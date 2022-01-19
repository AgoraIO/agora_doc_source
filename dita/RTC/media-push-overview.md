# 旁路推流概述

Agora 针对音视频直播场景提供旁路推流服务，你可以通过该服务订阅频道内的音视频流，将音视频流转码后（或选择不转码），通过标准协议（如 RTMP）推送到 CDN，丰富直播音视频流的分发渠道。

你可以通过 RESTful API 在服务端实现旁路推流，也可以通过 [Agora RTC SDK](https://docs.agora.io/cn/AgoraPlatform/term_agora_rtc_sdk) 提供的 API [在客户端实现旁路推流](https://docs.agora.io/cn/Interactive%20Broadcast/cdn_streaming_android?platform=Android)。


## 功能描述

Agora 旁路推流 RESTful API 支持以下功能：

### 转码

旁路推流的转码功能本质是一个编解码的功能，用于将多路音视频流合成一路音视频流，可以保障多位主播在直播时的同步性。使用转码功能时，你可以自定义以下内容：

| 字段                                           | 描述                                                         |
| :--------------------------------------------- | :----------------------------------------------------------- |
| transcodeOptions.audioOptions.sampleRate       | 音频编码采样率                                               |
| transcodeOptions.audioOptions.bitrate          | 音频编码码率                                                 |
| transcodeOptions.audioOptions.codecProfile     | 音频编解码规格。             |
| transcodeOptions.audioOptions.audioChannels    | 音频声道数                                                   |
| transcodeOptions.videoOptions.bitrate          | 视频编码码率                                                 |
| transcodeOptions.videoOptions.frameRate        | 视频编码帧率                                                 |
| transcodeOptions.videoOptions.gop              | 视频 GOP                                                     |
| transcodeOptions.videoOptions.codecProfile     | 视频的编码规格。       |
| transcodeOptions.videoOptions.seiExtraInfo     | 输出视频中携带的用户 SEI 信息。用于向 CDN 发送用户自定义的 SEI 信息。 |
| transcodeOptions.videoOptions.canvas           | 每个主播的视频画面尺寸及背景色                               |
| transcodeOptions.videoOptions.layout           | 多个主播的视频画面布局                                       |
| transcodeOptions.videoOptions.layout.ImageView | 直播水印                                                     |

> 如果是单主播场景，你可以选择不转码推流。

###  旁路推流

你可以使用旁路推流服务将单主播或多主播的音视频流通过标准协议（如 RTMP、RTMPS）推送到 CDN。

根据实际场景，旁路推流工作流如下：

多主播 ➡ Agora SD-RTN™ ➡ 推流服务器（转码并推流或不转码推流） ➡ CDN

观众通过对应的 CDN 地址即可观看直播。
