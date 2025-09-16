# -*- coding: utf-8 -*-
"""
配置管理器
"""

import os
import yaml
from pathlib import Path
from typing import Dict, Any, Optional
from jsonschema import validate, ValidationError
from loguru import logger

from .schemas import REPO_CONFIG_SCHEMA, PLATFORM_CONFIG_SCHEMA


class ConfigManager:
    """配置管理器，负责加载和验证配置文件"""
    
    def __init__(self, config_dir: str = "config"):
        """
        初始化配置管理器
        
        Args:
            config_dir: 配置文件目录路径
        """
        self.config_dir = Path(config_dir)
        self._repo_config: Optional[Dict[str, Any]] = None
        self._platform_configs: Dict[str, Dict[str, Any]] = {}
        
    def load_repo_config(self) -> Dict[str, Any]:
        """
        加载主配置文件
        
        Returns:
            Dict: 主配置信息
            
        Raises:
            FileNotFoundError: 配置文件不存在
            ValidationError: 配置文件格式错误
        """
        if self._repo_config is None:
            config_path = self.config_dir / "repo_config.yml"
            
            if not config_path.exists():
                raise FileNotFoundError(f"主配置文件不存在: {config_path}")
                
            logger.debug("加载主配置文件: {}", config_path)
            
            with open(config_path, 'r', encoding='utf-8') as f:
                config = yaml.safe_load(f)
                
            # 验证配置格式
            try:
                validate(instance=config, schema=REPO_CONFIG_SCHEMA)
                logger.info("主配置文件验证通过")
            except ValidationError as e:
                logger.error("主配置文件格式错误: {}", e.message)
                raise
                
            self._repo_config = config
            
        return self._repo_config
    
    def load_platform_config(self, platform: str) -> Dict[str, Any]:
        """
        加载平台配置文件
        
        Args:
            platform: 平台名称 (cpp-ng, android-ng, ios-ng, mac-ng)
            
        Returns:
            Dict: 平台配置信息
            
        Raises:
            FileNotFoundError: 配置文件不存在
            ValidationError: 配置文件格式错误
        """
        if platform not in self._platform_configs:
            config_path = self.config_dir / "platforms" / f"{platform}.yml"
            
            if not config_path.exists():
                raise FileNotFoundError(f"平台配置文件不存在: {config_path}")
                
            logger.debug("加载平台配置文件: {}", config_path)
            
            with open(config_path, 'r', encoding='utf-8') as f:
                config = yaml.safe_load(f)
                
            # 验证配置格式
            try:
                validate(instance=config, schema=PLATFORM_CONFIG_SCHEMA)
                logger.info("平台配置文件验证通过: {}", platform)
            except ValidationError as e:
                logger.error("平台配置文件格式错误 {}: {}", platform, e.message)
                raise
                
            self._platform_configs[platform] = config
            
        return self._platform_configs[platform]
    
    def get_html_source_path(self, platform: str) -> str:
        """
        获取指定平台的HTML源文件路径
        
        Args:
            platform: 平台名称
            
        Returns:
            str: HTML源文件路径
        """
        repo_config = self.load_repo_config()
        return repo_config["html_sources"][platform]
    
    def get_platform_search_paths(self, platform: str) -> Dict[str, list]:
        """
        获取指定平台的搜索路径配置
        
        Args:
            platform: 平台名称
            
        Returns:
            Dict: 包含include和exclude列表的字典
        """
        repo_config = self.load_repo_config()
        return repo_config["platforms"][platform]
    
    def get_repo_path(self) -> str:
        """
        获取代码仓库路径
        
        Returns:
            str: 代码仓库路径
        """
        repo_config = self.load_repo_config()
        return repo_config["repo_path"]
    
    def get_logging_config(self) -> Dict[str, Any]:
        """
        获取日志配置
        
        Returns:
            Dict: 日志配置信息
        """
        repo_config = self.load_repo_config()
        return repo_config["logging"]
    
    def get_supported_platforms(self) -> list:
        """
        获取支持的平台列表
        
        Returns:
            list: 支持的平台名称列表
        """
        repo_config = self.load_repo_config()
        return list(repo_config["html_sources"].keys())
    
    def validate_platform(self, platform: str) -> bool:
        """
        验证平台名称是否有效
        
        Args:
            platform: 平台名称
            
        Returns:
            bool: 平台是否有效
        """
        supported_platforms = self.get_supported_platforms()
        return platform in supported_platforms
    
    def reload_configs(self):
        """重新加载所有配置文件"""
        logger.info("重新加载所有配置文件")
        self._repo_config = None
        self._platform_configs.clear()
