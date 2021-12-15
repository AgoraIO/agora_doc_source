---
title: 快速切换直播频道
platform: Windows
updatedAt: 2019-09-23 17:04:35
---

## 功能描述

通常来说，如果直播观众希望切换到另外一个直播频道，需要依次调用如下方法：

- `leaveChannel`，用以离开当前频道
- `joinChannel`，用以加入新的频道

Agora Native SDK 从 v2.9.0 开始，提供新接口 `switchChannel`，帮助直播频道的观众更快实现直播频道切换。

## 实现方法

实现快速切换频道前，请确保你已在项目中实现了互动直播功能，详见开始[互动直播](start_live_windows)。

互动直播过程中，观众加入频道后只需调用 `switchChannel` 方法，就可以快速切换到另外一个直播频道。你需要在该方法中传入想要加入的新频道的 Token 和频道名。

成功调用 `switchChannel` 方法切换到其他频道后，本地会先收到离开原频道的回调 `onLeaveChannel`，再收到成功加入新频道的回调 `onJoinChannelSuccess`。

### API 调用时序

下图展示切换频道的 API 调用时序：

![](https://web-cdn.agora.io/docs-files/1569227096330)

### 示例代码

你可以参考下面的示例代码片段，调用 `switchChannel` 在项目中实现快速切换频道：

```C++
m_lpAgoraEngine->switchChannelChannel(YOUR_TOKEN, channelName)
```

### API 参考

- [switchChannel](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#a3eb5ee494ce124b34609c593719c89ab)

## 开发注意事项

`switchChannel` 方法仅适用于直播频道中的观众用户。
