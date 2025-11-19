#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Example: How to use format_params module in other scripts.

This example demonstrates how to integrate the format_params functionality
into your own scripts.
"""

import json
from format_params import format_params_in_json


def example_1_basic_usage():
    """Example 1: Basic usage - format a file in place."""
    print("=" * 80)
    print("Example 1: Basic Usage")
    print("=" * 80)
    
    # Create a test file
    test_data = {
        'api': {
            'testMethod': {
                'params': {
                    'windows': ['param1', 'param2', 'param3'],
                    'android': ['param1', 'param2']
                }
            }
        }
    }
    
    # Save with default formatting (multi-line)
    with open('example_test.json', 'w', encoding='utf-8') as f:
        json.dump(test_data, f, indent=4, ensure_ascii=False)
    
    print("\nBefore formatting:")
    with open('example_test.json', 'r', encoding='utf-8') as f:
        print(f.read())
    
    # Format the file
    format_params_in_json('example_test.json')
    
    print("\nAfter formatting:")
    with open('example_test.json', 'r', encoding='utf-8') as f:
        print(f.read())
    
    # Clean up
    import os
    os.remove('example_test.json')
    print("\nTest file cleaned up")


def example_2_save_to_new_file():
    """Example 2: Save formatted output to a new file."""
    print("\n" + "=" * 80)
    print("Example 2: Save to New File")
    print("=" * 80)
    
    # Create a test file
    test_data = {
        'data': {
            'items': ['item1', 'item2', 'item3'],
            'values': ['value1', 'value2']
        }
    }
    
    with open('example_input.json', 'w', encoding='utf-8') as f:
        json.dump(test_data, f, indent=4, ensure_ascii=False)
    
    print("\nOriginal file: example_input.json")
    
    # Format and save to new file
    format_params_in_json('example_input.json', 'example_output.json')
    
    print("\nFormatted file: example_output.json")
    with open('example_output.json', 'r', encoding='utf-8') as f:
        print(f.read())
    
    # Clean up
    import os
    os.remove('example_input.json')
    os.remove('example_output.json')
    print("\nTest files cleaned up")


def example_3_integrate_in_workflow():
    """Example 3: Integrate into a processing workflow."""
    print("\n" + "=" * 80)
    print("Example 3: Integrate into Workflow")
    print("=" * 80)
    
    # Simulate a workflow that generates JSON with params
    def process_data_and_save():
        """Simulate data processing that generates params."""
        data = {
            'api': {
                'method1': {
                    'name': 'Method 1',
                    'params': {
                        'platform1': ['arg1', 'arg2'],
                        'platform2': ['arg1', 'arg2', 'arg3']
                    }
                },
                'method2': {
                    'name': 'Method 2',
                    'params': {
                        'platform1': ['param1'],
                        'platform2': ['param1', 'param2']
                    }
                }
            }
        }
        
        # Save the data
        output_file = 'workflow_output.json'
        with open(output_file, 'w', encoding='utf-8') as f:
            json.dump(data, f, indent=4, ensure_ascii=False)
        
        return output_file
    
    print("\nStep 1: Process data and save to JSON...")
    output_file = process_data_and_save()
    
    print("\nStep 2: Format params arrays...")
    format_params_in_json(output_file)
    
    print("\nStep 3: Verify formatted output:")
    with open(output_file, 'r', encoding='utf-8') as f:
        content = f.read()
        # Check if arrays are on single lines
        if '"platform1": [' in content and '\n' not in content.split('"platform1": [')[1].split(']')[0]:
            print("✓ Arrays are correctly formatted to single line")
        else:
            print("✗ Arrays are still multi-line")
    
    # Clean up
    import os
    os.remove(output_file)
    print("\nTest file cleaned up")


def main():
    """Run all examples."""
    print("\n" + "=" * 80)
    print("Format Params Module - Usage Examples")
    print("=" * 80)
    
    try:
        example_1_basic_usage()
        example_2_save_to_new_file()
        example_3_integrate_in_workflow()
        
        print("\n" + "=" * 80)
        print("All examples completed successfully!")
        print("=" * 80)
        
    except Exception as e:
        print(f"\nError running examples: {e}")
        import traceback
        traceback.print_exc()


if __name__ == "__main__":
    main()

