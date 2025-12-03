"""确定提取范围模块"""

from pathlib import Path
from typing import List

from loguru import logger
from lxml import etree

from .config import (
    PlatformConfig,
    get_datatype_path,
    get_ditamap_path,
    matches_platform,
)
from .models import ScopeResult


class ScopeResolver:
    """确定提取范围"""
    
    def __init__(self, base_dir: Path, platform_config: PlatformConfig):
        """初始化
        
        Args:
            base_dir: DITA 文件根目录
            platform_config: 平台配置
        """
        self.base_dir = base_dir
        self.platform_config = platform_config
        self.props_platform = platform_config.props_platform
    
    def resolve(self) -> ScopeResult:
        """解析提取范围
        
        Returns:
            ScopeResult 包含所有需要提取的 key
        """
        result = ScopeResult()
        
        # 1. 从 ditamap 提取接口类和 API/Callback key
        self._resolve_from_ditamap(result)
        
        # 2. 从 datatype 提取普通类和枚举类 key
        self._resolve_from_datatype(result)
        
        logger.info(
            f"平台 {self.platform_config.json_platform} 提取范围: "
            f"接口类 {len(result.interface_keys)}, "
            f"API {len(result.api_keys)}, "
            f"普通类 {len(result.class_keys)}, "
            f"枚举 {len(result.enum_keys)}"
        )
        
        return result
    
    def _resolve_from_ditamap(self, result: ScopeResult) -> None:
        """从 ditamap 提取 key"""
        ditamap_path = get_ditamap_path(self.base_dir, self.platform_config)
        
        if not ditamap_path.exists():
            logger.warning(f"ditamap 文件不存在: {ditamap_path}")
            return
        
        try:
            tree = etree.parse(str(ditamap_path))
            root = tree.getroot()
        except Exception as e:
            logger.error(f"解析 ditamap 失败: {ditamap_path}, 错误: {e}")
            return
        
        # 用于跟踪已处理的接口类 key，避免重复提取
        interface_key_set: set[str] = set()
        
        # 首先找到接口类容器并提取接口类 key
        for topicref in root.iter("topicref"):
            href = topicref.get("href", "")
            if "rtc_interface_class.dita" in href:
                self._extract_interface_keys(topicref, result.interface_keys, interface_key_set)
                break  # 只有一个接口类容器
        
        # 然后遍历顶层 topichead 提取 API/Callback key
        for topichead in root.findall("topichead"):
            # 跳过配置相关的 topichead
            navtitle = topichead.get("navtitle", "")
            if navtitle == "Configurations":
                continue
            
            # 遍历 topichead 下的 topicref
            for topicref in topichead.findall("topicref"):
                href = topicref.get("href", "")
                
                # 跳过接口类容器
                if "rtc_interface_class.dita" in href:
                    continue
                
                # 提取该 toc 下的所有 API/Callback key
                self._extract_api_keys_from_toc(topicref, result.api_keys, interface_key_set)
    
    def _extract_interface_keys(
        self, parent: etree._Element, keys: List[str], key_set: set[str]
    ) -> None:
        """从接口类容器提取 key"""
        for topicref in parent.findall("topicref"):
            key = self._get_valid_key(topicref)
            if key:
                keys.append(key)
                key_set.add(key)
                logger.debug(f"发现接口类: {key}")
    
    def _extract_api_keys_from_toc(
        self, toc_topicref: etree._Element, keys: List[str], exclude_keys: set[str]
    ) -> None:
        """从 toc 容器提取 API/Callback key"""
        # 遍历 toc 下的所有 topicref（包括嵌套的）
        for topicref in toc_topicref.iter("topicref"):
            key = self._get_valid_key(topicref)
            if key and key not in exclude_keys:
                keys.append(key)
                logger.debug(f"发现 API/Callback: {key}")
    
    def _get_valid_key(self, topicref: etree._Element) -> str | None:
        """获取有效的 key（排除 resource-only 和 hide）
        
        Returns:
            有效的 key 或 None
        """
        # 排除 processing-role="resource-only"
        if topicref.get("processing-role") == "resource-only":
            return None
        
        # 排除 props="hide"
        props = topicref.get("props")
        if props == "hide":
            return None
        
        # 检查平台匹配
        if not matches_platform(props, self.props_platform):
            return None
        
        # 获取 keyref 属性
        keyref = topicref.get("keyref")
        if keyref:
            return keyref
        
        return None
    
    def _resolve_from_datatype(self, result: ScopeResult) -> None:
        """从 datatype 文件提取普通类和枚举类 key"""
        datatype_path = get_datatype_path(self.base_dir)
        
        if not datatype_path.exists():
            logger.warning(f"datatype 文件不存在: {datatype_path}")
            return
        
        try:
            tree = etree.parse(str(datatype_path))
            root = tree.getroot()
        except Exception as e:
            logger.error(f"解析 datatype 失败: {datatype_path}, 错误: {e}")
            return
        
        # 查找 class section
        class_section = root.find(".//section[@id='class']")
        if class_section is not None:
            self._extract_datatype_keys(class_section, result.class_keys)
        
        # 查找 enum section
        enum_section = root.find(".//section[@id='enum']")
        if enum_section is not None:
            self._extract_datatype_keys(enum_section, result.enum_keys)
    
    def _extract_datatype_keys(self, section: etree._Element, keys: List[str]) -> None:
        """从 datatype section 提取 key"""
        for ul in section.findall("ul"):
            # 检查 ul 的 props 是否匹配当前平台
            props = ul.get("props")
            if not matches_platform(props, self.props_platform):
                continue
            
            # 提取 ul 中的所有 xref keyref
            for li in ul.findall("li"):
                xref = li.find("xref")
                if xref is not None:
                    keyref = xref.get("keyref")
                    if keyref:
                        # 检查 li 和 xref 的 props
                        li_props = li.get("props")
                        xref_props = xref.get("props")
                        
                        if matches_platform(li_props, self.props_platform) and \
                           matches_platform(xref_props, self.props_platform):
                            keys.append(keyref)
                            logger.debug(f"发现数据类型: {keyref}")

