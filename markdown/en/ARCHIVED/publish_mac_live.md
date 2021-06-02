---
title: Publish and Subscribe to Streams
platform: macOS
updatedAt: 2018-12-14 06:19:46
---
Before publishing or subscribing to any streams, ensure that you prepared the development environment and joined the channel. See [Integrate the SDK](/en/Interactive%20Broadcast/mac_video).

## Implementation
### Enable the video mode
Call the `enableVideo` method to enable the video mode. The voice function is enabled by default in the Agora SDK, so you can call the `enableVideo` method before or after joining a channel.

- If you enable the video mode before joining a channel, you enter directly into a video broadcast.
- If you enable the video mode after joining a channel, the voice broadcast switches to a video broadcast.

```objective-c
//Objective-C
- (void)enableVideo {
  [self.agoraKit enableVideo];
  // Default mode is disableVideo
}
```

```swift
//Swift
func enableVideo() {
  agoraKit.enableVideo()  //Default mode is disableVideo.
}
```

### Set the video profile
After the video mode is enabled, call the `setVideoEncoderConfiguration` method to set the video encoding profile.

In the `setVideoEncoderConfiguration` method, specify the video encoding resolution, frame rate, bitrate, and orientation mode. 

> - The parameters specified in the `setVideoEncoderConfiguration` method are the maximum values under ideal network conditions. If the video engine cannot render the video using the specified parameters due to poor network conditions, the parameters further down the list are considered until a successful configuration is found.
> - If the device camera does not support the resolution specified by the video profile, the SDK automatically chooses a suitable camera resolution. This does not change the encoder resolution, and encoding will still use the resolution specified by the `setVideoProfile` method.

```objective-c
//Objective-C
AgoraVideoEncoderConfiguration *configuration =
[[AgoraVideoEncoderConfiguration alloc]
initWithSize:AgoraVideoDimension640x360
frameRate:AgoraVideoFrameRateFps15 bitrate:400
orientationMode:AgoraVideoOutputOrientationModeFixedPortrait];

[self.agoraKit setVideoEncoderConfiguration:configuration];
```

```swift
//Swift
let configuration = AgoraVideoEncoderConfiguration(size:
AgoraVideoDimension640x360, frameRate: .fps15, bitrate: 400,
orientationMode: .fixedPortrait)
agoraKit.setVideoEncoderConfiguration(configuration)
```

### Set the local video view
The local video view is the display area of the local video streams on the user’s local device.

Call the `setupLocalVideo` method before entering into a channel to bind the application with the video window of the local stream and configure the local video display.

In the `setupLocalVideo` method:

- Choose the display window of the local video streams.
- Specify the video display mode:
  - Hidden mode: The SDK scales the video until it fills the visible view boundaries. One dimension of the video may be clipped.
  - Fit mode: The SDK scales the video until one of its dimensions fits the boundaries. Areas that are not filled due to the disparity in the aspect ratio will be filled with black.
- Pass the uid of the local user. The default value is 0.

```objective-c
//Objective-C
- (void)setupLocalVideo {
  AgoraRtcVideoCanvas *videoCanvas = [[AgoraRtcVideoCanvas alloc] init];
  videoCanvas.uid = 0;

  videoCanvas.view = self.localVideo;
  videoCanvas.renderMode = AgoraVideoRenderModeHidden;
  [self.agoraKit setupLocalVideo:videoCanvas];
  // Bind local video stream to view
}
```

```swift
//Swift
func setupLocalVideo() {
  let videoCanvas = AgoraRtcVideoCanvas()
  videoCanvas.uid = 0
  videoCanvas.view = localVideo
  videoCanvas.renderMode = .hidden
  agoraKit.setupLocalVideo(videoCanvas)
}
```

### Set the remote video view
The remote video view is the display area of the remote video streams on the user’s local device.

Call the `setupRemoteVideo` method to configure the remote video display.

In the `setupRemoteVideo` method:

- Choose the display window of the remote video streams.
- Specify the video display mode:
  - Hidden mode: The SDK scales the video until it fills the visible view boundaries. One dimension of the video may be clipped.
  - Fit mode: The SDK scales the video until one of its dimensions fits the boundaries. Areas that are not filled due to the disparity in the aspect ratio will be filled with black.
- Pass the uid of the remote user. If the remote uid is unknown to the app, set it when the app receives the `didJoinedOfUid` callback.

```objective-c
//Objective-C
- (void)setupRemoteVideo {
  AgoraRtcVideoCanvas *videoCanvas = [[AgoraRtcVideoCanvas alloc] init];
  videoCanvas.uid = uid;

  videoCanvas.view = self.remoteVideo;
  videoCanvas.renderMode = AgoraVideoRenderModeFit;
  [self.agoraKit setupRemoteVideo:videoCanvas];
  // Bind the remote video stream to the view.
}
```

```swift
//Swift
func setupRemoteVideo() {
    let videoCanvas = AgoraRtcVideoCanvas()
    videoCanvas.uid = 1
    videoCanvas.view = remoteVideo
    videoCanvas.renderMode = .fit
    agoraKit.setupRemoteVideo(videoCanvas)
}
```


## Next Steps
You are now in a live broadcast. When the session ends, use the Agora SDK to exit the current channel:

- [Leave the Channel](/en/Interactive%20Broadcast/leave_mac)

For more functions, you can refer to the following sections:

- [Customize the Video/Audio Source and Renderer](/en/Interactive%20Broadcast/custom_video_mac)
- [Enable the Interoperability with the Web SDK](/en/Interactive%20Broadcast/interop_mac)
- [Push Streams to the CDN](/en/Interactive%20Broadcast/push_stream_ios2.0?platform=macOS)
- [Improve Experience Under Poor Network Conditions](/en/Interactive%20Broadcast/fallback_ios?platform=macOS)