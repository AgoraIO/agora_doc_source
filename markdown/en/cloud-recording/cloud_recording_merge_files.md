---
title: Merge Audio and Video Files after an Individual Recording
platform: All Platforms
updatedAt: 2021-02-20 09:26:13
---
## Overview

In individual recording mode, Agora Cloud Recording generates one audio and/or video file for each UID. If you want to merge each UID's audio and video files into one file, you can use our Audio & Video File Merging script.

## Prerequisites

Recommended systems for transcoding:

- Ubuntu 14.04 and later x64
- CentOS 6.5 and later (7.0 recommended) x64

To run the script, you need to install Python 2, version 2.7 or later.

### File preparation

- Use Agora Cloud Recording to generate the audio and/or video files. The transcoding will fail if any of the recorded files is missing.
- Ensure that the recorded files are stored in an accessible directory.

## Transcoding steps

### 1. Get the merging script

Download the [Agora Audio & Video File Merging](https://download.agora.io/acrsdk/release/Agora_Cloud_Recording_Tools_v1.14.1_20201026-1603685854_1361.tar.gz) script and decompress it. Find `ffmpeg.tar.gz` and `convert.py`. Decompress `ffmpeg.tar.gz`, and make sure it is in the same directory as `convert.py.`

<div class="alert note">To avoid compatibility issues, Agora suggests that you use the FFmpeg binary in the zipped file or install FFmpeg 3.3.</div>

### 2. Execute the Audio & Video File Merging script

You can start transcoding the files after you set the parameters.

#### Transcoding options

You can get the options with the `python convert.py` command.

![](https://web-cdn.agora.io/docs-files/1569831552391)

 Or you can refer to the following table to learn about the transcoding options:

| Option | Description                                                  |
| :----- | :----------------------------------------------------------- |
| `-f`   | Specify the directory of the recorded files to be transcoded. If the directory contains files generated during several recording instances, the transcoding script transcodes all the files by the order of the recording instances. |
| `-m`   | Set the transcoding mode: See [-m Options](#-m) for details.<li>`0`: (Default) Merge the audio and video files of the same UID based on the recording segment.</li><li>`1`: Merge the audio and video files of the same UID into one file.</li><li>`2`: Merge the audio files of the same UID into one audio file.</li><li>`3`: Merge the video files of the same UID into one video file (no audio).</li> |
| `-s`   | Set whether or not to include the period when a user is absent from a channel. If you do not set `-s`,  which is the default mode, then if a user leaves the channel and rejoins it later, the period when the user is absent is included and displayed as the last frame before the user leaves. For example, if a user is in the channel for 2 minutes, then leaves the channel for 30 minutes, and rejoins the channel for another 2 minutes for a total recording time of 34 minutes, the recording will display the last frame before the user leaves for 30 minutes. If you set `-s`, then if a user leaves the channel and rejoins it later, the recording will not include the period when the user is absent. Do not set this parameter when `-m` is `0`. |
| `-p`   | Set the frame rate of the transcoded video. The default rate is 15 fps. The value range is from 5 fps to 120 fps. If `-p` is less than 5 fps, the video will be transcoded with the frame rate of 5 fps. For more details, see [How do I set the video profile of the recorded video?](https://docs.agora.io/en/faq/recording_video_profile) |
| `-r`   | Set the resolution of the transcoded video in the format of “width height”, for example, `-r 640 360`. For more details, see [How do I set the video profile of the recorded video?](https://docs.agora.io/en/faq/recording_video_profile) |

<a id="-m">**-m options**</a>

Before introducing the `-m` options, we'll first explain the concept of a recording segment. A recording segment starts when Agora Cloud Recording starts recording a UID and ends when Agora Cloud Recording stops recording a UID.

Agora Cloud Recording starts recording a UID only when all the following conditions are met:

- The UID joins the channel and starts sending audio or video streams.
- You start Agora Cloud Recording

Agora Cloud Recording stops recording a UID as long as one of the following conditions is met:

- The UID stops sending streams and does not send streams again within 15 seconds
- The UID leaves the channel and does not rejoin within 15 seconds
- You stop Agora Cloud Recording

See [Example](#example) for more information about the recording segment. 

Now, let's see the behaviors of different `-m` options:

> We assume that each UID in the channel generates several audio files and video files.

- `0`: Merge the audio and video files of the same UID based on the recording segment. One recording segment of one UID corresponds to one merged file, named as `UID_timestamp_av.mp4`. In the filename, `timestamp` is the time when Agora Cloud Recording starts recording. If Agora Cloud Recording starts to record the audio and video at different times, `timestamp` is the earlier one of the two starting times. The time zone of `timestamp` is UTC+0. The `timestamp` parameter consists of the year, month, day, hour, minute, second, and millisecond. For example, `100_20190611073246073_av.mp4` is a merged file for UID 100 and the start time of the recording is 07:32:46.073 a.m., June 11, 2019.
- `1`: Merge the audio and video files of the same UID into one file. One UID corresponds to one file, named as `UID_0_merge_av.mp4`.
- `2`: Merge the audio files of the same UID into one audio file. One UID corresponds to one file, named as `UID_0_merge.m4a`. The file uses AAC encoding. You can use the [Agora Format Converter script](/en/cloud-recording/cloud_recording_convert_format) to transcode the file to other formats, such as MP3.
- `3`: Merge the video files of the same UID into one video file (no audio). One UID corresponds to one file, named as `UID_0_merge.mp4`.

### <a name="example"></a>Example

The following examples show different merged files with different `-m` settings.

Suppose that two users, with UIDs 100 and 125, stay in the channel, and you start Agora Cloud Recording in individual recording mode. UID 100 leaves the channel and rejoins the channel in 30 seconds, thus causing two segments in this recording instance. When the recording ends, UID 100 has four recorded files: one audio file and one video file for each of the two segments. UID 123 has one audio file and one video file.

To merge the audio and video files of the same UID into one file, use the following command:

```
python convert.py -f <directory of the files to be transcoded> -m 1 -s -p 30 -r 640 360
```

Two files are generated after transcoding: `100_0_merge_av.mp4` and `123_0_merge_av.mp4`. The 30 seconds when UID 100 is absent is not included in the merged file. To include the time interval, do not set `-s`.

To merge the audio and video files of the same UID based on the recording segment, use the following command:

```
python convert.py -f <directory of the files to be transcoded> -m 0 -p 30 -r 640 360
```

Three files are generated after transcoding: `100_timestamp1_av.mp4`, `100_timestamp2_av.mp4`, and `123_timestamp1_av.mp4`.

A `convert-done.txt` file is generated after the transcoding is complete. Once the transcoding script is used, a `convert.log` file is generated in the same directory as the audio and video files upon completion of the transcoding.

The transcoded MP4 file supports most mainstream media players. See the following table for details:

| Operating System | Media Players                                                |
| :--------------- | :----------------------------------------------------------- |
| Linux            | <li>VLC</li><li>ffplayer</li>                                                  |
| Windows          | <li>Media Player</li><li>KM Player</li><li>VLC Player</li><li>Chrome (49.0.2623 or later)</li>   |
| macOS            | <li>QuickTime Player</li><li>Movist</li><li>MPlayerX</li><li>Chrome (49.0.2623 or later)</li><li>Safari (11.0.3 or later)</li> |
| iOS              | <li>iOS default player</li><li>KMPlayer</li><li>Safari (9.0 or later)</li>              |
| Android          | <li>Android default player</li><li>MXPlayer</li><li>VLC</li><li>KMPlayer</li><li>Chrome (9.0.2623 or later)</li> |