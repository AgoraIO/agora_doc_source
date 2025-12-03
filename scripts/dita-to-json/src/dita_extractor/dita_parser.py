"""DITA 文件解析模块"""

import copy
import html
from pathlib import Path
from typing import List, Optional

from loguru import logger
from lxml import etree

from .config import PlatformConfig, matches_platform
from .keymap_parser import KeymapParser
from .markdown_converter import MarkdownConverter
from .models import (
    DetailedDesc,
    ParameterInfo,
    ParsedApi,
    ParsedEnum,
    ParsedStruct,
)


class DitaParser:
    """DITA 文件解析器"""
    
    def __init__(
        self,
        base_dir: Path,
        platform_config: PlatformConfig,
        keymap_parser: KeymapParser,
    ):
        """初始化
        
        Args:
            base_dir: DITA 文件根目录
            platform_config: 平台配置
            keymap_parser: keymap 解析器
        """
        self.base_dir = base_dir
        self.platform_config = platform_config
        self.props_platform = platform_config.props_platform
        self.language_platform = platform_config.language_platform
        self.keymap_parser = keymap_parser
        self.converter = MarkdownConverter(keymap_parser, self.props_platform)
        
        # 缓存已解析的文件
        self._file_cache: dict[str, etree._ElementTree] = {}
    
    def parse_api(self, key: str) -> Optional[ParsedApi]:
        """解析 API/Callback 文件
        
        Args:
            key: API 的 key
            
        Returns:
            ParsedApi 或 None
        """
        filepath = self.keymap_parser.get_filepath(key)
        if not filepath:
            logger.warning(f"找不到 API 文件路径: {key}")
            return None
        
        tree = self._load_file(filepath)
        if tree is None:
            return None
        
        root = tree.getroot()
        
        # 判断是否为 callback
        ref_id = root.get("id", "")
        is_callback = ref_id.startswith("callback_")
        
        # 提取各个部分
        signature = self._extract_signature(root)
        shortdesc = self._extract_shortdesc(root)
        detailed_desc = self._extract_detailed_desc(root)
        scenarios = self._extract_section_content(root, "scenario")
        related = self._extract_section_content(root, "related")
        timing = self._extract_section_content(root, "timing")
        restrictions = self._extract_section_content(root, "restriction")
        parameters = self._extract_parameters(root)
        return_value = self._extract_return_value(root)
        
        # 将 restrictions 合并到 detailed_desc.note（跳过无意义的 "无。"）
        if restrictions and restrictions.strip() not in ("无。", "无"):
            if detailed_desc:
                if detailed_desc.note:
                    detailed_desc.note = detailed_desc.note + "\n" + restrictions
                else:
                    detailed_desc.note = restrictions
            else:
                detailed_desc = DetailedDesc(note=restrictions)
        
        return ParsedApi(
            key=key,
            signature=signature,
            shortdesc=shortdesc,
            detailed_desc=detailed_desc,
            scenarios=scenarios,
            related=related,
            timing=timing,
            parameters=parameters,
            return_value=return_value,
            is_callback=is_callback,
        )
    
    def parse_struct(self, key: str, is_interface: bool = False) -> Optional[ParsedStruct]:
        """解析 Struct/Class 文件
        
        Args:
            key: Struct 的 key
            is_interface: 是否为接口类
            
        Returns:
            ParsedStruct 或 None
        """
        filepath = self.keymap_parser.get_filepath(key)
        if not filepath:
            logger.warning(f"找不到 Struct 文件路径: {key}")
            return None
        
        tree = self._load_file(filepath)
        if tree is None:
            return None
        
        root = tree.getroot()
        
        # 提取各个部分
        signature = self._extract_signature(root) if not is_interface else ""
        shortdesc = self._extract_shortdesc(root)
        detailed_desc = self._extract_detailed_desc(root)
        parameters = self._extract_parameters(root) if not is_interface else []
        
        return ParsedStruct(
            key=key,
            signature=signature,
            shortdesc=shortdesc,
            detailed_desc=detailed_desc,
            parameters=parameters,
            is_interface=is_interface,
        )
    
    def parse_enum(self, key: str) -> Optional[ParsedEnum]:
        """解析 Enum 文件
        
        Args:
            key: Enum 的 key
            
        Returns:
            ParsedEnum 或 None
        """
        filepath = self.keymap_parser.get_filepath(key)
        if not filepath:
            logger.warning(f"找不到 Enum 文件路径: {key}")
            return None
        
        tree = self._load_file(filepath)
        if tree is None:
            return None
        
        root = tree.getroot()
        
        # 提取各个部分
        shortdesc = self._extract_shortdesc(root)
        detailed_desc = self._extract_detailed_desc(root)
        parameters = self._extract_parameters(root)  # 枚举值
        
        return ParsedEnum(
            key=key,
            shortdesc=shortdesc,
            detailed_desc=detailed_desc,
            parameters=parameters,
        )
    
    def _load_file(self, filepath: str) -> Optional[etree._ElementTree]:
        """加载并缓存 DITA 文件"""
        if filepath in self._file_cache:
            return self._file_cache[filepath]
        
        try:
            tree = etree.parse(filepath)
            self._file_cache[filepath] = tree
            return tree
        except Exception as e:
            logger.error(f"解析 DITA 文件失败: {filepath}, 错误: {e}")
            return None
    
    def _extract_signature(self, root: etree._Element) -> str:
        """提取 API 签名"""
        section = root.find(".//section[@id='prototype']")
        if section is None:
            return ""
        
        # 查找匹配平台的 codeblock
        for codeblock in section.iter("codeblock"):
            props = codeblock.get("props")
            if self._matches_platform(props):
                # 获取代码内容并反转义
                content = "".join(codeblock.itertext())
                return html.unescape(content).strip()
        
        return ""
    
    def _extract_shortdesc(self, root: etree._Element) -> str:
        """提取简短描述"""
        shortdesc = root.find(".//shortdesc")
        if shortdesc is None:
            return ""
        
        # 查找匹配平台的 ph 元素
        for ph in shortdesc.iter("ph"):
            # 处理 conkeyref 引用
            conkeyref = ph.get("conkeyref")
            if conkeyref:
                resolved = self._resolve_conkeyref(conkeyref)
                if resolved is not None:
                    ph = resolved
            
            props = ph.get("props")
            if self._matches_platform(props):
                return self.converter.convert(ph)
        
        # 如果没有 ph，直接转换 shortdesc
        return self.converter.convert(shortdesc)
    
    def _extract_detailed_desc(self, root: etree._Element) -> Optional[DetailedDesc]:
        """提取详细描述"""
        section = root.find(".//section[@id='detailed_desc']")
        if section is None:
            return None
        
        result = DetailedDesc()
        
        # 提取 since/deprecated
        for dl in section.findall("dl"):
            props = dl.get("props")
            if not self._matches_platform(props):
                continue
            
            outputclass = dl.get("outputclass", "")
            dlentry = dl.find("dlentry")
            if dlentry is not None:
                dt = dlentry.find("dt")
                dd = dlentry.find("dd")
                if dt is not None and dd is not None:
                    dt_text = self.converter.convert_text_content(dt)
                    dd_text = self.converter.convert_text_content(dd)
                    combined = f"{dt_text} {dd_text}".strip()
                    
                    if "since" in outputclass:
                        result.since = combined
                    elif "deprecated" in outputclass:
                        result.deprecated = combined
        
        # 提取描述段落
        desc_parts: List[str] = []
        for p in section.findall("p"):
            props = p.get("props")
            if self._matches_platform(props):
                content = self.converter.convert(p, exclude_note=True)
                if content:
                    desc_parts.append(content)
        
        if desc_parts:
            result.desc = "\n".join(desc_parts).strip()
        
        # 提取 note
        notes: List[str] = []
        for note in section.findall("note"):
            props = note.get("props")
            if self._matches_platform(props):
                content = self.converter.convert(note)
                if content:
                    notes.append(content)
        
        if notes:
            result.note = "\n".join(notes).strip()
        
        # 检查是否有内容
        if result.since or result.desc or result.deprecated or result.note:
            return result
        
        return None
    
    def _extract_section_content(self, root: etree._Element, section_id: str) -> Optional[str]:
        """提取指定 section 的内容"""
        section = root.find(f".//section[@id='{section_id}']")
        if section is None:
            return None
        
        parts: List[str] = []
        for p in section.findall("p"):
            props = p.get("props")
            if self._matches_platform(props):
                content = self.converter.convert(p)
                if content:
                    parts.append(content)
        
        if parts:
            return "\n".join(parts).strip()
        return None
    
    def _extract_parameters(self, root: etree._Element) -> List[ParameterInfo]:
        """提取参数列表"""
        section = root.find(".//section[@id='parameters']")
        if section is None:
            return []
        
        parml = section.find("parml")
        if parml is None:
            return []
        
        params: List[ParameterInfo] = []
        
        for plentry in parml.findall("plentry"):
            param = self._extract_single_parameter(plentry)
            if param:
                params.append(param)
        
        return params
    
    def _extract_single_parameter(self, plentry: etree._Element) -> Optional[ParameterInfo]:
        """提取单个参数"""
        # 处理 conkeyref
        conkeyref = plentry.get("conkeyref")
        if conkeyref:
            resolved = self._resolve_conkeyref(conkeyref)
            if resolved is not None:
                plentry = resolved
            else:
                return None
        
        # 检查 plentry 级别的 props
        props = plentry.get("props")
        if not self._matches_platform(props):
            return None
        
        # 选择匹配平台的 pt
        pt = self._select_matching_element(plentry.findall("pt"))
        if pt is None:
            return None
        
        # 选择匹配平台的 pd
        pd = self._select_matching_element(plentry.findall("pd"))
        if pd is None:
            return None
        
        # 提取参数名（使用 convert 以处理 <ph keyref="..."/> 等元素）
        name = self.converter.convert(pt).strip()
        
        # 提取描述（排除 note 和 deprecated/since dl）
        desc = self.converter.convert(pd, exclude_note=True, exclude_dl_meta=True)
        
        # 提取 note
        note_parts: List[str] = []
        
        # 提取 <note> 元素
        note_content = self.converter.extract_note(pd)
        if note_content:
            note_parts.append(note_content)
        
        # 提取 deprecated/since dl 元素
        dl_meta = self.converter.extract_dl_meta(pd)
        if dl_meta:
            note_parts.append(dl_meta)
        
        note = "\n".join(note_parts) if note_parts else None
        
        return ParameterInfo(name=name, desc=desc, note=note)
    
    def _extract_return_value(self, root: etree._Element) -> Optional[str]:
        """提取返回值"""
        section = root.find(".//section[@id='return_values']")
        if section is None:
            return None
        
        parts: List[str] = []
        
        # 处理 p 元素
        for p in section.findall("p"):
            props = p.get("props")
            if self._matches_platform(props):
                content = self.converter.convert(p)
                if content:
                    parts.append(content)
        
        # 处理 ul 元素
        for ul in section.findall("ul"):
            props = ul.get("props")
            if self._matches_platform(props):
                content = self.converter.convert(ul)
                if content:
                    parts.append(content)
        
        if parts:
            return "\n".join(parts).strip()
        return None
    
    def _resolve_conkeyref(self, conkeyref: str) -> Optional[etree._Element]:
        """解析 conkeyref 引用
        
        Args:
            conkeyref: 格式为 "Key/id"
            
        Returns:
            解析后的元素副本或 None
        """
        try:
            key, elem_id = conkeyref.split("/")
        except ValueError:
            logger.warning(f"无效的 conkeyref 格式: {conkeyref}")
            return None
        
        # 从 keysmap 获取文件路径
        filepath = self.keymap_parser.get_filepath(key)
        if not filepath:
            logger.warning(f"conkeyref 找不到文件: {key}")
            return None
        
        # 加载目标文件
        tree = self._load_file(filepath)
        if tree is None:
            return None
        
        # 查找 id 匹配的元素
        target_elems = tree.xpath(f'//*[@id="{elem_id}"]')
        if not target_elems:
            logger.warning(f"conkeyref 找不到元素: {conkeyref}")
            return None
        
        target_elem = target_elems[0]
        
        # 深拷贝并移除顶层 props
        result = copy.deepcopy(target_elem)
        if "props" in result.attrib:
            del result.attrib["props"]
        
        return result
    
    def _select_matching_element(self, elements: List[etree._Element]) -> Optional[etree._Element]:
        """从多个元素中选择匹配当前平台的元素"""
        # 优先选择有 props 且匹配的
        for elem in elements:
            props = elem.get("props")
            if props and self._matches_platform(props):
                return elem
        
        # 其次选择没有 props 的（支持所有平台）
        for elem in elements:
            if elem.get("props") is None:
                return elem
        
        return None
    
    def _matches_platform(self, props: Optional[str]) -> bool:
        """检查 props 是否匹配当前平台"""
        return matches_platform(props, self.props_platform)

