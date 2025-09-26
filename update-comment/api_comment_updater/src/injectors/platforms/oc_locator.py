# -*- coding: utf-8 -*-
"""
Objective-C平台特定的代码定位器
"""

import re
from typing import List, Dict, Any, Optional, Tuple
from loguru import logger

from ...utils.file_utils import read_file_content
from .base import BaseLocator


class OcLocator(BaseLocator):
    """Objective-C代码定位器"""
    
    def locate_api(self, api_data: Dict[str, Any]) -> Optional[Tuple[str, int]]:
        """
        定位API在代码中的位置 - Objective-C版本
        
        Args:
            api_data: API数据，包含name、signature、parent_class等信息
            
        Returns:
            Tuple[str, int]: (文件路径, 行号)，如果未找到返回None
        """
        api_name = api_data.get("name", "")
        api_signature = api_data.get("signature", "")
        parent_class = api_data.get("parent_class", "")
        
        if not api_name:
            logger.warning("Objective-C API名称为空，跳过定位")
            return None
        
        # 提取纯净API名称（去除重载标识、OC参数等）
        clean_name = self._extract_clean_api_name(api_name)
        logger.debug("开始定位Objective-C API: {} (clean_name: {}, parent_class: {})", 
                    api_name, clean_name, parent_class)
        
        # 获取搜索文件列表
        search_files = self._get_search_files()
        if not search_files:
            logger.warning("未找到Objective-C搜索文件")
            return None
        
        logger.debug("Objective-C搜索文件数量: {}", len(search_files))
        
        # 存储各步骤的候选结果，用于后续parent_class验证
        step_candidates = {}
        
        # 步骤1: 完整签名匹配（性能开销最小，准确性最高）
        if api_signature:
            candidates = self._find_all_signature_matches(api_signature, search_files)
            if len(candidates) == 1:
                logger.info("通过完整签名定位到Objective-C API {}: {}:{}", api_name, candidates[0][0], candidates[0][1])
                return candidates[0]
            elif len(candidates) > 1:
                step_candidates[1] = candidates
                logger.debug("完整签名匹配找到 {} 个Objective-C候选位置", len(candidates))
        
        # 步骤2: 关键字+纯净API名匹配（命中率较高，性能开销中等）
        candidates = self._find_all_keywords_name_matches(clean_name, api_signature, search_files)
        if len(candidates) == 1:
            logger.info("通过关键字+名称定位到Objective-C API {}: {}:{}", api_name, candidates[0][0], candidates[0][1])
            return candidates[0]
        elif len(candidates) > 1:
            step_candidates[2] = candidates
            logger.debug("关键字+名称匹配找到 {} 个Objective-C候选位置", len(candidates))
        
        # 步骤3: 增强签名匹配（性能开销较大，尽量减少调用）
        if api_signature:
            candidates = self._find_all_signature_matches_enhanced(api_signature, search_files)
            if len(candidates) == 1:
                logger.info("通过增强签名定位到Objective-C API {}: {}:{}", api_name, candidates[0][0], candidates[0][1])
                return candidates[0]
            elif len(candidates) > 1:
                step_candidates[3] = candidates
                logger.debug("增强签名匹配找到 {} 个Objective-C候选位置", len(candidates))
        
        # 步骤4: 纯净名称匹配
        candidates = self._find_all_name_matches(clean_name, search_files)
        if len(candidates) == 1:
            logger.info("通过名称定位到Objective-C API {}: {}:{}", api_name, candidates[0][0], candidates[0][1])
            return candidates[0]
        elif len(candidates) > 1:
            step_candidates[4] = candidates
            logger.debug("名称匹配找到 {} 个Objective-C候选位置", len(candidates))
        
        # 步骤5: parent_class验证（处理多结果情况，仅处理有parent_class的情况）
        if step_candidates and parent_class:
            # 优先选择增强签名匹配（步骤3），其次选择结果数量最少的步骤
            if 3 in step_candidates:
                selected_step = 3
                candidates = step_candidates[3]
                logger.debug("优先选择增强签名匹配（步骤3）的 {} 个候选位置进行parent_class验证", len(candidates))
            else:
                # 选择结果数量最少的步骤，数量相同按步骤顺序
                min_count = min(len(candidates) for candidates in step_candidates.values())
                selected_step = min(step for step, candidates in step_candidates.items() 
                                  if len(candidates) == min_count)
                candidates = step_candidates[selected_step]
                logger.debug("选择步骤 {} 的 {} 个候选位置进行parent_class验证", selected_step, len(candidates))
            
            # 进行parent_class验证
            for file_path, line_number in candidates:
                if self._verify_parent_class(file_path, line_number, parent_class):
                    logger.info("通过parent_class验证定位到Objective-C API {}: {}:{}", api_name, file_path, line_number)
                    return (file_path, line_number)
            
            logger.warning("parent_class验证失败，所有候选位置都不属于类 {}", parent_class)
            return None
        return None
    
    def locate_class(self, class_data: Dict[str, Any]) -> Optional[Tuple[str, int]]:
        """
        定位类在代码中的位置 - Objective-C版本
        
        Args:
            class_data: 类数据
            
        Returns:
            Tuple[str, int]: (文件路径, 行号)，如果未找到返回None
        """
        class_name = class_data.get("name", "")
        logger.debug("开始定位Objective-C类: {}", class_name)
        
        search_files = self._get_search_files()
        if not search_files:
            logger.warning("未找到Objective-C搜索文件")
            return None
        
        logger.debug("Objective-C搜索文件数量: {}", len(search_files))
        
        # 搜索@interface声明
        for file_path in search_files:
            try:
                content = read_file_content(file_path)
                lines = content.split('\n')
                
                for line_num, line in enumerate(lines, 1):
                    line_clean = self._clean_code_line_for_matching(line)
                    
                    # 查找@interface或@protocol声明
                    if '@interface' in line_clean or '@protocol' in line_clean:
                        # 检查是否是完整的类声明（包括 Category 格式）
                        if self._is_class_interface_definition(line_clean, class_name):
                            logger.info("定位到Objective-C类 {}: {}", class_name, f"{file_path}:{line_num}")
                            return (file_path, line_num)
                            
            except Exception as e:
                logger.debug("读取文件失败 {}: {}", file_path, str(e))
                continue
        
        logger.warning("未能定位Objective-C类 {}", class_name)
        return None
    
    def _is_class_interface_definition(self, line: str, class_name: str) -> bool:
        """
        判断是否为Objective-C类接口定义（包括@protocol）
        
        Args:
            line: 代码行
            class_name: 类名
            
        Returns:
            bool: 是否为类接口定义
        """
        # 检查是否包含@interface或@protocol
        if '@interface' not in line and '@protocol' not in line:
            return False
        
        # 检查是否是类声明格式
        # @interface ClassName : ParentClass
        # @interface ClassName
        # @interface ClassName(Category)
        # @protocol ClassName <ParentProtocol>
        # @protocol ClassName (真正的定义，不是前向声明)
        patterns = [
            rf'@interface\s+{re.escape(class_name)}\s*:',
            rf'@interface\s+{re.escape(class_name)}\s*$',
            rf'@interface\s+{re.escape(class_name)}\s*\(',
            # 匹配协议定义，排除前向声明（以分号结尾的）
            rf'@protocol\s+{re.escape(class_name)}\s*(?!\s*;)(?:\s*<[^>]*>)?\s*$',
        ]
        
        for pattern in patterns:
            if re.search(pattern, line):
                return True
        
        # 特殊处理 Category 格式：AgoraRtcEngineKitEx -> AgoraRtcEngineKit(Ex)
        if class_name.endswith('Ex'):
            main_class = class_name[:-2]  # 移除 'Ex' 后缀
            category_pattern = rf'@interface\s+{re.escape(main_class)}\s*\(\s*Ex\s*\)'
            if re.search(category_pattern, line):
                return True
        
        # 特殊处理其他常见的 Category 格式
        # 例如：ClassNameCategory -> ClassName(Category)
        if len(class_name) > 8 and class_name.endswith('Category'):
            main_class = class_name[:-8]  # 移除 'Category' 后缀
            category_pattern = rf'@interface\s+{re.escape(main_class)}\s*\(\s*Category\s*\)'
            if re.search(category_pattern, line):
                return True
        
        return False
    
    def locate_enum(self, enum_data: Dict[str, Any]) -> Optional[Tuple[str, int]]:
        """
        定位枚举在代码中的位置 - Objective-C版本
        
        Args:
            enum_data: 枚举数据
            
        Returns:
            Tuple[str, int]: (文件路径, 行号)，如果未找到返回None
        """
        enum_name = enum_data.get("name", "")
        logger.debug("开始定位Objective-C枚举: {}", enum_name)
        
        search_files = self._get_search_files()
        if not search_files:
            logger.warning("未找到Objective-C搜索文件")
            return None
        
        logger.debug("Objective-C搜索文件数量: {}", len(search_files))
        
        # 搜索枚举声明
        for file_path in search_files:
            try:
                content = read_file_content(file_path)
                lines = content.split('\n')
                
                for line_num, line in enumerate(lines, 1):
                    line_clean = self._clean_code_line_for_matching(line)
                    
                    # 查找枚举声明
                    if self._is_enum_definition(line_clean, enum_name):
                        logger.info("定位到Objective-C枚举 {}: {}", enum_name, f"{file_path}:{line_num}")
                        return (file_path, line_num)
                            
            except Exception as e:
                logger.debug("读取文件失败 {}: {}", file_path, str(e))
                continue
        
        logger.warning("未能定位Objective-C枚举 {}", enum_name)
        return None
    
    def _is_enum_definition(self, line: str, enum_name: str) -> bool:
        """
        判断是否为Objective-C枚举定义
        
        Args:
            line: 代码行
            enum_name: 枚举名
            
        Returns:
            bool: 是否为枚举定义
        """
        # 检查是否包含枚举名
        if enum_name not in line:
            return False
        
        # 检查是否是枚举声明格式
        # typedef enum { ... } EnumName;
        # typedef NS_ENUM(NSInteger, EnumName) { ... };
        # typedef NS_OPTIONS(NSUInteger, EnumName) { ... };
        patterns = [
            rf'typedef\s+enum\s*.*{re.escape(enum_name)}',
            rf'typedef\s+NS_ENUM\s*\([^)]+,\s*{re.escape(enum_name)}',
            rf'typedef\s+NS_OPTIONS\s*\([^)]+,\s*{re.escape(enum_name)}',
            rf'enum\s+{re.escape(enum_name)}\s*{{',
        ]
        
        for pattern in patterns:
            if re.search(pattern, line):
                return True
        
        return False
    
    def locate_class_attribute(self, class_data: Dict[str, Any], attribute_name: str) -> Optional[Tuple[str, int]]:
        """
        定位类属性在代码中的位置 - Objective-C版本
        
        Args:
            class_data: 类数据
            attribute_name: 属性名称
            
        Returns:
            Tuple[str, int]: (文件路径, 行号)，如果未找到返回None
        """
        class_name = class_data.get("name", "")
        logger.debug("开始定位Objective-C类属性: {}.{}", class_name, attribute_name)
        
        # 先定位类的位置
        class_location = self.locate_class(class_data)
        if not class_location:
            logger.warning("无法定位类 {}，跳过属性定位", class_name)
            return None
        
        file_path, class_line = class_location
        
        try:
            content = read_file_content(file_path)
            lines = content.split('\n')
            
            # 在类定义范围内搜索属性
            for line_num in range(class_line, len(lines)):
                line = lines[line_num - 1]
                line_clean = self._clean_code_line_for_matching(line)
                
                # 查找@property声明
                if self._is_attribute_definition_enhanced(line_clean, attribute_name):
                    logger.info("定位到Objective-C类属性 {}.{}: {}", class_name, attribute_name, f"{file_path}:{line_num}")
                    return (file_path, line_num)
                
                # 如果遇到下一个类定义，停止搜索
                if line_num > class_line and ('@interface' in line_clean or '@implementation' in line_clean):
                    break
                    
        except Exception as e:
            logger.debug("读取文件失败 {}: {}", file_path, str(e))
        return None
    
    def _is_attribute_definition_enhanced(self, line: str, attribute_name: str) -> bool:
        """
        判断是否为Objective-C属性定义
        
        Args:
            line: 代码行
            attribute_name: 属性名
            
        Returns:
            bool: 是否为属性定义
        """
        # 检查是否包含@property和属性名
        if '@property' not in line or attribute_name not in line:
            return False
        
        # 检查是否是属性声明格式
        # @property (nonatomic, strong) Type attributeName;
        # @property (nonatomic, assign) Type attributeName;
        patterns = [
            rf'@property\s*\([^)]*\)\s+[^{{]*{re.escape(attribute_name)}',
            rf'@property\s+[^{{]*{re.escape(attribute_name)}',
        ]
        
        for pattern in patterns:
            if re.search(pattern, line):
                return True
        
        return False
    
    def locate_enum_value(self, enum_data: Dict[str, Any], value_name: str) -> Optional[Tuple[str, int]]:
        """
        定位枚举值在代码中的位置 - Objective-C版本
        
        Args:
            enum_data: 枚举数据
            value_name: 枚举值名称
            
        Returns:
            Tuple[str, int]: (文件路径, 行号)，如果未找到返回None
        """
        enum_name = enum_data.get("name", "")
        logger.debug("开始定位Objective-C枚举值: {}.{}", enum_name, value_name)
        
        # 先定位枚举的位置
        enum_location = self.locate_enum(enum_data)
        if not enum_location:
            logger.warning("无法定位枚举 {}，跳过枚举值定位", enum_name)
            return None
        
        file_path, enum_line = enum_location
        
        try:
            content = read_file_content(file_path)
            lines = content.split('\n')
            
            # 在枚举定义范围内搜索枚举值
            for line_num in range(enum_line, len(lines)):
                line = lines[line_num - 1]
                line_clean = self._clean_code_line_for_matching(line)
                
                # 查找枚举值定义
                if self._is_enum_value_definition(line_clean, value_name):
                    logger.info("定位到Objective-C枚举值 {}.{}: {}", enum_name, value_name, f"{file_path}:{line_num}")
                    return (file_path, line_num)
                
                # 如果遇到下一个枚举或类定义，停止搜索
                if line_num > enum_line and ('typedef' in line_clean or '@interface' in line_clean or '@implementation' in line_clean):
                    break
                    
        except Exception as e:
            logger.debug("读取文件失败 {}: {}", file_path, str(e))
        return None
    
    def _is_enum_value_definition(self, line: str, value_name: str) -> bool:
        """
        判断是否为Objective-C枚举值定义
        
        Args:
            line: 代码行
            value_name: 枚举值名
            
        Returns:
            bool: 是否为枚举值定义
        """
        # 检查是否包含枚举值名
        if value_name not in line:
            return False
        
        # 检查是否是枚举值定义格式
        # EnumValue = 0,
        # EnumValue,
        # EnumValue = 1 << 0,
        # EnumValue __deprecated = 2,
        # EnumValue __attribute__((deprecated)) = 3,
        patterns = [
            rf'{re.escape(value_name)}\s*=',
            rf'{re.escape(value_name)}\s*,',
            rf'{re.escape(value_name)}\s*$',
            rf'{re.escape(value_name)}\s+__deprecated\s*=',
            rf'{re.escape(value_name)}\s+__attribute__\s*\(\s*deprecated\s*\)\s*=',
        ]
        
        for pattern in patterns:
            if re.search(pattern, line):
                return True
        
        return False
    
    # ==================== Objective-C特定实现 ====================
    
    def _clean_signature(self, signature: str) -> str:
        """
        清理Objective-C签名，移除HTML标签、多余空白和NS_SWIFT_NAME
        
        Args:
            signature: 原始Objective-C签名
            
        Returns:
            str: 清理后的签名
        """
        clean_sig = signature
        # 统一空白字符
        clean_sig = re.sub(r'\s+', ' ', clean_sig)
        # 移除首尾空白
        clean_sig = clean_sig.strip()
        # 移除NS_SWIFT_NAME部分，保持分号
        # 使用更精确的正则表达式处理嵌套括号
        clean_sig = re.sub(r'\s+NS_SWIFT_NAME\([^()]*(?:\([^()]*\)[^()]*)*\)', '', clean_sig)
        # 移除deprecated标记
        clean_sig = re.sub(r'\s+__deprecated_msg\([^)]*\)', '', clean_sig)
        return clean_sig
    
    def _clean_code_line_for_matching(self, line: str) -> str:
        """
        清理Objective-C代码行，移除多余空白、NS_SWIFT_NAME和deprecated标记
        
        Args:
            line: 原始Objective-C代码行
            
        Returns:
            str: 清理后的代码行
        """
        clean_line = line.strip()
        # 统一空白字符
        clean_line = re.sub(r'\s+', ' ', clean_line)
        # 移除NS_SWIFT_NAME部分，保持分号
        # 使用更精确的正则表达式处理嵌套括号
        clean_line = re.sub(r'\s+NS_SWIFT_NAME\([^()]*(?:\([^()]*\)[^()]*)*\)', '', clean_line)
        # 移除deprecated标记
        clean_line = re.sub(r'\s+__deprecated_msg\([^)]*\)', '', clean_line)
        return clean_line
    
    def _find_nearest_parent_class(self, lines: List[str], api_line_index: int) -> Optional[str]:
        """
        从指定位置向上搜索，找到最近的Objective-C类声明
        
        Args:
            lines: 文件行列表
            api_line_index: API所在行的索引（0-based）
            
        Returns:
            Optional[str]: 找到的类名，如果未找到返回None
        """
        # 从API行向上搜索最近的类声明
        for i in range(api_line_index - 1, -1, -1):
            line = lines[i].strip()
            
            # 查找@interface声明
            if '@interface' in line:
                # 处理各种@interface格式：
                # @interface ClassName : ParentClass
                # @interface ClassName(Category)
                # @interface ClassName
                class_match = re.search(r'@interface\s+(\w+)', line)
                if class_match:
                    found_class = class_match.group(1)
                    logger.debug("找到Objective-C父类: {} 在行 {}", found_class, i + 1)
                    return found_class
            
            # 查找@protocol声明
            if '@protocol' in line:
                # 处理@protocol格式：
                # @protocol ProtocolName <ParentProtocol>
                # @protocol ProtocolName
                protocol_match = re.search(r'@protocol\s+(\w+)', line)
                if protocol_match:
                    found_protocol = protocol_match.group(1)
                    logger.debug("找到Objective-C协议: {} 在行 {}", found_protocol, i + 1)
                    return found_protocol
            
            # 查找@implementation声明
            if '@implementation' in line:
                # 处理@implementation格式
                impl_match = re.search(r'@implementation\s+(\w+)', line)
                if impl_match:
                    found_class = impl_match.group(1)
                    logger.debug("找到Objective-C实现类: {} 在行 {}", found_class, i + 1)
                    return found_class
        
        return None
    
    # ==================== Objective-C特定的辅助方法 ====================
    
    def _extract_clean_api_name(self, api_name: str) -> str:
        """
        提取纯净的API名称，去除重载标识和OC参数
        
        Args:
            api_name: 原始API名称
            
        Returns:
            str: 清理后的API名称
        """
        # 去除重载标识 [1/2], [2/2] 等
        clean_name = re.sub(r'\s*\[\d+/\d+\]', '', api_name)
        
        # 去除OC参数标识 :param1:param2: 等
        # 保留方法名部分，去除参数部分
        if ':' in clean_name:
            # 对于OC方法，只保留方法名部分
            clean_name = clean_name.split(':')[0]
        
        return clean_name.strip()
    
    def _find_all_keywords_name_matches(self, clean_name: str, signature: str, search_files: List[str]) -> List[Tuple[str, int]]:
        """
        使用关键字+纯净名称匹配查找所有候选位置
        
        Args:
            clean_name: 纯净API名称
            signature: API签名
            search_files: 搜索文件列表
            
        Returns:
            List[Tuple[str, int]]: 候选位置列表
        """
        candidates = []
        
        # Objective-C方法关键字
        oc_keywords = [
            '- (',  # 实例方法
            '+ (',  # 类方法
        ]
        
        for file_path in search_files:
            try:
                content = read_file_content(file_path)
                lines = content.split('\n')
                
                # 首先尝试单行匹配
                for line_num, line in enumerate(lines, 1):
                    line_clean = self._clean_code_line_for_matching(line)
                    
                    # 检查是否包含关键字和API名称
                    for keyword in oc_keywords:
                        if keyword in line_clean and clean_name in line_clean:
                            # 进一步验证：确保是方法定义而不是调用
                            if self._is_method_definition(line_clean, clean_name):
                                candidates.append((file_path, line_num))
                                break
                
                # 如果单行匹配失败，尝试多行匹配
                if not candidates:
                    # 使用通用多行匹配方法，传入关键字匹配函数
                    def keyword_match_func(signature):
                        for keyword in oc_keywords:
                            if keyword in signature and clean_name in signature:
                                return self._is_method_definition(signature, clean_name)
                        return False
                    candidates.extend(self._find_multiline_matches(file_path, lines, keyword_match_func))
                                
            except Exception as e:
                logger.debug("读取文件失败 {}: {}", file_path, str(e))
                continue
        
        return candidates
    
    
    def _is_method_definition(self, line: str, method_name: str) -> bool:
        """
        判断是否为Objective-C方法定义
        
        Args:
            line: 代码行
            method_name: 方法名
            
        Returns:
            bool: 是否为方法定义
        """
        # 检查是否以方法关键字开头
        if not (line.strip().startswith('- (') or line.strip().startswith('+ (')):
            return False
        
        # 检查是否包含方法名
        if method_name not in line:
            return False
        
        # 检查是否包含返回类型和参数
        # Objective-C方法格式：- (ReturnType)methodName:(ParamType)param1 otherParam:(ParamType)param2
        if ')' in line and ':' in line:
            return True
        
        return False
    
    def _find_all_signature_matches(self, signature: str, search_files: List[str]) -> List[Tuple[str, int]]:
        """
        使用完整签名匹配查找所有候选位置
        
        Args:
            signature: API签名
            search_files: 搜索文件列表
            
        Returns:
            List[Tuple[str, int]]: 候选位置列表
        """
        candidates = []
        clean_signature = self._clean_signature(signature)
        
        for file_path in search_files:
            try:
                content = read_file_content(file_path)
                lines = content.split('\n')
                
                # 首先尝试单行匹配
                for line_num, line in enumerate(lines, 1):
                    line_clean = self._clean_code_line_for_matching(line)
                    
                    # 直接匹配清理后的签名
                    if clean_signature in line_clean:
                        candidates.append((file_path, line_num))
                    # 如果直接匹配失败，尝试移除NS_SWIFT_NAME部分后匹配
                    elif 'NS_SWIFT_NAME' in line_clean:
                        # 移除NS_SWIFT_NAME部分，保持分号
                        line_without_swift = re.sub(r'\s+NS_SWIFT_NAME\([^)]+\)', '', line_clean)
                        # 确保以分号结尾
                        if not line_without_swift.endswith(';'):
                            line_without_swift += ';'
                        if clean_signature in line_without_swift:
                            candidates.append((file_path, line_num))
                
                # 如果单行匹配失败，尝试多行匹配
                if not candidates:
                    # 使用通用多行匹配方法，传入精确匹配函数
                    def exact_match_func(signature):
                        return signature == clean_signature
                    candidates.extend(self._find_multiline_matches(file_path, lines, exact_match_func))
                        
            except Exception as e:
                logger.debug("读取文件失败 {}: {}", file_path, str(e))
                continue
        
        return candidates
    
    def _find_multiline_matches(self, file_path: str, lines: List[str], match_func) -> List[Tuple[str, int]]:
        """
        通用的多行方法签名匹配方法
        
        Args:
            file_path: 文件路径
            lines: 文件行列表
            match_func: 匹配函数，接受合并后的签名字符串，返回是否匹配
            
        Returns:
            List[Tuple[str, int]]: 候选位置列表
        """
        candidates = []
        
        # 将多行签名合并为单行进行比较
        for i in range(len(lines)):
            # 尝试从当前行开始构建多行签名
            multiline_signature = ""
            for j in range(i, min(i + 5, len(lines))):  # 最多检查5行
                line_clean = self._clean_code_line_for_matching(lines[j])
                if line_clean.strip():
                    multiline_signature += " " + line_clean
                    
                    # 如果遇到分号，说明方法签名结束
                    if line_clean.endswith(';'):
                        multiline_signature = multiline_signature.strip()
                        if match_func(multiline_signature):
                            candidates.append((file_path, i + 1))  # 返回第一行的行号
                        break
        
        return candidates
    
    def _find_all_signature_matches_enhanced(self, signature: str, search_files: List[str]) -> List[Tuple[str, int]]:
        """
        使用增强签名匹配查找所有候选位置
        
        Args:
            signature: API签名
            search_files: 搜索文件列表
            
        Returns:
            List[Tuple[str, int]]: 候选位置列表
        """
        candidates = []
        clean_signature = self._clean_signature(signature)
        
        # 提取关键组件进行匹配
        signature_components = self._extract_signature_components(clean_signature)
        
        for file_path in search_files:
            try:
                content = read_file_content(file_path)
                lines = content.split('\n')
                
                # 首先尝试单行匹配
                for line_num, line in enumerate(lines, 1):
                    line_clean = self._clean_code_line_for_matching(line)
                    
                    # 检查关键组件匹配
                    if self._match_signature_components(line_clean, signature_components):
                        candidates.append((file_path, line_num))
                
                # 如果单行匹配失败，尝试多行匹配
                if not candidates:
                    # 使用通用多行匹配方法，传入组件匹配函数
                    def component_match_func(signature):
                        return self._match_signature_components(signature, signature_components)
                    candidates.extend(self._find_multiline_matches(file_path, lines, component_match_func))
                        
            except Exception as e:
                logger.debug("读取文件失败 {}: {}", file_path, str(e))
                continue
        
        return candidates
    
    def _extract_signature_components(self, signature: str) -> List[str]:
        """
        提取签名的关键组件
        
        Args:
            signature: 清理后的签名
            
        Returns:
            List[str]: 关键组件列表
        """
        components = []
        
        # 提取方法名 - 支持有参数和无参数的方法
        # 使用更通用的正则表达式：匹配返回类型后的第一个单词
        # 例如：- (int)pause; 或 - (int)methodName:param
        method_match = re.search(r'\([^)]+\)\s*(\w+)', signature)
        if method_match:
            components.append(method_match.group(1))
        
        # 提取返回类型
        return_match = re.search(r'\(([^)]+)\)', signature)
        if return_match:
            components.append(return_match.group(1))
        
        # 提取参数类型
        param_matches = re.findall(r':\s*\(([^)]+)\)', signature)
        components.extend(param_matches)
        
        return components
    
    def _match_signature_components(self, line: str, components: List[str]) -> bool:
        """
        检查行是否匹配签名组件
        
        Args:
            line: 代码行
            components: 签名组件列表
            
        Returns:
            bool: 是否匹配
        """
        if not components:
            return False
        
        # 要求匹配所有组件（更严格的匹配）
        match_count = sum(1 for component in components if component in line)
        return match_count == len(components)
    
    def _find_all_name_matches(self, clean_name: str, search_files: List[str]) -> List[Tuple[str, int]]:
        """
        使用纯净名称匹配查找所有候选位置
        
        Args:
            clean_name: 纯净API名称
            search_files: 搜索文件列表
            
        Returns:
            List[Tuple[str, int]]: 候选位置列表
        """
        candidates = []
        
        for file_path in search_files:
            try:
                content = read_file_content(file_path)
                lines = content.split('\n')
                
                # 首先尝试单行匹配
                for line_num, line in enumerate(lines, 1):
                    line_clean = self._clean_code_line_for_matching(line)
                    
                    # 检查是否包含方法名
                    if clean_name in line_clean:
                        # 进一步验证：确保是方法定义
                        if self._is_method_definition(line_clean, clean_name):
                            candidates.append((file_path, line_num))
                
                # 如果单行匹配失败，尝试多行匹配
                if not candidates:
                    # 使用通用多行匹配方法，传入名称匹配函数
                    def name_match_func(signature):
                        if clean_name in signature:
                            return self._is_method_definition(signature, clean_name)
                        return False
                    candidates.extend(self._find_multiline_matches(file_path, lines, name_match_func))
                            
            except Exception as e:
                logger.debug("读取文件失败 {}: {}", file_path, str(e))
                continue
        
        return candidates
    
    def _verify_parent_class(self, file_path: str, line_number: int, parent_class: str) -> bool:
        """
        验证API是否属于指定的父类
        
        Args:
            file_path: 文件路径
            line_number: 行号
            parent_class: 父类名
            
        Returns:
            bool: 是否属于指定父类
        """
        try:
            content = read_file_content(file_path)
            lines = content.split('\n')
            
            # 使用 _find_nearest_parent_class 查找最近的类声明
            found_class = self._find_nearest_parent_class(lines, line_number)
            if not found_class:
                return False
            
            # 检查是否匹配主类名
            if found_class == parent_class:
                return True
            
            # 检查是否是Category格式：ClassName(Category)
            # 需要重新检查原始行以获取完整的Category信息
            for i in range(line_number - 1, -1, -1):
                line = lines[i].strip()
                if '@interface' in line:
                    category_match = re.search(r'@interface\s+(\w+)\((\w+)\)', line)
                    if category_match:
                        main_class = category_match.group(1)
                        category_name = category_match.group(2)
                        # 对于Category，检查主类名或完整名称
                        if main_class == parent_class or f"{main_class}({category_name})" == parent_class:
                            return True
                        # 特殊处理：如果parent_class是ClassNameEx格式，检查是否是ClassName(Ex)
                        if parent_class.endswith('Ex') and main_class == parent_class[:-2] and category_name == 'Ex':
                            return True
                    break  # 找到第一个@interface就停止
                        
        except Exception as e:
            logger.debug("验证父类失败 {}:{}: {}", file_path, line_number, str(e))
        
        return False
