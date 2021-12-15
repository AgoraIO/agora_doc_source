---
title: 通话中质量监测
platform: Web
updatedAt: 2020-12-30 09:01:59
---

## 功能描述

Agora Web SDK 支持获取以下统计数据来检测通话质量：

- [系统信息](#system_statistics)
- [网络相关数据](#network_statistics)
- [当前会话的统计数据](#session_statistics)
- [本地发布流的统计数据](#local_stream_statistics)
- [远端订阅流的统计数据](#remote_stream_statistics)
- [本地用户的上下行网络质量相关的统计数据](#updownlink_network_quality)
- [频道内的异常事件](#exception)

## 实现方法

请确保已在你的项目中实现基本的实时音视频功能。详见[开始音视频通话](start_call_web)或[开始互动直播](start_live_web)。

<a name ="system_statistics"></a>

### 获取系统信息

调用 [`Client.getSystemStats`](./API%20Reference/web/interfaces/agorartc.client.html#getsystemstats) 方法获取系统信息。目前只能获取系统电量信息。

```javascript
client.getSystemStats(stats => {
  console.log(`Current battery level: ${stats.BatteryLevel}`);
});
```

> 该功能处于实验阶段，浏览器兼容信息请参考 [Battery Status API](https://developer.mozilla.org/en-US/docs/Web/API/Battery_Status_API)。

<a name ="network_statistics"></a>

### 获取网络相关数据

调用 [`Client.getTransportStats`](./API%20Reference/web/interfaces/agorartc.client.html#gettransportstats) 方法[<sup>[1]</sup>](#reference)获取**网络类型**和**网络连接状况统计数据**[<sup>[2]</sup>](#reference)。具体参数如下：

- `NetworkType`：网络类型[<sup>[3]</sup>](#reference)，如 Wi-Fi、蜂窝移动数据网络、蓝牙网络等。
- `OutgoingAvailableBandwidth`：上行可用带宽估计（Kbps）。
- `RTT`：Agora Web SDK 到 Agora SD-RTN 接入节点的平均往返延时（ RTT，Round-Trip Time），单位 ms。

```javascript
client.getTransportStats(stats => {
  console.log(`Current Transport RTT: ${stats.RTT}`);
  console.log(`Current Network Type: ${stats.networkType}`);
  console.log(`Current Transport OutgoingAvailableBandwidth: ${stats.OutgoingAvailableBandwidth}`);
});
```

<a name ="reference"></a>

> - [1] 本方法仅支持 Chrome 浏览器。
> - [2] 部分统计数据可能耗费 0-3 秒时间返回。
> - [3] `NetworkType` 参数仅支持 Google Chrome 61 及之后版本，且无法保证兼容性，详见[网络状况 API](https://developer.mozilla.org/zh-CN/docs/Web/API/Network_Information_API)。

<a name ="session_statistics"></a>

### 获取当前会话的统计数据

调用 [`Client.getSessionStats`](./API%20Reference/web/interfaces/agorartc.client.html#getsessionstats) 方法获取与当前会话相关的统计数据，包括：

- `Duration`：在当前频道内的时长（秒）。
- `RecvBitrate`：音视频总接收码率（Kbps），瞬间值。
- `RecvBytes`：接收字节数，累计值。
- `SendBitrate`：音视频总发送码率（Kbps），瞬间值。
- `SendBytes`：发送字节数，累计值。
- `UserCount`：通信场景下，该值为当前频道内的用户人数。直播场景下，如果本地用户为主播，该值为当前频道内的主播人数；如果本地用户为观众，该值为当前频道内的主播人数 + 1。

```javascript
client.getSessionStats(stats => {
  console.log(`Current Session Duration: ${stats.Duration}`);
  console.log(`Current Session UserCount: ${stats.UserCount}`);
  console.log(`Current Session SendBytes: ${stats.SendBytes}`);
  console.log(`Current Session RecvBytes: ${stats.RecvBytes}`);
  console.log(`Current Session SendBitrate: ${stats.SendBitrate}`);
  console.log(`Current Session RecvBitrate: ${stats.RecvBitrate}`);
});
```

> - 本方法仅支持 Chrome 浏览器。
> - 统计数据可能耗费 0-3 秒时间返回。

<a name ="local_stream_statistics"></a>

### 获取本地发布流的统计数据

调用以下方法获取本地发布流的音频和视频统计数据。

- [`Client.getLocalAudioStats`](./API%20Reference/web/interfaces/agorartc.client.html#getlocalaudiostats) 方法提供本地发布流的**音频**统计数据，包括：
  - `CodecType`：音频编码类型。
  - `MuteState`：音频是否静音。
  - `RecordingLevel`：音频采集能量。
  - `SamplingRate`：音频采样率（kHz）。
  - `SendBitrate`：音频发送码率（Kbps）。
  - `SendLevel`：音频发送能量。

```javascript
client.getLocalAudioStats(localAudioStats => {
  for (var uid in localAudioStats) {
    console.log(`Audio CodecType from ${uid}: ${localAudioStats[uid].CodecType}`);
    console.log(`Audio MuteState from ${uid}: ${localAudioStats[uid].MuteState}`);
    console.log(`Audio RecordingLevel from ${uid}: ${localAudioStats[uid].RecordingLevel}`);
    console.log(`Audio SamplingRate from ${uid}: ${localAudioStats[uid].SamplingRate}`);
    console.log(`Audio SendBitrate from ${uid}: ${localAudioStats[uid].SendBitrate}`);
    console.log(`Audio SendLevel from ${uid}: ${localAudioStats[uid].SendLevel}`);
  }
});
```

- [`Client.getLocalVideoStats`](./API%20Reference/web/interfaces/agorartc.client.html#getlocalvideostats) 方法提供本地发布流的**视频**统计数据，一个 uid 对应一组数据，包括：
  - `CaptureFrameRate`：视频采集帧率（fps）。
  - `CaptureResolutionHeight`：视频采集分辨率高度，单位为像素。
  - `CaptureResolutionWidth`：视频采集分辨率宽度，单位为像素。
  - `EncodeDelay`：本地视频从采集到编码的延时（ms）。
  - `MuteState`：视频画面是否开启。
  - `SendBitrate`：视频发送码率（Kbps）。
  - `SendFrameRate`：视频发送帧率（fps）。
  - `SendResolutionHeight`：视频发送分辨率高度，单位为像素。
  - `SendResolutionWidth`：视频发送分辨率宽度，单位为像素。
  - `TargetSendBitrate`：`setVideoProfile` 中设置的目标发送码率（Kbps）。
  - `TotalDuration`：从视频流发布到当前时间的总时长，单位为秒。
  - `TotalFreezeTime`：视频编码卡顿总时间，单位为秒。

```javascript
client.getLocalVideoStats(localVideoStats => {
  for (var uid in localVideoStats) {
    console.log(`Video CaptureFrameRate from ${uid}: ${localVideoStats[uid].CaptureFrameRate}`);
    console.log(`Video CaptureResolutionHeight from ${uid}: ${localVideoStats[uid].CaptureResolutionHeight}`);
    console.log(`Video CaptureResolutionWidth from ${uid}: ${localVideoStats[uid].CaptureResolutionWidth}`);
    console.log(`Video EncodeDelay from ${uid}: ${localVideoStats[uid].EncodeDelay}`);
    console.log(`Video MuteState from ${uid}: ${localVideoStats[uid].MuteState}`);
    console.log(`Video SendBitrate from ${uid}: ${localVideoStats[uid].SendBitrate}`);
    console.log(`Video SendFrameRate from ${uid}: ${localVideoStats[uid].SendFrameRate}`);
    console.log(`Video SendResolutionHeight from ${uid}: ${localVideoStats[uid].SendResolutionHeight}`);
    console.log(`Video SendResolutionWidth from ${uid}: ${localVideoStats[uid].SendResolutionWidth}`);
    console.log(`Video TargetSendBitrate from ${uid}: ${localVideoStats[uid].TargetSendBitrate}`);
    console.log(`Video TotalDuration from ${uid}: ${localVideoStats[uid].TotalDuration}`);
    console.log(`Video TotalFreezeTime from ${uid}: ${localVideoStats[uid].TotalFreezeTime}`);
  }
});
```

> - 这两个方法仅支持 Chrome 浏览器。
> - 统计数据可能耗费 0-3 秒返回。

<a name ="remote_stream_statistics"></a>

### 获取远端订阅流的统计数据

**获取远端订阅流的音频统计数据**

![](https://web-cdn.agora.io/docs-files/1577674685810)

- [`Client.getRemoteAudioStats`](./API%20Reference/web/interfaces/agorartc.client.html#getremoteaudiostats) 方法提供远端订阅流的**音频**统计数据，一个 uid 对应一组数据，详见下表：

| 参数                | 描述                                                                                       |
| ------------------- | ------------------------------------------------------------------------------------------ |
| `CodecType`         | 音频解码类型。                                                                             |
| `End2EndDelay`      | 端到端延时（ms），从远端采集音频到本地播放音频的延时。<br>图中阶段 1 + 2 + 3 + 4 + 5 + 6。 |
| `MuteState`         | 音频是否静音。                                                                             |
| `PacketLossRate`    | 远端音频的丢包率（%）。                                                                    |
| `RecvBitrate`       | 音频接收码率（Kbps）。                                                                     |
| `RecvLevel`         | 接收音频的音量。                                                                           |
| `TotalFreezeTime`   | 音频卡顿总时间（s）。                                                                      |
| `TotalPlayDuration` | 音频播放总时长（s）。                                                                      |
| `TransportDelay`    | 传输延时（ms），从远端发送音频到本地接收音频的延时。<br>图中阶段 2 + 3 + 4。               |

```javascript
client.getRemoteAudioStats(remoteAudioStatsMap => {
  for (var uid in remoteAudioStatsMap) {
    console.log(`Audio CodecType from ${uid}: ${remoteAudioStatsMap[uid].CodecType}`);
    console.log(`Audio End2EndDelay from ${uid}: ${remoteAudioStatsMap[uid].End2EndDelay}`);
    console.log(`Audio MuteState from ${uid}: ${remoteAudioStatsMap[uid].MuteState}`);
    console.log(`Audio PacketLossRate from ${uid}: ${remoteAudioStatsMap[uid].PacketLossRate}`);
    console.log(`Audio RecvBitrate from ${uid}: ${remoteAudioStatsMap[uid].RecvBitrate}`);
    console.log(`Audio RecvLevel from ${uid}: ${remoteAudioStatsMap[uid].RecvLevel}`);
    console.log(`Audio TotalFreezeTime from ${uid}: ${remoteAudioStatsMap[uid].TotalFreezeTime}`);
    console.log(`Audio TotalPlayDuration from ${uid}: ${remoteAudioStatsMap[uid].TotalPlayDuration}`);
    console.log(`Audio TransportDelay from ${uid}: ${remoteAudioStatsMap[uid].TransportDelay}`);
  }
});
```

**获取远端订阅流的视频统计数据**

![](https://web-cdn.agora.io/docs-files/1577675084533)

- [`Client.getRemoteVideoStats`](./API%20Reference/web/interfaces/agorartc.client.html#getremotevideostats) 方法提供远端订阅流的**视频**统计数据，一个 uid 对应一组数据，详见下表：

| 参数                     | 描述                                                                                        |
| ------------------------ | ------------------------------------------------------------------------------------------- |
| `End2EndDelay`           | 端到端延时（ms），从远端采集视频到本地播放视频的延时。<br/>图中阶段 1 + 2 + 3 + 4 + 5 + 6。 |
| `MuteState`              | 视频画面是否开启。                                                                          |
| `PacketLossRate`         | 远端视频的丢包率（%）。                                                                     |
| `RecvBitrate`            | 视频接收码率（Kbps）。                                                                      |
| `RecvResolutionHeight`   | 视频接收分辨率高度，单位为像素。                                                            |
| `RecvResolutionWidth`    | 视频接收分辨率宽度，单位为像素。                                                            |
| `RenderFrameRate`        | 渲染帧率（fps），视频解码输出帧率。                                                         |
| `RenderResolutionHeight` | 视频渲染分辨率高度，单位为像素。                                                            |
| `RenderResolutionWidth`  | 视频渲染分辨率宽度，单位为像素。                                                            |
| `TotalFreezeTime`        | 视频卡顿总时间，单位为秒。                                                                  |
| `TotalPlayDuration`      | 视频播放总时间，单位为秒。                                                                  |
| `TransportDelay`         | 传输延时（ms），从远端发送视频到本地接收视频的延时。<br/>图中阶段 2 + 3 + 4。               |

```javascript
client.getRemoteVideoStats(remoteVideoStatsMap => {
  for (var uid in remoteVideoStatsMap) {
    console.log(`Video End2EndDelay from ${uid}: ${remoteVideoStatsMap[uid].End2EndDelay}`);
    console.log(`Video MuteState from ${uid}: ${remoteVideoStatsMap[uid].MuteState}`);
    console.log(`Video PacketLossRate from ${uid}: ${remoteVideoStatsMap[uid].PacketLossRate}`);
    console.log(`Video RecvBitrate from ${uid}: ${remoteVideoStatsMap[uid].RecvBitrate}`);
    console.log(`Video RecvResolutionHeight from ${uid}: ${remoteVideoStatsMap[uid].RecvResolutionHeight}`);
    console.log(`Video RecvResolutionWidth from ${uid}: ${remoteVideoStatsMap[uid].RecvResolutionWidth}`);
    console.log(`Video RenderFrameRate from ${uid}: ${remoteVideoStatsMap[uid].RenderFrameRate}`);
    console.log(`Video RenderResolutionHeight from ${uid}: ${remoteVideoStatsMap[uid].RenderResolutionHeight}`);
    console.log(`Video RenderResolutionWidth from ${uid}: ${remoteVideoStatsMap[uid].RenderResolutionWidth}`);
    console.log(`Video TotalFreezeTime from ${uid}: ${remoteVideoStatsMap[uid].TotalFreezeTime}`);
    console.log(`Video TotalPlayDuration from ${uid}: ${remoteVideoStatsMap[uid].TotalPlayDuration}`);
    console.log(`Video TransportDelay from ${uid}: ${remoteVideoStatsMap[uid].TransportDelay}`);
  }
});
```

> - 这两个方法仅支持 Chrome 浏览器。
> - 统计数据可能耗费 0-3 秒返回。

<a name ="updownlink_network_quality"></a>

### 获取本地用户的上下行网络质量相关的统计数据

Agora Web SDK 通过 `Client.on` 中的 [`network-quality`](./API%20Reference/web/interfaces/agorartc.client.html#on) 回调向 App 报告本地用户的上下行网络质量。该回调每 2 秒触发，返回的参数包括：

- `downlinkNetworkQuality`：下行网络质量打分。
- `uplinkNetworkQuality`：上行网络质量打分。

质量打分对照表如下：

| 分数 | 说明                                             |
| ---- | :----------------------------------------------- |
| 0    | 网络质量未知。                                   |
| 1    | 网络质量极好。                                   |
| 2    | 用户主观感觉和极好差不多，但码率可能略低于极好。 |
| 3    | 用户主观感受有瑕疵但不影响沟通。                 |
| 4    | 勉强能沟通但不顺畅。                             |
| 5    | 网络质量非常差，基本不能沟通。                   |
| 6    | 完全无法沟通。                                   |

```javascript
client.on("network-quality", function (stats) {
  console.log("downlinkNetworkQuality", stats.downlinkNetworkQuality);
  console.log("uplinkNetworkQuality", stats.uplinkNetworkQuality);
});
```

> 该功能目前处于实验阶段，网络质量评分仅供参考。

<a name ="exception"></a>

### 关注频道内的异常事件

Agora Web SDK 通过 `Client.on` 中的 [`exception`](./API%20Reference/web/interfaces/agorartc.client.html#on) 回调通知 App 频道内的异常事件。异常事件不是错误，但是往往会引起通话质量问题。发生异常事件后，如果恢复正常，也会收到该回调。该回调返回：

- `code`：事件码。
- `msg`：提示消息。
- `uid`：发生异常或恢复的用户 UID。

```javascript
client.on("exception", function (evt) {
  console.log(evt.code, evt.msg, evt.uid);
});
```

每一个异常事件都有对应的恢复事件，详见下表：

![](https://web-cdn.agora.io/docs-files/1547180167044)

> 本回调仅支持 Chrome 浏览器。

## 开发注意事项

上述所有方法必须在成功加入频道之后调用。
