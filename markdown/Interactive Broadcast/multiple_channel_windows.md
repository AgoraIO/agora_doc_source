---
title: 加入多频道
platform: Windows
updatedAt: 2020-11-16 07:11:12
---

## 功能描述

为方便用户同时加入多个频道，接收多个频道的音视频流，Agora RTC Native SDK 3.0 及以上版本支持多频道管理，且频道数量无限制。

该功能可应用于类似超级小班课的场景：将一个互动大班里的学生分到不同的小班，学生可以在小班内进行实时音视频互动。根据场景需要，你还可以给每个小班可以配备一名助教老师。

<div class="alert note">多频道功能适用于直播场景，通信场景下不建议使用此功能。</div>

## 示例项目

我们在 GitHub 提供两个实现了多频道功能的开源示例项目，你可以前往下载体验，参考源代码。

- [MultiChannel](https://github.com/AgoraIO/API-Examples/tree/master/windows/APIExample/APIExample/Advanced/MultiChannel)
- [Breakout Class](https://github.com/AgoraIO-Usecase/Breakout-Class/tree/master/breakout-windows)

## 实现方法

SDK 提供 `IChannel` 类和 `IChannelEventHandler` 类实现多频道控制。

你可以多次调用 `createChannel`，通过不同的 `channelId` 创建多个 `IChannel` 对象（对应多个频道），然后分别调用 `IChannel` 中的 `joinChannel` 方法加入对应的频道。

实现多频道功能的主要步骤如下：

1. 调用 `createAgoraRtcEngine` 和 `initialize` 方法，创建并初始化 `IRtcEngine`。
2. 调用 `setChannelProfile `方法，将频道场景设置为直播。
3. 调用 `createChannel` 方法，通过 `channelId` 创建一个 `IChannel` 对象。
4. 调用 `IChannel` 类的 `setChannelEventHandler `方法，接收该频道的回调通知。
5. 调用 `IChannel` 类的 `joinChannel` 方法加入频道。
6. 根据需要，选择以下一种方式发布本地流：
   - 在 `IRtcEngine` 类的频道中发布本地流：调用 `IRtcEngine` 类的 `setClientRole` 方法将用户角色设置为主播，然后调用 `joinChannel` 方法加入频道，SDK 会自动发布流。这种方式适用于只需要将本地流固定发布到 `IRtcEngine` 类的频道的场景。
   - 在 `IChannel` 类的频道中发布本地流：调用 `IChannel` 类的 `setClientRole` 方法将用户角色设置为主播，然后调用 `publish` 方法在该频道内发布流。这种方式适用于需要切换发流的频道的场景。
7. 如果需要加入更多的频道，重复步骤 3、4、5。

<div class="alert note">
	<li>在 <code>IChannel</code> 类中调用 <code>publish</code> 方法之前，必须先调用 <code>setClientRole</code> 将用户角色设置为主播。</li>
	<li>加入多个频道时，请确保每个频道的频道名不同。</li>
	<li>同一时间，本地的音视频流只能发布到一个频道。如果你的场景需要切换发布本地流的频道，我们建议在 <code>IChannel</code> 类的频道中发布本地流，在切换发流频道前必须先调用 <code>unpublish</code> 取消当前的发布。</li>
</div>

### API 调用时序

加入多个频道，且在 `IRtcEngine` 类的频道中发布本地流的 API 时序如下：

![多频道时序图1](https://web-cdn.agora.io/docs-files/1605510618414)

加入多个频道，且在 `IChannel` 类的频道中发布本地流的 API 时序如下：

![多频道时序图2](https://web-cdn.agora.io/docs-files/1605510635577)

### 示例代码

下面的示例代码演示了如何加入一个 `IRtcEngine` 类的频道和一个 `IChannel` 类的频道，且在 `IRtcEngine` 类的频道中发布本地流。

1. 创建并初始化 `IRtcEngine` 对象。

```cpp
m_rtcEngine = createAgoraRtcEngine();
RtcEngineContext context;
std::string strAppID = GET_APP_ID;
context.appId = strAppID.c_str();
m_eventHandler.SetMsgReceiver(m_hWnd);
context.eventHandler = &m_eventHandler;
int ret = m_rtcEngine->initialize(context);
```

2. 启用视频模块。

```cpp
m_rtcEngine->enableVideo();
```

3. 将频道场景设置为直播场景。

```cpp
m_rtcEngine->setChannelProfile(CHANNEL_PROFILE_LIVE_BROADCASTING);
```

4. 设置用户角色为主播。

```cpp
m_rtcEngine->setClientRole(CLIENT_ROLE_BROADCASTER);
```

5. 传入 `token` 和 `channelId`, 加入 `IRtcEngine` 对象的频道。加入 `IRtcEngine` 类的频道后，SDK 会自动发布本地流。

```cpp
m_rtcEngine->joinChannel(APP_TOKEN, ChannelId, "", 0)；
```

6. 创建并获取一个 `IChannel` 对象，并监听该频道的回调通知。

```cpp
IChannel * pChannel = static_cast<IRtcEngine2 *>(m_rtcEngine)->createChannel(szChannelId.c_str());
ChannelEventHandler* pEvt = new ChannelEventHandler;
pEvt->setMsgHandler(GetSafeHwnd());
m_channels.emplace_back(szChannelId, pChannel, pEvt);
pChannel->setChannelEventHandler(pEvt);
```

7. 加入 `IChannel` 对象对应的频道。加入频道后，SDK 会自动订阅音视频流。

```cpp
pChannel->joinChannel(APP_TOKEN, "", 0, options);
```

8. 离开并销毁 `IChannel` 对象的频道。

```cpp
pChannel->leaveChannel();
pChannel->release();
```

9. 离开 `IRtcEngine` 对象的频道，并销毁 `IRtcEngine` 对象。

```cpp
m_rtcEngine->leaveChannel();
m_rtcEngine->release(true);
```

### API 参考

- [`createChannel`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine2.html#a9cabefe84d3a52400f941f1bd8c0f486)
- [`IChannel`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_channel.html) 类
- [`IChannelEventHandler`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_channel_event_handler.html) 类

## 开发注意事项

### 精细订阅限制

如果在加入 `IChannel` 类的频道时，将媒体订阅选项设置为不自动订阅音频流或视频流，加入频道后，`muteRemoteAudioStream` 或 `muteRemoteVideoStream` 方法会失效。

<div class="alert info"><code>IChannel</code> 中的 <code>joinChannel</code> 方法中提供媒体订阅选项设置（<code>autoSubscribeAudio</code> 和 <code>autoSubscribeVideo</code>），可以控制在加入频道后是否自动订阅音频流和视频流，默认为自动订阅。</div>

如果你需要在加入 `IChannel` 的频道时仅接收指定用户的音频流或视频流，Agora 建议使用以下方法：

1. 在加入该频道前调用 `IChannel` 中的 `setDefaultMuteAllRemoteAudioStreams(true)` 或 `setDefaultMuteAllRemoteVideoStreams(true)` 设置默认不接收该频道的所有音频流或所有视频流。
2. 调用 `IChannel` 中的 `joinChannel` 加入频道（媒体订阅选项使用默认设置）。
3. 调用 `IChannel` 中的 `muteRemoteAudioStream(false)` 或 `muteRemoteVideoStream(false)` 接收指定用户的音频流或视频流。

### 设置远端视图

在视频场景中，如果远端用户是通过 `IChannel` 加入频道的，那么在设置远端视图时，还需要在 [VideoCanvas](./API%20Reference/cpp/v3.0.0/structagora_1_1rtc_1_1_video_canvas.html) 中指定该远端用户所在频道的 channel ID，否则会无法渲染出远端视频画面。

### 多频道发流限制

SDK 仅支持用户同一时间在一个频道内发布媒体流。因此只要你在一个频道内正在发布流，就无法在另一个频道发布。

由于通过 `IRtcEngine` 类和 `IChannel` 类下的 `joinChannel` 方法加入频道后，SDK 的默认行为有以下差异：

- `IRtcEngine` 类下，SDK 默认发布本地音视频流到本频道。
- `IChannel` 类下，SDK 默认不发布本地音视频流到本频道。

因此，以下操作会导致 SDK 返回 `ERR_REFUSED(5)` 错误码：

- 通过 `IChannel` 类加入多频道：

  - 调用频道一的 `publish` 方法后，未调用频道一的 `unpublish` 方法结束发布，就调用频道二的 `publish` 方法。

- 通过混用 `IRtcEngine` 类和 `IChannel` 类加入多频道：

  - 通过 `IRtcEngine` 类加入频道一，然后通过 `IChannel` 类加入频道二后，试图调用 `IChannel` 类的 `publish` 方法。
  - 加入多个频道后，试图以观众身份调用 `IChannel` 类的 `publish` 方法。
  - 调用 `IChannel` 类的 `publish` 方法后，未调用对应 `IChannel` 类的 `unpublish` 方法，就试图通过 `IRtcEngine` 类的 `joinChannel` 方法加入频道。
