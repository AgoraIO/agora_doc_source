---
title: 通话中质量监测
platform: iOS
updatedAt: 2021-03-05 02:46:01
---

## 功能描述

**加入频道后**，SDK 会每隔 **2 秒**自动触发通话质量相关的下述回调，你可以了解当前通话的网络质量、本地统计信息、音频质量和视频质量。

<div class="alert note">请确保已在你的项目中实现基本的实时音视频功能。详见
  <li>iOS: <a href="start_call_ios">开始音视频通话</a>或<a href="start_live_ios">开始互动直播</a></li>
  <li>macOS: <a href="start_call_mac">开始音视频通话</a>或<a href="start_live_mac">开始互动直播</a></li></div>

## 示例项目

Agora 在 GitHub 提供了一个开源的 API-Examples 示例项目，其中实现了通话中质量监测功能。你可以直接下载体验或查看其中的源代码：

- iOS：[JoinChannelVideo.swift](https://github.com/AgoraIO/API-Examples/blob/master/iOS/APIExample/Examples/Basic/JoinChannelVideo/JoinChannelVideo.swift)
- macOS：[JoinChannelVideo.swift](https://github.com/AgoraIO/API-Examples/blob/master/macOS/APIExample/Examples/Basic/JoinChannelVideo/JoinChannelVideo.swift)

<a name="1"></a>

## 上下行网络质量报告

`networkQuality` 回调向你报告当前通话中每个用户/主播的上下行 last mile 网络质量，详见[质量打分](./API%20Reference/cpp/namespaceagora_1_1rtc.html#aeaf419fcafaa4d58da8b6d8718e31891)。其中，last mile 是指你的设备到 Agora 边缘服务器的网络。上行 last mile 网络质量打分基于实际发送码率、上行网络丢包率、平均往返时延和上行网络抖动计算；下行 last mile 网络质量打分基于下行网络丢包率、平均往返时延和下行网络抖动计算。

> - 在通信场景下，每隔 2 秒你会收到频道内所有用户（包括你自己）的网络质量报告。
> - 在直播场景下，如果你是主播，每隔 2 秒你会收到频道内所有主播（包括你自己）的网络质量报告；如果你是观众，每隔 2 秒你会收到所有主播和你自己的网络质量报告。
> - 实际发送码率与目标发送码率的比值越高，该网络下的通话质量越好，该网络质量打分越高。
>   <a name="RTT"></a>
> - **平均往返时延**指的是多次往返时延的平均值。
>   <a name="2"></a>

## 统计信息报告

`reportRtcStats` 回调向你报告本地通话统计信息。你可以了解到通话时长、当前通话频道中的人数、当前系统的 CPU 使用率、当前 App 的 CPU 使用率和以下重要参数。

| 参数                                | 描述                                      | 备注                                                                                                                                         |
| ----------------------------------- | ----------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------- |
| `txBytes`/`rxBytes`                 | 累计发送/接收字节数。                     | 自加入频道后累计的字节数。                                                                                                                   |
| `txAudioBytes`/`rxAudioByte`        | 累计发送/接收音频字节数。                 | 自加入频道后累计的字节数。                                                                                                                   |
| `txVideoBytes`/`rxVideoBytes`       | 累计发送/接收视频字节数。                 | 自加入频道后累计的字节数。                                                                                                                   |
| `txKBitRate`/`rxKBitRate`           | 发送/接收码率。                           | 统计周期内实际发送/接收的码率。                                                                                                              |
| `txAudioKBitRate`/`rxAudioKBitRate` | 音频发送/接收码率。                       | 统计周期内实际发送/接收的码率。                                                                                                              |
| `txVideoKBitRate`/`rxVideoKBitRate` | 视频发送/接收码率。                       | 统计周期内实际发送/接收的码率。                                                                                                              |
| `lastmileDelay`                     | 本地客户端到 Agora 边缘服务器的网络延迟。 | <li>此处指的是[平均往返时延](#RTT)的一半，不是客户端到 Agora 边缘服务器的单向时延。<li>此处的网络延迟不区分音频和视频，是 UDP 包得到的数据。 |
| `txPacketLossRate`                  | 本地客户端到 Agora 边缘服务器的丢包率。   | <li>音频和视频上行丢包率中的较大值。<li>使用**抗丢包**技术前的丢包率。                                                                       |
| `rxPacketLossRate`                  | Agora 边缘服务器到本地客户端的丢包率。    | <li>音频和视频下行丢包率中的较大值。<li>使用**抗丢包**技术前的丢包率。                                                                       |

#### 示例代码

```swift
func rtcEngine(_ engine: AgoraRtcEngineKit, reportRtcStats stats: AgoraChannelStats) {
    videos[0].statsInfo?.updateChannelStats(stats)
}
```

<a name="3"></a>

## 音频质量报告

<a name="31"></a>

### 本地音频流统计信息报告

`localAudioStats` 回调向你报告本地设备发送音频流的统计信息。你可以了解到当前通话声道数（单声道或双声道）、发送音频的采样率和发送音频的码率。

> SDK 会每隔 2 秒自动触发本回调，发送音频的采样率指统计周期内发送音频的实际采样率，发送音频的码率指统计周期内发送音频码率的**平均**值。

#### 示例代码

```swift
func rtcEngine(_ engine: AgoraRtcEngineKit, localAudioStats stats: AgoraRtcLocalAudioStats) {
    videos[0].statsInfo?.updateLocalAudioStats(stats)
}
```

<a name="32"></a>

### 本地音频流状态监控

本地音频的状态发生改变时（包括本地麦克风录制状态和音频编码状态），SDK 会触发 `localAudioStateChange` 回调向你报告当前本地音频状态。当本地音频出现故障时，你可以通过错误码排查问题。
<a name="33"></a>

### 远端音频流统计信息报告

![](https://web-cdn.agora.io/docs-files/1565595137741)
`remoteAudioStats` 回调向你报告当前通话中每个远端用户/主播音频流的统计信息。你可以了解到每个远端用户/主播发送的音频流质量（详见[质量打分](./API%20Reference/cpp/namespaceagora_1_1rtc.html#aeaf419fcafaa4d58da8b6d8718e31891)）、声道数（单声道或双声道）和以下重要参数信息。

| 参数                    | 描述                                                                                     | 备注                                                                                                                           |
| ----------------------- | ---------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------ |
| `networkTransportDelay` | 音频发送端到接收端的网络延迟。                                                           | 图中阶段 2 + 3 + 4                                                                                                             |
| `jitterBufferDelay`     | 接收端到网络抖动缓冲端的网络延迟。                                                       | 图中阶段 5                                                                                                                     |
| `audioLossRate`         | 统计周期内，实际接收到的远端音频流丢帧率。                                               | <li>图中阶段 2 + 3 + 4 + 5<li>一个统计周期内，音频丢帧率达到 4% 计为一次音频**卡顿**。                                         |
| `receivedSampleRate`    | 统计周期内，接收到的远端音频流的采样率。                                                 |                                                                                                                                |
| `receivedBitrate`       | 统计周期内，接收到的远端音频流的**平均**码率。                                           |                                                                                                                                |
| `totalFrozenTime`       | 远端用户/主播在加入频道后发生音频**卡顿**的累计时长。                                    | <li>Agora 定义`totalFrozenTime` = 音频**卡顿**次数 &times; 2 &times; 1000 （毫秒）。<li>累计时长是**自加入频道后**累计的时长。 |
| `frozenRate`            | 远端用户/主播音频卡顿累计时长占音频**总有效时长**的百分比。                              | 音频**总有效时长**指的是远端用户/主播加入频道后，既没有停止发送音频流，也没有禁用音频模块的通话时长。                          |
| `qoeQuality`            | 接收远端音频时，本地用户的主观体验质量。                                                 |                                                                                                                                |
| `qualityChangedReason`  | 接收远端音频时，本地用户主观体验质量较差的原因。                                         |                                                                                                                                |
| `mosValue`              | 统计周期内，Agora 实时音频 MOS（平均主观意见分）评估方法对接收到的远端音频流的质量评分。 |                                                                                                                                |

`remoteAudioStats` 侧重报告远端音频流的全链路音频质量，更贴近你的主观感受。即使网络发生丢包，因为 FEC（Forward Error Correction）、重传恢复和带宽估计等**抗丢包**和拥塞控制技术，最终在接收端的音频丢帧率也可能不高，所以你感知到的音频质量也可能较好。

> - 在通信场景下，每隔 2 秒你会收到频道内所有远端用户（不包括你自己）的音频流统计信息。
> - 在直播场景下，如果你是主播，每隔 2 秒你会收到频道内所有远端主播（不包括你自己）的音频流统计信息；如果你是观众，每隔 2 秒你会收到频道内所有远端主播的音频流统计信息。
> - Agora **音频模块**指音频处理过程，而不是 SDK 中的模块实物。发送音频流时，音频模块指音频采样、前处理、编码等处理过程；接收音频流时，音频模块指音频解码、后处理、播放等处理过程。
> - 用户只能开启/禁用自己的音频模块。
> - Agora 默认一个统计周期内的的音频**卡顿**不会多于 1 次。

#### 示例代码

```swift
func rtcEngine(_ engine: AgoraRtcEngineKit, remoteAudioStats stats: AgoraRtcRemoteAudioStats) {
    videos.first(where: { $0.uid == stats.uid })?.statsInfo?.updateAudioStats(stats)
}
```

<a name="34"></a>

### 远端音频流状态监控

远端用户/主播音频状态发生改变时，SDK 会触发 `remoteAudioStateChangedOfUid` 回调向你报告远端音频流当前状态和状态改变的原因。

> - 在通信场景下，本回调向你报告频道内所有远端用户（不包括你自己）的音频流状态信息。
> - 在直播场景下，如果你是主播，本回调向你报告频道内所有远端主播（不包括你自己）的音频流状态信息；如果你是观众，本回调向你报告频道内所有远端主播的音频流状态信息。

<a name="4"></a>

## 视频质量报告

<a name="41"></a>

### 本地视频流统计信息报告

`localVideoStats` 回调向你报告本地设备发送视频流的统计信息。你可以了解视频编码宽/高和以下重要参数信息。

> 如果你此前调用 `enableDualStreamMode` 方法开启[双流模式](https://docs.agora.io/cn/Agora%20Platform/terms?platform=All%20Platforms#a-name-duala双流模式)，则本回调描述本地设备发送的视频大流的统计信息。
>
> | 参数                      | 描述                           | 备注                                                                                                                                                                                |
> | ------------------------- | ------------------------------ | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
> | `rendererOutputFrameRate` | 本地视频渲染器的输出帧率。     |                                                                                                                                                                                     |
> | `encoderOutputFrameRate`  | 本地视频编码器的输出帧率。     |                                                                                                                                                                                     |
> | `targetBitrate`           | 当前编码器的目标编码码率。     | 该码率为 SDK 根据当前网络状况预估的一个值。                                                                                                                                         |
> | `targetFrameRate`         | 当前编码器的目标编码帧率。     |                                                                                                                                                                                     |
> | `encodedBitrate`          | 视频编码码率。                 | 不包含丢包后**重传**视频等的视频码率。                                                                                                                                              |
> | `sentBitrate`             | 统计周期内，实际发送视频码率。 | 不包含丢包后**重传**视频等的视频码率。                                                                                                                                              |
> | `sentFrameRate`           | 统计周期内，实际发送视频帧率。 | 不包含丢包后**重传**视频等的视频帧率。                                                                                                                                              |
> | `encodedFrameCount`       | 视频发送的累计帧数。           | 自加入频道后的累计值。                                                                                                                                                              |
> | `codecType`               | 视频的编码类型。               | <li>`VIDEO_CODEC_VP8 = 1`: VP8<li>`VIDEO_CODEC_H264 = 2`: （默认值）H.264                                                                                                           |
> | `qualityAdaptIndication`  | 本次统计的视频质量自适应情况。 | 相比上次统计（2 秒前）视频质量（基于目标码率/`targetBitrate` 和目标帧率/`targetFrameRate`），本次视频质量的情况：<li>本地视频质量不变。<li>本地视频质量改善。<li>本地视频质量变差。 |

#### 示例代码

```swift
func rtcEngine(_ engine: AgoraRtcEngineKit, localVideoStats stats: AgoraRtcLocalVideoStats) {
    videos[0].statsInfo?.updateLocalVideoStats(stats)
}
```

<a name="42"></a>

### 本地视频流状态监控

本地视频的状态发生改变时，SDK 会触发 `localVideoStateChange` 回调向你报告当前本地视频状态。当本地视频出现故障时，你可以通过错误码排查问题。
<a name="43"></a>

### 远端视频流统计信息报告

![](https://web-cdn.agora.io/docs-files/1565596347727)
`remoteVideoStats` 回调向你报告当前通话中每个远端用户/主播的视频流的统计信息。你可以了解到每个远端用户/主播的视频宽/高和以下重要参数信息。

| 参数                      | 描述                                                  | 备注                                                                                                                            |
| ------------------------- | ----------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------- |
| `rxStreamType`            | 视频流类型。                                          | 视频大流或小流，详见[双流模式](https://docs.agora.io/cn/Agora%20Platform/terms?platform=All%20Platforms#a-name-duala双流模式)。 |
| `receivedBitrate`         | 统计周期内，实际接收到的远端视频码率。                |                                                                                                                                 |
| `packetLossRate`          | 统计周期内，实际接收到的远端视频流丢包率。            | <li>图中阶段 2 + 3 + 4<li> 此处指使用**抗丢包**技术之后的丢包率，比使用**抗丢包**技术前的丢包率更低。                           |
| `decoderOutputFrameRate`  | 远端视频解码器的输出帧率。                            |                                                                                                                                 |
| `rendererOutputFrameRate` | 远端视频渲染器的输出帧率。                            |                                                                                                                                 |
| `totalFrozenTime`         | 远端用户/主播在加入频道后发送视频**卡顿**的累计时长。 | 通话过程中，视频帧率设置不低于 5 fps 时，连续渲染的两帧视频之间间隔超过 500 ms，则计为一次视频**卡顿**。                        |
| `frozenRate`              | 远端用户/主播卡顿累计时长占视频有效时长的百分比。     | 视频**有效时长**指远端用户/主播加入频道后，既没有停止发送视频流，也没有禁用视频模块的通话时长。                                 |

> - 在通信场景下，每隔 2 秒你会收到频道内所有远端用户（不包括你自己）的视频流统计信息。
> - 在直播场景下，如果你是主播，每隔 2 秒你会收到频道内所有远端主播（不包括你自己）的视频流统计信息；如果你是观众，每隔 2 秒你会收到频道内所有远端主播的视频流统计信息。
> - Agora **视频模块**指视频处理过程，而不是 SDK 中的模块实物。发送视频流时，视频模块指视频采集、前处理、编码等处理过程；接收视频流时，视频模块指视频解码、后处理、渲染/播放等处理过程。
> - 用户只能开启/禁用自己的视频模块。

#### 示例代码

```swift
func rtcEngine(_ engine: AgoraRtcEngineKit, remoteVideoStats stats: AgoraRtcRemoteVideoStats) {
    videos.first(where: { $0.uid == stats.uid })?.statsInfo?.updateVideoStats(stats)
}
```

<a name="44"></a>

### 远端视频流状态监控

远端用户/主播的视频流状态改变时，SDK 会触发 `remoteVideoStateChangedOfUid` 回调向你报告远端视频流当前状态和状态改变的原因。

> - 在通信场景下，本回调向你报告频道内所有远端用户（不包括你自己）的视频流状态信息。
> - 在直播场景下，如果你是主播，本回调向你报告频道内所有远端主播（不包括你自己）的视频流状态信息；如果你是观众，本回调向你报告频道内所有远端主播的视频流状态信息。

## API 参考

- [`networkQuality`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:networkQuality:txQuality:rxQuality:)
- [`reportRtcStats`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:reportRtcStats:)
- [`localAudioStats`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:localAudioStats:)
- [`localAudioStateChange`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:localAudioStateChange:error:)
- [`remoteAudioStats`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:remoteAudioStats:)
- [`remoteAudioStateChangedOfUid`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:remoteAudioStateChangedOfUid:state:reason:elapsed:)
- [`localVideoStats`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:localVideoStats:)
- [`localVideoStateChange`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:localVideoStateChange:error:)
- [`remoteVideoStats`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:remoteVideoStats:)
- [`remoteVideoStateChangedOfUid`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:remoteVideoStateChangedOfUid:state:)

## 开发注意事项

[`localAudioStateChange`](#32)、[`remoteAudioStateChangedOfUid`](#34)、[`localVideoStateChange`](#42) 和 [`remoteVideoStateChangedOfUid`](#44) 状态监控回调**不会**每 2 秒被 SDK 自动触发，各自触发条件详见正文。

## 相关链接

- [为什么在运行集成 RTC SDK 的 iOS app 时会看到查找本地网络设备的弹窗提示？](https://docs.agora.io/cn/faq/local_network_privacy)
