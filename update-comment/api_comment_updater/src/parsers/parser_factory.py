# -*- coding: utf-8 -*-
"""
HTML解析器工厂类
"""

from pathlib import Path
from typing import Dict, Any
from loguru import logger

from .toc_parser import TocHTMLParser
from .class_parser import ClassHTMLParser  
from .enum_parser import EnumHTMLParser


class HTMLParserFactory:
    """HTML解析器工厂类"""
    
    @staticmethod
    def create_parser(html_file_path: str, platform_config: Dict[str, Any]):
        """
        根据HTML文件类型创建对应的解析器
        
        Args:
            html_file_path: HTML文件路径
            platform_config: 平台配置信息
            
        Returns:
            BaseHTMLParser: 对应的解析器实例
            
        Raises:
            ValueError: 不支持的HTML文件类型
        """
        filename = Path(html_file_path).name.lower()
        
        if filename.startswith("toc_"):
            logger.debug("创建TOC解析器: {}", filename)
            return TocHTMLParser(platform_config)
        elif filename.startswith("class_"):
            logger.debug("创建Class解析器: {}", filename)
            return ClassHTMLParser(platform_config)
        elif filename.startswith("enum_"):
            logger.debug("创建Enum解析器: {}", filename)
            return EnumHTMLParser(platform_config)
        else:
            raise ValueError(f"不支持的HTML文件类型: {filename}")
    
    @staticmethod
    def get_html_type(html_file_path: str) -> str:
        """
        获取HTML文件的类型
        
        Args:
            html_file_path: HTML文件路径
            
        Returns:
            str: 文件类型 ("toc", "class", "enum")
            
        Raises:
            ValueError: 不支持的HTML文件类型
        """
        filename = Path(html_file_path).name.lower()
        
        if filename.startswith("toc_"):
            return "toc"
        elif filename.startswith("class_"):
            return "class"
        elif filename.startswith("enum_"):
            return "enum"
        else:
            raise ValueError(f"不支持的HTML文件类型: {filename}")
    
    @staticmethod
    def is_supported_html_file(html_file_path: str) -> bool:
        """
        检查是否为支持的HTML文件类型
        
        Args:
            html_file_path: HTML文件路径
            
        Returns:
            bool: 是否支持
        """
        try:
            HTMLParserFactory.get_html_type(html_file_path)
            return True
        except ValueError:
            return False
