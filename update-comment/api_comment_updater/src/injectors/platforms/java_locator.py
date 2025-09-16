# -*- coding: utf-8 -*-
"""
Java平台特定的代码定位器
"""

import re
from typing import List, Dict, Any, Optional, Tuple
from loguru import logger

from ...utils.file_utils import read_file_content
from .base import BaseLocator


class JavaLocator(BaseLocator):
    """Java代码定位器"""
    
    def locate_api(self, api_data: Dict[str, Any]) -> Optional[Tuple[str, int]]:
        """
        定位API在代码中的位置 - Java版本
        
        Args:
            api_data: API数据，包含name、signature、parent_class等信息
            
        Returns:
            Tuple[str, int]: (文件路径, 行号)，如果未找到返回None
        """
        # TODO: 实现Java特定的API定位逻辑
        # 暂时使用基础实现，后续根据Java特性进行优化
        logger.debug("Java API定位 - 待实现")
        return None
    
    def locate_class(self, class_data: Dict[str, Any]) -> Optional[Tuple[str, int]]:
        """
        定位类在代码中的位置 - Java版本
        
        Args:
            class_data: 类数据
            
        Returns:
            Tuple[str, int]: (文件路径, 行号)，如果未找到返回None
        """
        # TODO: 实现Java特定的类定位逻辑
        logger.debug("Java 类定位 - 待实现")
        return None
    
    def locate_enum(self, enum_data: Dict[str, Any]) -> Optional[Tuple[str, int]]:
        """
        定位枚举在代码中的位置 - Java版本
        
        Args:
            enum_data: 枚举数据
            
        Returns:
            Tuple[str, int]: (文件路径, 行号)，如果未找到返回None
        """
        # TODO: 实现Java特定的枚举定位逻辑
        logger.debug("Java 枚举定位 - 待实现")
        return None
    
    def locate_class_attribute(self, class_data: Dict[str, Any], attribute_name: str) -> Optional[Tuple[str, int]]:
        """
        定位类属性在代码中的位置 - Java版本
        
        Args:
            class_data: 类数据
            attribute_name: 属性名称
            
        Returns:
            Tuple[str, int]: (文件路径, 行号)，如果未找到返回None
        """
        # TODO: 实现Java特定的属性定位逻辑
        logger.debug("Java 属性定位 - 待实现")
        return None
    
    def locate_enum_value(self, enum_data: Dict[str, Any], value_name: str) -> Optional[Tuple[str, int]]:
        """
        定位枚举值在代码中的位置 - Java版本
        
        Args:
            enum_data: 枚举数据
            value_name: 枚举值名称
            
        Returns:
            Tuple[str, int]: (文件路径, 行号)，如果未找到返回None
        """
        # TODO: 实现Java特定的枚举值定位逻辑
        logger.debug("Java 枚举值定位 - 待实现")
        return None
    
    # ==================== Java特定实现 ====================
    
    def _clean_signature(self, signature: str) -> str:
        """
        清理Java签名，移除注解、HTML标签和多余空白
        
        Args:
            signature: 原始Java签名
            
        Returns:
            str: 清理后的签名
        """
        # 移除HTML标签
        clean_sig = re.sub(r'<[^>]+>', '', signature)
        
        # 移除Java注解（如@CalledByNative, @Override等）
        clean_sig = re.sub(r'@\w+\s+', '', clean_sig)
        
        # 统一空白字符，包括换行符
        clean_sig = re.sub(r'\s+', ' ', clean_sig)
        
        # 移除首尾空白
        clean_sig = clean_sig.strip()
        
        return clean_sig
    
    def _clean_code_line_for_matching(self, line: str) -> str:
        """
        清理Java代码行，移除注解等
        
        Args:
            line: 原始Java代码行
            
        Returns:
            str: 清理后的代码行
        """
        # 移除Java注解（如@CalledByNative, @Override等）
        clean_line = re.sub(r'@\w+\s+', '', line)
        
        # 统一空白字符
        clean_line = re.sub(r'\s+', ' ', clean_line)
        
        # 移除首尾空白
        clean_line = clean_line.strip()
        
        return clean_line
    
    def _is_attribute_definition_enhanced(self, line: str, attribute_name: str) -> bool:
        """
        Java属性定义检测
        
        Args:
            line: 已经strip()的代码行
            attribute_name: 属性名称
            
        Returns:
            bool: 是否为Java属性定义
        """
        # 跳过访问修饰符行
        if line in ['public:', 'private:', 'protected:']:
            return False
        
        # 跳过明显的函数定义
        if '(' in line and ')' in line:
            return False
        
        # 跳过赋值语句（关键改进）
        if '=' in line and not line.endswith(';'):
            return False
        
        # 跳过明显的赋值语句模式（但不跳过带类型的属性声明）
        # 只跳过没有类型前缀的赋值语句
        assignment_patterns = [
            rf"^\s*{re.escape(attribute_name)}\s*=",  # 行开头直接是 name = （没有类型）
        ]
        
        for pattern in assignment_patterns:
            if re.search(pattern, line):
                logger.debug("跳过赋值语句: {}", line)
                return False
        
        # Java属性定义模式
        java_patterns = [
            # Java访问修饰符：public/private/protected type name;
            rf"\b(?:public\s+|private\s+|protected\s+)\w+\s+{re.escape(attribute_name)}\s*;",
            # Java访问修饰符带默认值：public type name = value;
            rf"\b(?:public\s+|private\s+|protected\s+)\w+\s+{re.escape(attribute_name)}\s*=\s*[^;]+;",
            # Java静态属性：public static type name;
            rf"\b(?:public\s+|private\s+|protected\s+)?(?:static\s+|final\s+)*\w+\s+{re.escape(attribute_name)}\s*;",
            # Java静态属性带默认值：public static type name = value;
            rf"\b(?:public\s+|private\s+|protected\s+)?(?:static\s+|final\s+)*\w+\s+{re.escape(attribute_name)}\s*=\s*[^;]+;",
        ]
        
        for pattern in java_patterns:
            if re.search(pattern, line):
                logger.debug("匹配Java属性声明模式: {}", line)
                return True
        
        return False
    
    def _is_enum_value_definition(self, line: str, value_name: str) -> bool:
        """
        Java枚举值定义检测
        
        Args:
            line: 代码行
            value_name: 枚举值名
            
        Returns:
            bool: 是否为Java枚举值定义
        """
        # Java枚举值模式：public final static int VALUE_NAME = 0x00000001;
        java_patterns = [
            # 标准Java枚举值：public final static int VALUE_NAME = value;
            rf"\b(?:public\s+|private\s+|protected\s+)?(?:final\s+)?(?:static\s+)?\w+\s+{re.escape(value_name)}\s*=",
            # 简化模式：static int VALUE_NAME = value;
            rf"\bstatic\s+\w+\s+{re.escape(value_name)}\s*=",
            # 最简模式：int VALUE_NAME = value;
            rf"\b\w+\s+{re.escape(value_name)}\s*=",
        ]
        
        for pattern in java_patterns:
            if re.search(pattern, line):
                return True
        
        return False
    
    def _find_nearest_parent_class(self, lines: List[str], api_line_index: int) -> Optional[str]:
        """
        从指定位置向上搜索，找到最近的Java类声明
        
        Args:
            lines: 文件行列表
            api_line_index: API所在行的索引（0-based）
            
        Returns:
            Optional[str]: 找到的类名，如果未找到返回None
        """
        # Java类声明模式
        java_class_patterns = [
            # public interface ClassName {
            r"^\s*(?:public\s+|private\s+|protected\s+)?interface\s+([\w<>]+)\s*\{",
            # public abstract class ClassName extends ParentClass {
            r"^\s*(?:public\s+|private\s+|protected\s+)?(?:abstract\s+)?class\s+([\w<>]+)(?:\s+extends\s+[\w<>]+)?\s*\{",
            # public static class ClassName {
            r"^\s*(?:public\s+|private\s+|protected\s+)?(?:static\s+)?class\s+([\w<>]+)\s*\{",
            # 简化模式：interface ClassName {
            r"^\s*interface\s+([\w<>]+)\s*\{",
            # 简化模式：class ClassName extends ParentClass {
            r"^\s*class\s+([\w<>]+)(?:\s+extends\s+[\w<>]+)?\s*\{",
        ]
        
        # 编译正则表达式
        compiled_patterns = []
        for pattern in java_class_patterns:
            try:
                compiled_patterns.append(re.compile(pattern))
            except re.error as e:
                logger.warning("Java类检测正则表达式错误: {}", str(e))
                continue
        
        # 从API位置向上搜索
        brace_count = 0
        for i in range(api_line_index, -1, -1):
            line = lines[i]
            
            # 计算大括号层级（向上搜索时反向计算）
            for char in reversed(line):
                if char == '}':
                    brace_count += 1
                elif char == '{':
                    brace_count -= 1
            
            # 检查是否匹配Java类声明模式
            for pattern in compiled_patterns:
                match = pattern.search(line)
                if match and brace_count <= 0:  # 确保在正确的作用域层级
                    class_name = match.group(1)
                    logger.debug("找到Java父类: {} 在行 {}", class_name, i + 1)
                    return class_name
        
        return None
