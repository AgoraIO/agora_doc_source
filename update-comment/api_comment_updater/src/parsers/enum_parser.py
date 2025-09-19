# -*- coding: utf-8 -*-
"""
Enum HTML文件解析器
用于解析enum_xxx.html文件，提取枚举信息
"""

from typing import Dict, List, Any
from loguru import logger

from .html_parser import BaseHTMLParser
from ..utils.text_utils import build_comment_block, extract_text_content


class EnumHTMLParser(BaseHTMLParser):
    """Enum HTML文件解析器"""
    
    def _extract_data(self) -> Dict[str, Any]:
        """
        从Enum HTML文件中提取枚举数据
        
        Returns:
            Dict: 包含枚举信息的数据
        """
        result = {
            "type": "enum",
            "file": self._get_file_name(),
            "enums": []
        }
        
        # 提取枚举信息
        enum_data = self._extract_enum_info()
        if enum_data:
            result["enums"].append(enum_data)
            logger.info("从 {} 提取了枚举: {}", self._get_file_name(), enum_data.get("name", "Unknown"))
        else:
            logger.warning("未能从 {} 提取到枚举信息", self._get_file_name())
        
        return result
    
    def _extract_enum_info(self) -> Dict[str, Any]:
        """
        提取枚举的基本信息
        
        Returns:
            Dict: 枚举信息
        """
        enum_data = {}
        
        # 提取枚举名
        enum_data["name"] = self._extract_name()
        if not enum_data["name"]:
            logger.warning("无法提取枚举名")
            return None
        
        # 提取文件名
        enum_data["file"] = self._get_file_name()
        
        # 提取枚举注释信息
        enum_data["enum_comment"] = self._extract_enum_comments()
        
        return enum_data
    
    def _extract_enum_comments(self) -> List[Dict[str, Any]]:
        """
        提取枚举的注释信息，包括枚举描述和枚举值注释
        
        Returns:
            List[Dict]: 注释信息列表
        """
        comments = []
        
        # 1. 提取枚举描述注释
        desc_comment = self._extract_enum_description()
        if desc_comment:
            comments.append({
                "type": "desc",
                "comment": desc_comment
            })
        
        # 2. 提取枚举值注释
        enumerator_comments = self._extract_enumerator_comments()
        comments.extend(enumerator_comments)
        
        return comments
    
    def _extract_enum_description(self) -> List[str]:
        """
        提取枚举的描述注释
        
        Returns:
            List[str]: 格式化的注释行
        """
        content = {}
        
        # 提取简短描述
        brief = self._extract_short_description()
        if brief:
            content["brief"] = brief
        
        # 提取详细描述
        details = self._extract_detailed_description()
        if details:
            content["details"] = details
        
        # 提取注意事项（类似toc方式）
        notes = self._extract_notes_for_enum_desc()
        if notes:
            content["note"] = notes
        
        if content:
            return build_comment_block(content)
        
        return []
    
    def _extract_enumerator_comments(self) -> List[Dict[str, Any]]:
        """
        提取枚举值的注释
        
        Returns:
            List[Dict]: 枚举值注释列表
        """
        enumerator_comments = []
        
        # 查找枚举值section (通常在parameters section中)
        params_section = self.soup.find('section', id=lambda x: x and '__parameters' in x)
        if not params_section:
            logger.debug("未找到枚举值section")
            return enumerator_comments
        
        # 查找所有dl元素中的枚举值（可能有多个dl标签）
        dl_elements = params_section.find_all('dl', class_='parml')
        if not dl_elements:
            logger.debug("未找到枚举值列表")
            return enumerator_comments
        
        logger.debug("找到 {} 个枚举值dl元素", len(dl_elements))
        
        for dl_elem in dl_elements:
            # 每个枚举值由dt和dd组成 - 只查找直接子dt，避免包含deprecated等嵌套dt
            dt_elements = dl_elem.find_all('dt', class_='dlterm', recursive=False)
            logger.debug("当前dl中找到 {} 个枚举值dt元素", len(dt_elements))
            
            for dt in dt_elements:
                # 提取枚举值名称
                enum_value_name = self._extract_enum_value_name(dt)
                logger.debug("提取到枚举值名称: {}", enum_value_name)
                
                # 查找对应的dd元素
                dd = dt.find_next_sibling('dd', class_='pd')
                enum_desc = ""
                enum_note = ""
                
                if dd:
                    # 创建dd的副本，避免修改原始DOM
                    import copy
                    dd_copy = copy.copy(dd)
                    
                    # 提取note内容（使用统一格式化逻辑）
                    from ..utils.note_utils import extract_notes_from_dd
                    enum_note = extract_notes_from_dd(dd_copy)
                    
                    # 移除note元素后继续处理
                    note_selectors = ['.note.attention', '.note_attention', '.note.note', '.note_note']
                    for selector in note_selectors:
                        note_elements = dd_copy.select(selector)
                        for note_elem in note_elements:
                            note_elem.decompose()
                    
                    # 移除since/deprecated信息，这些信息应从现有代码保留
                    deprecated_elements = dd_copy.find_all('dl', class_='deprecated')
                    for deprecated_elem in deprecated_elements:
                        deprecated_elem.decompose()
                    
                    since_elements = dd_copy.find_all('dl', class_='since')
                    for since_elem in since_elements:
                        since_elem.decompose()
                    
                    # 使用多行提取保留列表结构
                    from ..utils.text_utils import extract_multiline_content
                    enum_desc = extract_multiline_content(dd_copy)
                    logger.debug("提取到枚举值描述（已排除since/deprecated和note）: {}", enum_desc)
                
                if enum_value_name and (enum_desc or enum_note):
                    # 构建枚举值注释
                    comment_lines = ["/**"]
                    
                    # 添加描述内容
                    if enum_desc:
                        desc_lines = enum_desc.split('\n')
                        for line in desc_lines:
                            if line.strip():
                                comment_lines.append(f" * {line}")
                    
                    # 添加note内容（使用统一格式化后的内容）
                    if enum_note:
                        # enum_note已经包含完整的@note格式，直接添加
                        if enum_note.startswith('@note '):
                            # 单行格式：@note 内容
                            comment_lines.append(f" * {enum_note}")
                        elif enum_note.startswith('@note\n'):
                            # 多行格式：@note\n * 内容
                            note_lines = enum_note.split('\n')
                            for line in note_lines:
                                if line.strip():
                                    if line.startswith(' * '):
                                        # 已经有正确的缩进格式，直接使用
                                        comment_lines.append(line)
                                    elif line.startswith('* '):
                                        # 缺少空格的格式，补充空格
                                        comment_lines.append(f" {line}")
                                    else:
                                        # 纯内容，添加完整前缀
                                        comment_lines.append(f" * {line}")
                        else:
                            # 兜底：直接作为@note内容
                            comment_lines.append(f" * @note {enum_note}")
                    
                    comment_lines.append(" */")
                    
                    enumerator_comments.append({
                        "type": "enumerator",
                        "value": enum_value_name,
                        "comment": comment_lines
                    })
                    
                    logger.debug("成功添加枚举值注释: {}", enum_value_name)
                else:
                    logger.warning("枚举值信息不完整: name={}, desc={}", enum_value_name, enum_desc)
        
        logger.debug("总共提取了 {} 个枚举值注释", len(enumerator_comments))
        return enumerator_comments
    
    def _extract_enum_value_name(self, dt_element) -> str:
        """
        从dt元素中提取枚举值名称
        
        Args:
            dt_element: dt元素
            
        Returns:
            str: 枚举值名称
        """
        # 查找span元素中的枚举值名称
        span_elem = dt_element.find('span', class_='ph')
        if span_elem:
            enum_name = span_elem.get_text(strip=True)
            logger.debug("提取到枚举值名称: {}", enum_name)
            return enum_name
        
        # 如果没有span，直接提取dt的文本
        enum_name = dt_element.get_text(strip=True)
        logger.debug("提取到枚举值名称(fallback): {}", enum_name)
        return enum_name
    
    def _extract_notes_for_enum_desc(self) -> str:
        """
        提取枚举描述的注意事项，使用统一的note处理逻辑
        
        Returns:
            str: 格式化后的note内容
        """
        from ..utils.note_utils import extract_notes_from_html, format_notes_content
        
        notes = []
        
        # 提取详细描述中的notes
        detailed_desc_section = self.soup.find('section', id=lambda x: x and '__detailed_desc' in x)
        if detailed_desc_section:
            detailed_notes = extract_notes_from_html(detailed_desc_section)
            notes.extend(detailed_notes)
        
        # 提取其他特定区域的notes（排除参数区域和详细描述区域）
        params_section = self.soup.find('section', id=lambda x: x and '__parameters' in x)
        exclude_sections = [params_section, detailed_desc_section]
        
        other_notes = extract_notes_from_html(self.soup, exclude_sections)
        notes.extend(other_notes)
        
        # 使用统一的格式化逻辑
        return format_notes_content(notes)
    
