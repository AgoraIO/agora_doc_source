# -*- coding: utf-8 -*-
"""
API注释自动化更新工具 - 主程序入口
"""

import click
import json
import sys
from pathlib import Path
from typing import Dict, Any, List

from .config.manager import ConfigManager
from .utils.logger import LogManager
from .utils.file_utils import ensure_directory_exists, get_html_files, classify_html_files
from .parsers.parser_factory import HTMLParserFactory
from .processors.comment_normalizer import CommentNormalizer
from loguru import logger


class APICommentUpdater:
    """API注释更新器主类"""
    
    def __init__(self, config_dir: str = "config"):
        """
        初始化更新器
        
        Args:
            config_dir: 配置文件目录
        """
        self.config_manager = ConfigManager(config_dir)
        self.log_manager = LogManager()
        self._setup_logging()
        
    def _setup_logging(self):
        """设置日志系统"""
        try:
            logging_config = self.config_manager.get_logging_config()
            self.log_manager.setup_logging(logging_config)
            logger.info("API注释更新工具启动")
        except Exception as e:
            # 如果配置加载失败，使用默认配置
            self.log_manager.setup_logging({
                'file_level': 'info',
                'console_level': 'info',
                'log_dir': './logs'
            })
            logger.warning("使用默认日志配置: {}", str(e))
    
    def extract_comments(self, platform: str, output_file: str = None) -> Dict[str, Any]:
        """
        从HTML文档中提取注释
        
        Args:
            platform: 平台名称 (cpp-ng, android-ng, ios-ng, mac-ng)
            output_file: 输出JSON文件路径，如果为None则使用默认路径
            
        Returns:
            Dict: 提取的注释数据
        """
        logger.info("开始提取 {} 平台的注释", platform)
        
        # 验证平台
        if not self.config_manager.validate_platform(platform):
            raise ValueError(f"不支持的平台: {platform}")
        
        # 加载平台配置
        platform_config = self.config_manager.load_platform_config(platform)
        html_source_path = self.config_manager.get_html_source_path(platform)
        
        # 构建HTML文件路径
        html_dir = Path(html_source_path)
        if not html_dir.is_absolute():
            # 相对路径，相对于配置文件目录的父目录
            config_dir = Path(self.config_manager.config_dir)
            html_dir = config_dir.parent / html_source_path
        
        if not html_dir.exists():
            raise FileNotFoundError(f"HTML源目录不存在: {html_dir}")
        
        # 获取HTML文件
        html_files = list(get_html_files(str(html_dir)))
        classified_files = classify_html_files(html_files)
        
        logger.info("找到HTML文件: toc={}, class={}, enum={}", 
                   len(classified_files['toc']), 
                   len(classified_files['class']), 
                   len(classified_files['enum']))
        
        # 提取数据
        result = {
            "platform": platform,
            "generated_at": self._get_timestamp(),
            "api": [],
            "class": [],
            "enum": []
        }
        
        # 处理各类型文件
        for file_type, files in classified_files.items():
            for html_file in files:
                try:
                    parser = HTMLParserFactory.create_parser(html_file, platform_config)
                    data = parser.parse_file(html_file)
                    
                    if file_type == "toc" and data.get("apis"):
                        result["api"].extend(data["apis"])
                    elif file_type == "class" and data.get("classes"):
                        result["class"].extend(data["classes"])
                    elif file_type == "enum" and data.get("enums"):
                        result["enum"].extend(data["enums"])
                        
                except Exception as e:
                    logger.error("解析文件失败 {}: {}", html_file, str(e))
                    continue
        
        logger.info("提取完成: api={}, class={}, enum={}", 
                   len(result["api"]), 
                   len(result["class"]), 
                   len(result["enum"]))
        
        # 应用注释格式化（行长度限制等）
        from .processors.comment_formatter import CommentFormatter
        formatter = CommentFormatter(max_line_length=100)
        result = formatter.format_extracted_data(result)
        logger.info("注释格式化完成")
        
        # 保存到文件
        if output_file is None:
            ensure_directory_exists("output")
            output_file = f"output/{platform}.json"
        
        self._save_json(result, output_file)
        logger.info("结果已保存到: {}", output_file)
        
        return result
    
    def inject_comments(self, platform: str, json_file: str):
        """
        将注释注入到代码仓库
        
        Args:
            platform: 平台名称
            json_file: JSON数据文件路径
        """
        logger.info("开始注入 {} 平台的注释", platform)
        
        # 验证平台
        if not self.config_manager.validate_platform(platform):
            raise ValueError(f"不支持的平台: {platform}")
        
        # 加载JSON数据
        if not Path(json_file).exists():
            raise FileNotFoundError(f"JSON文件不存在: {json_file}")
        
        with open(json_file, 'r', encoding='utf-8') as f:
            data = json.load(f)
        
        # 加载配置
        platform_config = self.config_manager.load_platform_config(platform)
        repo_config = self.config_manager.load_repo_config()
        
        # 创建注释注入器
        from .injectors.comment_injector import CommentInjector
        injector = CommentInjector(repo_config, platform_config)
        
        # 统计信息
        total_apis = len(data.get("api", []))
        total_classes = len(data.get("class", []))
        total_enums = len(data.get("enum", []))
        
        success_apis = 0
        success_classes = 0 
        success_enums = 0
        
        # 注入API注释
        logger.info("开始注入 {} 个API注释", total_apis)
        for api_data in data.get("api", []):
            try:
                if injector.inject_api_comment(api_data):
                    success_apis += 1
            except Exception as e:
                logger.error("注入API注释失败 {}: {}", api_data.get("name", "Unknown"), str(e))
                continue
        
        # 注入类注释
        logger.info("开始注入 {} 个类注释", total_classes)
        for class_data in data.get("class", []):
            try:
                if injector.inject_class_comment(class_data):
                    success_classes += 1
            except Exception as e:
                logger.error("注入类注释失败 {}: {}", class_data.get("name", "Unknown"), str(e))
                continue
        
        # 注入枚举注释
        logger.info("开始注入 {} 个枚举注释", total_enums)
        for enum_data in data.get("enum", []):
            try:
                if injector.inject_enum_comment(enum_data):
                    success_enums += 1
            except Exception as e:
                logger.error("注入枚举注释失败 {}: {}", enum_data.get("name", "Unknown"), str(e))
                continue
        
        logger.info("注释注入完成: API {}/{}, 类 {}/{}, 枚举 {}/{}", 
                   success_apis, total_apis,
                   success_classes, total_classes, 
                   success_enums, total_enums)
        
    def update_comments(self, platform: str):
        """
        完整的更新流程：提取 + 注入
        
        Args:
            platform: 平台名称，或 'all' 表示所有平台
        """
        if platform == "all":
            platforms = self.config_manager.get_supported_platforms()
            logger.info("处理所有平台: {}", platforms)
            
            for p in platforms:
                try:
                    logger.info("=== 处理平台: {} ===", p)
                    # 提取注释
                    ensure_directory_exists("output")
                    json_file = f"output/{p}.json"
                    self.extract_comments(p, json_file)
                    
                    # 注入注释
                    self.inject_comments(p, json_file)
                    
                except Exception as e:
                    logger.error("处理平台 {} 失败: {}", p, str(e))
                    continue
        else:
            logger.info("处理单个平台: {}", platform)
            # 提取注释
            ensure_directory_exists("output") 
            json_file = f"output/{platform}.json"
            self.extract_comments(platform, json_file)
            
            # 注入注释
            self.inject_comments(platform, json_file)
            
    def _get_timestamp(self) -> str:
        """获取当前时间戳"""
        from datetime import datetime
        return datetime.now().isoformat() + "Z"
    
    def _save_json(self, data: Dict[str, Any], file_path: str):
        """保存JSON数据到文件"""
        ensure_directory_exists(Path(file_path).parent)
        with open(file_path, 'w', encoding='utf-8') as f:
            json.dump(data, f, ensure_ascii=False, indent=2)


class TestAPICommentUpdater(APICommentUpdater):
    """测试模式的API注释更新器，使用测试配置"""
    
    def __init__(self, config_dir: str = "config"):
        """
        初始化测试更新器
        
        Args:
            config_dir: 配置文件目录
        """
        # 创建测试配置管理器
        self.config_manager = TestConfigManager(config_dir)
        self.log_manager = LogManager()
        self._setup_logging()


class TestConfigManager(ConfigManager):
    """测试配置管理器，优先使用test_config.yml"""
    
    def load_repo_config(self) -> Dict[str, Any]:
        """加载仓库配置，优先使用测试配置"""
        test_config_path = Path(self.config_dir) / "test_config.yml"
        
        if test_config_path.exists():
            logger.debug("使用测试配置文件: {}", test_config_path)
            
            import yaml
            with open(test_config_path, 'r', encoding='utf-8') as f:
                config = yaml.safe_load(f)
            
            # 验证配置
            from .config.schemas import REPO_CONFIG_SCHEMA
            from jsonschema import validate
            validate(config, REPO_CONFIG_SCHEMA)
            logger.info("测试配置文件验证通过")
            
            self._repo_config = config
            return config
        else:
            # 回退到默认配置
            logger.debug("测试配置不存在，使用默认配置")
            return super().load_repo_config()


@click.group()
@click.option('--config-dir', default="config", help="配置文件目录")
@click.pass_context
def main(ctx, config_dir):
    """API注释自动化更新工具"""
    ctx.ensure_object(dict)
    ctx.obj['config_dir'] = config_dir


@main.command()
@click.option('--config-dir', default="config", help="配置文件目录")
def init(config_dir):
    """初始化配置文件"""
    config_path = Path(config_dir)
    config_path.mkdir(parents=True, exist_ok=True)
    
    click.echo(f"配置目录已创建: {config_path.absolute()}")
    click.echo("请编辑配置文件后再运行其他命令")


@main.command()
@click.option('--platform', required=True, help="平台名称 (cpp-ng, android-ng, ios-ng, mac-ng)")
@click.option('--output', help="输出JSON文件路径")
@click.pass_context
def extract(ctx, platform, output):
    """从HTML文档中提取注释"""
    try:
        updater = APICommentUpdater(ctx.obj['config_dir'])
        result = updater.extract_comments(platform, output)
        
        click.echo(f"提取完成")
        click.echo(f"API: {len(result['api'])}")
        click.echo(f"🏗️  Class: {len(result['class'])}")
        click.echo(f"📊 Enum: {len(result['enum'])}")
        
    except Exception as e:
        click.echo(f"❌ 提取失败: {e}", err=True)
        sys.exit(1)


@main.command()
@click.option('--platform', required=True, help="平台名称")
@click.option('--json-file', required=True, help="JSON数据文件路径")
@click.pass_context
def inject(ctx, platform, json_file):
    """将注释注入到代码仓库"""
    try:
        updater = APICommentUpdater(ctx.obj['config_dir'])
        updater.inject_comments(platform, json_file)
        click.echo("✅ 注入完成")
        
    except Exception as e:
        click.echo(f"❌ 注入失败: {e}", err=True)
        sys.exit(1)


@main.command()
@click.option('--platform', required=True, help="平台名称，或 'all' 表示所有平台")
@click.pass_context
def update(ctx, platform):
    """完整的更新流程：提取 + 注入"""
    try:
        updater = APICommentUpdater(ctx.obj['config_dir'])
        updater.update_comments(platform)
        click.echo("更新完成")
        
    except Exception as e:
        click.echo(f"❌ 更新失败: {e}", err=True)
        sys.exit(1)


@main.command()
@click.option('--platform', default="cpp-ng", help="测试平台名称")
@click.option('--json-file', help="指定JSON文件路径，如果不指定则使用默认测试JSON")
@click.option('--action', type=click.Choice(['extract', 'inject', 'update']), default='update', help="测试操作类型")
def test(platform, json_file, action):
    """测试模式：使用测试配置和测试文件进行调试"""
    try:
        # 使用测试配置目录
        test_config_dir = "config"
        
        # 检查测试配置文件是否存在
        test_config_path = Path(test_config_dir) / "test_config.yml"
        if not test_config_path.exists():
            click.echo(f"❌ 测试配置文件不存在: {test_config_path}", err=True)
            click.echo("请确保 config/test_config.yml 文件存在", err=True)
            sys.exit(1)
        
        # 检查测试源代码目录是否存在
        test_src_dir = Path("tests/src")
        if not test_src_dir.exists():
            click.echo(f"❌ 测试源代码目录不存在: {test_src_dir}", err=True)
            click.echo("请确保 tests/src/ 目录存在并包含测试文件", err=True)
            sys.exit(1)
        
        click.echo("启动测试模式")
        click.echo(f"配置目录: {test_config_dir}")
        click.echo(f"测试源码: {test_src_dir}")
        click.echo(f"平台: {platform}")
        click.echo(f"操作: {action}")
        
        # 创建测试更新器，使用特殊的测试配置管理器
        updater = TestAPICommentUpdater(test_config_dir)
        
        if action == 'extract':
            # 只提取注释
            ensure_directory_exists("output")
            output_file = f"output/{platform}-test.json"
            result = updater.extract_comments(platform, output_file)
            
            click.echo(f"提取完成")
            click.echo(f"API: {len(result['api'])}")
            click.echo(f"🏗️  Class: {len(result['class'])}")
            click.echo(f"📊 Enum: {len(result['enum'])}")
            click.echo(f"💾 输出文件: {output_file}")
            
        elif action == 'inject':
            # 只注入注释
            if json_file is None:
                json_file = f"output/{platform}-test.json"
            
            if not Path(json_file).exists():
                click.echo(f"❌ JSON文件不存在: {json_file}", err=True)
                click.echo("请先运行 extract 操作或指定有效的JSON文件", err=True)
                sys.exit(1)
            
            updater.inject_comments(platform, json_file)
            click.echo("注入完成")
            
        elif action == 'update':
            # 完整流程
            ensure_directory_exists("output")
            json_file = f"output/{platform}-test.json"
            
            # 提取
            result = updater.extract_comments(platform, json_file)
            click.echo(f"提取完成: API {len(result['api'])}, Class {len(result['class'])}, Enum {len(result['enum'])}")
            
            # 注入
            updater.inject_comments(platform, json_file)
            click.echo("注入完成")
            
            click.echo("测试更新完成")
        
        # 显示测试文件状态
        click.echo("\n测试文件状态:")
        for test_file in test_src_dir.glob("*.h"):
            click.echo(f"   {test_file.name}")
        
    except Exception as e:
        click.echo(f"❌ 测试失败: {e}", err=True)
        import traceback
        traceback.print_exc()
        sys.exit(1)


if __name__ == "__main__":
    main()
