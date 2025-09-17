# -*- coding: utf-8 -*-
"""
Java平台特定的注释注入器
"""

import re
from typing import Dict, List, Any, Optional
from loguru import logger

from ...utils.file_utils import read_file_content, write_file_content
from ...processors.comment_normalizer import CommentNormalizer
from .base import BaseInjector


class JavaInjector(BaseInjector):
    """Java注释注入器"""
    
    def __init__(self, repo_config: Dict[str, Any], platform_config: Dict[str, Any]):
        """
        初始化Java注释注入器
        
        Args:
            repo_config: 代码仓库配置
            platform_config: 平台配置
        """
        super().__init__(repo_config, platform_config)
        
        # 初始化Java特定的组件
        from .java_locator import JavaLocator
        self.code_locator = JavaLocator(repo_config, platform_config)
        self.comment_normalizer = CommentNormalizer(platform_config)
        
        # 初始化注释格式化器
        from ...processors.comment_formatter import CommentFormatter
        self.comment_formatter = CommentFormatter()
    
    def inject_api_comment(self, api_data: Dict[str, Any]) -> bool:
        """
        注入API注释 - Java版本
        
        Args:
            api_data: API数据
            
        Returns:
            bool: 是否成功注入
        """
        api_name = api_data.get("name", "")
        logger.debug("开始注入API注释: {}", api_name)
        
        # 定位API在代码中的位置
        location = self.code_locator.locate_api(api_data)
        if not location:
            logger.warning("未能定位API {}, 跳过注入", api_name)
            return False
        
        file_path, line_number = location
        
        # 标准化注释
        new_comment_lines = self.comment_normalizer.normalize_api_comment(api_data)
        if not new_comment_lines:
            logger.warning("API {} 没有有效注释，跳过注入", api_name)
            return False
        
        # 注入注释
        success = self._inject_comment_at_location(
            file_path, line_number, new_comment_lines, api_name
        )
        
        if success:
            logger.info("成功注入API注释: {} -> {}:{}", api_name, file_path, line_number)
        else:
            logger.error("注入API注释失败: {}", api_name)
        
        return success
    
    def inject_class_comment(self, class_data: Dict[str, Any]) -> bool:
        """
        批量注入类注释 - Java版本（一次性处理所有注释，避免多次文件写入）
        
        Args:
            class_data: 类数据
            
        Returns:
            bool: 是否成功注入
        """
        class_name = class_data.get("name", "")
        logger.debug("开始批量注入类注释: {}", class_name)
        
        # 定位类在代码中的位置
        location = self.code_locator.locate_class(class_data)
        if not location:
            logger.warning("未能定位类 {}, 跳过注入", class_name)
            return False
        
        file_path, line_number = location
        
        # 标准化类注释
        normalized_data = self.comment_normalizer.normalize_class_comment(class_data)
        
        # 分离处理：先处理类注释，再处理属性注释
        success_count = 0
        total_count = 0
        
        # 1. 注入类描述注释
        class_comments = [item for item in normalized_data if item.get("type") == "desc"]
        if class_comments:
            class_comment_lines = class_comments[0].get("comment", [])
            if class_comment_lines:
                total_count += 1
                if self._inject_comment_at_location(file_path, line_number, class_comment_lines, f"{class_name} (class)"):
                    success_count += 1
                    logger.info("成功注入类注释: {}", class_name)
        
        # 2. 批量注入属性注释
        attribute_comments = [item for item in normalized_data if item.get("type") == "attribute"]
        for attr_comment in attribute_comments:
            attr_name = attr_comment.get("value", "")
            attr_comment_lines = attr_comment.get("comment", [])
            
            if attr_name and attr_comment_lines:
                total_count += 1
                # 定位属性
                attr_location = self.code_locator.locate_class_attribute(class_data, attr_name)
                if attr_location:
                    attr_file_path, attr_line_number = attr_location
                    if self._inject_comment_at_location(attr_file_path, attr_line_number, attr_comment_lines, f"{class_name}.{attr_name}"):
                        success_count += 1
                        logger.info("成功注入属性注释: {}.{}", class_name, attr_name)
                else:
                    logger.warning("未能定位属性: {}.{}", class_name, attr_name)
        
        logger.info("类注释注入完成: {} ({}/{})", class_name, success_count, total_count)
        return success_count > 0
    
    def inject_enum_comment(self, enum_data: Dict[str, Any]) -> bool:
        """
        注入枚举注释 - Java版本
        
        Args:
            enum_data: 枚举数据
            
        Returns:
            bool: 是否成功注入
        """
        enum_name = enum_data.get("name", "")
        logger.debug("开始注入枚举注释: {}", enum_name)
        
        # 定位枚举在代码中的位置
        location = self.code_locator.locate_enum(enum_data)
        if not location:
            logger.warning("未能定位枚举 {}, 跳过注入", enum_name)
            return False
        
        file_path, line_number = location
        
        # 标准化枚举注释
        normalized_data = self.comment_normalizer.normalize_enum_comment(enum_data)
        
        success_count = 0
        total_count = 0
        
        # 1. 注入枚举描述注释
        enum_comments = [item for item in normalized_data if item.get("type") == "desc"]
        if enum_comments:
            enum_comment_lines = enum_comments[0].get("comment", [])
            if enum_comment_lines:
                total_count += 1
                if self._inject_comment_at_location(file_path, line_number, enum_comment_lines, f"{enum_name} (enum)"):
                    success_count += 1
                    logger.info("成功注入枚举注释: {}", enum_name)
        
        # 2. 批量注入枚举值注释
        enumerator_comments = [item for item in normalized_data if item.get("type") == "enumerator"]
        for enum_comment in enumerator_comments:
            enum_value_name = enum_comment.get("value", "")
            enum_comment_lines = enum_comment.get("comment", [])
            
            if enum_value_name and enum_comment_lines:
                total_count += 1
                # 定位枚举值
                value_location = self.code_locator.locate_enum_value(enum_data, enum_value_name)
                if value_location:
                    value_file_path, value_line_number = value_location
                    if self._inject_comment_at_location(value_file_path, value_line_number, enum_comment_lines, f"{enum_name}.{enum_value_name}"):
                        success_count += 1
                        logger.info("成功注入枚举值注释: {}.{}", enum_name, enum_value_name)
                else:
                    logger.warning("未能定位枚举值: {}.{}", enum_name, enum_value_name)
        
        logger.info("枚举注释注入完成: {} ({}/{})", enum_name, success_count, total_count)
        return success_count > 0
    
    # ==================== Java特定的注释处理逻辑 ====================
    
    def _find_existing_comment_start(self, lines: List[str], target_line: int) -> Optional[int]:
        """
        查找目标行前的现有注释块的开始位置（Java增强版，支持跳过注解）
        
        Args:
            lines: 文件行列表
            target_line: 目标行索引(0-based)
            
        Returns:
            Optional[int]: 注释开始行索引，如果没有找到返回None
        """
        if target_line <= 0 or target_line >= len(lines):
            return None
        
        current_line = target_line - 1
        skip_count = 0  # 跟踪跳过的行数，防止过度搜索
        
        while current_line >= 0 and skip_count < 10:  # 最多向上搜索10行
            line_content = lines[current_line].strip()
            
            # 跳过空行
            if not line_content:
                current_line -= 1
                skip_count += 1
                continue
            
            # 跳过Java注解（重要：Java特有处理）
            if self._is_java_annotation(line_content):
                current_line -= 1
                skip_count += 1
                continue
            
            # 检查是否为注释行
            if line_content.endswith('*/'):
                # 找到注释结束，向上查找注释开始
                comment_end = current_line
                while current_line >= 0:
                    line_content = lines[current_line].strip()
                    if line_content.startswith('/**') or line_content.startswith('/*'):
                        logger.debug("找到现有注释块: 行 {} 到 {}", current_line + 1, comment_end + 1)
                        return current_line
                    current_line -= 1
                return None
            
            # 检查是否为单行注释
            if line_content.startswith('//'):
                # 单行注释，继续向上查找连续的单行注释
                comment_start = current_line
                while current_line >= 0:
                    line_content = lines[current_line].strip()
                    if not line_content.startswith('//'):
                        break
                    comment_start = current_line
                    current_line -= 1
                logger.debug("找到现有单行注释块: 行 {} 开始", comment_start + 1)
                return comment_start
            
            # 如果遇到非注释行，停止搜索
            break
        
        return None
    
    def _is_java_annotation(self, line: str) -> bool:
        """
        判断是否为Java注解（Java特有方法）
        
        Args:
            line: 代码行（已strip）
            
        Returns:
            bool: 是否为Java注解
        """
        if not line:
            return False
        
        # Java注解模式
        java_annotations = [
            '@CalledByNative', '@Override', '@Deprecated', '@SuppressWarnings',
            '@NonNull', '@Nullable', '@VisibleForTesting', '@RestrictTo',
            '@TargetApi', '@RequiresApi', '@IntDef', '@StringDef'
        ]
        
        # 检查是否以@开头（通用注解模式）
        if line.startswith('@'):
            return True
        
        # 检查特定的Java注解
        for annotation in java_annotations:
            if line.startswith(annotation):
                return True
        
        return False
    
    def _find_comment_end(self, lines: List[str], start_line: int) -> Optional[int]:
        """
        查找Java注释的结束位置（增强版）
        
        Args:
            lines: 文件行列表
            start_line: 注释开始行索引
            
        Returns:
            Optional[int]: 注释结束行索引，如果没有找到返回None
        """
        if start_line < 0 or start_line >= len(lines):
            return None
        
        start_line_content = lines[start_line].strip()
        
        # 处理单行注释
        if start_line_content.startswith('//'):
            current_line = start_line
            # 查找连续的单行注释
            while current_line < len(lines):
                line_content = lines[current_line].strip()
                if not line_content.startswith('//') and line_content:
                    # 遇到非单行注释的非空行，返回前一行
                    return current_line - 1
                elif not line_content:
                    # 遇到空行，检查下一行
                    next_line_idx = current_line + 1
                    if (next_line_idx < len(lines) and 
                        lines[next_line_idx].strip() and 
                        not lines[next_line_idx].strip().startswith('//')):
                        return current_line - 1
                current_line += 1
            return current_line - 1
        
        # 处理多行注释
        elif start_line_content.startswith('/**') or start_line_content.startswith('/*'):
            # 查找注释结束标记 */
            for i in range(start_line, len(lines)):
                line = lines[i].strip()
                if line.endswith('*/'):
                    logger.debug("找到注释结束: 行 {}", i + 1)
                    return i
                # 检查是否为注释行，如果不是可能表示注释格式有问题
                elif i > start_line and not self._is_comment_line(line):
                    logger.warning("注释格式可能有问题，在行 {} 找到非注释内容: {}", i + 1, line)
                    # 继续搜索，可能是注释内容
            
            # 如果没找到结束标记，返回None
            logger.warning("未找到注释结束标记")
            return None
        
        return None
    
    def _is_comment_line(self, line: str) -> bool:
        """
        判断是否为Java注释行（包括多行注释中的各种格式）
        
        Args:
            line: 已经strip()的代码行
            
        Returns:
            bool: 是否为注释行
        """
        if not line:
            return True  # 空行在注释块中是允许的
        
        # 标准注释行格式
        if line.startswith('*') or line.startswith('//'):
            return True
        
        # 注释开始和结束
        if line.startswith('/**') or line.startswith('/*') or line == '*/':
            return True
        
        # 检查特殊的注释内容模式
        comment_prefixes = ['@', '-', '+']  # 常见的注释内容前缀
        stripped_line = line.lstrip()
        for prefix in comment_prefixes:
            if stripped_line.startswith(prefix):
                return True
        
        # 检查是否为明确的Java代码行（包含代码关键字或符号）
        code_indicators = [
            'class ', 'interface ', 'enum ', 'package ',
            'public ', 'private ', 'protected ', 'static ',
            'final ', 'abstract ', 'synchronized ',
            'import ', 'extends ', 'implements ',
            ');', '};', '{', '}', '=',
            'return ', 'if (', 'for (', 'while (', 'switch ('
        ]
        
        for indicator in code_indicators:
            if indicator in line:
                return False
        
        # 检查Java注解（注解不是注释）
        if self._is_java_annotation(line):
            return False
        
        # 如果不包含明确的代码指示符，可能是注释的延续行
        return True
    
    def _inject_comment_at_location(self, file_path: str, line_number: int, 
                                   comment_lines: List[str], element_name: str) -> bool:
        """
        在指定位置注入注释（Java版本）
        
        Args:
            file_path: 文件路径
            line_number: 目标行号（1-based）
            comment_lines: 注释行列表
            element_name: 元素名称（用于日志）
            
        Returns:
            bool: 是否成功注入
        """
        try:
            # 读取文件内容
            content = read_file_content(file_path)
            if content is None:
                logger.error("无法读取文件: {}", file_path)
                return False
            
            lines = content.split('\n')
            target_index = line_number - 1  # 转换为0-based索引
            
            if target_index < 0 or target_index >= len(lines):
                logger.error("行号超出范围: {} (文件共{}行)", line_number, len(lines))
                return False
            
            # 查找并删除现有注释
            existing_comment_start = self._find_existing_comment_start(lines, target_index)
            if existing_comment_start is not None:
                existing_comment_end = self._find_comment_end(lines, existing_comment_start)
                if existing_comment_end is not None:
                    # 删除现有注释
                    logger.debug("删除现有注释: 行 {} 到 {}", existing_comment_start + 1, existing_comment_end + 1)
                    del lines[existing_comment_start:existing_comment_end + 1]
                    # 调整目标位置
                    target_index = existing_comment_start
            
            # 保留现有信息并插入新注释
            preserved_comment = self._preserve_existing_info("", comment_lines)
            
            # 在目标位置插入注释
            for i, comment_line in enumerate(preserved_comment):
                lines.insert(target_index + i, comment_line)
            
            # 写回文件
            new_content = '\n'.join(lines)
            success = write_file_content(file_path, new_content)
            
            if success:
                logger.debug("成功注入注释到 {}:{} ({})", file_path, line_number, element_name)
            else:
                logger.error("写入文件失败: {}", file_path)
            
            return success
            
        except Exception as e:
            logger.error("注入注释时发生错误 {}:{} - {}", file_path, line_number, str(e))
            return False
    
    def _preserve_existing_info(self, existing_content: str, new_comment: List[str]) -> List[str]:
        """
        保留现有代码中的特殊标记（Java版本）
        
        Args:
            existing_content: 现有文件内容
            new_comment: 新注释行
            
        Returns:
            List[str]: 合并后的注释行
        """
        # 查找并提取现有的@technical preview、@since、@deprecated信息
        existing_comment = self._extract_existing_comment(existing_content)
        if existing_comment:
            return self.comment_normalizer.preserve_existing_info(existing_comment, new_comment)
        
        return new_comment
    
    def _extract_existing_comment(self, content: str) -> str:
        """
        从文件内容中提取现有的注释（Java版本）
        
        Args:
            content: 文件内容
            
        Returns:
            str: 现有注释内容
        """
        # 使用正则表达式提取 /** ... */ 格式的注释
        import re
        
        comment_pattern = r'/\*\*(.*?)\*/'
        match = re.search(comment_pattern, content, re.DOTALL)
        if match:
            return match.group(1)
        
        # 如果没有找到多行注释，查找连续的单行注释
        single_line_pattern = r'((?:^\s*//.*\n?)+)'
        match = re.search(single_line_pattern, content, re.MULTILINE)
        if match:
            return match.group(1)
        
        return ""
    
    def _extract_preserved_info(self, existing_comment: str) -> Dict[str, str]:
        """
        从现有注释中提取需要保留的信息（Java版本）
        
        Args:
            existing_comment: 现有注释内容
            
        Returns:
            Dict[str, str]: 提取的信息
        """
        preserved_info = {}
        
        if not existing_comment:
            return preserved_info
        
        # 提取technical preview信息
        technical_preview_pattern = r'@technical\s+preview'
        if re.search(technical_preview_pattern, existing_comment, re.IGNORECASE):
            preserved_info['technical_preview'] = '@technical preview'
        
        # 提取since信息
        since_pattern = r'@since\s+(v?[\d\.]+.*?)(?:\n|\*|$)'
        since_match = re.search(since_pattern, existing_comment, re.IGNORECASE)
        if since_match:
            preserved_info['since'] = f'@since {since_match.group(1).strip()}'
        
        # 提取deprecated信息（Java特有格式）
        deprecated_patterns = [
            r'@deprecated\s+(.*?)(?:\n|\*|$)',
            r'@Deprecated.*?(?:\n|$)'  # Java注解形式
        ]
        
        for pattern in deprecated_patterns:
            deprecated_match = re.search(pattern, existing_comment, re.IGNORECASE | re.DOTALL)
            if deprecated_match:
                if 'deprecated' not in preserved_info:  # 避免重复
                    deprecated_text = deprecated_match.group(1).strip() if deprecated_match.lastindex else '@deprecated'
                    preserved_info['deprecated'] = f'@deprecated {deprecated_text}' if deprecated_text != '@deprecated' else '@deprecated'
                break
        
        return preserved_info
