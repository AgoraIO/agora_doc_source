#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Add parameter information to the name_groups.json file for API entries.

This script reads the existing name_groups.json file, extracts parameter information
from corresponding DITA files, and updates the JSON structure to include parameters
for each platform.
"""

import os
import json
import xml.etree.ElementTree as ET
from typing import Dict, List, Tuple, Optional, Set
import logging
import re

# Configure logging
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')
logger = logging.getLogger(__name__)

class ParameterExtractor:
    """Extract parameter information from DITA files and update JSON structure."""
    
    def __init__(self):
        # Platform mapping: JSON platform name -> keysmap file suffix
        self.platform_mapping = {
            'windows': 'cpp',
            'android': 'java',
            'ios': 'ios',
            'macos': 'macos'
        }
        
        # Platform props mapping for DITA files
        self.platform_props = {
            'windows': ['cpp'],
            'android': ['android'],
            'ios': ['ios'],
            'macos': ['mac']
        }
        
        # Cache for parsed DITA files to avoid re-parsing
        self.dita_cache = {}
        
        # Cache for href mappings from keysmap files
        self.href_cache = {}
    
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
        """Load href mappings from all keysmap files."""
        config_dir = "dita/RTC-NG/config"
        
        for platform, file_suffix in self.platform_mapping.items():
            file_path = os.path.join(config_dir, f"keys-rtc-ng-api-{file_suffix}.ditamap")
            
            if not os.path.exists(file_path):
                logger.warning(f"Keysmap file not found: {file_path}")
                continue
            
            try:
                tree = ET.parse(file_path)
                root = tree.getroot()
                
                for keydef in root.iter():
                    if keydef.tag.endswith('keydef'):
                        keys = keydef.get('keys')
                        href = keydef.get('href')
                        
                        if keys and href and href.startswith('../API/api_'):
                            # Store the href for this key
                            if keys not in self.href_cache:
                                self.href_cache[keys] = href
                
                logger.info(f"Loaded {len([k for k in self.href_cache.keys()])} href mappings from {file_path}")
                
            except Exception as e:
                logger.error(f"Error parsing keysmap file {file_path}: {e}")
    
    def parse_dita_file(self, dita_path: str) -> Optional[ET.Element]:
        """
        Parse a DITA file and return the root element.
        
        Args:
            dita_path: Path to the DITA file
            
        Returns:
            Root element of the parsed DITA file or None if parsing fails
        """
        if dita_path in self.dita_cache:
            return self.dita_cache[dita_path]
        
        full_path = os.path.join("dita/RTC-NG", dita_path.lstrip('../'))
        
        try:
            tree = ET.parse(full_path)
            root = tree.getroot()
            self.dita_cache[dita_path] = root
            return root
        except Exception as e:
            logger.error(f"Error parsing DITA file {full_path}: {e}")
            return None
    
    def resolve_conkeyref(self, conkeyref: str, visited_refs: Set[str] = None) -> List[Dict]:
        """
        Resolve conkeyref references to get parameter information.
        
        Args:
            conkeyref: The conkeyref attribute value (e.g., "joinChannel2/token")
            visited_refs: Set to track visited references to prevent infinite loops
            
        Returns:
            List of parameter dictionaries
        """
        if visited_refs is None:
            visited_refs = set()
        
        if conkeyref in visited_refs:
            logger.warning(f"Circular reference detected in conkeyref: {conkeyref}")
            return []
        
        visited_refs.add(conkeyref)
        
        try:
            key, param_id = conkeyref.split('/', 1)
        except ValueError:
            logger.warning(f"Invalid conkeyref format: {conkeyref}")
            return []
        
        # Get the href for the referenced key
        if key not in self.href_cache:
            logger.warning(f"Referenced key not found in href cache: {key}")
            return []
        
        href = self.href_cache[key]
        root = self.parse_dita_file(href)
        
        if root is None:
            return []
        
        # Find the referenced plentry by id
        for section in root.iter():
            if (section.tag.endswith('section') and 
                section.get('id') == 'parameters'):
                
                for plentry in section.iter():
                    if (plentry.tag.endswith('plentry') and 
                        plentry.get('id') == param_id):
                        
                        return self.extract_params_from_plentry(plentry, visited_refs)
        
        logger.warning(f"Referenced parameter not found: {conkeyref}")
        return []
    
    def extract_params_from_plentry(self, plentry: ET.Element, visited_refs: Set[str] = None) -> List[Dict]:
        """
        Extract parameter information from a plentry element.
        
        Args:
            plentry: The plentry XML element
            visited_refs: Set to track visited references
            
        Returns:
            List of parameter dictionaries with 'name' and 'platforms' keys
        """
        if visited_refs is None:
            visited_refs = set()
        
        # Check if this plentry has a conkeyref
        conkeyref = plentry.get('conkeyref')
        if conkeyref:
            return self.resolve_conkeyref(conkeyref, visited_refs)
        
        params = []
        
        # Extract pt elements
        for pt in plentry.iter():
            if pt.tag.endswith('pt') and pt.text and pt.text.strip():
                param_name = pt.text.strip()
                
                # Get platform information from props
                props = pt.get('props', '')
                if props:
                    # Parse props to get platforms
                    platforms = self.parse_props_to_platforms(props)
                else:
                    # No props means all platforms
                    platforms = list(self.platform_mapping.keys())
                
                params.append({
                    'name': param_name,
                    'platforms': platforms
                })
        
        return params
    
    def parse_props_to_platforms(self, props: str) -> List[str]:
        """
        Parse props attribute to determine which platforms it applies to.
        
        Args:
            props: The props attribute value
            
        Returns:
            List of platform names
        """
        props_list = [p.strip() for p in props.split()]
        applicable_platforms = []
        
        for platform, platform_props in self.platform_props.items():
            # Check if any of the platform's props are in the props list
            if any(prop in props_list for prop in platform_props):
                applicable_platforms.append(platform)
        
        return applicable_platforms
    
    def extract_parameters_from_dita(self, dita_path: str) -> Dict[str, List[str]]:
        """
        Extract parameters from a DITA file for all platforms.
        
        Args:
            dita_path: Path to the DITA file
            
        Returns:
            Dictionary mapping platform names to parameter lists
        """
        root = self.parse_dita_file(dita_path)
        if root is None:
            return {}
        
        # Find the parameters section
        parameters_section = None
        for section in root.iter():
            if (section.tag.endswith('section') and 
                section.get('id') == 'parameters'):
                parameters_section = section
                break
        
        if parameters_section is None:
            logger.debug(f"No parameters section found in {dita_path}")
            return {}
        
        # Initialize platform parameter lists
        platform_params = {platform: [] for platform in self.platform_mapping.keys()}
        
        # Extract parameters from each plentry
        for plentry in parameters_section.iter():
            if plentry.tag.endswith('plentry'):
                params = self.extract_params_from_plentry(plentry)
                
                for param in params:
                    param_name = param['name']
                    param_platforms = param['platforms']
                    
                    # Add parameter to applicable platforms
                    for platform in param_platforms:
                        if platform in platform_params:
                            platform_params[platform].append(param_name)
        
        # Remove duplicates while preserving order
        for platform in platform_params:
            seen = set()
            platform_params[platform] = [
                param for param in platform_params[platform]
                if not (param in seen or seen.add(param))
            ]
        
        return platform_params
    
    def update_api_with_parameters(self, data: Dict) -> Dict:
        """
        Update the API entries in the JSON data with parameter information.
        
        Args:
            data: The original JSON data
            
        Returns:
            Updated JSON data with parameters
        """
        if 'api' not in data:
            logger.warning("No 'api' section found in JSON data")
            return data
        
        updated_apis = {}
        total_apis = len(data['api'])
        processed_count = 0
        
        for key, platforms_data in data['api'].items():
            processed_count += 1
            
            if processed_count % 50 == 0:
                logger.info(f"Processed {processed_count}/{total_apis} APIs")
            
            # Get the href for this key
            href = self.href_cache.get(key)
            if not href:
                logger.debug(f"No href found for key: {key}")
                # Keep original structure without parameters
                updated_apis[key] = platforms_data
                continue
            
            # Extract parameters from the DITA file
            platform_params = self.extract_parameters_from_dita(href)
            
            # Update the structure
            updated_platforms = {}
            for platform, keyword in platforms_data.items():
                updated_platforms[platform] = {
                    'keyword': keyword,
                    'params': platform_params.get(platform, [])
                }
            
            updated_apis[key] = updated_platforms
        
        # Update the data
        data['api'] = updated_apis
        return data
    
    def save_updated_json(self, data: Dict, output_file: str) -> None:
        """
        Save the updated JSON data to a file with custom formatting.
        
        Args:
            data: The updated JSON data
            output_file: Output file path
        """
        try:
            # First save with default formatting
            with open(output_file, 'w', encoding='utf-8') as f:
                json.dump(data, f, indent=4, ensure_ascii=False)
            
            # Read the file and reformat params arrays to single line
            with open(output_file, 'r', encoding='utf-8') as f:
                content = f.read()
            
            # Use regex to format params arrays to single line
            import re
            
            # Pattern to match params arrays that span multiple lines
            params_pattern = r'"params": \[\s*\n(\s*"[^"]*",?\s*\n)*\s*\]'
            
            def format_params_array(match):
                # Extract the matched text
                matched_text = match.group(0)
                
                # Extract all parameter names using regex
                param_names = re.findall(r'"([^"]*)"', matched_text)
                
                # Format as single line array
                if param_names:
                    formatted_params = '["' + '", "'.join(param_names) + '"]'
                else:
                    formatted_params = '[]'
                
                return f'"params": {formatted_params}'
            
            # Apply the formatting
            content = re.sub(params_pattern, format_params_array, content)
            
            # Write the formatted content back
            with open(output_file, 'w', encoding='utf-8') as f:
                f.write(content)
            
            logger.info(f"Successfully saved updated JSON to {output_file}")
            
            # Print statistics
            api_count = len(data.get('api', {}))
            apis_with_params = sum(
                1 for api_data in data.get('api', {}).values()
                if any(
                    isinstance(platform_data, dict) and platform_data.get('params')
                    for platform_data in api_data.values()
                )
            )
            
            logger.info(f"Statistics:")
            logger.info(f"  Total API entries: {api_count}")
            logger.info(f"  APIs with parameters: {apis_with_params}")
            
        except Exception as e:
            logger.error(f"Error saving updated JSON to {output_file}: {e}")
    
    def run(self, input_file: str = "name_groups.json", output_file: str = "name_groups_with_params.json") -> None:
        """
        Run the complete parameter extraction and JSON update process.
        
        Args:
            input_file: Input JSON file path
            output_file: Output JSON file path
        """
        logger.info("Starting parameter extraction process...")
        
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
        
        logger.info(f"Found {len(self.href_cache)} href mappings")
        
        # Update API entries with parameters
        logger.info("Extracting parameters and updating JSON structure...")
        updated_data = self.update_api_with_parameters(data)
        
        # Save updated JSON
        self.save_updated_json(updated_data, output_file)
        
        logger.info("Parameter extraction completed!")


def main():
    """Main function."""
    extractor = ParameterExtractor()
    extractor.run()


if __name__ == "__main__":
    main()
