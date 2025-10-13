# -*- coding: utf-8 -*-
"""
注释格式化处理器
在JSON生成后对注释进行格式化处理，包括行长度限制等
"""

from typing import Dict, List, Any
from loguru import logger

from ..utils.text_utils import _wrap_comment_line


class CommentFormatter:
    """注释格式化处理器，负责对生成的JSON注释进行后处理"""
    
    def __init__(self, max_line_length: int = 100):
        """
        初始化格式化处理器
        
        Args:
            max_line_length: 最大行长度
        """
        self.max_line_length = max_line_length
        logger.debug("初始化注释格式化处理器，最大行长度: {}", max_line_length)
    
    def format_extracted_data(self, data: Dict[str, Any]) -> Dict[str, Any]:
        """
        格式化提取的数据，对所有注释应用行长度限制
        
        Args:
            data: 提取的原始数据
            
        Returns:
            Dict: 格式化后的数据
        """
        logger.debug("开始格式化提取的数据")
        
        formatted_data = data.copy()
        
        # 处理API注释
        if 'api' in formatted_data:
            for api in formatted_data['api']:
                if 'comment' in api:
                    api['comment'] = self._format_comment_lines(api['comment'])
        
        # 处理Class注释
        if 'class' in formatted_data:
            for class_item in formatted_data['class']:
                if 'class_comment' in class_item:
                    for comment_item in class_item['class_comment']:
                        if 'comment' in comment_item:
                            comment_item['comment'] = self._format_comment_lines(comment_item['comment'])
        
        # 处理Enum注释
        if 'enum' in formatted_data:
            for enum_item in formatted_data['enum']:
                if 'enum_comment' in enum_item:
                    for comment_item in enum_item['enum_comment']:
                        if 'comment' in comment_item:
                            comment_item['comment'] = self._format_comment_lines(comment_item['comment'])
        
        logger.debug("注释格式化完成")
        return formatted_data
    
    def _format_comment_lines(self, comment_lines: List[str]) -> List[str]:
        """
        格式化注释行，应用行长度限制
        
        Args:
            comment_lines: 原始注释行列表
            
        Returns:
            List[str]: 格式化后的注释行列表
        """
        if not comment_lines:
            return comment_lines
        
        formatted_lines = []
        
        for line in comment_lines:
            # 检查行长度
            if len(line) <= self.max_line_length:
                # 行长度符合要求，直接添加
                formatted_lines.append(line)
            else:
                # 行长度超限，需要换行处理
                if line.strip() in ['/**', '*/'] or line.strip() == '*':
                    # 注释边界行和空行，直接添加
                    formatted_lines.append(line)
                else:
                    # 提取前缀和内容
                    prefix, content = self._extract_line_prefix_and_content(line)
                    if content:
                        # 对内容进行换行处理
                        wrapped_lines = _wrap_comment_line(content, prefix, self.max_line_length)
                        formatted_lines.extend(wrapped_lines)
                    else:
                        # 没有内容，直接添加
                        formatted_lines.append(line)
        
        return formatted_lines
    
    def _extract_line_prefix_and_content(self, line: str) -> tuple:
        """
        从注释行中提取前缀和内容
        
        Args:
            line: 注释行
            
        Returns:
            tuple: (前缀, 内容)
        """
        # 常见的注释行格式：
        # " * @brief Some content"
        # " * Some content"
        # " *"
        
        stripped = line.lstrip()
        if stripped.startswith('* '):
            # 标准注释行
            indent = line[:len(line) - len(stripped)]  # 提取缩进
            prefix = indent + '* '
            content = stripped[2:]  # 去掉 "* "
            return prefix, content
        elif stripped == '*':
            # 空注释行
            return line, ''
        else:
            # 其他格式，尝试智能识别
            if ' * ' in line:
                parts = line.split(' * ', 1)
                prefix = parts[0] + ' * '
                content = parts[1] if len(parts) > 1 else ''
                return prefix, content
            else:
                # 无法识别格式，返回原行
                return line, ''
    
    def format_single_comment(self, comment_lines: List[str]) -> List[str]:
        """
        格式化单个注释块（用于注入时的实时格式化）
        
        Args:
            comment_lines: 注释行列表
            
        Returns:
            List[str]: 格式化后的注释行列表
        """
        return self._format_comment_lines(comment_lines)
