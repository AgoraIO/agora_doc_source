---
title: 推流到 CDN
platform: Android
updatedAt: 2021-01-07 08:26:53
---
## 功能描述

将直播媒体流发布到 CDN (Content Delivery Network) 的过程称为 CDN 直播推流。用户无需安装 App 即可通过 Web 浏览器观看直播。

在推流到 CDN 过程中，当频道中有多个主播时，通常会涉及到[转码](terms#transcoding)，将多个直播流组合成单个流，并设置这个流的音视频属性和合图布局。

<div class="alert note">本服务为收费服务，详见<a href="https://docs.agora.io/cn/Interactive%20Broadcast/faq/client_streaming_billing"> RTMP 推流收费</a>。</div>

![](https://web-cdn.agora.io/docs-files/1588993718649)

## 前提条件

请确保已开通 CDN 旁路推流功能，步骤如下：
1. 登录[控制台](https://console.agora.io)，点击左侧导航栏 ![img](https://web-cdn.agora.io/docs-files/1551250582235) 按钮进入**产品用量**页面。
2. 在页面左上角展开下拉列表选择需要开通 CDN 旁路推流的项目，然后点击旁路推流下的**分钟数**。
![](https://web-cdn.agora.io/docs-files/1569297956098)
<div class="alert note"><b>旁路推流服务</b>仅适用于 Native SDK 2.4.1 及以上版本和 Web SDK 2.9.0 及以上版本，若您使用的版本较低，建议升级至新版本。</div>
3. 点击**开启旁路推流服务**。
4. 点击**应用** 即可开通旁路推流服务，并得到 500 个最大并发频道数。

<div class="alert note"> 并发频道数 N，指用户可以同时使用 N 路流进行推流转码。</div>

开通成功后，你可以在用量页面看到旁路推流的使用情况。

## 实现方法

在实现推流到 CDN 功能前，请确保你已在项目中完成基本的音视频功能。详见[开始互动直播](start_live_android)。

参考如下步骤，在你的项目中实现推流到 CDN：

<a name="single"></a>
1. 频道内主播可以调用 `setLiveTranscoding` 方法设置音视频流的直播参数 （`LiveTranscoding`），如分辨率、码率、帧率、水印和背景色位置。如果你需要多主播转码合图，请在 `TranscodingUser` 类中设置每个主播的参数，详见[示例代码](#trans)。

2. 频道内主播可以调用 `addPublishStreamUrl` 方法向 CDN 推流直播中增加指定的一路媒体流。推流地址可以在推流后动态增删。

   > 请通过 `transcodingEnabled` 设置是否转码推流。
  
3. （可选）频道内主播再次调用 `setLiveTranscoding` 方法更新音视频流的直播参数 （`LiveTranscoding`）。

	> 直播参数（`LiveTranscoding`）有更新，`onTranscodingUpdated` 回调会被触发并向主播报告更新信息。

4. 频道内主播可以调用 `removePublishStreamUrl` 方法向 CDN 推流直播中删除指定的一路媒体流。

推流状态改变时，SDK 会触发 `onRtmpStreamingStateChanged` 回调向主播报告当前推流状态。请确保收到该回调后再调用 API 进行下一步操作。如果增加或删除一个推流地址失败，请通过错误码排查问题。更多问题请参考[注意事项](#consideration)。

<a name="trans"></a>
### 示例代码

```java
// Java
// CDN 推流参数设置。
LiveTranscoding config = new LiveTranscoding();
config.audioSampleRate = TYPE_44100;
config.audioChannels = 2;
config.audioBitrate = 48;
// 用于旁路推流的输出视频流的总宽度 (px)。360 为默认值。
config.width = 360;
// 用于旁路推流的输出视频流的总高度 (px)。640 为默认值。
config.height = 640;
// 设置推流输出视频的码率 (Kbps)，默认值为 400。
config.videoBitrate = 400;
// 用于旁路推流的输出视频的帧率 (fps)。默认值为 15。取值范围为 [1,30]，Agora 服务器会将高于 30 的帧率设置改为 30。
config.videoFramerate = 15;
// 如果 userCount > 1，则需要为每个 transcodingUser 分别设置布局。
config.userCount = 1;  
// 推流输出视频的编码规格。可以设置为 Baseline (66)、Main (77) 或 High (100)。如果设置其他值，Agora 会统一设为默认值 High (100)。
config.videoCodecProfile = HIGH;

//分配用户视窗的合图布局。
LiveTranscoding transcoding = new LiveTranscoding();
LiveTranscoding.TranscodingUser user = new LiveTranscoding.TranscodingUser();
// 下面的 uid 应和 joinChannel() 输入的 uid 保持一致。
user.uid = 123456;
transcoding.addUser(user);
user.x = 0;
user.audioChannel = 0;
user.y = 0;
user.width = 640;
user.height = 720;

// CDN 推流参数设置。注意：调用这个接口前提是需要转码；否则，就不要调用这个接口。
rtcEngine.setLiveTranscoding(transcoding);

// 添加一个推流地址。transcodingEnabled 设置为 true，表示开启转码。如开启，则必须通过 setLiveTranscoding 接口配置 LiveTranscoding 类。单主播模式下，我们不建议使用转码。
rtcEngine.addPublishStreamUrl(url, true);

// 删除一个推流地址。
rtcEngine.removePublishStreamUrl(url);
```

**合图示例1：两人横向平铺**

<img alt="../_images/sei_2host.png" src="https://web-cdn.agora.io/docs-files/cn/sei_2host.png" style="width: 500px;"/>

```c++
Canvas:
     width: 640
     height: 360
     backgroundColor: #FFFFFF

User0:
      userId: 123
      x: 0
      y: 0
      width: 320
      height: 360
      zOrder: 1
      alpha: 1.0

User1:
      userId: 456
      x: 320
      y: 0
      width: 320
      height: 360
      zOrder: 1
      alpha: 1.0
```

**合图示例2：三人纵向平铺**

<img alt="../_images/sei_3host.png" src="https://web-cdn.agora.io/docs-files/cn/sei_3host.png" style="width: 370px;"/>

```c++
Canvas:
      width: 360
      height: 640
      backgroundColor: #FFFFFF

   User0:
      userId: 123
      x: 0
      y: 0
      width: 360
      height: 640
      zOrder: 1
      alpha: 1.0

   User1:
       userId: 456
       x: 0
       y: 320
       width: 180
       height: 320
       zOrder: 2
       alpha: 1.0

   User2:
       userId: 789
       x: 180
       y: 320
       width: 180
       height: 320
       zOrder: 2
       alpha: 1.0
```

**合图示例3：1 人全屏 + N 人悬浮小窗**

<img alt="../_images/sei_random.png" src="https://web-cdn.agora.io/docs-files/cn/sei_random.png" style="width: 370px;"/>

```c++
Canvas:
   width: 360
   height: 640
   backgroundColor: #FFFFFF

User0:
   userId: 123
   x: 0
   y: 0
   width: 360
   height: 640
   zOrder: 1
   alpha: 1.0

User1:
    userId: 456
    x: 45
    y: 390
    width: 110
    height: 213
    zOrder: 2
    alpha: 1.0

User2:
    userId: 789
    x: 185
    y: 390
    width: 110
    height: 213
    zOrder: 2
    alpha: 1.0
```

同时，我们在 GitHub 提供一个开源的 [Live-Streaming](https://github.com/AgoraIO/Advanced-Interactive-Broadcasting/tree/master/Live-Streaming) 示例项目。

### API 参考

- [`setLiveTranscoding`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a3cb9804ae71819038022d7575834b88c)
- [`addPublishStreamUrl`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a4445b4ca9509cc4e2966b6d308a8f08f)
- [`removePublishStreamUrl`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a87b3f2f17bce8f4cc42b3ee6312d30d4)
- [`onTranscodingUpdated`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#afcacc60191697a4105364d1b0c411eb1)
- [`onRtmpStreamingStateChanged`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a7b9f1a5d87480cfd6187c3da0ade3f94)

<a name="consideration"></a>
## 注意事项

- 同一频道内最多支持 17 位主播。
- 本服务为收费服务，Agora 按照音视频转码时长来计费。
- 如果对单主播不经过转码直接推流，请略过[步骤 1](#single)，直接调用 `addPublishStreamUrl` 方法并设置 `transcodingEnabled (false)` 。
- 你可以参考[视频分辨率表格](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1video_1_1_video_encoder_configuration.html#a4b090cd0e9f6d98bcf89cb1c4c2066e8)设置 `videoBitrate` 的值。如果设置的码率超出合理范围，Agora 服务器会在合理区间内自动调整码率值。
- 请确保转码推流和非转码推流中使用的流地址不同。
