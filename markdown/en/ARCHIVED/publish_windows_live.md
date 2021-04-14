---
title: Publish and Subscribe to Streams
platform: Windows
updatedAt: 2018-12-14 06:20:08
---
Before publishing or subscribing to any streams, ensure that you prepared the development environment and joined the channel. See [Integrate the SDK](/en/Interactive%20Broadcast/windows_video).

## Implementation
### Enable the video mode
Call the <code>enableVideo</code> method to enable the video mode. The voice function is enabled by default in the Agora SDK, so you can call the <code>enableVideo</code> method before or after joining a channel.

-   If you enable the video mode before joining a channel, you enter directly into a video broadcast.
-   If you enable the video mode after joining a channel, the voice broadcast switches to a video broadcast.


```
nRet = m_lpAgoraEngine->enableVideo();
```

### Set the video profile
After the video mode is enabled, call the <code>setVideoProfile</code> method to set the video encoding profile.

In the <code>setVideoProfile</code> method, specify the video encoding resolution, frame rate, bitrate, and orientation mode. See the <code>setChannelProfile</code> method for more information.

> -   The parameters specified in the <code>setVideoProfile</code> method are the maximum values under ideal network conditions. If the video engine cannot render the video using the specified parameters due to poor network conditions, the parameters further down the list are considered until a successful configuration is found.

> -   If the device camera does not support the resolution specified by the video profile, the SDK automatically chooses a suitable camera resolution. This does not change the encoder resolution, and encoding will still use the resolution specified by the <code>setVideoProfile</code> method.


```
int nVideoSolution = m_dlgSetup.GetVideoSolution();
lpAgoraEngine->setVideoProfile((VIDEO_PROFILE_TYPE)nVideoSolution, m_dlgSetup.IsWHSwap());
```

### Set the local video view 
The local video view is the display area of the local video streams on the user’s local device.

Call the <code>setupLocalVideo</code> method before entering into a channel to bind the application with the video window of the local stream and configure the local video display area.

In the <code>setupLocalVideo</code> method:

-   Choose the display window of the local video streams.

-   Specify the video display mode:

    -   Hidden mode: The SDK scales the video until it fills the visible view boundaries. One dimension of the video may be clipped.
    -   Fit mode: The SDK scales the video until one of its dimensions fits the boundaries. Areas that are not filled due to the disparity in the aspect ratio will be filled with black.

-   Pass the uid of the local user. The default value is 0.


```
VideoCanvas vc;

vc.uid = 0;
vc.view = m_dlgVideo.GetLocalVideoWnd();
vc.renderMode = RENDER_MODE_TYPE::RENDER_MODE_FIT;

lpRtcEngine->setupLocalVideo(vc);
```


### Set the remote local view
The remote video view is the display area of the remote video streams on the user’s local device.

Call the <code>setupRemoteVideo</code> method to configure the remote video display.

In the <code>setupRemoteVideo</code> method:

-   Choose the display window of the remote video streams.

-   Specify the video display mode.

    -   Hidden mode: The SDK scales the video until it fills the visible view boundaries. One dimension of the video may be clipped.
    -   Fit mode: The SDK scales the video until one of its dimensions fits the boundaries. Areas that are not filled due to the disparity in the aspect ratio will be filled with black.

-   Pass the uid of the remote user. If the remote uid is unknown to the application, set it when the application receives the <code>onUserJoined</code> event.


```
canvas.uid = agvWndInfo.nUID;
canvas.view = m_wndVideo[nIndex].GetSafeHwnd();

CAgoraObject::GetEngine()->setupRemoteVideo(canvas);
```

## More Steps
You are now in a live broadcast. When the session ends, use the Agora SDK to exit the current channel:

- [Leave the Channel](/en/Interactive%20Broadcast/leave_windows)

For more functions, you can refer to the following sections:

- [Customize the Video/Audio Source and Renderer](/en/Interactive%20Broadcast/custom_video_windows)
- [Enable the Interoperability with the Web SDK](/en/Interactive%20Broadcast/interop_windows)
- [Improve Experience Under Poor Network Conditions](/en/Interactive%20Broadcast/fallback_windows)