---
title: How can I set a mirror mode?
platform: ["Android","iOS","macOS","Windows"]
updatedAt: 2020-03-02 17:43:47
Products: ["Video","Interactive Broadcast"]
---
As of v3.0.0, Agora Native SDK provides [new methods](#api) for you to obtain the desired video display effect at different stages in a video call.

## Stage 1. Set a mirror mode for the local view
On the local device, the video stream of the local user is bound to the local view, and the local user can see the display effect of the local view. You can use `mirrorMode` in the `setupLocalVideo` or` setLocalRenderVideo` method to set a mirror effect for the local view. It affects only the local user's view on the local device, not any view on the remote device.
<div class = "alert note"> <code>mirrorMode</code> has a default value, that is, the SDK enables mirror mode at this stage when using the front camera, and disables it when using the rear camera. </div>

## Stage 2. Set a mirror effect for the remote view on the local device
The video stream of a remote user is bound to the corresponding remote view on the local device, and the local user can see the display effect of the remote view. You can use `mirrorMode` in the `setupRemoteVideo` or `setRemoteRenderMode` method to set a mirror effect for the remote view. It affects only the remote user's view on the local device, not any view on the remote device.

## Stage 3. Set a mirror effect for the video stream to be sent
The local video stream is encoded and then sent to the remote user. You can use `config` in the `setVideoEncoderConfiguration` method to set a mirror effect for the video stream to be sent. It affects only the local user's view on the remote device, not any view on the local device.

<a name="api"></a>
## API reference
See the following API reference for details:
* [`setLocalVideoMirrorMode (deprecated)`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#a67f08a1ee32d9443a04bb9b293156bde)
* [`setupLocalVideo`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#a744003a9c0230684e985e42d14361f28)
* [`setLocalRenderMode`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#ac433e6e88da91f87c107012cbaf8bb5c)
* [`setupRemoteVideo`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#ac166814787b0a1d8da5f5c632dd7cdcf)
* [`setLocalRenderMode`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#ac433e6e88da91f87c107012cbaf8bb5c)
* [`setVideoEncoderConfiguration`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#a9bcbdcee0b5c52f96b32baec1922cf2e)