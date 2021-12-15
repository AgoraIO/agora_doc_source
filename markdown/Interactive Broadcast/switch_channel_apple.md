---
title: 快速切换直播频道
platform: iOS
updatedAt: 2020-04-15 15:50:33
---

## 功能描述

通常来说，如果直播观众希望切换到另外一个直播频道，需要依次调用如下方法：

- `leaveChannel`，用以离开当前频道
- `joinChannelByToken`，用以加入新的频道

Agora Native SDK 从 v2.9.0 开始，提供新接口 `switchChannelByToken`，帮助直播频道的观众更快实现直播频道切换。

## 实现方法

实现快速切换频道前，请确保你已在项目中实现了互动直播功能，详见开始如下文档：

- iOS：[开始互动直播](start_live_ios)
- macOS: [开始互动直播](start_live_mac)

互动直播过程中，观众加入频道后只需调用 `switchChannelByToken` 方法，就可以快速切换到另外一个直播频道。你需要在该方法中传入想要加入的新频道的 Token 和频道名。

成功调用 `switchChannelByToken` 方法切换到其他频道后，本地会先收到离开原频道的回调 `didLeaveChannel`，再收到成功加入新频道的回调 `didJoinChannel`。

### API 调用时序

下图展示切换频道的 API 调用时序：

![](https://web-cdn.agora.io/docs-files/1569228400516)

### 示例代码

你可以参考下面的示例代码片段，调用 `switchChannel` 在项目中实现快速切换频道：

```swift
agoraKit.switchChannel(byToken: nil, channelId: channel.channelName, joinSuccess: nil)
```

同时，我们在 GitHub 提供一个开源的 [Quick-Switch-iOS](https://github.com/AgoraIO/Advanced-Video/tree/dev/backup/Quick-Switch-Channel/Quick-Switch-iOS) 示例项目，你也可以前往下载体验并参考源代码。

### API 参考

- [switchChannelByToken](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/switchChannelByToken:channelId:joinSuccess:)

## 开发注意事项

`switchChannelByToken` 方法仅适用于直播频道中的观众用户。
