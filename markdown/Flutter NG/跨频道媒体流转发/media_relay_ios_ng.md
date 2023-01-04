# 跨频道媒体流转发

在直播场景下，跨频道媒体流转发功能可实现主播角色的媒体流从源频道同时转发进多个目标频道，其中：

- 所有主播发布并接收彼此的音视频流，进行跨频道实时互动
- 观众可以接收到所有主播的音视频流，同时观看多位主播互动

该功能因其实时性和互动性，能够丰富直播玩法，尤其适用于连麦 PK、在线合唱等直播场景，为观众带来更好的观看体验的同时，也为主播带来更多的流量和收益。


## 示例项目

我们在 GitHub 提供了开源的跨频道媒体流转发示例项目 [MediaChannelRelay](https://github.com/AgoraIO/API-Examples/blob/main/iOS/APIExample/APIExample/Examples/Advanced/MediaChannelRelay/MediaChannelRelay.swift)。下方是 Demo 的演示效果：


| | PK 前 | PK 中 |
|:----|:--------|:------------|
| **主播 A** | <img src="https://web-cdn.agora.io/docs-files/1672803590199" width="70%"/> | <img src="https://web-cdn.agora.io/docs-files/1672803643613" width="75%"/> |
| **主播 B** | <img src="https://web-cdn.agora.io/docs-files/1672803622116" width="70%"/> | <img src="https://web-cdn.agora.io/docs-files/1672803662758" width="75%"/> |
| **主播 A 的观众**| | |


## 前提条件

在开始前，请确保满足以下条件：

- 在你的项目中实现基本的实时音视频功能，详见[开始互动直播](./start_live_ios_ng)。
- <a href="https://agora-ticket.agora.io/">联系技术支持</a>开通跨频道连麦功能。


## 实现步骤

参考如下 API 时序图实现相关代码逻辑：

![](https://web-cdn.agora.io/docs-files/1672818162076)

### 1. 开始跨频道媒体流转发

一个频道内可以有多个主播转发媒体流，哪个主播调用 `startChannelMediaRelay` 方法，SDK 就转发哪个主播的流，示例代码如下：

```swift
// 配置源频道信息
// 将源频道名的默认值为 nil，表示 SDK 自动填充当前频道名
// 基于该特性的实现原理，必须将源频道的 uid 设为 0
// 这里的 token 与用户加入源频道时的 token 不同，需要用源频道名和 uid = 0 重新生成
let config = AgoraChannelMediaRelayConfiguration()
config.sourceInfo = AgoraChannelMediaRelayInfo(token: nil)

// 配置目标频道信息
// 你可以将 uid 设为 0 由 SDK 随机分配，或自行指定 uid 并确保其与目标频道中的所有 uid 不同
let destinationInfo = AgoraChannelMediaRelayInfo(token: nil)
config.setDestinationInfo(destinationInfo, forChannelName: destinationChannelName)
// 开始跨频道媒体流转发
agoraKit.startChannelMediaRelay(config)
```


### 2. 更新媒体流转发的频道

成功调用 `startChannelMediaRelay` 开始跨频道媒体流转发后，如需添加或移除目标频道，可以调用 `updateChannelMediaRelay` 方法更新目标频道。

> 更新后的配置会**全量替换**掉之前的配置。


### 3. 暂停/恢复转发媒体流

成功调用 `startChannelMediaRelay` 开始跨频道媒体流转发后，如果想暂停向所有目标频道发送媒体流，可调用 `pauseAllChannelMediaRelay` 方法，示例代码如下：

```swift
agoraKit.pauseAllChannelMediaRelay()
```

暂停跨频道媒体流转发后，如果想恢复向所有目标频道转发媒体流，可调用 `resumeAllChannelMediaRelay` 方法，示例代码如下：

```swift
agoraKit.resumeAllChannelMediaRelay()
```


### 4. 停止跨频道媒体流转发

在成功调用 `startChannelMediaRelay` 方法后，如果想再次调用该方法，必须先调用 `stopChannelMediaRelay` 方法退出当前的转发状态，示例代码如下：

```swift
agoraKit.stopChannelMediaRelay()
```

> 如果该方法调用不成功，可以调用 `leaveChannel` 方法离开频道，跨频道媒体流转发会自动停止。


### 5. 监听跨频道媒体流状态

在跨频道媒体流转发过程中，SDK 会通过 `channelMediaRelayStateDidChange` 和 `didReceiveChannelMediaRelayEvent` 回调报告媒体流转发的状态和事件，你可以参考状态码或事件码的含义实现相关的业务逻辑。示例代码如下：

```swift
func rtcEngine(_ engine: AgoraRtcEngineKit, channelMediaRelayStateDidChange state: AgoraChannelMediaRelayState, error: AgoraChannelMediaRelayError) {
    LogUtils.log(message: "channelMediaRelayStateDidChange: \(state.rawValue) error \(error.rawValue)", level: .info)
    
    switch(state){
    case .running:
        isRelaying = true
        break
    case .failure:
        showAlert(message: "Media Relay Failed: \(error.rawValue)")
        isRelaying = false
        break
    case .idle:
        isRelaying = false
        break
    default:break
    }
}
```

主要的状态码和事件码及其对应的媒体流转发状态如下：

| 状态码 | 错误码 | 事件码 | 媒体流转发状态 |
| ------- | ------ | ------ | ------------- |
| 2 | 0 | 4 | 源频道开始向目标频道传输数据。  |
| 3 | 详见[错误码](./API%20Reference/ios_ng/API/toc_stream_management.html#callback_irtcengineeventhandler_onchannelmediarelaystatechanged) | /  | 跨频道媒体流转发出现异常，可以参考错误码进行问题排查。  |
| 0 | 0 | /  | 已停止媒体流转发。  |


## 相关参考

### 开发注意事项

- 在直播场景中，只有角色为主播的用户才能调用 `startChannelMediaRelay` 开始跨频道媒体流转发
- 该功能最多支持将媒体流转发至 64 个目标频道
- 该功能不支持 String 型 `uid`，如需使用跨频道连麦功能，则要在普通连麦中也使用 Int 型 `uid`，否则跨频道连麦功能无法正常使用

### API 参考

- [`startChannelMediaRelay`](./API%20Reference/ios_ng/API/toc_stream_management.html#api_irtcengine_startchannelmediarelay)
- [`updateChannelMediaRelay`](./API%20Reference/ios_ng/API/toc_stream_management.html#api_irtcengine_updatechannelmediarelay)
- [`stopChannelMediaRelay`](./API%20Reference/ios_ng/API/toc_stream_management.html#api_irtcengine_stopchannelmediarelay)
- [`pauseAllChannelMediaRelay`](./API%20Reference/ios_ng/API/toc_stream_management.html#api_irtcengine_pauseallchannelmediarelay)
- [`resumeAllChannelMediaRelay`](./API%20Reference/ios_ng/API/toc_stream_management.html#api_irtcengine_resumeallchannelmediarelay)
- [`channelMediaRelayStateDidChange`](./API%20Reference/ios_ng/API/toc_network.html#callback_irtcengineeventhandler_onchannelmediarelaystatechanged)
- [`didReceiveChannelMediaRelayEvent`](./API%20Reference/ios_ng/API/toc_stream_management.html#callback_irtcengineeventhandler_onchannelmediarelayevent)
- [`AgoraChannelMediaRelayConfiguration`](./API%20Reference/ios_ng/API/class_channelmediarelayconfiguration.html)
- [`AgoraChannelMediaRelayInfo`](./API%20Reference/ios_ng/API/class_channelmediainfo.html)