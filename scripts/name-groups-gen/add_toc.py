#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
为 name_groups.json 中的 API 添加 toc 字段。

该脚本从 RTC_NG_API_*.ditamap 文件中提取 API 所属的分类（toc），
并将其添加到 name_groups.json 文件中。
"""

import os
import json
import re
import xml.etree.ElementTree as ET
from typing import Dict, List, Optional, Tuple
import logging

# 配置日志输出到控制台和文件
def setup_logging():
    """设置日志系统，同时输出到控制台和文件。"""
    logger = logging.getLogger(__name__)
    logger.setLevel(logging.INFO)
    
    # 清除已有的处理器
    logger.handlers.clear()
    
    # 创建格式化器
    formatter = logging.Formatter('%(asctime)s - %(levelname)s - %(message)s')
    
    # 控制台处理器
    console_handler = logging.StreamHandler()
    console_handler.setLevel(logging.INFO)
    console_handler.setFormatter(formatter)
    logger.addHandler(console_handler)
    
    # 文件处理器
    file_handler = logging.FileHandler('add_toc.log', encoding='utf-8')
    file_handler.setLevel(logging.DEBUG)
    file_handler.setFormatter(formatter)
    logger.addHandler(file_handler)
    
    return logger

logger = setup_logging()

class TocExtractor:
    """从 ditamap 文件中提取 API 的 toc 信息并添加到 name_groups.json。"""
    
    def __init__(self):
        # ditamap 文件列表，按优先级排序
        self.ditamap_files = [
            '../../dita/RTC-NG/RTC_NG_API_CPP.ditamap',
            '../../dita/RTC-NG/RTC_NG_API_Android.ditamap',
            '../../dita/RTC-NG/RTC_NG_API_iOS.ditamap',
            '../../dita/RTC-NG/RTC_NG_API_macOS.ditamap',
            '../../dita/RTC-NG/RTC_NG_API_Flutter.ditamap',
            '../../dita/RTC-NG/RTC_NG_API_RN.ditamap',
            '../../dita/RTC-NG/RTC_NG_API_Unity.ditamap',
            '../../dita/RTC-NG/RTC_NG_API_Electron.ditamap'
        ]
        
        # 缓存每个 ditamap 文件中的 key -> toc 映射
        self.toc_cache = {}
    
    def load_existing_json(self, file_path: str) -> Dict:
        """
        加载现有的 name_groups.json 文件。
        
        Args:
            file_path: JSON 文件路径
            
        Returns:
            包含 JSON 数据的字典
        """
        try:
            with open(file_path, 'r', encoding='utf-8') as f:
                data = json.load(f)
            logger.info(f"成功加载 JSON 文件，包含 {len(data.get('api', {}))} 个 API 条目")
            return data
        except Exception as e:
            logger.error(f"加载 JSON 文件 {file_path} 时出错: {e}")
            return {}
    
    def extract_toc_from_href(self, href: str) -> Optional[str]:
        """
        从 href 中提取 toc 名称。
        
        Args:
            href: href 属性值，如 "API/toc_initialize.dita"
            
        Returns:
            toc 名称（不含扩展名），如 "toc_initialize"
        """
        if not href or not href.startswith('API/toc_'):
            return None
        
        # 提取文件名并去除扩展名
        filename = os.path.basename(href)
        toc_name = os.path.splitext(filename)[0]
        return toc_name
    
    def find_toc_for_keyref(self, element: ET.Element, keyref: str, current_toc_stack: List[str]) -> Optional[str]:
        """
        递归查找指定 keyref 对应的 toc。
        
        Args:
            element: 当前 XML 元素
            keyref: 要查找的 keyref 值
            current_toc_stack: 当前的 toc 栈（用于处理嵌套）
            
        Returns:
            找到的 toc 名称，如果没找到则返回 None
        """
        # 检查当前元素是否是 topicref
        if element.tag.endswith('topicref'):
            href = element.get('href')
            current_keyref = element.get('keyref')
            
            # 如果当前元素有 toc href，将其加入栈
            toc_name = self.extract_toc_from_href(href) if href else None
            if toc_name:
                current_toc_stack = current_toc_stack + [toc_name]
            
            # 如果找到匹配的 keyref
            if current_keyref == keyref:
                # 返回最内层的 toc（栈顶）
                if current_toc_stack:
                    return current_toc_stack[-1]
                else:
                    logger.warning(f"找到 keyref={keyref}，但没有对应的 toc")
                    return None
        
        # 递归处理子元素
        for child in element:
            result = self.find_toc_for_keyref(child, keyref, current_toc_stack)
            if result:
                return result
        
        return None
    
    def parse_ditamap_file(self, file_path: str) -> Dict[str, str]:
        """
        解析单个 ditamap 文件，提取所有 key -> toc 的映射。
        
        Args:
            file_path: ditamap 文件路径
            
        Returns:
            key -> toc 的映射字典
        """
        if not os.path.exists(file_path):
            logger.warning(f"ditamap 文件不存在: {file_path}")
            return {}
        
        try:
            tree = ET.parse(file_path)
            root = tree.getroot()
            
            key_toc_mapping = {}
            
            # 遍历所有元素，查找带有 keyref 的 topicref
            def traverse_and_extract(element: ET.Element, toc_stack: List[str]):
                """遍历元素树并提取 key-toc 映射。"""
                if element.tag.endswith('topicref'):
                    href = element.get('href')
                    keyref = element.get('keyref')
                    
                    # 如果是 toc 节点，加入栈
                    toc_name = self.extract_toc_from_href(href) if href else None
                    new_toc_stack = toc_stack + [toc_name] if toc_name else toc_stack
                    
                    # 如果有 keyref，记录映射
                    if keyref and new_toc_stack:
                        # 使用最内层的 toc
                        key_toc_mapping[keyref] = new_toc_stack[-1]
                        logger.debug(f"找到映射: {keyref} -> {new_toc_stack[-1]}")
                    
                    # 递归处理子元素
                    for child in element:
                        traverse_and_extract(child, new_toc_stack)
                else:
                    # 对于非 topicref 元素，继续遍历子元素
                    for child in element:
                        traverse_and_extract(child, toc_stack)
            
            traverse_and_extract(root, [])
            
            logger.info(f"从 {os.path.basename(file_path)} 中提取了 {len(key_toc_mapping)} 个 key-toc 映射")
            return key_toc_mapping
            
        except Exception as e:
            logger.error(f"解析 ditamap 文件 {file_path} 时出错: {e}")
            return {}
    
    def load_all_ditamap_files(self) -> None:
        """加载所有 ditamap 文件的 toc 映射。"""
        logger.info("开始加载所有 ditamap 文件...")
        
        for ditamap_file in self.ditamap_files:
            platform_name = os.path.basename(ditamap_file).replace('RTC_NG_API_', '').replace('.ditamap', '')
            logger.info(f"正在解析 {platform_name} 平台的 ditamap 文件...")
            
            key_toc_mapping = self.parse_ditamap_file(ditamap_file)
            self.toc_cache[platform_name] = key_toc_mapping
        
        total_mappings = sum(len(mapping) for mapping in self.toc_cache.values())
        logger.info(f"所有 ditamap 文件加载完成，共提取 {total_mappings} 个映射")
    
    def find_toc_for_key(self, key: str) -> Optional[str]:
        """
        在所有 ditamap 文件中查找指定 key 的 toc。
        
        Args:
            key: API 的 key
            
        Returns:
            找到的 toc 名称，如果没找到则返回 None
        """
        # 按优先级依次查找
        for platform_name, key_toc_mapping in self.toc_cache.items():
            if key in key_toc_mapping:
                toc = key_toc_mapping[key]
                logger.debug(f"在 {platform_name} 中找到 key={key} 的 toc: {toc}")
                return toc
        
        # 所有 ditamap 文件中都没找到
        logger.error(f"在所有 ditamap 文件中都未找到 key={key} 的 toc")
        return None
    
    def add_toc_to_apis(self, data: Dict) -> Dict:
        """
        为所有 API 条目添加 toc 字段。
        
        Args:
            data: 原始 JSON 数据
            
        Returns:
            添加了 toc 字段的 JSON 数据
        """
        if 'api' not in data:
            logger.warning("JSON 数据中没有 'api' 部分")
            return data
        
        updated_apis = {}
        total_apis = len(data['api'])
        processed_count = 0
        added_toc_count = 0
        not_found_count = 0
        
        logger.info(f"开始为 {total_apis} 个 API 添加 toc 字段...")
        
        for key, api_data in data['api'].items():
            processed_count += 1
            
            if processed_count % 100 == 0:
                logger.info(f"已处理 {processed_count}/{total_apis} 个 API")
            
            # 查找该 key 的 toc
            toc = self.find_toc_for_key(key)
            
            # 创建更新后的条目
            updated_entry = dict(api_data)
            if toc:
                updated_entry['toc'] = toc
                added_toc_count += 1
            else:
                not_found_count += 1
            
            updated_apis[key] = updated_entry
        
        # 更新数据
        data['api'] = updated_apis
        
        logger.info(f"处理完成: 成功添加 toc 的 API: {added_toc_count}/{total_apis}")
        logger.info(f"未找到 toc 的 API: {not_found_count}/{total_apis}")
        
        return data
    
    def save_updated_json(self, data: Dict, output_file: str) -> None:
        """
        保存更新后的 JSON 数据到文件，并对 params 数组进行自定义格式化。
        
        Args:
            data: 更新后的 JSON 数据
            output_file: 输出文件路径
        """
        try:
            # 首先使用默认格式保存
            with open(output_file, 'w', encoding='utf-8') as f:
                json.dump(data, f, indent=4, ensure_ascii=False)
            
            # 读取文件内容并重新格式化 params 数组为单行
            with open(output_file, 'r', encoding='utf-8') as f:
                content = f.read()
            
            # 使用正则表达式将 params 数组格式化为单行
            import re
            
            # 匹配跨多行的 params 对象值
            params_pattern = r'"([^"]+)": \[\s*\n(\s*"[^"]*",?\s*\n)*\s*\]'
            
            def format_params_array(match):
                # 提取匹配的文本
                matched_text = match.group(0)
                platform_name = match.group(1)
                
                # 使用正则表达式提取所有参数名
                param_names = re.findall(r'"([^"]*)"', matched_text)
                # 从参数名列表中移除平台名
                param_names = [name for name in param_names if name != platform_name]
                
                # 格式化为单行数组
                if param_names:
                    formatted_params = '["' + '", "'.join(param_names) + '"]'
                else:
                    formatted_params = '[]'
                
                return f'"{platform_name}": {formatted_params}'
            
            # 应用格式化
            content = re.sub(params_pattern, format_params_array, content)
            
            # 将格式化后的内容写回文件
            with open(output_file, 'w', encoding='utf-8') as f:
                f.write(content)
            
            logger.info(f"成功保存更新后的 JSON 到 {output_file}")
            
            # 打印统计信息
            api_count = len(data.get('api', {}))
            apis_with_toc = sum(
                1 for api_data in data.get('api', {}).values()
                if isinstance(api_data, dict) and 'toc' in api_data
            )
            
            logger.info(f"统计信息:")
            logger.info(f"  总 API 条目数: {api_count}")
            logger.info(f"  包含 toc 的 API: {apis_with_toc}")
            logger.info(f"  覆盖率: {apis_with_toc/api_count*100:.2f}%")
            
        except Exception as e:
            logger.error(f"保存 JSON 文件到 {output_file} 时出错: {e}")
    
    def run(self, input_file: str = "name_groups.json", output_file: str = "name_groups_with_toc.json") -> None:
        """
        运行完整的 toc 提取流程。
        
        Args:
            input_file: 输入 JSON 文件路径
            output_file: 输出 JSON 文件路径
        """
        logger.info("=" * 60)
        logger.info("开始 toc 提取流程...")
        logger.info("=" * 60)
        
        # 加载现有 JSON
        data = self.load_existing_json(input_file)
        if not data:
            logger.error("加载 JSON 数据失败")
            return
        
        # 加载所有 ditamap 文件
        self.load_all_ditamap_files()
        
        if not self.toc_cache:
            logger.error("没有加载到任何 ditamap 文件")
            return
        
        # 为 API 添加 toc 字段
        updated_data = self.add_toc_to_apis(data)
        
        # 保存更新后的 JSON
        self.save_updated_json(updated_data, output_file)
        
        logger.info("=" * 60)
        logger.info("toc 提取流程完成！")
        logger.info("=" * 60)


def main():
    """主函数。"""
    extractor = TocExtractor()
    extractor.run()


if __name__ == "__main__":
    main()
