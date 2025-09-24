# -*- coding: utf-8 -*-
"""
注释标准化处理器
将HTML内容转换为标准化的代码注释格式
"""

from typing import Dict, List, Any, Optional
from loguru import logger

from ..utils.text_utils import build_comment_block, clean_whitespace


class CommentNormalizer:
    """注释标准化处理器"""
    
    def __init__(self, platform_config: Dict[str, Any]):
        """
        初始化处理器
        
        Args:
            platform_config: 平台配置信息
        """
        self.platform_config = platform_config
        self.comment_template = platform_config.get("comment_template", "")
        self.language = platform_config.get("language", "cpp")
        
    def normalize_api_comment(self, api_data: Dict[str, Any]) -> List[str]:
        """
        标准化API注释
        
        Args:
            api_data: API数据
            
        Returns:
            List[str]: 标准化的注释行
        """
        logger.debug("标准化API注释: {}", api_data.get("name", "Unknown"))
        
        # 直接返回已经构建好的注释
        if "comment" in api_data and isinstance(api_data["comment"], list):
            return api_data["comment"]
        
        # 如果没有预构建的注释，从原始数据构建
        content = self._extract_content_from_api(api_data)
        return build_comment_block(content)
    
    def normalize_class_comment(self, class_data: Dict[str, Any]) -> Dict[str, Any]:
        """
        标准化类注释
        
        Args:
            class_data: 类数据
            
        Returns:
            Dict: 标准化的类注释数据
        """
        logger.debug("标准化类注释: {}", class_data.get("name", "Unknown"))
        
        result = {
            "name": class_data.get("name", ""),
            "signature": class_data.get("signature", ""),
            "file": class_data.get("file", ""),
            "comments": []
        }
        
        # 处理类注释
        class_comments = class_data.get("class_comment", [])
        for comment_item in class_comments:
            if comment_item.get("type") == "desc":
                # 类描述注释
                result["comments"].append({
                    "type": "class_description",
                    "comment": comment_item.get("comment", [])
                })
            elif comment_item.get("type") == "attribute":
                # 属性注释
                result["comments"].append({
                    "type": "attribute",
                    "target": comment_item.get("value", ""),
                    "comment": comment_item.get("comment", [])
                })
        
        return result
    
    def normalize_enum_comment(self, enum_data: Dict[str, Any]) -> Dict[str, Any]:
        """
        标准化枚举注释
        
        Args:
            enum_data: 枚举数据
            
        Returns:
            Dict: 标准化的枚举注释数据
        """
        logger.debug("标准化枚举注释: {}", enum_data.get("name", "Unknown"))
        
        result = {
            "name": enum_data.get("name", ""),
            "file": enum_data.get("file", ""),
            "comments": []
        }
        
        # 处理枚举注释
        enum_comments = enum_data.get("enum_comment", [])
        for comment_item in enum_comments:
            if comment_item.get("type") == "desc":
                # 枚举描述注释
                result["comments"].append({
                    "type": "enum_description",
                    "comment": comment_item.get("comment", [])
                })
            elif comment_item.get("type") == "enumerator":
                # 枚举值注释
                result["comments"].append({
                    "type": "enumerator",
                    "target": comment_item.get("value", ""),
                    "comment": comment_item.get("comment", [])
                })
        
        return result
    
    def _extract_content_from_api(self, api_data: Dict[str, Any]) -> Dict[str, Any]:
        """
        从API数据中提取注释内容
        
        Args:
            api_data: API数据
            
        Returns:
            Dict: 注释内容字典
        """
        content = {}
        
        # 这里应该从API数据中提取各种注释字段
        # 但由于我们在解析阶段已经构建了注释，这里主要是处理特殊情况
        
        return content
    
    def apply_template(self, content: Dict[str, Any]) -> List[str]:
        """
        应用注释模板
        
        Args:
            content: 注释内容字典
            
        Returns:
            List[str]: 格式化的注释行
        """
        if not self.comment_template:
            return build_comment_block(content)
        
        # 应用自定义模板
        template_lines = self.comment_template.split('\n')
        result_lines = []
        
        for line in template_lines:
            # 替换模板变量
            formatted_line = line
            for key, value in content.items():
                placeholder = f"{{{key}}}"
                if placeholder in formatted_line:
                    if isinstance(value, str):
                        formatted_line = formatted_line.replace(placeholder, value)
                    elif isinstance(value, list):
                        # 对于列表类型，使用第一个元素或空字符串
                        replacement = value[0] if value else ""
                        formatted_line = formatted_line.replace(placeholder, replacement)
                    else:
                        formatted_line = formatted_line.replace(placeholder, str(value))
            
            result_lines.append(formatted_line)
        
        return result_lines
    
    def preserve_existing_info(self, existing_comment: str, new_comment: List[str]) -> List[str]:
        """
        保留现有代码中的@technical preview/@since/@deprecated信息
        
        Args:
            existing_comment: 现有的注释文本
            new_comment: 新生成的注释行
            
        Returns:
            List[str]: 合并后的注释行
        """
        if not existing_comment:
            return new_comment
        
        # 提取需要保留的信息
        preserved_info = self._extract_preserved_patterns(existing_comment)
        
        if not preserved_info:
            return new_comment
        
        # 将保留的信息插入到新注释中
        return self._merge_preserved_info(new_comment, preserved_info)
    
    def _extract_preserved_patterns(self, comment_text: str) -> Dict[str, str]:
        """
        从现有注释中提取需要保留的模式
        
        Args:
            comment_text: 注释文本
            
        Returns:
            Dict: 保留的信息
        """
        import re
        
        preserved = {}
        preserve_patterns = self.platform_config.get("preserve_patterns", {})
        
        for pattern_name, pattern in preserve_patterns.items():
            if pattern_name == "deprecated":
                # 对deprecated进行特殊处理，支持多行描述
                preserved_content = self._extract_deprecated_content(comment_text)
                if preserved_content:
                    preserved[pattern_name] = preserved_content
                    logger.debug("保留信息: {} = {}", pattern_name, preserved[pattern_name])
            elif pattern_name == "technical_preview":
                # technical_preview只保留标签本身，不保留后续内容
                match = re.search(pattern, comment_text, re.IGNORECASE)
                if match:
                    preserved[pattern_name] = "@technical preview"
                    logger.debug("保留信息: {} = {}", pattern_name, preserved[pattern_name])
            else:
                # since等其他模式继续使用原逻辑
                match = re.search(pattern, comment_text, re.IGNORECASE)
                if match:
                    preserved[pattern_name] = match.group(0)
                    logger.debug("保留信息: {} = {}", pattern_name, preserved[pattern_name])
        
        return preserved
    
    def _extract_deprecated_content(self, comment_text: str) -> str:
        """
        提取完整的@deprecated内容，包括多行描述
        
        Args:
            comment_text: 注释文本
            
        Returns:
            str: 完整的deprecated内容，如果没有则返回空字符串
        """
        import re
        
        lines = comment_text.split('\n')
        deprecated_content = []
        in_deprecated_block = False
        empty_line_count = 0
        
        for line in lines:
            stripped = line.strip()
            
            # 移除注释前缀
            if stripped.startswith('*'):
                stripped = stripped[1:].strip()
            elif stripped.startswith('//'):
                stripped = stripped[2:].strip()
            
            # 检查是否是@deprecated的开始
            if re.match(r'@deprecated\b', stripped, re.IGNORECASE):
                in_deprecated_block = True
                empty_line_count = 0
                deprecated_content.append(stripped)
                continue
            
            # 如果在deprecated块中
            if in_deprecated_block:
                # 检查是否遇到其他@标签（结束deprecated块）
                if re.match(r'@\w+', stripped):
                    break
                
                # 如果是空行
                if not stripped:
                    empty_line_count += 1
                    # 如果连续遇到空行，则认为deprecated块结束
                    if empty_line_count >= 1:
                        break
                    continue
                else:
                    # 重置空行计数
                    empty_line_count = 0
                    deprecated_content.append(stripped)
        
        if deprecated_content:
            return '\n'.join(deprecated_content)
        
        return ""
    
    def _merge_preserved_info(self, comment_lines: List[str], preserved_info: Dict[str, str]) -> List[str]:
        """
        将保留的信息合并到新注释中
        
        Args:
            comment_lines: 新注释行
            preserved_info: 保留的信息
            
        Returns:
            List[str]: 合并后的注释行
        """
        if not comment_lines or not preserved_info:
            return comment_lines
        
        result = []
        preserved_inserted = False
        
        for line in comment_lines:
            result.append(line)
            
            # 在@brief后面插入保留的信息
            if line.strip().startswith("* @brief") and not preserved_inserted:
                result.append(" *")
                for info_type, info_text in preserved_info.items():
                    # 处理多行内容
                    if '\n' in info_text:
                        for info_line in info_text.split('\n'):
                            result.append(f" * {info_line}")
                    else:
                        result.append(f" * {info_text}")
                preserved_inserted = True
        
        # 如果没有@brief行（如enum注释），在注释结束前插入保留信息
        if not preserved_inserted and len(result) >= 2:
            # 在最后的 */ 前插入保留信息
            insert_pos = len(result) - 1  # */ 的位置
            for info_type, info_text in preserved_info.items():
                # 处理多行内容
                if '\n' in info_text:
                    for info_line in info_text.split('\n'):
                        result.insert(insert_pos, f" * {info_line}")
                        insert_pos += 1
                else:
                    result.insert(insert_pos, f" * {info_text}")
                    insert_pos += 1
        
        return result
