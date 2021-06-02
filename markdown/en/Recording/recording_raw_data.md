---
title: Get the Raw Data
platform: All Platforms
updatedAt: 2020-03-11 10:00:40
---
The Agora On-premise Recording SDK supports raw data in individual recording, and raw data for mixed audio in composite recording.

For details on the recording profile, see [Set the Recording Profile](/en/Recording/recording_profile).

## Raw data in individual recording

Set <code>isMixingEnabled</code> = 0 to start individual recording.

Choose the different types of files by setting the parameters according to the following table:：

| **Raw Data**        | **Parameter and File**                                      |
| ------------------- | ------------------------------------------------------------ |
| Raw audio data  | <li>`getAudioFrame = 1`: AAC file<li>`getAudioFrame = 2`: PCM file |
| Raw video data  | <li>`getVideoFrame = 1`: H.264 file<li>`getVideoFrame = 2:` YUV frame file<li>`getVideoFrame = 3`: JPG frame file<li>`getVideoFrame = 4`: JPG file<li>`getVideoFrame = 5`: JPG file + MPEG-4 video file |

> The Web supports raw data in YUV format only, not in H.264 format.

## Raw audio data in composite recording
	
Set <code>isMixingEnabled</code> = 1 to start composite recording.

The Agora On-premise Recording SDK supports raw data for mixed audio, and generates a PCM file.

| **Raw Data**        |**Parameter and File**                                             |
| ------------------- | ------------------------------------------------------------ |
| Raw audio data         | `getAudioFrame = 3`：PCM file |
