---
title: 如何处理音量太小问题？
platform: ["Android","iOS","macOS","Windows","Unity","Cocos Creator","Electron","React Native","Flutter"]
updatedAt: 2020-08-25 16:03:29
Products: ["Voice","Video","Interactive Broadcast"]
---
## 步骤 1：自检操作

* 请检查接收方的系统音量是否已调大。
* 请检查该问题是否由您的设备引起的，例如，更换耳机或者其他播放设备，或在您的 PC 店或移动端，测试其他同类 VoIP 引用是否也存在声音小的问题。
* 请确认在通话过程中是否使用了第三方的音频应用，因而改变了音频系统底层的设置或者路由，请开发者自行检查代码逻辑。
* 调用以下 API 获取音量信息，调节音量大小：`enableAudioVolumeIndication`，`adjustRecordingSignalVolume`，`adjustPlaybackSignalVolume`，和 `adjustAudioMixingVolume`。详见各平台的 API 参考说明文档。
* 在 `onAudioRouteChanged` 回调里检查语音路由到听筒还是外放(扬声器)。如果是听筒，请调用 API `setDefaultAudioRouteToSpeakerphone` 将语音路由修改至从外放出声。

## 步骤 2：联系技术支持

如果问题仍然存在，请联系技术支持，并提供以下信息，方便快速定位问题:

* 用户所在的频道名称；
* 哪些用户反映音量过小，请提供他们的 UID；
* 用户发现音量过小的时间段。

## 步骤 3：水晶球监控通话质量

你可以使用 Agora 控制台中的[水晶球](https://dashboard.agora.io/analytics/call/search)功能对通话质量进行跟踪和反馈，详见[水晶球教程](https://dashboard.agora.io/analytics/call/tutorial?_ga=2.197716463.1125435494.1542623251-764614247.1539586349)。