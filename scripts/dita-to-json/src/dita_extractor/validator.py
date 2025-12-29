"""数据验证模块"""

import re
from typing import Any, Dict, List

from loguru import logger

from .models import ValidationError, ValidationResult


class Validator:
    """JSON 数据验证器"""
    
    # XML/DITA 标签检测正则
    # 只匹配明确的 DITA/XML 标签，如 <xref>, <ph>, <note>, <p>, <ul>, <li> 等
    DITA_TAGS = [
        "xref", "ph", "note", "p", "ul", "ol", "li", "dl", "dt", "dd",
        "dlentry", "codeblock", "codeph", "parmname", "simpletable",
        "sthead", "strow", "stentry", "parml", "plentry", "pt", "pd",
        "section", "title", "shortdesc", "prolog", "refbody", "reference",
        "topicref", "keydef", "keyword", "indexterm", "metadata",
    ]
    XML_TAG_PATTERN = re.compile(
        r"<(" + "|".join(DITA_TAGS) + r")(?:\s+[^>]*)?>",
        re.IGNORECASE
    )
    
    def validate(self, json_data: List[Dict[str, Any]]) -> ValidationResult:
        """验证 JSON 数据
        
        Args:
            json_data: 要验证的 JSON 数据（平台列表）
            
        Returns:
            ValidationResult
        """
        errors: List[ValidationError] = []
        
        for platform_data in json_data:
            changes = platform_data.get("changes", {})
            
            # 验证 api_changes
            for item in changes.get("api_changes", []):
                self._validate_api_item(item, errors)
            
            # 验证 struct_changes
            for item in changes.get("struct_changes", []):
                self._validate_struct_item(item, errors)
            
            # 验证 enum_changes
            for item in changes.get("enum_changes", []):
                self._validate_enum_item(item, errors)
        
        is_valid = len(errors) == 0
        
        if not is_valid:
            logger.warning(f"验证发现 {len(errors)} 个错误")
            for error in errors[:10]:  # 只显示前 10 个
                logger.warning(f"  [{error.item_type}] {error.key}: {error.field} - {error.message}")
            if len(errors) > 10:
                logger.warning(f"  ... 还有 {len(errors) - 10} 个错误")
        
        return ValidationResult(is_valid=is_valid, errors=errors)
    
    def _validate_api_item(self, item: Dict[str, Any], errors: List[ValidationError]) -> None:
        """验证 api_changes 列表项"""
        details = item.get("details", {})
        key = details.get("api_name", "unknown")
        
        # 必填字段检查
        required_fields = [
            ("api_name", details.get("api_name")),
            ("api_signature", details.get("api_signature")),
            ("shortdesc", details.get("shortdesc")),
            ("platforms", details.get("platforms")),
            ("parent_class", details.get("parent_class")),
        ]
        
        for field_name, field_value in required_fields:
            if not field_value:
                errors.append(ValidationError(
                    item_type="api",
                    key=key,
                    field=field_name,
                    message=f"必填字段为空",
                ))
        
        # XML 残留检测
        self._check_xml_residue(item, "api", key, errors)
    
    def _validate_struct_item(self, item: Dict[str, Any], errors: List[ValidationError]) -> None:
        """验证 struct_changes 列表项"""
        details = item.get("details", {})
        key = details.get("struct_name", "unknown")
        
        # 必填字段检查（struct 的 parent_class 允许为空）
        required_fields = [
            ("struct_name", details.get("struct_name")),
            ("shortdesc", details.get("shortdesc")),
            ("platforms", details.get("platforms")),
        ]
        
        for field_name, field_value in required_fields:
            if not field_value:
                errors.append(ValidationError(
                    item_type="struct",
                    key=key,
                    field=field_name,
                    message=f"必填字段为空",
                ))
        
        # XML 残留检测
        self._check_xml_residue(item, "struct", key, errors)
    
    def _validate_enum_item(self, item: Dict[str, Any], errors: List[ValidationError]) -> None:
        """验证 enum_changes 列表项"""
        details = item.get("details", {})
        key = details.get("enum_name", "unknown")
        
        # 必填字段检查（enum 的 parent_class 允许为空）
        required_fields = [
            ("enum_name", details.get("enum_name")),
            ("shortdesc", details.get("shortdesc")),
            ("platforms", details.get("platforms")),
        ]
        
        for field_name, field_value in required_fields:
            if not field_value:
                errors.append(ValidationError(
                    item_type="enum",
                    key=key,
                    field=field_name,
                    message=f"必填字段为空",
                ))
        
        # XML 残留检测
        self._check_xml_residue(item, "enum", key, errors)
    
    def _check_xml_residue(
        self,
        item: Dict[str, Any],
        item_type: str,
        key: str,
        errors: List[ValidationError],
    ) -> None:
        """检查 XML 残留"""
        self._check_xml_in_value(item, item_type, key, "", errors)
    
    def _check_xml_in_value(
        self,
        value: Any,
        item_type: str,
        key: str,
        path: str,
        errors: List[ValidationError],
    ) -> None:
        """递归检查值中的 XML 残留"""
        if isinstance(value, str):
            if self.XML_TAG_PATTERN.search(value):
                errors.append(ValidationError(
                    item_type=item_type,
                    key=key,
                    field=path or "root",
                    message=f"发现 XML 残留: {value[:100]}...",
                ))
        elif isinstance(value, dict):
            for k, v in value.items():
                new_path = f"{path}.{k}" if path else k
                self._check_xml_in_value(v, item_type, key, new_path, errors)
        elif isinstance(value, list):
            for i, v in enumerate(value):
                new_path = f"{path}[{i}]"
                self._check_xml_in_value(v, item_type, key, new_path, errors)

