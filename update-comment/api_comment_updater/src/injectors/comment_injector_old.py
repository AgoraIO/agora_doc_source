# -*- coding: utf-8 -*-
"""
注释注入器
将标准化的注释注入到代码文件中
"""

import re
from pathlib import Path
from typing import Dict, List, Any, Optional, Tuple
from loguru import logger

from ..utils.file_utils import read_file_content, write_file_content
from ..processors.comment_normalizer import CommentNormalizer
from .code_locator import CodeLocator


class CommentInjector:
    """注释注入器，负责将注释注入到代码文件中"""
    
    def __init__(self, repo_config: Dict[str, Any], platform_config: Dict[str, Any]):
        """
        初始化注释注入器
        
        Args:
            repo_config: 代码仓库配置
            platform_config: 平台配置
        """
        self.repo_config = repo_config
        self.platform_config = platform_config
        self.code_locator = CodeLocator(repo_config, platform_config)
        self.comment_normalizer = CommentNormalizer(platform_config)
        
        # 初始化注释格式化器（批量注入需要）
        from ..processors.comment_formatter import CommentFormatter
        self.comment_formatter = CommentFormatter()
        
        logger.debug("初始化注释注入器: 平台={}", platform_config.get("platform"))
    
    def inject_api_comment(self, api_data: Dict[str, Any]) -> bool:
        """
        注入API注释
        
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
        批量注入类注释（一次性处理所有注释，避免多次文件写入）
        
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
        success = True
        
        # 第一步：处理类描述注释
        class_comment_injected = False
        for comment_item in normalized_data.get("comments", []):
            comment_type = comment_item.get("type")
            comment_lines = comment_item.get("comment", [])
            
            if comment_type == "class_description" and comment_lines:
                success = self._inject_comment_at_location(
                    file_path, line_number, comment_lines, class_name
                )
                if success:
                    class_comment_injected = True
                    logger.debug("成功注入类描述注释: {}", class_name)
                else:
                    logger.error("注入类描述注释失败: {}", class_name)
                    return False
                break
        
        # 第二步：处理属性注释
        if class_comment_injected:
            # 重新读取文件以获取更新后的内容
            from ..utils.file_utils import read_file_content
            updated_content = read_file_content(file_path)
            
            
            # 重新定位类和属性
            updated_class_location = self.code_locator.locate_class(class_data)
            if updated_class_location:
                for comment_item in normalized_data.get("comments", []):
                    comment_type = comment_item.get("type")
                    comment_lines = comment_item.get("comment", [])
                    
                    if comment_type == "attribute" and comment_lines:
                        attribute_name = comment_item.get("target", "") or comment_item.get("value", "")
                        if attribute_name:
                            attr_location = self.code_locator.locate_class_attribute(class_data, attribute_name)
                            if attr_location:
                                attr_file, attr_line = attr_location
                                attr_success = self._inject_comment_at_location(
                                    attr_file, attr_line, comment_lines, f"{class_name}.{attribute_name}"
                                )
                                if not attr_success:
                                    logger.error("注入属性注释失败: {}.{}", class_name, attribute_name)
                                    success = False
                            else:
                                logger.warning("未能定位类属性 {}.{}", class_name, attribute_name)
                                success = False
        
        if success:
            logger.info("成功批量注入类注释: {}", class_name)
        else:
            logger.error("批量注入类注释失败: {}", class_name)
        
        return success
    
    def inject_enum_comment(self, enum_data: Dict[str, Any]) -> bool:
        """
        注入枚举注释（采用分离处理策略，避免位置错位）
        
        Args:
            enum_data: 枚举数据
            
        Returns:
            bool: 是否成功注入
        """
        enum_name = enum_data.get("name", "")
        logger.debug("开始批量注入枚举注释: {}", enum_name)
        
        # 定位枚举在代码中的位置
        location = self.code_locator.locate_enum(enum_data)
        if not location:
            logger.warning("未能定位枚举 {}, 跳过注入", enum_name)
            return False
        
        file_path, line_number = location
        
        # 标准化枚举注释
        normalized_data = self.comment_normalizer.normalize_enum_comment(enum_data)
        success = True
        
        # 第一步：处理枚举描述注释
        enum_comment_injected = False
        for comment_item in normalized_data.get("comments", []):
            comment_type = comment_item.get("type")
            comment_lines = comment_item.get("comment", [])
            
            if comment_type == "enum_description" and comment_lines:
                success = self._inject_comment_at_location(
                    file_path, line_number, comment_lines, enum_name
                )
                if success:
                    enum_comment_injected = True
                    logger.debug("成功注入枚举描述注释: {}", enum_name)
                else:
                    logger.error("注入枚举描述注释失败: {}", enum_name)
                    return False
                break
        
        # 第二步：处理枚举值注释
        if enum_comment_injected:
            # 重新读取文件以获取更新后的内容
            # Note: code_locator会自动读取最新的文件内容
            
            
            # 重新定位枚举和枚举值
            updated_enum_location = self.code_locator.locate_enum(enum_data)
            if updated_enum_location:
                for comment_item in normalized_data.get("comments", []):
                    comment_type = comment_item.get("type")
                    comment_lines = comment_item.get("comment", [])
                    
                    if comment_type == "enumerator" and comment_lines:
                        value_name = comment_item.get("target", "") or comment_item.get("value", "")
                        if value_name:
                            value_location = self.code_locator.locate_enum_value(enum_data, value_name)
                            if value_location:
                                value_file, value_line = value_location
                                value_success = self._inject_comment_at_location(
                                    value_file, value_line, comment_lines, f"{enum_name}.{value_name}"
                                )
                                if not value_success:
                                    logger.error("注入枚举值注释失败: {}.{}", enum_name, value_name)
                                    success = False
                            else:
                                logger.warning("未能定位枚举值 {}.{}", enum_name, value_name)
                                success = False
            else:
                logger.error("重新定位枚举失败: {}", enum_name)
                success = False
        
        if success:
            logger.info("成功批量注入枚举注释: {}", enum_name)
        else:
            logger.error("批量注入枚举注释失败: {}", enum_name)
        
        return success
    
    def _batch_inject_by_file(self, injection_tasks: List[Dict], context_name: str) -> bool:
        """
        按文件分组批量注入注释，避免多次文件写入
        
        Args:
            injection_tasks: 注入任务列表
            context_name: 上下文名称（用于日志）
            
        Returns:
            bool: 是否成功注入
        """
        if not injection_tasks:
            return True
        
        # 按文件分组
        files_to_process = {}
        for task in injection_tasks:
            file_path = task['file_path']
            if file_path not in files_to_process:
                files_to_process[file_path] = []
            files_to_process[file_path].append(task)
        
        logger.debug("批量注入 {} 的注释，涉及 {} 个文件", context_name, len(files_to_process))
        
        # 逐个文件处理
        overall_success = True
        for file_path, tasks in files_to_process.items():
            try:
                # 读取文件内容
                from ..utils.file_utils import read_file_content, write_file_content
                content = read_file_content(file_path)
                lines = content.split('\n')
                
                # 按行号排序（从大到小，避免插入时行号偏移）
                tasks.sort(key=lambda x: x['line_number'], reverse=True)
                
                # 在内存中完成所有注释注入
                file_modified = False
                for task in tasks:
                    line_number = task['line_number']
                    comment_lines = task['comment_lines']
                    target_name = task['target_name']
                    
                    # 执行单个注释注入（在内存中）
                    success = self._inject_comment_in_memory(
                        lines, line_number, comment_lines, target_name
                    )
                    
                    if success:
                        file_modified = True
                        logger.debug("在内存中成功注入注释: {} -> {}:{}", target_name, file_path, line_number)
                    else:
                        logger.error("在内存中注入注释失败: {} -> {}:{}", target_name, file_path, line_number)
                        overall_success = False
                
                # 如果文件有修改，一次性写入
                if file_modified:
                    new_content = '\n'.join(lines)
                    write_file_content(file_path, new_content)
                    logger.debug("批量写入文件完成: {}", file_path)
                
            except Exception as e:
                logger.error("批量处理文件失败 {}: {}", file_path, str(e))
                overall_success = False
        
        return overall_success
    
    def _inject_comment_in_memory(self, lines: List[str], line_number: int, 
                                comment_lines: List[str], target_name: str) -> bool:
        """
        在内存中的行列表中注入注释（不写入文件）
        
        Args:
            lines: 文件行列表（会被修改）
            line_number: 目标行号
            comment_lines: 注释行
            target_name: 目标名称
            
        Returns:
            bool: 是否成功注入
        """
        try:
            if line_number < 1 or line_number > len(lines):
                logger.error("行号超出范围: {} (文件共 {} 行)", line_number, len(lines))
                return False
            
            # 获取目标行的缩进
            target_line = lines[line_number - 1]
            indent = ""
            for char in target_line:
                if char in [' ', '\t']:
                    indent += char
                else:
                    break
            
            # 检查是否已存在注释并保留特殊信息
            existing_comment_start = self._find_existing_comment_start(lines, line_number - 1)
            final_comment_lines = comment_lines
            
            if existing_comment_start is not None:
                # 提取现有注释内容以保留特殊标记
                existing_comment_end = self._find_comment_end(lines, existing_comment_start)
                if existing_comment_end is not None:
                    # 提取现有注释内容
                    existing_comment_lines = lines[existing_comment_start:existing_comment_end + 1]
                    existing_content = '\n'.join(existing_comment_lines)
                    
                    # 保留现有的@deprecated、@since等信息
                    final_comment_lines = self._preserve_existing_info(existing_content, comment_lines)
                    
                    # 删除现有注释行（从后往前删除，避免索引偏移）
                    for i in range(existing_comment_end, existing_comment_start - 1, -1):
                        if i < len(lines):
                            del lines[i]
                    # 更新行号
                    line_number = existing_comment_start
            
            # 应用格式化处理
            final_comment_lines = self.comment_formatter.format_single_comment(final_comment_lines)
            
            # 插入新注释，应用相同的缩进
            insert_pos = line_number - 1
            indented_comment_lines = [indent + comment_line for comment_line in final_comment_lines]
            for i, comment_line in enumerate(indented_comment_lines):
                lines.insert(insert_pos + i, comment_line)
            
            return True
            
        except Exception as e:
            logger.error("内存注释注入失败 {}: {}", target_name, str(e))
            return False
    
    def _inject_comment_at_location(self, file_path: str, line_number: int, 
                                  comment_lines: List[str], target_name: str) -> bool:
        """
        在指定位置注入注释
        
        Args:
            file_path: 文件路径
            line_number: 行号
            comment_lines: 注释行列表
            target_name: 目标名称（用于日志）
            
        Returns:
            bool: 是否成功注入
        """
        try:
            # 读取文件内容
            content = read_file_content(file_path)
            lines = content.split('\n')
            
            if line_number < 1 or line_number > len(lines):
                logger.error("行号超出范围: {} (文件共 {} 行)", line_number, len(lines))
                return False
            
            # 查找并处理现有注释
            existing_comment_text = ""
            start_line = self._find_existing_comment_start(lines, line_number - 1)
            if start_line is not None:
                end_line = self._find_comment_end(lines, start_line)
                if end_line is not None:
                    # 提取现有注释文本用于保留@deprecated等信息
                    existing_comment_lines = lines[start_line:end_line + 1]
                    existing_comment_text = '\n'.join(existing_comment_lines)
                    
                    # 移除现有注释（包含空行）
                    del lines[start_line:end_line + 1]
                    # 调整目标行号
                    line_number = start_line + 1
                else:
                    logger.warning("未找到注释结束位置，可能注释格式有问题")
            
            # 保留现有的@deprecated、@since等信息
            final_comment_lines = self._preserve_existing_info(existing_comment_text, comment_lines)
            
            # 应用行长度格式化
            from ..processors.comment_formatter import CommentFormatter
            formatter = CommentFormatter(max_line_length=100)
            final_comment_lines = formatter.format_single_comment(final_comment_lines)
            
            # 检测API定义行的缩进
            api_line = lines[line_number - 1] if line_number <= len(lines) else ""
            indent = self._get_line_indent(api_line)
            
            # 插入新注释，应用相同的缩进
            insert_pos = line_number - 1
            indented_comment_lines = [indent + comment_line for comment_line in final_comment_lines]
            for i, comment_line in enumerate(reversed(indented_comment_lines)):
                lines.insert(insert_pos, comment_line)
            
            # 写回文件
            new_content = '\n'.join(lines)
            write_file_content(file_path, new_content)
            
            logger.debug("成功注入注释到 {}:{}", file_path, line_number)
            return True
            
        except Exception as e:
            logger.error("注入注释失败 {} -> {}:{}: {}", target_name, file_path, line_number, str(e))
            return False
    
    def _find_existing_comment_start(self, lines: List[str], target_line: int) -> Optional[int]:
        """
        查找目标行前的现有注释块的开始位置（增强版）
        
        支持多种注释格式：
        1. 单行注释：/** ... */ 
        2. 单行注释：/* ... */
        3. 多行注释：/** ... */ (跨行)
        4. 多行注释：/* ... */ (跨行)
        
        Args:
            lines: 文件行列表
            target_line: 目标行索引(0-based)
            
        Returns:
            Optional[int]: 注释开始行索引，如果没有找到返回None
        """
        # 从目标行的上一行开始向上搜索，允许跳过空行和注解
        current_line = target_line - 1
        
        # 跳过空行和Java注解，但记录跳过的行数
        skipped_lines_count = 0
        while current_line >= 0:
            line_content = lines[current_line].strip()
            if not line_content:
                # 空行
                current_line -= 1
                skipped_lines_count += 1
            elif self._is_java_annotation(line_content):
                # Java注解，跳过
                current_line -= 1
                skipped_lines_count += 1
            else:
                # 找到非空非注解行
                break
        
        # 如果没有找到非空非注解行，说明没有注释
        if current_line < 0:
            return None
        
        # 限制跳过行数量，避免误删除距离太远的注释
        if skipped_lines_count > 3:
            return None
        
        line = lines[current_line].strip()
        
        # 检查各种单行注释格式
        if self._is_any_single_line_comment(line):
            return current_line
        
        # 检查是否为多行注释结束标记
        if line == "*/":
            # 向上查找注释开始标记
            comment_end = current_line
            for i in range(comment_end, -1, -1):
                line_content = lines[i].strip()
                
                # 找到注释开始标记
                if (line_content.startswith("/**") or 
                    line_content.startswith("/*")):
                    return i
                elif not self._is_comment_line(line_content):
                    # 遇到非注释行，说明注释块不完整
                    return None
        
        # 检查是否为多行注释开始但在同一行结束的情况
        if (line.startswith("/**") and line.endswith("*/")) or \
           (line.startswith("/*") and line.endswith("*/")):
            return current_line
        
        # 检查是否为跨行注释的结束行（以 */ 结尾但不是单独的 */）
        if line.endswith("*/") and line != "*/":
            # 向上查找注释开始标记
            for i in range(current_line, -1, -1):
                line_content = lines[i].strip()
                
                # 找到注释开始标记
                if (line_content.startswith("/**") or 
                    line_content.startswith("/*")):
                    return i
                elif not self._is_comment_line(line_content):
                    # 遇到非注释行，说明注释块不完整
                    break
        
        return None
    
    def _is_java_annotation(self, line: str) -> bool:
        """
        检查是否为Java注解
        
        Args:
            line: 已经strip()的代码行
            
        Returns:
            bool: 是否为Java注解
        """
        return line.startswith('@') and not line.startswith('@@')
    
    def _is_single_line_comment(self, line: str) -> bool:
        """
        检查是否为单行注释 /* ... */
        
        Args:
            line: 已经strip()的代码行
            
        Returns:
            bool: 是否为单行注释
        """
        if not line:
            return False
        
        # 检查是否以 /* 开始并以 */ 结束
        if line.startswith('/*') and line.endswith('*/') and len(line) > 4:
            # 确保不是多行注释的开始 (/** 开头)
            if not line.startswith('/**'):
                return True
        
        return False
    
    def _is_any_single_line_comment(self, line: str) -> bool:
        """
        检查是否为任何格式的单行注释
        
        支持格式：
        1. /** ... */
        2. /* ... */
        
        Args:
            line: 已经strip()的代码行
            
        Returns:
            bool: 是否为单行注释
        """
        if not line:
            return False
        
        # 检查 /** ... */ 格式
        if (line.startswith('/**') and line.endswith('*/') and len(line) > 5):
            return True
        
        # 检查 /* ... */ 格式（但不是 /** 开头）
        if (line.startswith('/*') and line.endswith('*/') and 
            len(line) > 4 and not line.startswith('/**')):
            return True
        
        return False
    
    def _find_comment_end(self, lines: List[str], start_line: int) -> Optional[int]:
        """
        查找注释的结束位置（增强版）
        
        Args:
            lines: 文件行列表
            start_line: 注释开始行索引
            
        Returns:
            Optional[int]: 注释结束行索引，如果没有找到返回None
        """
        start_line_content = lines[start_line].strip()
        
        # 如果是任何格式的单行注释，结束位置就是开始位置
        if self._is_any_single_line_comment(start_line_content):
            return start_line
        
        # 多行注释，查找结束标记
        for i in range(start_line, len(lines)):
            line = lines[i].strip()
            
            # 检查是否为同行结束的多行注释（开始行就包含结束标记）
            if i == start_line and line.endswith("*/"):
                return start_line
            
            # 检查各种结束标记
            if (line == "*/" or line.endswith("**/") or 
                line == "* */" or line.endswith("* */")):  # 添加Java格式支持
                # 查看下一行是否为空行，如果是也要移除
                next_line_idx = i + 1
                if (next_line_idx < len(lines) and 
                    lines[next_line_idx].strip() == ""):
                    return next_line_idx
                return i
            
            # 如果遇到非注释行（除了第一行的开始标记），说明注释块已结束
            if i > start_line and not self._is_comment_line(line):
                # 回到上一行查找结束标记
                prev_line = lines[i-1].strip() if i > 0 else ""
                if prev_line == "*/" or prev_line.endswith("**/"):
                    return i - 1
                # 如果上一行不是结束标记，可能是格式问题，返回上一行
                return i - 1
        
        return None
    
    def _preserve_existing_info(self, existing_content: str, new_comment: List[str]) -> List[str]:
        """
        保留现有代码中的特殊标记
        
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
        从文件内容中提取现有的注释
        
        Args:
            content: 文件内容
            
        Returns:
            str: 现有注释内容
        """
        # 使用正则表达式提取 /** ... */ 格式的注释
        comment_pattern = r'/\*\*(.*?)\*/'
        matches = re.findall(comment_pattern, content, re.DOTALL)
        
        if matches:
            # 返回最后一个匹配的注释（通常是最相关的）
            return matches[-1]
        
        return ""
    
    def _get_line_indent(self, line: str) -> str:
        """
        获取行的缩进字符串
        
        Args:
            line: 代码行
            
        Returns:
            str: 缩进字符串（空格或制表符）
        """
        indent = ""
        for char in line:
            if char in [' ', '\t']:
                indent += char
            else:
                break
        return indent
    
    def _is_comment_line(self, line: str) -> bool:
        """
        判断是否为注释行（包括多行注释中的各种格式）
        
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
        if line.startswith('/**') or line == '*/':
            return True
        
        # 检查是否为明确的代码行（包含代码关键字或符号）
        code_indicators = [
            'class ', 'struct ', 'enum ', 'namespace ',
            'public:', 'private:', 'protected:',
            'virtual ', 'static ', 'const ', 'inline ',
            'typedef ', '#include', '#define', '#if',
            ');', '};', '{', '}', '=',
            'return ', 'if (', 'for (', 'while (', 'switch ('
        ]
        
        for indicator in code_indicators:
            if indicator in line:
                return False
        
        # 如果不包含明确的代码指示符，可能是注释的延续行
        # 特别是像 "stream." 这样的文本片段
        return True
