https://docs-preprod.agora.io/cn/live-streaming-standard-legacy/media_relay_apple?platform=iOS

MediaChannelRelay/ https://github.com/AgoraIO/API-Examples/blob/main/iOS/APIExample/APIExample/Examples/Advanced/MediaChannelRelay/MediaChannelRelay.swift

ChannelMediaRelay/ https://github.com/AgoraIO/API-Examples/blob/main/macOS/APIExample/Examples/Advanced/ChannelMediaRelay/ChannelMediaRelay.swift

## 功能描述

跨直播间连麦，指主播的媒体流可以同时转发进多个直播频道，实现主播跨频道与其他主播实时互动的场景。其中：

- 频道中的所有主播可以看见彼此，并听到彼此的声音。
- 频道中的观众可以看到所有主播，并听到主播的声音。

该功能因其实时性和互动性，尤其适用于连麦 PK、在线合唱等直播场景，在增加直播趣味的同时，有效吸粉。


## 示例项目

我们在 GitHub 提供了开源的跨频道媒体流转发示例项目，你可以前往下载，并参考其中的源代码。
- iOS: [ChannelMediaRelay](https://github.com/AgoraIO/API-Examples/blob/legacy/iOS/APIExample/Examples/Advanced/MediaChannelRelay/MediaChannelRelay.swift) 
- macOS: [ChannelMediaRelay](https://github.com/AgoraIO/API-Examples/blob/legacy/macOS/APIExample/Examples/Advanced/ChannelMediaRelay/ChannelMediaRelay.swift)

## 实现方法

<div class="alert note">跨频道连麦功能需要<a href="https://agora-ticket.agora.io/">联系技术支持</a>开通。</div>

实现跨频道连麦功能前，请确保你已在项目中实现基本的实时音视频功能，详见如下文档：
- iOS：[开始互动直播](start_live_ios)
- macOS：[开始互动直播](start_live_mac)

Agora Native SDK 在 v2.9.0 中新增如下跨频道媒体流转发接口，支持将源频道中的媒体流转发至最多 4 个目标频道，实现跨直播间连麦功能：

- `startChannelMediaRelay`
- `updateChannelMediaRelay`
- `stopChannelMediaRelay`

在跨频道媒体流转发过程中，SDK 会通过 `channelMediaRelayStateDidChange` 和 `didReceiveChannelMediaRelayEvent` 回调报告媒体流转发的状态和事件，你可以参考如下状态码或事件码的含义实现相关的业务逻辑：


| 状态码 | 事件码 | 媒体流转发状态 |
| ---------------- | ---------------- | ---------------- |
| AgoraChannelMediaRelayStateRunning(2) 和 AgoraChannelMediaRelayErrorNone(0)     | AgoraChannelMediaRelayEventSentTo-DestinationChannel(4)      | 源频道开始向目标频道传输数据      |
| AgoraChannelMediaRelayStateFailure(3)     | /      | 跨频道媒体流转发出现异常。可以参考 error 参数中报告的出错原因进行问题排查      |
| AgoraChannelMediaRelayStateIdle(0) 和 AgoraChannelMediaRelayErrorNone(0)     | /      | 已停止媒体流转发      |

**Note**：
- 一个频道内可以有多个主播转发媒体流。哪个主播调用 `startChannelMediaRelay` 方法，SDK 就转发哪个主播的流。
- 跨频道连麦中，如果目标频道的主播掉线或离开频道，源频道的主播会收到 `didOfflineOfUid` 回调。

### API 调用时序

参考如下 API 时序图实现相关代码逻辑：

![](https://web-cdn.agora.io/docs-files/1568964425915)

### 示例代码

```swift
// 配置源频道信息，其中 channelName 使用默认值，即当前的频道名；uid 使用默认值 0
let config = AgoraChannelMediaRelayConfiguration()
// 注意 sourceChannelToken 和用户加入源频道时的 Token 不一致，需要用 uid = 0 和源频道名重新生成
config.sourceInfo = AgoraChannelMediaRelayInfo(token: sourceChannelToken)
  
// 配置目标频道信息
let destinationInfo = AgoraChannelMediaRelayInfo(token: destinationChannelToken)
config.setDestinationInfo(destinationInfo, forChannelName: destinationChannelName)
// 开始跨频道媒体流转发
agoraKit.startChannelMediaRelay(config)

// 停止跨频道媒体流转发
agoraKit.stopChannelMediaRelay()
```

```swift
// 使用 channelMediaRelayStateDidChange 回调监控跨频道媒体流的状态
func rtcEngine)(_ engine: AgoraRtcEngineKit, channelMediaRelayStateDidChange state: AgoraChannelMediaRelayState, error: AgoraChannelMediaRelayError) {
  LogUtils.log(message: "channelMediaRelayStateDidChange: \(state.rawVlue) error \(error.rawValue)", level: .info)
  
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

<div class="alert note">在跨频道过程中，如果需要更新跨频道媒体流转发的信息，则可以在  <code>startChannelMediaRelay</code> 后调用<code>updateChannelMediaRelay</code> 方法。</div>


### API 参考

- [`startChannelMediaRelay`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/startChannelMediaRelay:)
- [`updateChannelMediaRelay`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/updateChannelMediaRelay:)
- [`stopChannelMediaRelay`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/stopChannelMediaRelay)
- [`channelMediaRelayStateDidChange`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:channelMediaRelayStateDidChange:error:)
- [`didReceiveChannelMediaRelayEvent`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:didReceiveChannelMediaRelayEvent:)


## 开发注意事项

- 该功能最多支持将媒体流转发至 4 个目标频道。转发过程中，如果想添加或删除目标频道，可以调用 `updateChannelMediaRelay` 方法。
- 该功能不支持 String 型用户 ID。
- 在设置源频道信息时，请确保 `uid` 必须为 0，且用于生成 token 的 `uid` 也必须为 0。
- 在成功调用 `startChannelMediaRelay` 方法后，如果想再次调用该方法，必须先调用 `stopChannelMediaRelay` 方法退出当前的转发状态。