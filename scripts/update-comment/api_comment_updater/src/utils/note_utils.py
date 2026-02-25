#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Note处理工具模块
统一处理API、Class、Enum中的note内容格式化
"""

import re
from typing import List, Union
from bs4 import BeautifulSoup, Tag
from loguru import logger


def format_notes_content(notes: Union[str, List[str]]) -> str:
    """
    统一格式化note内容
    
    Args:
        notes: note内容，可以是字符串或字符串列表
        
    Returns:
        str: 格式化后的note内容
    """
    if not notes:
        return ""
    
    # 确保notes是列表
    if isinstance(notes, str):
        notes = [notes]
    
    processed_notes = []
    
    for note in notes:
        if not note or not note.strip():
            continue
            
        # 移除note标题
        cleaned_note = _remove_note_titles(note.strip())
        if cleaned_note:
            processed_notes.append(cleaned_note)
    
    if not processed_notes:
        return ""
    
    # 判断是否需要换行
    needs_newline = _should_use_newline(processed_notes)
    
    if needs_newline:
        # 多行格式：@note 换行显示
        result_lines = ["@note"]
        for note in processed_notes:
            # 先处理literal \n字符串，将\\n替换为真正的换行符
            note_content = note.replace('\\n', '\n')
            note_lines = note_content.split('\n')
            for line in note_lines:
                if line.strip():
                    # 保留原始缩进信息
                    leading_spaces = len(line) - len(line.lstrip())
                    content = line.strip()
                    
                    # 检查是否是列表项
                    if content.startswith(('- ', '* ', '+ ', '1. ', '2. ', '3. ', '4. ', '5. ', '6. ', '7. ', '8. ', '9. ')):
                        # 对于列表项，保留原始缩进（转换为注释缩进）
                        # 原始缩进0 -> ' * ', 原始缩进2 -> ' *   ', 原始缩进4 -> ' *     '
                        indent_spaces = ' ' * leading_spaces
                        result_lines.append(f" *{indent_spaces} {content}")
                    else:
                        # 对于普通文本，使用基本缩进
                        result_lines.append(f" * {content}")
        return '\n'.join(result_lines)
    else:
        # 单行格式：@note 直接跟内容
        combined_note = ' '.join(processed_notes)
        return f"@note {combined_note}"


def _remove_note_titles(text: str) -> str:
    """
    移除note中的标题
    
    Args:
        text: 原始text
        
    Returns:
        str: 移除标题后的text
    """
    # 支持的标题模式（英文和中文）
    title_patterns = [
        r'^Note:\s*',
        r'^Attention:\s*', 
        r'^Warning:\s*',
        r'^Caution:\s*',
        r'^Important:\s*',
        r'^Tip:\s*',
        r'^注意：\s*',
        r'^警告：\s*',
        r'^提示：\s*',
        r'^重要：\s*'
    ]
    
    result = text
    for pattern in title_patterns:
        result = re.sub(pattern, '', result, flags=re.IGNORECASE | re.MULTILINE)
    
    return result.strip()


def _should_use_newline(notes: List[str]) -> bool:
    """
    判断是否需要换行显示
    
    Args:
        notes: note列表
        
    Returns:
        bool: 是否需要换行
    """
    # 条件1: 多条note
    if len(notes) > 1:
        return True
    
    # 条件2: 单条note但包含多个段落或列表
    if len(notes) == 1:
        note = notes[0]
        
        # 先处理literal \n字符串
        processed_note = note.replace('\\n', '\n')
        
        # 检查是否包含换行（说明需要分行显示）
        if '\n' in processed_note:
            return True
            
        # 检查是否包含多个段落（多个\n\n或多个<p>标签的痕迹）
        if '\n\n' in processed_note or processed_note.count('\n') > 2:
            return True
            
        # 检查是否包含列表结构
        if _contains_list_structure(processed_note):
            return True
    
    return False


def _contains_list_structure(text: str) -> bool:
    """
    检查文本是否包含列表结构
    
    Args:
        text: 待检查的文本
        
    Returns:
        bool: 是否包含列表结构
    """
    # 检查是否包含列表项标记
    list_patterns = [
        r'^\s*[-*+]\s+',  # - item, * item, + item
        r'^\s*\d+\.\s+',  # 1. item, 2. item
        r'^\s*[a-zA-Z]\.\s+',  # a. item, b. item
        r'^\s*[ivxlcdm]+\.\s+',  # i. item, ii. item (roman)
    ]
    
    lines = text.split('\n')
    list_count = 0
    
    for line in lines:
        for pattern in list_patterns:
            if re.match(pattern, line, re.IGNORECASE):
                list_count += 1
                break
    
    # 如果有2个或以上的列表项，认为是列表结构
    return list_count >= 2


def extract_notes_from_html(soup_element: Union[BeautifulSoup, Tag], 
                           exclude_sections: List[Union[BeautifulSoup, Tag]] = None) -> List[str]:
    """
    从HTML元素中提取note内容
    
    Args:
        soup_element: BeautifulSoup元素
        exclude_sections: 要排除的section列表
        
    Returns:
        List[str]: 提取到的note列表
    """
    if exclude_sections is None:
        exclude_sections = []
    
    notes = []
    
    # note选择器
    note_selectors = [
        '.note.attention',
        '.note_attention', 
        '.note.note',
        '.note_note'
    ]
    
    for selector in note_selectors:
        note_elements = soup_element.select(selector)
        for note_elem in note_elements:
            # 检查是否在排除的section中
            should_exclude = False
            for exclude_section in exclude_sections:
                if exclude_section and exclude_section.find(lambda tag: tag == note_elem):
                    should_exclude = True
                    break
            
            if should_exclude:
                continue
            
            # 提取note内容
            from .text_utils import extract_multiline_content
            note_text = extract_multiline_content(note_elem)
            if note_text and note_text not in notes:
                notes.append(note_text)
    
    return notes


def extract_notes_from_dd(dd_element: Tag) -> str:
    """
    从dd元素中提取note内容（用于属性和枚举值）
    
    Args:
        dd_element: BeautifulSoup dd元素
        
    Returns:
        str: 提取到的note内容
    """
    if not dd_element:
        return ""
    
    # 查找note元素
    note_selectors = ['.note.attention', '.note_attention', '.note.note', '.note_note']
    notes = []
    
    for selector in note_selectors:
        note_elements = dd_element.select(selector)
        for note_elem in note_elements:
            from .text_utils import extract_multiline_content
            note_text = extract_multiline_content(note_elem)
            if note_text and note_text not in notes:
                notes.append(note_text)
    
    return format_notes_content(notes)
