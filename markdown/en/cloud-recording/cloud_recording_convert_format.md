---
title: Convert File Format after a Composite Recording
platform: All Platforms
updatedAt: 2021-02-20 09:26:37
---
## Overview

You can use the Format Converter script to convert between different audio and video file formats. The script supports the following file formats:

- Audio: MP3, WAV, and AAC
- Video: MP4 and TS

The script cannot convert an audio file into a video file and vice versa.

## Prerequisites

Server: Physical or virtual

System:

- Ubuntu 14.04 and later x64
- CentOS 6.5 and later (7.0 recommended) x64

Programming language: Python 2.7 and later

### File preparation

Ensure that you have downloaded all the files to convert to your local server. The script does not support converting files on any third-party cloud storage.

## Transcoding steps

### 1. Get the Format Converter script

Download the Agora Format Converter script and decompress it. Find `format_convert.py` in the `tools` folder. 

### 2. Execute the Format Converter script

Use the following command:

```
python format_convert.py <directory> <source_format> <destination_format>
```

Where:

- `directory`: Directory of the source files
- `source_format`: Format of the source files. `source_format` must be in lowercase, that is:
  - Audio: `mp3`, `wav`, or `aac`
  - Video: `mp4` or `ts`
- `destination_format`: Format to which you want to convert the source files. `destination_format` must be in lowercase, that is:
- - Audio: `mp3`, `wav`, or `aac`
  - Video: `mp4` or `ts`

When you run the command, the script will search for all the files in the specified format in the directory and convert them to the target format. The names of the converted files are the same as the source files, except for the suffix.

## Example

To convert all the MP4 files under `/home/testname/testfolder` to TS formats, use the following command:

```
python format_convert.py /home/testname/testfolder/ mp4 ts
```