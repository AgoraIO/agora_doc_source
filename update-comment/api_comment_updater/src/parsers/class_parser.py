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
                if dd:
                    # 使用多行提取保留列表结构
                    from ..utils.text_utils import extract_multiline_content
                    attr_desc = extract_multiline_content(dd)
                
                if attr_name and attr_desc:
                    # 构建属性注释（不使用@brief，直接使用描述）
                    comment_lines = ["/**"]
                    
                    # 处理多行描述
                    desc_lines = attr_desc.split('\n')
                    for line in desc_lines:
                        if line.strip():
                            comment_lines.append(f" * {line}")
                    
                    comment_lines.append(" */")
                    
                    attribute_comments.append({
                        "type": "attribute",
                        "value": attr_name,
                        "comment": comment_lines
                    })
                    
                    logger.debug("提取到属性注释: {}", attr_name)
        
        return attribute_comments
    
    def _extract_since_info(self) -> str:
        """
        提取Since版本信息 - 已弃用，since信息应从现有代码保留
        
        Returns:
            str: 空字符串，since信息不再从HTML提取
        """
        # since/deprecated信息不再从HTML提取，应从现有代码保留
        return ""
