---
title: 如何设置镜像模式？
platform: ["Android","iOS","macOS","Windows"]
updatedAt: 2020-03-02 17:42:53
Products: ["Video","Interactive Broadcast","live-streaming"]
---
自 v3.0.0 起，Agora Native SDK 提供新的接口方便你在实时音视频通话的不同阶段中获取期望的视频显示效果。

## 阶段 1. 本地视图显示

在本地设备上，本地用户的视频流绑定在本地视图上，本地用户可以看到本地视图显示效果。你可以在`setupLocalVideo` 或 `setLocalRenderVideo` 中，通过 `mirrorMode` 设置本地视图显示为镜像效果。它只影响本地用户所见，不影响远端用户所见。

<div class="alert note"><code>mirrorMode</code> 有默认值，即使用前置摄像头时默认启动此阶段的镜像模式，使用后置摄像头时默认关闭此阶段的镜像模式。</div>

## 阶段 2. 远端用户视图显示

在本地设备上，远端用户的视频流绑定在对应的远端视图上，本地用户可以看到远端视图显示效果。你可以在 `setupRemoteVideo` 或 `setRemoteRenderMode`中，通过 `mirrorMode` 设置远端视图显示为镜像效果。它只影响本地用户所见，不影响远端用户所见。

## 阶段 3. 本地发送视频流

本地视频流编码后会发送给远端用户观看。在`setVideoEncoderConfiguration` 中，你可以通过 `config` 设置本地发送的视频流为镜像模式。它只影响远端用户所见，不影响本地用户所见。

## API 参考
如果你想了解更多细节，请参考以下 API 文档：
* [`setLocalVideoMirrorMode (deprecated)`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#a67f08a1ee32d9443a04bb9b293156bde)
* [`setupLocalVideo`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#a744003a9c0230684e985e42d14361f28)
* [`setLocalRenderMode`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#ac433e6e88da91f87c107012cbaf8bb5c)
* [`setupRemoteVideo`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#ac166814787b0a1d8da5f5c632dd7cdcf)
* [`setLocalRenderMode`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#ac433e6e88da91f87c107012cbaf8bb5c)
* [`setVideoEncoderConfiguration`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#a9bcbdcee0b5c52f96b32baec1922cf2e)