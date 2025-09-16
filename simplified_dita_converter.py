#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
简化版 DITA XML 到 JSON/YAML 转换工具

专门为你的项目优化，提供：
- 更简洁的输出格式
- 更好的性能
- 可选的结构简化
- 与现有工具的兼容性

使用示例:
    python simplified_dita_converter.py input.dita output.json
    python simplified_dita_converter.py input.json output.dita --simple
"""

import xml.etree.ElementTree as ET
import json
import yaml
import argparse
import os
from typing import Dict, Any, List, Union


class SimplifiedDITAConverter:
    """简化版 DITA 转换器"""
    
    def __init__(self, simple_mode: bool = False):
        """
        初始化转换器
        
        Args:
            simple_mode: 简化模式，输出更简洁的结构
        """
        self.simple_mode = simple_mode
    
    def xml_to_dict(self, element: ET.Element) -> Dict[str, Any]:
        """
        将XML元素转换为字典
        
        Args:
            element: XML元素
            
        Returns:
            字典表示
        """
        result = {}
        
        # 标签名
        result['_tag'] = element.tag
        
        # 属性
        if element.attrib:
            if self.simple_mode:
                result.update(element.attrib)  # 直接合并属性
            else:
                result['_attributes'] = element.attrib
        
        # 文本内容
        text = element.text.strip() if element.text else ''
        tail = element.tail.strip() if element.tail else ''
        
        if text:
            result['_text'] = text
        if tail and not self.simple_mode:
            result['_tail'] = tail
        
        # 子元素
        if len(element) > 0:
            children = []
            children_dict = {}
            
            for child in element:
                child_data = self.xml_to_dict(child)
                
                if self.simple_mode:
                    # 简化模式：相同标签的元素组成数组
                    tag_name = child.tag
                    if tag_name in children_dict:
                        if not isinstance(children_dict[tag_name], list):
                            children_dict[tag_name] = [children_dict[tag_name]]
                        children_dict[tag_name].append(child_data)
                    else:
                        children_dict[tag_name] = child_data
                else:
                    # 完整模式：保持顺序
                    children.append(child_data)
            
            if self.simple_mode and children_dict:
                result.update(children_dict)
            elif children:
                result['_children'] = children
        
        return result
    
    def dict_to_xml(self, data: Dict[str, Any], tag_name: str = None) -> ET.Element:
        """
        将字典转换为XML元素
        
        Args:
            data: 字典数据
            tag_name: 强制指定的标签名
            
        Returns:
            XML元素
        """
        # 获取标签名
        if tag_name:
            element_tag = tag_name
        else:
            element_tag = data.get('_tag', 'element')
        
        # 创建元素
        element = ET.Element(element_tag)
        
        # 处理数据
        for key, value in data.items():
            if key == '_tag':
                continue
            elif key == '_attributes':
                # 设置属性
                for attr_key, attr_value in value.items():
                    element.set(attr_key, str(attr_value))
            elif key == '_text':
                # 设置文本
                element.text = str(value)
            elif key == '_tail':
                # 设置尾部文本
                element.tail = str(value)
            elif key == '_children':
                # 处理子元素
                for child_data in value:
                    child_element = self.dict_to_xml(child_data)
                    element.append(child_element)
            elif self.simple_mode and not key.startswith('_'):
                # 简化模式：处理子元素
                if isinstance(value, list):
                    # 数组形式的子元素
                    for item in value:
                        if isinstance(item, dict):
                            child_element = self.dict_to_xml(item, key)
                            element.append(child_element)
                        else:
                            # 简单值
                            child = ET.SubElement(element, key)
                            child.text = str(item)
                elif isinstance(value, dict):
                    # 单个子元素
                    child_element = self.dict_to_xml(value, key)
                    element.append(child_element)
                elif not self.simple_mode:
                    # 作为属性处理
                    element.set(key, str(value))
        
        return element
    
    def xml_to_json(self, xml_file: str, output_file: str = None, 
                    indent: int = 2) -> str:
        """XML转JSON"""
        # 解析XML
        tree = ET.parse(xml_file)
        root = tree.getroot()
        
        # 转换为字典
        if self.simple_mode:
            result = self.xml_to_dict(root)
        else:
            result = {
                'xml_info': {
                    'version': '1.0',
                    'encoding': 'UTF-8',
                    'doctype': self._extract_doctype(xml_file)
                },
                'content': self.xml_to_dict(root)
            }
        
        # 转换为JSON
        json_str = json.dumps(result, ensure_ascii=False, indent=indent)
        
        # 保存文件
        if output_file:
            with open(output_file, 'w', encoding='utf-8') as f:
                f.write(json_str)
        
        return json_str
    
    def json_to_xml(self, json_file: str, output_file: str = None) -> str:
        """JSON转XML"""
        # 读取JSON
        with open(json_file, 'r', encoding='utf-8') as f:
            data = json.load(f)
        
        # 转换为XML
        if self.simple_mode or 'content' not in data:
            root_element = self.dict_to_xml(data)
        else:
            root_element = self.dict_to_xml(data['content'])
        
        # 格式化XML
        self._indent(root_element)
        
        # 生成XML字符串
        xml_str = '<?xml version="1.0" encoding="UTF-8"?>\n'
        
        # 添加DOCTYPE（如果有）
        if not self.simple_mode and 'xml_info' in data:
            doctype = data['xml_info'].get('doctype', '')
            if doctype:
                xml_str += doctype + '\n'
        
        xml_str += ET.tostring(root_element, encoding='unicode', method='xml')
        
        # 保存文件
        if output_file:
            with open(output_file, 'w', encoding='utf-8') as f:
                f.write(xml_str)
        
        return xml_str
    
    def xml_to_yaml(self, xml_file: str, output_file: str = None) -> str:
        """XML转YAML"""
        # 解析XML
        tree = ET.parse(xml_file)
        root = tree.getroot()
        
        # 转换为字典
        if self.simple_mode:
            result = self.xml_to_dict(root)
        else:
            result = {
                'xml_info': {
                    'version': '1.0',
                    'encoding': 'UTF-8',
                    'doctype': self._extract_doctype(xml_file)
                },
                'content': self.xml_to_dict(root)
            }
        
        # 转换为YAML
        yaml_str = yaml.dump(result, allow_unicode=True, default_flow_style=False,
                           indent=2, sort_keys=False)
        
        # 保存文件
        if output_file:
            with open(output_file, 'w', encoding='utf-8') as f:
                f.write(yaml_str)
        
        return yaml_str
    
    def yaml_to_xml(self, yaml_file: str, output_file: str = None) -> str:
        """YAML转XML"""
        # 读取YAML
        with open(yaml_file, 'r', encoding='utf-8') as f:
            data = yaml.safe_load(f)
        
        # 转换为XML
        if self.simple_mode or 'content' not in data:
            root_element = self.dict_to_xml(data)
        else:
            root_element = self.dict_to_xml(data['content'])
        
        # 格式化XML
        self._indent(root_element)
        
        # 生成XML字符串
        xml_str = '<?xml version="1.0" encoding="UTF-8"?>\n'
        
        # 添加DOCTYPE（如果有）
        if not self.simple_mode and 'xml_info' in data:
            doctype = data['xml_info'].get('doctype', '')
            if doctype:
                xml_str += doctype + '\n'
        
        xml_str += ET.tostring(root_element, encoding='unicode', method='xml')
        
        # 保存文件
        if output_file:
            with open(output_file, 'w', encoding='utf-8') as f:
                f.write(xml_str)
        
        return xml_str
    
    def _extract_doctype(self, xml_file: str) -> str:
        """提取DOCTYPE声明"""
        try:
            with open(xml_file, 'r', encoding='utf-8') as f:
                content = f.read()
                if '<!DOCTYPE' in content:
                    start = content.find('<!DOCTYPE')
                    end = content.find('>', start) + 1
                    return content[start:end]
        except:
            pass
        return ''
    
    def _indent(self, elem: ET.Element, level: int = 0):
        """为XML添加缩进"""
        indent_str = "\n" + "    " * level
        if len(elem):
            if not elem.text or not elem.text.strip():
                elem.text = indent_str + "    "
            if not elem.tail or not elem.tail.strip():
                elem.tail = indent_str
            for child in elem:
                self._indent(child, level + 1)
            if not child.tail or not child.tail.strip():
                child.tail = indent_str
        else:
            if level and (not elem.tail or not elem.tail.strip()):
                elem.tail = indent_str


def main():
    """命令行接口"""
    parser = argparse.ArgumentParser(description='简化版 DITA XML 转换工具')
    parser.add_argument('input_file', help='输入文件路径')
    parser.add_argument('output_file', help='输出文件路径')
    parser.add_argument('--simple', action='store_true', 
                       help='启用简化模式（更简洁的输出）')
    parser.add_argument('--indent', type=int, default=2, 
                       help='JSON缩进空格数 (默认: 2)')
    
    args = parser.parse_args()
    
    # 创建转换器
    converter = SimplifiedDITAConverter(simple_mode=args.simple)
    
    # 检测文件类型
    input_ext = os.path.splitext(args.input_file)[1].lower()
    output_ext = os.path.splitext(args.output_file)[1].lower()
    
    try:
        if input_ext in ['.xml', '.dita']:
            if output_ext == '.json':
                converter.xml_to_json(args.input_file, args.output_file, args.indent)
                print(f"✅ 成功转换: {args.input_file} → {args.output_file}")
            elif output_ext in ['.yaml', '.yml']:
                converter.xml_to_yaml(args.input_file, args.output_file)
                print(f"✅ 成功转换: {args.input_file} → {args.output_file}")
            else:
                print(f"❌ 不支持的输出格式: {output_ext}")
        
        elif input_ext == '.json':
            if output_ext in ['.xml', '.dita']:
                converter.json_to_xml(args.input_file, args.output_file)
                print(f"✅ 成功转换: {args.input_file} → {args.output_file}")
            else:
                print(f"❌ 不支持的输出格式: {output_ext}")
        
        elif input_ext in ['.yaml', '.yml']:
            if output_ext in ['.xml', '.dita']:
                converter.yaml_to_xml(args.input_file, args.output_file)
                print(f"✅ 成功转换: {args.input_file} → {args.output_file}")
            else:
                print(f"❌ 不支持的输出格式: {output_ext}")
        
        else:
            print(f"❌ 不支持的输入格式: {input_ext}")
    
    except Exception as e:
        print(f"❌ 转换失败: {str(e)}")
        import traceback
        traceback.print_exc()


if __name__ == '__main__':
    main()
