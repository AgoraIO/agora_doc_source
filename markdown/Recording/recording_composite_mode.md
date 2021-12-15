---
title: 合流录制
platform: All Platforms
updatedAt: 2021-01-13 07:51:40
---

## 功能描述

本地服务端录制支持两种模式：

- 单流录制模式：（默认录制模式）分开录制频道内每个 UID 的音频流和视频流。每个 UID 均有其对应的音频文件和视频文件。
- 合流录制模式：频道内所有或指定 UID 的音视频混合录制为一个音视频文件；或频道内所有或指定 UID 的音频混合录制为一个纯音频文件，所有或指定 UID 的视频混合录制为一个纯视频文件。

本文介绍如何通过命令行的方式进行**合流录制**。

阅读本文前，请确保你已经完成录制 SDK 的环境准备和集成工作并且了解如何使用命令行开始录制，详见[集成客户端](./recording_integrate_cpp)和[命令行录制](./recording_cmd_cpp)。单流或合流模式的设置必须在开始录制的时候完成，不支持在录制开始后切换模式。请参阅[单流录制模式和合流录制模式的区别](https://docs.agora.io/cn/faq/recording_mode)来决定应使用哪种模式。

> 为方便起见，本文我们假设频道内每个用户都发送音频和视频。如果某个用户没有发送音频或视频，例如直播频道中的观众，一般不会生成该用户的音频或视频录制文件（Web 端例外）。

## 实现方法

### 启用合流录制

在开始录制时将参数 `isMixingEnabled` 设为 1 即可使用合流模式录制。

根据录制内容的不同，录制生成的文件如下表所示：

| 录制内容       | 参数设置                                  | 录制生成文件        |
| :------------- | :---------------------------------------- | :------------------ |
| 仅录制音频     | `--isAudioOnly 1 --isMixingEabled 1`      | 一个 AAC 音频文件   |
| 仅录制视频     | `--isVideoOnly 1 --isMixingEnabled 1`     | 一个 MP4 视频文件   |
| 同时录制音视频 | `--isMixingEnabled 1 --mixedVideoAudio 2` | 一个 MP4 音视频文件 |

> - 合流录制模式下，如果同时录制音视频，我们建议同时将 `mixedVideoAudio` 参数设为 2，把音频文件和视频文件实时混合成一个既有音频也有视频的 MP4 文件。
> - 在仅录制音频或仅录制视频时请不要将 `mixedVideoAudio` 设为 2。

### 设置音视频编码配置

合流模式下，你可以自己设置录制文件的音视频编码配置。

#### 音频编码配置

设置 `audioProfile` 参数，设置音频编码模式、采样率、声道数和码率。

- 0：默认音频设置，采样率 48 KHz，单声道，编码码率为 48 Kbps。
- 1：高音质，采样率 48 KHz，单声道，编码码率 128 Kbps。
- 2：高音质立体声，采样率 48 KHz，双声道，编码码率 192 Kbps。

#### 视频编码配置

设置 `mixResolution` 参数，格式为：width, high, fps, Kbps，从左至右分别对应合流视频的宽、高、帧率和码率。默认的视频编码配置为 `640,360,15,500`。推荐的视频编码配置请参考 [分辨率、帧率和码率对照表](https://docs.agora.io/cn/faq/recording_video_profile)。

### 设置合流布局

在合流模式录制多人视频时，你可以通过 layoutMode 参数设置频道内所有发流用户画面的大小及其在视频画布上的位置，进行[合流布局](./recording_layout_guide)。默认设置为 0（悬浮布局）。

## 命令行示例

以下命令行为合流录制模式下录制一个直播频道里的音视频，音频编码配置为高音质，视频编码配置为 640,480,15,1000，合流布局设为 1（自适应布局）。

```
./recorder_local --appId <你的 App ID> --channel <待录制的频道名> --channelProfile 1 --uid 0 --appliteDir ~/Agora_Recording_SDK_for_Linux_FULL/bin --isMixingEnabled 1 --mixedVideoAudio 2 --audioProfile 1 --mixResolution 640,480,15,1000 --layoutMode 1
```
