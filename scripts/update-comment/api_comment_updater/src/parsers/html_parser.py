# -*- coding: utf-8 -*-
"""
HTML解析器基类
"""

import re
import copy
from abc import ABC, abstractmethod
from pathlib import Path
from bs4 import BeautifulSoup
from typing import Dict, List, Any, Optional
from loguru import logger

from ..utils.text_utils import extract_text_content, clean_whitespace, unescape_html_entities


class BaseHTMLParser(ABC):
    """HTML解析器基类"""
    
    def __init__(self, platform_config: Dict[str, Any]):
        """
        初始化HTML解析器
        
        Args:
            platform_config: 平台配置信息
        """
        self.platform_config = platform_config
        self.html_parsing_config = platform_config.get("html_parsing", {})
        self.soup: Optional[BeautifulSoup] = None
        self.file_path: str = ""
        
    def parse_file(self, html_file_path: str) -> Dict[str, Any]:
        """
        解析HTML文件
        
        Args:
            html_file_path: HTML文件路径
            
        Returns:
            Dict: 解析结果
        """
        self.file_path = html_file_path
        
        try:
            logger.debug("开始解析HTML文件: {}", html_file_path)
            
            # 读取HTML文件
            with open(html_file_path, 'r', encoding='utf-8') as f:
                html_content = f.read()
            
            # 创建BeautifulSoup对象
            self.soup = BeautifulSoup(html_content, 'lxml')
            
            # 调用子类的具体解析方法
            result = self._extract_data()
            
            logger.info("成功解析HTML文件: {}", Path(html_file_path).name)
            return result
            
        except Exception as e:
            logger.error("解析HTML文件失败 {}: {}", html_file_path, str(e))
            raise
    
    @abstractmethod
    def _extract_data(self) -> Dict[str, Any]:
        """
        提取数据的抽象方法，由子类实现
        
        Returns:
            Dict: 提取的数据
        """
        pass
    
    def _extract_name(self, section_elem=None) -> str:
        """
        提取API/类/枚举名称
        
        Args:
            section_elem: 指定的section元素，如果为None则在整个文档中查找
            
        Returns:
            str: 名称
        """
        selector = self.html_parsing_config.get("api_name_selector", "")
        if not selector:
            return ""
        
        search_scope = section_elem if section_elem else self.soup
        name_elem = search_scope.select_one(selector)
        
        if name_elem:
            name = clean_whitespace(name_elem.get_text())
            logger.debug("提取到名称: {}", name)
            return name
        
        # 尝试其他可能的选择器（用于class和enum）
        alternative_selectors = [
            "h1.title.topictitle1 span.ph",  # class和enum使用h1
            "span.ph"  # 简化选择器
        ]
        
        for alt_selector in alternative_selectors:
            name_elem = search_scope.select_one(alt_selector)
            if name_elem:
                name = clean_whitespace(name_elem.get_text())
                logger.debug("提取到名称（备用选择器）: {}", name)
                return name
        
        logger.warning("未找到名称元素，选择器: {}", selector)
        return ""
    
    def _extract_signature(self, section_elem=None) -> str:
        """
        提取API签名
        
        Args:
            section_elem: 指定的section元素
            
        Returns:
            str: 签名
        """
        selector = self.html_parsing_config.get("signature_selector", "")
        if not selector:
            return ""
        
        search_scope = section_elem if section_elem else self.soup
        sig_elem = search_scope.select_one(selector)
        
        if sig_elem:
            # 先移除多余的HTML标签，保留原始的文本结构
            signature_text = self._clean_signature_text(sig_elem)
            signature = unescape_html_entities(signature_text)
            logger.debug("提取到签名: {}", signature[:100] + "..." if len(signature) > 100 else signature)
            return signature
        
        logger.warning("未找到签名元素，选择器: {}", selector)
        return ""
    
    def _clean_signature_text(self, element) -> str:
        """
        清理签名文本，移除多余空格但保留换行
        
        Args:
            element: BeautifulSoup元素
            
        Returns:
            str: 清理后的签名
        """
        if not element:
            return ""
        
        # 获取原始文本，保留换行
        text = element.get_text()
        
        # 按行处理，移除每行的首尾空格，但保留行与行之间的换行
        lines = text.split('\n')
        cleaned_lines = []
        
        for line in lines:
            # 移除行首行尾的空格，但保留行内的必要空格
            cleaned_line = line.strip()
            if cleaned_line:
                # 移除多余的内部空格，但保留一个空格
                cleaned_line = re.sub(r'\s+', ' ', cleaned_line)
                cleaned_lines.append(cleaned_line)
        
        # 重新组合，保留换行结构
        if len(cleaned_lines) == 1:
            # 单行签名，直接返回
            return cleaned_lines[0]
        else:
            # 多行签名，保留换行
            return '\n'.join(cleaned_lines)
    
    def _extract_parent_class(self, section_elem=None) -> str:
        """
        提取父类信息
        
        Args:
            section_elem: 指定的section元素
            
        Returns:
            str: 父类名称
        """
        selector = self.html_parsing_config.get("parent_class_selector", "")
        if not selector:
            return ""
        
        search_scope = section_elem if section_elem else self.soup
        parent_elem = search_scope.select_one(selector)
        
        if parent_elem:
            parent_class = clean_whitespace(parent_elem.get_text())
            logger.debug("提取到父类: {}", parent_class)
            return parent_class
        
        logger.debug("未找到父类信息")
        return ""
    
    def _extract_short_description(self, section_elem=None) -> str:
        """
        提取简短描述 (shortdesc)
        
        Args:
            section_elem: 指定的section元素
            
        Returns:
            str: 简短描述
        """
        search_scope = section_elem if section_elem else self.soup
        
        # 查找shortdesc元素
        shortdesc_elem = search_scope.find(class_='shortdesc')
        if shortdesc_elem:
            desc_text = extract_text_content(shortdesc_elem)
            logger.debug("提取到简短描述: {}", desc_text[:100] + "..." if len(desc_text) > 100 else desc_text)
            return desc_text
        
        logger.debug("未找到简短描述")
        return ""
    
    def _extract_detailed_description(self, section_elem=None) -> str:
        """
        提取详细描述，排除since/deprecated信息
        
        Args:
            section_elem: 指定的section元素
            
        Returns:
            str: 详细描述
        """
        search_scope = section_elem if section_elem else self.soup
        
        # 查找详细描述section
        detailed_sections = [
            search_scope.find('section', id=lambda x: x and '__detailed_desc' in x),
            search_scope.find('section', class_='detailed_desc'),
            search_scope.find(class_='detailed_desc')
        ]
        
        for section in detailed_sections:
            if section:
                # 创建section的副本，避免修改原始DOM
                section_copy = copy.copy(section)
                
                # 移除since/deprecated信息
                since_elements = section_copy.find_all('dl', class_='since')
                for since_elem in since_elements:
                    since_elem.decompose()
                
                deprecated_elements = section_copy.find_all('dl', class_='deprecated')
                for deprecated_elem in deprecated_elements:
                    deprecated_elem.decompose()
                
                # 移除note元素，避免重复提取到@note中
                note_selectors = [
                    '.note.attention',
                    '.note_attention', 
                    '.note.note',
                    '.note_note'
                ]
                for selector in note_selectors:
                    note_elements = section_copy.select(selector)
                    for note_elem in note_elements:
                        note_elem.decompose()
                
                # 移除标题元素
                title_elem = section_copy.find(['h1', 'h2', 'h3', 'h4', 'h5', 'h6'])
                if title_elem:
                    title_elem.decompose()
                
                # 使用多行提取保留列表结构
                from ..utils.text_utils import extract_multiline_content
                desc_text = extract_multiline_content(section_copy)
                
                # 移除可能残留的"Details"标题文本
                if desc_text and desc_text.startswith("Details"):
                    desc_text = desc_text[7:].strip()  # 移除"Details"并清理空白
                
                if desc_text:
                    logger.debug("提取到详细描述（已排除since/deprecated和标题）")
                    return desc_text
        
        logger.debug("未找到详细描述")
        return ""
    
    def _extract_parameters(self, section_elem=None) -> List[Dict[str, str]]:
        """
        提取参数信息
        
        Args:
            section_elem: 指定的section元素
            
        Returns:
            List[Dict]: 参数信息列表
        """
        search_scope = section_elem if section_elem else self.soup
        
        # 查找参数section
        params_section = search_scope.find('section', id=lambda x: x and '__parameters' in x)
        if not params_section:
            return []
        
        parameters = []
        
        # 查找所有dl元素中的参数（可能有多个dl标签）
        dl_elements = params_section.find_all('dl', class_='parml')
        logger.debug("找到 {} 个参数dl元素", len(dl_elements))
        
        for dl_elem in dl_elements:
            # 每个参数由dt和dd组成 - 只查找直接子dt，避免包含嵌套dt
            dt_elements = dl_elem.find_all('dt', class_='dlterm', recursive=False)
            logger.debug("当前dl中找到 {} 个参数dt元素", len(dt_elements))
            
            for dt in dt_elements:
                param_name = clean_whitespace(dt.get_text())
                
                # 查找对应的dd元素
                dd = dt.find_next_sibling('dd', class_='pd')
                param_desc = ""
                if dd:
                    # 使用多行提取保留列表结构
                    from ..utils.text_utils import extract_multiline_content
                    param_desc = extract_multiline_content(dd)
                
                if param_name:
                    parameters.append({
                        'name': param_name,
                        'description': param_desc
                    })
                    logger.debug("提取参数: {}", param_name)
        
        logger.debug("提取到 {} 个参数", len(parameters))
        return parameters
    
    def _extract_return_info(self, section_elem=None) -> str:
        """
        提取返回值信息
        
        Args:
            section_elem: 指定的section元素
            
        Returns:
            str: 返回值信息
        """
        search_scope = section_elem if section_elem else self.soup
        
        # 查找返回值section
        return_section = search_scope.find('section', id=lambda x: x and '__return_values' in x)
        if return_section:
            # 使用多行提取保留列表结构
            from ..utils.text_utils import extract_multiline_content
            return_text = extract_multiline_content(return_section)
            # 移除标题部分
            if return_text.startswith('Returns'):
                return_text = return_text[7:].strip()
            logger.debug("提取到返回值信息")
            return return_text
        
        logger.debug("未找到返回值信息")
        return ""
    
    def _extract_notes(self, section_elem=None) -> str:
        """
        提取注意事项
        
        Args:
            section_elem: 指定的section元素
            
        Returns:
            str: 注意事项
        """
        search_scope = section_elem if section_elem else self.soup
        
        notes = []
        
        # 查找各种注意事项的标签
        note_selectors = [
            '.note.attention',
            '.note_attention', 
            '.note.note',
            '.note_note'
        ]
        
        for selector in note_selectors:
            note_elements = search_scope.select(selector)
            for note_elem in note_elements:
                # 使用多行提取保留列表结构
                from ..utils.text_utils import extract_multiline_content
                note_text = extract_multiline_content(note_elem)
                if note_text and note_text not in notes:
                    notes.append(note_text)
        
        result = '\n'.join(notes)
        if result:
            logger.debug("提取到注意事项")
        
        return result
    
    def _get_file_name(self) -> str:
        """
        获取当前解析的文件名
        
        Returns:
            str: 文件名
        """
        return Path(self.file_path).name if self.file_path else ""
