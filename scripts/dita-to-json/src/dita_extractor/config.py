"""平台映射和路径配置"""

from dataclasses import dataclass
from pathlib import Path
from typing import Dict, Set


@dataclass(frozen=True)
class PlatformConfig:
    """平台配置信息"""
    json_platform: str      # JSON 输出平台名
    props_platform: str     # props 属性值
    ditamap_platform: str   # ditamap 文件名后缀
    keysmap_platform: str   # keysmap 文件名后缀
    linksmap_platform: str  # linksmap 文件名后缀
    language_platform: str  # codeblock outputclass 语言


# 12 个平台完整映射
PLATFORM_CONFIGS: Dict[str, PlatformConfig] = {
    "electron": PlatformConfig("electron", "electron", "Electron", "electron", "electron", "typescript"),
    "flutter": PlatformConfig("flutter", "flutter", "Flutter", "flutter", "flutter", "dart"),
    "rn": PlatformConfig("rn", "rn", "RN", "rn", "rn", "typescript"),
    "unity": PlatformConfig("unity", "unity", "UNITY", "unity", "unity", "csharp"),
    "csharp": PlatformConfig("csharp", "cs", "CS", "unity", "unity", "csharp"),
    "unreal-cpp": PlatformConfig("unreal-cpp", "unreal", "Unreal", "unreal", "unreal-cpp", "cpp"),
    "unreal-bp": PlatformConfig("unreal-bp", "bp", "Blueprint", "blueprint", "unreal-blueprint", "cpp"),
    "windows": PlatformConfig("windows", "cpp", "CPP", "cpp", "cpp", "cpp"),
    "ios": PlatformConfig("ios", "ios", "iOS", "ios", "ios", "objectivec"),
    "android": PlatformConfig("android", "android", "Android", "java", "android", "java"),
    "macos": PlatformConfig("macos", "mac", "macOS", "macos", "macos", "objectivec"),
    "harmonyos": PlatformConfig("harmonyos", "hmos", "Harmony", "harmony", "harmony", "arkts"),
}

# props 展开映射
PROPS_EXPANSION: Dict[str, Set[str]] = {
    "framework": {"electron", "flutter", "rn", "unity", "cs", "unreal", "bp"},
    "native": {"android", "ios", "mac", "cpp", "hmos"},
    "apple": {"mac", "ios"},
}


def get_ditamap_path(base_dir: Path, platform_config: PlatformConfig) -> Path:
    """获取 ditamap 文件路径"""
    return base_dir / f"RTC_NG_API_{platform_config.ditamap_platform}.ditamap"


def get_keysmap_path(base_dir: Path, platform_config: PlatformConfig) -> Path:
    """获取 keysmap 文件路径"""
    return base_dir / "config" / f"keys-rtc-ng-api-{platform_config.keysmap_platform}.ditamap"


def get_linksmap_paths(base_dir: Path, platform_config: PlatformConfig) -> tuple[Path, Path]:
    """获取 linksmap 文件路径（通用 + 平台专用）"""
    common = base_dir / "config" / "keys-rtc-ng-links.ditamap"
    platform_specific = base_dir / "config" / f"keys-rtc-ng-links-{platform_config.linksmap_platform}.ditamap"
    return common, platform_specific


def get_datatype_path(base_dir: Path) -> Path:
    """获取 datatype 文件路径"""
    return base_dir / "API" / "rtc_api_data_type.dita"


def matches_platform(props_attr: str | None, target_props: str) -> bool:
    """判断元素是否匹配目标平台
    
    Args:
        props_attr: 元素的 props 属性值，可能为 None
        target_props: 目标平台的 props_platform 值
        
    Returns:
        True 如果元素应该在目标平台显示
    """
    # 无 props 属性表示支持所有平台
    if props_attr is None:
        return True
    
    # hide 表示不支持任何平台
    if props_attr == "hide":
        return False
    
    # cn/en 表示语言过滤，等效于支持所有平台
    if props_attr in ("cn", "en"):
        return True
    
    # 展开并检查
    expanded: Set[str] = set()
    for p in props_attr.split():
        if p in PROPS_EXPANSION:
            expanded.update(PROPS_EXPANSION[p])
        else:
            expanded.add(p)
    
    return target_props in expanded

