# -*- coding: utf-8 -*-
"""
注释注入器 - 工厂模式入口
将标准化的注释注入到代码文件中
"""

from typing import Dict, Any
from loguru import logger


class CommentInjector:
    """注释注入器工厂，负责创建和委托到平台特定的注入器"""
    
    def __init__(self, repo_config: Dict[str, Any], platform_config: Dict[str, Any]):
        """
        初始化注释注入器工厂
        
        Args:
            repo_config: 代码仓库配置
            platform_config: 平台配置
        """
        self.platform = platform_config["platform"]
        self._injector = self._create_platform_injector(repo_config, platform_config)
        
        logger.debug("初始化注释注入器工厂: 平台={}", self.platform)
    
    def _create_platform_injector(self, repo_config: Dict[str, Any], platform_config: Dict[str, Any]):
        """
        根据平台创建对应的注入器
        
        Args:
            repo_config: 代码仓库配置
            platform_config: 平台配置
            
        Returns:
            平台特定的注入器实例
        """
        if self.platform == "cpp-ng":
            from .platforms.cpp_injector import CppInjector
            return CppInjector(repo_config, platform_config)
        elif self.platform in ["android-ng", "java-ng"]:
            from .platforms.java_injector import JavaInjector
            return JavaInjector(repo_config, platform_config)
        elif self.platform in ["ios-ng", "oc-ng"]:
            from .platforms.oc_injector import OcInjector
            return OcInjector(repo_config, platform_config)
        elif self.platform in ["mac-ng", "oc-ng"]:
            from .platforms.oc_injector import OcInjector
            return OcInjector(repo_config, platform_config)
        else:
            raise ValueError(f"Unsupported platform: {self.platform}")
    
    # ==================== 委托方法 ====================
    # 所有方法都委托到具体的平台实现
    
    def inject_api_comment(self, api_data: Dict[str, Any]) -> bool:
        """
        注入API注释
        
        Args:
            api_data: API数据
            
        Returns:
            bool: 是否成功注入
        """
        return self._injector.inject_api_comment(api_data)
    
    def inject_class_comment(self, class_data: Dict[str, Any]) -> bool:
        """
        批量注入类注释
        
        Args:
            class_data: 类数据
            
        Returns:
            bool: 是否成功注入
        """
        return self._injector.inject_class_comment(class_data)
    
    def inject_enum_comment(self, enum_data: Dict[str, Any]) -> bool:
        """
        注入枚举注释
        
        Args:
            enum_data: 枚举数据
            
        Returns:
            bool: 是否成功注入
        """
        return self._injector.inject_enum_comment(enum_data)
