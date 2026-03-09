#!/usr/bin/env python3
"""
DITA Map Reorganization Script

Reorganizes ditamap files from function-based classification to parent class-based classification.
Supports batch processing for multiple platforms, uses lxml for XML parsing, and validates key consistency before reorganization.
"""

import json
from lxml import etree
import argparse
from pathlib import Path
from typing import Dict, List, Optional, Set
from collections import defaultdict
import sys

# Predefined parent class order
# This order is based on the structure found in RTC-NG ditamap files across different platforms
PARENT_CLASS_ORDER = [
    # Core RTC Engine classes
    "IRtcEngine",
    "IRtcEngineEx",
    "IRtcEngineEventHandler",
    # Media Player classes
    "IMediaPlayer",
    "IMediaPlayerCacheManager",
    "IMediaPlayerSourceObserver",
    "IMediaPlayerCustomDataProvider",  # Unity only
    # Observer classes
    "IAudioEncodedFrameObserver",
    "IAudioFrameObserver",
    "IAudioFrameObserverBase",
    "IMediaPlayerAudioFrameObserver",
    "IMediaPlayerVideoFrameObserver",
    "IVideoEncodedFrameObserver",
    "IVideoFrameObserver",
    "IAudioSpectrumObserver",
    "IMetadataObserver",
    # Device Manager classes
    "IAudioDeviceManager",
    "IVideoDeviceManager",
    # Media Engine
    "IMediaEngine",
    # Direct CDN Streaming
    "IDirectCdnStreamingEventHandler",
    # Spatial Audio classes
    "IBaseSpatialAudioEngine",
    "ICloudSpatialAudioEngine",  # Unity only
    "ICloudSpatialAudioEventHandler",  # Unity only
    "ILocalSpatialAudioEngine",
    # Media Recorder classes
    "IMediaRecorder",
    "IMediaRecorderObserver",
    # Music Content Center (CN only)
    "IMusicContentCenter",
    "IMusicContentCenterEventHandler",
    "IMusicPlayer",
    # Platform-specific classes
    # React Native
    "RtcSurfaceView",
    "RtcTextureView",
    # Flutter
    "RtcEngineExt",
    "AgoraVideoView",
    "MediaPlayerController",
    "VideoViewController",
    # Unity
    "AgoraVideoSurface",
    "VideoSurfaceYUV",
]

# Non-API keyrefs that should be filtered out (parent classes)
NON_API_KEYS = set(PARENT_CLASS_ORDER)


def get_tag_name(element) -> str:
    """
    Extract tag name from an element, handling namespaces
    
    Args:
        element: XML element
        
    Returns:
        Tag name without namespace prefix
    """
    tag = element.tag
    if isinstance(tag, str):
        return tag.split('}')[-1] if '}' in tag else tag
    else:
        # Handle QName objects or other tag types
        tag_str = str(tag)
        return tag_str.split('}')[-1] if '}' in tag_str else tag_str


class DitamapReorganizer:
    """DITA Map Reorganizer"""
    
    def __init__(self, name_groups_path: str, platform: str):
        """
        Initialize the reorganizer
        
        Args:
            name_groups_path: Path to the name_groups JSON file
            platform: Target platform name (e.g., 'electron')
        """
        self.platform = platform
        self.name_groups_path = Path(name_groups_path)
        
        # Load name_groups data
        if not self.name_groups_path.exists():
            raise FileNotFoundError(f"name_groups file not found: {name_groups_path}")
        
        with open(self.name_groups_path, 'r', encoding='utf-8') as f:
            self.name_groups = json.load(f)
        
        if 'api' not in self.name_groups:
            raise ValueError("No 'api' section found in name_groups file")
        
        self.api_data = self.name_groups['api']
    
    def get_platform_api_keys(self) -> Set[str]:
        """
        Get all API keys supported by this platform
        
        Returns:
            Set of API keys
        """
        api_keys = set()
        
        for api_key, api_info in self.api_data.items():
            # Check if this platform supports this API
            if self.platform in api_info:
                api_keys.add(api_key)
        
        return api_keys
    
    def extract_keys_from_ditamap(self, ditamap_path: str) -> Set[str]:
        """
        Extract all API keyrefs from a ditamap file
        
        Args:
            ditamap_path: Path to the ditamap file
            
        Returns:
            Set of API keys (filtered to exclude parent classes and interface classes)
        """
        tree = etree.parse(ditamap_path)
        root = tree.getroot()
        
        # Extract all keyrefs
        api_keys = set()
        
        # Track if we're inside rtc_interface_class.dita section
        in_interface_class_section = False
        
        # Iterate through all topicref elements
        for topicref in root.iter():
            # Check if this is a topicref element (handle namespaces)
            tag_name = get_tag_name(topicref)
            
            if tag_name == 'topicref':
                href = topicref.get('href')
                # Check if we're entering or leaving the interface class section
                if href and 'rtc_interface_class.dita' in href:
                    in_interface_class_section = True
                    continue
                elif href and in_interface_class_section:
                    # If we encounter another href while in interface class section, we've left it
                    in_interface_class_section = False
                
                keyref = topicref.get('keyref')
                if keyref:
                    # Filter out parent class keyrefs
                    if keyref in NON_API_KEYS:
                        continue
                    
                    # Filter out interface classes (keys in rtc_interface_class.dita section)
                    if in_interface_class_section:
                        continue
                    
                    # Filter out keys that look like interface classes but aren't in name_groups
                    # (these are likely old interface classes that should be ignored)
                    if keyref not in self.api_data and keyref.startswith('I') and keyref[1:2].isupper():
                        continue
                    
                    api_keys.add(keyref)
        
        return api_keys
    
    def check_key_consistency(self, ditamap_path: str) -> tuple[bool, Optional[str]]:
        """
        Check if keys in ditamap are consistent with name_groups
        
        Args:
            ditamap_path: Path to the ditamap file
            
        Returns:
            (is_consistent, error_message)
        """
        ditamap_keys = self.extract_keys_from_ditamap(ditamap_path)
        name_groups_keys = self.get_platform_api_keys()
        
        # Find differences
        only_in_ditamap = ditamap_keys - name_groups_keys
        only_in_name_groups = name_groups_keys - ditamap_keys
        
        # Only report keys that are in ditamap but not in name_groups as errors
        # Keys only in name_groups might be old version APIs that have been replaced
        if only_in_ditamap:
            error_msg = f"Key inconsistency detected!\n"
            error_msg += f"Keys in ditamap but not in name_groups ({len(only_in_ditamap)}): {sorted(only_in_ditamap)}\n"
            if only_in_name_groups:
                error_msg += f"Note: Keys only in name_groups ({len(only_in_name_groups)}): {sorted(only_in_name_groups)}\n"
                error_msg += "These are likely old version APIs that have been replaced in the ditamap.\n"
            return False, error_msg
        
        # If there are keys only in name_groups, warn but don't fail
        if only_in_name_groups:
            print(f"Warning: {len(only_in_name_groups)} keys in name_groups but not in ditamap (likely old version APIs): {sorted(only_in_name_groups)}")
        
        return True, None
    
    def extract_apis_by_parent_class(self) -> Dict[str, List[str]]:
        """
        Group APIs by parent_class
        
        Returns:
            Dictionary mapping parent_class to list of API keys
        """
        apis_by_class = defaultdict(list)
        
        for api_key, api_info in self.api_data.items():
            # Check if this platform supports this API
            if self.platform not in api_info:
                continue
            
            # Get parent_class
            parent_class = api_info.get('parent_class')
            if not parent_class:
                print(f"Warning: API '{api_key}' has no parent_class, skipping")
                continue
            
            apis_by_class[parent_class].append(api_key)
        
        # Sort APIs within each parent_class alphabetically
        for parent_class in apis_by_class:
            apis_by_class[parent_class].sort()
        
        return dict(apis_by_class)
    
    def reorganize_ditamap(self, input_path: str):
        """
        Reorganize the ditamap file
        
        Args:
            input_path: Path to the input ditamap file
        """
        input_path = Path(input_path)
        
        # Read original file content to preserve XML declaration and DOCTYPE
        with open(input_path, 'r', encoding='utf-8') as f:
            original_content = f.read()
        
        # Parse source file
        parser = etree.XMLParser(strip_cdata=False, remove_blank_text=False)
        tree = etree.parse(input_path, parser)
        root = tree.getroot()
        
        # Extract map element
        map_elem = root
        tag_name = get_tag_name(map_elem)
        if tag_name != 'map':
            for elem in root.iter():
                tag_name = get_tag_name(elem)
                if tag_name == 'map':
                    map_elem = elem
                    break
        
        # Extract Configurations section
        configurations_section = None
        api_topichead = None
        
        for child in map_elem:
            tag_name = get_tag_name(child)
            if tag_name == 'topichead':
                navtitle = child.get('navtitle')
                if navtitle == 'Configurations':
                    configurations_section = child
                elif navtitle and navtitle != 'Configurations':
                    api_topichead = child
        
        # Extract tail references and rtc_api_overview
        tail_refs = []
        overview_ref = None
        
        if api_topichead is not None:
            children = list(api_topichead)
            # Find overview from front to back
            for child in children:
                tag_name = get_tag_name(child)
                if tag_name == 'topicref':
                    href = child.get('href')
                    if href and 'rtc_api_overview' in href and overview_ref is None:
                        overview_ref = child
                        break
            
            # Find tail references from back to front (rtc_api_data_type.dita and rtc_api_sunset.dita)
            for i in range(len(children) - 1, -1, -1):
                child = children[i]
                tag_name = get_tag_name(child)
                if tag_name == 'topicref':
                    href = child.get('href')
                    if href:
                        if 'rtc_api_data_type.dita' in href or 'rtc_api_sunset.dita' in href:
                            tail_refs.insert(0, child)
                        elif 'rtc_api_overview' not in href:
                            # If we encounter other hrefs (not overview or tail), stop collecting tail
                            break
        
        # Get APIs grouped by parent_class
        apis_by_class = self.extract_apis_by_parent_class()
        
        # Create new topichead for API classification
        # Use deep copy to avoid modifying original elements
        new_topichead = etree.Element('topichead')
        
        # Add topicmeta if it exists in source file
        if api_topichead is not None:
            for child in api_topichead:
                tag_name = get_tag_name(child)
                if tag_name == 'topicmeta':
                    new_topichead.append(etree.fromstring(etree.tostring(child)))
                    break
        
        # Add rtc_api_overview if it exists
        if overview_ref is not None:
            new_topichead.append(etree.fromstring(etree.tostring(overview_ref)))
        
        # Add parent_classes in predefined order
        for parent_class in PARENT_CLASS_ORDER:
            if parent_class not in apis_by_class:
                continue
            
            # Create topicref for parent_class
            parent_ref = etree.Element('topicref')
            parent_ref.set('keyref', parent_class)
            parent_ref.set('chunk', 'to-content')
            
            # Add all APIs under this parent_class
            for api_key in apis_by_class[parent_class]:
                api_ref = etree.Element('topicref')
                api_ref.set('keyref', api_key)
                api_ref.set('toc', 'no')
                parent_ref.append(api_ref)
            
            new_topichead.append(parent_ref)
        
        # Add tail references
        for tail_ref in tail_refs:
            new_topichead.append(etree.fromstring(etree.tostring(tail_ref)))
        
        # Build new map element
        new_map = etree.Element('map')
        
        # Copy map attributes
        for key, value in map_elem.items():
            new_map.set(key, value)
        
        # Add title and topicmeta if they exist
        for child in map_elem:
            tag_name = get_tag_name(child)
            if tag_name in ['title', 'topicmeta']:
                new_map.append(etree.fromstring(etree.tostring(child)))
        
        # Add Configurations section
        if configurations_section is not None:
            new_map.append(etree.fromstring(etree.tostring(configurations_section)))
        
        # Add new API classification section
        new_map.append(new_topichead)
        
        # Generate XML string
        xml_string = etree.tostring(
            new_map,
            encoding='UTF-8',
            xml_declaration=False,
            pretty_print=True
        ).decode('utf-8')
        
        # Add XML declaration and DOCTYPE
        xml_declaration = '<?xml version="1.0" encoding="UTF-8"?>'
        doctype = '<!DOCTYPE map PUBLIC "-//OASIS//DTD DITA Map//EN" "map.dtd">'
        
        final_xml = f'{xml_declaration}\n{doctype}\n{xml_string}'
        
        # Write to file
        with open(input_path, 'w', encoding='utf-8') as f:
            f.write(final_xml)


def get_ditamap_path(platform: str) -> Path:
    """
    Generate ditamap file path based on platform name
    
    Args:
        platform: Platform name (e.g., 'electron')
        
    Returns:
        Path to the ditamap file
    """
    # Capitalize first letter of platform name
    platform_capitalized = platform[0].upper() + platform[1:] if platform else platform
    
    # Build file path
    base_path = Path('en-US/dita/RTC-AIDOC-FRAMEWORK')
    filename = f'RTC_NG_API_{platform_capitalized}.ditamap'
    
    return base_path / filename


def main():
    """Main function"""
    parser = argparse.ArgumentParser(
        description='Reorganize DITA Map files from function-based to parent class-based classification'
    )
    parser.add_argument(
        '--platform',
        type=str,
        required=True,
        help='Target platform(s), supports multiple platforms separated by commas, e.g., electron,rn,flutter'
    )
    parser.add_argument(
        '--name-groups',
        type=str,
        default='scripts/reorg-ditamap/name_groups_framework.json',
        help='Path to name_groups file (default: scripts/reorg-ditamap/name_groups_framework.json)'
    )
    
    args = parser.parse_args()
    
    # Parse platform list
    platforms = [p.strip() for p in args.platform.split(',')]
    
    # Process each platform
    for platform in platforms:
        print(f"\nProcessing platform: {platform}")
        
        # Generate file path
        ditamap_path = get_ditamap_path(platform)
        
        if not ditamap_path.exists():
            print(f"Error: File not found: {ditamap_path}")
            continue
        
        print(f"File path: {ditamap_path}")
        
        try:
            # Create reorganizer
            reorganizer = DitamapReorganizer(args.name_groups, platform)
            
            # Check key consistency
            print("Checking key consistency...")
            is_consistent, error_msg = reorganizer.check_key_consistency(str(ditamap_path))
            
            if not is_consistent:
                print(f"Error: {error_msg}")
                print(f"Skipping reorganization for platform {platform}")
                continue
            
            print("Key consistency check passed")
            
            # Perform reorganization
            print("Starting reorganization...")
            reorganizer.reorganize_ditamap(str(ditamap_path))
            print(f"Completed: {platform}")
            
        except Exception as e:
            print(f"Error: Failed to process platform {platform}: {e}")
            import traceback
            traceback.print_exc()
            continue
    
    print("\nAll platforms processed")


if __name__ == '__main__':
    main()
