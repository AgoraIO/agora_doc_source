---
title: 推流到 CDN
platform: iOS
updatedAt: 2019-10-29 11:57:28
---
## 功能描述

旁路推流功能用于将主播的上行音频流转化为 RTMP 流分发，供 Web 端或流媒体播放器端收听。

> 请联系 [sales@agora.io](mailto:sales@agora.io) 开通推流功能。


声网提供的 CDN 旁路推流方案主要基于以下 API 进行推流、外部输入音频源、转码设置：

- [`addPublishStreamUrl`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/addPublishStreamUrl:transcodingEnabled:)
- [`removePublishStreamUrl`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/removePublishStreamUrl:)
- [`setLiveTranscoding`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setLiveTranscoding:)

声网的 CDN 推流方案具有以下优点：

- 能够随时启动或停止推流
- 增加了控制信息
- 能够在不间断推流的同时增减推流地址
- 通过回调接口掌握推流成功与否
- 较少的接口便于客户快速升级。


## 推流到 CDN

你需要联系 [sales@agora.io](mailto:sales@agora.io) 开通推流功能。

> 声网今后将在 Dashboard 提供自助服务。

- 主播需要通过 `addPublishStreamUrl` 接口指定推流地址。推流地址可以在开始推流后动态增删。
- 主播需要在 `joinChannel` 成功后通过 `setLiveTranscoding` 接口定义转码参数和设置（RTMP 画布大小等信息）。CDN 音频推流时仍需设置一个 16 &times; 16 的最小视窗。

### Objective-C 示例代码：

```objective-c
//CDN 转码设置
AgoraLiveTranscodingUser *user = [[AgoraLiveTranscodingUser alloc] init];
user.uid = 12345;
user.rect = CGRectMake(0, 0, 16, 16);
user.audioChannel = 0;

AgoraRtcEngineKit *rtcEngine = [AgoraRtcEngineKit sharedEngineWithAppId:@"" delegate:nil];
AgoraLiveTranscoding *transcoding = [[AgoraLiveTranscoding alloc] init];
transcoding.audioSampleRate = AgoraAudioSampleRateType44100;
transcoding.audioChannels = 2;
//config.audioBitrate
transcoding.size = CGSizeMake(16, 16);
transcoding.videoFramerate = 15;
transcoding.videoCodecProfile = AgoraVideoCodecProfileTypeHigh;
transcoding.transcodingUsers = @[user];

[rtcEngine setLiveTranscoding:transcoding];
```

```objective-c
// 添加推流地址
// transcodingEnabled: 是否启用转码功能。如启用，需要先通过 setLiveTranscoding 接口设置转码参数
[rtcEngine addPublishStreamUrl:streamUrl transcodingEnabled:NO];
```

```objective-c
// 删除推流地址
[rtcEngine removePublishStreamUrl:streamUrl];
```