#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Format params arrays in name_groups.json to single line format.

This script reads a JSON file and reformats all params arrays from multi-line
format to single-line format for better readability.

Example:
    Before:
        "params": {
            "windows": [
                "param1",
                "param2",
                "param3"
            ]
        }
    
    After:
        "params": {
            "windows": ["param1", "param2", "param3"]
        }
"""

import json
import re
import logging
import sys

# Configure logging
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')
logger = logging.getLogger(__name__)


def format_params_in_json(input_file: str, output_file: str = None) -> None:
    """
    Format params arrays in JSON file to single line.
    
    Args:
        input_file: Input JSON file path
        output_file: Output JSON file path (if None, overwrites input file)
    """
    if output_file is None:
        output_file = input_file
    
    try:
        # Load JSON to validate it
        logger.info(f"Loading JSON file: {input_file}")
        with open(input_file, 'r', encoding='utf-8') as f:
            data = json.load(f)
        
        # Save with default formatting first
        logger.info(f"Saving JSON with default formatting...")
        with open(output_file, 'w', encoding='utf-8') as f:
            json.dump(data, f, indent=4, ensure_ascii=False)
        
        # Read the file content
        with open(output_file, 'r', encoding='utf-8') as f:
            content = f.read()
        
        # Pattern to match array values that span multiple lines
        # This pattern matches arrays like:
        #   "platform": [
        #       "param1",
        #       "param2"
        #   ]
        params_pattern = r'"([^"]+)": \[\s*\n(\s*"[^"]*",?\s*\n)*\s*\]'
        
        def format_params_array(match):
            """
            Format a multi-line array to single line.
            
            Args:
                match: Regex match object
                
            Returns:
                Formatted single-line array string
            """
            # Extract the matched text
            matched_text = match.group(0)
            key_name = match.group(1)
            
            # Extract all values using regex
            values = re.findall(r'"([^"]*)"', matched_text)
            # Remove the key name from values (it's captured as the first match)
            values = [val for val in values if val != key_name]
            
            # Format as single line array
            if values:
                formatted_array = '["' + '", "'.join(values) + '"]'
            else:
                formatted_array = '[]'
            
            return f'"{key_name}": {formatted_array}'
        
        # Count matches before formatting
        matches_before = len(re.findall(params_pattern, content))
        
        # Apply the formatting
        logger.info(f"Formatting {matches_before} multi-line arrays to single line...")
        content = re.sub(params_pattern, format_params_array, content)
        
        # Write the formatted content back
        with open(output_file, 'w', encoding='utf-8') as f:
            f.write(content)
        
        logger.info(f"Successfully formatted params arrays in {output_file}")
        logger.info(f"Formatted {matches_before} arrays")
        
        if output_file != input_file:
            logger.info(f"Output saved to: {output_file}")
        else:
            logger.info(f"File updated in place: {output_file}")
        
    except json.JSONDecodeError as e:
        logger.error(f"Invalid JSON file: {e}")
        sys.exit(1)
    except FileNotFoundError:
        logger.error(f"File not found: {input_file}")
        sys.exit(1)
    except Exception as e:
        logger.error(f"Error formatting params: {e}")
        sys.exit(1)


def main():
    """Main function."""
    import argparse
    
    parser = argparse.ArgumentParser(
        description='Format params arrays in JSON file to single line format',
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
Examples:
  # Format name_groups.json in place
  python format_params.py name_groups.json
  
  # Format and save to a different file
  python format_params.py name_groups.json -o name_groups_formatted.json
  
  # Format name_groups_overload.json in place
  python format_params.py name_groups_overload.json
        """
    )
    
    parser.add_argument(
        'input_file',
        help='Input JSON file path'
    )
    
    parser.add_argument(
        '-o', '--output',
        dest='output_file',
        help='Output JSON file path (default: overwrite input file)',
        default=None
    )
    
    args = parser.parse_args()
    
    logger.info("=" * 80)
    logger.info("Starting params array formatting...")
    logger.info("=" * 80)
    
    format_params_in_json(args.input_file, args.output_file)
    
    logger.info("=" * 80)
    logger.info("Formatting completed!")
    logger.info("=" * 80)


if __name__ == "__main__":
    main()

