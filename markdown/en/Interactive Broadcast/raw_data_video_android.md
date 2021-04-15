---
title: Raw Video Data
platform: Android
updatedAt: 2021-01-12 07:08:46
---
## Introduction

During real-time communications, you can pre- and post-process the audio and video data and modify them for desired playback effects

The Native SDK uses the `IAudioFrameObserver` and `IVideoFrameObserver` class to provide raw data functions. You can pre-process the data before sending it to the encoder and modify the captured video frames and voice signals. You can also post-process the data after sending it to the decoder and modify the received video frames and voice signals.

This article tells how to use raw video data with the `IVideoFrameObserver` class.

## Implementation

Before using the raw data functions, ensure that you have implemented the basic real-time communication functions in your project. For details, see [Start a Call](start_call_android) or [Start a Live Broadcast](start_live_android).

Follow these steps to implement the raw data functions in your project:

1. Call the `registerVideoFrameObserver` method to register a video observer object before joining the channel. You need to implement an `IVideoFrameObserver` class in this method.
2. After you successfully register the observer object, the SDK triggers the `onCaptureVideoFrame` or `onRenderVideoFrame` callback to send the raw video data each time a frame is captured.
3. Process the captured raw data according to your needs. Send the processed data back to the SDK through the `onCaptureVideoFrame` and `onRenderVideoFrame` callback.

### API call sequence

The following diagram shows how to implement the raw data functions in your project:

![](https://web-cdn.agora.io/docs-files/1569217891150)

### Sample code

Refer to the following sample code to implement the raw data functions in your project:

```C++
#include <jni.h>
#include <android/log.h>
#include <cstring>
 
#include "agora/IAgoraRtcEngine.h"
#include "agora/IAgoraMediaEngine.h"
 
#include "video_preprocessing_plugin_jni.h"
 
class AgoraVideoFrameObserver : public agora::media::IVideoFrameObserver
{
public:
    // Get the video frame captured by the local camera.
    virtual bool onCaptureVideoFrame(VideoFrame& videoFrame) override
    {
        int width = videoFrame.width;
        int height = videoFrame.height;
 
        memset(videoFrame.uBuffer, 128, videoFrame.uStride * height / 2);
        memset(videoFrame.vBuffer, 128, videoFrame.vStride * height / 2);
 
        return true;
    }
     
    // Get the video frame sent by the remote user.
    virtual bool onRenderVideoFrame(unsigned int uid, VideoFrame& videoFrame) override
    {
        return true;
    }
};

class IVideoFrameObserver
{
     public:
         enum VIDEO_FRAME_TYPE {
         FRAME_TYPE_YUV420 = 0,  // The video frame format is YUV 420.
         };
     struct VideoFrame {
         VIDEO_FRAME_TYPE type;
         int width;  // Width of the video frame.
         int height;  // Height of the video frame.
         int yStride;  // Line stride of the Y buffer in the YUV data.
         int uStride;  // Line stride of the U buffer in the YUV data.
         int vStride;  // Line strided of the V buffer in the YUV data.
         void* yBuffer;  // Pointer to the Y buffer in the YUV data.
         void* uBuffer;  // Pointer to the U buffer in the YUV data.
         void* vBuffer;  // Pointer to the V buffer in the YUV data.
         int rotation; // Rotation information of the video frame. You can set it as 0, 90, 180, or 270.
         int64_t renderTimeMs; // Timestamp of the video frame.
         };
     public:
         virtual bool onCaptureVideoFrame(VideoFrame& videoFrame) = 0;
         virtual bool onRenderVideoFrame(unsigned int uid, VideoFrame& videoFrame) = 0;
};
```

We also provide an open-source [Agora-Plugin-Raw-Data-API-Android-Java](https://github.com/AgoraIO/Advanced-Video/blob/master/Capture-Raw-Video-Data/Agora-Plugin-Raw-Data-API-Android-Java) demo project on Github. You can try the demo, or view the source code in the [VideoChatViewActivity.java](https://github.com/AgoraIO/Advanced-Video/blob/master/Capture-Raw-Video-Data/Agora-Plugin-Raw-Data-API-Android-Java/app/src/main/java/io/agora/rtc/plugin/rawdata/sample/VideoChatViewActivity.java) file.

### API reference

 - [registerVideoFrameObserver](./API%20Reference/cpp/classagora_1_1media_1_1_i_media_engine.html#a5eee4dfd1fd46e4a865feba163f3c5de)
 - [onCaptureVideoFrame](./API%20Reference/cpp/classagora_1_1media_1_1_i_video_frame_observer.html#a915c673aec879dcc2b08246bb2fcf49a)
 - [onRenderVideoFrame](./API%20Reference/cpp/classagora_1_1media_1_1_i_video_frame_observer.html#a966ed2459b6887c52112af638bc27c14)

## Considerations

The methods that we use in this article are in C++. For Android, refer to the following steps to register the video observer object.

1. Create a shared library project with `libapm-` as the prefix and `so` as the suffix. For example, `libapm-encryption.so`.
2. Before joining the channel, call the `loadAgoraRtcEnginePlugin` method. RtcEngine will automatically load the plug-in.
3. After RtcEngine is destroyed, call the `unloadAgoraRtcEnginePlugin` method to remove the plug-in.

```java
static AgoraVideoFrameObserver s_videoFrameObserver;
static agora::rtc::IRtcEngine* rtcEngine = NULL;
 
 
#ifdef __cplusplus
extern "C" {
#endif
 
int __attribute__((visibility("default"))) loadAgoraRtcEnginePlugin(agora::rtc::IRtcEngine* engine)
{
    __android_log_print(ANDROID_LOG_ERROR, "plugin", "plugin loadAgoraRtcEnginePlugin");
    rtcEngine = engine;
    return 0;
}

void __attribute__((visibility("default"))) unloadAgoraRtcEnginePlugin(agora::rtc::IRtcEngine* engine)
{
    __android_log_print(ANDROID_LOG_ERROR, "plugin", "plugin unloadAgoraRtcEnginePlugin");
    rtcEngine = NULL;
}
 
JNIEXPORT void JNICALL Java_io_agora_propeller_preprocessing_VideoPreProcessing_enablePreProcessing
  (JNIEnv *env, jobject obj, jboolean enable)
{
    if (!rtcEngine)
        return;
    agora::util::AutoPtr<agora::media::IMediaEngine> mediaEngine;
    mediaEngine.queryInterface(rtcEngine, agora::AGORA_IID_MEDIA_ENGINE);
    if (mediaEngine) {
        if (enable) {
            mediaEngine->registerVideoFrameObserver(&s_videoFrameObserver);
        } else {
            mediaEngine->registerVideoFrameObserver(NULL);
        }
    }
}
 
#ifdef __cplusplus
}
#endif
```

## Reference

Refer to [Raw Audio Data](raw_data_audio_android) if you want to implement the raw audio data function in your project.
 
 
