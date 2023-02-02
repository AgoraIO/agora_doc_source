本文介绍如何调用声网提供的 API 设置视频编码属性。

## 技术原理

在视频通话或视频互动直播场景下，视频画面是否清晰流畅，很大程度上决定了用户体验。

视频编码属性包含视频分辨率、帧率、码率等影响视频质量的参数设置。你可以通过设置视频编码属性，控制视频流在不同网络条件下的展示方式。

声网 SDK 提供了 `setVideoEncoderConfiguration` 方法设置视频编码属性。此方法可以在初始化 `AgoraRtcEngineKit` 后的任何阶段（加入频道之前或之后）调用。

如果在加入频道后不需要重新设置视频编码属性，声网建议在 `enableVideo` 前调用 `setVideoEncoderConfiguration`，以加快首帧出图的时间。

### 分辨率、帧率和码率

视频编码属性的参数如下所示：

- `dimensions`：视频编码的分辨率（px）。默认值为 960 × 540。通常情况下，分辨率越高，视频的清晰度会越好。该参数的值不代表最终视频输出的方向。点击[旋转方向模式](#orientationmode)了解如何设置视频输出的方向模式。
- `frameRate`: 视频编码的帧率 (fps)，即每秒钟要编码多少帧画面。默认值为 15。通常情况下，帧率越大，画面越流畅。在对视频流畅度要求较高的场景下，可以将此参数设置为 20 或 25。建议不要将 `frameRate` 设置为大于 30。
- `bitrate`：视频编码码率 (Kbps)。默认值为 `AgoraVideoBitrateStandard`，即标准码率模式。在标准码率模式下，SDK 会根据已设置的频道场景、分辨率和帧率为你设置一个合适的码率。

<div class="alert note"><ul>
    <li>为获得高质量的视频，需要将分辨率、码率和帧率维持在相对平衡的状态。较高的分辨率需要较高的码率。在码率一定的情况下，过高的帧率会降低分辨率。</li><li>上述参数设置的均为理想情况下的最大值。当视频因网络环境等原因无法达到设置的分辨率、帧率或码率的最大值时，取值会尽量接近最大值。</li></ul></div>



#### 视频参数推荐值

通常来讲，视频编码参数的选择要根据产品实际情况和场景来确定。比如，在一对一教学场景下，老师和学生的窗口比较大，要求分辨率会高一点，随之帧率和码率也要高一点； 如果是一对四场景， 老师和学生的窗口都比较小，分辨率可以低一点，对应的码率帧率也会低一点，以减少编解码的资源消耗和缓解下行带宽压力。

一般可按下列场景中的推荐值进行设置。

- 双人视频通话场景：
  - 分辨率 320 × 240，帧率 15 fps，码率 200 Kbps
  - 分辨率 640 × 360，帧率 15 fps，码率 400 Kbps
- 一对多视频通话场景：
  - 分辨率 160 × 120，帧率 15 fps，码率 65 Kbps
  - 分辨率 320 × 180，帧率 15 fps，码率 140 Kbps
  - 分辨率 320 × 240，帧率 15 fps，码率 200 Kbps

### <a name="orientationmode"></a>旋转方向模式

在视频旋转场景中，我们主要关注采集端和播放端的行为。其中：

- 采集端采集视频并输出视频。即视频和 Status Bar 的相对位置。
- 播放端渲染接收到的视频图像，并根据接收到的旋转信息，结合自身 Status Bar 的相对位置旋转视频。

为防止视频因旋转出现大头、缩放或剪切的问题，声网 SDK 在 `setVideoEncoderConfiguration` 中提供了 `orientationMode` 参数。你可以通过这个参数，结合视频场景需要，获取想要的视频渲染效果。

`orientationMode` 参数提供了三种模式以适应不同的用户需求：`Adaptive`, `FixedLandscape`, 和 `FixedPortrait`。

无论采取哪种模式，声网 SDK 都保证视频和 Status Bar 的相对位置在采集端和播放端始终一致。

#### Adaptive

在 `Adaptive` 模式下， SDK 输出的视频方向与采集到的视频方向一致。接收端会根据收到的视频旋转信息对视频进行旋转。该模式适用于接收端可以调整视频方向的场景:

当使用后置摄像头采集视频时，视频采集器和播放器的视频方向如下图所示。请注意，视频方向因 UI 是否锁定而异。
<div class="alert note">在 macOS 平台上，Status Bar 总是处于垂直地面方向的正上方，因此不存在 UI 锁定的情况。下文 UI 锁定仅适用于 iOS 平台。</div>

##### UI 已锁定（或禁用 app 屏幕自动旋转）

Status Bar 与屏幕的相对方向保持一致，与手机重力感应无关（例如微信）。因此，视频和屏幕的相对位置在视频采集端和播放端始终一致。

- 采集端横屏时：

<img alt="../_images/rotation_adaptive_uilock_landscape.jpg" src="https://web-cdn.agora.io/docs-files/rotation_adaptive_uilock_landscape.jpg" />

- 采集端竖屏时：

<img alt="../_images/rotation_adaptive_uilock_portrait.jpg" src="https://web-cdn.agora.io/docs-files/rotation_adaptive_uilock_portrait.jpg" />

##### UI 不锁定（启用 app 屏幕自动旋转）

无论屏幕的方向如何（例如，在 Facetime 中），app 中的 Status Bar 始终在水平方向。因此，视频和重力的相对方向在采集端和播放端始终一致。

- 采集端横屏时：

<img alt="../_images/rotation_adaptive_uiunlock_landscape.jpg" src="https://web-cdn.agora.io/docs-files/rotation_adaptive_uiunlock_landscape.jpg" />

- 采集端竖屏时：

<img alt="../_images/rotation_adaptive_uiunlock_portrait.jpg" src="https://web-cdn.agora.io/docs-files/rotation_adaptive_uiunlock_portrait.jpg" />

#### FixedLandscape

在 `FixedLandscape` 模式下，输出的视频相对 Status Bar 总是处于横屏模式。如果采集到的视频是竖屏模式，则视频编码器会对其进行裁剪。该方式适用于接收端无法处理旋转信息的情况。

当使用后置摄像头作为视频采集器时，视频采集器和播放器的视频方向如下图所示。

- 横向模式下采集的视频（不需要视频裁剪）：

<img alt="../_images/rotation_fixed_landscape.jpg" src="https://web-cdn.agora.io/docs-files/rotation_fixed_landscape.jpg" />

- 竖屏模式下采集的视频（需要视频裁剪）：

<img alt="../_images/rotation_fixed_landscape_cut.jpg" src="https://web-cdn.agora.io/docs-files/rotation_fixed_landscape_cut.jpg" />

#### FixedPortrait

在 `FixedPortrait` 模式下，输出的视频相对 Status Bar 总是处于竖屏模式。如果采集到的视频是横屏模式，则视频编码器会对其进行裁剪。该方式适用于接收端无法处理旋转信息的情况。

当使用后置摄像头作为视频采集器时，视频采集器和播放器的视频方向如下图所示。

- 采集到的视频是竖屏模式（不需要视频裁剪）：

<img alt="../_images/rotation_fixed_portrait.jpg" src="https://web-cdn.agora.io/docs-files/rotation_fixed_portrait.jpg" />

- 采集到的视频是横屏模式（需要视频裁剪）：

<img alt="../_images/rotation_fixed_portrait_cut.jpg" src="https://web-cdn.agora.io/docs-files/rotation_fixed_portrait_cut.jpg" />

### 降级偏好

为保证弱网下用户的视频体验，声网 SDK 还提供了 `degradationPreference` 参数，来设置带宽受限时视频编码的降级偏好。

### 镜像模式

默认情况下，SDK 在编码时不对视频作镜像操作。你可以通过 `mirrorMode` 参数来设置视频编码的镜像模式决定远端用户看到的视频画面。

### 最低编码帧率、码率

如果你对视频质量或传输帧率有特殊的需求，还可以通过如下两个参数进行设置。

- `minFrameRate`: 视频最低编码帧率 (fps)。`minFrameRate` 和 `AgoraDegradationMaintainQuality` 可搭配使用，用于在网络连接不可靠时平衡视频清晰度和帧率。` minFrameRate` 较低时，一旦带宽不足，帧率下降幅度较大，画质清晰度受影响比较小；` minFrameRate` 较高时，一旦带宽不足，帧率下降幅度有限，视频清晰度受影响比较大。
- `minBitrate`: 视频最低编码码率 (Kbps)。声网 SDK 会根据网络条件进行码率自适应。将此参数设置为大于默认值时，会强制视频编码器输出高质量的视频图像，但可能会导致丢包率增高并影响视频播放的流畅度。

<div class="alert note"><code>
	minFrameRate</code> 和 <code>minBitrate</code> 的默认值可以满足大多数实时场景的要求。一般情况下声网建议你不要更改这些默认值。</div>



## 前提条件

在进行操作之前，请确保你已经在项目中实现了基本的实时音视频功能。详见[开始视频通话](start_call_ios_ng)或[开始互动直播](start_live_ios_ng)。

## 实现方法

你可以参考如下示例代码，在你的项目中设置各种视频编码参数：

```swift
// 根据用户在界面的选择设置视频编码的分辨率、帧率、码率与横竖屏方向模式
let resolution = configs["resolution"] as? CGSize,
let fps = configs["fps"] as? Int,
let orientation = config["orientation"] as? AgoraVideoOutputOrientationMode else {return}

agoraKit.setVideoEncoderConfiguration(AgoraVideoEncoderConfiguration(size: resolution,
        frameRate: AgoraVideoFrameRate(rawValue: fps) ?? .fps15,
        bitrate: AgoraVideoBitrateStandard,
        orientationMode: orientation))
```

## 参考信息

介绍本文中使用方法的更多信息以及相关页面的链接。

### 示例项目

声网在 GitHub 上提供了一个已实现视频编码属性设置的开源示例项目。你可以下载体验或查看源代码。

* iOS： [JoinChannelVideo.swift ](https://github.com/AgoraIO/API-Examples/blob/main/iOS/APIExample/Examples/Basic/JoinChannelVideo/JoinChannelVideo.swift)
* macOS： [JoinChannelVideo.swift ](https://github.com/AgoraIO/API-Examples/blob/main/macOS/APIExample/Examples/Basic/JoinChannelVideo/JoinChannelVideo.swift)

### 开发注意事项

- `setVideoEncoderConfiguration` 中的各参数值是在理想网络状态下的最大值。声网 SDK 会根据实时网络环境和设备，对设置的参数作自适应调整，通常会下调参数。
- `setVideoEncoderConfiguration` 中的参数设置可能会影响计费。如果因自适应产生参数下调，计费按用户实际订阅的视频分辨率为准。详见[实时音视频计费](./billing_rtc_ng)。

声网 SDK 提供了多种分辨率、帧率和码率以供选择。你也可以根据下表自行定义。

<a name="videoprofile"></a>
### 视频属性参考

| 分辨率 (宽 × 高)        |  帧率 (fps)       |  基准码率 (Kbps, 适用于通信场景)     |  直播码率 (Kbps, 适用于直播场景)     |
|------------------------|------------------|---------------------|--------------------|
| 160 × 120              | 15               | 65                  | 110                |
| 120 × 120              | 15               | 50                  | 90                 |
| 320 × 180              | 15               | 140                 | 240                |
| 180 × 180              | 15               | 100                 | 160                |
| 240 × 180              | 15               | 120                 | 200                |
| 320 × 240              | 15               | 200                 | 300                |
| 240 × 240              | 15               | 140                 | 240                |
| 424 × 240              | 15               | 220                 | 370                |
| 640 × 360              | 15               | 400                 | 680                |
| 360 × 360              | 15               | 260                 | 440                |
| 640 × 360              | 30               | 600                 | 1030               |
| 360 × 360              | 30               | 400                 | 670                |
| 480 × 360              | 15               | 320                 | 550                |
| 480 × 360              | 30               | 490                 | 830                |
| 640 × 480              | 15               | 500                 | 750                |
| 480 × 480              | 15               | 400                 | 680                |
| 640 × 480              | 30               | 750                 | 1130               |
| 480 × 480              | 30               | 600                 | 1030               |
| 848 × 480              | 15               | 610                 | 920                |
| 848 × 480              | 30               | 930                 | 1400               |
| 640 × 480              | 10               | 400                 | 600                |
| 960 × 540              | 15               | 750                 | 1100               |
| 960 × 540              | 30               | 1110                | 1670               |
| 1280 × 720             | 15               | 1130                | 1600               |
| 1280 × 720             | 30               | 1710                | 2400               |
| 960 × 720              | 15               | 910                 | 1280               |
| 960 × 720              | 30               | 1380                | 2000               |
| 1920 × 1080            | 15               | 2080                | 2500               |
| 1920 × 1080            | 30               | 3150                | 3780               |
| 1920 × 1080            | 60               | 4780                | 5730               |
| 2560 × 1440            | 30               | 4850                | 4850               |
| 2560 × 1440            | 60               | 7350                | 7350               |
| 3840 × 2160            | 30               | 8910                | 8910               |
| 3840 × 2160            | 60               | 13500               | 13500              |