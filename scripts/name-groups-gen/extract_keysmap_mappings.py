#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Extract API/struct/enum mappings from keysmap files.

This script extracts all keydef mappings from keysmap files, excluding those with props="hide".
It includes mappings with props="cn" and other props attributes.
"""

import os
import json
import xml.etree.ElementTree as ET
from typing import Dict, List, Set
import logging
import re

# Configure logging
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')
logger = logging.getLogger(__name__)


class KeysmapExtractor:
    """Extract mappings from keysmap files."""
    
    def __init__(self):
        # Platform mapping: platform name -> keysmap file suffix
        self.platform_mapping = {
            'electron': 'electron',
            'rn': 'rn',
            'unity': 'unity',
            'flutter': 'flutter',
            'csharp': 'unity',
            'unreal-cpp': 'unreal',
            'unreal-blueprint': 'blueprint',
            # 'windows': 'cpp',
            # 'android': 'java',
            # 'ios': 'ios',
            # 'macos': 'macos'
        }
        
        # Keysmap files directory
        self.config_dir = "../../dita/RTC-NG/config"
        
        # Store all extracted mappings
        self.api_mappings = {}
        self.struct_mappings = {}
        self.enum_mappings = {}
        
        # Track which keys have been seen
        self.all_keys = set()
    
    def extract_name_from_href(self, href: str) -> tuple:
        """
        Extract the name and type from href.
        
        Args:
            href: The href attribute value (e.g., "../API/api_irtcengine_initialize.dita")
            
        Returns:
            Tuple of (name, type) where type is 'api', 'struct', 'enum', or None
        """
        if not href or not href.startswith('../API/'):
            return None, None
        
        # Extract filename from href
        filename = href.split('/')[-1].replace('.dita', '')
        
        # Determine type based on filename prefix
        if filename.startswith('api_'):
            return filename.replace('api_', ''), 'api'
        elif filename.startswith('class_'):
            return filename.replace('class_', ''), 'struct'
        elif filename.startswith('enum_'):
            return filename.replace('enum_', ''), 'enum'
        elif filename.startswith('callback_'):
            return filename.replace('callback_', ''), 'api'
        
        return None, None
    
    def should_skip_keydef(self, keydef: ET.Element) -> bool:
        """
        Check if a keydef should be skipped.
        
        Args:
            keydef: The keydef XML element
            
        Returns:
            True if should skip, False otherwise
        """
        props = keydef.get('props', '')
        
        # Skip if props contains "hide"
        if 'hide' in props.split():
            return True
        
        return False
    
    def extract_keyword_from_keydef(self, keydef: ET.Element) -> str:
        """
        Extract the keyword (display name) from keydef.
        
        Args:
            keydef: The keydef XML element
            
        Returns:
            The keyword string or empty string if not found
        """
        # Try to find keyword in topicmeta
        for topicmeta in keydef.iter():
            if topicmeta.tag.endswith('topicmeta'):
                for keywords in topicmeta.iter():
                    if keywords.tag.endswith('keywords'):
                        for keyword in keywords.iter():
                            if keyword.tag.endswith('keyword') and keyword.text:
                                return keyword.text.strip()
        
        return ''
    
    def parse_keysmap_file(self, platform: str, file_suffix: str) -> None:
        """
        Parse a keysmap file and extract mappings.
        
        Args:
            platform: Platform name (e.g., 'windows', 'android')
            file_suffix: Keysmap file suffix (e.g., 'cpp', 'java')
        """
        file_path = os.path.join(self.config_dir, f"keys-rtc-ng-api-{file_suffix}.ditamap")
        
        if not os.path.exists(file_path):
            logger.warning(f"Keysmap file not found: {file_path}")
            return
        
        try:
            tree = ET.parse(file_path)
            root = tree.getroot()
            
            api_count = 0
            struct_count = 0
            enum_count = 0
            skipped_count = 0
            
            for keydef in root.iter():
                if keydef.tag.endswith('keydef'):
                    # Check if should skip
                    if self.should_skip_keydef(keydef):
                        skipped_count += 1
                        continue
                    
                    keys = keydef.get('keys')
                    href = keydef.get('href')
                    
                    if not keys or not href:
                        continue
                    
                    # Track all keys
                    self.all_keys.add(keys)
                    
                    # Extract name and type from href
                    name, mapping_type = self.extract_name_from_href(href)
                    
                    if not name or not mapping_type:
                        continue
                    
                    # Extract keyword (display name)
                    keyword = self.extract_keyword_from_keydef(keydef)
                    if not keyword:
                        keyword = keys  # Fallback to keys if no keyword found
                    
                    # Store mapping based on type
                    if mapping_type == 'api':
                        if keys not in self.api_mappings:
                            self.api_mappings[keys] = {}
                        self.api_mappings[keys][platform] = keyword
                        api_count += 1
                    elif mapping_type == 'struct':
                        if keys not in self.struct_mappings:
                            self.struct_mappings[keys] = {}
                        self.struct_mappings[keys][platform] = keyword
                        struct_count += 1
                    elif mapping_type == 'enum':
                        if keys not in self.enum_mappings:
                            self.enum_mappings[keys] = {}
                        self.enum_mappings[keys][platform] = keyword
                        enum_count += 1
            
            logger.info(f"Parsed {file_path}:")
            logger.info(f"  APIs: {api_count}, Structs: {struct_count}, Enums: {enum_count}, Skipped: {skipped_count}")
            
        except Exception as e:
            logger.error(f"Error parsing keysmap file {file_path}: {e}")
    
    def extract_all_mappings(self) -> None:
        """Extract mappings from all keysmap files."""
        logger.info("Extracting mappings from all keysmap files...")
        
        for platform, file_suffix in self.platform_mapping.items():
            logger.info(f"\nProcessing {platform} platform...")
            self.parse_keysmap_file(platform, file_suffix)
    
    def compare_with_existing(self, existing_file: str = "name_groups.json") -> Dict:
        """
        Compare extracted mappings with existing name_groups.json.
        
        Args:
            existing_file: Path to existing name_groups.json
            
        Returns:
            Dictionary containing comparison results
        """
        try:
            with open(existing_file, 'r', encoding='utf-8') as f:
                existing_data = json.load(f)
        except Exception as e:
            logger.error(f"Error loading existing file {existing_file}: {e}")
            return {}
        
        existing_apis = set(existing_data.get('api', {}).keys())
        existing_structs = set(existing_data.get('struct', {}).keys())
        existing_enums = set(existing_data.get('enum', {}).keys())
        
        extracted_apis = set(self.api_mappings.keys())
        extracted_structs = set(self.struct_mappings.keys())
        extracted_enums = set(self.enum_mappings.keys())
        
        # Find missing entries
        missing_apis = extracted_apis - existing_apis
        missing_structs = extracted_structs - existing_structs
        missing_enums = extracted_enums - existing_enums
        
        # Find extra entries (in existing but not in extracted)
        extra_apis = existing_apis - extracted_apis
        extra_structs = existing_structs - extracted_structs
        extra_enums = existing_enums - extracted_enums
        
        comparison = {
            'missing_apis': sorted(list(missing_apis)),
            'missing_structs': sorted(list(missing_structs)),
            'missing_enums': sorted(list(missing_enums)),
            'extra_apis': sorted(list(extra_apis)),
            'extra_structs': sorted(list(extra_structs)),
            'extra_enums': sorted(list(extra_enums)),
            'existing_api_count': len(existing_apis),
            'existing_struct_count': len(existing_structs),
            'existing_enum_count': len(existing_enums),
            'extracted_api_count': len(extracted_apis),
            'extracted_struct_count': len(extracted_structs),
            'extracted_enum_count': len(extracted_enums)
        }
        
        return comparison
    
    def save_extracted_mappings(self, output_file: str = "extracted_mappings.json") -> None:
        """
        Save extracted mappings to a JSON file.
        
        Args:
            output_file: Output file path
        """
        data = {
            'api': self.api_mappings,
            'struct': self.struct_mappings,
            'enum': self.enum_mappings
        }
        
        try:
            with open(output_file, 'w', encoding='utf-8') as f:
                json.dump(data, f, indent=4, ensure_ascii=False)
            logger.info(f"\nSaved extracted mappings to {output_file}")
        except Exception as e:
            logger.error(f"Error saving mappings to {output_file}: {e}")
    
    def print_comparison_report(self, comparison: Dict) -> None:
        """
        Print a comparison report.
        
        Args:
            comparison: Comparison results dictionary
        """
        print("\n" + "=" * 80)
        print("映射关系对比报告")
        print("=" * 80)
        
        print("\n统计信息:")
        print(f"  现有 APIs: {comparison['existing_api_count']}")
        print(f"  提取 APIs: {comparison['extracted_api_count']}")
        print(f"  现有 Structs: {comparison['existing_struct_count']}")
        print(f"  提取 Structs: {comparison['extracted_struct_count']}")
        print(f"  现有 Enums: {comparison['existing_enum_count']}")
        print(f"  提取 Enums: {comparison['extracted_enum_count']}")
        
        print("\n缺失的映射 (在 keysmap 中但不在 name_groups.json 中):")
        print("-" * 80)
        
        if comparison['missing_apis']:
            print(f"\n缺失的 APIs ({len(comparison['missing_apis'])} 个):")
            for i, key in enumerate(comparison['missing_apis'][:50], 1):  # Show first 50
                platforms = list(self.api_mappings[key].keys())
                print(f"  {i:3}. {key:50} (平台: {', '.join(platforms)})")
            if len(comparison['missing_apis']) > 50:
                print(f"  ... 还有 {len(comparison['missing_apis']) - 50} 个")
        else:
            print("\n✓ 没有缺失的 APIs")
        
        if comparison['missing_structs']:
            print(f"\n缺失的 Structs ({len(comparison['missing_structs'])} 个):")
            for i, key in enumerate(comparison['missing_structs'][:50], 1):
                platforms = list(self.struct_mappings[key].keys())
                print(f"  {i:3}. {key:50} (平台: {', '.join(platforms)})")
            if len(comparison['missing_structs']) > 50:
                print(f"  ... 还有 {len(comparison['missing_structs']) - 50} 个")
        else:
            print("\n✓ 没有缺失的 Structs")
        
        if comparison['missing_enums']:
            print(f"\n缺失的 Enums ({len(comparison['missing_enums'])} 个):")
            for i, key in enumerate(comparison['missing_enums'][:50], 1):
                platforms = list(self.enum_mappings[key].keys())
                print(f"  {i:3}. {key:50} (平台: {', '.join(platforms)})")
            if len(comparison['missing_enums']) > 50:
                print(f"  ... 还有 {len(comparison['missing_enums']) - 50} 个")
        else:
            print("\n✓ 没有缺失的 Enums")
        
        print("\n额外的映射 (在 name_groups.json 中但不在 keysmap 中):")
        print("-" * 80)
        
        if comparison['extra_apis']:
            print(f"\n额外的 APIs ({len(comparison['extra_apis'])} 个):")
            for i, key in enumerate(comparison['extra_apis'][:20], 1):
                print(f"  {i:3}. {key}")
            if len(comparison['extra_apis']) > 20:
                print(f"  ... 还有 {len(comparison['extra_apis']) - 20} 个")
        else:
            print("\n✓ 没有额外的 APIs")
        
        if comparison['extra_structs']:
            print(f"\n额外的 Structs ({len(comparison['extra_structs'])} 个):")
            for i, key in enumerate(comparison['extra_structs'][:20], 1):
                print(f"  {i:3}. {key}")
            if len(comparison['extra_structs']) > 20:
                print(f"  ... 还有 {len(comparison['extra_structs']) - 20} 个")
        else:
            print("\n✓ 没有额外的 Structs")
        
        if comparison['extra_enums']:
            print(f"\n额外的 Enums ({len(comparison['extra_enums'])} 个):")
            for i, key in enumerate(comparison['extra_enums'][:20], 1):
                print(f"  {i:3}. {key}")
            if len(comparison['extra_enums']) > 20:
                print(f"  ... 还有 {len(comparison['extra_enums']) - 20} 个")
        else:
            print("\n✓ 没有额外的 Enums")
        
        print("\n" + "=" * 80)
    
    def run(self) -> None:
        """Run the extraction and comparison process."""
        logger.info("Starting keysmap extraction process...")
        
        # Extract mappings from all keysmap files
        self.extract_all_mappings()
        
        # Save extracted mappings
        self.save_extracted_mappings()
        
        # Compare with existing name_groups.json
        logger.info("\nComparing with existing name_groups.json...")
        comparison = self.compare_with_existing()
        
        # Print comparison report
        self.print_comparison_report(comparison)
        
        logger.info("\nExtraction and comparison completed!")


def main():
    """Main function."""
    extractor = KeysmapExtractor()
    extractor.run()


if __name__ == "__main__":
    main()

