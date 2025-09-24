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
        keyword_candidates = self._find_by_keywords_and_name(search_files, clean_name)
        if len(keyword_candidates) == 1:
            logger.debug("策略1成功，找到唯一匹配")
            return keyword_candidates[0]
        elif len(keyword_candidates) > 1:
            logger.debug("策略1找到多个候选: {}", len(keyword_candidates))
        
        # 策略2: 完整签名匹配
        signature_candidates = []
        if api_signature:
            logger.debug("策略2: 完整签名匹配")
            signature_candidates = self._find_by_full_signature(search_files, api_signature)
            if len(signature_candidates) == 1:
                logger.debug("策略2成功，找到唯一匹配")
                return signature_candidates[0]
            elif len(signature_candidates) > 1:
                logger.debug("策略2找到多个候选: {}", len(signature_candidates))
        
        # 策略3: 增强签名匹配
        enhanced_candidates = []
        if api_signature:
            logger.debug("策略3: 增强签名匹配")
            enhanced_candidates = self._find_by_enhanced_signature(search_files, api_signature)
            if len(enhanced_candidates) == 1:
                logger.debug("策略3成功，找到唯一匹配")
                return enhanced_candidates[0]
            elif len(enhanced_candidates) > 1:
                logger.debug("策略3找到多个候选: {}", len(enhanced_candidates))
                # 应用参数数量过滤
                filtered_candidates = self._filter_by_parameter_count(enhanced_candidates, api_signature)
                if len(filtered_candidates) == 1:
                    logger.debug("策略3参数过滤后找到唯一匹配")
                    return filtered_candidates[0]
                enhanced_candidates = filtered_candidates
        
        # 策略4: 纯净名称匹配
        logger.debug("策略4: 纯净名称匹配")
        name_candidates = self._find_by_clean_name(search_files, clean_name)
        if len(name_candidates) == 1:
            logger.debug("策略4成功，找到唯一匹配")
            return name_candidates[0]
        elif len(name_candidates) > 1:
            logger.debug("策略4找到多个候选: {}", len(name_candidates))
        
        # 策略5: 从结果最少的策略中选择候选进行parent_class验证
        strategy_results = [
            (1, keyword_candidates, "策略1"),
            (2, signature_candidates, "策略2"), 
            (3, enhanced_candidates, "策略3"),
            (4, name_candidates, "策略4")
        ]
        
        # 过滤掉空结果，按候选数量和策略优先级排序
        valid_strategies = [(num, candidates, name) for num, candidates, name in strategy_results if len(candidates) > 1]
        if not valid_strategies:
            # 如果没有多候选策略，尝试合并所有候选
            all_candidates = []
            for _, candidates, _ in strategy_results:
                all_candidates.extend(candidates)
            if all_candidates:
                return list(set(all_candidates))[0]  # 去重后返回第一个
            logger.warning("所有策略都未找到API: {}", api_name)
            return None
        
        # 按候选数量升序，策略编号升序排序（优先选择结果最少且优先级最高的）
        valid_strategies.sort(key=lambda x: (len(x[1]), x[0]))
        best_strategy_num, best_candidates, best_strategy_name = valid_strategies[0]
        
        logger.debug("策略5: 选择{}的{}个候选进行parent_class验证", best_strategy_name, len(best_candidates))
        
        if parent_class:
            verified_candidates = self._verify_parent_class(best_candidates, parent_class)
            if verified_candidates:
                logger.debug("parent_class验证成功，剩余候选: {}", len(verified_candidates))
                
                # 如果还有多个候选，应用参数数量过滤
                if len(verified_candidates) > 1 and api_signature:
                    logger.debug("应用参数数量过滤，候选数: {}", len(verified_candidates))
                    final_candidates = self._filter_by_parameter_count(verified_candidates, api_signature)
                    if final_candidates:
                        logger.debug("参数过滤后剩余候选: {}", len(final_candidates))
                        return final_candidates[0]
                
                return verified_candidates[0]  # 返回第一个验证通过的
        
        # 如果无法验证parent_class，返回最佳策略的第一个候选
        return best_candidates[0]
    
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
            # 优先选择最佳候选
            best_candidate = self._select_best_class_candidate(candidates, class_name)
            logger.debug("通过类名找到类: {}", class_name)
            return best_candidate
        
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
            # 优先选择enum定义而不是class定义
            best_candidate = self._select_best_enum_candidate(candidates, enum_name)
            logger.debug("通过名称找到枚举: {}", enum_name)
            return best_candidate
        
        logger.warning("未找到枚举: {}", enum_name)
        return None
    
    def locate_class_attribute(self, class_data: Dict[str, Any], attribute_name: str) -> Optional[Tuple[str, int]]:
        """
        定位类属性在代码中的位置 - Java版本（文件修改安全版本）
        
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
        
        # 重新搜索整个类的属性，不依赖可能过时的类行号
        attribute_location = self._search_attribute_by_class_name(class_name, attribute_name)
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
    
    
    def _extract_clean_api_name(self, api_name: str) -> str:
        """提取纯净API名称（去除重载标识等）"""
        if not api_name:
            return ""
        
        clean_name = api_name.strip()
        
        # 1. 去除C++/Java重载标识 [数字/数字]
        overload_pattern = r'\s*\[(\d+)/(\d+)\]\s*$'
        clean_name = re.sub(overload_pattern, '', clean_name)
        
        # 2. 去除传统重载标识，如 "method_1", "method_2"
        clean_name = re.sub(r'_\d+$', '', clean_name)
        
        # 3. 去除其他可能的后缀
        clean_name = clean_name.split('(')[0]  # 去除参数部分
        clean_name = clean_name.strip()
        
        return clean_name
    
    def _find_by_keywords_and_name(self, search_files: List[str], clean_name: str) -> List[Tuple[str, int]]:
        """策略1: 关键字+纯净API名匹配（支持多行方法定义）"""
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
                        # 单行方法定义检查
                        if self._looks_like_method_definition(line, clean_name):
                            candidates.append((file_path, i + 1))
                            logger.debug("关键字匹配找到候选: {}:{}", file_path, i + 1)
                        # 多行方法定义检查：如果包含(但不包含)，检查是否为方法开始
                        elif ('(' in line and ')' not in line and 
                              any(indicator in line for indicator in ['int', 'void', 'String', 'boolean', 'public', 'private', 'protected', 'abstract'])):
                            candidates.append((file_path, i + 1))
                            logger.debug("关键字匹配找到候选（多行方法）: {}:{}", file_path, i + 1)
                            
            except Exception as e:
                logger.warning("读取文件失败 {}: {}", file_path, str(e))
                continue
        
        return list(set(candidates))  # 去重
    
    def _find_by_full_signature(self, search_files: List[str], signature: str) -> List[Tuple[str, int]]:
        """策略2: 完整签名匹配（精确原始签名匹配）"""
        candidates = []
        
        if not signature:
            return candidates
        
        # 策略2使用原始签名进行精确匹配，保持最高的区分度
        for file_path in search_files:
            try:
                content = read_file_content(file_path)
                if not content:
                    continue
                
                lines = content.split('\n')
                for i, line in enumerate(lines):
                    # 策略2进行完全原始匹配，只清理首尾空白
                    clean_line = line.strip()
                    # 直接使用原始签名匹配，不进行任何内容清理
                    if signature in clean_line:
                        candidates.append((file_path, i + 1))
                        logger.debug("原始签名匹配找到候选: {}:{}", file_path, i + 1)
                        
            except Exception as e:
                logger.warning("读取文件失败 {}: {}", file_path, str(e))
                continue
        
        return list(set(candidates))  # 去重
    
    def _find_by_enhanced_signature(self, search_files: List[str], signature: str) -> List[Tuple[str, int]]:
        """策略3: 增强签名匹配（清理注解后的宽松匹配，支持多行）"""
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
                    
                    # 单行检查
                    match_count = sum(1 for part in signature_parts if part in clean_line)
                    if match_count >= len(signature_parts) * 0.7:  # 70%匹配度
                        candidates.append((file_path, i + 1))
                        logger.debug("增强签名匹配找到候选: {}:{}", file_path, i + 1)
                    
                    # 多行检查：如果当前行包含(但不包含)，尝试合并后续行
                    elif ('(' in line and ')' not in line and i + 1 < len(lines)):
                        multi_line = line
                        for j in range(i + 1, min(i + 5, len(lines))):
                            multi_line += " " + lines[j].strip()
                            if ')' in multi_line:
                                clean_multi_line = self._clean_code_line_for_matching(multi_line)
                                match_count = sum(1 for part in signature_parts if part in clean_multi_line)
                                if match_count >= len(signature_parts) * 0.7:
                                    candidates.append((file_path, i + 1))
                                    logger.debug("多行增强签名匹配找到候选: {}:{}", file_path, i + 1)
                                break
                        
            except Exception as e:
                logger.warning("读取文件失败 {}: {}", file_path, str(e))
                continue
        
        return list(set(candidates))  # 去重
    
    def _filter_by_parameter_count(self, candidates: List[Tuple[str, int]], expected_signature: str) -> List[Tuple[str, int]]:
        """根据参数数量过滤候选"""
        if not candidates or not expected_signature:
            return candidates
        
        # 从期望签名中提取参数数量
        expected_params = self._count_parameters_in_signature(expected_signature)
        if expected_params is None:
            return candidates  # 无法确定参数数量，返回所有候选
        
        filtered_candidates = []
        for file_path, line_num in candidates:
            try:
                content = read_file_content(file_path)
                if not content:
                    continue
                
                lines = content.split('\n')
                if line_num - 1 >= len(lines):
                    continue
                
                # 获取方法签名（可能跨行）
                method_signature = self._extract_method_signature_at_line(lines, line_num - 1)
                if method_signature:
                    actual_params = self._count_parameters_in_signature(method_signature)
                    if actual_params == expected_params:
                        filtered_candidates.append((file_path, line_num))
                        logger.debug("参数数量匹配: {}:{} ({} 参数)", file_path, line_num, actual_params)
                    else:
                        logger.debug("参数数量不匹配: {}:{} (期望{}，实际{})", file_path, line_num, expected_params, actual_params)
                        
            except Exception as e:
                logger.warning("参数数量检查失败 {}:{}: {}", file_path, line_num, str(e))
                continue
        
        return filtered_candidates if filtered_candidates else candidates  # 如果过滤后为空，返回原候选
    
    def _count_parameters_in_signature(self, signature: str) -> int:
        """计算签名中的参数数量"""
        if not signature:
            return None
        
        # 查找参数列表
        paren_start = signature.find('(')
        paren_end = signature.rfind(')')
        
        if paren_start == -1 or paren_end == -1 or paren_start >= paren_end:
            return None
        
        params_str = signature[paren_start + 1:paren_end].strip()
        if not params_str:
            return 0  # 无参数
        
        # 简单的参数计数（按逗号分割，但需要考虑泛型）
        param_count = 0
        paren_level = 0
        angle_level = 0
        
        for char in params_str:
            if char == '<':
                angle_level += 1
            elif char == '>':
                angle_level -= 1
            elif char == '(':
                paren_level += 1
            elif char == ')':
                paren_level -= 1
            elif char == ',' and paren_level == 0 and angle_level == 0:
                param_count += 1
        
        return param_count + 1 if param_count > 0 or params_str else 0
    
    def _extract_method_signature_at_line(self, lines: List[str], line_index: int) -> str:
        """提取指定行开始的方法签名（可能跨行）"""
        if line_index >= len(lines):
            return ""
        
        signature = lines[line_index].strip()
        
        # 如果包含(但不包含)，继续收集后续行
        if '(' in signature and ')' not in signature:
            for i in range(line_index + 1, min(line_index + 10, len(lines))):
                signature += " " + lines[i].strip()
                if ')' in signature:
                    break
        
        return signature
    
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
                
                # 跟踪大括号层级（忽略注释中的大括号）
                brace_level += self._count_braces_outside_comments(line)
                
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
                
                # 跟踪大括号层级（忽略注释中的大括号）
                brace_level += self._count_braces_outside_comments(line)
                
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
    
    def _count_braces_outside_comments(self, line: str) -> int:
        """
        计算行中大括号的净增量，忽略注释中的大括号
        
        Args:
            line: 代码行
            
        Returns:
            int: 大括号净增量 (左括号数 - 右括号数)
        """
        # 简化处理：如果行明显是注释行，则忽略其中的大括号
        stripped = line.strip()
        if (stripped.startswith('*') or 
            stripped.startswith('//') or 
            stripped.startswith('/*') or
            stripped.endswith('*/')):
            # 这是注释行，忽略其中的大括号
            return 0
        
        # 移除行注释 // 
        if '//' in line:
            line = line[:line.index('//')]
        
        # 简单处理：计算非注释部分的大括号
        return line.count('{') - line.count('}')
    
    def _search_attribute_by_class_name(self, class_name: str, attribute_name: str) -> Optional[Tuple[str, int]]:
        """
        通过类名搜索属性，不依赖可能过时的类行号
        这个方法会重新定位类，然后搜索属性，避免文件修改导致的行号偏移问题
        
        Args:
            class_name: 类名
            attribute_name: 属性名
            
        Returns:
            Tuple[str, int]: (文件路径, 行号)，如果未找到返回None
        """
        search_files = self._get_search_files()
        
        for file_path in search_files:
            try:
                content = read_file_content(file_path)
                if not content:
                    continue
                
                lines = content.split('\n')
                
                # 重新定位类声明
                for i, line in enumerate(lines):
                    if self._looks_like_class_definition(line, class_name):
                        logger.debug("重新定位类 {} 在 {}:{}", class_name, file_path, i + 1)
                        
                        # 在这个类范围内搜索属性
                        attribute_location = self._search_attribute_in_class(file_path, i + 1, attribute_name)
                        if attribute_location:
                            return attribute_location
                        
            except Exception as e:
                logger.warning("搜索属性时读取文件失败 {}: {}", file_path, str(e))
                continue
        
        return None
    
    def _looks_like_method_definition(self, line: str, method_name: str) -> bool:
        """判断行是否像方法定义"""
        line = line.strip()
        
        # 基本检查
        if not method_name in line:
            return False
        
        # 排除注释行（与_looks_like_class_definition保持一致）
        if line.startswith('//') or line.startswith('*') or line.startswith('/*'):
            return False
        
        # 排除字符串中的引用（防止误匹配字符串常量中的方法名）
        # 检查方法名是否出现在引号内
        import re
        # 匹配包含方法名的引号内容
        quoted_patterns = [
            rf'"[^"]*{method_name}[^"]*"',  # "...method_name..."
            rf"'[^']*{method_name}[^']*'",  # '...method_name...'
            rf'`[^`]*{method_name}[^`]*`',  # `...method_name...`
        ]
        for pattern in quoted_patterns:
            if re.search(pattern, line):
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
        
        # 排除注释行
        if line.startswith('//') or line.startswith('*') or line.startswith('/*'):
            return False
        
        # 排除字符串中的引用
        if f'"{class_name}"' in line or f"'{class_name}'" in line:
            return False
        
        # 排除注释中的反引号引用
        if f'`{class_name}`' in line:
            return False
        
        # Java类特征：必须是真正的类声明格式
        class_patterns = [
            rf'\bpublic\s+class\s+{re.escape(class_name)}\b',
            rf'\bprivate\s+class\s+{re.escape(class_name)}\b', 
            rf'\bprotected\s+class\s+{re.escape(class_name)}\b',
            rf'\bclass\s+{re.escape(class_name)}\b',
            rf'\bpublic\s+interface\s+{re.escape(class_name)}\b',
            rf'\binterface\s+{re.escape(class_name)}\b',
            rf'\bpublic\s+enum\s+{re.escape(class_name)}\b',
            rf'\benum\s+{re.escape(class_name)}\b',
        ]
        
        for pattern in class_patterns:
            if re.search(pattern, line):
                logger.debug("匹配Java类定义模式: {} -> {}", pattern, line.strip())
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
    
    def _is_getter_method(self, line: str, attribute_name: str) -> bool:
        """
        检查是否是getter方法（无参数方法，方法名匹配属性名）
        
        Args:
            line: 代码行
            attribute_name: 属性名称
            
        Returns:
            bool: 是否为getter方法
        """
        # getter方法特征：
        # 1. 包含访问修饰符（public/private/protected）
        # 2. 有返回类型
        # 3. 方法名与属性名完全匹配
        # 4. 无参数 ()
        # 5. 可能有大括号 {
        
        # 基本格式检查
        if not ('public' in line or 'private' in line or 'protected' in line):
            return False
        
        if attribute_name not in line:
            return False
        
        # 检查是否是无参数方法
        if not ('()' in line or '( )' in line):
            return False
        
        # 构建getter方法的正则模式
        # 匹配: [修饰符] [返回类型] [属性名]()
        getter_pattern = rf"\b(?:public\s+|private\s+|protected\s+)(?:static\s+)?[\w.]+(?:<[^>]+>)?\s+{re.escape(attribute_name)}\s*\(\s*\)"
        
        if re.search(getter_pattern, line):
            logger.debug("识别为getter方法: {}", line)
            return True
        
        return False
    
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
        
        # 跳过明显的函数定义（但不跳过属性初始化和getter方法）
        if '(' in line and ')' in line:
            # 检查是否是属性初始化（包含 = new）
            if '=' in line and 'new ' in line:
                # 这可能是属性初始化，不跳过
                pass
            # 检查是否是getter方法（无参数方法，方法名匹配属性名）
            elif self._is_getter_method(line, attribute_name):
                # 这是getter方法，当作属性处理
                pass
            else:
                # 这可能是函数定义，跳过
                return False
        
        # 跳过赋值语句（关键改进），但不跳过属性声明
        if '=' in line and not line.endswith(';'):
            # 检查是否是属性声明的开始（包含访问修饰符和类型）
            if re.search(r'\b(?:final\s+)?(?:public\s+|private\s+|protected\s+)(?:static\s+|final\s+)*[\w.]+(?:\[\])?\s+\w+\s*=', line):
                # 这是属性声明，不跳过
                pass
            else:
                # 这是普通赋值语句，跳过
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
        
        # Java属性定义模式（增强版：支持数组、泛型、完全限定类名）
        # 定义Java类型模式：支持基本类型、数组、泛型、完全限定类名
        # 示例：int, int[], ArrayList<String>, java.util.List<String>, javax.microedition.khronos.egl.EGLContext
        java_type_pattern = r"(?:[\w.]+(?:<[^>]+>)?(?:\[\])*)"
        
        java_patterns = [
            # Java访问修饰符：public/private/protected type name;
            rf"\b(?:public\s+|private\s+|protected\s+){java_type_pattern}\s+{re.escape(attribute_name)}\s*;",
            # Java访问修饰符带默认值：public type name = value;
            rf"\b(?:public\s+|private\s+|protected\s+){java_type_pattern}\s+{re.escape(attribute_name)}\s*=\s*[^;]+;",
            # Java静态属性：public static type name;
            rf"\b(?:public\s+|private\s+|protected\s+)?(?:static\s+|final\s+)*{java_type_pattern}\s+{re.escape(attribute_name)}\s*;",
            # Java静态属性带默认值：public static type name = value;
            rf"\b(?:public\s+|private\s+|protected\s+)?(?:static\s+|final\s+)*{java_type_pattern}\s+{re.escape(attribute_name)}\s*=\s*[^;]+;",
            # Java final前置属性：final public type name;
            rf"\b(?:final\s+)?(?:public\s+|private\s+|protected\s+)(?:static\s+|final\s+)*{java_type_pattern}\s+{re.escape(attribute_name)}\s*;",
            # Java final前置属性带默认值：final public type name = value;
            rf"\b(?:final\s+)?(?:public\s+|private\s+|protected\s+)(?:static\s+|final\s+)*{java_type_pattern}\s+{re.escape(attribute_name)}\s*=",
        ]
        
        for pattern in java_patterns:
            if re.search(pattern, line):
                logger.debug("匹配Java属性声明模式: {}", line)
                return True
        
        # 最后检查：如果是getter方法，也认为是属性定义
        if self._is_getter_method(line, attribute_name):
            logger.debug("匹配getter方法模式: {}", line)
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
        # Java枚举值模式
        java_patterns = [
            # 现代Java枚举：VALUE_NAME(value),
            rf"\b{re.escape(value_name)}\s*\(",
            # 简单Java枚举：VALUE_NAME,
            rf"\b{re.escape(value_name)}\s*[,;]",
            # 常量模式：public final static int VALUE_NAME = 0x00000001;
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
            # public interface ClassName extends ParentInterface {
            r"^\s*(?:public\s+|private\s+|protected\s+)?interface\s+([\w<>]+)(?:\s+extends\s+[\w<>,\s]+)?\s*\{",
            # public abstract class ClassName extends ParentClass {
            r"^\s*(?:public\s+|private\s+|protected\s+)?(?:abstract\s+)?class\s+([\w<>]+)(?:\s+extends\s+[\w<>]+)?\s*\{",
            # public static class ClassName {
            r"^\s*(?:public\s+|private\s+|protected\s+)?(?:static\s+)?class\s+([\w<>]+)\s*\{",
            # 简化模式：interface ClassName extends ParentInterface {
            r"^\s*interface\s+([\w<>]+)(?:\s+extends\s+[\w<>,\s]+)?\s*\{",
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
        
        # 从API位置向上搜索，找到直接包含的类/接口
        brace_count = 0
        found_classes = []  # 存储找到的所有类，按层级排序
        
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
                if match:
                    class_name = match.group(1)
                    found_classes.append((class_name, brace_count, i + 1))
                    logger.debug("找到Java父类: {} 在行 {} (层级: {})", class_name, i + 1, brace_count)
        
        # 选择最直接包含API的类
        if found_classes:
            # 首先按brace_count升序排序（选择最内层），然后按行号降序排序（选择最近的）
            found_classes.sort(key=lambda x: (x[1], -x[2]))
            best_class = found_classes[0]
            logger.debug("选择最直接父类: {} (层级: {}, 行号: {})", best_class[0], best_class[1], best_class[2])
            return best_class[0]
        
        return None
    
    def _select_best_class_candidate(self, candidates: List[Tuple[str, int]], class_name: str) -> Tuple[str, int]:
        """
        从多个类候选中选择最佳匹配
        
        优先级规则：
        1. 文件名与类名匹配的专用文件 (AudioFrame.java -> AudioFrame)
        2. 在base/core等核心包中的定义
        3. 较短的文件路径（更可能是主定义而不是引用）
        4. 行号较小的定义（通常是主类定义而不是内部类）
        
        Args:
            candidates: 候选列表 [(文件路径, 行号)]
            class_name: 类名
            
        Returns:
            Tuple[str, int]: 最佳候选 (文件路径, 行号)
        """
        if len(candidates) == 1:
            return candidates[0]
        
        logger.debug("为类 {} 选择最佳候选，共 {} 个选项", class_name, len(candidates))
        for file_path, line_num in candidates:
            logger.debug("  候选: {}:{}", file_path, line_num)
        
        # 评分系统
        scored_candidates = []
        
        for file_path, line_num in candidates:
            score = 0
            
            # 1. 文件名匹配 (+100分)
            filename = file_path.split('/')[-1].split('\\')[-1]  # 兼容不同路径分隔符
            if filename == f"{class_name}.java":
                score += 100
                logger.debug("  {}:{} 文件名匹配 +100", file_path, line_num)
            
            # 2. 核心包路径 (+50分)
            if any(pkg in file_path.lower() for pkg in ['/base/', '/core/', '/rtc2/']):
                score += 50
                logger.debug("  {}:{} 核心包 +50", file_path, line_num)
            
            # 3. 避免测试/示例/内部路径 (-30分)
            if any(bad in file_path.lower() for bad in ['/test/', '/example/', '/sample/', '/demo/']):
                score -= 30
                logger.debug("  {}:{} 测试/示例路径 -30", file_path, line_num)
            
            # 4. 较短路径 (+20分，路径越短分数越高)
            path_depth = file_path.count('/') + file_path.count('\\')
            score += max(0, 20 - path_depth)
            
            # 5. 较小行号 (+10分，行号越小分数越高)
            score += max(0, 100 - line_num) // 10
            
            scored_candidates.append((score, file_path, line_num))
            logger.debug("  {}:{} 总分: {}", file_path, line_num, score)
        
        # 按分数排序，选择最高分
        scored_candidates.sort(key=lambda x: x[0], reverse=True)
        best_score, best_file, best_line = scored_candidates[0]
        
        logger.debug("选择最佳候选: {}:{} (得分: {})", best_file, best_line, best_score)
        return (best_file, best_line)
    
    def _select_best_enum_candidate(self, candidates: List[Tuple[str, int]], enum_name: str) -> Tuple[str, int]:
        """
        从多个枚举候选中选择最佳的
        
        优先级规则:
        1. 优先选择 enum 定义而不是 class 定义 (+100分)
        2. 优先选择文件名匹配的候选 (+50分)
        3. 优先选择更小的行号 (更早定义，+行号差值分)
        
        Args:
            candidates: 候选列表 [(文件路径, 行号), ...]
            enum_name: 枚举名称
            
        Returns:
            Tuple[str, int]: 最佳候选的 (文件路径, 行号)
        """
        if len(candidates) == 1:
            return candidates[0]
        
        logger.debug("为枚举 {} 选择最佳候选，共 {} 个选项", enum_name, len(candidates))
        for file_path, line_num in candidates:
            logger.debug("  候选: {}:{}", file_path, line_num)
        
        scored_candidates = []
        
        for file_path, line_num in candidates:
            score = 0
            
            try:
                content = read_file_content(file_path)
                if not content:
                    continue
                
                lines = content.split('\n')
                if line_num - 1 >= len(lines):
                    continue
                
                line = lines[line_num - 1].strip()
                
                # 规则1: 优先选择enum定义
                if f'public enum {enum_name}' in line:
                    score += 100
                    logger.debug("  {}:{} enum定义 +100", file_path, line_num)
                elif f'public class {enum_name}' in line:
                    score += 0  # class定义不加分
                    logger.debug("  {}:{} class定义 +0", file_path, line_num)
                
                # 规则2: 文件名匹配
                file_name = file_path.split('/')[-1].split('\\')[-1].lower()
                if enum_name.lower() in file_name:
                    score += 50
                    logger.debug("  {}:{} 文件名匹配 +50", file_path, line_num)
                
                # 规则3: 更小的行号 (更早定义)
                line_bonus = max(0, 100 - line_num) // 10
                score += line_bonus
                logger.debug("  {}:{} 行号优势 +{}", file_path, line_num, line_bonus)
                
                scored_candidates.append((score, file_path, line_num))
                logger.debug("  {}:{} 总分: {}", file_path, line_num, score)
                
            except Exception as e:
                logger.warning("评估枚举候选失败 {}:{}: {}", file_path, line_num, str(e))
                continue
        
        if not scored_candidates:
            return candidates[0]
        
        # 按分数降序排序，选择最高分的候选
        scored_candidates.sort(key=lambda x: x[0], reverse=True)
        best_score, best_file, best_line = scored_candidates[0]
        
        logger.debug("选择最佳枚举候选: {}:{} (得分: {})", best_file, best_line, best_score)
        return (best_file, best_line)
