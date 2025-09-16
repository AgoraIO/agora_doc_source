# -*- coding: utf-8 -*-
"""
C++平台特定的代码定位器
"""

import re
from typing import List, Dict, Any, Optional, Tuple
from loguru import logger

from ...utils.file_utils import read_file_content
from .base import BaseLocator


class CppLocator(BaseLocator):
    """C++代码定位器"""
    
    def locate_api(self, api_data: Dict[str, Any]) -> Optional[Tuple[str, int]]:
        """
        定位API在代码中的位置
        
        优化后的统一定位策略：
        1. 关键字+纯净API名匹配
        2. 完整签名匹配  
        3. 增强签名匹配
        4. 纯净名称匹配
        5. parent_class验证（处理多结果情况）
        
        Args:
            api_data: API数据，包含name、signature、parent_class等信息
            
        Returns:
            Tuple[str, int]: (文件路径, 行号)，如果未找到返回None
        """
        api_name = api_data.get("name", "")
        api_signature = api_data.get("signature", "")
        parent_class = api_data.get("parent_class", "")
        
        if not api_name:
            logger.warning("API名称为空，跳过定位")
            return None
        
        # 提取纯净API名称（去除重载标识、OC参数等）
        clean_name = self._extract_clean_api_name(api_name)
        logger.debug("开始定位API: {} (clean_name: {}, parent_class: {})", 
                    api_name, clean_name, parent_class)
        
        # 获取搜索文件列表
        search_files = self._get_search_files()
        if not search_files:
            logger.warning("未找到搜索文件")
            return None
        
        logger.debug("搜索文件数量: {}", len(search_files))
        
        # 存储各步骤的候选结果，用于后续parent_class验证
        step_candidates = {}
        
        # 步骤1: 关键字+纯净API名匹配（命中率最高，性能开销最小）
        candidates = self._find_all_keywords_name_matches(clean_name, api_signature, search_files)
        if len(candidates) == 1:
            logger.info("通过关键字+名称定位到API {}: {}:{}", api_name, candidates[0][0], candidates[0][1])
            return candidates[0]
        elif len(candidates) > 1:
            step_candidates[1] = candidates
            logger.debug("关键字+名称匹配找到 {} 个候选位置", len(candidates))
        
        # 步骤2: 完整签名匹配
        if api_signature:
            candidates = self._find_all_signature_matches(api_signature, search_files)
            if len(candidates) == 1:
                logger.info("通过完整签名定位到API {}: {}:{}", api_name, candidates[0][0], candidates[0][1])
                return candidates[0]
            elif len(candidates) > 1:
                step_candidates[2] = candidates
                logger.debug("完整签名匹配找到 {} 个候选位置", len(candidates))
        
        # 步骤3: 增强签名匹配（性能开销较大，尽量减少调用）
        if api_signature:
            candidates = self._find_all_signature_matches_enhanced(api_signature, search_files)
            if len(candidates) == 1:
                logger.info("通过增强签名定位到API {}: {}:{}", api_name, candidates[0][0], candidates[0][1])
                return candidates[0]
            elif len(candidates) > 1:
                step_candidates[3] = candidates
                logger.debug("增强签名匹配找到 {} 个候选位置", len(candidates))
        
        # 步骤4: 纯净名称匹配
        candidates = self._find_all_name_matches(clean_name, search_files)
        if len(candidates) == 1:
            logger.info("通过名称定位到API {}: {}:{}", api_name, candidates[0][0], candidates[0][1])
            return candidates[0]
        elif len(candidates) > 1:
            step_candidates[4] = candidates
            logger.debug("名称匹配找到 {} 个候选位置", len(candidates))
        
        # 步骤5: parent_class验证（处理多结果情况）
        if step_candidates and parent_class:
            # 选择结果数量最少的步骤，数量相同按步骤顺序
            min_count = min(len(candidates) for candidates in step_candidates.values())
            selected_step = min(step for step, candidates in step_candidates.items() 
                              if len(candidates) == min_count)
            
            selected_candidates = step_candidates[selected_step]
            logger.debug("选择步骤 {} 的 {} 个候选位置进行parent_class验证", selected_step, len(selected_candidates))
            
            # 进行parent_class验证
            for file_path, line_num in selected_candidates:
                if self._validate_parent_class(file_path, line_num, parent_class):
                    logger.info("通过parent_class验证定位到API {}: {}:{}", api_name, file_path, line_num)
                    return (file_path, line_num)
            
            logger.error("parent_class验证失败，所有候选位置都不属于类 {}", parent_class)
        elif step_candidates:
            logger.error("找到多个候选位置但缺少parent_class信息，无法进一步筛选")
        
        logger.error("未能定位API: {}", api_name)
        return None
    
    def locate_class(self, class_data: Dict[str, Any]) -> Optional[Tuple[str, int]]:
        """
        定位类在代码中的位置
        
        Args:
            class_data: 类数据
            
        Returns:
            Tuple[str, int]: (文件路径, 行号)，如果未找到返回None
        """
        class_name = class_data.get("name", "")
        class_signature = class_data.get("signature", "")
        
        if not class_name:
            logger.warning("类名称为空，跳过定位")
            return None
        
        logger.debug("开始定位类: {}", class_name)
        
        search_files = self._get_search_files()
        
        # 策略1: 签名匹配
        if class_signature:
            location = self._search_by_signature(class_signature, search_files)
            if location:
                logger.info("通过签名定位到类 {}: {}:{}", class_name, location[0], location[1])
                return location
        
        # 策略2: 类名匹配
        location = self._search_by_class_name(class_name, search_files)
        if location:
            logger.info("通过名称定位到类 {}: {}:{}", class_name, location[0], location[1])
            return location
        
        logger.warning("未能定位类: {}", class_name)
        return None
    
    def locate_enum(self, enum_data: Dict[str, Any]) -> Optional[Tuple[str, int]]:
        """
        定位枚举在代码中的位置
        
        Args:
            enum_data: 枚举数据
            
        Returns:
            Tuple[str, int]: (文件路径, 行号)，如果未找到返回None
        """
        enum_name = enum_data.get("name", "")
        
        if not enum_name:
            logger.warning("枚举名称为空，跳过定位")
            return None
        
        logger.debug("开始定位枚举: {}", enum_name)
        
        search_files = self._get_search_files()
        
        # 搜索枚举定义
        location = self._search_by_enum_name(enum_name, search_files)
        if location:
            logger.info("定位到枚举 {}: {}:{}", enum_name, location[0], location[1])
            return location
        
        logger.warning("未能定位枚举: {}", enum_name)
        return None
    
    def locate_class_attribute(self, class_data: Dict[str, Any], attribute_name: str) -> Optional[Tuple[str, int]]:
        """
        定位类属性在代码中的位置
        
        Args:
            class_data: 类数据
            attribute_name: 属性名称
            
        Returns:
            Tuple[str, int]: (文件路径, 行号)，如果未找到返回None
        """
        # 先定位类
        class_location = self.locate_class(class_data)
        if not class_location:
            return None
        
        file_path, class_line = class_location
        
        try:
            content = read_file_content(file_path)
        except Exception as e:
            logger.debug("读取文件失败 {}: {}", file_path, str(e))
            return None
        if content is None:
            return None
        lines = content.split('\n')
        
        # 从类定义开始向下搜索属性
        class_start = class_line - 1  # 转为0-based索引
        
        # 找到类的结束位置（匹配大括号）
        class_end = self._find_class_end(lines, class_start)
        if class_end is None:
            logger.warning("未找到类 {} 的结束位置", class_data.get("name"))
            return None
        
        # 使用增强的属性搜索策略
        attribute_location = self._search_attribute_enhanced(lines, class_start, class_end, attribute_name)
        if attribute_location:
            logger.info("定位到属性 {}: {}:{}", attribute_name, file_path, attribute_location + 1)
            return (file_path, attribute_location + 1)
        
        logger.warning("未在类 {} 中找到属性 {}", class_data.get("name"), attribute_name)
        return None
    
    def locate_enum_value(self, enum_data: Dict[str, Any], value_name: str) -> Optional[Tuple[str, int]]:
        """
        定位枚举值在代码中的位置
        
        Args:
            enum_data: 枚举数据
            value_name: 枚举值名称
            
        Returns:
            Tuple[str, int]: (文件路径, 行号)，如果未找到返回None
        """
        # 先定位枚举
        enum_location = self.locate_enum(enum_data)
        if not enum_location:
            return None
        
        file_path, enum_line = enum_location
        
        try:
            content = read_file_content(file_path)
            if content is None:
                return None
            lines = content.split('\n')
            
            # 从枚举定义开始向下搜索枚举值
            enum_start = enum_line - 1  # 转为0-based索引
            
            # 找到枚举的结束位置（匹配大括号）
            enum_end = self._find_enum_end(lines, enum_start)
            if enum_end is None:
                logger.warning("未找到枚举 {} 的结束位置", enum_data.get("name"))
                return None
            
            # 在枚举定义范围内搜索枚举值
            for i in range(enum_start + 1, enum_end):
                line = lines[i].strip()
                
                # 跳过注释和空行
                if not line or line.startswith('//') or line.startswith('*') or line.startswith('/**') or line == '*/':
                    continue
                
                # 搜索枚举值定义
                if self._is_enum_value_definition(line, value_name):
                    logger.info("定位到枚举值 {}: {}:{}", value_name, file_path, i + 1)
                    return (file_path, i + 1)
            
            logger.warning("未在枚举 {} 中找到枚举值 {}", enum_data.get("name"), value_name)
            return None
            
        except Exception as e:
            logger.error("定位枚举值失败 {}: {}", value_name, str(e))
            return None
    
    # ==================== C++特定实现 ====================
    
    def _clean_signature(self, signature: str) -> str:
        """
        清理C++签名，移除HTML标签和多余空白
        
        Args:
            signature: 原始C++签名
            
        Returns:
            str: 清理后的签名
        """
        # 移除HTML标签
        clean_sig = re.sub(r'<[^>]+>', '', signature)
        
        # 统一空白字符
        clean_sig = re.sub(r'\s+', ' ', clean_sig)
        
        # 移除首尾空白
        clean_sig = clean_sig.strip()
        
        return clean_sig
    
    def _clean_code_line_for_matching(self, line: str) -> str:
        """
        清理C++代码行
        
        Args:
            line: 原始C++代码行
            
        Returns:
            str: 清理后的代码行
        """
        # C++暂时不需要特殊清理，直接返回去除首尾空白的行
        return line.strip()
    
    def _is_attribute_definition_enhanced(self, line: str, attribute_name: str) -> bool:
        """
        C++属性定义检测
        
        Args:
            line: 已经strip()的代码行
            attribute_name: 属性名称
            
        Returns:
            bool: 是否为C++属性定义
        """
        # 特殊处理：OPTIONAL_ENUM_SIZE_T 枚举定义
        if attribute_name == 'OPTIONAL_ENUM_SIZE_T' and 'OPTIONAL_ENUM_SIZE_T{' in line:
            return True
        
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
        
        # C++属性定义模式
        cpp_patterns = [
            # 标准声明：type name;
            rf"\b\w+\s+{re.escape(attribute_name)}\s*;",
            # 带默认值的声明：type name = value;
            rf"\b\w+\s+{re.escape(attribute_name)}\s*=\s*[^;]+;",
            # 带修饰符：const/static type name;
            rf"\b(?:const\s+|static\s+)?\w+\s+{re.escape(attribute_name)}\s*;",
            # 带修饰符和默认值：const/static type name = value;
            rf"\b(?:const\s+|static\s+)?\w+\s+{re.escape(attribute_name)}\s*=\s*[^;]+;",
            # 模板类型：Template<T> name;
            rf"\b\w+<[^>]+>\s+{re.escape(attribute_name)}\s*;",
            # 模板类型带默认值：Template<T> name = value;
            rf"\b\w+<[^>]+>\s+{re.escape(attribute_name)}\s*=\s*[^;]+;",
            # 指针类型：type* name; 或 type *name;
            rf"\b\w+\s*\*\s*{re.escape(attribute_name)}\s*;",
            # 指针类型带默认值：type* name = value;
            rf"\b\w+\s*\*\s*{re.escape(attribute_name)}\s*=\s*[^;]+;",
            # 引用类型：type& name;
            rf"\b\w+\s*&\s*{re.escape(attribute_name)}\s*;",
            # 数组类型：type name[size];
            rf"\b\w+\s+{re.escape(attribute_name)}\s*\[[^\]]*\]\s*;",
            # 行尾注释的情况：type name;  // comment
            rf"\b\w+\s+{re.escape(attribute_name)}\s*;\s*//",
            
            # ========== 带后置修饰符的模式 ==========
            # 带 __deprecated 等后置修饰符：type name __deprecated;
            rf"\b\w+\s+{re.escape(attribute_name)}\s+__\w+\s*;",
            # 带后置修饰符和默认值：type name __deprecated = value;
            rf"\b\w+\s+{re.escape(attribute_name)}\s+__\w+\s*=\s*[^;]+;",
            # 带前置和后置修饰符：const type name __deprecated;
            rf"\b(?:const\s+|static\s+)?\w+\s+{re.escape(attribute_name)}\s+__\w+\s*;",
            # 带前置和后置修饰符和默认值：const type name __deprecated = value;
            rf"\b(?:const\s+|static\s+)?\w+\s+{re.escape(attribute_name)}\s+__\w+\s*=\s*[^;]+;",
            # 模板类型带后置修饰符：Template<T> name __deprecated;
            rf"\b\w+<[^>]+>\s+{re.escape(attribute_name)}\s+__\w+\s*;",
            # 指针类型带后置修饰符：type* name __deprecated;
            rf"\b\w+\s*\*\s*{re.escape(attribute_name)}\s+__\w+\s*;",
            # 引用类型带后置修饰符：type& name __deprecated;
            rf"\b\w+\s*&\s*{re.escape(attribute_name)}\s+__\w+\s*;",
            # 行尾注释带后置修饰符：type name __deprecated;  // comment
            rf"\b\w+\s+{re.escape(attribute_name)}\s+__\w+\s*;\s*//",
        ]
        
        for pattern in cpp_patterns:
            if re.search(pattern, line):
                logger.debug("匹配C++属性声明模式: {}", line)
                return True
        
        return False
    
    def _is_enum_value_definition(self, line: str, value_name: str) -> bool:
        """
        C++枚举值定义检测
        
        Args:
            line: 代码行
            value_name: 枚举值名
            
        Returns:
            bool: 是否为C++枚举值定义
        """
        # C++枚举值定义通常是：VALUE_NAME = 1, 或 VALUE_NAME, 或 VALUE_NAME __deprecated = 1,
        cpp_patterns = [
            rf"^\s*{re.escape(value_name)}\s*[,=]",           # 行开始的 VALUE_NAME, 或 VALUE_NAME =
            rf"^\s*{re.escape(value_name)}\s*$",              # 只有 VALUE_NAME
            rf"^\s*{re.escape(value_name)}\s+\w+\s*[,=]",     # VALUE_NAME modifier = 或 VALUE_NAME modifier,
            rf"^\s*{re.escape(value_name)}\s+__\w+\s*[,=]",   # VALUE_NAME __modifier = 或 VALUE_NAME __modifier,
        ]
        
        for pattern in cpp_patterns:
            if re.search(pattern, line):
                return True
        
        return False
    
    def _find_nearest_parent_class(self, lines: List[str], api_line_index: int) -> Optional[str]:
        """
        从指定位置向上搜索，找到最近的C++类声明
        
        Args:
            lines: 文件行列表
            api_line_index: API所在行的索引（0-based）
            
        Returns:
            Optional[str]: 找到的类名，如果未找到返回None
        """
        # 获取类检测配置
        class_detection = self.search_patterns.get("class_detection", {})
        if not class_detection:
            # 如果没有配置，使用默认的C++规则
            class_detection = {
                "class_patterns": [
                    r"^\s*(class|struct|interface)\s+([\w:]+)\s*[:{]",
                    r"^\s*(class|struct|interface)\s+([\w:]+)\s*$"
                ],
                "scope_markers": {"start": "{", "end": "}"}
            }
        
        class_patterns = class_detection.get("class_patterns", [])
        scope_start = class_detection.get("scope_markers", {}).get("start", "{")
        scope_end = class_detection.get("scope_markers", {}).get("end", "}")
        
        # 编译正则表达式
        compiled_patterns = []
        for pattern in class_patterns:
            try:
                compiled_patterns.append(re.compile(pattern))
            except re.error as e:
                logger.warning("C++类检测正则表达式错误: {}", str(e))
                continue
        
        # 从API位置向上搜索
        brace_count = 0
        for i in range(api_line_index, -1, -1):
            line = lines[i]
            
            # 计算大括号层级（向上搜索时反向计算）
            for char in reversed(line):
                if char == scope_end:
                    brace_count += 1
                elif char == scope_start:
                    brace_count -= 1
            
            # 检查是否匹配C++类声明模式
            for pattern in compiled_patterns:
                match = pattern.search(line)
                if match and brace_count <= 0:  # 确保在正确的作用域层级
                    class_name = match.group(2) if len(match.groups()) >= 2 else match.group(1)
                    logger.debug("找到C++父类: {} 在行 {}", class_name, i + 1)
                    return class_name
        
        return None
    
    # ==================== 从原代码迁移的方法 ====================
    # 这些方法从原 code_locator.py 迁移过来，保持原有逻辑
    
    def _extract_clean_api_name(self, api_name: str) -> str:
        """提取纯净的API名称，去除各种平台特定的标识"""
        if not api_name:
            return ""
        
        clean_name = api_name.strip()
        
        # 1. 去除C++/Java重载标识 [数字/数字]
        overload_pattern = r'\s*\[(\d+)/(\d+)\]\s*$'
        clean_name = re.sub(overload_pattern, '', clean_name)
        
        # 2. 去除OC选择器参数（保留第一个方法名部分）
        # 例如: "setClientRole:options:" -> "setClientRole"
        if ':' in clean_name:
            clean_name = clean_name.split(':')[0]
        
        clean_name = clean_name.strip()
        logger.debug("API名称清理: {} -> {}", api_name, clean_name)
        return clean_name
    
    def _extract_keywords_from_signature(self, signature: str) -> str:
        """从签名中提取关键字"""
        if not signature:
            return ""
        
        # 清理签名
        clean_sig = self._clean_signature(signature)
        
        # 提取关键字模式
        keywords_patterns = [
            r"^(virtual\s+\w+)",     # virtual int
            r"^(static\s+\w+)",      # static void
            r"^(\w+\s+\w+)",         # int/void function
            r"^(struct\s+\w+)",      # struct ClassName
            r"^(class\s+\w+)",       # class ClassName
            r"^(enum\s+\w+)",        # enum EnumName
        ]
        
        for pattern in keywords_patterns:
            match = re.search(pattern, clean_sig)
            if match:
                return match.group(1)
        
        # 如果没有找到模式，返回前两个单词
        words = clean_sig.split()
        if len(words) >= 2:
            return f"{words[0]} {words[1]}"
        elif len(words) == 1:
            return words[0]
        
        return ""
    
    def _search_by_signature(self, signature: str, search_files: List[str]) -> Optional[Tuple[str, int]]:
        """通过签名搜索（为class/enum定位保留的方法）"""
        # 清理签名，移除HTML标签和多余空白
        clean_signature = self._clean_signature(signature)
        escaped_signature = re.escape(clean_signature)
        
        # 获取签名搜索模式
        signature_patterns = self.search_patterns.get("signature_patterns", [])
        if not signature_patterns:
            signature_patterns = [r"^{escaped_signature}$", r"^\s*{escaped_signature}\s*;?\s*$"]
        
        for pattern_template in signature_patterns:
            pattern = pattern_template.replace("{escaped_signature}", escaped_signature)
            
            try:
                compiled_pattern = re.compile(pattern, re.MULTILINE)
                
                for file_path in search_files:
                    try:
                        content = read_file_content(file_path)
                    except Exception as e:
                        logger.debug("读取文件失败 {}: {}", file_path, str(e))
                        continue
                    if content is None:
                        continue
                    match = compiled_pattern.search(content)
                    if match:
                        line_number = content[:match.start()].count('\n') + 1
                        return (file_path, line_number)
                        
            except re.error as e:
                logger.warning("正则表达式错误: {}", str(e))
                continue
        
        return None
    
    def _search_by_class_name(self, class_name: str, search_files: List[str]) -> Optional[Tuple[str, int]]:
        """通过类名搜索"""
        # 类定义模式（更精确的模式优先）
        class_patterns = [
            rf"\b(class|struct)\s+{re.escape(class_name)}\s*[{{:]",
            rf"^\s*(class|struct)\s+{re.escape(class_name)}\b"
        ]
        
        for pattern in class_patterns:
            try:
                compiled_pattern = re.compile(pattern, re.MULTILINE)
                
                for file_path in search_files:
                    try:
                        content = read_file_content(file_path)
                    except Exception as e:
                        logger.debug("读取文件失败 {}: {}", file_path, str(e))
                        continue
                    if content is None:
                        continue
                    match = compiled_pattern.search(content)
                    if match:
                        line_number = content[:match.start()].count('\n') + 1
                        return (file_path, line_number)
                        
            except re.error as e:
                logger.warning("正则表达式错误: {}", str(e))
                continue
        
        return None
    
    def _search_by_enum_name(self, enum_name: str, search_files: List[str]) -> Optional[Tuple[str, int]]:
        """通过枚举名搜索"""
        # 枚举定义模式（更精确的模式优先）
        enum_patterns = [
            rf"\benum\s+(class\s+)?{re.escape(enum_name)}\s*[{{:]",
            rf"^\s*enum\s+(class\s+)?{re.escape(enum_name)}\b",
        ]
        
        for pattern in enum_patterns:
            try:
                compiled_pattern = re.compile(pattern, re.MULTILINE)
                
                for file_path in search_files:
                    try:
                        content = read_file_content(file_path)
                    except Exception as e:
                        logger.debug("读取文件失败 {}: {}", file_path, str(e))
                        continue
                    if content is None:
                        continue
                    match = compiled_pattern.search(content)
                    if match:
                        line_number = content[:match.start()].count('\n') + 1
                        return (file_path, line_number)
                        
            except re.error as e:
                logger.warning("正则表达式错误: {}", str(e))
                continue
        
        return None
    
    # 其他辅助方法（从原代码迁移）
    def _find_class_end(self, lines: List[str], start_line: int) -> Optional[int]:
        """找到类定义的结束位置"""
        brace_count = 0
        found_opening = False
        
        for i in range(start_line, len(lines)):
            line = lines[i]
            
            # 计算大括号
            for char in line:
                if char == '{':
                    brace_count += 1
                    found_opening = True
                elif char == '}':
                    brace_count -= 1
                    
                    # 如果找到了开始大括号，且计数回到0，说明类结束
                    if found_opening and brace_count == 0:
                        return i
        
        return None
    
    def _find_enum_end(self, lines: List[str], start_line: int) -> Optional[int]:
        """找到枚举定义的结束位置"""
        brace_count = 0
        found_opening = False
        
        for i in range(start_line, len(lines)):
            line = lines[i]
            
            # 计算大括号
            for char in line:
                if char == '{':
                    brace_count += 1
                    found_opening = True
                elif char == '}':
                    brace_count -= 1
                    
                    # 如果找到了开始大括号，且计数回到0，说明枚举结束
                    if found_opening and brace_count == 0:
                        return i
        
        return None
    
    def _search_attribute_enhanced(self, lines: List[str], class_start: int, class_end: int, attribute_name: str) -> Optional[int]:
        """增强的属性搜索策略，避免在函数体内误匹配"""
        logger.debug("开始增强属性搜索: {} 在范围 {}-{}", attribute_name, class_start + 1, class_end + 1)
        
        brace_level = 0  # 跟踪大括号层级
        in_function_body = False
        in_data_structure = False  # 跟踪是否在union/struct等数据结构内
        current_access_level = "private"  # 默认访问级别
        
        # 从类定义开始遍历，包含类定义行以正确计算大括号层级
        for i in range(class_start, class_end):
            line = lines[i]
            stripped_line = line.strip()
            
            # 跳过注释和空行
            if not stripped_line or self._is_comment_or_empty_line(stripped_line):
                continue
            
            # 跳过类定义行本身
            if i == class_start:
                # 更新大括号层级但不搜索属性
                brace_level += stripped_line.count('{') - stripped_line.count('}')
                continue
            
            # 更新大括号层级
            brace_level += stripped_line.count('{') - stripped_line.count('}')
            
            # 检查访问修饰符
            if stripped_line in ['public:', 'private:', 'protected:']:
                current_access_level = stripped_line.rstrip(':')
                continue
            
            # 检查是否进入数据结构（union, struct, enum等）
            if self._is_data_structure_start(stripped_line):
                in_data_structure = True
                logger.debug("进入数据结构在行 {}: {}", i + 1, stripped_line[:50])
                continue
            
            # 检查是否进入/退出函数体
            if self._is_function_start(stripped_line):
                in_function_body = True
                logger.debug("进入函数体在行 {}: {}", i + 1, stripped_line[:50])
                # 如果函数声明没有大括号（如构造函数声明），立即退出函数体状态
                if not stripped_line.endswith('{'):
                    in_function_body = False
                    logger.debug("函数声明无大括号，立即退出函数体")
                continue
            
            # 如果在函数体内且大括号层级回到1（类级别），说明函数结束
            if in_function_body and brace_level == 1:
                in_function_body = False
                logger.debug("退出函数体在行 {}", i + 1)
                continue
            
            # 如果在数据结构内且大括号层级回到1（类级别），说明数据结构结束
            if in_data_structure and brace_level == 1:
                in_data_structure = False
                logger.debug("退出数据结构在行 {}", i + 1)
                continue
            
            # 搜索属性的条件：
            # 1. 不在函数体内
            # 2. 在类的直接大括号内 (brace_level == 1)
            # 3. 或者在数据结构内 (in_data_structure 且 brace_level == 2)
            should_search = (not in_function_body and 
                           (brace_level == 1 or (in_data_structure and brace_level == 2)))
            
            if should_search:
                if self._is_attribute_definition_enhanced(stripped_line, attribute_name):
                    logger.debug("找到属性定义在行 {}: {}", i + 1, stripped_line)
                    return i
        
        return None
    
    def _is_comment_or_empty_line(self, line: str) -> bool:
        """检查是否为注释或空行"""
        if not line:
            return True
        
        # 各种注释格式
        comment_starts = ['*', '//', '/**', '*/', '/*']
        for start in comment_starts:
            if line.startswith(start):
                return True
        
        return False
    
    def _is_data_structure_start(self, line: str) -> bool:
        """检查是否为数据结构开始行（union, struct, enum等）"""
        # 数据结构关键字
        data_structure_keywords = ['union {', 'struct {', 'enum {', 'class {']
        
        for keyword in data_structure_keywords:
            if keyword in line:
                return True
        
        # 单独的关键字（可能在下一行有大括号）
        if line.strip() in ['union', 'struct', 'enum', 'class']:
            return True
        
        return False
    
    def _is_function_start(self, line: str) -> bool:
        """检查是否为函数开始行"""
        # 函数特征：包含括号且以大括号结尾或分号结尾
        if '(' in line and ')' in line:
            # 排除一些明显不是函数的情况
            if line.startswith('#') or line.startswith('//'):
                return False
            
            # 排除构造函数初始化列表（以冒号开头或逗号结尾）
            if line.strip().startswith(':') or line.strip().endswith(','):
                return False
            
            # 构造函数、析构函数、普通方法
            if (line.endswith('{') or 
                line.endswith(';') or 
                'virtual' in line or 
                '~' in line):
                return True
            
            # 检查是否为函数声明模式（返回类型 函数名(参数)）
            # 简单启发式：如果包含常见的函数模式
            if any(keyword in line for keyword in ['virtual', 'static', 'inline', 'explicit']):
                return True
            
            # 如果行以标识符开头且包含括号，可能是函数
            # 但要排除明显的初始化语句
            stripped = line.strip()
            if not stripped.startswith('(') and not '=' in stripped:
                # 检查是否符合函数声明模式
                # 匹配模式：[修饰符] 返回类型 函数名(参数) [const] [{;]
                func_pattern = r'^[a-zA-Z_][a-zA-Z0-9_:*&\s]*\([^)]*\)\s*[const\s]*[{;]?$'
                if re.match(func_pattern, stripped):
                    return True
        
        return False
    
    def _is_function_definition(self, line: str, function_name: str) -> bool:
        """判断是否为函数定义行"""
        # 简单的启发式判断
        # 函数定义通常包含返回类型、函数名和参数列表
        
        # 排除注释行
        if line.strip().startswith('//') or line.strip().startswith('*'):
            return False
        
        # 排除函数调用（通常不包含类型信息）
        if f"{function_name}(" in line and not any(keyword in line for keyword in ['virtual', 'static', 'int', 'void', 'bool', 'string']):
            return False
        
        # 包含函数名和括号的可能是定义
        return f"{function_name}(" in line
    
    def _validate_parent_class(self, file_path: str, line_num: int, expected_parent_class: str) -> bool:
        """验证指定位置的API是否属于预期的父类"""
        try:
            content = read_file_content(file_path)
            if content is None:
                return False
            lines = content.split('\n')
            
            # 从API位置向上搜索，找到最近的类声明
            parent_class = self._find_nearest_parent_class(lines, line_num - 1)  # 转换为0-based索引
            
            if parent_class:
                # 支持简单的类名匹配和完全限定名匹配
                if parent_class == expected_parent_class:
                    return True
                # 支持去除命名空间的匹配（例如 agora::rtc::IClass vs IClass）
                if parent_class.split('::')[-1] == expected_parent_class.split('::')[-1]:
                    return True
                
                # 检查继承关系：如果找到的类继承自期望的类，也算匹配
                if self._check_inheritance_relationship(lines, parent_class, expected_parent_class):
                    logger.debug("parent_class继承验证成功: {} 类 {} 继承自 {}", file_path, parent_class, expected_parent_class)
                    return True
            
            return False
            
        except Exception as e:
            logger.debug("验证parent_class时发生错误 {}: {}", file_path, str(e))
            return False
    
    def _check_inheritance_relationship(self, lines: List[str], child_class: str, expected_parent: str) -> bool:
        """检查类的继承关系"""
        # 查找子类的声明行，看是否有extends关键字
        for line in lines:
            # 匹配类声明：class ChildClass extends ParentClass
            inheritance_pattern = rf"class\s+{re.escape(child_class)}\s+extends\s+([\w<>]+)"
            match = re.search(inheritance_pattern, line)
            if match:
                parent_class = match.group(1)
                if parent_class == expected_parent:
                    return True
                # 递归检查多级继承
                return self._check_inheritance_relationship(lines, parent_class, expected_parent)
        
        return False
    
    # 搜索匹配方法（从原代码迁移）
    def _find_all_signature_matches(self, signature: str, search_files: List[str]) -> List[Tuple[str, int]]:
        """找到所有匹配签名的位置"""
        matches_set = set()  # 使用set去重
        clean_signature = self._clean_signature(signature)
        escaped_signature = re.escape(clean_signature)
        
        signature_patterns = self.search_patterns.get("signature_patterns", [])
        if not signature_patterns:
            signature_patterns = [
                "^{escaped_signature}$",
                "^\\s*{escaped_signature}\\s*;?\\s*$"
            ]
        
        for pattern_template in signature_patterns:
            pattern = pattern_template.replace("{escaped_signature}", escaped_signature)
            try:
                compiled_pattern = re.compile(pattern)
                for file_path in search_files:
                    try:
                        content = read_file_content(file_path)
                    except Exception as e:
                        logger.debug("读取文件失败 {}: {}", file_path, str(e))
                        continue
                    if content is None:
                        continue
                    lines = content.split('\n')
                    for line_num, line in enumerate(lines, 1):
                        # 清理代码行以便匹配（移除注解等）
                        clean_line = self._clean_code_line_for_matching(line)
                        if compiled_pattern.search(clean_line):
                            matches_set.add((file_path, line_num))
                        
                        # 对于多行方法声明，尝试合并后续行进行匹配
                        if ('(' in line and ')' not in line and 
                            line_num < len(lines)):
                            # 尝试合并多行构建完整签名
                            multi_line = line
                            for next_line_num in range(line_num, min(line_num + 5, len(lines) + 1)):
                                if next_line_num <= len(lines):
                                    next_line = lines[next_line_num - 1] if next_line_num > line_num else ""
                                    if next_line_num > line_num:
                                        multi_line += " " + next_line.strip()
                                    if ')' in multi_line:
                                        clean_multi_line = self._clean_code_line_for_matching(multi_line)
                                        if compiled_pattern.search(clean_multi_line):
                                            matches_set.add((file_path, line_num))
                                        break
            except re.error as e:
                logger.warning("正则表达式错误: {}", str(e))
                continue
        
        return list(matches_set)
    
    def _find_all_keywords_name_matches(self, api_name: str, signature: str, search_files: List[str]) -> List[Tuple[str, int]]:
        """找到所有通过关键字+名称匹配的位置"""
        matches = []
        keywords = self._extract_keywords_from_signature(signature)
        if not keywords:
            return matches
        
        search_pattern = rf"\b{re.escape(keywords)}\s+{re.escape(api_name)}\b"
        
        try:
            compiled_pattern = re.compile(search_pattern)
            for file_path in search_files:
                try:
                    content = read_file_content(file_path)
                except Exception as e:
                    logger.debug("读取文件失败 {}: {}", file_path, str(e))
                    continue
                if content is None:
                    continue
                for line_num, line in enumerate(content.split('\n'), 1):
                    if compiled_pattern.search(line):
                        if self._is_function_definition(line, api_name):
                            matches.append((file_path, line_num))
        except re.error as e:
            logger.warning("正则表达式错误: {}", str(e))
        
        return matches
    
    def _find_all_name_matches(self, api_name: str, search_files: List[str]) -> List[Tuple[str, int]]:
        """找到所有通过名称匹配的位置"""
        matches = []
        name_patterns = self.search_patterns.get("name_patterns", [rf"\b{api_name}\b"])
        
        for pattern_template in name_patterns:
            pattern = pattern_template.replace("{api_name}", re.escape(api_name))
            try:
                compiled_pattern = re.compile(pattern)
                for file_path in search_files:
                    try:
                        content = read_file_content(file_path)
                    except Exception as e:
                        logger.debug("读取文件失败 {}: {}", file_path, str(e))
                        continue
                    if content is None:
                        continue
                    for line_num, line in enumerate(content.split('\n'), 1):
                        if compiled_pattern.search(line):
                            if self._is_function_definition(line, api_name):
                                matches.append((file_path, line_num))
            except re.error as e:
                logger.warning("正则表达式错误: {}", str(e))
                continue
        
        return matches
    
    def _find_all_signature_matches_enhanced(self, signature: str, search_files: List[str]) -> List[Tuple[str, int]]:
        """增强的签名匹配，处理格式差异"""
        matches = []
        
        # 标准化输入签名
        normalized_input_signature = self._normalize_signature_enhanced(signature)
        logger.debug("标准化输入签名: {}", normalized_input_signature)
        
        for file_path in search_files:
            try:
                content = read_file_content(file_path)
            except Exception as e:
                logger.debug("读取文件失败 {}: {}", file_path, str(e))
                continue
            if content is None:
                continue
            lines = content.split('\n')
            
            # 逐行检查，支持多行签名
            i = 0
            while i < len(lines):
                # 尝试匹配单行或多行签名
                candidate_signature = self._extract_candidate_signature(lines, i)
                if candidate_signature:
                    normalized_candidate = self._normalize_signature_enhanced(candidate_signature)
                    
                    if normalized_input_signature == normalized_candidate:
                        # 找到匹配的签名，确定具体行号
                        actual_line = self._find_signature_start_line(lines, i, candidate_signature)
                        matches.append((file_path, actual_line + 1))  # 转换为1-based行号
                        logger.debug("找到匹配签名在 {}:{}", file_path, actual_line + 1)
                
                i += 1
        
        return matches
    
    def _normalize_signature_enhanced(self, signature: str) -> str:
        """增强的签名标准化，处理各种格式差异"""
        if not signature:
            return ""
        
        # 1. 移除多余的空白和换行
        normalized = ' '.join(signature.split())
        
        # 2. 标准化常见的格式差异
        # 移除行尾分号和空格
        normalized = normalized.rstrip('; ')
        
        # 3. 标准化参数列表中的空格
        # 在逗号后添加空格，在逗号前移除空格
        normalized = re.sub(r'\s*,\s*', ', ', normalized)
        
        # 4. 标准化括号内的空格
        normalized = re.sub(r'\(\s+', '(', normalized)
        normalized = re.sub(r'\s+\)', ')', normalized)
        
        # 5. 标准化操作符周围的空格
        normalized = re.sub(r'\s*=\s*', ' = ', normalized)
        
        return normalized
    
    def _extract_candidate_signature(self, lines: List[str], start_index: int) -> Optional[str]:
        """从指定位置提取候选签名（支持多行）"""
        if start_index >= len(lines):
            return None
        
        line = lines[start_index].strip()
        
        # 跳过注释和空行
        if not line or line.startswith('//') or line.startswith('/*') or line.startswith('*'):
            return None
        
        # 检查是否可能是函数定义的开始
        if not any(keyword in line for keyword in ['virtual', 'static', 'int', 'void', 'bool', 'char', 'float', 'double']):
            return None
        
        # 收集完整的函数签名（可能跨多行）
        signature_lines = []
        i = start_index
        brace_count = 0
        paren_count = 0
        found_opening_paren = False
        
        while i < len(lines):
            current_line = lines[i].strip()
            if not current_line:
                i += 1
                continue
                
            signature_lines.append(current_line)
            
            # 计算括号
            for char in current_line:
                if char == '(':
                    paren_count += 1
                    found_opening_paren = True
                elif char == ')':
                    paren_count -= 1
                elif char == '{':
                    brace_count += 1
                elif char == '}':
                    brace_count -= 1
            
            # 如果找到了完整的函数签名（括号匹配且以分号或大括号结束）
            if found_opening_paren and paren_count == 0:
                if current_line.endswith(';') or current_line.endswith('= 0;') or '{' in current_line:
                    break
            
            i += 1
            
            # 防止无限循环
            if i - start_index > 10:  # 最多检查10行
                break
        
        if signature_lines and found_opening_paren and paren_count == 0:
            return ' '.join(signature_lines)
        
        return None
    
    def _find_signature_start_line(self, lines: List[str], search_start: int, signature: str) -> int:
        """找到签名的实际开始行"""
        # 简单实现：返回搜索开始位置
        # 可以根据需要进一步优化，找到函数名所在的确切行
        return search_start
