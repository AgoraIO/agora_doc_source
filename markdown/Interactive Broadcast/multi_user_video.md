---
title: 多人视频场景
platform: All Platforms
updatedAt: 2021-01-04 07:42:16
---

## 概述

在视频通话或直播场景中，如果多个用户同时发流，由于设备性能消耗和网络流量的上升，可能带来比较大的体验下降。

本文展示如何使用 Agora RTC SDK 实现多人视频通话或直播，以及相关的集成注意事项。通过合理的集成方式，Agora 可以支持多达 17 人同时发视频流。

多人视频通信或直播场景下，为降低带宽占用、确保通话流畅，Agora 建议所有发流端开启[双流模式](https://docs.agora.io/cn/Agora%20Platform/terms?platform=All%20Platforms#dual-stream)，接收端设置 1-N 订阅模式，即订阅一路大流和 N 路小流。

## 实现方法

在实现如下步骤前，请确保已在你的项目中实现基本的实时音视频通信功能。详见[实现视频通话](https://docs.agora.io/cn/Video/start_call_android?platform=Android)或[实现视频直播](https://docs.agora.io/cn/Interactive%20Broadcast/start_live_android?platform=Android)。

<div class="alert note">使用通信<a href="https://docs.agora.io/cn/Agora Platform/terms?platform=All Platforms#channel-profile">频道场景</a>时，Agora 建议你在加入频道前调用 <code> setParameters("{"che.audio.live_for_comm": true}")</code>，启用针对多人通信场景的优化策略。  
如果你使用的是 v2.3.2 或之前版本的 RTC Native SDK，还需要调用 <code>setParameters("{\"che.video.moreFecSchemeEnabled\": true}")</code>开启 ULP FEC，提高视频数据传输的可靠性。</div>

### Native 端

 <div class="alert note">本节适用于 Android、iOS、macOS、Windows、Electron 和 Unity 平台。</div>

#### 1. 开启双流模式

加入频道后，各发流端调用 `enableDualStreamMode` 方法开启双流模式。开启后，SDK 会在发送视频流的同时，额外发送一路分辨率低、码率低的视频流。其中，原视频流也称为大流，分辨率和码率更低的那路流则为小流。

SDK 会根据大流的视频属性，自动设置小流的默认视频属性。

#### 2. 设置订阅流类型

接收端再调用 `setRemoteVideoStreamType` 方法，将订阅的一路视频流设为大流，其它路视频流均设置为小流。

#### 3. 手动设置小流视频属性

为保证通信流畅，Agora 建议你调用如下方法自定义小流参数，防止因小流码率过高而造成带宽压力。

小流最高可支持 640 × 480 px，30 fps，和 1000 Kbps。但是为保证通信质量，Agora 建议自定义的小流分辨率不超过 320 × 180 px，码率不超过 140 Kbps，且小流帧率不能超过大流帧率。

```
// 自定义视频小流参数设置：320 px × 180 px, 5 fps, 140 Kbps``setParameters(``"{\"che.video.lowBitRateStreamParameter\":{\"width\":320,\"height\":180,\"frameRate\":5,\"bitRate\":140}}"``);
```

#### API 参考

- [`enableDualStreamMode`](https://docs.agora.io/cn/Interactive%20Broadcast/API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a645cb7d0f3a59dda27b157cf130c8c9a)
- [`setRemoteVideoStreamType`](https://docs.agora.io/cn/Interactive%20Broadcast/API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a51756b4d2e7997fbe6481d2deb5c0396)

### Web 端

 <div class="alert note">本节适用于 Web 平台。</div>

#### 1. 开启双流模式

成功调用 `Stream.init `方法后，各发流端调用 `enableDualStreamMode` 方法开启双流模式。开启后，SDK 会在发送视频流的同时，额外发送一路分辨率低、码率低的视频流。其中，原视频流也称为大流，分辨率和码率更低的那路流则为小流。

对于 v3.1.0 版本及之后的 Web SDK，小流的视频属性默认值固定为分辨率（宽 × 高） 160 × 120，码率 50 Kbps，帧率 15 fps。在 v3.1.0 之前的版本中，SDK 会根据大流的视频属性设置默认的小流视频属性，详见大小流默认视频参数对照表。

#### 2. 设置订阅流类型

接收端再调用 `setRemoteVideoStreamType` 方法，将订阅的一路视频流设为大流，其它视频流均设置为小流。

#### 3. 手动设置小流视频属性

如果你不想要使用默认的小流视频属性，还可以调用` Client.setLowStreamParameter` 自定义小流参数，防止因小流码率过高而造成带宽压力。

 <div class="alert note"><ul>
     <li>从 v3.1.0 版本开始，手动设置的小流的宽高比如果和大流不一致，SDK 会自动修改小流的高，以保持宽高比一致。</li><li>由于不同的浏览器对于视频属性有不同的限制，通过该接口设置的视频参数不一定都会生效。目前发现的未能充分适配的浏览器有 Firefox：在 Firefox 浏览器上，设置帧率不生效。浏览器本身会将帧率固定在 30 fps。</li>
     </ul></div>

#### 4. 发布和订阅流

完成设置后，调用` Client.publish` 方法[发布本地流](https://docs.agora.io/cn/Interactive%20Broadcast/start_live_web?platform=Web#发布本地流)，调用`Client.subscribe`方法[订阅远端流](https://docs.agora.io/cn/Interactive%20Broadcast/start_live_web?platform=Web#订阅远端流) 。

#### API 参考

- [`enableDualStream`](https://docs.agora.io/cn/Interactive%20Broadcast/API%20Reference/web/interfaces/agorartc.client.html#enabledualstream)
- [`setRemoteVideoStreamType`](https://docs.agora.io/cn/Interactive%20Broadcast/API%20Reference/web/interfaces/agorartc.client.html#setremotevideostreamtype)
- [`setLowStreamParameter`](https://docs.agora.io/cn/Interactive%20Broadcast/API%20Reference/web/interfaces/agorartc.client.html#setlowstreamparameter)

## 大小流视频属性对应关系

### Native 端

 <div class="alert note">本节适用于 Android、iOS、macOS、Windows、Electron 和 Unity 平台。</div>

SDK 根据大流的视频属性自动设置小流的视频属性。如果你无需手动设置小流视频属性，可以参考本节内容，了解大流和小流视频属性的对应关系。

#### 通信场景大小流对应关系

通信场景下，小流的默认视频属性遵循以下规则：

- 小流宽高 = 大流宽高 × 0.45，且最大不超过 288，最小不低于 64，且保持比例
- 小流帧率固定为 5
- 小流码率 = 大流码率 × 0.1
- 小流的宽必须为 4 的倍数，高必须为偶数

#### 直播场景大小流对应关系

下表展示直播场景时，不同的大流宽高比下，小流默认的分辨率、码率和帧率。

| 大流宽高比 | 小流分辨率（宽 x 高，px）                          | 小流码率（Kbps） | 小流帧率（fps） |
| :--------- | :------------------------------------------------- | :--------------- | :-------------- |
| 1：1       | 160 × 160                                          | 68               | 5               |
| 3：4       | 120 × 160                                          | 45               | 5               |
| 4：3       | 160 × 120                                          | 45               | 5               |
| 9：16      | 108 × 192                                          | 50               | 5               |
| 16：9      | 192 × 108                                          | 50               | 5               |
| 其他宽高比 | 宽高中的较大值取 160，较小值根据大流宽高比计算得出 | 68               | 5               |

#### 主流分辨率大小流视频属性对应表

你也可以参考下表，了解主流视频大流参数下，默认的小流参数，各数字依次表示宽 × 高、帧率、码率。注意下表中的大流参数为通信场景下的视频参数；直播场景下，大流的码率对照表中的值翻倍，但取值不能超过 6500。

| 大流参数             | 通信场景小流参数  | 直播场景小流参数 |
| :------------------- | :---------------- | :--------------- |
| 320 × 240，15，200   | 144 × 108，5，20  | 160 × 120，5，45 |
| 640 × 360，15，400   | 288 × 162，5，40  | 192 × 108，5，50 |
| 640 × 480，15，500   | 288 × 216，5，50  | 160 × 120，5，45 |
| 1280 × 720，15，1130 | 288 × 162，5，113 | 192 × 108，5，50 |
| 240 × 320，15，200   | 108 × 144，5，20  | 120 × 160，5，45 |
| 240 × 320，15，200   | 108 × 144，5，20  | 120 × 160，5，45 |
| 360 × 640，15，400   | 164 × 288，5，40  | 108 × 192，5，50 |
| 480 × 640，15，500   | 216 × 288，5，50  | 120 × 160，5，45 |
| 720 × 1280，15 1130  | 164 × 288，5，113 | 108 × 192，5，50 |

### Web 端

 <div class="alert note">本节内容仅适用于 v3.1.0 之前版本的 RTC Web SDK。</div>

对于 v3.0.1 之前的版本，SDK 会根据大流的视频属性自动设置小流的视频属性。参考下表了解不同的大流视频属性下对应的小流视频属性。

| 大流视频参数                       | 小流视频参数 |
| :--------------------------------- | :----------- |
| `360P_1360P_4360P_9360P_10360P_11` | `90P_1 `     |
| ` 360P_3360P_6`                    | `120P_3`     |
| ` 360P_7360P_8`                    | `120P_1 `    |
| `480P_1480P_2480P_4480P_10`        | `120P_1 `    |
| `480P_3480P_6 `                    | `120P_3 `    |

各视频属性对应的视频分辨率、帧率和码率请参考 [API 文档](https://docs.agora.io/cn/Interactive%20Broadcast/API%20Reference/web/interfaces/agorartc.stream.html#setvideoprofile)。

## 集成注意事项

- 视频双流不适用于屏幕共享和视频自采集的场景。
- 为保证通信质量，我们建议大流视频分辨率不超过 640 x 480，帧率不超过 15 fps。
- 本文各视频属性参数的单位，如无特别说明，分辨率为 px，帧率为 fps，码率为 Kbps。
- Agora 建议你在界面布局里采用一大多小的窗口布局：大窗口显示大流的画面，小窗口显示小流的画面。
- 在 Web 端，如果你手动设置小流视频属性，请确保小流宽高比与大流宽高比一致。
- 在 Native 端，通话或直播过程中，如果有发流用户离开频道，接收端可以在收到该用户离线的回调后，调用 `setupRemoteVideo` 方法，将该用户的 `view` 设为空，app 即可彻底释放该用户占用的 `view`。
