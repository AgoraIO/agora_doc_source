# DITA Map Reorganization Script

This script reorganizes DITA Map files from function-based classification to parent class-based classification. It supports batch processing for multiple platforms, uses lxml for XML parsing, and validates key consistency before reorganization.

## Features

- **Parent Class-based Organization**: Reorganizes APIs by their parent classes instead of functional categories
- **Multi-platform Support**: Process multiple platforms in a single run
- **Key Consistency Validation**: Checks that API keys in ditamap files match those in name_groups before reorganization
- **Automatic File Path Generation**: Automatically generates file paths based on platform names
- **Preserves Structure**: Maintains Configurations section and tail references (rtc_api_data_type.dita, rtc_api_sunset.dita)

## Requirements

- Python 3.6+
- lxml library

Install dependencies:
```bash
pip install lxml
```

## Usage

### Basic Usage

Process a single platform:
```bash
python scripts/reorg-ditamap/reorg_ditamap.py --platform electron
```

Process multiple platforms:
```bash
python scripts/reorg-ditamap/reorg_ditamap.py --platform electron,rn,flutter
```

### Command Line Arguments

- `--platform` (required): Target platform(s), supports multiple platforms separated by commas
  - Examples: `electron`, `rn`, `flutter`, `unity`, `electron,rn,flutter`
- `--name-groups` (optional): Path to name_groups file
  - Default: `scripts/reorg-ditamap/name_groups_framework.json`

### Examples

```bash
# Process Electron platform
python scripts/reorg-ditamap/reorg_ditamap.py --platform electron

# Process React Native and Flutter platforms
python scripts/reorg-ditamap/reorg_ditamap.py --platform rn,flutter

# Process Unity with custom name_groups file
python scripts/reorg-ditamap/reorg_ditamap.py --platform unity --name-groups path/to/custom_name_groups.json
```

## How It Works

1. **Loads name_groups data**: Reads the `name_groups_framework.json` file to get API parent class mappings
2. **Validates key consistency**: Compares API keys in the ditamap file with those in name_groups for the target platform
3. **Groups APIs by parent class**: Organizes APIs according to their parent classes
4. **Reorganizes ditamap structure**:
   - Preserves the Configurations section
   - Preserves tail references (rtc_api_data_type.dita, rtc_api_sunset.dita)
   - Reorganizes APIs by parent class in predefined order
   - Adds `chunk="to-content"` attribute to parent class topicrefs
   - Adds `toc="no"` attribute to API topicrefs

## File Structure

The script expects:
- **Input files**: `en-US/dita/RTC-AIDOC-FRAMEWORK/RTC_NG_API_{Platform}.ditamap`
- **Name groups file**: `scripts/reorg-ditamap/name_groups_framework.json`

Output files overwrite the input files (in-place modification).

## Parent Class Order

The script uses a predefined order for parent classes based on the structure found in RTC-NG ditamap files across different platforms:

1. Core RTC Engine classes (IRtcEngine, IRtcEngineEx, IRtcEngineEventHandler)
2. Media Player classes
3. Observer classes
4. Device Manager classes
5. Media Engine
6. Direct CDN Streaming
7. Spatial Audio classes
8. Media Recorder classes
9. Music Content Center (CN only)
10. Platform-specific classes (RN, Flutter, Unity)

## Error Handling

- **File not found**: If the ditamap file doesn't exist, the script skips that platform
- **Key inconsistency**: If API keys don't match between ditamap and name_groups, reorganization is skipped with detailed error messages
- **Missing parent_class**: APIs without a parent_class are skipped with a warning

## Notes

- The script modifies files in-place. Make sure to backup your files before running the script
- Key consistency check must pass before reorganization proceeds
- Only APIs supported by the target platform (as defined in name_groups) are included in the output
