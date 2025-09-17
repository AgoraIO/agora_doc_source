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
        
        优化后的统一定位策略（参考C++实现）：
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
        
        # 提取纯净API名称（去除重载标识等）
        clean_name = self._extract_clean_api_name(api_name)
        logger.debug("开始定位API: {} (clean_name: {}, parent_class: {})", 
                    api_name, clean_name, parent_class)
        
        # 获取搜索文件列表
        search_files = self._get_search_files()
        if not search_files:
            logger.warning("未找到搜索文件")
            return None
        
        # 策略1: 关键字+纯净API名匹配（高精度）
        logger.debug("策略1: 关键字+纯净API名匹配")
        candidates = self._find_by_keywords_and_name(search_files, clean_name)
        if len(candidates) == 1:
            logger.debug("策略1成功，找到唯一匹配")
            return candidates[0]
        elif len(candidates) > 1:
            logger.debug("策略1找到多个候选: {}", len(candidates))
        
        # 策略2: 完整签名匹配
        if api_signature:
            logger.debug("策略2: 完整签名匹配")
            signature_candidates = self._find_by_full_signature(search_files, api_signature)
            if len(signature_candidates) == 1:
                logger.debug("策略2成功，找到唯一匹配")
                return signature_candidates[0]
            elif len(signature_candidates) > 1:
                logger.debug("策略2找到多个候选: {}", len(signature_candidates))
                candidates.extend(signature_candidates)
        
        # 策略3: 增强签名匹配
        if api_signature:
            logger.debug("策略3: 增强签名匹配")
            enhanced_candidates = self._find_by_enhanced_signature(search_files, api_signature)
            if len(enhanced_candidates) == 1:
                logger.debug("策略3成功，找到唯一匹配")
                return enhanced_candidates[0]
            elif len(enhanced_candidates) > 1:
                logger.debug("策略3找到多个候选: {}", len(enhanced_candidates))
                candidates.extend(enhanced_candidates)
        
        # 策略4: 纯净名称匹配
        logger.debug("策略4: 纯净名称匹配")
        name_candidates = self._find_by_clean_name(search_files, clean_name)
        if len(name_candidates) == 1:
            logger.debug("策略4成功，找到唯一匹配")
            return name_candidates[0]
        elif len(name_candidates) > 1:
            logger.debug("策略4找到多个候选: {}", len(name_candidates))
            candidates.extend(name_candidates)
        
        # 去重
        candidates = list(set(candidates))
        
        # 策略5: parent_class验证（处理多结果情况）
        if len(candidates) > 1 and parent_class:
            logger.debug("策略5: parent_class验证，候选数: {}", len(candidates))
            verified_candidates = self._verify_parent_class(candidates, parent_class)
            if verified_candidates:
                logger.debug("parent_class验证成功，剩余候选: {}", len(verified_candidates))
                return verified_candidates[0]  # 返回第一个验证通过的
        
        # 如果有候选但无法验证parent_class，返回第一个
        if candidates:
            logger.debug("返回第一个候选（无parent_class验证）")
            return candidates[0]
        
        logger.warning("所有策略都未找到API: {}", api_name)
        return None
    
    def locate_class(self, class_data: Dict[str, Any]) -> Optional[Tuple[str, int]]:
        """
        定位类在代码中的位置 - Java版本
        
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
        
        # 获取搜索文件列表
        search_files = self._get_search_files()
        if not search_files:
            logger.warning("未找到搜索文件")
            return None
        
        # 优先使用签名匹配
        if class_signature:
            candidates = self._find_by_full_signature(search_files, class_signature)
            if candidates:
                logger.debug("通过签名找到类: {}", class_name)
                return candidates[0]
        
        # 使用类名匹配
        candidates = self._find_by_class_name(search_files, class_name)
        if candidates:
            logger.debug("通过类名找到类: {}", class_name)
            return candidates[0]
        
        logger.warning("未找到类: {}", class_name)
        return None
    
    def locate_enum(self, enum_data: Dict[str, Any]) -> Optional[Tuple[str, int]]:
        """
        定位枚举在代码中的位置 - Java版本
        
        Args:
            enum_data: 枚举数据
            
        Returns:
            Tuple[str, int]: (文件路径, 行号)，如果未找到返回None
        """
        enum_name = enum_data.get("name", "")
        enum_signature = enum_data.get("signature", "")
        
        if not enum_name:
            logger.warning("枚举名称为空，跳过定位")
            return None
        
        logger.debug("开始定位枚举: {}", enum_name)
        
        # 获取搜索文件列表
        search_files = self._get_search_files()
        if not search_files:
            logger.warning("未找到搜索文件")
            return None
        
        # 优先使用签名匹配
        if enum_signature:
            candidates = self._find_by_full_signature(search_files, enum_signature)
            if candidates:
                logger.debug("通过签名找到枚举: {}", enum_name)
                return candidates[0]
        
        # 使用枚举名匹配（Java中枚举通常是interface或class）
        candidates = self._find_by_class_name(search_files, enum_name)
        if candidates:
            logger.debug("通过名称找到枚举: {}", enum_name)
            return candidates[0]
        
        logger.warning("未找到枚举: {}", enum_name)
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
        class_name = class_data.get("name", "")
        
        if not class_name or not attribute_name:
            logger.warning("类名或属性名为空，跳过定位")
            return None
        
        logger.debug("开始定位属性: {}.{}", class_name, attribute_name)
        
        # 先定位类
        class_location = self.locate_class(class_data)
        if not class_location:
            logger.warning("未找到类 {}，无法定位属性", class_name)
            return None
        
        file_path, class_line = class_location
        
        # 在类内搜索属性
        attribute_location = self._search_attribute_in_class(file_path, class_line, attribute_name)
        if attribute_location:
            logger.debug("找到属性: {}.{}", class_name, attribute_name)
            return attribute_location
        
        logger.warning("未找到属性: {}.{}", class_name, attribute_name)
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
        enum_name = enum_data.get("name", "")
        
        if not enum_name or not value_name:
            logger.warning("枚举名或枚举值名为空，跳过定位")
            return None
        
        logger.debug("开始定位枚举值: {}.{}", enum_name, value_name)
        
        # 先定位枚举
        enum_location = self.locate_enum(enum_data)
        if not enum_location:
            logger.warning("未找到枚举 {}，无法定位枚举值", enum_name)
            return None
        
        file_path, enum_line = enum_location
        
        # 在枚举内搜索枚举值
        value_location = self._search_enum_value_in_enum(file_path, enum_line, value_name)
        if value_location:
            logger.debug("找到枚举值: {}.{}", enum_name, value_name)
            return value_location
        
        logger.warning("未找到枚举值: {}.{}", enum_name, value_name)
        return None
    
    # ==================== 核心辅助方法（参考C++实现） ====================
    
    def _get_search_files(self) -> List[str]:
        """获取搜索文件列表"""
        import os
        import glob
        
        # 从配置中获取代码仓库路径
        repo_path = self.repo_path
        if not repo_path:
            logger.warning("未配置代码仓库路径")
            return []
        
        # 搜索Java文件
        java_files = []
        
        # 递归搜索所有.java文件
        for root, dirs, files in os.walk(repo_path):
            # 跳过常见的非源码目录
            dirs[:] = [d for d in dirs if d not in ['.git', '.svn', 'build', 'target', '.idea', '.vscode']]
            
            for file in files:
                if file.endswith('.java'):
                    java_files.append(os.path.join(root, file))
        
        logger.debug("找到 {} 个Java文件", len(java_files))
        return java_files
    
    def _extract_clean_api_name(self, api_name: str) -> str:
        """提取纯净API名称（去除重载标识等）"""
        if not api_name:
            return ""
        
        # 去除重载标识，如 "method_1", "method_2"
        clean_name = re.sub(r'_\d+$', '', api_name)
        
        # 去除其他可能的后缀
        clean_name = clean_name.split('(')[0]  # 去除参数部分
        clean_name = clean_name.strip()
        
        return clean_name
    
    def _find_by_keywords_and_name(self, search_files: List[str], clean_name: str) -> List[Tuple[str, int]]:
        """策略1: 关键字+纯净API名匹配"""
        candidates = []
        java_keywords = ['public', 'private', 'protected', 'static', 'final', 'abstract']
        
        for file_path in search_files:
            try:
                content = read_file_content(file_path)
                if not content:
                    continue
                
                lines = content.split('\n')
                for i, line in enumerate(lines):
                    line = line.strip()
                    if not line:
                        continue
                    
                    # 检查是否包含Java关键字和API名称
                    if any(keyword in line for keyword in java_keywords) and clean_name in line:
                        # 进一步验证是否为方法定义
                        if self._looks_like_method_definition(line, clean_name):
                            candidates.append((file_path, i + 1))
                            logger.debug("关键字匹配找到候选: {}:{}", file_path, i + 1)
                            
            except Exception as e:
                logger.warning("读取文件失败 {}: {}", file_path, str(e))
                continue
        
        return list(set(candidates))  # 去重
    
    def _find_by_full_signature(self, search_files: List[str], signature: str) -> List[Tuple[str, int]]:
        """策略2: 完整签名匹配"""
        candidates = []
        clean_signature = self._clean_signature(signature)
        
        if not clean_signature:
            return candidates
        
        for file_path in search_files:
            try:
                content = read_file_content(file_path)
                if not content:
                    continue
                
                lines = content.split('\n')
                for i, line in enumerate(lines):
                    clean_line = self._clean_code_line_for_matching(line)
                    if clean_signature in clean_line:
                        candidates.append((file_path, i + 1))
                        logger.debug("签名匹配找到候选: {}:{}", file_path, i + 1)
                        
            except Exception as e:
                logger.warning("读取文件失败 {}: {}", file_path, str(e))
                continue
        
        return list(set(candidates))  # 去重
    
    def _find_by_enhanced_signature(self, search_files: List[str], signature: str) -> List[Tuple[str, int]]:
        """策略3: 增强签名匹配（更宽松的匹配）"""
        candidates = []
        clean_signature = self._clean_signature(signature)
        
        if not clean_signature:
            return candidates
        
        # 提取关键部分进行匹配
        signature_parts = clean_signature.split()
        if len(signature_parts) < 2:
            return candidates
        
        for file_path in search_files:
            try:
                content = read_file_content(file_path)
                if not content:
                    continue
                
                lines = content.split('\n')
                for i, line in enumerate(lines):
                    clean_line = self._clean_code_line_for_matching(line)
                    
                    # 检查是否包含签名的关键部分
                    match_count = sum(1 for part in signature_parts if part in clean_line)
                    if match_count >= len(signature_parts) * 0.7:  # 70%匹配度
                        candidates.append((file_path, i + 1))
                        logger.debug("增强签名匹配找到候选: {}:{}", file_path, i + 1)
                        
            except Exception as e:
                logger.warning("读取文件失败 {}: {}", file_path, str(e))
                continue
        
        return list(set(candidates))  # 去重
    
    def _find_by_clean_name(self, search_files: List[str], clean_name: str) -> List[Tuple[str, int]]:
        """策略4: 纯净名称匹配"""
        candidates = []
        
        for file_path in search_files:
            try:
                content = read_file_content(file_path)
                if not content:
                    continue
                
                lines = content.split('\n')
                for i, line in enumerate(lines):
                    if clean_name in line and self._looks_like_method_definition(line, clean_name):
                        candidates.append((file_path, i + 1))
                        logger.debug("名称匹配找到候选: {}:{}", file_path, i + 1)
                        
            except Exception as e:
                logger.warning("读取文件失败 {}: {}", file_path, str(e))
                continue
        
        return list(set(candidates))  # 去重
    
    def _find_by_class_name(self, search_files: List[str], class_name: str) -> List[Tuple[str, int]]:
        """查找类声明"""
        candidates = []
        
        for file_path in search_files:
            try:
                content = read_file_content(file_path)
                if not content:
                    continue
                
                lines = content.split('\n')
                for i, line in enumerate(lines):
                    if self._looks_like_class_definition(line, class_name):
                        candidates.append((file_path, i + 1))
                        logger.debug("类名匹配找到候选: {}:{}", file_path, i + 1)
                        
            except Exception as e:
                logger.warning("读取文件失败 {}: {}", file_path, str(e))
                continue
        
        return list(set(candidates))  # 去重
    
    def _verify_parent_class(self, candidates: List[Tuple[str, int]], parent_class: str) -> List[Tuple[str, int]]:
        """策略5: parent_class验证"""
        if not parent_class:
            return candidates
        
        verified_candidates = []
        
        for file_path, line_number in candidates:
            try:
                content = read_file_content(file_path)
                if not content:
                    continue
                
                lines = content.split('\n')
                
                # 从API位置向上查找父类
                found_parent = self._find_nearest_parent_class(lines, line_number - 1)
                if found_parent and parent_class.lower() in found_parent.lower():
                    verified_candidates.append((file_path, line_number))
                    logger.debug("parent_class验证通过: {} in {}", parent_class, found_parent)
                    
            except Exception as e:
                logger.warning("parent_class验证失败 {}: {}", file_path, str(e))
                continue
        
        return verified_candidates
    
    def _search_attribute_in_class(self, file_path: str, class_line: int, attribute_name: str) -> Optional[Tuple[str, int]]:
        """在类内搜索属性"""
        try:
            content = read_file_content(file_path)
            if not content:
                return None
            
            lines = content.split('\n')
            
            # 从类声明开始向下搜索
            brace_level = 0
            in_class = False
            
            for i in range(class_line - 1, len(lines)):
                line = lines[i]
                
                # 跟踪大括号层级
                brace_level += line.count('{') - line.count('}')
                
                if i == class_line - 1:  # 类声明行
                    in_class = True
                    continue
                
                if in_class and brace_level <= 0:
                    # 退出类作用域
                    break
                
                if in_class and self._is_attribute_definition_enhanced(line.strip(), attribute_name):
                    return (file_path, i + 1)
            
            return None
            
        except Exception as e:
            logger.warning("搜索属性失败 {}: {}", file_path, str(e))
            return None
    
    def _search_enum_value_in_enum(self, file_path: str, enum_line: int, value_name: str) -> Optional[Tuple[str, int]]:
        """在枚举内搜索枚举值"""
        try:
            content = read_file_content(file_path)
            if not content:
                return None
            
            lines = content.split('\n')
            
            # 从枚举声明开始向下搜索
            brace_level = 0
            in_enum = False
            
            for i in range(enum_line - 1, len(lines)):
                line = lines[i]
                
                # 跟踪大括号层级
                brace_level += line.count('{') - line.count('}')
                
                if i == enum_line - 1:  # 枚举声明行
                    in_enum = True
                    continue
                
                if in_enum and brace_level <= 0:
                    # 退出枚举作用域
                    break
                
                if in_enum and self._is_enum_value_definition(line.strip(), value_name):
                    return (file_path, i + 1)
            
            return None
            
        except Exception as e:
            logger.warning("搜索枚举值失败 {}: {}", file_path, str(e))
            return None
    
    def _looks_like_method_definition(self, line: str, method_name: str) -> bool:
        """判断行是否像方法定义"""
        line = line.strip()
        
        # 基本检查
        if not method_name in line:
            return False
        
        # Java方法特征：包含括号，可能包含访问修饰符
        if '(' in line and ')' in line:
            # 检查是否包含Java访问修饰符或返回类型
            java_indicators = ['public', 'private', 'protected', 'static', 'final', 'abstract', 'void', 'int', 'String', 'boolean']
            if any(indicator in line for indicator in java_indicators):
                return True
        
        return False
    
    def _looks_like_class_definition(self, line: str, class_name: str) -> bool:
        """判断行是否像类定义"""
        line = line.strip()
        
        # 基本检查
        if not class_name in line:
            return False
        
        # Java类特征：class/interface关键字
        class_keywords = ['class', 'interface', 'enum']
        if any(keyword in line for keyword in class_keywords):
            return True
        
        return False
    
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
