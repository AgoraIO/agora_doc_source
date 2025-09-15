# -*- coding: utf-8 -*-
"""
文本处理工具模块
"""

import re
import html
from typing import List, Dict, Any
from bs4 import BeautifulSoup, Tag, NavigableString
from loguru import logger


def unescape_html_entities(text: str) -> str:
    """
    还原HTML转义字符
    
    Args:
        text: 包含HTML转义字符的文本
        
    Returns:
        str: 还原后的文本
    """
    if not text:
        return text
        
    # 处理常见的HTML转义字符
    text = html.unescape(text)
    
    # 处理一些特殊的转义字符
    replacements = {
        '&lt;': '<',
        '&gt;': '>',
        '&quot;': '"',
        '&apos;': "'",
        '&amp;': '&'
    }
    
    for escaped, unescaped in replacements.items():
        text = text.replace(escaped, unescaped)
    
    return text


def clean_whitespace(text: str) -> str:
    """
    清理多余的空白字符
    
    Args:
        text: 原始文本
        
    Returns:
        str: 清理后的文本
    """
    if not text:
        return text
        
    # 移除行首行尾空白
    text = text.strip()
    
    # 将多个连续空白字符替换为单个空格
    text = re.sub(r'\s+', ' ', text)
    
    return text


def _smart_add_spaces(element, text: str) -> str:
    """
    智能添加空格，避免句末出现多余空格
    
    Args:
        element: HTML元素
        text: 元素文本内容
        
    Returns:
        str: 处理后的文本
    """
    # 获取前后的兄弟节点
    prev_sibling = element.previous_sibling
    next_sibling = element.next_sibling
    
    # 决定是否需要前置空格
    need_leading_space = (prev_sibling is not None and 
                         str(prev_sibling).strip() and 
                         not str(prev_sibling).endswith(' '))
    
    # 决定是否需要后置空格
    need_trailing_space = (next_sibling is not None and 
                          str(next_sibling).strip() and 
                          not str(next_sibling).startswith(' ') and
                          not str(next_sibling).startswith('.') and
                          not str(next_sibling).startswith(',') and
                          not str(next_sibling).startswith(';') and
                          not str(next_sibling).startswith(':'))
    
    # 构建结果
    result = text
    if need_leading_space:
        result = f" {result}"
    if need_trailing_space:
        result = f"{result} "
    
    return result


def convert_html_to_markdown(element, indent_level: int = 0) -> str:
    """
    将HTML元素转换为Markdown格式
    
    Args:
        element: BeautifulSoup元素
        indent_level: 嵌套缩进级别
        
    Returns:
        str: Markdown格式的文本
    """
    if isinstance(element, NavigableString):
        return str(element)
    
    if not isinstance(element, Tag):
        return str(element)
    
    text = ""
    tag_name = element.name.lower()
    
    if tag_name == 'ul':
        # 无序列表，支持嵌套缩进
        for li in element.find_all('li', recursive=False):
            item_text = convert_html_to_markdown(li, indent_level)
            if item_text.strip():
                indent = "  " * indent_level  # 每级缩进2个空格
                text += f"{indent}- {item_text.strip()}\n"
    elif tag_name == 'ol':
        # 有序列表，支持嵌套缩进
        for i, li in enumerate(element.find_all('li', recursive=False), 1):
            item_text = convert_html_to_markdown(li, indent_level + 1)
            if item_text.strip():
                indent = "  " * indent_level  # 每级缩进2个空格
                text += f"{indent}{i}. {item_text.strip()}\n"
    elif tag_name == 'li':
        # 列表项，需要特殊处理嵌套ul
        for child in element.children:
            if hasattr(child, 'name') and child.name == 'ul':
                # 嵌套ul需要换行和增加缩进
                text += '\n' + convert_html_to_markdown(child, indent_level + 1)
            else:
                text += convert_html_to_markdown(child, indent_level)
    elif tag_name == 'code' or (tag_name == 'span' and 'codeph' in element.get('class', [])):
        # 行内代码
        code_text = element.get_text()
        text = f"`{code_text}`"
    elif tag_name == 'pre':
        # 代码块
        code_text = element.get_text()
        text = f"```\n{code_text}\n```"
    elif tag_name in ['strong', 'b']:
        # 粗体
        inner_text = ''.join(convert_html_to_markdown(child, indent_level) for child in element.children)
        text = f"**{inner_text}**"
    elif tag_name in ['em', 'i']:
        # 斜体
        inner_text = ''.join(convert_html_to_markdown(child, indent_level) for child in element.children)
        text = f"*{inner_text}*"
    elif tag_name == 'br':
        # 换行
        text = "\n"
    elif tag_name == 'p':
        # 段落
        inner_text = ''.join(convert_html_to_markdown(child, indent_level) for child in element.children)
        text = f"{inner_text.strip()}\n\n"
    elif tag_name == 'div' and 'ul' in str(element):
        # 包含ul的div，需要特殊处理确保列表前有换行
        inner_text = ""
        for child in element.children:
            if hasattr(child, 'name') and child.name == 'ul':
                # ul前加换行
                if inner_text and not inner_text.endswith('\n'):
                    inner_text += '\n'
            inner_text += convert_html_to_markdown(child, indent_level)
        text = inner_text
    elif tag_name == 'a' and 'xref' in element.get('class', []):
        # 交叉引用链接，转换为markdown代码格式
        link_text = element.get_text()
        code_text = f"`{link_text}`"
        text = _smart_add_spaces(element, code_text)
    elif tag_name == 'span':
        # span标签特殊处理
        classes = element.get('class', [])
        if 'ph' in classes or 'keyword' in classes or 'apiname' in classes:
            if 'keyword' in classes or 'apiname' in classes:
                # 对于keyword和apiname，转换为markdown代码格式
                span_text = element.get_text()
                code_text = f"`{span_text}`"
                text = _smart_add_spaces(element, code_text)
            else:
                # ph标签需要递归处理子元素，保持内部HTML结构转换
                inner_text = ''.join(convert_html_to_markdown(child, indent_level) for child in element.children)
                text = _smart_add_spaces(element, inner_text)
        else:
            # 普通span，直接处理子元素
            for child in element.children:
                text += convert_html_to_markdown(child, indent_level)
    elif tag_name in ['div']:
        # 通用容器
        for child in element.children:
            text += convert_html_to_markdown(child, indent_level)
    else:
        # 其他标签，需要智能处理ul前的换行
        prev_child = None
        for child in element.children:
            child_text = convert_html_to_markdown(child, indent_level)
            
            # 如果当前子元素是ul/ol，且前面有文本内容，需要添加换行
            if (hasattr(child, 'name') and child.name in ['ul', 'ol'] and 
                prev_child is not None and text.strip() and 
                not text.endswith('\n')):
                text += '\n'
            
            text += child_text
            prev_child = child
    
    return text


def extract_text_content(element) -> str:
    """
    提取元素的纯文本内容，处理HTML标签
    
    Args:
        element: BeautifulSoup元素
        
    Returns:
        str: 纯文本内容（单行，不包含\n字符）
    """
    if not element:
        return ""
    
    # 先转换为Markdown格式，然后清理
    markdown_text = convert_html_to_markdown(element)
    
    # 清理多余的换行和空白，最终合并为单行
    lines = markdown_text.split('\n')
    cleaned_lines = []
    
    for line in lines:
        cleaned_line = clean_whitespace(line)
        if cleaned_line:  # 只保留非空行
            cleaned_lines.append(cleaned_line)
    
    # 用空格连接所有行，避免\n出现在最终结果中
    result = ' '.join(cleaned_lines)
    return unescape_html_entities(result)


def extract_multiline_content(element) -> str:
    """
    提取元素的多行内容，用于注释构建
    
    Args:
        element: BeautifulSoup元素
        
    Returns:
        str: 多行文本内容（保留换行结构）
    """
    if not element:
        return ""
    
    # 先转换为Markdown格式，然后清理
    markdown_text = convert_html_to_markdown(element)
    
    # 清理多余的换行和空白，但保留必要的换行和缩进
    lines = markdown_text.split('\n')
    cleaned_lines = []
    
    for line in lines:
        # 对于多行内容，保留行首缩进，只清理行尾和内部多余空格
        if line.strip():  # 只处理非空行
            # 保留行首空格（缩进），只清理行尾和压缩内部多余空格
            leading_spaces = len(line) - len(line.lstrip())
            content_part = line.lstrip()
            cleaned_content = clean_whitespace(content_part)
            cleaned_line = ' ' * leading_spaces + cleaned_content
            cleaned_lines.append(cleaned_line)
    
    result = '\n'.join(cleaned_lines)
    return unescape_html_entities(result)


def format_comment_lines(content: str, prefix: str = " * ", max_line_length: int = 100) -> List[str]:
    """
    将文本内容格式化为注释行，支持行长度限制
    
    Args:
        content: 文本内容
        prefix: 每行的前缀
        max_line_length: 最大行长度
        
    Returns:
        List[str]: 格式化后的注释行列表
    """
    if not content:
        return []
    
    lines = content.split('\n')
    comment_lines = []
    
    for line in lines:
        if line.strip():
            # 应用行长度限制
            wrapped_lines = _wrap_comment_line(line.strip(), prefix, max_line_length)
            comment_lines.extend(wrapped_lines)
        else:
            comment_lines.append(f"{prefix}")
    
    return comment_lines


def _wrap_comment_line(text: str, prefix: str = " * ", max_line_length: int = 100) -> List[str]:
    """
    将单行文本按照指定长度换行，保持单词完整性
    
    Args:
        text: 要换行的文本
        prefix: 每行的前缀
        max_line_length: 最大行长度
        
    Returns:
        List[str]: 换行后的行列表
    """
    if not text:
        return [prefix]
    
    # 如果当前行（包含前缀）不超过限制，直接返回
    full_line = f"{prefix}{text}"
    if len(full_line) <= max_line_length:
        return [full_line]
    
    # 需要换行处理
    result_lines = []
    remaining_text = text
    
    while remaining_text:
        # 计算当前行可用的文本宽度
        available_width = max_line_length - len(prefix)
        
        if len(remaining_text) <= available_width:
            # 剩余文本可以放在一行内
            result_lines.append(f"{prefix}{remaining_text}")
            break
        
        # 找到合适的断行点
        break_point = _find_line_break_point(remaining_text, available_width)
        
        if break_point <= 0:
            # 无法找到合适的断行点，强制在可用宽度处断行
            break_point = available_width
        
        # 添加当前行
        current_line_text = remaining_text[:break_point].rstrip()
        result_lines.append(f"{prefix}{current_line_text}")
        
        # 更新剩余文本
        remaining_text = remaining_text[break_point:].lstrip()
    
    return result_lines


def _find_line_break_point(text: str, max_width: int) -> int:
    """
    在指定宽度内找到最佳的断行点
    
    Args:
        text: 文本
        max_width: 最大宽度
        
    Returns:
        int: 断行点位置
    """
    if len(text) <= max_width:
        return len(text)
    
    # 在最大宽度内寻找最后一个空格
    for i in range(max_width, 0, -1):
        if text[i] == ' ':
            return i
    
    # 如果没有空格，寻找标点符号
    for i in range(max_width, 0, -1):
        if text[i] in '.,;:!?':
            return i + 1
    
    # 如果没有标点符号，寻找连字符
    for i in range(max_width, 0, -1):
        if text[i] == '-':
            return i + 1
    
    # 如果都没有找到，返回0表示无法在此处断行
    return 0


def extract_parameter_info(param_element) -> Dict[str, str]:
    """
    从参数元素中提取参数信息
    
    Args:
        param_element: 参数的BeautifulSoup元素
        
    Returns:
        Dict: 包含参数名和描述的字典
    """
    param_info = {}
    
    # 查找参数名
    dt_elem = param_element.find('dt', class_='pt dlterm')
    if dt_elem:
        param_info['name'] = clean_whitespace(dt_elem.get_text())
    
    # 查找参数描述
    dd_elem = param_element.find('dd', class_='pd')
    if dd_elem:
        param_info['description'] = extract_text_content(dd_elem)
    
    return param_info


def build_comment_block(content_dict: Dict[str, Any], max_line_length: int = 100) -> List[str]:
    """
    根据内容字典构建完整的注释块，支持行长度限制
    
    Args:
        content_dict: 包含各种注释内容的字典
        max_line_length: 最大行长度
        
    Returns:
        List[str]: 完整的注释行列表
    """
    comment_lines = ["/**"]
    
    # 检查是否有@brief之后的其他内容
    has_content_after_brief = any(content_dict.get(key) for key in [
        'technical_preview', 'preserved_since', 'preserved_deprecated', 
        'details', 'note', 'parameters', 'return', 'throws'
    ])
    
    # @brief
    if content_dict.get('brief'):
        brief_text = f"@brief {content_dict['brief']}"
        wrapped_lines = _wrap_comment_line(brief_text, " * ", max_line_length)
        comment_lines.extend(wrapped_lines)
        # 只有当后面还有其他内容时才添加空行
        if has_content_after_brief:
            comment_lines.append(" *")
    
    # technical preview (如果存在)
    if content_dict.get('technical_preview'):
        comment_lines.append(" * @technical preview")
    
    # 保留的since和deprecated信息
    if content_dict.get('preserved_since'):
        since_lines = _wrap_comment_line(content_dict['preserved_since'], " * ", max_line_length)
        comment_lines.extend(since_lines)
    
    if content_dict.get('preserved_deprecated'):
        deprecated_lines = _wrap_comment_line(content_dict['preserved_deprecated'], " * ", max_line_length)
        comment_lines.extend(deprecated_lines)
    
    # 如果有技术预览或版本信息，添加空行
    if any(content_dict.get(key) for key in ['technical_preview', 'preserved_since', 'preserved_deprecated']):
        comment_lines.append(" *")
    
    # @details
    if content_dict.get('details'):
        comment_lines.append(" * @details")
        detail_lines = format_comment_lines(content_dict['details'], " * ", max_line_length)
        comment_lines.extend(detail_lines)
        comment_lines.append(" *")
    
    # @note
    if content_dict.get('note'):
        comment_lines.append(" * @note")
        note_lines = format_comment_lines(content_dict['note'], " * ", max_line_length)
        comment_lines.extend(note_lines)
        comment_lines.append(" *")
    
    # 参数
    if content_dict.get('parameters'):
        for param in content_dict['parameters']:
            if isinstance(param, dict) and 'name' in param:
                if param.get('description'):
                    param_text = f"@param {param['name']} {param['description']}"
                    param_lines = _wrap_comment_line(param_text, " * ", max_line_length)
                    comment_lines.extend(param_lines)
                else:
                    comment_lines.append(f" * @param {param['name']}")
        comment_lines.append(" *")
    
    # @return
    if content_dict.get('return'):
        comment_lines.append(" * @return")
        return_lines = format_comment_lines(content_dict['return'], " * ", max_line_length)
        comment_lines.extend(return_lines)
    
    # @throws (Java)
    if content_dict.get('throws'):
        comment_lines.append(" * @throws")
        throws_lines = format_comment_lines(content_dict['throws'], " * ", max_line_length)
        comment_lines.extend(throws_lines)
    
    comment_lines.append(" */")
    return comment_lines
