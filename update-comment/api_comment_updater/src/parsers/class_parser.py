# -*- coding: utf-8 -*-
"""
Class HTML文件解析器
用于解析class_xxx.html文件，提取类信息
"""

from typing import Dict, List, Any
from loguru import logger

from .html_parser import BaseHTMLParser
from ..utils.text_utils import build_comment_block, extract_text_content


class ClassHTMLParser(BaseHTMLParser):
    """Class HTML文件解析器"""
    
    def _extract_data(self) -> Dict[str, Any]:
        """
        从Class HTML文件中提取类数据
        
        Returns:
            Dict: 包含类信息的数据
        """
        result = {
            "type": "class",
            "file": self._get_file_name(),
            "classes": []
        }
        
        # 提取类信息
        class_data = self._extract_class_info()
        if class_data:
            result["classes"].append(class_data)
            logger.info("从 {} 提取了类: {}", self._get_file_name(), class_data.get("name", "Unknown"))
        else:
            logger.warning("未能从 {} 提取到类信息", self._get_file_name())
        
        return result
    
    def _extract_class_info(self) -> Dict[str, Any]:
        """
        提取类的基本信息
        
        Returns:
            Dict: 类信息
        """
        class_data = {}
        
        # 提取类名
        class_data["name"] = self._extract_name()
        if not class_data["name"]:
            logger.warning("无法提取类名")
            return None
        
        # 提取类签名
        class_data["signature"] = self._extract_signature()
        
        # 提取文件名
        class_data["file"] = self._get_file_name()
        
        # 提取类注释信息
        class_data["class_comment"] = self._extract_class_comments()
        
        return class_data
    
    def _extract_class_comments(self) -> List[Dict[str, Any]]:
        """
        提取类的注释信息，包括类描述和属性注释
        
        Returns:
            List[Dict]: 注释信息列表
        """
        comments = []
        
        # 1. 提取类描述注释
        desc_comment = self._extract_class_description()
        if desc_comment:
            comments.append({
                "type": "desc",
                "comment": desc_comment
            })
        
        # 2. 提取属性注释
        attribute_comments = self._extract_attribute_comments()
        comments.extend(attribute_comments)
        
        return comments
    
    def _extract_class_description(self) -> List[str]:
        """
        提取类的描述注释
        
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
        
        # 提取Since信息
        since_info = self._extract_since_info()
        if since_info:
            content["details"] = (content.get("details", "") + f"\n\nSince: {since_info}").strip()
        
        # 提取注意事项（类似toc方式）
        notes = self._extract_notes_for_class_desc()
        if notes:
            content["note"] = notes
        
        if content:
            return build_comment_block(content)
        
        return []
    
    def _extract_attribute_comments(self) -> List[Dict[str, Any]]:
        """
        提取类属性的注释
        
        Returns:
            List[Dict]: 属性注释列表
        """
        attribute_comments = []
        
        # 查找参数/属性section
        params_section = self.soup.find('section', id=lambda x: x and '__parameters' in x)
        if not params_section:
            logger.debug("未找到属性section")
            return attribute_comments
        
        # 查找所有dl元素中的属性（可能有多个dl标签）
        dl_elements = params_section.find_all('dl', class_='parml')
        if not dl_elements:
            logger.debug("未找到属性列表")
            return attribute_comments
        
        logger.debug("找到 {} 个属性dl元素", len(dl_elements))
        
        for dl_elem in dl_elements:
            # 每个属性由dt和dd组成 - 只查找直接子dt，避免包含嵌套dt
            dt_elements = dl_elem.find_all('dt', class_='dlterm', recursive=False)
            logger.debug("当前dl中找到 {} 个属性dt元素", len(dt_elements))
            
            for dt in dt_elements:
                attr_name = dt.get_text(strip=True)
                
                # 查找对应的dd元素
                dd = dt.find_next_sibling('dd', class_='pd')
                attr_desc = ""
                attr_note = ""
                
                if dd:
                    # 创建dd的副本，避免修改原始DOM
                    import copy
                    dd_copy = copy.copy(dd)
                    
                    # 提取note内容（简洁格式）
                    attr_note = self._extract_note_for_attribute(dd_copy)
                    
                    # 移除note元素后提取描述
                    note_selectors = ['.note.attention', '.note_attention', '.note.note', '.note_note']
                    for selector in note_selectors:
                        note_elements = dd_copy.select(selector)
                        for note_elem in note_elements:
                            note_elem.decompose()
                    
                    # 使用多行提取保留列表结构
                    from ..utils.text_utils import extract_multiline_content
                    attr_desc = extract_multiline_content(dd_copy)
                
                if attr_name and (attr_desc or attr_note):
                    # 构建属性注释
                    comment_lines = ["/**"]
                    
                    # 添加描述内容
                    if attr_desc:
                        desc_lines = attr_desc.split('\n')
                        for line in desc_lines:
                            if line.strip():
                                comment_lines.append(f" * {line}")
                    
                    # 添加note内容（简洁格式，不换行）
                    if attr_note:
                        comment_lines.append(f" * @note {attr_note}")
                    
                    comment_lines.append(" */")
                    
                    attribute_comments.append({
                        "type": "attribute",
                        "value": attr_name,
                        "comment": comment_lines
                    })
                    
                    logger.debug("提取到属性注释: {}", attr_name)
        
        return attribute_comments
    
    def _extract_notes_for_class_desc(self) -> str:
        """
        提取类描述的注意事项，类似toc_parser的方式
        
        Returns:
            str: 注意事项内容
        """
        notes = []
        
        # 提取详细描述中的notes
        detailed_desc_section = self.soup.find('section', id=lambda x: x and '__detailed_desc' in x)
        if detailed_desc_section:
            # 查找详细描述中的note元素
            note_selectors = [
                '.note.attention',
                '.note_attention', 
                '.note.note',
                '.note_note'
            ]
            for selector in note_selectors:
                note_elements = detailed_desc_section.select(selector)
                for note_elem in note_elements:
                    from ..utils.text_utils import extract_multiline_content
                    note_text = extract_multiline_content(note_elem)
                    if note_text and note_text not in notes:
                        notes.append(note_text)
        
        # 提取其他特定区域的notes（排除参数区域）
        params_section = self.soup.find('section', id=lambda x: x and '__parameters' in x)
        
        # 在整个文档中查找notes，但排除参数区域
        note_selectors = [
            '.note.attention',
            '.note_attention', 
            '.note.note',
            '.note_note'
        ]
        
        for selector in note_selectors:
            note_elements = self.soup.select(selector)
            for note_elem in note_elements:
                # 检查这个note是否在参数区域内
                if params_section and params_section.find(lambda tag: tag == note_elem):
                    continue  # 跳过参数区域内的notes
                
                # 检查是否已经在详细描述中处理过
                if detailed_desc_section and detailed_desc_section.find(lambda tag: tag == note_elem):
                    continue  # 跳过已处理的notes
                
                from ..utils.text_utils import extract_multiline_content
                note_text = extract_multiline_content(note_elem)
                if note_text and note_text not in notes:
                    notes.append(note_text)
        
        result = '\n\n'.join(notes)
        return result
    
    def _extract_note_for_attribute(self, dd_element) -> str:
        """
        从dd元素中提取note内容（简洁格式，不保留标题）
        
        Args:
            dd_element: BeautifulSoup dd元素
            
        Returns:
            str: 简洁的note内容
        """
        if not dd_element:
            return ""
        
        note_texts = []
        note_selectors = ['.note.attention', '.note_attention', '.note.note', '.note_note']
        
        for selector in note_selectors:
            note_elements = dd_element.select(selector)
            for note_elem in note_elements:
                from ..utils.text_utils import extract_text_content
                note_text = extract_text_content(note_elem)
                
                # 移除note标题（如 "Note:", "Attention:" 等）
                note_text = self._remove_note_title(note_text)
                
                if note_text and note_text not in note_texts:
                    note_texts.append(note_text)
        
        # 合并多个note，用空格分隔（简洁格式）
        return ' '.join(note_texts)
    
    def _remove_note_title(self, text: str) -> str:
        """
        移除note标题（如 "Note:", "Attention:" 等）
        
        Args:
            text: 原始note文本
            
        Returns:
            str: 移除标题后的文本
        """
        if not text:
            return text
        
        # 常见的note标题模式
        title_patterns = [
            r'^Note:\s*',
            r'^Attention:\s*',
            r'^Warning:\s*',
            r'^Caution:\s*',
            r'^Important:\s*',
            r'^Tip:\s*',
            r'^注意：\s*',
            r'^警告：\s*',
            r'^提示：\s*'
        ]
        
        import re
        for pattern in title_patterns:
            text = re.sub(pattern, '', text, flags=re.IGNORECASE)
        
        return text.strip()
    
    def _extract_since_info(self) -> str:
        """
        提取Since版本信息 - 已弃用，since信息应从现有代码保留
        
        Returns:
            str: 空字符串，since信息不再从HTML提取
        """
        # since/deprecated信息不再从HTML提取，应从现有代码保留
        return ""
