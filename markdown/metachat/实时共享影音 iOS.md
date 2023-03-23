本文介绍如何在元宇宙中实现多用户共同观看电影、聆听音乐和 K 歌。

用户可以与异地好友在虚拟环境中共享观影、听歌、唱歌的乐趣。虚拟环境可以设置为电影院等娱乐场所，用户可随时暂停视频，与其他用户进行交流互动。该功能可以增加元语聊场景的玩法多样性，为在线互动提供更逼真的体验。

![](https://web-cdn.agora.io/docs-files/1679563308898)
![](https://web-cdn.agora.io/docs-files/1679563317645)

## 技术原理

![](https://web-cdn.agora.io/docs-files/1679564236130)

在一起看电影、听音乐的功能实现中，主播通过媒体播放器控制音视频的播放。媒体播放器将视频推送至元宇宙中的视频显示屏，所有用户都可以通过显示屏观看视频内容。同时，主播发布麦克风采集的音频和播放器的音乐，观众或听众可以订阅这些音频。从而达到一起看电影、一起听音乐的效果。

在一起 K 歌的功能实现中，你还需添加在线 K 歌房的代码逻辑，并将元宇宙中的视频显示屏当成 K 歌房的歌词组件，向用户展示 K 歌界面，用户可以跟随主唱一起唱歌。

## 前提条件

实现空间音效前，请确保你已实现基础的元语聊功能，如创建、进入 3D 常见，更新用户角色。详见[客户端实现](https://docs.agora.io/cn/metachat/metachat_client_ios?platform=All%20Platforms)。

## 实现步骤

<pic>

### 1. 推送视频

调用 enableVideoDisplay 开启元宇宙中的视频显示屏，再通过 pushVideoFrameToDisplay 将你从媒体播放器 onFrame 回调得到的视频帧推送至该视频显示屏。

```java
// 开启视频显示屏
// "1" 为指定的 displayID
metaChatScene.enableVideoDisplay("1", true);
// 将媒体播放器 onFrame 回调视频帧推送至指定的视频显示屏上
metaChatScene.pushVideoFrameToDisplay("1", frame);
```

### 2. 同步视频播放进度

为了同步主播和观众的视频播放进度，主播调用 sendStreamMessage 发布携带播放进度的数据流，观众通过 onStreamMessage 接收数据流，解析出播放进度。

```java
public abstract int sendStreamMessage(int streamId, byte[] message);
```

```swift
// 开启视频显示屏
// "1" 为指定的 displayID
metachatScene?.enableVideoDisplay("1", enable: true)
// vf 为待推送的视频帧
let vf = AgoraVideoFrame()
// 格式为 I420
vf.format = 1
vf.strideInPixels = Int32(videoFrame.width)
vf.height = Int32(videoFrame.height)
vf.dataBuf = data
// 将视频帧推送至指定的视频显示屏上
metachatScene?.pushVideoFrame(toDisplay: "1", frame: vf)

func sendStreamMessage(
    _ streamId: Int,
    data: Data
) -> Int
```