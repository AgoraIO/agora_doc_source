---
title: Composite Recording
platform: Linux
updatedAt: 2021-01-13 07:53:53
---
## Overview

The On-premise Recording SDK supports two recording modes:

- Individual recording mode: This is the default recording mode. The SDK generates one audio and/or video file for each UID. 
- Composite recording mode: The audio of all UIDs in the channel is mixed into an audio file and the video of all UIDs is mixed into a video file. 

This page shows how to record audio and/or video in **composite recording mode** by the command line.

Before proceeding, ensure that you have compiled the Agora Recorder Demo and know how to record a call by the command line. For more information, see [Record by Command Line](https://docs-preview.agoralab.co/en/Recording/recording_cmd_cpp). You must select either individual recording mode or composite recording mode when you start the recording. You cannot switch between the two modes after a recording starts. 

See [Differences between individual recording mode and composite recording mode](https://docs.agora.io/en/faq/recording_mode) to decide which mode you should use.

> For simplicity, we assume that every UID in the channel sends both audio and video streams. If a UID neither sends audio nor video, such as the audience in a live broadcast, there will be no file for this UID.

## Implementation

### Enable composite recording mode

When starting recording, set the `isMixingEnabled` parameter as 1 to enable composite recording mode. 

The recording files and formats depend on your choice of recording audio, video, or both.

|                              | Setting                                   | Recording files and formats                      |
| :--------------------------- | :---------------------------------------- | :----------------------------------------------- |
| Record only audio            | `--isAudioOnly 1`<br> `--isMixingEnabled 1`     | One audio file in AAC format                     |
| Record only video (no audio) | `--isVideoOnly 1` <br>`--isMixingEnabled 1`     | One video file in MP4 format                     |
| Record both audio and video  | `--isMixingEnabled 1` <br>`--mixedVideoAudio 2` | One file in MP4 format with both audio and video |

> - In composite recording mode, if you choose to record both audio and video, we suggest setting the  `mixedVideoAudio` parameter as 2 to mix the audio and video in an MP4 file in real time.
> - In composite recording mode, if you choose to record only audio/video, do not set the  `mixedVideoAudio` parameter as 2. 

### Set audio/video profile

In composite recording mode, you can set the audio and video profile of the recording file.

#### Audio profile

You can set the `audioProfile` parameter as the following values:

- `0`: (Default) Sample rate of 48 KHz, communication encoding, mono, and a bitrate of up to 48 Kbps.
- `1`: Sample rate of 48 KHz, music encoding, mono, and a bitrate of up to 128 Kbps.
- `2`: Sample rate of 48 KHz, music encoding, stereo, and a bitrate of up to 192 Kbps.

#### Video profile

You can set the `mixResolution` parameter, including the width, height, frame rate, and bitrate. The default setting is `640,360,15,500.` We recommend you set the video profile according to the [Video Profile Table](https://docs.agora.io/en/faq/recording_video_profile).

### Set video layout

In composite recording mode, you can use the `layoutMode` parameter to set the video layout and arrange the size and position of the region for each user. The default value is 0 (Floating Layout). For more information, see [Set Video Layout](./recording_layout_guide).

## Example

The following example shows how to record both audio and video in a live broadcast channel in composite recording mode. 

```
./recorder_local --appId <Your App ID> --channel <The name of the channel to be recorded> --channelProfile 1 --uid 0 --appliteDir ~/Agora_Recording_SDK_for_Linux_FULL/bin --isMixingEnabled 1 --mixedVideoAudio 2 --audioProfile 1 --mixResolution 640,480,15,1000 --layoutMode 1
```