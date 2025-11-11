# -*- coding: utf-8 -*-
"""
平台特定逻辑的基类
"""

from abc import ABC, abstractmethod
from typing import Dict, List, Any, Optional, Tuple
from loguru import logger

from ...utils.file_utils import find_files_by_patterns


class BaseLocator(ABC):
    """代码定位器基类"""
    
    def __init__(self, repo_config: Dict[str, Any], platform_config: Dict[str, Any]):
        """
        初始化代码定位器基类
        
        Args:
            repo_config: 代码仓库配置
            platform_config: 平台配置
        """
        self.repo_path = repo_config["repo_path"]
        self.platform = platform_config["platform"]
        self.search_patterns = platform_config.get("search_patterns", {})
        
        # 获取平台搜索路径
        platforms_config = repo_config.get("platforms", {})
        self.platform_paths = platforms_config.get(self.platform, {})
        
        logger.debug("初始化{}代码定位器: 仓库路径={}", self.platform, self.repo_path)
    
    def _get_search_files(self) -> List[str]:
        """
        获取搜索文件列表
        
        Returns:
            List[str]: 文件路径列表
        """
        if not hasattr(self, '_cached_search_files'):
            include_patterns = self.platform_paths.get("include", [])
            exclude_patterns = self.platform_paths.get("exclude", [])
            
            self._cached_search_files = find_files_by_patterns(
                self.repo_path, include_patterns, exclude_patterns
            )
            logger.debug("缓存搜索文件列表，共 {} 个文件", len(self._cached_search_files))
        
        return self._cached_search_files
    
    # 抽象方法 - 子类必须实现
    @abstractmethod
    def _clean_signature(self, signature: str) -> str:
        """清理签名，移除HTML标签和多余空白"""
        pass
    
    @abstractmethod
    def _is_attribute_definition_enhanced(self, line: str, attribute_name: str) -> bool:
        """增强的属性定义检测"""
        pass
    
    @abstractmethod
    def _is_enum_value_definition(self, line: str, value_name: str) -> bool:
        """判断是否为枚举值定义行"""
        pass
    
    @abstractmethod
    def _find_nearest_parent_class(self, lines: List[str], api_line_index: int) -> Optional[str]:
        """从指定位置向上搜索，找到最近的类声明"""
        pass
    
    @abstractmethod
    def _clean_code_line_for_matching(self, line: str) -> str:
        """清理代码行以便进行签名匹配"""
        pass


class BaseInjector(ABC):
    """注释注入器基类"""
    
    def __init__(self, repo_config: Dict[str, Any], platform_config: Dict[str, Any]):
        """
        初始化注释注入器基类
        
        Args:
            repo_config: 代码仓库配置
            platform_config: 平台配置
        """
        self.repo_config = repo_config
        self.platform_config = platform_config
        self.platform = platform_config["platform"]
        
        logger.debug("初始化{}注释注入器", self.platform)
    
    # 抽象方法 - 子类必须实现
    @abstractmethod
    def _find_existing_comment_start(self, lines: List[str], target_line: int) -> Optional[int]:
        """查找目标行前的现有注释块的开始位置"""
        pass
    
    @abstractmethod
    def _find_comment_end(self, lines: List[str], start_line: int) -> Optional[int]:
        """查找注释的结束位置"""
        pass
    
    @abstractmethod
    def _is_comment_line(self, line: str) -> bool:
        """判断是否为注释行"""
        pass
    
    # 通用工具方法
    def _get_line_indent(self, line: str) -> str:
        """
        获取行的缩进字符串
        
        Args:
            line: 代码行
            
        Returns:
            str: 缩进字符串（空格或制表符）
        """
        indent = ""
        for char in line:
            if char in [' ', '\t']:
                indent += char
            else:
                break
        return indent
