本文介绍如何在元宇宙中实现多用户共同观看电影、聆听音乐和 K 歌。

用户可以在虚拟环境中与异地好友体验共享观影、听歌、唱歌的乐趣。不同用户看到视频、听到音乐几乎是同时的，用户间的互动也是几乎没有延迟。虚拟环境可以设置为电影院等娱乐场所，用户可以随时暂停视频，与其他用户进行实时交流互动，从而更好地享受在线互动的乐趣。实时共赏影音功能可以增加元语聊场景的多样性，为在线互动提供更真实的体验。


![](https://web-cdn.agora.io/docs-files/1679563308898)
![](https://web-cdn.agora.io/docs-files/1679563317645)

## 技术原理

![](https://web-cdn.agora.io/docs-files/1679564236130) //TODO 需要更新图片

在一起看电影、听音乐的功能实现中，主播通过媒体播放器控制音视频的播放。媒体播放器将视频推送至元宇宙中的视频显示屏，所有用户都可以通过显示屏观看视频内容。同时，主播发布麦克风采集的音频和播放器的音乐，观众或听众可以订阅这些音频。从而达到一起看电影、一起听音乐的效果。

在一起 K 歌的功能实现中，你还需添加在线 K 歌房的代码逻辑，并将元宇宙中的视频显示屏当成 K 歌房的歌词组件，向用户展示 K 歌界面，用户可以跟随主唱一起唱歌。

## 示例项目

声网在 GitHub 上提供开源 [Agora-MetaChat](https://github.com/AgoraIO-Community/Agora-MetaChat/tree/dev_sdk2) 示例项目供你参考使用。如果你还需了解 Unity 部分的工程文件和功能指南，请联系 sales@agora.io 获取。


## 前提条件

实现实时共赏影音功能前，请确保你已实现基础的元语聊功能，如创建、进入 3D 场景、创建虚拟形象。详见[客户端实现](https://docs.agora.io/cn/metachat/metachat_client_android?platform=All%20Platforms)。

## 实现步骤

下图展示 API 调用时序：

![](https://web-cdn.agora.io/docs-files/1679996687853)

### 1. 推送视频

调用 [`enableVideoDisplay`](https://docs.agora.io/cn/metachat/metachat_api_android?platform=All%20Platforms#enablevideodisplay) 开启元宇宙中的视频显示屏，再通过 [`pushVideoFrameToDisplay`](https://docs.agora.io/cn/metachat/metachat_api_android?platform=All%20Platforms#pushvideoframetodisplay) 将你从媒体播放器 onFrame 回调得到的视频帧推送至该视频显示屏。

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