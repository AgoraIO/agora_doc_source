"""解析 keysmap 和 linksmap 映射文件"""

from pathlib import Path
from typing import Dict, Optional

from loguru import logger
from lxml import etree

from .config import PlatformConfig, get_keysmap_path, get_linksmap_paths
from .models import KeymapEntry, LinkEntry


class KeymapParser:
    """解析 keysmap 和 linksmap 映射文件"""
    
    def __init__(self, base_dir: Path, platform_config: PlatformConfig):
        """初始化
        
        Args:
            base_dir: DITA 文件根目录
            platform_config: 平台配置
        """
        self.base_dir = base_dir
        self.platform_config = platform_config
        self.api_keymap: Dict[str, KeymapEntry] = {}
        self.link_keymap: Dict[str, LinkEntry] = {}
        
        # 解析映射文件
        self._parse_keysmap()
        self._parse_linksmap()
    
    def _parse_keysmap(self) -> None:
        """解析 keysmap 文件"""
        keysmap_path = get_keysmap_path(self.base_dir, self.platform_config)
        
        if not keysmap_path.exists():
            logger.warning(f"keysmap 文件不存在: {keysmap_path}")
            return
        
        try:
            tree = etree.parse(str(keysmap_path))
            root = tree.getroot()
        except Exception as e:
            logger.error(f"解析 keysmap 失败: {keysmap_path}, 错误: {e}")
            return
        
        # 遍历所有 keydef
        for keydef in root.iter("keydef"):
            key = keydef.get("keys")
            href = keydef.get("href")
            
            if not key:
                continue
            
            # 获取 keyword
            keyword = self._extract_keyword(keydef)
            if not keyword:
                keyword = key  # 默认使用 key 作为 keyword
            
            # 处理相对路径
            if href:
                # href 是相对于 keysmap 文件的路径
                filepath = (keysmap_path.parent / href).resolve()
                filepath_str = str(filepath)
            else:
                filepath_str = ""
            
            self.api_keymap[key] = KeymapEntry(
                key=key,
                filepath=filepath_str,
                keyword=keyword,
            )
        
        logger.info(f"解析 keysmap 完成，共 {len(self.api_keymap)} 个条目")
    
    def _parse_linksmap(self) -> None:
        """解析 linksmap 文件（通用 + 平台专用）"""
        common_path, platform_path = get_linksmap_paths(self.base_dir, self.platform_config)
        
        # 先解析通用 linksmap
        if common_path.exists():
            self._parse_single_linksmap(common_path)
        
        # 再解析平台专用 linksmap（会覆盖通用的）
        if platform_path.exists():
            self._parse_single_linksmap(platform_path)
        
        logger.info(f"解析 linksmap 完成，共 {len(self.link_keymap)} 个条目")
    
    def _parse_single_linksmap(self, linksmap_path: Path) -> None:
        """解析单个 linksmap 文件"""
        try:
            tree = etree.parse(str(linksmap_path))
            root = tree.getroot()
        except Exception as e:
            logger.error(f"解析 linksmap 失败: {linksmap_path}, 错误: {e}")
            return
        
        # 遍历所有 keydef
        for keydef in root.iter("keydef"):
            key = keydef.get("keys")
            href = keydef.get("href")
            
            if not key or not href:
                continue
            
            # 获取链接文本
            text = self._extract_keyword(keydef) or ""
            
            self.link_keymap[key] = LinkEntry(
                key=key,
                url=href,
                text=text,
            )
    
    def _extract_keyword(self, keydef: etree._Element) -> Optional[str]:
        """从 keydef 提取 keyword"""
        # 查找 topicmeta/keywords/keyword
        topicmeta = keydef.find("topicmeta")
        if topicmeta is not None:
            keywords = topicmeta.find("keywords")
            if keywords is not None:
                keyword = keywords.find("keyword")
                if keyword is not None and keyword.text:
                    return keyword.text.strip()
        return None
    
    def get_api_entry(self, key: str) -> Optional[KeymapEntry]:
        """获取 API keymap 条目
        
        Args:
            key: API/类/枚举的 key
            
        Returns:
            KeymapEntry 或 None
        """
        return self.api_keymap.get(key)
    
    def get_link_entry(self, key: str) -> Optional[LinkEntry]:
        """获取 link keymap 条目
        
        Args:
            key: 链接的 key
            
        Returns:
            LinkEntry 或 None
        """
        return self.link_keymap.get(key)
    
    def get_keyword(self, key: str) -> str:
        """获取 key 对应的 keyword
        
        Args:
            key: API/类/枚举的 key
            
        Returns:
            keyword，如果找不到则返回 key 本身
        """
        entry = self.api_keymap.get(key)
        if entry:
            return entry.keyword
        return key
    
    def get_filepath(self, key: str) -> Optional[str]:
        """获取 key 对应的文件路径
        
        Args:
            key: API/类/枚举的 key
            
        Returns:
            文件路径或 None
        """
        entry = self.api_keymap.get(key)
        if entry and entry.filepath:
            return entry.filepath
        return None

