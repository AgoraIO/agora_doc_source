# -*- coding: utf-8 -*-
"""
配置管理器测试
"""

import pytest
import tempfile
import os
from pathlib import Path
import yaml

from src.config.manager import ConfigManager


@pytest.fixture
def temp_config_dir():
    """创建临时配置目录"""
    with tempfile.TemporaryDirectory() as temp_dir:
        config_dir = Path(temp_dir) / "config"
        config_dir.mkdir()
        
        # 创建platforms子目录
        platforms_dir = config_dir / "platforms"
        platforms_dir.mkdir()
        
        # 创建测试用的主配置文件
        repo_config = {
            "repo_path": "/test/repo",
            "html_sources": {
                "cpp-ng": "test/cpp",
                "android-ng": "test/android", 
                "ios-ng": "test/ios",
                "mac-ng": "test/mac"
            },
            "platforms": {
                "cpp-ng": {
                    "include": ["*.h"],
                    "exclude": ["internal/*"]
                }
            },
            "logging": {
                "file_level": "debug",
                "console_level": "info",
                "log_dir": "./logs"
            }
        }
        
        with open(config_dir / "repo_config.yml", 'w') as f:
            yaml.dump(repo_config, f)
            
        # 创建测试用的平台配置文件
        platform_config = {
            "platform": "cpp-ng",
            "language": "cpp", 
            "html_parsing": {
                "api_name_selector": "test_selector",
                "signature_selector": "test_sig",
                "parent_class_selector": "test_parent"
            },
            "comment_template": "test template",
            "search_patterns": {
                "signature_patterns": ["test_pattern"],
                "name_patterns": ["test_name"]
            },
            "preserve_patterns": {
                "technical_preview": "test_tech",
                "since": "test_since", 
                "deprecated": "test_dep"
            }
        }
        
        with open(platforms_dir / "cpp-ng.yml", 'w') as f:
            yaml.dump(platform_config, f)
            
        yield str(config_dir)


def test_load_repo_config(temp_config_dir):
    """测试加载主配置文件"""
    manager = ConfigManager(temp_config_dir)
    config = manager.load_repo_config()
    
    assert config["repo_path"] == "/test/repo"
    assert "cpp-ng" in config["html_sources"]
    assert config["logging"]["file_level"] == "debug"


def test_load_platform_config(temp_config_dir):
    """测试加载平台配置文件"""
    manager = ConfigManager(temp_config_dir)
    config = manager.load_platform_config("cpp-ng")
    
    assert config["platform"] == "cpp-ng"
    assert config["language"] == "cpp"
    assert "api_name_selector" in config["html_parsing"]


def test_get_html_source_path(temp_config_dir):
    """测试获取HTML源路径"""
    manager = ConfigManager(temp_config_dir)
    path = manager.get_html_source_path("cpp-ng")
    
    assert path == "test/cpp"


def test_validate_platform(temp_config_dir):
    """测试平台验证"""
    manager = ConfigManager(temp_config_dir)
    
    assert manager.validate_platform("cpp-ng") == True
    assert manager.validate_platform("invalid-platform") == False


def test_get_supported_platforms(temp_config_dir):
    """测试获取支持的平台列表"""
    manager = ConfigManager(temp_config_dir)
    platforms = manager.get_supported_platforms()
    
    assert "cpp-ng" in platforms
    assert "android-ng" in platforms
    assert len(platforms) == 4


def test_missing_config_file():
    """测试配置文件不存在的情况"""
    manager = ConfigManager("/nonexistent/path")
    
    with pytest.raises(FileNotFoundError):
        manager.load_repo_config()
        
    with pytest.raises(FileNotFoundError):
        manager.load_platform_config("cpp-ng")
