---
title: Custom Video Source and Renderer
platform: Unity
updatedAt: 2020-07-20 11:56:38
---
## Introduction

By default, the Agora Unity SDK enables the default video module to capture and render video during real-time communications.

However, the default modules may not meet your development requirements, such as in the following scenarios:

- Your app owns other video module.
- You need a video source other than camera, such as a recorded screen.
- You need to process the captured video with a pre-processing library for functions such as image enhancement or augmented reality (AR).
- You need a flexible device allocation policy for avoiding conflicts with other services.

This article describes how to use the Agora Unity SDK to customize the video source and renderer.

## Implementation

Before customizing the video source or renderer, ensure that you have implemented the basic real-time communication functions in your project. See [Start a Video Call](https://docs.agora.io/en/Video/start_call_unity?platform=Unity) or [Start a Video Broadcast](https://docs.agora.io/en/Interactive%20Broadcast/start_live_unity?platform=Unity) for details.

Refer to the following steps to customize the video source and renderer in your project:

1. Call `SetExternalVideoSource` before `JoinChannelByKey` to enable an external video source.
2. Manage the capturing and processing of the specified video data on your own.
3. Call `PushVideoFrame` to send the video back to the SDK.

The following steps show how to implement screen sharing by customizing the video source or renderer.

1. Specify the external video source by calling `SetExternalVideoSource` before `JoinChannelByKey`.

   ```C#
mRtcEngine.SetExternalVideoSource(true, false);
	 ```

2. Define the Texture2D, and use Texture2D to read screen pixels as an external video source.

   ```C#
mRect = new Rect(0, 0, Screen.width, Screen.height);
mTexture = new Texture2D((int)mRect.width, (int)mRect.height, TextureFormat.RGBA32, false);
mTexture.ReadPixels(mRect, 0, 0);
mTexture.Apply();
	 ```
   
3. Call `PushVideoFrame` to send the video source to the SDK and to implement screen sharing.

   ```C#
int a = rtc.PushVideoFrame(externalVideoFrame);
	 ```
   

### API call sequence

The following diagram shows the API call sequence for customizing the video source and renderer.

![](https://web-cdn.agora.io/docs-files/1576229371972)

### Sample code

Refer to the following code to customize the video source in your project, for functions such as screen sharing.

```C#
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using agora_gaming_rtc;
using UnityEngine.UI;
using System.Globalization;
using System.Runtime.InteropServices;
using System;

public class ShareScreen : MonoBehaviour
{
Texture2D mTexture;
Rect mRect;
[SerializeField]
private string appId = "Your_AppID";
[SerializeField]
private string channelName = "agora";
public IRtcEngine mRtcEngine;
int i = 100;
void Start()
{
Debug.Log("ScreenShare Activated");
mRtcEngine = IRtcEngine.GetEngine(appId);
// Sets the output log level of the SDK.
mRtcEngine.SetLogFilter(LOG_FILTER.DEBUG | LOG_FILTER.INFO | LOG_FILTER.WARNING | LOG_FILTER.ERROR | LOG_FILTER.CRITICAL);
// Enables the video module.
mRtcEngine.EnableVideo();
// Enables the video observer.
mRtcEngine.EnableVideoObserver();
// Configures the external video source.
mRtcEngine.SetExternalVideoSource(true, false);
// Joins a channel
mRtcEngine.JoinChannel(channelName, null, 0);
// Creates a rectangular region of the screen.
mRect = new Rect(0, 0, Screen.width, Screen.height);
// Creates a texture of the rectangle you create.
mTexture = new Texture2D((int)mRect.width, (int)mRect.height, TextureFormat.RGBA32, false);
}

void Update(){
 StartCoroutine(shareScreen());
}
// Starts to share the screen.
IEnumerator shareScreen()
{
yield return new WaitForEndOfFrame();
// Reads the Pixels of the rectangle you create.
mTexture.ReadPixels(mRect, 0, 0);
// Applies the Pixels read from the rectangle to the texture.
mTexture.Apply();
// Gets the Raw Texture data from the texture and apply it to an array of bytes.
byte[] bytes = mTexture.GetRawTextureData();
// Gives enough space for the bytes array.
int size = Marshal.SizeOf(bytes[0]) * bytes.Length;
// Checks whether the IRtcEngine instance is existed.
IRtcEngine rtc = IRtcEngine.QueryEngine();

if (rtc != null)
{
// Creates a new external video frame.
ExternalVideoFrame externalVideoFrame = new ExternalVideoFrame();
// Sets the buffer type of the video frame.
externalVideoFrame.type = ExternalVideoFrame.VIDEO_BUFFER_TYPE.VIDEO_BUFFER_RAW_DATA;
// Sets the format of the video pixel.
externalVideoFrame.format = ExternalVideoFrame.VIDEO_PIXEL_FORMAT.VIDEO_PIXEL_UNKNOWN;
// Applies raw data.
externalVideoFrame.buffer = bytes;
// Sets the width (pixel) of the video frame.
externalVideoFrame.stride = (int)mRect.width;
// Sets the height (pixel) of the video frame.
externalVideoFrame.height = (int)mRect.height;
// Removes pixels from the sides of the frame
externalVideoFrame.cropLeft = 10;
externalVideoFrame.cropTop = 10;
externalVideoFrame.cropRight = 10;
externalVideoFrame.cropBottom = 10;
// Rotates the video frame (0, 90, 180, or 270)
externalVideoFrame.rotation = 180;
// Increments i with the video timestamp.
externalVideoFrame.timestamp = i++;
// Pushes the external video frame with the frame you create.
int a = rtc.PushVideoFrame(externalVideoFrame);
}
}
}
```

### API reference

- [SetExternalVideoSource](./API%20Reference/unity/classagora__gaming__rtc_1_1_i_rtc_engine.html#aae4a31d2375ed620605360ae1199eee8)
- [PushVideoFrame](./API%20Reference/unity/classagora__gaming__rtc_1_1_i_rtc_engine.html#af9e8d34e2a1ac07b8984fb6181a6ab81)