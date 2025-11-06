#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Add parent_class field to API entries in name_groups.json.

This script reads the name_groups.json file and adds a parent_class field to each API entry
by extracting the parent class information from the corresponding keysmap files.
"""

import os
import json
import xml.etree.ElementTree as ET
from typing import Dict, List, Optional, Set
import logging
import re

# Configure logging to both console and file
def setup_logging():
    """Setup logging to both console and file."""
    logger = logging.getLogger(__name__)
    logger.setLevel(logging.INFO)
    
    # Clear any existing handlers
    logger.handlers.clear()
    
    # Create formatter
    formatter = logging.Formatter('%(asctime)s - %(levelname)s - %(message)s')
    
    # Console handler
    console_handler = logging.StreamHandler()
    console_handler.setLevel(logging.INFO)
    console_handler.setFormatter(formatter)
    logger.addHandler(console_handler)
    
    # File handler
    file_handler = logging.FileHandler('add_parent_class.log', encoding='utf-8')
    file_handler.setLevel(logging.DEBUG)
    file_handler.setFormatter(formatter)
    logger.addHandler(file_handler)
    
    return logger

logger = setup_logging()

class ParentClassExtractor:
    """Extract parent class information from keysmap files and add to name_groups.json."""
    
    def __init__(self):
        # Platform mapping: JSON platform name -> keysmap file suffix
        self.platform_mapping = {
            'windows': 'cpp',
            'android': 'java',
            'ios': 'ios',
            'macos': 'macos'
        }
        
        # Cache for href mappings from keysmap files: {platform: {key: href}}
        self.href_cache = {}
        
        # Cache for interface class mappings: {platform: {lowercase_class: proper_case_class}}
        self.interface_class_cache = {}
    
    def load_existing_json(self, file_path: str) -> Dict:
        """
        Load the existing name_groups.json file.
        
        Args:
            file_path: Path to the JSON file
            
        Returns:
            Dictionary containing the JSON data
        """
        try:
            with open(file_path, 'r', encoding='utf-8') as f:
                data = json.load(f)
            logger.info(f"Loaded existing JSON with {len(data.get('api', {}))} API entries")
            return data
        except Exception as e:
            logger.error(f"Error loading JSON file {file_path}: {e}")
            return {}
    
    def load_keysmap_href_mappings(self) -> None:
        """Load href mappings and interface class mappings from all keysmap files."""
        config_dir = "../../dita/RTC-NG/config"
        
        for platform, file_suffix in self.platform_mapping.items():
            file_path = os.path.join(config_dir, f"keys-rtc-ng-api-{file_suffix}.ditamap")
            
            if not os.path.exists(file_path):
                logger.warning(f"Keysmap file not found: {file_path}")
                continue
            
            try:
                tree = ET.parse(file_path)
                root = tree.getroot()
                
                platform_hrefs = {}
                platform_interface_classes = {}
                
                for keydef in root.iter():
                    if keydef.tag.endswith('keydef'):
                        keys = keydef.get('keys')
                        href = keydef.get('href')
                        
                        if keys and href:
                            # API and callback mappings
                            if href.startswith('../API/api_') or href.startswith('../API/callback_'):
                                platform_hrefs[keys] = href
                            # Interface class mappings
                            elif href.startswith('../API/class_'):
                                # Extract class name from href: ../API/class_irtcengine.dita -> irtcengine
                                class_match = re.search(r'class_([^/]+)\.dita', href)
                                if class_match:
                                    lowercase_class = class_match.group(1)
                                    platform_interface_classes[lowercase_class] = keys
                                    logger.debug(f"Found interface class mapping: {lowercase_class} -> {keys}")
                
                self.href_cache[platform] = platform_hrefs
                self.interface_class_cache[platform] = platform_interface_classes
                
                logger.info(f"Loaded {len(platform_hrefs)} href mappings and {len(platform_interface_classes)} interface class mappings from {file_path}")
                
            except Exception as e:
                logger.error(f"Error parsing keysmap file {file_path}: {e}")
    
    def extract_parent_class_from_href(self, href: str) -> Optional[str]:
        """
        Extract parent class from href path.
        
        Args:
            href: The href attribute value (e.g., "../API/api_ivideoeffectobject_addorupdatevideoeffect.dita")
            
        Returns:
            Parent class name or None if not found
        """
        # Pattern to match: {api|callback}_{parent_class}_{key}.dita
        pattern = r'\.\.\/API\/(api|callback)_([^_]+)_[^/]+\.dita'
        
        match = re.search(pattern, href)
        if match:
            parent_class = match.group(2)
            return parent_class
        
        logger.debug(f"Could not extract parent class from href: {href}")
        return None
    
    def get_proper_case_class_name(self, lowercase_class: str, supported_platforms: List[str]) -> str:
        """
        Get the proper case class name from interface class mappings.
        
        Args:
            lowercase_class: The lowercase class name extracted from href
            supported_platforms: List of platforms that support this API
            
        Returns:
            Proper case class name or the original lowercase name if not found
        """
        proper_case_names = {}
        
        for platform in supported_platforms:
            if platform not in self.interface_class_cache:
                continue
            
            if lowercase_class in self.interface_class_cache[platform]:
                proper_case_name = self.interface_class_cache[platform][lowercase_class]
                proper_case_names[platform] = proper_case_name
        
        if not proper_case_names:
            logger.debug(f"No proper case mapping found for class: {lowercase_class}")
            return lowercase_class
        
        # Check if all platforms have the same proper case name
        unique_proper_names = set(proper_case_names.values())
        
        if len(unique_proper_names) == 1:
            return list(unique_proper_names)[0]
        else:
            # Multiple different proper case names found
            logger.warning(f"Inconsistent proper case names for class {lowercase_class}: {proper_case_names}")
            # Return the most common one, or the first one if tie
            from collections import Counter
            counter = Counter(proper_case_names.values())
            most_common = counter.most_common(1)[0][0]
            logger.warning(f"Using most common proper case name for {lowercase_class}: {most_common}")
            return most_common
    
    def get_parent_class_for_key(self, key: str, supported_platforms: List[str]) -> Optional[str]:
        """
        Get parent class for a given key by checking all supported platforms.
        
        Args:
            key: The API key
            supported_platforms: List of platforms that support this key
            
        Returns:
            Parent class name in proper case or None if not found
        """
        parent_classes = {}
        
        for platform in supported_platforms:
            if platform not in self.href_cache:
                logger.debug(f"No href cache for platform: {platform}")
                continue
            
            if key not in self.href_cache[platform]:
                logger.debug(f"Key {key} not found in {platform} keysmap")
                continue
            
            href = self.href_cache[platform][key]
            lowercase_parent_class = self.extract_parent_class_from_href(href)
            
            if lowercase_parent_class:
                parent_classes[platform] = lowercase_parent_class
        
        if not parent_classes:
            logger.warning(f"No parent class found for key: {key}")
            return None
        
        # Check if all platforms have the same parent class (lowercase)
        unique_parent_classes = set(parent_classes.values())
        
        if len(unique_parent_classes) == 1:
            lowercase_class = list(unique_parent_classes)[0]
        else:
            # Multiple different parent classes found
            logger.warning(f"Inconsistent parent classes for key {key}: {parent_classes}")
            # Return the most common one, or the first one if tie
            from collections import Counter
            counter = Counter(parent_classes.values())
            lowercase_class = counter.most_common(1)[0][0]
            logger.warning(f"Using most common parent class for {key}: {lowercase_class}")
        
        # Get the proper case class name
        proper_case_class = self.get_proper_case_class_name(lowercase_class, supported_platforms)
        return proper_case_class
    
    def add_parent_class_to_apis(self, data: Dict) -> Dict:
        """
        Add parent_class field to all API entries.
        
        Args:
            data: The original JSON data
            
        Returns:
            Updated JSON data with parent_class fields
        """
        if 'api' not in data:
            logger.warning("No 'api' section found in JSON data")
            return data
        
        updated_apis = {}
        total_apis = len(data['api'])
        processed_count = 0
        added_parent_class_count = 0
        
        for key, platforms_data in data['api'].items():
            processed_count += 1
            
            if processed_count % 100 == 0:
                logger.info(f"Processed {processed_count}/{total_apis} APIs")
            
            # Get supported platforms (platforms that have keywords)
            supported_platforms = list(platforms_data.keys())
            
            # Filter out non-platform keys (like isOverload, params)
            actual_platforms = [p for p in supported_platforms if p in self.platform_mapping]
            
            if not actual_platforms:
                logger.debug(f"No supported platforms found for key: {key}")
                updated_apis[key] = platforms_data
                continue
            
            # Get parent class for this key
            parent_class = self.get_parent_class_for_key(key, actual_platforms)
            
            # Create updated entry
            updated_entry = dict(platforms_data)
            if parent_class:
                updated_entry['parent_class'] = parent_class
                added_parent_class_count += 1
            
            updated_apis[key] = updated_entry
        
        # Update the data
        data['api'] = updated_apis
        
        logger.info(f"Added parent_class to {added_parent_class_count}/{total_apis} APIs")
        return data
    
    def save_updated_json(self, data: Dict, output_file: str) -> None:
        """
        Save the updated JSON data to a file.
        
        Args:
            data: The updated JSON data
            output_file: Output file path
        """
        try:
            with open(output_file, 'w', encoding='utf-8') as f:
                json.dump(data, f, indent=4, ensure_ascii=False)
            
            logger.info(f"Successfully saved updated JSON to {output_file}")
            
            # Print statistics
            api_count = len(data.get('api', {}))
            apis_with_parent_class = sum(
                1 for api_data in data.get('api', {}).values()
                if isinstance(api_data, dict) and 'parent_class' in api_data
            )
            
            logger.info(f"Statistics:")
            logger.info(f"  Total API entries: {api_count}")
            logger.info(f"  APIs with parent_class: {apis_with_parent_class}")
            
        except Exception as e:
            logger.error(f"Error saving updated JSON to {output_file}: {e}")
    
    def run(self, input_file: str = "name_groups_merged.json", output_file: str = "name_groups_step1.json") -> None:
        """
        Run the complete parent class extraction process.
        
        Args:
            input_file: Input JSON file path
            output_file: Output JSON file path
        """
        logger.info("Starting parent class extraction process...")
        
        # Load existing JSON
        data = self.load_existing_json(input_file)
        if not data:
            logger.error("Failed to load existing JSON data")
            return
        
        # Load href mappings from keysmap files
        logger.info("Loading href mappings from keysmap files...")
        self.load_keysmap_href_mappings()
        
        if not self.href_cache:
            logger.error("No href mappings found")
            return
        
        total_mappings = sum(len(platform_hrefs) for platform_hrefs in self.href_cache.values())
        logger.info(f"Found {total_mappings} total href mappings across all platforms")
        
        # Add parent class to API entries
        logger.info("Adding parent_class to API entries...")
        updated_data = self.add_parent_class_to_apis(data)
        
        # Save updated JSON
        self.save_updated_json(updated_data, output_file)
        
        logger.info("Parent class extraction completed!")


def main():
    """Main function."""
    extractor = ParentClassExtractor()
    extractor.run()


if __name__ == "__main__":
    main()
