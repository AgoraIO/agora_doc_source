"""CLI 入口模块"""

import argparse
import json
import sys
import time
from pathlib import Path
from typing import Any, Dict, List

from loguru import logger

from .config import PLATFORM_CONFIGS, PlatformConfig
from .dita_parser import DitaParser
from .json_builder import JsonBuilder
from .keymap_parser import KeymapParser
from .logger import log_statistics, setup_logger
from .models import ExtractionStats
from .scope_resolver import ScopeResolver
from .validator import Validator


def parse_args() -> argparse.Namespace:
    """解析命令行参数"""
    parser = argparse.ArgumentParser(
        description="DITA to JSON Extractor - 将 DITA 文档提取为结构化 JSON",
        formatter_class=argparse.RawDescriptionHelpFormatter,
    )
    
    parser.add_argument(
        "--platforms",
        nargs="+",
        choices=list(PLATFORM_CONFIGS.keys()) + ["all"],
        default=["all"],
        help="要提取的平台，可指定多个，默认为 all",
    )
    
    parser.add_argument(
        "--base-dir",
        type=Path,
        default=Path("dita/RTC-NG"),
        help="DITA 文件根目录，默认为 dita/RTC-NG",
    )
    
    parser.add_argument(
        "--output",
        type=Path,
        default=Path("output.json"),
        help="输出文件路径，默认为 output.json",
    )
    
    parser.add_argument(
        "--name-groups",
        type=Path,
        default=None,
        help="name_groups.json 文件路径，默认为 scripts/dita-to-json/name_groups.json",
    )
    
    parser.add_argument(
        "--log-dir",
        type=Path,
        default=None,
        help="日志目录，默认为 scripts/dita-to-json/logs",
    )
    
    parser.add_argument(
        "--skip-validation",
        action="store_true",
        help="跳过数据验证",
    )
    
    return parser.parse_args()


def get_platforms(platform_args: List[str]) -> List[str]:
    """获取要处理的平台列表"""
    if "all" in platform_args:
        return list(PLATFORM_CONFIGS.keys())
    return platform_args


def extract_platform(
    platform: str,
    base_dir: Path,
    json_builder: JsonBuilder,
) -> tuple[Dict[str, Any], ExtractionStats]:
    """提取单个平台的数据
    
    Args:
        platform: 平台名称
        base_dir: DITA 文件根目录
        json_builder: JSON 构建器
        
    Returns:
        (平台输出数据, 统计信息)
    """
    platform_config = PLATFORM_CONFIGS[platform]
    logger.info(f"开始提取平台: {platform}")
    
    # 1. 解析 keymap
    keymap_parser = KeymapParser(base_dir, platform_config)
    
    # 2. 解析 scope
    scope_resolver = ScopeResolver(base_dir, platform_config)
    scope = scope_resolver.resolve()
    
    # 3. 创建 DITA 解析器
    dita_parser = DitaParser(base_dir, platform_config, keymap_parser)
    
    # 4. 提取数据
    api_items: List[Dict[str, Any]] = []
    struct_items: List[Dict[str, Any]] = []
    enum_items: List[Dict[str, Any]] = []
    
    # 提取接口类（作为 struct，is_interface=True）
    for key in scope.interface_keys:
        try:
            parsed = dita_parser.parse_struct(key, is_interface=True)
            if parsed:
                item = json_builder.build_struct_item(key, parsed, platform)
                struct_items.append(item)
                logger.debug(f"提取接口类: {key}")
        except Exception as e:
            logger.warning(f"提取接口类失败: {key}, 错误: {e}")
    
    # 提取 API/Callback
    for key in scope.api_keys:
        try:
            parsed = dita_parser.parse_api(key)
            if parsed:
                item = json_builder.build_api_item(key, parsed, platform)
                api_items.append(item)
                logger.debug(f"提取 API: {key}")
        except Exception as e:
            logger.warning(f"提取 API 失败: {key}, 错误: {e}")
    
    # 提取普通类
    for key in scope.class_keys:
        try:
            parsed = dita_parser.parse_struct(key, is_interface=False)
            if parsed:
                item = json_builder.build_struct_item(key, parsed, platform)
                struct_items.append(item)
                logger.debug(f"提取类: {key}")
        except Exception as e:
            logger.warning(f"提取类失败: {key}, 错误: {e}")
    
    # 提取枚举
    for key in scope.enum_keys:
        try:
            parsed = dita_parser.parse_enum(key)
            if parsed:
                item = json_builder.build_enum_item(key, parsed, platform)
                enum_items.append(item)
                logger.debug(f"提取枚举: {key}")
        except Exception as e:
            logger.warning(f"提取枚举失败: {key}, 错误: {e}")
    
    # 构建平台输出
    platform_output = json_builder.build_platform_output(
        platform, api_items, struct_items, enum_items
    )
    
    # 统计
    stats = json_builder.count_stats(api_items, struct_items, enum_items)
    
    logger.info(
        f"平台 {platform} 提取完成: "
        f"API {stats.api_count}, Callback {stats.callback_count}, "
        f"Struct {stats.struct_count}, Enum {stats.enum_count}"
    )
    
    return platform_output, stats


def main() -> int:
    """主函数"""
    args = parse_args()
    
    # 确定路径
    script_dir = Path(__file__).parent.parent.parent
    log_dir = args.log_dir or (script_dir / "logs")
    name_groups_path = args.name_groups or (script_dir / "name_groups.json")
    
    # 初始化日志
    setup_logger(log_dir)
    
    start_time = time.time()
    logger.info("=" * 50)
    logger.info("DITA to JSON Extractor 开始运行")
    logger.info(f"DITA 根目录: {args.base_dir}")
    logger.info(f"输出文件: {args.output}")
    
    # 获取平台列表
    platforms = get_platforms(args.platforms)
    logger.info(f"目标平台: {', '.join(platforms)}")
    
    # 创建 JSON 构建器
    json_builder = JsonBuilder(name_groups_path)
    
    # 提取所有平台
    all_outputs: List[Dict[str, Any]] = []
    total_stats = ExtractionStats()
    
    for platform in platforms:
        try:
            output, stats = extract_platform(platform, args.base_dir, json_builder)
            all_outputs.append(output)
            
            # 累加统计
            total_stats.api_count += stats.api_count
            total_stats.callback_count += stats.callback_count
            total_stats.struct_count += stats.struct_count
            total_stats.enum_count += stats.enum_count
        except Exception as e:
            logger.error(f"提取平台 {platform} 失败: {e}")
            total_stats.error_count += 1
    
    # 验证数据
    if not args.skip_validation:
        validator = Validator()
        result = validator.validate(all_outputs)
        total_stats.error_count += len(result.errors)
    
    # 输出 JSON
    try:
        args.output.parent.mkdir(parents=True, exist_ok=True)
        with open(args.output, "w", encoding="utf-8") as f:
            json.dump(all_outputs, f, ensure_ascii=False, indent=2)
        logger.info(f"JSON 输出完成: {args.output}")
    except Exception as e:
        logger.error(f"输出 JSON 失败: {e}")
        return 1
    
    # 输出统计
    elapsed = time.time() - start_time
    log_statistics(
        elapsed=elapsed,
        platform_count=len(platforms),
        api_count=total_stats.api_count,
        callback_count=total_stats.callback_count,
        struct_count=total_stats.struct_count,
        enum_count=total_stats.enum_count,
        error_count=total_stats.error_count,
    )
    
    return 0 if total_stats.error_count == 0 else 1


if __name__ == "__main__":
    sys.exit(main())

