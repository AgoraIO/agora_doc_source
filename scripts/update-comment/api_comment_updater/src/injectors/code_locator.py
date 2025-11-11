# -*- coding: utf-8 -*-
"""
代码定位器 - 工厂模式入口
在代码仓库中精确定位API位置
"""

from typing import Dict, Any, Optional, Tuple
from loguru import logger


class CodeLocator:
    """代码定位器工厂，负责创建和委托到平台特定的定位器"""
    
    def __init__(self, repo_config: Dict[str, Any], platform_config: Dict[str, Any]):
        """
        初始化代码定位器工厂
        
        Args:
            repo_config: 代码仓库配置
            platform_config: 平台配置
        """
        self.platform = platform_config["platform"]
        self._locator = self._create_platform_locator(repo_config, platform_config)
        
        logger.debug("初始化代码定位器工厂: 平台={}", self.platform)
    
    def _create_platform_locator(self, repo_config: Dict[str, Any], platform_config: Dict[str, Any]):
        """
        根据平台创建对应的定位器
        
        Args:
            repo_config: 代码仓库配置
            platform_config: 平台配置
            
        Returns:
            平台特定的定位器实例
        """
        if self.platform == "cpp-ng":
            from .platforms.cpp_locator import CppLocator
            return CppLocator(repo_config, platform_config)
        elif self.platform in ["android-ng", "java-ng"]:
            from .platforms.java_locator import JavaLocator
            return JavaLocator(repo_config, platform_config)
        elif self.platform in ["ios-ng", "oc-ng"]:
            from .platforms.oc_locator import OcLocator
            return OcLocator(repo_config, platform_config)
        elif self.platform in ["mac-ng", "oc-ng"]:
            from .platforms.oc_locator import OcLocator
            return OcLocator(repo_config, platform_config)
        else:
            raise ValueError(f"Unsupported platform: {self.platform}")
    
    # ==================== 委托方法 ====================
    # 所有方法都委托到具体的平台实现
    
    def locate_api(self, api_data: Dict[str, Any]) -> Optional[Tuple[str, int]]:
        """
        定位API在代码中的位置
        
        Args:
            api_data: API数据，包含name、signature、parent_class等信息
            
        Returns:
            Tuple[str, int]: (文件路径, 行号)，如果未找到返回None
        """
        return self._locator.locate_api(api_data)
    
    def locate_class(self, class_data: Dict[str, Any]) -> Optional[Tuple[str, int]]:
        """
        定位类在代码中的位置
        
        Args:
            class_data: 类数据
            
        Returns:
            Tuple[str, int]: (文件路径, 行号)，如果未找到返回None
        """
        return self._locator.locate_class(class_data)
    
    def locate_enum(self, enum_data: Dict[str, Any]) -> Optional[Tuple[str, int]]:
        """
        定位枚举在代码中的位置
        
        Args:
            enum_data: 枚举数据
            
        Returns:
            Tuple[str, int]: (文件路径, 行号)，如果未找到返回None
        """
        return self._locator.locate_enum(enum_data)
    
    def locate_class_attribute(self, class_data: Dict[str, Any], attribute_name: str) -> Optional[Tuple[str, int]]:
        """
        定位类属性在代码中的位置
        
        Args:
            class_data: 类数据
            attribute_name: 属性名称
            
        Returns:
            Tuple[str, int]: (文件路径, 行号)，如果未找到返回None
        """
        return self._locator.locate_class_attribute(class_data, attribute_name)
    
    def locate_enum_value(self, enum_data: Dict[str, Any], value_name: str) -> Optional[Tuple[str, int]]:
        """
        定位枚举值在代码中的位置
        
        Args:
            enum_data: 枚举数据
            value_name: 枚举值名称
            
        Returns:
            Tuple[str, int]: (文件路径, 行号)，如果未找到返回None
        """
        return self._locator.locate_enum_value(enum_data, value_name)