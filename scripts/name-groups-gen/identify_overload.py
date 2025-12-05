#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Identify and mark overloaded APIs in name_groups.json.

This script scans the API section of name_groups.json and identifies overloaded
methods by detecting patterns like [1/2], [2/2], [1/3], etc. in the keyword values.
When such patterns are found, it adds "isOverload": true to the API entry.

Pattern examples:
  - "SetClientRole [1/2]"
  - "setClientRole [2/2]"
  - "joinChannel [1/3]"
  - "joinChannel [2/3]"
  - "joinChannel [3/3]"
"""

import json
import re
import logging
from typing import Dict, Set
import sys

# Configure logging
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')
logger = logging.getLogger(__name__)


class OverloadIdentifier:
    """Identify and mark overloaded APIs based on keyword patterns."""
    
    def __init__(self):
        # Pattern to match overload indicators like [1/2], [2/3], etc.
        # Matches: [digit/digit] where digits can be 1-9
        self.overload_pattern = re.compile(r'\[\d+/\d+\]')
    
    def load_json(self, file_path: str) -> Dict:
        """
        Load the name_groups.json file.
        
        Args:
            file_path: Path to the JSON file
            
        Returns:
            Dictionary containing the JSON data
        """
        try:
            with open(file_path, 'r', encoding='utf-8') as f:
                data = json.load(f)
            logger.info(f"已加载 JSON 文件: {file_path}")
            logger.info(f"API 条目总数: {len(data.get('api', {}))}")
            return data
        except FileNotFoundError:
            logger.error(f"文件不存在: {file_path}")
            sys.exit(1)
        except json.JSONDecodeError as e:
            logger.error(f"JSON 格式错误: {e}")
            sys.exit(1)
        except Exception as e:
            logger.error(f"加载文件时出错: {e}")
            sys.exit(1)
    
    def is_overloaded_api(self, api_entry: Dict) -> bool:
        """
        Check if an API entry contains overload pattern in any of its keywords.
        
        Args:
            api_entry: Dictionary containing API platform mappings
            
        Returns:
            True if overload pattern is found, False otherwise
        """
        if not isinstance(api_entry, dict):
            return False
        
        # Check all values in the API entry
        for key, value in api_entry.items():
            # Skip special keys
            if key in ['isOverload', 'params', 'toc', 'parent_class']:
                continue
            
            # Check if value is a string and contains the overload pattern
            if isinstance(value, str) and self.overload_pattern.search(value):
                return True
        
        return False
    
    def identify_overloaded_apis(self, data: Dict) -> Dict[str, Dict]:
        """
        Identify all overloaded APIs in the data.
        
        Args:
            data: The complete JSON data
            
        Returns:
            Dictionary mapping API keys to their data (only overloaded APIs)
        """
        if 'api' not in data:
            logger.warning("JSON 数据中没有 'api' 部分")
            return {}
        
        overloaded_apis = {}
        
        for api_key, api_entry in data['api'].items():
            if self.is_overloaded_api(api_entry):
                overloaded_apis[api_key] = api_entry
        
        return overloaded_apis
    
    def mark_overloaded_apis(self, data: Dict) -> tuple[Dict, int, int]:
        """
        Mark all overloaded APIs with "isOverload": true.
        
        Args:
            data: The complete JSON data
            
        Returns:
            Tuple of (updated data, count of newly marked APIs, count of already marked APIs)
        """
        if 'api' not in data:
            logger.warning("JSON 数据中没有 'api' 部分")
            return data, 0, 0
        
        newly_marked = 0
        already_marked = 0
        
        for api_key, api_entry in data['api'].items():
            if isinstance(api_entry, dict) and self.is_overloaded_api(api_entry):
                # Check if already marked
                if api_entry.get('isOverload') == True:
                    already_marked += 1
                    logger.debug(f"已标记的重载 API: {api_key}")
                else:
                    # Add isOverload flag
                    api_entry['isOverload'] = True
                    newly_marked += 1
                    logger.debug(f"新标记的重载 API: {api_key}")
        
        return data, newly_marked, already_marked
    
    def save_json(self, data: Dict, output_file: str) -> None:
        """
        Save the updated JSON data to a file.
        
        Args:
            data: The updated JSON data
            output_file: Output file path
        """
        try:
            with open(output_file, 'w', encoding='utf-8') as f:
                json.dump(data, f, indent=4, ensure_ascii=False)
            logger.info(f"已保存更新后的 JSON 文件: {output_file}")
        except Exception as e:
            logger.error(f"保存文件时出错: {e}")
            sys.exit(1)
    
    def generate_report(self, overloaded_apis: Dict[str, Dict], output_file: str = None) -> None:
        """
        Generate a report of identified overloaded APIs.
        
        Args:
            overloaded_apis: Dictionary of overloaded APIs
            output_file: Optional file path to save the report
        """
        report_lines = []
        report_lines.append("=" * 80)
        report_lines.append("重载 API 识别报告")
        report_lines.append("=" * 80)
        report_lines.append(f"\n识别到的重载 API 总数: {len(overloaded_apis)}\n")
        report_lines.append("=" * 80)
        report_lines.append("详细列表:")
        report_lines.append("=" * 80)
        
        for api_key, api_entry in sorted(overloaded_apis.items()):
            report_lines.append(f"\nAPI Key: {api_key}")
            
            # Find and display the overload patterns
            overload_values = []
            for key, value in api_entry.items():
                if key in ['isOverload', 'params', 'toc', 'parent_class']:
                    continue
                if isinstance(value, str) and self.overload_pattern.search(value):
                    overload_values.append(f"  {key}: {value}")
            
            for line in overload_values:
                report_lines.append(line)
        
        report_lines.append("\n" + "=" * 80)
        
        report_text = "\n".join(report_lines)
        
        # Print to console
        print(report_text)
        
        # Save to file if specified
        if output_file:
            try:
                with open(output_file, 'w', encoding='utf-8') as f:
                    f.write(report_text)
                logger.info(f"报告已保存到: {output_file}")
            except Exception as e:
                logger.error(f"保存报告时出错: {e}")
    
    def run(self, input_file: str = "name_groups.json", 
            output_file: str = "name_groups_marked.json",
            report_file: str = None,
            dry_run: bool = False) -> None:
        """
        Run the complete overload identification and marking process.
        
        Args:
            input_file: Input JSON file path
            output_file: Output JSON file path
            report_file: Optional report file path
            dry_run: If True, only identify and report without saving changes
        """
        logger.info("=" * 80)
        logger.info("开始识别重载 API...")
        logger.info("=" * 80)
        
        # Load JSON
        data = self.load_json(input_file)
        
        # Identify overloaded APIs
        logger.info("\n正在扫描重载 API...")
        overloaded_apis = self.identify_overloaded_apis(data)
        
        logger.info(f"识别到 {len(overloaded_apis)} 个重载 API")
        
        if dry_run:
            logger.info("\n[预览模式] 不会保存更改")
            self.generate_report(overloaded_apis, report_file)
            return
        
        # Mark overloaded APIs
        logger.info("\n正在标记重载 API...")
        updated_data, newly_marked, already_marked = self.mark_overloaded_apis(data)
        
        logger.info(f"新标记的 API: {newly_marked}")
        logger.info(f"已标记的 API: {already_marked}")
        logger.info(f"重载 API 总数: {newly_marked + already_marked}")
        
        # Save updated JSON
        self.save_json(updated_data, output_file)
        
        # Generate report
        if report_file or len(overloaded_apis) > 0:
            logger.info("\n生成报告...")
            self.generate_report(overloaded_apis, report_file)
        
        logger.info("\n" + "=" * 80)
        logger.info("处理完成!")
        logger.info("=" * 80)
        
        # Print summary
        print(f"\n📊 处理摘要:")
        print(f"  输入文件: {input_file}")
        print(f"  输出文件: {output_file}")
        print(f"  新标记的重载 API: {newly_marked}")
        print(f"  已标记的重载 API: {already_marked}")
        print(f"  重载 API 总数: {newly_marked + already_marked}")
        if report_file:
            print(f"  报告文件: {report_file}")


def main():
    """Main function."""
    import argparse
    
    parser = argparse.ArgumentParser(
        description='识别并标记 name_groups.json 中的重载 API',
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
示例:
  # 识别并标记重载 API（原地修改）
  python identify_overload.py
  
  # 指定输入和输出文件
  python identify_overload.py -i name_groups.json -o name_groups_marked.json
  
  # 预览模式（不保存更改，只生成报告）
  python identify_overload.py --dry-run
  
  # 生成详细报告
  python identify_overload.py -r overload_report.txt
  
  # 预览并生成报告
  python identify_overload.py --dry-run -r overload_report.txt

识别规则:
  检测 API 的任意平台关键字中是否包含 [数字/数字] 模式
  例如: [1/2], [2/2], [1/3], [2/3], [3/3] 等
  
  示例:
    "SetClientRole [1/2]"  -> 重载 API
    "setClientRole [2/2]"  -> 重载 API
    "joinChannel [1/3]"    -> 重载 API
        """
    )
    
    parser.add_argument(
        '-i', '--input',
        dest='input_file',
        default='name_groups.json',
        help='输入 JSON 文件路径 (默认: name_groups.json)'
    )
    
    parser.add_argument(
        '-o', '--output',
        dest='output_file',
        default='name_groups.json',
        help='输出 JSON 文件路径 (默认: name_groups.json，原地修改)'
    )
    
    parser.add_argument(
        '-r', '--report',
        dest='report_file',
        help='生成报告文件路径 (可选)'
    )
    
    parser.add_argument(
        '--dry-run',
        action='store_true',
        help='预览模式：只识别和报告，不保存更改'
    )
    
    args = parser.parse_args()
    
    identifier = OverloadIdentifier()
    identifier.run(
        input_file=args.input_file,
        output_file=args.output_file,
        report_file=args.report_file,
        dry_run=args.dry_run
    )


if __name__ == "__main__":
    main()

