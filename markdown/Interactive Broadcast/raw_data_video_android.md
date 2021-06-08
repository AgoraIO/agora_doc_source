---
title: 原始视频数据
platform: Android
updatedAt: 2021-01-12 07:03:54
---
## 功能描述

音视频传输过程中，我们可以对采集到的音视频数据进行前处理和后处理，获取想要的播放效果。

对于有自行处理音视频数据需求的场景，Agora 提供原始数据功能，你可以在将数据发送给编码器前进行前处理，对捕捉到的语音信号或视频帧进行修改；也可以在将数据发送给解码器后进行后处理，对接收到的语音信号或视频帧进行修改。

Native SDK 通过提供 `IVideoFrameObserver` 类，实现采集、修改原始视频数据功能。

## 实现方法

在使用原始数据功能前，请确保你已在项目中完成基本的实时音视频功能，详见[一对一通话](start_call_android)或[互动直播](start_live_android)。

参考如下步骤，在你的项目中实现原始视频数据功能：

1. 加入频道前调用 `registerVideoFrameObserver` 方法注册视频观测器，并在该方法中实现一个 `IVideoFrameObserver` 类。
2. 成功注册后，SDK 会在捕捉到每个视频帧时通过 `onCaptureVideoFrame`、`onPreEncodeVideoFrame` 或 `onRenderVideoFrame` 回调发送获取到的原始视频数据。
3. 用户拿到视频数据后，根据场景需要自行进行处理。然后将处理过的视频数据再通过上述回调发送给 SDK。

### API 调用时序

下图展示使用原始视频数据的 API 调用时序：

![](https://web-cdn.agora.io/docs-files/1577090428042)


### 示例代码

你可以对照 API 时序图，参考下面的示例代码片段，在项目中实现原始视频数据功能：

```c++
#include <jni.h>
#include <android/log.h>
#include <cstring>
 
#include "agora/IAgoraRtcEngine.h"
#include "agora/IAgoraMediaEngine.h"
 
#include "video_preprocessing_plugin_jni.h"
 
class AgoraVideoFrameObserver : public agora::media::IVideoFrameObserver
{
public:
    // 获取本地摄像头采集到的视频帧
    virtual bool onCaptureVideoFrame(VideoFrame& videoFrame) override
    {
        int width = videoFrame.width;
        int height = videoFrame.height;
 
        memset(videoFrame.uBuffer, 128, videoFrame.uStride * height / 2);
        memset(videoFrame.vBuffer, 128, videoFrame.vStride * height / 2);
 
        return true;
    }
     
    // 获取远端用户发送的视频帧
    virtual bool onRenderVideoFrame(unsigned int uid, VideoFrame& videoFrame) override
    {
        return true;
    }
		// 获取本地视频编码前的视频帧
    virtual bool onPreEncodeVideoFrame(VideoFrame& videoFrame) override
    {
        return true;
    }
};

class IVideoFrameObserver
{
     public:
         enum VIDEO_FRAME_TYPE {
         FRAME_TYPE_YUV420 = 0,  // 视频帧格式为 YUV 420
         };
     struct VideoFrame {
         VIDEO_FRAME_TYPE type;
         int width;  // 视频帧的宽
         int height;  // 视频帧的高
         int yStride;  // YUV 数据中的 Y 缓冲区的行跨度
         int uStride;  // YUV 数据中的 U 缓冲区的行跨度
         int vStride;  // YUV 数据中的 V 缓冲区的行跨度
         void* yBuffer;  // YUV 数据中的 Y 缓冲区的指针
         void* uBuffer;  // YUV 数据中 U 缓冲区的指针
         void* vBuffer;  // YUV 数据中 V 缓冲区的指针
         int rotation; // 该帧的旋转信息，可设为 0, 90, 180, 270
         int64_t renderTimeMs; // 该帧的时间戳
         };
     public:
         virtual bool onCaptureVideoFrame(VideoFrame& videoFrame) = 0;
         virtual bool onRenderVideoFrame(unsigned int uid, VideoFrame& videoFrame) = 0;
				 virtual bool onPreEncodeVideoFrame(VideoFrame& videoFrame) { return true; }
};
```
 
同时，我们在 GitHub 提供一个开源的 [Agora-Plugin-Raw-Data-API-Android-Java](https://github.com/AgoraIO/Advanced-Video/blob/master/Capture-Raw-Video-Data/Agora-Plugin-Raw-Data-API-Android-Java) 示例项目。你可以前往下载，或参考 [VideoChatViewActivity.java](https://github.com/AgoraIO/Advanced-Video/blob/master/Capture-Raw-Video-Data/Agora-Plugin-Raw-Data-API-Android-Java/app/src/main/java/io/agora/rtc/plugin/rawdata/sample/VideoChatViewActivity.java) 文件的源代码。
 
 ### API 参考
 
 - [`registerVideoFrameObserver`](./API%20Reference/cpp/classagora_1_1media_1_1_i_media_engine.html#a5eee4dfd1fd46e4a865feba163f3c5de)
 - [`onCaptureVideoFrame`](./API%20Reference/cpp/classagora_1_1media_1_1_i_video_frame_observer.html#a915c673aec879dcc2b08246bb2fcf49a)
 - [`onRenderVideoFrame`](./API%20Reference/cpp/classagora_1_1media_1_1_i_video_frame_observer.html#a966ed2459b6887c52112af638bc27c14)
 - [`onPreEncodeVideoFrame`](./API%20Reference/cpp/classagora_1_1media_1_1_i_video_frame_observer.html#a2be41cdde19fcc0f365d4eb14a963e1c)

## 开发注意事项

本文中使用的原始数据接口为 C++ 接口。如果你在 Android 平台开发，请参考如下步骤，使用 SDK 库的 JNI 和插件管理器注册视频数据观测器。

1.创建一个共享库工程。该工程必须以 `libapm-` 为前缀，`so` 为后缀，如 `libapm-encryption.so`。
2. 加入频道前，调用 `loadAgoraRtcEnginePlugin` 接口，RtcEngine 会自动加载统计目录插件，即刚刚创建的 `libapm-encryption.so` 文件。
3. SDK 销毁引擎后，调用 `unloadAgoraRtcEnginePlugin` 接口，RtcEngine 会自动卸载插件。

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

## 相关文档

如果你还想在项目中实现原始音频数据功能，请参考[原始音频数据](raw_data_audio_android)。