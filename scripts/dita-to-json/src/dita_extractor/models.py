"""数据模型定义"""

from dataclasses import dataclass, field
from typing import List, Optional


@dataclass
class ScopeResult:
    """提取范围结果"""
    interface_keys: List[str] = field(default_factory=list)  # 接口类 key
    api_keys: List[str] = field(default_factory=list)        # API/Callback key
    class_keys: List[str] = field(default_factory=list)      # 普通类 key
    enum_keys: List[str] = field(default_factory=list)       # 枚举类 key


@dataclass
class KeymapEntry:
    """keysmap 条目"""
    key: str           # API/类/枚举的 key
    filepath: str      # 对应的 dita 文件路径
    keyword: str       # 显示名称


@dataclass
class LinkEntry:
    """linksmap 条目"""
    key: str           # 链接的 key
    url: str           # 链接地址
    text: str          # 链接文本（可能为空）


@dataclass
class ParameterInfo:
    """参数信息"""
    name: str
    desc: str
    note: Optional[str] = None


@dataclass
class DetailedDesc:
    """详细描述"""
    since: Optional[str] = None
    desc: Optional[str] = None
    deprecated: Optional[str] = None
    note: Optional[str] = None


@dataclass
class ParsedApi:
    """解析后的 API/Callback 数据"""
    key: str
    signature: str
    shortdesc: str
    detailed_desc: Optional[DetailedDesc] = None
    scenarios: Optional[str] = None
    related: Optional[str] = None
    timing: Optional[str] = None
    parameters: List[ParameterInfo] = field(default_factory=list)
    return_value: Optional[str] = None
    is_callback: bool = False


@dataclass
class ParsedStruct:
    """解析后的 Struct/Class 数据"""
    key: str
    signature: str
    shortdesc: str
    detailed_desc: Optional[DetailedDesc] = None
    parameters: List[ParameterInfo] = field(default_factory=list)
    is_interface: bool = False  # 是否为接口类


@dataclass
class ParsedEnum:
    """解析后的 Enum 数据"""
    key: str
    shortdesc: str
    detailed_desc: Optional[DetailedDesc] = None
    parameters: List[ParameterInfo] = field(default_factory=list)  # 枚举值列表


@dataclass
class ValidationError:
    """验证错误"""
    item_type: str   # api/struct/enum
    key: str         # 项目 key
    field: str       # 字段名
    message: str     # 错误信息


@dataclass
class ValidationResult:
    """验证结果"""
    is_valid: bool
    errors: List[ValidationError] = field(default_factory=list)


@dataclass
class ExtractionStats:
    """提取统计信息"""
    api_count: int = 0
    callback_count: int = 0
    struct_count: int = 0
    enum_count: int = 0
    error_count: int = 0

