---
title: Raw Video Data
platform: Windows
updatedAt: 2021-01-12 08:53:12
---
## Introduction

During real-time communications, you can pre- and post-process video data and modify it for desired playback effects.

The Native SDK uses the `IVideoFrameObserver` class to provide raw data functions. You can pre-process the data before sending it to the encoder and modify the captured video frames. You can also post-process the data after sending it to the decoder and modify the received video frames.

This article describes how to use raw video data with the `IVideoFrameObserver` class.

## Implementation

Before using the raw data functions, ensure that you have implemented the basic real-time communication functions in your project. For details, see [Start a Call](./start_call_windows) or [Start Live Interactive Streaming](./start_live_windows).

Follow these steps to implement the raw data functions in your project:

1. Before joining the channel, call `registerVideoFrameObserver` to register a video frame observer.
2. After successful registration, the SDK sends the raw video data via `onCaptureVideoFrame`, `onPreEncodeVideoFrame`, or `onRenderVideoFrame`.
3. After acquiring the raw data, you can process the data based on your scenario and send the processed data to the SDK via the callbacks mentioned in step 2.

### API call sequence

The following diagram shows how to implement the raw data functions in your project:

![img](https://web-cdn.agora.io/docs-files/1575873646147)

### Data transfer

The following diagram shows the data transfer with the `IVideoFrameObserver` class:

![](https://web-cdn.agora.io/docs-files/1606288025895)

With `onCaptureVideoFrame`, `onPreEncodeVideoFrame`, and `onRenderVideoFrame`, you can:

- Get raw video frames from `VideoFrame`.
- Process the raw frames from `VideoFrame` and return to the SDK or your custom renderer.

### Sample code

1. Call `registerVideoFrameObserver` to register a video frame observer.

```cpp
// Register or unregister the video frame observer
BOOL CAgoraOriginalVideoDlg::RegisterVideoFrameObserver(BOOL bEnable,IVideoFrameObserver * videoFrameObserver)
{
   // Create an AutoPtr instance using the IMediaEngine as template
    agora::util::AutoPtr<agora::media::IMediaEngine> mediaEngine;
    // The AutoPtr instance calls queryInterface and gets a pointer to the IMediaEngine instance via IID. 
    // The AutoPtr instance accesses the pointer to the IMediaEngine instance and calls registerVideoFrameObserver via IMediaEngine.
    mediaEngine.queryInterface(m_rtcEngine, agora::AGORA_IID_MEDIA_ENGINE);
    int nRet = 0;
    if (mediaEngine.get() == NULL)
        return FALSE;
    if (bEnable) {
        // Register the video frame observer
        nRet = mediaEngine->registerVideoFrameObserver(videoFrameObserver);
    }
    else {
        // Unregister the video frame observer
        nRet = mediaEngine->registerVideoFrameObserver(NULL);
    }
    return nRet == 0 ? TRUE : FALSE;
}
```

2. Once you obtain the raw video data, you can pre-process or post-process it.

   Pre-process:

```cpp
// Get the raw video data captured by the camera via onCaptureVideoFrame, process the data with a grayscale filter, and return the data to the SDK
bool CGrayVideoProcFrameObserver::onCaptureVideoFrame(VideoFrame & videoFrame)
{
    int nSize = videoFrame.height * videoFrame.width;
    memset(videoFrame.uBuffer, 128, nSize / 4);
    memset(videoFrame.vBuffer, 128, nSize / 4);
    return true;
}
  
  
  
// Get the raw video data captured by the camera via onCaptureVideoFrame and process with an average filter, and return the data to the SDK
bool CAverageFilterVideoProcFrameObserver::onCaptureVideoFrame(VideoFrame & videoFrame)
{
    static int step = 1;
    static bool flag = true;
    if (flag)
    {
        step += 2;
    }
    else {
        step -= 2;
    }
    if (step >= 151)
    {
        flag = false;
        step -= 4;
    }
    else if (step <= 0) {
        flag = true;
        step += 4;
    }
    AverageFiltering((unsigned char *)videoFrame.yBuffer, videoFrame.width, videoFrame.height, step);
    AverageFiltering((unsigned char *)videoFrame.uBuffer, videoFrame.width / 2, videoFrame.height / 2, step);
    AverageFiltering((unsigned char *)videoFrame.vBuffer, videoFrame.width / 2, videoFrame.height / 2, step);
    return true;
}
```

   
   Post-process:

```cpp
// Get the raw video data from the remote user via onRenderVideoFrame, process the data with a grayscale filter, and return the data to the SDK
bool CGrayVideoProcFrameObserver::onRenderVideoFrame(unsigned int uid, VideoFrame & videoFrame)
{
    int nSize = videoFrame.height * videoFrame.width;
    memset(videoFrame.uBuffer, 128, nSize / 4);
    memset(videoFrame.vBuffer, 128, nSize / 4);
    return true;
}
  
// Get the raw video data from the remote user via onRenderVideoFrame, process the data with an average filter, and return the data to the SDK
bool CAverageFilterVideoProcFrameObserver::onRenderVideoFrame(unsigned int uid, VideoFrame & videoFrame)
{
    static int step = 1;
    static bool flag = true;
    if (flag)
    {
        step += 2;
    }
    else {
        step -= 2;
    }
    if (step >= 151)
    {
        flag = false;
        step -= 4;
    }
    else if (step <= 0) {
        flag = true;
        step += 4;
    }
    AverageFiltering((unsigned char *)videoFrame.yBuffer, videoFrame.width, videoFrame.height, step);
    AverageFiltering((unsigned char *)videoFrame.uBuffer, videoFrame.width / 2, videoFrame.height / 2, step);
    AverageFiltering((unsigned char *)videoFrame.vBuffer, videoFrame.width / 2, videoFrame.height / 2, step);
    return true;
}
```

### API reference

- [`registerVideoFrameObserver`](https://docs.agora.io/en/Interactive%20Broadcast/API%20Reference/cpp/classagora_1_1media_1_1_i_media_engine.html#a5eee4dfd1fd46e4a865feba163f3c5de)
- [`onCaptureVideoFrame`](https://docs.agora.io/en/Interactive%20Broadcast/API%20Reference/cpp/classagora_1_1media_1_1_i_video_frame_observer.html#a915c673aec879dcc2b08246bb2fcf49a)
- [`onRenderVideoFrame`](https://docs.agora.io/en/Interactive%20Broadcast/API%20Reference/cpp/classagora_1_1media_1_1_i_video_frame_observer.html#a966ed2459b6887c52112af638bc27c14)
- [`onPreEncodeVideoFrame`](https://docs.agora.io/en/Interactive%20Broadcast/API%20Reference/cpp/classagora_1_1media_1_1_i_video_frame_observer.html#a2be41cdde19fcc0f365d4eb14a963e1c)

### Sample project

Refer to the sample project on [GitHub](https://github.com/AgoraIO/API-Examples/tree/master/windows/APIExample) to learn how to use raw video data in your project.