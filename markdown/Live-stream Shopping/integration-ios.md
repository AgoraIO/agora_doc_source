本文介绍如何实现电商直播场景。

## 示例项目

声网在 [Agora-Scenario-Examples](https://github.com/AgoraIO-Usecase/Agora-Scenario-Examples/tree/main) 仓库中提供[电商直播](https://github.com/AgoraIO-Usecase/Agora-Scenario-Examples/tree/main/iOS/Agora%20Scenarios/Scenes/Shopping)源代码供你参考。

## 业务流程图

本节介绍电商直播涉及到的通用业务流程，包含主播和观众的实时音视频互动、主播之间的跨直播间 PK 连麦。

### 实时互动

房主进入直播间，开始上架商品，进行电商直播。用户可以查看商品列表进行下单。

![](https://web-cdn.agora.io/docs-files/1684397470563)

### PK 连麦

房主邀请另一个房间的房主开始 PK 连麦。用户可以看到两个房主 PK 连麦直播的画面。

![](https://web-cdn.agora.io/docs-files/1684397483079)


## 准备开发环境

### 前提条件



### 创建项目



## 实现电商直播

如下时序图中展示了如何预览直播、加入直播间、上下架商品、PK 连麦、退出直播间。声网 RTC SDK 承担实时音视频的业务，声网云服务承担信令消息和数据存储的业务。本节会详细介绍如何调用 RTC SDK 的 API 完成这些逻辑，但是信令消息的逻辑需要你参考时序图自行实现。

<div class="alert note">声网云服务为内部自研服务，暂不对外提供。声网建议你参考文档自行实现相似的一套服务。如需协助，请<a href="https://docs.agora.io/cn/Agora%20Platform/ticket?platform=All%20Platforms">提交工单</a>。</div>

![](https://web-cdn.agora.io/docs-files/1684744943721)

### 1. 预览直播

房主进入直播间前一般需要预览本地直播视频。你可以调用如下方法，创建 `AgoraRtcEngineKit` 并开启本地视频预览：

- [`sharedEngineWithConfig`](https://docportal.shengwang.cn/cn/live-streaming-premium-4.x/API%20Reference/ios_ng/API/toc_core_method.html#api_irtcengine_initialize): 创建 `AgoraRtcEngineKit`。
- [`setupLocalVideo`](): 初始化本地视图。#TODO enableVideo？时序图是否要改？
- [`startPreview`](https://docportal.shengwang.cn/cn/live-streaming-premium-4.x/API%20Reference/ios_ng/API/toc_video_process.html#api_irtcengine_startpreview): 开启视频预览。


```swift
// 创建 AgoraRtcEngineKit
agoraKit = AgoraRtcEngineKit.sharedEngine(with: rtcEngineConfig, delegate: self)
agoraKit?.setClientRole(getRole(uid: currentUserId))
// 开启视频
agoraKit?.enableVideo()
agoraKit?.enableAudio()
agoraKit?.setDefaultAudioRouteToSpeakerphone(true)
// 开启本地预览
agoraKit?.startPreview()
```

### 2. 加入直播间 #TODO 为什么是 joinChannelEx 不是非 Ex

你可以使用声网 RTC SDK 的 [`sharedEngineWithConfig`]() 方法创建一个 `AgoraRtcEngineKit`，再通过 [`joinChannel`]() 和 [`setChannelProfile`]() 方法让用户加入一个频道场景为 `LiveBroadcasting` 的频道。频道用于传输直播间中的音视频流，云服务用于传输直播间中的信令消息和存储数据。用户在频道内可以进行实时音视频互动。频道内的用户有两种角色：#TODO 这里和 Android 不同

- 主播：可以发送和接收音视频流。直播间的房主即为主播。
- 观众：只可以接收音视频流。

你需要调用 `setupLocalVideo` 在主播端渲染本地视频，调用 `setupRemoteVideo` 在观众端渲染远端视频（即主播的视频）。#TODO 这里和 Android 不同

```swift
let connection = AgoraRtcConnection()
connection.channelId = channelName
connection.localUid = uid

let channelMediaOptions = AgoraRtcChannelMediaOptions()
channelMediaOptions.clientRoleType = .broadcaster
channelMediaOptions.publishMicrophoneTrack = true
channelMediaOptions.publishCameraTrack = true
channelMediaOptions.autoSubscribeVideo = true
channelMediaOptions.autoSubscribeAudio = true

// 加入频道
let joinResult = agoraKit?.joinChannelEx(byToken: KeyCenter.Token, connection: connection, delegate: self, mediaOptions: channelMediaOptions, joinSuccess: nil)
if joinResult != 0 {
    print("join fail")
    return
}

// 主播端渲染本地视频
let canvas = AgoraRtcVideoCanvas()
canvas.uid = uid
canvas.renderMode = .hidden
agoraKit?.setupLocalVideo(canvas)


// 观众端渲染远端视频，即渲染主播的视频
let canvas = AgoraRtcVideoCanvas()
canvas.uid = remoteUid
canvas.renderMode = .hidden


let remoteConnection = AgoraRtcConnection()
remoteConnection.channelId = channelName
remoteConnection.localUid = uid
agoraKit?.setupRemoteVideoEx(canvas, connection: remoteConnection)
```

### 3. 开始 PK 连麦

房主跨直播间 PK 连麦意味着不同频道内的主播加入对方频道进行连麦。当房间内用户收到房主 PK 连麦的信令消息后，房间内用户的代码逻辑如下：

- 房间 A：
    - 房主 A 通过 [`joinChannelEx`]() 加入频道 B，并且设置订阅频道 B 内音视频流，但不发送音视频流。同时通过 [`setupRemoteVideoEx`]() 渲染频道 B 中主播的视频。
    - 观众通过 `joinChannelEx` 加入频道 B，并且设置订阅频道 B 内音视频流，但不发送音视频流。同时通过 `setupRemoteVideoEx` 渲染频道 B 中主播的视频。
- 房间 B：
    - 房主 B 通过 `joinChannelEx` 加入频道 A，并且设置订阅频道 A 内音视频流，但不发送音视频流。同时通过 `setupRemoteVideoEx` 渲染频道 A 中主播的视频。
    - 观众通过 `joinChannelEx` 加入频道 A，并且设置订阅频道 A 内音视频流，但不发送音视频流。同时通过 `setupRemoteVideoEx` 渲染频道 A 中主播的视频。

完成这些逻辑后，观众可以同时接收频道 A 和 B 的音视频流，因此可以同时看到两个房间的房主。房主仅在自己的频道发流，在对方的频道内不发流仅收流，因此，房主可以（在对方频道）看到对方，达到连麦的效果。


```swift
let connection = AgoraRtcConnection()
connection.channelId = channelName
connection.localUid = uid

// 加入对方频道时，订阅音视频流，但是不发送音视频流
let channelMediaOptions = AgoraRtcChannelMediaOptions()
channelMediaOptions.clientRoleType = .audience
channelMediaOptions.publishMicrophoneTrack = false
channelMediaOptions.publishCameraTrack = false
channelMediaOptions.autoSubscribeVideo = true
channelMediaOptions.autoSubscribeAudio = true

// 加入对方频道以 PK 连麦
let joinResult = agoraKit?.joinChannelEx(byToken: KeyCenter.Token, connection: connection, delegate: self, mediaOptions: channelMediaOptions, joinSuccess: nil)
if joinResult != 0 {
    print("join fail")
    return
}


// 渲染对方房主的视频
let canvas = AgoraRtcVideoCanvas()
canvas.uid = remoteUid
canvas.renderMode = .hidden

let remoteConnection = AgoraRtcConnection()
remoteConnection.channelId = channelName
remoteConnection.localUid = uid
agoraKit?.setupRemoteVideoEx(canvas, connection: remoteConnection)
```

### 4. 结束 PK 连麦

结束 PK 连麦时，房间内用户都需要调用 [`leaveChannelEx`](https://docportal.shengwang.cn/cn/live-streaming-premium-4.x/API%20Reference/ios_ng/API/toc_multi_channel.html#api_irtcengineex_leavechannelex) 离开对方频道。

```swift
let connection = AgoraRtcConnection()
connection.channelId = channelName
connection.localUid = uid
agoraKit?.leaveChannelEx(connection, leaveChannelBlock: nil)
```

### 5. 退出直播间

直播结束，所有用户退出直播间时都需要调用 [`leaveChannel`](https://docportal.shengwang.cn/cn/live-streaming-premium-4.x/API%20Reference/ios_ng/API/toc_core_method.html#api_irtcengine_leavechannel) 离开频道。如果不再加入房间，还可以调用 [`destroy`](https://docportal.shengwang.cn/cn/live-streaming-premium-4.x/API%20Reference/ios_ng/API/toc_core_method.html#api_irtcengine_release) 销毁 `AgoraRtcEngineKit`。

```swift
agoraKit?.leaveChannel()
AgoraRtcEngineKit.destroy()
```