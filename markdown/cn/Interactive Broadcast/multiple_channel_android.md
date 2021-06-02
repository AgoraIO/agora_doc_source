---
title: 加入多频道
platform: Android
updatedAt: 2020-11-16 07:12:42
---
## 功能描述

为方便用户同时加入多个频道，接收多个频道的音视频流，Agora Native SDK 自 v3.0 起新增支持多频道管理，且频道数量无限制。

该功能可应用于类似超级小班课的场景：将一个互动大班里的学生分到不同的小班，学生可以在小班内进行实时音视频互动。根据场景需要，你还可以给每个小班可以配备一名助教老师。

## 实现方法
Native SDK 通过一个 `RtcChannel` 类和 `IRtcChannelEventHandler` 类实现多频道控制。你可以从如下任一种方法实现该功能：

### 方法一：仅使用 RtcChannel 类实现

参考如下步骤在项目中实现多频道功能：

1. 调用 `RtcEngine` 类的 `createRtcChannel` 方法，通过 `channelId` 创建一个 `RtcChannel` 对象。
2. 调用 `RtcChannel` 对象中的 `joinChannel` 方法加入频道。
3. 重复步骤 1、2，创建多个 `RtcChannel` 对象，然后分别调用这些 `RtcChannel` 对象中的 `joinChannel` 方法，同时加入多个频道。

<div class="alert note">
	<li>加入多个频道后，你可以调用各 <code>RtcChannel</code> 对象中的 <code>publish</code> 方法在对应的频道中发布音视频流。但需要注意，一次只能在一个 <code>RtcChannel</code> 对象的频道里发布。
	<li>调用频道一内的 <code>publish</code> 方法发布流后，必须先调用频道一的 <code>unpublish</code> 方法结束发布，才能调用频道二的 <code>publish</code> 方法。</div>

该方法适用于需求频繁切换发布音、视频流频道的场景。

**API 调用时序**

参考如下步骤，在你的项目中使用 `RtcChannel` 类实现多频道功能。

![](https://web-cdn.agora.io/docs-files/1575868780563)

**示例代码**

你还可以参考如下示例代码。

```Java
    public  boolean joinChannelWithRtcChannel(String channelId, String token, String info, int uid)
    {

        // 1. Create rtcEngine
        RtcEngine rtcEngine = RtcEngine.create(mContext, SConstants.MEDIA_APP_ID, new IRtcEngineEventHandler() {
            // Override events

            @Override
            public void onJoinChannelSuccess(String channel, int uid, int elapsed) {
                super.onJoinChannelSuccess(channel, uid, elapsed);
            }
        });

        // 2. Create rtcChannel
        RtcChannel rtcChannel = rtcEngine.createRtcChannel(channelId);
        if (null == rtcChannel) return false;

        // 3. Set rtcChannelEventHandler
        rtcChannel.setRtcChannelEventHandler(new IRtcChannelEventHandler() {
            // Override events

            @Override
            public void onJoinChannelSuccess(RtcChannel rtcChannel, int uid, int elapsed) {
                super.onJoinChannelSuccess(rtcChannel, uid, elapsed);
            }
        });

        // 4. Configurate mediaOptions
        ChannelMediaOptions mediaOptions = new ChannelMediaOptions();
        mediaOptions.autoSubscribeAudio = true;
        mediaOptions.autoSubscribeVideo = true;

        // 5. Join channel
        int ret = rtcChannel.joinChannel(token, info, uid, mediaOptions);

        return (ret == 0);
    }
```

### 方法二：混用 RtcChannel 和 RtcEngine 类

参考如下步骤在项目中实现多频道功能：

1. 调用 `RtcEngine` 类下的 `joinChannel` 方法加入第一个频道。
2. 调用 `RtcEngine` 类的 `createRtcChannel` 方法，通过 `channelId` 创建一个 `RtcChannel` 对象。
3. 调用 `RtcChannel` 对象中的 `joinChannel` 方法加入第二个频道。
4. 重复步骤 2、3，创建多个 `RtcChannel` 对象，然后分别调用这些 `RtcChannel` 对象中的 `joinChannel` 方法，加入更多频道。

该方法适用于只需要将音、视频流固定发布到某个频道的场景。对于已经使用 Agora SDK 实现实时音视频功能的开发者，该方法不涉及原有代码逻辑变动。

**API 调用时序**

参考如下步骤，在你的项目中使用 `RtcEngine` 和 `RtcChannel` 类实现多频道功能。

![](https://web-cdn.agora.io/docs-files/1575868802804)

我们在 GitHub 提供一个实现了多频道功能的开源示例项目 [Breakout Class](https://github.com/AgoraIO-Usecase/Breakout-Class/tree/master/breakout-android)，你可以前往下载体验，了解其中的源代码。

### API 参考

- [`createRtcChannel`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a9eb0770851a8ba489564f72f9b280bca)
- [`RtcChannel`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_channel.html) 类
- [`IRtcChannelEventHandler`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_channel_event_handler.html) 类

## 开发注意事项

### 设置远端视图

在视频场景中，如果远端用户是通过 `RtcChannel` 加入频道的，那么在设置远端视图时，还需要在 [VideoCanvas](./API%20Reference/java/v3.0.0/classio_1_1agora_1_1rtc_1_1video_1_1_video_canvas.html)  中指定该远端用户所在频道的 channel ID，否则会无法渲染出远端视频画面。

### 多频道发流限制

SDK 仅支持用户同一时间在一个频道内发布音、视频流。因此只要你在一个频道内正在发布音、视频流，就无法在另一个频道发布。

由于通过 `RtcEngine` 类和 `RtcChannel` 类下的 `joinChannel` 方法加入频道后，SDK 的默认行为有以下差异：

- `RtcEngine` 类下，SDK 默认发布本地音视频流到本频道
- `RtcChannel` 类下，SDK 默认不发布本地音视频流到本频道

因此，以下操作会导致 SDK 返回 `ERR_REFUSED(5)` 错误码：

- 通过 `RtcChannel` 类加入多频道：
  - 调用频道一的 `publish` 方法后，未调用频道一的 `unpublish` 方法结束发布，就调用频道二的 `publish` 方法；
- 通过混用 `RtcEngine` 类和 `RtcChannel` 类加入多频道：
  - 通信场景下，通过 `RtcEngine` 类加入频道一，然后通过 `RtcChannel` 类加入频道二后，试图调用 `RtcChannel` 类的 `publish` 方法；
  - 直播场景下，以主播身份通过 `RtcEngine` 类加入频道一，然后通过 `RtcChannel` 类加入频道二后，试图调用 `RtcChannel` 类的 `publish` 方法；
  - 直播场景下，加入多个频道后，试图以观众身份调用 `RtcChannel` 类的 `publish` 方法；
  - 调用 `RtcChannel` 类的 `publish` 方法后，未调用对应 `RtcChannel` 类的 `unpublish` 方法，就试图通过 `RtcEngine` 类的 `joinChannel` 方法加入频道。


