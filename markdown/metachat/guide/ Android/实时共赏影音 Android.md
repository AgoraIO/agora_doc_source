本文介绍如何实现实时共赏影音功能。

实时共赏影音功能指多用户在虚拟环境中共同观看电影、聆听音乐和 K 歌。不同用户看到视频、听到音乐几乎是同时的，用户间的互动也几乎没有延迟。虚拟环境可以设置为电影院等娱乐场所，用户可以随时暂停视频，与其他用户进行实时交流互动，从而更好地体验观影、听歌、唱歌的乐趣。实时共赏影音功能可以增加元语聊场景的多样性，为在线互动提供更真实的体验。


![](https://web-cdn.agora.io/docs-files/1679563308898)
![](https://web-cdn.agora.io/docs-files/1679563317645)

## 技术原理

![](https://web-cdn.agora.io/docs-files/1680256359442)

在一起看电影、听音乐的功能实现中，主播通过媒体播放器控制音视频的播放，并将从媒体播放器获取的视频原始数据推送至 Unity 场景。同时，主播发布麦克风采集的音频和播放器的音乐，受众可以订阅这些音频。主播和受众通过数据流进行播放进度和播放 URL 的信息传递。受众控制媒体播放器对齐主播的播放进度，并把播放器播放的视频原始帧推送至 Unity 场景。

在一起 K 歌的功能实现中，你还需要添加在 Native 界面展示 K 歌房的玩法，并通过一起看电影的逻辑进行视频的同步。K 歌的功能实现详见 [K 歌房](https://docs.agora.io/cn/online-ktv/ktv_overview)。

## 示例项目

声网在 GitHub 上提供开源 [Agora-MetaChat](https://github.com/AgoraIO-Community/Agora-MetaChat/tree/dev_sdk2) 示例项目供你参考使用。如果你还需了解 Unity 部分的工程文件和功能指南，请联系 sales@agora.io 获取。


## 前提条件

实现实时共赏影音功能前，请确保你已实现基础的元语聊功能，如创建、进入 3D 场景、创建虚拟形象。详见[客户端实现](https://docs.agora.io/cn/metachat/metachat_client_android?platform=All%20Platforms)。

## 实现步骤

下图展示 API 调用时序：

![](https://web-cdn.agora.io/docs-files/1682064472217)

### 1. 推送视频

调用 [`enableVideoDisplay`](https://docs.agora.io/cn/metachat/metachat_api_android?platform=All%20Platforms#enablevideodisplay) 开启元宇宙中的视频显示屏，再通过 [`pushVideoFrameToDisplay`](https://docs.agora.io/cn/metachat/metachat_api_android?platform=All%20Platforms#pushvideoframetodisplay) 将你从媒体播放器 `onFrame` 回调得到的视频帧推送至该视频显示屏。

```java
// 开启视频显示屏
// "1" 为指定的 displayID
metaChatScene.enableVideoDisplay("1", true);
// 将媒体播放器 onFrame 回调视频帧推送至指定的视频显示屏上
metaChatScene.pushVideoFrameToDisplay("1", frame);
```

### 2. 同步视频播放进度

为了同步主播和观众的视频播放进度，主播调用 [`sendStreamMessage`](https://docs.agora.io/cn/live-streaming-premium-4.x/API%20Reference/java_ng/API/toc_stream_management.html#api_irtcengine_sendstreammessage) 发布携带播放进度的数据流，观众通过 [`onStreamMessage`](https://docs.agora.io/cn/live-streaming-premium-4.x/API%20Reference/java_ng/v4.1.1/API/toc_network.html#callback_irtcengineeventhandler_onstreammessage) 接收数据流，解析出播放进度。

```java
public abstract int sendStreamMessage(int streamId, byte[] message);
```