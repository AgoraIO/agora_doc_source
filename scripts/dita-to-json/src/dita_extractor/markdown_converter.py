"""XML 元素到 Markdown 转换模块"""

import html
import re
from typing import TYPE_CHECKING, Callable, List, Optional

from loguru import logger
from lxml import etree

from .config import matches_platform

if TYPE_CHECKING:
    from .keymap_parser import KeymapParser

# Type alias for conkeyref resolver callback
ConkeyrefResolver = Callable[[str], Optional[etree._Element]]


class MarkdownConverter:
    """将 XML 元素转换为 Markdown 文本"""
    
    def __init__(
        self,
        keymap_parser: "KeymapParser",
        props_platform: str,
        conkeyref_resolver: Optional[ConkeyrefResolver] = None,
    ):
        """初始化
        
        Args:
            keymap_parser: keymap 解析器，用于解析 xref 链接
            props_platform: 当前平台的 props 值，用于过滤元素
            conkeyref_resolver: 可选的 conkeyref 解析回调函数
        """
        self.keymap_parser = keymap_parser
        self.props_platform = props_platform
        self.conkeyref_resolver = conkeyref_resolver
    
    def convert(
        self,
        element: Optional[etree._Element],
        exclude_note: bool = False,
        exclude_dl_meta: bool = False,
    ) -> str:
        """转换元素为 Markdown 文本
        
        Args:
            element: 要转换的 XML 元素
            exclude_note: 是否排除 note 元素
            exclude_dl_meta: 是否排除 dl (deprecated/since) 元素
            
        Returns:
            Markdown 格式的文本
        """
        if element is None:
            return ""
        
        result = self._convert_element(element, exclude_note, exclude_dl_meta)
        return self._clean_whitespace(result)
    
    def _clean_whitespace(self, text: str) -> str:
        """清理文本中多余的空白
        
        处理策略：
        1. 移除每行末尾的空白
        2. 对于列表项：只保留有效的嵌套缩进（2 空格的倍数），移除 XML 源码缩进
        3. 对于非列表项：移除所有前导空白
        4. 将多个连续空行合并为单个换行
        
        嵌套列表缩进规则：
        - 代码生成的缩进是 2 空格的倍数（"  " * n）
        - XML 源码缩进通常是大量空格或不规则空格，需要移除
        """
        lines = text.split("\n")
        cleaned_lines: List[str] = []
        
        for line in lines:
            stripped = line.lstrip()
            
            # 检查是否为列表项
            is_ul_item = stripped.startswith("- ")
            is_ol_item = bool(re.match(r"^\d+\. ", stripped))
            
            if is_ul_item or is_ol_item:
                # 计算前导空格数
                leading_spaces = len(line) - len(stripped)
                
                # 只保留有效的嵌套缩进（2 的倍数，且不超过合理范围）
                # 代码生成的缩进最多几级，不会超过 10 个空格
                if leading_spaces > 0 and leading_spaces <= 10 and leading_spaces % 2 == 0:
                    # 有效的嵌套缩进，保留
                    cleaned_lines.append(line.rstrip())
                else:
                    # 无效缩进（XML 源码缩进），移除
                    cleaned_lines.append(stripped.rstrip())
            else:
                # 非列表项，移除所有前导空白
                cleaned_lines.append(stripped.rstrip())
        
        text = "\n".join(cleaned_lines)
        
        # 将多个连续换行合并为单个换行
        text = re.sub(r"\n{2,}", "\n", text)
        
        # 合并连续的代码引用：`foo``bar` -> `foobar`
        # 只处理同一行内的情况，避免误删多行代码块的边界（```）
        # 使用负向断言确保不匹配三反引号代码块
        # (?<!`) 确保前面不是反引号，(?!`) 确保后面不是反引号
        text = re.sub(r"(?<!`)`[ \t]*`(?!`)", "", text)
        
        # 移除开头和结尾的空白
        return text.strip()
    
    def convert_text_content(self, element: Optional[etree._Element]) -> str:
        """仅转换元素的纯文本内容（不包括子元素标签）
        
        Args:
            element: 要转换的 XML 元素
            
        Returns:
            纯文本内容
        """
        if element is None:
            return ""
        
        return "".join(element.itertext()).strip()
    
    def _convert_element(
        self,
        element: etree._Element,
        exclude_note: bool = False,
        exclude_dl_meta: bool = False,
    ) -> str:
        """递归转换元素
        
        Args:
            element: XML 元素
            exclude_note: 是否排除 note 元素
            exclude_dl_meta: 是否排除 dl (deprecated/since) 元素
            
        Returns:
            转换后的文本
        """
        tag = etree.QName(element.tag).localname if isinstance(element.tag, str) else str(element.tag)
        
        # 处理不同类型的元素
        if tag == "xref":
            return self._convert_xref(element)
        elif tag == "apiname":
            # 处理 apiname keyref（如 <apiname keyref="IRtcEngine"/>）
            keyref = element.get("keyref")
            if keyref:
                keyword = self.keymap_parser.get_keyword(keyref)
                return f"`{keyword}`"
            # 没有 keyref，返回文本内容
            return f"`{self._convert_children(element)}`"
        elif tag == "ph":
            # 处理 conkeyref 属性（如 <ph conkeyref="xxx/yyy"/>）
            conkeyref = element.get("conkeyref")
            if conkeyref and self.conkeyref_resolver:
                resolved = self.conkeyref_resolver(conkeyref)
                if resolved is not None:
                    element = resolved
            # 处理 keyref 属性（如 <ph keyref="true"/>）
            keyref = element.get("keyref")
            if keyref:
                # 从 keysmap 获取 keyword
                keyword = self.keymap_parser.get_keyword(keyref)
                return keyword
            return self._convert_children(element, exclude_note)
        elif tag == "codeph":
            return self._convert_codeph(element)
        elif tag == "parmname":
            return self._convert_parmname(element)
        elif tag == "ul":
            return self._convert_ul(element, exclude_note, indent=0)
        elif tag == "ol":
            return self._convert_ol(element, exclude_note, indent=0)
        elif tag == "li":
            # li 元素由 _convert_ul/_convert_ol 处理，这里作为后备
            return self._convert_children(element, exclude_note)
        elif tag == "p":
            return self._convert_p(element, exclude_note)
        elif tag == "codeblock":
            return self._convert_codeblock(element)
        elif tag == "simpletable":
            return self._convert_simpletable(element)
        elif tag == "note":
            if exclude_note:
                return ""
            return self._convert_children(element, exclude_note, exclude_dl_meta)
        elif tag == "dl":
            # 检查是否为 deprecated/since 元数据
            outputclass = element.get("outputclass", "")
            if exclude_dl_meta and outputclass in ("deprecated", "since"):
                return ""
            # 非元数据 dl，正常转换
            return self._convert_children(element, exclude_note, exclude_dl_meta)
        else:
            # 默认：递归处理子元素
            return self._convert_children(element, exclude_note, exclude_dl_meta)
    
    def _convert_children(
        self,
        element: etree._Element,
        exclude_note: bool = False,
        exclude_dl_meta: bool = False,
    ) -> str:
        """转换元素的所有子内容（文本和子元素）"""
        result: List[str] = []
        
        # 处理元素开头的文本
        if element.text:
            result.append(element.text)
        
        # 处理子元素
        for child in element:
            child_tag = etree.QName(child.tag).localname if isinstance(child.tag, str) else str(child.tag)
            
            # 检查子元素的 props 是否匹配当前平台
            child_props = child.get("props")
            if not matches_platform(child_props, self.props_platform):
                # props 不匹配，跳过该元素但仍处理 tail
                if child.tail:
                    result.append(child.tail)
                continue
            
            # 跳过 note 元素（如果需要）
            if exclude_note and child_tag == "note":
                # 但仍然处理 tail
                if child.tail:
                    result.append(child.tail)
                continue
            
            # 跳过 deprecated/since dl 元素（如果需要）
            if exclude_dl_meta and child_tag == "dl":
                outputclass = child.get("outputclass", "")
                if outputclass in ("deprecated", "since"):
                    if child.tail:
                        result.append(child.tail)
                    continue
            
            result.append(self._convert_element(child, exclude_note, exclude_dl_meta))
            
            # 处理元素后的文本（tail）
            if child.tail:
                result.append(child.tail)
        
        return "".join(result)
    
    def _convert_xref(self, element: etree._Element) -> str:
        """转换 xref 链接"""
        keyref = element.get("keyref")
        href = element.get("href")
        
        # 获取链接文本（子元素内容）
        link_text = self._convert_children(element).strip()
        
        if keyref:
            # 先检查是否为 API 链接
            api_entry = self.keymap_parser.get_api_entry(keyref)
            if api_entry and api_entry.filepath:
                # API 链接：使用 keyword 作为代码引用
                keyword = api_entry.keyword
                return f"`{keyword}`"
            
            # 检查是否为外部链接
            link_entry = self.keymap_parser.get_link_entry(keyref)
            if link_entry:
                # 外部链接
                url = link_entry.url
                text = link_text if link_text else link_entry.text
                if text:
                    return f"[{text}]({url})"
                else:
                    return url
            
            # 找不到映射，使用 keyref 作为代码引用
            logger.debug(f"未找到 keyref 映射: {keyref}")
            return f"`{keyref}`"
        
        elif href:
            # 直接使用 href 属性的链接
            if link_text:
                return f"[{link_text}]({href})"
            else:
                return href
        
        # 没有 keyref 或 href，返回文本内容
        return link_text if link_text else ""
    
    def _convert_codeph(self, element: etree._Element) -> str:
        """转换 codeph 代码引用"""
        content = self._convert_children(element).strip()
        if content:
            return f"`{content}`"
        return ""
    
    def _convert_parmname(self, element: etree._Element) -> str:
        """转换 parmname 参数名称"""
        content = self._convert_children(element).strip()
        if content:
            return f"`{content}`"
        return ""
    
    def _convert_ul(self, element: etree._Element, exclude_note: bool = False, indent: int = 0) -> str:
        """转换无序列表
        
        Args:
            element: ul 元素
            exclude_note: 是否排除 note 元素
            indent: 缩进级别（每级 2 个空格）
        """
        items: List[str] = []
        indent_str = "  " * indent
        
        for li in element.findall("li"):
            # 处理 conkeyref 引用
            conkeyref = li.get("conkeyref")
            if conkeyref and self.conkeyref_resolver:
                resolved = self.conkeyref_resolver(conkeyref)
                if resolved is not None:
                    li = resolved
                else:
                    # conkeyref 解析失败，跳过
                    continue
            
            # 检查 li 的 props 是否匹配当前平台
            props = li.get("props")
            if not matches_platform(props, self.props_platform):
                continue
            
            content = self._convert_li(li, exclude_note, indent)
            if content:
                items.append(f"{indent_str}- {content}")
        
        if items:
            # 列表前加换行，确保列表项从新行开始
            return "\n" + "\n".join(items) + "\n\n"
        return ""
    
    def _convert_ol(self, element: etree._Element, exclude_note: bool = False, indent: int = 0) -> str:
        """转换有序列表
        
        Args:
            element: ol 元素
            exclude_note: 是否排除 note 元素
            indent: 缩进级别（每级 3 个空格，用于对齐数字后的内容）
        """
        items: List[str] = []
        indent_str = "  " * indent
        
        idx = 1
        for li in element.findall("li"):
            # 处理 conkeyref 引用
            conkeyref = li.get("conkeyref")
            if conkeyref and self.conkeyref_resolver:
                resolved = self.conkeyref_resolver(conkeyref)
                if resolved is not None:
                    li = resolved
                else:
                    # conkeyref 解析失败，跳过
                    continue
            
            # 检查 li 的 props 是否匹配当前平台
            props = li.get("props")
            if not matches_platform(props, self.props_platform):
                continue
            
            content = self._convert_li(li, exclude_note, indent)
            if content:
                items.append(f"{indent_str}{idx}. {content}")
                idx += 1
        
        if items:
            # 列表前加换行，确保列表项从新行开始
            return "\n" + "\n".join(items) + "\n\n"
        return ""
    
    def _convert_li(self, li: etree._Element, exclude_note: bool, indent: int) -> str:
        """转换单个列表项，处理嵌套列表
        
        Args:
            li: li 元素
            exclude_note: 是否排除 note 元素
            indent: 当前缩进级别
        """
        parts: List[str] = []
        
        # 处理 li 的直接文本（保留空格，由 _clean_whitespace 统一处理）
        if li.text:
            parts.append(li.text)
        
        # 处理子元素
        for child in li:
            child_tag = etree.QName(child.tag).localname if isinstance(child.tag, str) else str(child.tag)
            
            # 检查子元素的 props 是否匹配当前平台
            child_props = child.get("props")
            if not matches_platform(child_props, self.props_platform):
                # props 不匹配，跳过该元素但仍处理 tail
                if child.tail:
                    parts.append(child.tail)
                continue
            
            if child_tag == "ul":
                # 处理 ul 的 conkeyref
                ul_conkeyref = child.get("conkeyref")
                if ul_conkeyref and self.conkeyref_resolver:
                    resolved = self.conkeyref_resolver(ul_conkeyref)
                    if resolved is not None:
                        child = resolved
                # 嵌套无序列表，增加缩进
                nested = self._convert_ul(child, exclude_note, indent + 1)
                if nested:
                    parts.append("\n" + nested.rstrip("\n"))
            elif child_tag == "ol":
                # 处理 ol 的 conkeyref
                ol_conkeyref = child.get("conkeyref")
                if ol_conkeyref and self.conkeyref_resolver:
                    resolved = self.conkeyref_resolver(ol_conkeyref)
                    if resolved is not None:
                        child = resolved
                # 嵌套有序列表，增加缩进
                nested = self._convert_ol(child, exclude_note, indent + 1)
                if nested:
                    parts.append("\n" + nested.rstrip("\n"))
            elif child_tag == "note" and exclude_note:
                pass
            else:
                # 其他元素正常转换
                converted = self._convert_element(child, exclude_note)
                if converted:
                    parts.append(converted)
            
            # 处理 tail（保留空格，由 _clean_whitespace 统一处理）
            if child.tail:
                parts.append(child.tail)
        
        # 只清理首尾多余空白，保留中间的空格
        return "".join(parts).strip()
    
    def _convert_p(self, element: etree._Element, exclude_note: bool = False) -> str:
        """转换段落"""
        content = self._convert_children(element, exclude_note).strip()
        if content:
            return content + "\n"
        return ""
    
    def _convert_codeblock(self, element: etree._Element) -> str:
        """转换代码块"""
        # 获取代码内容并反转义 XML 实体
        content = self._get_text_content(element)
        content = self._unescape_xml(content)
        
        if content:
            return f"```\n{content}\n```"
        return ""
    
    def _convert_simpletable(self, element: etree._Element) -> str:
        """转换简单表格"""
        rows: List[List[str]] = []
        header_row: List[str] = []
        
        # 处理表头
        sthead = element.find("sthead")
        if sthead is not None:
            for stentry in sthead.findall("stentry"):
                header_row.append(self._convert_children(stentry).strip())
        
        # 处理数据行
        for strow in element.findall("strow"):
            row: List[str] = []
            for stentry in strow.findall("stentry"):
                row.append(self._convert_children(stentry).strip())
            if row:
                rows.append(row)
        
        if not header_row and not rows:
            return ""
        
        # 构建 Markdown 表格
        result: List[str] = []
        
        # 确定列数
        col_count = max(
            len(header_row) if header_row else 0,
            max((len(row) for row in rows), default=0)
        )
        
        if col_count == 0:
            return ""
        
        # 表头
        if header_row:
            # 补齐列数
            while len(header_row) < col_count:
                header_row.append("")
            result.append("| " + " | ".join(header_row) + " |")
        else:
            # 没有表头，使用空表头
            result.append("| " + " | ".join([""] * col_count) + " |")
        
        # 分隔行
        result.append("| " + " | ".join(["---"] * col_count) + " |")
        
        # 数据行
        for row in rows:
            # 补齐列数
            while len(row) < col_count:
                row.append("")
            result.append("| " + " | ".join(row) + " |")
        
        return "\n".join(result) + "\n\n"
    
    def _get_text_content(self, element: etree._Element) -> str:
        """获取元素的所有文本内容"""
        return "".join(element.itertext())
    
    def _unescape_xml(self, text: str) -> str:
        """反转义 XML 实体"""
        return html.unescape(text)
    
    def extract_note(self, element: etree._Element) -> Optional[str]:
        """从元素中提取 note 内容
        
        Args:
            element: 要搜索的元素
            
        Returns:
            note 内容或 None
        """
        notes: List[str] = []
        
        for note in element.iter("note"):
            # 检查 note 及其祖先元素的 props 是否匹配当前平台
            if not self._check_ancestor_props(note, element):
                continue
            
            content = self._convert_children(note).strip()
            if content:
                notes.append(content)
        
        if notes:
            return "\n".join(notes)
        return None

    def extract_dl_meta(self, element: etree._Element) -> Optional[str]:
        """从元素中提取 deprecated/since dl 内容
        
        Args:
            element: 要搜索的元素
            
        Returns:
            deprecated/since 内容或 None
        """
        results: List[str] = []
        
        for dl in element.iter("dl"):
            outputclass = dl.get("outputclass", "")
            if outputclass in ("deprecated", "since"):
                # 检查 dl 及其祖先元素的 props 是否匹配当前平台
                if not self._check_ancestor_props(dl, element):
                    continue
                
                # 提取 dlentry 中的 dt 和 dd
                for dlentry in dl.findall("dlentry"):
                    # 检查 dlentry 的 props 是否匹配当前平台
                    dlentry_props = dlentry.get("props")
                    if not matches_platform(dlentry_props, self.props_platform):
                        continue
                    
                    dt = dlentry.find("dt")
                    dd = dlentry.find("dd")
                    
                    dt_text = self._convert_children(dt).strip() if dt is not None else ""
                    dd_text = self._convert_children(dd).strip() if dd is not None else ""
                    
                    if dt_text and dd_text:
                        results.append(f"{dt_text}{dd_text}")
                    elif dt_text:
                        results.append(dt_text)
                    elif dd_text:
                        results.append(dd_text)
        
        if results:
            return "\n".join(results)
        return None
    
    def _check_ancestor_props(self, target: etree._Element, root: etree._Element) -> bool:
        """检查目标元素及其祖先元素的 props 是否都匹配当前平台
        
        Args:
            target: 目标元素
            root: 根元素（停止检查的边界）
            
        Returns:
            如果所有祖先的 props 都匹配（或没有 props），返回 True
        """
        current = target
        while current is not None and current != root:
            props = current.get("props")
            if not matches_platform(props, self.props_platform):
                return False
            current = current.getparent()
        return True

