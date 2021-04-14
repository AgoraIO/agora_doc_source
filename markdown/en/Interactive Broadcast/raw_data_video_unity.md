---
title: Raw Video Data
platform: Unity
updatedAt: 2020-07-06 12:57:34
---
## Introduction

During real-time communications, you can pre-process and post-process the audio and video data and modify them for desired playback effects.

Agora provides raw data functions for the users who need to process audio and video data. You can pre-process the data before sending it to the encoder and modify the captured video frames and voice signals. You can also post-process the data after sending it to the decoder and modify the received video frames and voice signals.

Agora RTC SDK for Unity provides the `VideoRawDataManager` class to capture and modify the raw video data.

## Implementation

Before using the raw data functions, ensure that you have implemented the basic real-time communication functions in your project. See [Start a Video Call](https://docs.agora.io/en/Video/start_call_unity?platform=Unity) or [Start a Video Broadcast](https://docs.agora.io/en/Interactive%20Broadcast/start_live_unity?platform=Unity) for details.

Follow these steps to implement the raw video data functions in your project:

1. Choose any of the following methods to register the video observer:

   - Call `EnableVideoObserver` to register the video observer before joining a channel. This method is typically used for the capture and rendering of SDK. If you choose this method, call `DisableVideoObserver` after leaving the channel to unregister the video observer.
   - Call `RegisterVideoRawDataObserver` to register the video observer. This method is typically used for self-capture and rendering. If you choose this method, call `UnRegisterVideoRawDataObserver` to unregister the video observer.
   <div class="alert note">You must call EnableVideoObserver and DisableVideoObserver together, or RegisterVideoRawDataObserver and UnRegisterVideoRawDataObserver together. Ensure that you don't mix them, otherwise, undefined behaviors may occur.</div>

2. After you successfully register the observer, call `SetOnCaptureVideoFrameCallback` and `SetOnRenderVideoFrameCallback` to listen for the `OnCaptureVideoFrameHandler` and `OnRenderVideoFrameHandler` callbacks, respectively. The SDK triggers `OnCaptureVideoFrameHandler` or `OnRenderVideoFrameHandler` to send the captured or received raw video data each time the SDK captures a local or remote frame.

3. Process the captured raw video data according to your needs. 

### API call sequence

The following diagram shows how to implement the raw data functions in your project:

![](https://web-cdn.agora.io/docs-files/1576228297748)

### Sample code

Refer to the following sample code to implement the raw video data functions in your project:

```C#
// Initializes the IRtcEngine object.
mRtcEngine = IRtcEngine.GetEngine(mVendorKey);
// Get the VideoRawDataManager object.
videoRawDataManager = VideoRawDataManager.GetInstance(mRtcEngine);
// Enable the video module.
mRtcEngine.EnableVideo();
// Enable the video observer.
mRtcEngine.EnableVideoObserver();
// Listens for the OnCaptureVideoFrameHandler delegate.
videoRawDataManager.SetOnCaptureVideoFrameCallback(OnCaptureVideoFrameHandler);
// Listens for the OnRenderVideoFrameHandler delegate.
videoRawDataManager.SetOnRenderVideoFrameCallback(OnRenderVideoFrameHandler);
// Get the video data sent by the remote user.
void OnRenderVideoFrameHandler(uint uid, VideoFrame videoFrame)
{
    logCallback("OnRenderVideoFrameHandler uid = " + uid + "  ,videoFrame = " + videoFrame.width + "  height = " + videoFrame.height);
}
// Get the video data received by the remote user.
void OnCaptureVideoFrameHandler(VideoFrame videoFrame)
{
    logCallback("OnCaptureVideoFrameHandler  videoFrame  width =  " + videoFrame.width + " ,height = " + videoFrame.height);
}
public enum VIDEO_FRAME_TYPE {
    /** 0: YUV420. */
    FRAME_TYPE_YUV420 = 0, 
    /** 1: RGBA. */
    FRAME_TYPE_RGBA = 1,
};
public struct VideoFrame {
// Only support FRAME_TYPE_RGBA.
public VIDEO_FRAME_TYPE type;
// The width of the video frame.
public int width; 
// The height of the video frame.
public int height; 
// The line span of the Y buffer within the video data.
public int yStride; 
// The buffer of the RGBA data.
public byte[] buffer; 
// Set the rotation of this frame before rendering the video. Supports 0, 90, 180, 270 degrees clockwise.
public int rotation;
// The timestamp of the external audio frame.
public long renderTimeMs;
// The reserved parameter.
public int avsync_type;
};
```



### API reference

- `EnableVideoObserver`
- `DisableVideoObserver`
- `RegisterVideoRawDataObserver`
- `UnRegisterVideoRawDataObserver`
- `SetOnCaptureVideoFrameCallback`
- `SetOnRenderVideoFrameCallback`
- `OnCaptureVideoFrameHandler`
- `OnRenderVideoFrameHandler`

## Considerations

- After you call `EnableVideoObserver` or `DisableVideoObserver`, SDK calls `RegisterVideoRawDataObserver` or `UnRegisterVideoRawDataObserver` automatically, so you don't need to call them again.