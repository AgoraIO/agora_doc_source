#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Extract parameter information for overloaded methods from name_groups.json.

This script identifies overloaded methods (methods with keys like key, key1, key2, etc.)
and adds parameter information only for those methods. Non-overloaded methods remain unchanged.
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

class OverloadParameterExtractor:
    """Extract parameter information for overloaded methods only."""
    
    def __init__(self):
        # Platform mapping: JSON platform name -> keysmap file suffix
        self.platform_mapping = {
            'electron': 'electron',
            'flutter': 'flutter',
            'rn': 'rn',
            'unity': 'unity',
            'csharp': 'unity',
            'unreal-cpp': 'unreal',
            'unreal-bp': 'blueprint',
            'windows': 'cpp',
            'ios': 'ios',
            'android': 'java',
            'macos': 'macos',
            'harmonyos': 'harmony'
        }
        
        # Platform props mapping for DITA files (one-to-one)
        self.platform_props = {
            'electron': ['electron'],
            'flutter': ['flutter'],
            'rn': ['rn'],
            'unity': ['unity'],
            'csharp': ['cs'],
            'unreal-cpp': ['unreal'],
            'unreal-bp': ['bp'],
            'windows': ['cpp'],
            'ios': ['ios'],
            'android': ['android'],
            'macos': ['mac'],
            'harmonyos': ['hmos']
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
    
    def identify_overloaded_methods(self, api_data: Dict) -> Dict[str, List[str]]:
        """
        Identify overloaded methods by analyzing key patterns.
        
        Args:
            api_data: The API section of the JSON data
            
        Returns:
            Dictionary mapping base method names to lists of overloaded keys
        """
        overload_groups = {}
        
        # Group keys by their base names
        for key in api_data.keys():
            # Extract base name (remove trailing digits)
            # Handle two patterns:
            # 1. methodName1, methodName2 -> methodName
            # 2. methodName2_ClassName -> methodName_ClassName
            base_name = re.sub(r'\d+$', '', key)  # Pattern 1: digits at end
            if base_name == key:
                # No digits at end, try pattern 2: digits before underscore
                base_name = re.sub(r'\d+(_)', r'\1', key)
            
            if base_name not in overload_groups:
                overload_groups[base_name] = []
            overload_groups[base_name].append(key)
        
        # Filter to only include groups with multiple methods
        overloaded_methods = {
            base_name: keys for base_name, keys in overload_groups.items()
            if len(keys) > 1
        }
        
        logger.info(f"Found {len(overloaded_methods)} overloaded method groups:")
        for base_name, keys in overloaded_methods.items():
            logger.info(f"  {base_name}: {keys}")
        
        return overloaded_methods
    
    def load_keysmap_href_mappings(self) -> None:
        """Load href mappings from all keysmap files."""
        config_dir = "../../dita/RTC-NG/config"
        
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
                        
                        # Load both API files (api_*) and class files (class_*)
                        if keys and href and (href.startswith('../API/api_')  or href.startswith('../API/class_') or href.startswith('../API/callback_')):
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
        
        full_path = os.path.join("../../dita/RTC-NG", dita_path.lstrip('../'))
        
        try:
            tree = ET.parse(full_path)
            root = tree.getroot()
            self.dita_cache[dita_path] = root
            return root
        except Exception as e:
            logger.error(f"Error parsing DITA file {full_path}: {e}")
            return None
    
    def resolve_conkeyref(self, conkeyref: str, referrer_props: str = '', visited_refs: Set[str] = None) -> List[Dict]:
        """
        Resolve conkeyref references to get parameter information.
        
        Args:
            conkeyref: The conkeyref attribute value (e.g., "joinChannel2/token")
            referrer_props: The props attribute from the referrer plentry (if any)
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
                        
                        # Extract params from the referenced plentry
                        params = self.extract_params_from_plentry(plentry, visited_refs)
                        
                        # If the referrer has props, we need to filter the platforms
                        if referrer_props:
                            referrer_platforms = self.parse_props_to_platforms(referrer_props)
                            # Filter each parameter's platforms
                            filtered_params = []
                            for param in params:
                                # Intersect with referrer platforms
                                filtered_platforms = [p for p in param['platforms'] if p in referrer_platforms]
                                if filtered_platforms:
                                    filtered_params.append({
                                        'name': param['name'],
                                        'platforms': filtered_platforms
                                    })
                            return filtered_params
                        
                        return params
        
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
            # Pass the plentry's props to resolve_conkeyref
            plentry_props = plentry.get('props', '')
            return self.resolve_conkeyref(conkeyref, plentry_props, visited_refs)
        
        # Check if plentry itself has props
        plentry_props = plentry.get('props', '')
        
        # Dictionary to store parameter names by platform
        # This handles cases where different platforms use different parameter names
        platform_param_names = {}
        
        # Extract pt elements
        for pt in plentry.iter():
            if pt.tag.endswith('pt') and pt.text and pt.text.strip():
                param_name = pt.text.strip()
                
                # Get platform information from props
                # Priority: pt props > plentry props > no props (all platforms)
                pt_props = pt.get('props', '')
                
                if pt_props:
                    # pt has its own props, use it
                    platforms = self.parse_props_to_platforms(pt_props)
                elif plentry_props:
                    # plentry has props, use it
                    platforms = self.parse_props_to_platforms(plentry_props)
                else:
                    # No props means all platforms
                    platforms = list(self.platform_mapping.keys())
                
                # Store the parameter name for each platform
                for platform in platforms:
                    if platform not in platform_param_names:
                        platform_param_names[platform] = []
                    platform_param_names[platform].append(param_name)
        
        # Convert to the expected format
        # Group by parameter name and collect platforms
        param_dict = {}
        for platform, param_names in platform_param_names.items():
            for param_name in param_names:
                if param_name not in param_dict:
                    param_dict[param_name] = []
                param_dict[param_name].append(platform)
        
        # Convert to list format
        params = []
        for param_name, platforms in param_dict.items():
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
        
        # Handle special props shortcuts first
        if 'native' in props_list:
            # native means all platforms: android, cpp, ios, mac
            applicable_platforms.extend(['android', 'windows', 'ios', 'macos'])
        else:
            # Handle apple shortcut (can coexist with other props)
            if 'apple' in props_list:
                # apple means iOS and macOS platforms: ios, mac
                applicable_platforms.extend(['ios', 'macos'])
            
            # Normal props processing (check all other props)
            for platform, platform_props in self.platform_props.items():
                # Check if any of the platform's props are in the props list
                if any(prop in props_list for prop in platform_props):
                    # Avoid adding duplicates from apple shortcut
                    if platform not in applicable_platforms:
                        applicable_platforms.append(platform)
        
        # Remove duplicates while preserving order
        seen = set()
        applicable_platforms = [
            platform for platform in applicable_platforms
            if not (platform in seen or seen.add(platform))
        ]
        
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
        
        # Check if the parameters section itself has props
        section_props = parameters_section.get('props', '')
        section_platforms = None
        if section_props:
            # If the section has props, only these platforms should have parameters
            section_platforms = self.parse_props_to_platforms(section_props)
            logger.debug(f"Parameters section has props='{section_props}', applicable platforms: {section_platforms}")
        
        # Initialize platform parameter lists
        platform_params = {platform: [] for platform in self.platform_mapping.keys()}
        
        # Extract parameters from each plentry
        for plentry in parameters_section.iter():
            if plentry.tag.endswith('plentry'):
                params = self.extract_params_from_plentry(plentry)
                
                for param in params:
                    param_name = param['name']
                    param_platforms = param['platforms']
                    
                    # If section has props, intersect with param platforms
                    if section_platforms:
                        param_platforms = [p for p in param_platforms if p in section_platforms]
                    
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
    
    def update_overloaded_methods(self, data: Dict, overloaded_methods: Dict[str, List[str]]) -> Dict:
        """
        Update only the overloaded methods with parameter information.
        
        Args:
            data: The original JSON data
            overloaded_methods: Dictionary of overloaded method groups
            
        Returns:
            Updated JSON data
        """
        if 'api' not in data:
            logger.warning("No 'api' section found in JSON data")
            return data
        
        # Get all overloaded keys (from identified groups)
        all_overloaded_keys = set()
        for keys in overloaded_methods.values():
            all_overloaded_keys.update(keys)
        
        updated_apis = {}
        
        for key, platforms_data in data['api'].items():
            # Check if this is an overloaded method:
            # 1. It's in the identified overloaded groups, OR
            # 2. It already has isOverload=true in the original data
            is_overloaded = (key in all_overloaded_keys or 
                           (isinstance(platforms_data, dict) and platforms_data.get('isOverload')))
            
            if is_overloaded:
                # This is an overloaded method, add isOverload and params
                logger.debug(f"Processing overloaded method: {key}")
                
                # Get the href for this key
                href = self.href_cache.get(key)
                if not href:
                    logger.debug(f"No href found for overloaded key: {key}")
                    # Keep original structure but add isOverload
                    updated_apis[key] = dict(platforms_data)
                    updated_apis[key]['isOverload'] = True
                    updated_apis[key]['params'] = {}
                    continue
                
                # Extract parameters from the DITA file
                platform_params = self.extract_parameters_from_dita(href)
                
                # Create new structure
                updated_entry = dict(platforms_data)
                updated_entry['isOverload'] = True
                updated_entry['params'] = {}
                
                # Add params for platforms that have parameters
                for platform in self.platform_mapping.keys():
                    if platform in platform_params and platform_params[platform]:
                        updated_entry['params'][platform] = platform_params[platform]
                
                updated_apis[key] = updated_entry
            else:
                # This is not an overloaded method, keep original structure
                updated_apis[key] = platforms_data
        
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
            
            # Pattern to match params object values that span multiple lines
            params_pattern = r'"([^"]+)": \[\s*\n(\s*"[^"]*",?\s*\n)*\s*\]'
            
            def format_params_array(match):
                # Extract the matched text
                matched_text = match.group(0)
                platform_name = match.group(1)
                
                # Extract all parameter names using regex
                param_names = re.findall(r'"([^"]*)"', matched_text)
                # Remove the platform name from param_names
                param_names = [name for name in param_names if name != platform_name]
                
                # Format as single line array
                if param_names:
                    formatted_params = '["' + '", "'.join(param_names) + '"]'
                else:
                    formatted_params = '[]'
                
                return f'"{platform_name}": {formatted_params}'
            
            # Apply the formatting
            content = re.sub(params_pattern, format_params_array, content)
            
            # Write the formatted content back
            with open(output_file, 'w', encoding='utf-8') as f:
                f.write(content)
            
            logger.info(f"Successfully saved updated JSON to {output_file}")
            
            # Print statistics
            api_count = len(data.get('api', {}))
            overloaded_count = sum(
                1 for api_data in data.get('api', {}).values()
                if isinstance(api_data, dict) and api_data.get('isOverload')
            )
            
            logger.info(f"Statistics:")
            logger.info(f"  Total API entries: {api_count}")
            logger.info(f"  Overloaded methods: {overloaded_count}")
            
        except Exception as e:
            logger.error(f"Error saving updated JSON to {output_file}: {e}")
    
    def run(self, input_file: str = "name_groups.json", output_file: str = "name_groups.json") -> None:
        """
        Run the complete overload parameter extraction process.
        
        Args:
            input_file: Input JSON file path
            output_file: Output JSON file path
        """
        logger.info("Starting overload parameter extraction process...")
        
        # Load existing JSON
        data = self.load_existing_json(input_file)
        if not data:
            logger.error("Failed to load existing JSON data")
            return
        
        # Identify overloaded methods
        logger.info("Identifying overloaded methods...")
        overloaded_methods = self.identify_overloaded_methods(data.get('api', {}))
        
        if not overloaded_methods:
            logger.info("No overloaded methods found, copying original file...")
            with open(output_file, 'w', encoding='utf-8') as f:
                json.dump(data, f, indent=4, ensure_ascii=False)
            return
        
        # Load href mappings from keysmap files
        logger.info("Loading href mappings from keysmap files...")
        self.load_keysmap_href_mappings()
        
        if not self.href_cache:
            logger.error("No href mappings found")
            return
        
        logger.info(f"Found {len(self.href_cache)} href mappings")
        
        # Update overloaded methods with parameters
        logger.info("Extracting parameters for overloaded methods...")
        updated_data = self.update_overloaded_methods(data, overloaded_methods)
        
        # Save updated JSON
        self.save_updated_json(updated_data, output_file)
        
        logger.info("Overload parameter extraction completed!")


def main():
    """Main function."""
    extractor = OverloadParameterExtractor()
    extractor.run()


if __name__ == "__main__":
    main()
