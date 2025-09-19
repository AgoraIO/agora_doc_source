# -*- coding: utf-8 -*-
"""
TOC HTML文件解析器
用于解析toc_xxx.html文件，提取API信息
"""

from typing import Dict, List, Any
from loguru import logger

from .html_parser import BaseHTMLParser
from ..utils.text_utils import extract_multiline_content
from ..utils.text_utils import build_comment_block


class TocHTMLParser(BaseHTMLParser):
    """TOC HTML文件解析器"""
    
    def _extract_data(self) -> Dict[str, Any]:
        """
        从TOC HTML文件中提取API数据
        
        Returns:
            Dict: 包含API列表的数据
        """
        result = {
            "type": "toc",
            "file": self._get_file_name(),
            "apis": []
        }
        
        # 查找所有API section (nested1级别的article)
        api_sections = self.soup.find_all('article', {'class': 'topic reference nested1'})
        
        # 如果没有找到article，可能是片段HTML，尝试直接从body中提取
        if not api_sections:
            logger.debug("未找到article元素，尝试从文档片段中提取")
            # 检查是否有API相关的元素
            if self.soup.find('h2', class_='title topictitle2'):
                api_sections = [self.soup]  # 将整个文档作为一个section处理
        
        logger.debug("找到 {} 个API section", len(api_sections))
        
        for section in api_sections:
            try:
                api_data = self._extract_api_from_section(section)
                if api_data:
                    result["apis"].append(api_data)
            except Exception as e:
                logger.error("提取API信息时发生错误: {}", str(e))
                continue
        
        logger.info("从 {} 提取了 {} 个API", self._get_file_name(), len(result["apis"]))
        return result
    
    def _extract_api_from_section(self, section) -> Dict[str, Any]:
        """
        从section元素中提取单个API的信息
        
        Args:
            section: BeautifulSoup section元素
            
        Returns:
            Dict: API信息
        """
        api_data = {}
        
        # 提取API名称
        api_data["name"] = self._extract_name(section)
        if not api_data["name"]:
            logger.warning("跳过没有名称的API section")
            return None
        
        # 提取API签名
        api_data["signature"] = self._extract_signature(section)
        
        # 提取父类信息
        api_data["parent_class"] = self._extract_parent_class(section)
        
        # 提取文件名
        api_data["file"] = self._get_file_name()
        
        # 构建注释内容
        comment_content = self._build_comment_content(section)
        api_data["comment"] = self._build_api_comment_lines(comment_content)
        
        logger.debug("成功提取API: {}", api_data["name"])
        return api_data
    
    def _build_comment_content(self, section) -> Dict[str, Any]:
        """
        构建注释内容字典
        
        Args:
            section: BeautifulSoup section元素
            
        Returns:
            Dict: 注释内容字典
        """
        content = {}
        
        # 提取简短描述作为@brief
        brief = self._extract_short_description(section)
        if brief:
            content["brief"] = brief
        
        # 提取详细描述
        details = self._extract_detailed_description(section)
        
        # 收集其他信息到details
        additional_info = []
        
        # 提取适用场景 (Applicable scenarios)
        scenario_section = section.find('section', id=lambda x: x and '__scenario' in x)
        if scenario_section:
            scenario_text = self._extract_multiline_from_section(scenario_section, "Applicable scenarios")
            if scenario_text:
                additional_info.append(f"Applicable scenarios: {scenario_text}")
        
        # 提取调用时机 (Call timing)
        timing_section = section.find('section', id=lambda x: x and '__timing' in x)
        if timing_section:
            timing_text = self._extract_multiline_from_section(timing_section, "Call timing")
            if timing_text:
                additional_info.append(f"Call timing: {timing_text}")
        
        # 提取相关回调 (Related callbacks)
        related_section = section.find('section', id=lambda x: x and '__related' in x)
        if related_section:
            related_text = self._extract_multiline_from_section(related_section, "Related callbacks")
            if related_text:
                additional_info.append(f"Related callbacks: {related_text}")
        
        # 合并详细信息（不包括限制信息）
        if details:
            additional_info.insert(0, details)
        
        if additional_info:
            content["details"] = '\n\n'.join(additional_info)
        
        # 提取注意事项（包括限制信息和特定区域的notes）
        notes = self._extract_notes_for_api(section)
        if notes:
            content["note"] = notes
        
        # 提取参数信息
        parameters = self._extract_parameters(section)
        if parameters:
            content["parameters"] = parameters
        
        # 提取返回值信息（使用多行版本保留列表结构）
        return_section = section.find('section', id=lambda x: x and '__return_values' in x)
        if return_section:
            return_text = self._extract_multiline_from_section(return_section, "Returns")
            if return_text:
                content["return"] = return_text
        
        return content
    
    def _build_api_comment_lines(self, content: Dict[str, Any]) -> List[str]:
        """
        根据内容字典构建API注释行
        
        Args:
            content: 包含各种注释内容的字典
            
        Returns:
            List[str]: 完整的注释行列表
        """
        comment_lines = ["/**"]
        
        # 检查是否有@brief之后的其他内容
        has_content_after_brief = any(content.get(key) for key in [
            'details', 'note', 'parameters', 'return', 'throws'
        ])
        
        # @brief
        if content.get('brief'):
            comment_lines.append(f" * @brief {content['brief']}")
            # 只有当后面还有其他内容时才添加空行
            if has_content_after_brief:
                comment_lines.append(" *")
        
        # @details
        if content.get('details'):
            comment_lines.append(" * @details")
            # 使用多行内容，保留列表结构
            details_text = content['details']
            for line in details_text.split('\n'):
                if line.strip():
                    comment_lines.append(f" * {line}")
            comment_lines.append(" *")
        
        # @note (使用新的统一格式)
        if content.get('note'):
            note_content = content['note']
            
            # 检查note内容是否已经包含@note格式
            if note_content.startswith('@note '):
                # 单行格式：@note 内容
                comment_lines.append(f" * {note_content}")
            elif note_content.startswith('@note\n'):
                # 多行格式：@note\n * 内容
                note_lines = note_content.split('\n')
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
                # 兜底：使用旧格式
                comment_lines.append(" * @note")
                for line in note_content.split('\n'):
                    if line.strip():
                        comment_lines.append(f" * {line}")
            
            comment_lines.append(" *")
        
        # 参数
        if content.get('parameters'):
            for param in content['parameters']:
                if isinstance(param, dict) and 'name' in param:
                    param_desc = param.get('description', '')
                    if param_desc:
                        # 处理多行参数描述
                        desc_lines = param_desc.split('\n')
                        if len(desc_lines) == 1:
                            # 单行描述
                            comment_lines.append(f" * @param {param['name']} {param_desc}")
                        else:
                            # 多行描述，第一行包含参数名，后续行缩进
                            first_line = desc_lines[0].strip()
                            comment_lines.append(f" * @param {param['name']} {first_line}")
                            for line in desc_lines[1:]:
                                if line.strip():
                                    comment_lines.append(f" * {line}")
                    else:
                        comment_lines.append(f" * @param {param['name']}")
            comment_lines.append(" *")
        
        # @return
        if content.get('return'):
            comment_lines.append(" * @return")
            return_text = content['return']
            for line in return_text.split('\n'):
                if line.strip():
                    comment_lines.append(f" * {line}")
        
        comment_lines.append(" */")
        return comment_lines
    
    def _extract_multiline_from_section(self, section, title_to_remove: str = "") -> str:
        """
        从section中提取多行文本，保留列表结构
        
        Args:
            section: BeautifulSoup section元素
            title_to_remove: 要移除的标题文本
            
        Returns:
            str: 提取的多行文本
        """
        if not section:
            return ""
        
        # 移除标题元素
        title_elem = section.find(['h1', 'h2', 'h3', 'h4', 'h5', 'h6'])
        if title_elem:
            title_elem.decompose()
        
        # 使用多行内容提取
        text = extract_multiline_content(section)
        
        # 如果指定了标题，尝试移除
        if title_to_remove and text.startswith(title_to_remove):
            text = text[len(title_to_remove):].strip()
        
        return text
    
    def _extract_notes_for_api(self, section) -> str:
        """
        提取API的注意事项，包括限制信息和特定区域的notes
        
        Args:
            section: BeautifulSoup section元素
            
        Returns:
            str: 格式化后的note内容
        """
        from ..utils.note_utils import extract_notes_from_html, format_notes_content
        
        notes = []
        
        # 1. 提取限制信息 (Restrictions)
        restriction_section = section.find('section', id=lambda x: x and '__restriction' in x)
        if restriction_section:
            restriction_text = self._extract_multiline_from_section(restriction_section, "Restrictions")
            if restriction_text and restriction_text.lower() != "none.":
                notes.append(restriction_text)
        
        # 2. 提取详细描述中的notes
        detailed_desc_section = section.find('section', id=lambda x: x and '__detailed_desc' in x)
        if detailed_desc_section:
            detailed_notes = extract_notes_from_html(detailed_desc_section)
            notes.extend(detailed_notes)
        
        # 3. 提取其他特定区域的notes（排除参数区域和详细描述区域）
        params_section = section.find('section', id=lambda x: x and '__parameters' in x)
        exclude_sections = [params_section, detailed_desc_section]
        
        other_notes = extract_notes_from_html(section, exclude_sections)
        notes.extend(other_notes)
        
        # 使用统一的格式化逻辑
        return format_notes_content(notes)
    
    def _extract_text_from_section(self, section, title_to_remove: str = "") -> str:
        """
        从section中提取文本，移除标题
        
        Args:
            section: BeautifulSoup section元素
            title_to_remove: 要移除的标题文本
            
        Returns:
            str: 提取的文本
        """
        if not section:
            return ""
        
        # 移除标题元素
        title_elem = section.find(['h1', 'h2', 'h3', 'h4', 'h5', 'h6'])
        if title_elem:
            title_elem.decompose()
        
        # 提取剩余内容
        from ..utils.text_utils import extract_text_content
        text = extract_text_content(section)
        
        # 如果指定了标题，尝试移除
        if title_to_remove and text.startswith(title_to_remove):
            text = text[len(title_to_remove):].strip()
        
        return text
