# -*- coding: utf-8 -*-
"""
配置文件JSON Schema定义
"""

# 主配置文件schema
REPO_CONFIG_SCHEMA = {
    "type": "object",
    "properties": {
        "repo_path": {
            "type": "string",
            "description": "代码仓库路径"
        },
        "html_sources": {
            "type": "object",
            "properties": {
                "cpp-ng": {"type": "string"},
                "android-ng": {"type": "string"},
                "ios-ng": {"type": "string"},
                "mac-ng": {"type": "string"}
            },
            "required": ["cpp-ng", "android-ng", "ios-ng", "mac-ng"],
            "description": "HTML文档路径配置"
        },
        "platforms": {
            "type": "object",
            "patternProperties": {
                "^(cpp-ng|android-ng|ios-ng|mac-ng)$": {
                    "type": "object",
                    "properties": {
                        "include": {
                            "type": "array",
                            "items": {"type": "string"}
                        },
                        "exclude": {
                            "type": "array", 
                            "items": {"type": "string"}
                        }
                    },
                    "required": ["include", "exclude"]
                }
            },
            "description": "各平台搜索路径配置"
        },
        "logging": {
            "type": "object",
            "properties": {
                "file_level": {
                    "type": "string",
                    "enum": ["debug", "info", "warning", "error"]
                },
                "console_level": {
                    "type": "string", 
                    "enum": ["debug", "info", "warning", "error"]
                },
                "log_dir": {"type": "string"},
                "max_log_files": {"type": "integer", "minimum": 1}
            },
            "required": ["file_level", "console_level", "log_dir"],
            "description": "日志配置"
        }
    },
    "required": ["repo_path", "html_sources", "platforms", "logging"]
}

# 平台配置文件schema
PLATFORM_CONFIG_SCHEMA = {
    "type": "object",
    "properties": {
        "platform": {
            "type": "string",
            "enum": ["cpp-ng", "android-ng", "ios-ng", "mac-ng"]
        },
        "language": {
            "type": "string",
            "enum": ["cpp", "java", "objc"]
        },
        "html_parsing": {
            "type": "object",
            "properties": {
                "api_name_selector": {"type": "string"},
                "signature_selector": {"type": "string"},
                "parent_class_selector": {"type": "string"}
            },
            "required": ["api_name_selector", "signature_selector", "parent_class_selector"]
        },
        "comment_template": {"type": "string"},
        "search_patterns": {
            "type": "object",
            "properties": {
                "signature_patterns": {
                    "type": "array",
                    "items": {"type": "string"}
                },
                "name_patterns": {
                    "type": "array", 
                    "items": {"type": "string"}
                }
            },
            "required": ["signature_patterns", "name_patterns"]
        },
        "preserve_patterns": {
            "type": "object",
            "properties": {
                "technical_preview": {"type": "string"},
                "since": {"type": "string"},
                "deprecated": {"type": "string"}
            },
            "required": ["technical_preview", "since", "deprecated"]
        }
    },
    "required": ["platform", "language", "html_parsing", "comment_template", 
                "search_patterns", "preserve_patterns"]
}
