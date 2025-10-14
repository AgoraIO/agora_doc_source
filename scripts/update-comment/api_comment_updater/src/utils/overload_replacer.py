#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
重载方法名替换器
用于将注释中的重载方法名（如 methodName [1/2]）替换为对应的方法签名
"""

import re
import json
from typing import Dict, List, Optional, Tuple
from loguru import logger


class OverloadReplacer:
    """重载方法名替换器"""
    
    def __init__(self):
        """初始化替换器"""
        self.overload_mapping = {}  # {method_name_with_overload: signature}
        
    def build_overload_mapping(self, data: Dict) -> None:
        """构建重载方法名到签名的映射
        
        Args:
            data: 完整的JSON数据
        """
        logger.debug("开始构建重载方法映射")
        self.overload_mapping.clear()
        
        # 处理API中的重载方法
        if "api" in data:
            for api_item in data["api"]:
                name = api_item.get("name", "")
                signature = api_item.get("signature", "")
                
                # 检查是否包含重载标识
                if self._has_overload_identifier(name):
                    # 提取简化的方法签名（去除virtual、返回类型等）
                    simplified_signature = self._extract_method_signature(signature)
                    if simplified_signature:
                        self.overload_mapping[name] = simplified_signature
                        logger.debug("添加API重载映射: {} -> {}", name, simplified_signature)
        
        logger.info("构建重载方法映射完成，共 {} 个重载方法", len(self.overload_mapping))
    
    def replace_overload_references(self, data: Dict) -> Dict:
        """替换注释中的重载方法引用
        
        Args:
            data: 完整的JSON数据
            
        Returns:
            替换后的JSON数据
        """
        logger.info("开始替换重载方法引用")
        
        # 先构建映射
        self.build_overload_mapping(data)
        
        # 替换API注释中的重载引用
        if "api" in data:
            for api_item in data["api"]:
                if "comment" in api_item:
                    api_item["comment"] = self._replace_in_comment_lines(api_item["comment"])
        
        # 替换Class注释中的重载引用
        if "class" in data:
            for class_item in data["class"]:
                if "class_comment" in class_item:
                    for comment_item in class_item["class_comment"]:
                        if "comment" in comment_item:
                            comment_item["comment"] = self._replace_in_comment_lines(comment_item["comment"])
        
        # 替换Enum注释中的重载引用
        if "enum" in data:
            for enum_item in data["enum"]:
                if "enum_comment" in enum_item:
                    for comment_item in enum_item["enum_comment"]:
                        if "comment" in comment_item:
                            comment_item["comment"] = self._replace_in_comment_lines(comment_item["comment"])
        
        logger.info("重载方法引用替换完成")
        return data
    
    def _has_overload_identifier(self, name: str) -> bool:
        """检查方法名是否包含重载标识
        
        Args:
            name: 方法名
            
        Returns:
            是否包含重载标识
        """
        return bool(re.search(r'\[\d+/\d+\]', name))
    
    def _extract_method_signature(self, signature: str) -> Optional[str]:
        """从完整签名中提取简化的方法签名
        
        Args:
            signature: 完整的方法签名
            
        Returns:
            简化的方法签名，只保留方法名和参数，如 methodName(const char* key, int value)
        """
        try:
            # 去除换行符和多余空格
            cleaned_signature = re.sub(r'\n', ' ', signature.strip())
            cleaned_signature = re.sub(r'\s+', ' ', cleaned_signature)
            
            # 处理宏定义包装的情况
            # 例如: "#if defined(...) virtual int methodName(...) = 0; #endif"
            macro_match = re.search(r'#if.*?#endif', cleaned_signature, re.DOTALL)
            if macro_match:
                # 提取宏定义内的函数签名
                macro_content = macro_match.group(0)
                # 从宏内容中提取函数签名部分，更精确的匹配
                # 匹配 virtual/static 等修饰符 + 返回类型 + 方法名 + 参数
                inner_signature = re.search(r'(virtual|static|const|public|private|protected|abstract)?\s*\w+\s+(\w+)\s*\(([^)]*)\)\s*=\s*0\s*;', macro_content)
                if inner_signature:
                    # 直接构造简化签名
                    method_name = inner_signature.group(2)
                    params = inner_signature.group(3).strip()
                    return f"{method_name}({params})"
            
            # 移除前缀修饰符
            cleaned_signature = re.sub(r'^(virtual|static|const|public|private|protected|abstract)\s+', '', cleaned_signature)
            
            # 移除返回类型，只保留方法名和参数
            # 匹配模式: [返回类型] 方法名(参数...)
            method_match = re.search(r'\b(\w+)\s*\(([^)]*)\)', cleaned_signature)
            if method_match:
                method_name = method_match.group(1)
                params = method_match.group(2).strip()
                return f"{method_name}({params})"
            
            # 如果无法匹配，尝试清理后返回
            cleaned_signature = re.sub(r'\s*=\s*0\s*;?\s*$', '', cleaned_signature)
            cleaned_signature = re.sub(r'\s*\{.*?\}\s*$', '', cleaned_signature, flags=re.DOTALL)
            cleaned_signature = re.sub(r'\s*;\s*$', '', cleaned_signature)
            
            return cleaned_signature.strip()
            
        except Exception as e:
            logger.warning("提取方法签名失败: {}, 错误: {}", signature, str(e))
        
        return None
    
    
    def _replace_in_comment_lines(self, comment_lines: List[str]) -> List[str]:
        """在注释行中替换重载方法引用
        
        Args:
            comment_lines: 注释行列表
            
        Returns:
            替换后的注释行列表
        """
        if not comment_lines or not self.overload_mapping:
            return comment_lines
        
        result_lines = []
        i = 0
        
        while i < len(comment_lines):
            line = comment_lines[i]
            
            # 检查当前行是否包含重载方法引用
            replacements_made = False
            for overload_name, signature in self.overload_mapping.items():
                # 提取基础方法名（去除重载标识）
                base_method_name = re.sub(r'\s*\[\d+/\d+\]', '', overload_name)
                
                # 模式1: 完整匹配在同一行 `methodName [1/2]`
                pattern1 = re.escape(overload_name)
                if re.search(f'`{pattern1}`', line):
                    line = re.sub(f'`{re.escape(overload_name)}`', f'`{signature}`', line)
                    logger.debug("替换重载引用: {} -> {}", overload_name, signature)
                    replacements_made = True
                    continue
                
                # 模式2: 跨行匹配 - 方法名在当前行，重载标识在下一行
                if i < len(comment_lines) - 1:
                    next_line = comment_lines[i + 1]
                    
                    # 检查当前行是否以方法名结尾（可能带反引号）
                    current_line_pattern = rf'`{re.escape(base_method_name)}\s*$'
                    # 检查下一行是否以重载标识开始
                    overload_identifier = re.search(r'\[(\d+/\d+)\]', overload_name)
                    if overload_identifier:
                        identifier = overload_identifier.group(1)
                        next_line_pattern = rf'^\s*\*?\s*\[{re.escape(identifier)}\]`'
                        
                        if re.search(current_line_pattern, line) and re.search(next_line_pattern, next_line):
                            # 将完整的方法签名放在当前行
                            line = re.sub(rf'`{re.escape(base_method_name)}\s*$', f'`{signature}`', line)
                            # 下一行移除重载标识，保持正确的注释格式
                            next_line_cleaned = re.sub(rf'^\s*(\*?\s*)\[{re.escape(identifier)}\]`', r'\1', next_line).strip()
                            if next_line_cleaned in ['*', ' *', '']:
                                # 如果下一行变空，设置为注释行格式
                                comment_lines[i + 1] = ' *'
                            else:
                                # 确保保持正确的注释格式
                                if not next_line_cleaned.startswith(' *'):
                                    comment_lines[i + 1] = ' * ' + next_line_cleaned.lstrip('* ')
                                else:
                                    comment_lines[i + 1] = next_line_cleaned
                            
                            logger.debug("跨行替换重载引用: {} -> {}", overload_name, signature)
                            replacements_made = True
                            break
            
            result_lines.append(line)
            i += 1
        
        return result_lines


def main():
    """命令行入口，支持直接处理JSON文件"""
    import argparse
    import sys
    
    parser = argparse.ArgumentParser(description='重载方法名替换工具')
    parser.add_argument('input_file', help='输入JSON文件路径')
    parser.add_argument('-o', '--output', help='输出JSON文件路径（默认为输入文件名_replaced.json）')
    parser.add_argument('-v', '--verbose', action='store_true', help='显示详细日志')
    
    args = parser.parse_args()
    
    # 设置日志级别
    if args.verbose:
        logger.remove()
        logger.add(sys.stderr, level="DEBUG")
    
    try:
        # 读取输入文件
        with open(args.input_file, 'r', encoding='utf-8') as f:
            data = json.load(f)
        
        logger.info("读取输入文件: {}", args.input_file)
        
        # 创建替换器并处理
        replacer = OverloadReplacer()
        result = replacer.replace_overload_references(data)
        
        # 确定输出文件名
        if args.output:
            output_file = args.output
        else:
            # 默认输出文件名：原文件名_replaced.json
            input_path = args.input_file
            if input_path.endswith('.json'):
                output_file = input_path[:-5] + '_replaced.json'
            else:
                output_file = input_path + '_replaced.json'
        
        # 写入输出文件
        with open(output_file, 'w', encoding='utf-8') as f:
            json.dump(result, f, indent=2, ensure_ascii=False)
        
        logger.info("处理完成，输出文件: {}", output_file)
        print(f"✅ 重载方法替换完成！")
        print(f"📁 输入文件: {args.input_file}")
        print(f"📁 输出文件: {output_file}")
        
    except FileNotFoundError:
        logger.error("文件不存在: {}", args.input_file)
        sys.exit(1)
    except json.JSONDecodeError as e:
        logger.error("JSON文件格式错误: {}", str(e))
        sys.exit(1)
    except Exception as e:
        logger.error("处理失败: {}", str(e))
        sys.exit(1)


if __name__ == '__main__':
    main()
