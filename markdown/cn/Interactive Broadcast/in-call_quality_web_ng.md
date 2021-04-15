---
title: 通话中质量监测
platform: Web
updatedAt: 2021-03-10 04:00:48
---
<div class="alert note">本文仅适用于 Agora Web SDK 4.x 版本。如果你使用的是 Web SDK 3.x 或更早版本，请查看<a href="./in-call_quality_web?platform=Web">通话中质量监测</a>。</li></div>

## 功能描述
Agora Web SDK 支持获取以下统计数据来检测通话质量：
- Last mile 上下行网络质量
- 当前通话的统计数据
- 本地轨道的统计数据
- 远端轨道的统计数据
- 频道内的异常事件

<div class="alert info">点击<a href="https://webdemo.agora.io/agora-websdk-api-example-4.x/displayCallStats/index.html">在线体验</a>试用通话中质量监测功能。</div>

## 实现方法

开始前，请确保你已参考快速开始在你的项目中实现基本的实时音视频功能。

### Last mile 上下行网络质量

Last mile 是指你的设备到 Agora 边缘服务器的网络。

本地用户加入频道后，SDK 会每 1 秒触发 [AgoraRTCClient.on("network-quality")](./API%20Reference/web_ng/interfaces/iagorartcclient.html#event_network_quality) 回调报告本地用户的上下行 last-mile 网络质量打分。

你还可以通过 [AgoraRTCClient.getRemoteNetworkQuality](./API%20Reference/web_ng/interfaces/iagorartcclient.html#getremotenetworkquality) 方法获取本地订阅的所有远端用户的上下行 last-mile 网络质量打分。

质量打分对照表如下：

| 分数 | 说明                                             |
| :--- | :----------------------------------------------- |
| 0    | 网络质量未知。                                   |
| 1    | 网络质量极好。                                   |
| 2    | 用户主观感觉和极好差不多，但码率可能略低于极好。 |
| 3    | 用户主观感受有瑕疵但不影响沟通。                 |
| 4    | 勉强能沟通但不顺畅。                             |
| 5    | 网络质量非常差，基本不能沟通。                   |
| 6    | 完全无法沟通。                                   |

```js
client.on("network-quality", (stats) => {
    console.log("downlinkNetworkQuality", stats.downlinkNetworkQuality);
    console.log("uplinkNetworkQuality", stats.uplinkNetworkQuality);
});
```

```js
const remoteNetworkQuality = client.getRemoteNetworkQuality();
```

### 获取当前通话的统计数据

调用 [AgoraRTCClient.getRTCStats](./API%20Reference/web_ng/interfaces/iagorartcclient.html#getrtcstats) 方法获取与当前通话的统计数据，数据说明详见 [AgoraRTCStats](./API%20Reference/web_ng/interfaces/agorartcstats.html)。

```
const clientStats = client.getRTCStats();
```

### 获取本地音视频轨道的统计数据

调用 [AgoraRTCClient.getLocalAudioStats](./API%20Reference/web_ng/interfaces/iagorartcclient.html#getlocalaudiostats) 和 [AgoraRTCClient.getLocalVideoStats](./API%20Reference/web_ng/interfaces/iagorartcclient.html#getlocalvideostats) 方法分别获取本地发布的音频轨道和视频轨道的统计数据。数据说明详见 [LocalAudioTrackStats](./API%20Reference/web_ng/interfaces/localaudiotrackstats.html) 和 [LocalVideoTrackStats](./API%20Reference/web_ng/interfaces/localvideotrackstats.html)。

```
const localStats = {
  video: client.getLocalVideoStats(),
  audio: client.getLocalAudioStats()
};
```

### 获取远端音视频轨道的统计数据

调用 [AgoraRTCClient.getRemoteAudioStats](./API%20Reference/web_ng/interfaces/iagorartcclient.html#getremoteaudiostats) 和 [AgoraRTCClient.getRemoteVideoStats](./API%20Reference/web_ng/interfaces/iagorartcclient.html#getremotevideostats) 方法获取订阅的远端音频轨道和远端视频轨道的统计数据。其中，你可参考下图理解 `end2EndDelay`、`receiveDelay 和 ``transportDelay` 字段，其他数据说明详见 [RemoteAudioTrackStats](./API%20Reference/web_ng/interfaces/remoteaudiotrackstats.html) 和 [RemoteVideoTrackStats](./API%20Reference/web_ng/interfaces/remotevideotrackstats.html)。

![](https://web-cdn.agora.io/docs-files/1615347404333)

| 字段             | 描述                                                         |
| :--------------- | :----------------------------------------------------------- |
| `end2EndDelay`   | 端到端延时（毫秒），从远端采集音频或视频到本地播放音频或视频的延时。图中阶段 1 + 2 + 3 + 4 + 5 + 6。 |
| `receiveDelay`   | 接收音频延时（毫秒），从远端发送音频或视频到本地播放音频或视频的延时，图中阶段 2 + 3 + 4 + 5 + 6。 |
| `transportDelay` | 传输延时（毫秒），从远端发送音频或视频到本地接收音频或视频的延时。图中阶段 2 + 3 + 4。 |

```
const remoteTracksStats = {
  video: client.getRemoteVideoStats()[uid],
  audio: client.getRemoteAudioStats()[uid]
};
```

### 关注频道内的异常事件

SDK 通过 [AgoraRTCClient.on("exception")](./API%20Reference/web_ng/interfaces/iagorartcclient.html#event_exception) 回调报告频道内的异常事件。异常事件不是错误，但是往往会引起通话质量问题。发生异常事件后，如果恢复正常，也会收到该回调。该回调返回：

- `code`：事件码。
- `msg`：提示消息。
- `uid`：发生异常或恢复的用户 UID。

```
client.on("exception", function(evt) {
  console.log(evt.code, evt.msg, evt.uid);
})
```

每个异常事件都有对应的恢复事件，详见下表：

![](https://web-cdn.agora.io/docs-files/1547180167044)

## 开发注意事项

上述所有方法必须在成功加入频道之后调用。