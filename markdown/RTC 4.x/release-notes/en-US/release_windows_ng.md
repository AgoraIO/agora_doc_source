## v4.1.1

 v4.1.1 was released on January xx, 2023.


 #### Compatibility changes

 As of this release, the SDK optimizes the video encoder algorithm and upgrades the default video encoding resolution from 640 × 360 to 960 × 540 to accommodate improvements in device performance and network bandwidth, providing users with a full-link HD experience in various audio and video interaction scenarios.

 You can call the `setVideoEncoderConfiguration` method to set the expected video encoding resolution in the video encoding parameters configuration.

<div class="alert note">The increase in the default resolution affects the aggregate resolution and thus the billing rate. See <a href="./billing_rtc_ng">Pricing</a>.</div>

 #### New features

 **1. Instant frame rendering**

 This release adds the `enableInstantMediaRendering` method to enable instant rendering mode for audio and video frames, which can speed up the first video or audio frame rendering after the user joins the channel.

 **2. Video rendering tracing**

 This release adds the `startMediaRenderingTracing` and `startMediaRenderingTracingEx` methods. The SDK starts tracing the rendering status of the video frames in the channel from the moment this method is called and reports information about the event through the `onVideoRenderingTracingResult` callback.

 Agora recommends that you use this method in conjunction with the UI settings (such as buttons and sliders) in your app. For example, call this method at the moment when the user clicks the "Join Channel" button, and then get the indicators in the video frame rendering process through the `onVideoRenderingTracingResult` callback. This enables developers to facilitate developers to optimize the indicators to improve the user experience.

 #### Improvements

 **Video frame observer**

 As of this release, the SDK optimizes the `onRenderVideoFrame` callback, and the meaning of the return value is different depending on the video processing mode:

 - When the video processing mode is `PROCESS_MODE_READ_ONLY`, the return value is reserved for future use.
 - When the video processing mode is `PROCESS_MODE_READ_WRITE`, the SDK receives the video frame when the return value is `true`; the video frame is discarded when the return value is `false`.

 #### Issues fixed

 This release fixed the following issues:

 - When using Agora Media Player to play RTSP video streams, the video images sometimes appeared pixelated. 
 - Playing audio files with a sample rate of 48 kHz failed.
 - Adding an alpha channel to an image in PNG or GIF format failed when the local client mixed video streams. 
 - After joining the channel, remotes users saw a watermark even though the watermark was deleted. 
 - If a watermark was added after starting screen sharing, the watermark did not display the screen. 
 - When joining a channel and accessing an external camera, calling `setDevice` to specify the video capture device as the external camera did not take effect. 
 - When trying to outline the shared window and put it on top, the shared window did not stay on top of other windows. 
 - When there were multiple video streams in a channel, calling some video enhancement APIs occasionally failed. 
 - At the moment when a user left a channel, a request for leaving was not sent to the server and the leaving behavior was incorrectly determined by the server as timed out.

 #### API changes

 **Added**

 - `enableInstantMediaRendering`
 - `startMediaRenderingTracing`
 - `startMediaRenderingTracingEx`
 - `onVideoRenderingTracingResult`
 - `MEDIA_RENDER_TRACE_EVENT`
 - `VideoRenderingTracingInfo`

 **Deleted**

 - `enableRemoteSuperResolution`
 - Deleted `superResolutionType` in `RemoteVideoStats`

## v4.0.0

#### New features

**2. Ultra HD resolution (Beta)**

In order to improve the interactive video experience, the SDK optimizes the whole process of video capture, encoding, decoding and rendering, and now supports 4K resolution. The improved FEC (Forward Error Correction) algorithm enables adaptive switches according to the frame rate and number of video frame packets, which further reduces the video stuttering rate in 4K scenes.

Additionally, you can set the encoding resolution to 4K (3840 × 2160) and the frame rate to 60 fps when calling `setVideoEncoderConfiguration`. The SDK supports automatic fallback to the appropriate resolution and frame rate if your device does not support 4K.

<div class="alert info"><li>This feature has certain requirements with regards to device performance and network bandwidth, and the supported upstream and downstream frame rates vary on different platforms. To experience this feature, contact [support@agora.io](mailto:support@agora.io).
<li>The increase in the default resolution affects the aggregate resolution and thus the billing rate. See <a href="./billing_rtc_ng">Pricing</a>.</div>
