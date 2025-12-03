"""JSON 构建模块"""

import json
from pathlib import Path
from typing import Any, Dict, List, Optional

from loguru import logger

from .models import (
    DetailedDesc,
    ExtractionStats,
    ParameterInfo,
    ParsedApi,
    ParsedEnum,
    ParsedStruct,
)


class JsonBuilder:
    """构建 JSON 输出"""
    
    def __init__(self, name_groups_path: Path):
        """初始化
        
        Args:
            name_groups_path: name_groups.json 文件路径
        """
        self.name_groups: Dict[str, Any] = {}
        self._load_name_groups(name_groups_path)
    
    def _load_name_groups(self, path: Path) -> None:
        """加载 name_groups.json"""
        if not path.exists():
            logger.warning(f"name_groups.json 不存在: {path}")
            return
        
        try:
            with open(path, "r", encoding="utf-8") as f:
                self.name_groups = json.load(f)
            logger.info(f"加载 name_groups.json 完成")
        except Exception as e:
            logger.error(f"加载 name_groups.json 失败: {e}")
    
    def build_api_item(self, key: str, parsed: ParsedApi, platform: str) -> Dict[str, Any]:
        """构建 api_changes 列表项
        
        Args:
            key: API 的 key
            parsed: 解析后的 API 数据
            platform: 平台名称（json_platform）
            
        Returns:
            api_changes 列表项
        """
        # 从 name_groups 获取 parent_class
        parent_class = self._get_parent_class("api", key)
        
        return {
            "diff": [],
            "parent_class": parent_class,
            "package_name": "",
            "details": {
                "api_name": key,
                "api_signature": parsed.signature,
                "change_type": "create",
                "change_desc": "",
                "shortdesc": parsed.shortdesc,
                "platforms": platform,
                "parent_class": parent_class,
                "detailed_desc": self._build_detailed_desc(parsed.detailed_desc),
                "scenarios": parsed.scenarios or "",
                "related": parsed.related or "",
                "timing": parsed.timing or "",
                "parameters": self._build_parameters(parsed.parameters),
                "return_value": parsed.return_value or "",
            }
        }
    
    def build_struct_item(self, key: str, parsed: ParsedStruct, platform: str) -> Dict[str, Any]:
        """构建 struct_changes 列表项
        
        Args:
            key: Struct 的 key
            parsed: 解析后的 Struct 数据
            platform: 平台名称（json_platform）
            
        Returns:
            struct_changes 列表项
        """
        return {
            "diff": [],
            "parent_class": "",
            "package_name": "",
            "details": {
                "struct_name": key,
                "struct_signature": parsed.signature,
                "change_type": "create",
                "change_desc": "",
                "shortdesc": parsed.shortdesc,
                "platforms": platform,
                "parent_class": "",
                "detailed_desc": self._build_detailed_desc(parsed.detailed_desc),
                "parameters": self._build_parameters(parsed.parameters),
            }
        }
    
    def build_enum_item(self, key: str, parsed: ParsedEnum, platform: str) -> Dict[str, Any]:
        """构建 enum_changes 列表项
        
        Args:
            key: Enum 的 key
            parsed: 解析后的 Enum 数据
            platform: 平台名称（json_platform）
            
        Returns:
            enum_changes 列表项
        """
        return {
            "diff": [],
            "parent_class": "",
            "package_name": "",
            "details": {
                "enum_name": key,
                "change_type": "create",
                "change_desc": "",
                "shortdesc": parsed.shortdesc,
                "platforms": platform,
                "parent_class": "",
                "detailed_desc": self._build_detailed_desc(parsed.detailed_desc),
                "parameters": self._build_parameters(parsed.parameters),
            }
        }
    
    def build_platform_output(
        self,
        platform: str,
        api_items: List[Dict[str, Any]],
        struct_items: List[Dict[str, Any]],
        enum_items: List[Dict[str, Any]],
    ) -> Dict[str, Any]:
        """构建单个平台的输出
        
        Args:
            platform: 平台名称（json_platform）
            api_items: api_changes 列表
            struct_items: struct_changes 列表
            enum_items: enum_changes 列表
            
        Returns:
            平台输出对象
        """
        return {
            "file": f"{platform}.diff",
            "changes": {
                "api_changes": api_items,
                "struct_changes": struct_items,
                "enum_changes": enum_items,
            }
        }
    
    def _get_parent_class(self, category: str, key: str) -> str:
        """从 name_groups 获取 parent_class
        
        Args:
            category: 分类（api/struct/enum）
            key: 项目的 key
            
        Returns:
            parent_class 或空字符串
        """
        category_data = self.name_groups.get(category, {})
        item_data = category_data.get(key, {})
        return item_data.get("parent_class", "")
    
    def _build_detailed_desc(self, detailed_desc: Optional[DetailedDesc]) -> Dict[str, str]:
        """构建 detailed_desc 对象"""
        if detailed_desc is None:
            return {
                "since": "",
                "desc": "",
                "deprecated": "",
                "note": "",
            }
        
        return {
            "since": detailed_desc.since or "",
            "desc": detailed_desc.desc or "",
            "deprecated": detailed_desc.deprecated or "",
            "note": detailed_desc.note or "",
        }
    
    def _build_parameters(self, parameters: List[ParameterInfo]) -> List[Dict[str, str]]:
        """构建 parameters 列表"""
        result: List[Dict[str, str]] = []
        
        for param in parameters:
            item: Dict[str, str] = {
                "name": param.name,
                "desc": param.desc,
            }
            if param.note:
                item["note"] = param.note
            result.append(item)
        
        return result
    
    def count_stats(
        self,
        api_items: List[Dict[str, Any]],
        struct_items: List[Dict[str, Any]],
        enum_items: List[Dict[str, Any]],
    ) -> ExtractionStats:
        """统计提取数量
        
        Args:
            api_items: api_changes 列表
            struct_items: struct_changes 列表
            enum_items: enum_changes 列表
            
        Returns:
            统计信息
        """
        stats = ExtractionStats()
        
        for item in api_items:
            api_name = item.get("details", {}).get("api_name", "")
            if api_name.startswith("on") or "callback" in api_name.lower():
                stats.callback_count += 1
            else:
                stats.api_count += 1
        
        stats.struct_count = len(struct_items)
        stats.enum_count = len(enum_items)
        
        return stats

