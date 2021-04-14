---
title: 视频采集旋转
platform: Android
updatedAt: 2019-09-20 12:07:40
---
## 功能描述

Agora 的视频采集、渲染和输出的流程大致如下：

<img alt="../_images/rotation_encoding_decoding.jpg" src="https://web-cdn.agora.io/docs-files/cn/rotation_encoding_decoding.jpg" style="width: 840px; "/>

因此在视频旋转场景中，我们主要关注两个端：采集端和播放端 。其中：
- 采集端采集并输出视频图像，以及视频相对于 Status Bar 的位置，即旋转信息。
- 播放端渲染接收到的视频图像，并根据接收到的旋转信息，结合自身 Status Bar 的相对位置，旋转视频。

为防止视频因旋转出现大头、缩放或剪切的问题，Agora SDK 在 `setVideoEncoderConfiguration` 方法中提供一个 `VideoEncoderConfiguration` 类，其中包含一个 `orientationMode` 参数。你可以通过这个参数，结合视频场景需要，获取想要的视频渲染效果。

## 实现方法

在设置视频旋转模式前，请确保已在项目中实现了基本的实时音视频功能，详见[开始音视频通话](start_call_android)或[开始互动直播](start_live_android)。

Agora 在 `orientaionMode` 参数中，提供了 `ADAPTIVE`、`FIXED_LANDSCAPE` 和 `FIXED_PORTRAIT` 三种方向模式。

<div class="alert note">无论是哪一种模式，Agora SDK 保证视频和 Status Bar 的相对位置在采集端和播放端始终一致。</div>

### ADAPTIVE 模式

该模式下， SDK 输出的视频方向与采集到的视频方向一致。接收端会根据收到的视频旋转信息对视频进行旋转。该模式适用于接收端可以调整视频方向的场景。

下图演示了后置摄像头采集下，Adaptive 模式分别在 UI 锁定和 UI 不锁定情况下的行为：

**UI 锁定时（或 UI 不锁定但客户端关闭了屏幕自动旋转功能时）**

Status Bar 与屏幕的相对方向保持不变，和手机的重力感应无关（比如微信）。此时，视频和屏幕的相对方向在采集端和播放端始终一致：

- 采集端横屏时：

    <img alt="../_images/rotation_adaptive_uilock_landscape.jpg" src="https://web-cdn.agora.io/docs-files/cn/rotation_adaptive_uilock_landscape.jpg" />

- 采集端竖屏时：

    <img alt="../_images/rotation_adaptive_uilock_portrait.jpg" src="https://web-cdn.agora.io/docs-files/cn/rotation_adaptive_uilock_portrait.jpg" />

**UI 不锁定且客户端开启屏幕自动旋转时**

Status Bar 总是处于垂直地面方向的正上方，和屏幕的朝向无关（比如 Facetime）。此时，视频和重力的相对方向在采集端和播放端始终一致：

- 采集端横屏时：

    <img alt="../_images/rotation_adaptive_uiunlock_landscape.jpg" src="https://web-cdn.agora.io/docs-files/cn/rotation_adaptive_uiunlock_landscape.jpg" />

- 采集端竖屏时：

    <img alt="../_images/rotation_adaptive_uiunlock_portrait.jpg" src="https://web-cdn.agora.io/docs-files/cn/rotation_adaptive_uiunlock_portrait.jpg" />

### FIXED_LANDSCAPE 模式

该模式下，SDK 保证输出的视频相对 Status Bar 总是处于横屏模式；如果采集到的视频是竖屏模式，则视频编码器会对其进行裁剪。该模式适用于当接收端无法调整视频方向时，如使用 CDN 推流场景。

下图演示了后置摄像头采集下，FIXED_LANDSCAPE 模式在采集端处于不同角度时的行为：

-  采集到的视频是横屏模式：（采集端未对硬件采集的视频进行裁剪处理）

    <img alt="../_images/rotation_fixed_landscape.jpg" src="https://web-cdn.agora.io/docs-files/cn/rotation_fixed_landscape.jpg" />


-   采集到的视频是竖屏模式：（采集端对硬件采集的视频进行裁剪处理，使其成为横屏画面。图中红色虚线部分演示 SDK 对采集到的图像裁剪后留下的部分）

    <img alt="../_images/rotation_fixed_landscape_cut.jpg" src="https://web-cdn.agora.io/docs-files/cn/rotation_fixed_landscape_cut.jpg" />

### FIXED_PORTRAIT 模式

该模式下，SDK 保证输出的视频相对 Status Bar 总是处于竖屏模式；如果采集到的视频是横屏模式，则视频编码器会对其进行裁剪。该模式适用于当接收端无法调整视频方向时，如使用 CDN 推流场景。

下图演示了后置摄像头采集下，FIXED_PORTRAIT 模式在采集端处于不同角度时的行为：

-   采集到的视频是竖屏模式：（采集端未对硬件采集的视频进行裁剪处理）

    <img alt="../_images/rotation_fixed_portrait.jpg" src="https://web-cdn.agora.io/docs-files/cn/rotation_fixed_portrait.jpg" />


-   采集到的视频是横屏模式：（采集端对硬件采集的视频进行裁剪处理，使其成为竖屏画面。图中红色虚线部分演示 SDK 对采集到的图像裁剪后留下的部分）

    <img alt="../_images/rotation_fixed_portrait_cut.jpg" src="https://web-cdn.agora.io/docs-files/cn/rotation_fixed_portrait_cut.jpg" />
		
### API 参考

- [setVideoEncoderConfiguration](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#af5f4de754e2c1f493096641c5c5c1d8f)
- [orientationMode](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1video_1_1_video_encoder_configuration.html#a50e755074e254026b51dfaa2e3dc91d9)
		
## 开发注意事项

视频的方向模式通过设置视频属性 `setVideoEncoderConfiguration` 方法实现。该方法的调用时序和示例代码请参考[设置视频属性](video_profile_android)。