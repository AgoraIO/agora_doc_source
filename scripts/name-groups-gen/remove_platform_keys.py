#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Remove platform-specific keywords and params from name_groups.json.

This script removes all keywords and params entries for specified platforms.
If a key only contains keywords for the specified platforms (and no other platforms),
the entire key will be removed.

Usage:
    python remove_platform_keys.py -p electron
    python remove_platform_keys.py -p electron rn flutter
    python remove_platform_keys.py -p electron -i input.json -o output.json
"""

import json
import logging
import sys
from typing import Dict, List, Set

# Configure logging
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')
logger = logging.getLogger(__name__)


class PlatformKeyRemover:
    """Remove platform-specific keywords and params from name_groups.json."""
    
    # Special keys that should not be treated as platform keywords
    SPECIAL_KEYS = {'isOverload', 'params', 'toc', 'parent_class'}
    
    # All valid platform names
    VALID_PLATFORMS = {
        'windows', 'android', 'ios', 'macos',
        'electron', 'rn', 'unity', 'flutter',
        'csharp', 'unreal-cpp', 'unreal-blueprint'
    }
    
    def __init__(self, platforms_to_remove: List[str]):
        """
        Initialize the remover.
        
        Args:
            platforms_to_remove: List of platform names to remove
        """
        self.platforms_to_remove = set(platforms_to_remove)
        
        # Validate platform names
        invalid_platforms = self.platforms_to_remove - self.VALID_PLATFORMS
        if invalid_platforms:
            logger.warning(f"警告: 以下平台名称可能无效: {invalid_platforms}")
        
        logger.info(f"将要删除的平台: {', '.join(sorted(self.platforms_to_remove))}")
    
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
    
    def get_platform_keywords(self, entry: Dict) -> Set[str]:
        """
        Get all platform keywords from an entry.
        
        Args:
            entry: Dictionary containing platform mappings
            
        Returns:
            Set of platform names that have keywords
        """
        if not isinstance(entry, dict):
            return set()
        
        platforms = set()
        for key in entry.keys():
            if key not in self.SPECIAL_KEYS:
                platforms.add(key)
        
        return platforms
    
    def should_remove_entry(self, entry: Dict) -> bool:
        """
        Check if an entry should be completely removed.
        
        An entry should be removed if it only contains keywords for the
        platforms to be removed (and no other platforms).
        
        Args:
            entry: Dictionary containing platform mappings
            
        Returns:
            True if the entry should be removed, False otherwise
        """
        if not isinstance(entry, dict):
            return False
        
        # Get all platform keywords
        platform_keywords = self.get_platform_keywords(entry)
        
        # If no platform keywords, don't remove
        if not platform_keywords:
            return False
        
        # Check if all platform keywords are in the removal list
        remaining_platforms = platform_keywords - self.platforms_to_remove
        
        # If no remaining platforms, remove the entire entry
        return len(remaining_platforms) == 0
    
    def remove_platform_data(self, entry: Dict) -> Dict:
        """
        Remove platform-specific keywords and params from an entry.
        
        Args:
            entry: Dictionary containing platform mappings
            
        Returns:
            Updated entry with platform data removed
        """
        if not isinstance(entry, dict):
            return entry
        
        updated_entry = {}
        
        for key, value in entry.items():
            # Skip platform keywords to be removed
            if key in self.platforms_to_remove:
                continue
            
            # Handle params specially
            if key == 'params' and isinstance(value, dict):
                # Remove platform-specific params
                updated_params = {
                    platform: params
                    for platform, params in value.items()
                    if platform not in self.platforms_to_remove
                }
                # Only add params if there are remaining platforms
                if updated_params:
                    updated_entry[key] = updated_params
            else:
                # Keep other keys
                updated_entry[key] = value
        
        return updated_entry
    
    def process_category(self, category_data: Dict, category_name: str) -> tuple[Dict, int, int]:
        """
        Process a category (api, class, callback, enum, struct).
        
        Args:
            category_data: Dictionary containing category entries
            category_name: Name of the category
            
        Returns:
            Tuple of (updated category data, removed entries count, modified entries count)
        """
        if not isinstance(category_data, dict):
            return category_data, 0, 0
        
        updated_category = {}
        removed_count = 0
        modified_count = 0
        
        for key, entry in category_data.items():
            # Check if the entire entry should be removed
            if self.should_remove_entry(entry):
                removed_count += 1
                logger.debug(f"删除 {category_name} 条目: {key} (仅包含待删除平台)")
                continue
            
            # Remove platform-specific data
            updated_entry = self.remove_platform_data(entry)
            
            # Check if anything was modified
            if updated_entry != entry:
                modified_count += 1
                logger.debug(f"修改 {category_name} 条目: {key}")
            
            updated_category[key] = updated_entry
        
        return updated_category, removed_count, modified_count
    
    def process_json(self, data: Dict) -> tuple[Dict, Dict]:
        """
        Process the entire JSON data.
        
        Args:
            data: The complete JSON data
            
        Returns:
            Tuple of (updated data, statistics dictionary)
        """
        updated_data = {}
        stats = {
            'api': {'removed': 0, 'modified': 0, 'total': 0},
            'class': {'removed': 0, 'modified': 0, 'total': 0},
            'callback': {'removed': 0, 'modified': 0, 'total': 0},
            'enum': {'removed': 0, 'modified': 0, 'total': 0},
            'struct': {'removed': 0, 'modified': 0, 'total': 0}
        }
        
        # Process each category
        for category in ['api', 'class', 'callback', 'enum', 'struct']:
            if category in data:
                stats[category]['total'] = len(data[category])
                
                updated_category, removed, modified = self.process_category(
                    data[category], category
                )
                
                updated_data[category] = updated_category
                stats[category]['removed'] = removed
                stats[category]['modified'] = modified
        
        # Copy other top-level keys
        for key, value in data.items():
            if key not in ['api', 'class', 'callback', 'enum', 'struct']:
                updated_data[key] = value
        
        return updated_data, stats
    
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
    
    def print_statistics(self, stats: Dict) -> None:
        """
        Print processing statistics.
        
        Args:
            stats: Statistics dictionary
        """
        print("\n" + "=" * 80)
        print("处理统计")
        print("=" * 80)
        
        total_removed = 0
        total_modified = 0
        total_remaining = 0
        
        for category in ['api', 'class', 'callback', 'enum', 'struct']:
            if category in stats:
                cat_stats = stats[category]
                removed = cat_stats['removed']
                modified = cat_stats['modified']
                total = cat_stats['total']
                remaining = total - removed
                
                total_removed += removed
                total_modified += modified
                total_remaining += remaining
                
                print(f"\n{category.upper()}:")
                print(f"  原始条目数: {total}")
                print(f"  删除的条目: {removed}")
                print(f"  修改的条目: {modified}")
                print(f"  保留的条目: {remaining}")
        
        print("\n" + "=" * 80)
        print("总计:")
        print(f"  删除的条目总数: {total_removed}")
        print(f"  修改的条目总数: {total_modified}")
        print(f"  保留的条目总数: {total_remaining}")
        print("=" * 80)
    
    def run(self, input_file: str = "name_groups.json",
            output_file: str = "name_groups.json",
            dry_run: bool = False) -> None:
        """
        Run the complete platform removal process.
        
        Args:
            input_file: Input JSON file path
            output_file: Output JSON file path
            dry_run: If True, only show what would be done without saving
        """
        logger.info("=" * 80)
        logger.info("开始删除平台相关数据...")
        logger.info("=" * 80)
        
        # Load JSON
        data = self.load_json(input_file)
        
        # Process JSON
        logger.info("\n正在处理 JSON 数据...")
        updated_data, stats = self.process_json(data)
        
        # Print statistics
        self.print_statistics(stats)
        
        if dry_run:
            logger.info("\n[预览模式] 不会保存更改")
            return
        
        # Save updated JSON
        self.save_json(updated_data, output_file)
        
        logger.info("\n" + "=" * 80)
        logger.info("处理完成!")
        logger.info("=" * 80)
        
        # Print summary
        print(f"\n📊 处理摘要:")
        print(f"  输入文件: {input_file}")
        print(f"  输出文件: {output_file}")
        print(f"  删除的平台: {', '.join(sorted(self.platforms_to_remove))}")


def main():
    """Main function."""
    import argparse
    
    parser = argparse.ArgumentParser(
        description='从 name_groups.json 中删除指定平台的所有相关数据',
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
示例:
  # 删除 electron 平台
  python remove_platform_keys.py -p electron
  
  # 删除多个平台
  python remove_platform_keys.py -p electron rn flutter
  
  # 指定输入输出文件
  python remove_platform_keys.py -p electron -i input.json -o output.json
  
  # 预览模式（不保存更改）
  python remove_platform_keys.py -p electron --dry-run

支持的平台:
  windows, android, ios, macos,
  electron, rn, unity, flutter,
  csharp, unreal-cpp, unreal-blueprint

删除规则:
  1. 删除指定平台的 keyword
  2. 删除指定平台的 params 项
  3. 如果某个 key 只有指定平台的 keyword，则删除整个 key
  4. 保留其他平台的数据和特殊字段（isOverload, toc, parent_class）
        """
    )
    
    parser.add_argument(
        '-p', '--platforms',
        nargs='+',
        required=True,
        help='要删除的平台名称（可指定多个）'
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
        '--dry-run',
        action='store_true',
        help='预览模式：只显示将要做的更改，不保存文件'
    )
    
    args = parser.parse_args()
    
    # Create remover instance
    remover = PlatformKeyRemover(args.platforms)
    
    # Run the process
    remover.run(
        input_file=args.input_file,
        output_file=args.output_file,
        dry_run=args.dry_run
    )


if __name__ == "__main__":
    main()

