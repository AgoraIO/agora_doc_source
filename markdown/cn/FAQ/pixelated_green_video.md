---
title: 为什么我的视频会出现花屏或绿屏？
platform: ["Android","iOS","macOS","Windows","Unity","Electron","React Native","Flutter"]
updatedAt: 2020-07-06 15:19:36
Products: ["Video","Interactive Broadcast"]
---
花屏指视频画面中出现颜色错误的不规则像素块，导致视频无法正常显示。

<div class="alert note">花屏与视频模糊不同。视频模糊一般由于分辨率或码率过低导致。在模糊的视频中画面依然是完整的。</div>

绿屏是指视频画面中出现绿色色块，导致视频无法正常显示。

花屏或绿屏可能由摄像头、第三方美颜 SDK、视频分辨率、或采集和渲染模块的问题导致。你可以参考以下步骤解决问题。

## 用户自检

<a id="sender_pixelated"></a>

### 发送端花屏

1. 按照以下步骤排查摄像头、第三方美颜 SDK、视频分辨率的问题：
   1. 确认摄像头是否可以正常工作。
   2. 检查第三方美颜 SDK。如果你使用了第三方美颜 SDK，尝试关闭美颜功能并检查是否花屏。如果花屏现象消失，那么可能是第三方美颜 SDK 的问题，请联系第三方美颜 SDK 的技术支持。
   3. 检查视频分辨率是否是 Agora [推荐的分辨率](https://docs.agora.io/cn/Voice/API%20Reference/cpp/structagora_1_1rtc_1_1_video_encoder_configuration.html#af10ca07d888e2f33b34feb431300da69)。如果不是，尝试改变视频分辨率。
2. 排查采集和渲染模块的问题：
    1. 如果发送端使用自采集、自渲染，你需要自行排查自采集模块的问题。如果自采集模块没有问题，再自行排查自渲染模块的问题。你可以参考 Agora 提供的[自采集](https://github.com/AgoraIO/Advanced-Video/blob/dev/backup/Custom-Media-Device/Agora-Custom-Media-Device-Android/README.zh.md)和[自渲染](https://github.com/AgoraIO/Advanced-Video/tree/master/Android/sample-custom-render)的示例项目。
    2. 如果发送端使用自采集、Agora RTC SDK 渲染，你需要自行排查自采集模块的问题。你可以参考 Agora 提供的[自采集](https://github.com/AgoraIO/Advanced-Video/blob/dev/backup/Custom-Media-Device/Agora-Custom-Media-Device-Android/README.zh.md)的示例项目。
    3. 如果发送端使用 Agora RTC SDK 采集、自渲染，你需要自行排查自渲染模块的问题。你可以参考 Agora 提供的[自渲染](https://github.com/AgoraIO/Advanced-Video/tree/master/Android/sample-custom-render)的示例项目。
    4. 如果发送端使用 Agora RTC SDK 采集、Agora RTC SDK 渲染，请[提交工单](https://agora-ticket.agora.io/)联系 Agora 技术支持。

<div class="alert note">发送端使用 YUV 数据自渲染时，检查 <code><a href="/cn/Interactive%20Broadcast/API%20Reference/cpp/structagora_1_1media_1_1_i_video_frame_observer_1_1_video_frame.html">VideoFrame</a></code> 中 <code>Stride</code> 参数和 <code>width</code> 参数的使用是否混淆。</div>

<a id="receiver_pixelated"></a>

### 接收端花屏

如果发送端和接收端同时出现花屏，你需要首先参考[发送端花屏](#sender_pixelated)排查发送端的问题。如果只有接收端花屏，请参考以下步骤排查：

1. 无论接收端使用 Agora RTC SDK 渲染还是自渲染，首先你需要排查发送端的问题。如果发送端使用了自采集，你需要检查发送端自采集的数据在传给 SDK 的过程中是否存在问题。
2. 如果接收端使用自渲染，你需要自行排查接收端自渲染模块的问题。

<div class="alert note">接收端使用 YUV 数据自渲染时，检查 <code><a href="/cn/Interactive%20Broadcast/API%20Reference/cpp/structagora_1_1media_1_1_i_video_frame_observer_1_1_video_frame.html">VideoFrame</a></code> 中 <code>Stride</code> 参数和 <code>width</code> 参数的使用是否混淆。</div>

<a id="sender_green"></a>

### 发送端绿屏

如果发送端出现绿屏，按照以下步骤排查发送端绿屏问题：

1. 按照以下步骤排查摄像头、第三方美颜 SDK、视频分辨率的问题：
   1. 确认摄像头是否可以正常工作。
   2. 检查第三方美颜 SDK。如果你使用了第三方美颜 SDK，尝试关闭美颜功能并检查是否绿屏。如果绿屏现象消失，那么可能是第三方美颜 SDK 的问题，请联系第三方美颜 SDK 的技术支持。
   3. 检查视频分辨率是否是 Agora [推荐的分辨率](https://docs.agora.io/cn/Voice/API%20Reference/cpp/structagora_1_1rtc_1_1_video_encoder_configuration.html#af10ca07d888e2f33b34feb431300da69)。如果不是，尝试改变视频分辨率。
2. 排查采集和渲染模块的问题：
   - 如果发送端使用自采集、自渲染，在使用 [`setVideoSource`](/cn/Interactive%20Broadcast/API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#aa240e991d12b5240fc5fd362cbc0d521) 设置自定义视频源时，你需要检查在 `getBufferType` 中指定的视频数据格式和通过 `IVideoFrameConsumer` 传回 SDK 的视频数据格式是否一致。如果格式不一致，需要修改为一致的格式后，再检查视频是否绿屏。如果自采集没有问题，你需要自行排查自渲染的问题。
   - 如果发送端使用自采集、Agora RTC SDK 渲染，你需要自行排查自采集模块的问题。在使用 [`setVideoSource`](/cn/Interactive%20Broadcast/API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#aa240e991d12b5240fc5fd362cbc0d521) 设置自定义视频源时，你还需要检查在 `getBufferType` 中指定的视频数据格式和通过 `IVideoFrameConsumer` 传回 SDK 的视频数据格式是否一致。如果格式不一致，需要修改为一致的格式后，再检查视频是否绿屏。如果自采集模块没有问题，你还需要检查自采集的数据在传给 SDK 的过程中是否存在问题。
   - 如果发送端使用 Agora RTC SDK 采集、自渲染，你需要自行排查自渲染模块的问题。
   - 如果发送端使用 Agora RTC SDK 采集、Agora RTC SDK 渲染，请[提交工单](https://agora-ticket.agora.io/)联系 Agora 技术支持。

<div class="alert note">对于 Android 平台，如果你在通信场景下使用自采集，请检查使用的视频数据格式是否是 Texture。Agora RTC SDK for Android 不支持在通信场景下接收 Texture 格式的视频数据，你需要更换为 YUV 格式之后，再检查视频是否绿屏。</div>

<a id="receiver_green"></a>

### 接收端绿屏

如果发送端和接收端同时出现绿屏，你需要首先参考[发送端绿屏](#sender_green)排查发送端的问题。如果只有接收端绿屏，请参考以下排查步骤。

- 无论接收端使用 Agora RTC SDK 渲染还是自渲染，首先你需要排查发送端的问题。如果发送端使用了自采集，你需要检查发送端自采集的数据在传输给 SDK 的过程中是否存在问题。发送端在使用 [`setVideoSource`](/cn/Interactive%20Broadcast/API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#aa240e991d12b5240fc5fd362cbc0d521) 设置自定义视频源时，你还需要检查在 `getBufferType` 中指定的视频数据格式和通过 `IVideoFrameConsumer` 传回 SDK 的视频数据格式是否一致。如果格式不一致，需要修改为一致的格式后，再检查接收端视频是否绿屏。

<div class="alert note">对于 Android 平台，如果你在通信场景下使用自采集，请检查使用的视频数据格式是否是 Texture。Agora RTC SDK for Android 不支持在通信场景下接收 Texture 格式的视频数据，你需要更换为 YUV 格式之后，再检查视频是否绿屏。</div>

## 联系技术支持

如果上述的自查无法帮助你解决问题，请[提交工单](https://agora-ticket.agora.io/)联系 Agora 技术支持。为了更好地帮助您快速解决问题，请提供以下信息。


### 必要信息

- 出现花屏、绿屏的频道名。
- 出现花屏、绿屏时，发送端和接收端用户的 UID 以及设备型号。
- 花屏、绿屏的截图。
- 问题出现的时间点或时间段。
- 发送端和接收端的采集和渲染方式：Agora RTC SDK 采集、自采集、Agora RTC SDK 渲染、自渲染。
- SDK 日志文件，参考[如何设置日志文件](https://docs.agora.io/cn/faq/logfile)。

### 更多信息

- 用其他分辨率可否重现花屏和绿屏。
- 其他应用是否出现花屏和绿屏。
- 在其他机型上可否重现花屏和绿屏。