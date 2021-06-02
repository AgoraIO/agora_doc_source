---
title: 原始音频数据
platform: Android
updatedAt: 2021-03-05 08:16:14
---
## 功能描述

音频传输过程中，我们可以对采集到的音频数据进行前处理和后处理，获取想要的播放效果。

对于有自行处理音频数据需求的场景，Agora 提供原始数据功能，你可以在将数据发送给编码器前进行前处理，对捕捉到的语音信号进行修改；也可以在将数据发送给解码器后进行后处理，对接收到的语音信号进行修改。

## 示例项目

我们在 GitHub 上提供以下开源的示例项目:
- [通过 JNI 调用 C++ 接口获取原始音频数据](https://github.com/AgoraIO/API-Examples/blob/master/Android/APIExample/app/src/main/java/io/agora/api/example/examples/advanced/ProcessRawData.java)
- [调用 Java 接口获取原始音频数据](https://github.com/AgoraIO/API-Examples/blob/master/Android/APIExample/app/src/main/java/io/agora/api/example/examples/advanced/ProcessAudioRawData.java)

你可以前往下载，或查看其中的源代码。

## 实现方法

在使用原始数据功能前，请确保你已在项目中完成基本的实时音频功能。

### 调用 Java 接口获取原始音频数据

从 v3.3.0 开始，你可以调用 Java 接口，获取原始音频数据并进行处理。

1. 加入频道前调用 `registerAudioFrameObserver` 方法注册语音观测器。在此之前，你需要先创建一个 `IAudioFrameObserver` 实例。
2. 调用 `set` 方法设置你想要获取的音频帧格式。
3. 实现 `onRecordFrame`、`onPlaybackFrame`、`onPlaybackFrameBeforeMixing` 和 `onMixedFrame` 回调。从回调中获取音频帧并进行处理。

#### API 调用时序

下图展示使用原始音频数据的 API 调用时序：

![](https://web-cdn.agora.io/docs-files/1614567140163)

#### 示例代码

```java
// 调用 registerAudioFrameObserver 方法注册语音观测器，并在该方法中传入一个 IAudioFrameObserver 实例。
engine.registerAudioFrameObserver(new IAudioFrameObserver() {
    
    //实现 onRecordFrame 回调，从回调中获取音频帧并进行播放。
    @Override
    public boolean onRecordFrame(byte[] samples, int numOfSamples, int bytesPerSample, int channels, int samplesPerSec) {
        if(isEnableLoopBack){
            mAudioPlayer.play(samples, 0, numOfSamples * bytesPerSample);
        }
        
        return false;
    }
    //实现 onPlaybackFrame 回调
    @Override
    public boolean onPlaybackFrame(byte[] samples, int numOfSamples, int bytesPerSample, int channels, int samplesPerSec) {
        return false;
    }
    //实现 onPlaybackFrameBeforeMixing 回调
    @Override
    public boolean onPlaybackFrameBeforeMixing(byte[] samples, int numOfSamples, int bytesPerSample, int channels, int samplesPerSec, int uid) {
        return false;
    }


    //实现 onMixedFrame 回调
    @Override
    public boolean onMixedFrame(byte[] samples, int numOfSamples, int bytesPerSample, int channels, int samplesPerSec) {
        return false;
    }
    
    // 调用 set 方法设置各回调返回的音视频帧格式
    engine.setRecordingAudioFrameParameters(SAMPLE_RATE, SAMPLE_NUM_OF_CHANNEL, Constants.RAW_AUDIO_FRAME_OP_MODE_READ_WRITE,SAMPLES_PER_CALL);
    engine.setMixedAudioFrameParameters(SAMPLE_RATE, SAMPLES_PER_CALL);
    engine.setPlaybackAudioFrameParameters(SAMPLE_RATE, SAMPLE_NUM_OF_CHANNEL, Constants.RAW_AUDIO_FRAME_OP_MODE_READ_WRITE,SAMPLES_PER_CALL);
});
```



#### API 参考

- [registerAudioFrameObserver](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a57eaa3859be21cd327763fc316197fff)
- [setRecordingAudioFrameParameters](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a682a8c493660bb565a38869dcc84c73e)
- [setPlaybackAudioFrameParameters](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a07e30f884f4dae8c7ddba740aeb008f1)
- [setMixedAudioFrameParameters](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a24da4130cac855befeac9b2f2e6e751f)
- [onRecordFrame](./API%20Reference/java/interfaceio_1_1agora_1_1rtc_1_1_i_audio_frame_observer.html#a386c3a451ce95f796d64e83006d7779c)
- [onPlaybackFrame](./API%20Reference/java/interfaceio_1_1agora_1_1rtc_1_1_i_audio_frame_observer.html#a3781dd30d34a0634140872a9dd131488)
- [onPlaybackFrameBeforeMixing](./API%20Reference/java/interfaceio_1_1agora_1_1rtc_1_1_i_audio_frame_observer.html#ab43c709bdbce83f907b00710b48d8d56)
- [onMixedFrame](./API%20Reference/java/interfaceio_1_1agora_1_1rtc_1_1_i_audio_frame_observer.html#a81794255075807161fa1a3c13e23db2c)

### 通过 JNI 调用 C++ 接口获取原始音频数据

<div class="alert note">Agora C++ SDK 通过提供 <code>IAudioFrameObserver</code> 类，实现采集、修改原始音频数据功能。你可以通过 JNI (Java Native Interface) 使用 Java 调用 Agora 的 C++ 接口。由于 RTC Java SDK 封装了 RTC C++ SDK，所以可以直接通过 include SDK 中 <code>.h</code> 文件的方式调用 C++ 方法。</div>

参考如下步骤，在你的项目中实现原始音频数据功能：

1. 在项目中通过 JNI 和 C++ 接口文件生成共享库，从而可以使 Java 调用 Agora C++ SDK 的原始音频数据相关接口。
2. 加入频道前调用 `registerAudioFrameObserver` 方法注册语音观测器，并在该方法中实现一个 `IAudioFrameObserver` 类。
3. 成功注册后，SDK 通过 `onRecordAudioFrame`、`onPlaybackAudioFrame`、`onPlaybackAudioFrameBeforeMixing` 或 `onMixedAudioFrame` 回调发送采集到的原始音频数据。
4. 用户拿到音频数据后，根据场景需要自行进行处理。完成音频数据处理后，你可以直接进行自播放，或根据场景需求再通过 `onRecordAudioFrame`、`onPlaybackAudioFrame`、`onPlaybackAudioFrameBeforeMixing` 或 `onMixedAudioFrame` 回调发送给 SDK。

#### 在 Java 项目中调用 Agora C++ API

![](https://web-cdn.agora.io/docs-files/1607667406469)

- Java 项目通过 Java 接口文件加载 C++ 接口文件（`.cpp` 文件）编译成的 `.so` 库。
- Java 接口文件通过 `javac -h -jni` 命令生成 .h 文件。C++ 接口文件需要 include 此文件。
- C++ 接口文件通过 include Agora Android SDK 的头文件调用 Agora Android SDK 中 `.so` 库的 C++ 方法。

#### API 调用时序

下图展示使用原始音频数据的 API 调用时序：

<div class="alert note"><code>registerAudioFrameObserver</code>、<code>onRecordAudioFrame</code>、<code>onPlaybackAudioFrame</code>、<code>onMixedAudioFrame</code> 和 <code>onPlaybackAudioFrameBeforeMixing</code> 均为 C++ 方法和回调。</div>

![img](https://web-cdn.agora.io/docs-files/1569223703579)

#### 示例代码

##### 创建 JNI 接口

通过 JNI 接口分别创建 Java 和 C++ 的接口文件，并将 C++ 接口文件构建为 `.so` 库。

1. 创建用于调用 C++ API 的 Java 接口文件。接口文件中声明需要调用 C++ 的相关 Java 方法。具体实现可参考示例项目中的 `MediaPreProcessing.java` 文件。

```java
// Java 接口文件，声明需要调用 C++ 的相关 Java 方法
package io.agora.advancedvideo.rawdata;

import java.nio.ByteBuffer;

public class MediaPreProcessing {
    static {
        // 加载 C++ .so 库。.so 库通过编译 C++ 接口文件生成。
        // .so 库的名称取决于编译 C++ 接口文件生成的库名
        System.loadLibrary("apm-plugin-raw-data");
    }
    // 定义本地方法
    public interface ProgressCallback {

       ...

        // 获取录制的音频帧
        void onRecordAudioFrame(int audioFrameType, int samples, int bytesPerSample, int channels, int samplesPerSec, long renderTimeMs, int bufferLength);
        // 获取播放的音频帧
        void onPlaybackAudioFrame(int audioFrameType, int samples, int bytesPerSample, int channels, int samplesPerSec, long renderTimeMs, int bufferLength);
        // 获取混音前播放的音频帧
        void onPlaybackAudioFrameBeforeMixing(int uid, int audioFrameType, int samples, int bytesPerSample, int channels, int samplesPerSec, long renderTimeMs, int bufferLength);
        // 获取混音后的音频帧
        void onMixedAudioFrame(int audioFrameType, int samples, int bytesPerSample, int channels, int samplesPerSec, long renderTimeMs, int bufferLength);
    }

    public static native void setCallback(ProgressCallback callback);

    public static native void setAudioRecordByteBuffer(ByteBuffer byteBuffer);

    public static native void setAudioPlayByteBuffer(ByteBuffer byteBuffer);

    public static native void setBeforeAudioMixByteBuffer(ByteBuffer byteBuffer);

    public static native void setAudioMixByteBuffer(ByteBuffer byteBuffer);


    public static native void releasePoint();

}
```

2. 运行以下命令从 Java 接口文件生成 .h 文件。

```shell
# JDK 10 或更高版本
javac -h -jni MediaPreProcessing.java

# JDK 9 或更早版本
javac MediaPreProcessing.java
javah -jni MediaPreProcessing.class
```

3. 创建 C++ 接口文件，用于被 Java 调用。C++ 接口文件需要根据生成的 `.h` 文件，从 C++ SDK export 相应的方法。具体实现可参考示例项目中的 `io_agora_advancedvideo_rawdata_MediaPreProcessing.cpp` 文件。

   <div class="alert note">JNI 在 C++ 中定义了与 Java 相映射的数据结构。你可以参考<a href="https://docs.oracle.com/javase/7/docs/technotes/guides/jni/spec/jniTOC.html">这里</a>获取详细信息。</div>

```cpp
// 全局变量

jobject gCallBack = nullptr;
jclass gCallbackClass = nullptr;
// Java 层的 method ID
jmethodID recordAudioMethodId = nullptr;
jmethodID playbackAudioMethodId = nullptr;
jmethodID playBeforeMixAudioMethodId = nullptr;
jmethodID mixAudioMethodId = nullptr;
// 从 onRecordAudioFrame 获取的音频帧 ByteBuffer
void *_javaDirectPlayBufferRecordAudio = nullptr;
// 从 onPlaybackAudioFrame 获取的音频帧 ByteBuffer
void *_javaDirectPlayBufferPlayAudio = nullptr;
// 从 onPlaybackAudioFrameBeforeMixing 获取的音频帧 ByteBuffer
void *_javaDirectPlayBufferBeforeMixAudio = nullptr;
// 从 onMixedAudioFrame 获取的音频帧 ByteBuffer
void *_javaDirectPlayBufferMixAudio = nullptr;
map<int, void *> decodeBufferMap;

static JavaVM *gJVM = nullptr;

// 实现 IAudioFrameObserver 类及相关回调
class AgoraAudioFrameObserver : public agora::media::IAudioFrameObserver
{

public:
    AgoraAudioFrameObserver()
    {
        gCallBack = nullptr;
    }

    ~AgoraAudioFrameObserver()
    {
    }
// 从 AudioFrame 对象获取音频帧数据，复制到 ByteBuffer，并通过 method ID 调用 Java 方法
    void getAudioFrame(AudioFrame &audioFrame, _jmethodID *jmethodID, void *_byteBufferObject,
                       unsigned int uid)
    {
        if (_byteBufferObject == nullptr)
        {
            return;
        }

        AttachThreadScoped ats(gJVM);
        JNIEnv *env = ats.env();
        if (env == nullptr)
        {
            return;
        }
        int len = audioFrame.samples * audioFrame.bytesPerSample;
        memcpy(_byteBufferObject, audioFrame.buffer, (size_t) len); // * sizeof(int16_t)

        if (uid == 0)
        {
            env->CallVoidMethod(gCallBack, jmethodID, audioFrame.type, audioFrame.samples,
                                audioFrame.bytesPerSample,
                                audioFrame.channels, audioFrame.samplesPerSec,
                                audioFrame.renderTimeMs, len);
        } else
        {
            env->CallVoidMethod(gCallBack, jmethodID, uid, audioFrame.type, audioFrame.samples,
                                audioFrame.bytesPerSample,
                                audioFrame.channels, audioFrame.samplesPerSec,
                                audioFrame.renderTimeMs, len);
        }
    }
    // 将音频帧数据从 ByteBuffer 复制到 AudioFrame 对象
    void writebackAudioFrame(AudioFrame &audioFrame, void *byteBuffer)
    {
        if (byteBuffer == nullptr)
        {
            return;
        }

        int len = audioFrame.samples * audioFrame.bytesPerSample;
        memcpy(audioFrame.buffer, byteBuffer, (size_t) len);
    }

public:
    // 实现 onRecordAudioFrame 回调
    virtual bool onRecordAudioFrame(AudioFrame &audioFrame) override
    {
        // 获取录制的音频帧
        getAudioFrame(audioFrame, recordAudioMethodId, _javaDirectPlayBufferRecordAudio, 0);
        // 将音频帧发送回 SDK
        writebackAudioFrame(audioFrame, _javaDirectPlayBufferRecordAudio);
        return true;
    }

    // 实现 onPlaybackAudioFrame 回调
    virtual bool onPlaybackAudioFrame(AudioFrame &audioFrame) override
    {
        // 获取播放的音频帧
        getAudioFrame(audioFrame, playbackAudioMethodId, _javaDirectPlayBufferPlayAudio, 0);
        // 将音频帧发送回 SDK
        writebackAudioFrame(audioFrame, _javaDirectPlayBufferPlayAudio);
        return true;
    }

   // 实现 onPlaybackAudioFrameBeforeMixing 回调
    virtual bool onPlaybackAudioFrameBeforeMixing(unsigned int uid, AudioFrame &audioFrame) override
    {
        // 获取混音前播放的音频帧
        getAudioFrame(audioFrame, playBeforeMixAudioMethodId, _javaDirectPlayBufferBeforeMixAudio,
                      uid);
        // 将音频帧发送回 SDK
        writebackAudioFrame(audioFrame, _javaDirectPlayBufferBeforeMixAudio);
        return true;
    }

    // 实现 onMixedAudioFrame 回调
    virtual bool onMixedAudioFrame(AudioFrame &audioFrame) override
    {
        // 获取混音后的音频帧
        getAudioFrame(audioFrame, mixAudioMethodId, _javaDirectPlayBufferMixAudio, 0);
        // 将音频帧发送回 SDK
        writebackAudioFrame(audioFrame, _javaDirectPlayBufferMixAudio);
        return true;
    }
};


...

// AgoraAudioFrameObserver 对象
static AgoraAudioFrameObserver s_audioFrameObserver;
// IRtcEngine 对象
static agora::rtc::IRtcEngine *rtcEngine = nullptr;

// 设置 C++ 接口
#ifdef __cplusplus
extern "C" {
#endif


int __attribute__((visibility("default")))
loadAgoraRtcEnginePlugin(agora::rtc::IRtcEngine *engine)
{
    __android_log_print(ANDROID_LOG_DEBUG, "agora-raw-data-plugin", "loadAgoraRtcEnginePlugin");
    rtcEngine = engine;
    return 0;
}

void __attribute__((visibility("default")))
unloadAgoraRtcEnginePlugin(agora::rtc::IRtcEngine *engine)
{
    __android_log_print(ANDROID_LOG_DEBUG, "agora-raw-data-plugin", "unloadAgoraRtcEnginePlugin");

    rtcEngine = nullptr;
}


...


// 针对 Java 接口文件，通过 JNI 导出相应的 C++ 实现。
// Java_io_agora_advancedvideo_rawdata_MediaPreProcessing_setCallback 方法
// 对应 Java 接口文件的 setCallback 方法。
JNIEXPORT void JNICALL Java_io_agora_advancedvideo_rawdata_MediaPreProcessing_setCallback
        (JNIEnv *env, jclass, jobject callback)
{
    if (!rtcEngine) return;

    env->GetJavaVM(&gJVM);
    // 创建使用 IMediaEngine 类为 template 的 AutoPtr 实例
    agora::util::AutoPtr<agora::media::IMediaEngine> mediaEngine;
    // AutoPtr 实例调用 queryInterface 方法，通过 IID 获取 IMediaEngine 实例的指针。
    // AutoPtr 实例会通过箭头操作符访问 IMediaEngine 实例的指针并通过 IMediaEngine 实例调用 registerVideoFrameObserver
    mediaEngine.queryInterface(rtcEngine, agora::INTERFACE_ID_TYPE::AGORA_IID_MEDIA_ENGINE);
    if (mediaEngine)
    {

        ...


        // 注册音频帧观测器
        int ret = mediaEngine->registerAudioFrameObserver(&s_audioFrameObserver);

    }

if (gCallBack == nullptr)
    {
        gCallBack = env->NewGlobalRef(callback);
        gCallbackClass = env->GetObjectClass(gCallBack);

        // 获取回调函数的 method ID
        recordAudioMethodId = env->GetMethodID(gCallbackClass, "onRecordAudioFrame", "(IIIIIJI)V");
        playbackAudioMethodId = env->GetMethodID(gCallbackClass, "onPlaybackAudioFrame",
                                                 "(IIIIIJI)V");
        playBeforeMixAudioMethodId = env->GetMethodID(gCallbackClass,
                                                      "onPlaybackAudioFrameBeforeMixing",
                                                      "(IIIIIIJI)V");
        mixAudioMethodId = env->GetMethodID(gCallbackClass, "onMixedAudioFrame", "(IIIIIJI)V");

        ...

        __android_log_print(ANDROID_LOG_DEBUG, "setCallback", "setCallback done successfully");
    }

}

...

// Java 接口文件中 setAudioRecordByteBuffer 方法的 C++ 实现
JNIEXPORT void JNICALL
Java_io_agora_advancedvideo_rawdata_MediaPreProcessing_setAudioRecordByteBuffer
        (JNIEnv *env, jclass, jobject bytebuffer)
{
    _javaDirectPlayBufferRecordAudio = env->GetDirectBufferAddress(bytebuffer);
}
// Java 接口文件中 setAudioPlayByteBuffer 方法的 C++ 实现
JNIEXPORT void JNICALL Java_io_agora_advancedvideo_rawdata_MediaPreProcessing_setAudioPlayByteBuffer
        (JNIEnv *env, jclass, jobject bytebuffer)
{
    _javaDirectPlayBufferPlayAudio = env->GetDirectBufferAddress(bytebuffer);
}
//  Java 接口文件中 setBeforeAudioMixByteBuffer 方法的 C++ 实现
JNIEXPORT void JNICALL
Java_io_agora_advancedvideo_rawdata_MediaPreProcessing_setBeforeAudioMixByteBuffer
        (JNIEnv *env, jclass, jobject bytebuffer)
{
    _javaDirectPlayBufferBeforeMixAudio = env->GetDirectBufferAddress(bytebuffer);
}
//  Java 接口文件中 setAudioMixByteBuffer 方法的 C++ 实现
JNIEXPORT void JNICALL Java_io_agora_advancedvideo_rawdata_MediaPreProcessing_setAudioMixByteBuffer
        (JNIEnv *env, jclass, jobject bytebuffer)
{
    _javaDirectPlayBufferMixAudio = env->GetDirectBufferAddress(bytebuffer);
}

}


...


#ifdef __cplusplus
}
#endif
```

4. 通过 NDK 构建 C++ 接口文件，生成 `.so` 库。CMake 示例内容如下。所生成的 .so 库在 Java 接口文件中通过 `System.loadLibrary()` 的方式加载。

```
cmake_minimum_required(VERSION 3.4.1)

add_library( # Sets the name of the library.
        apm-plugin-raw-data

        # Sets the library as a shared library.
        SHARED

        # Provides a relative path to your source file(s).
        src/main/cpp/io_agora_advancedvideo_rawdata_MediaPreProcessing.cpp)


find_library( # Sets the name of the path variable.
        log-lib

        # Specifies the name of the NDK library that
        # you want CMake to locate.
        log)

target_link_libraries( # Specifies the target library.
        apm-plugin-raw-data

        # Links the target library to the log library
        # included in the NDK.
        ${log-lib})
```

   #####  在 Java 项目中实现原始音频数据功能

1. 实现 Java 接口文件中与 C++ 方法映射的接口。

```java
// 在 Java 中实现 ProgressCallback 接口
public class MediaDataObserverPlugin implements MediaPreProcessing.ProgressCallback {


    ...

   // 获取录制的音频帧
   @Override
    public void onRecordAudioFrame(int audioFrameType, int samples, int bytesPerSample, int channels, int samplesPerSec, long renderTimeMs, int bufferLength) {
        byte[] buf = new byte[bufferLength];
        byteBufferAudioRecord.limit(bufferLength);
        byteBufferAudioRecord.get(buf);
        byteBufferAudioRecord.flip();

        for (MediaDataAudioObserver observer : audioObserverList) {
            observer.onRecordAudioFrame(buf, audioFrameType, samples, bytesPerSample, channels, samplesPerSec, renderTimeMs, bufferLength);
        }

        byteBufferAudioRecord.put(buf);
        byteBufferAudioRecord.flip();
    }

    // 获取播放的音频帧
    @Override
    public void onPlaybackAudioFrame(int audioFrameType, int samples, int bytesPerSample, int channels, int samplesPerSec, long renderTimeMs, int bufferLength) {
        byte[] buf = new byte[bufferLength];
        byteBufferAudioPlay.limit(bufferLength);
        byteBufferAudioPlay.get(buf);
        byteBufferAudioPlay.flip();

        for (MediaDataAudioObserver observer : audioObserverList) {
            observer.onPlaybackAudioFrame(buf, audioFrameType, samples, bytesPerSample, channels, samplesPerSec, renderTimeMs, bufferLength);
        }

        byteBufferAudioPlay.put(buf);
        byteBufferAudioPlay.flip();
    }
    // 获取混音前播放的音频帧
    @Override
    public void onPlaybackAudioFrameBeforeMixing(int uid, int audioFrameType, int samples, int bytesPerSample, int channels, int samplesPerSec, long renderTimeMs, int bufferLength) {
        byte[] buf = new byte[bufferLength];
        byteBufferBeforeAudioMix.limit(bufferLength);
        byteBufferBeforeAudioMix.get(buf);
        byteBufferBeforeAudioMix.flip();

        for (MediaDataAudioObserver observer : audioObserverList) {
            observer.onPlaybackAudioFrameBeforeMixing(uid, buf, audioFrameType, samples, bytesPerSample, channels, samplesPerSec, renderTimeMs, bufferLength);
        }

        byteBufferBeforeAudioMix.put(buf);
        byteBufferBeforeAudioMix.flip();
    }
    // 获取混音后的音频帧
    @Override
    public void onMixedAudioFrame(int audioFrameType, int samples, int bytesPerSample, int channels, int samplesPerSec, long renderTimeMs, int bufferLength) {
        byte[] buf = new byte[bufferLength];
        byteBufferAudioMix.limit(bufferLength);
        byteBufferAudioMix.get(buf);
        byteBufferAudioMix.flip();

        for (MediaDataAudioObserver observer : audioObserverList) {
            observer.onMixedAudioFrame(buf, audioFrameType, samples, bytesPerSample, channels, samplesPerSec, renderTimeMs, bufferLength);
        }

        byteBufferAudioMix.put(buf);
        byteBufferAudioMix.flip();
    }
 }
```

2. 在 Java 中，调用 `setCallback` 方法。`setCallback` 方法通过 JNI 调用 C++ API 的 `registerAudioFrameObserver` 方法，注册音频帧观测器。

```java
@Override
   public void onActivityCreated(@Nullable Bundle savedInstanceState) {
       super.onActivityCreated(savedInstanceState);
       mediaDataObserverPlugin = MediaDataObserverPlugin.the();
       // 注册音频帧观测器
       MediaPreProcessing.setCallback(mediaDataObserverPlugin);

       ...

   }
```

3. 实现 `onRecordAudioFrame` 回调，`onPlaybackAudioFrame` 回调， `onPlaybackAudioFrameBeforeMixing` 回调，和 `onMixedAudioFrame` 回调。从回调中获取音频帧并进行处理。

```java
// 获取录制的音频帧
@Override
 public void onRecordAudioFrame(byte[] data, int audioFrameType, int samples, int bytesPerSample, int channels, int samplesPerSec, long renderTimeMs, int bufferLength) {

 }

 // 获取播放的音频帧
 @Override
 public void onPlaybackAudioFrame(byte[] data, int audioFrameType, int samples, int bytesPerSample, int channels, int samplesPerSec, long renderTimeMs, int bufferLength) {

 }


// 获取混音前播放的音频帧
 @Override
 public void onPlaybackAudioFrameBeforeMixing(int uid, byte[] data, int audioFrameType, int samples, int bytesPerSample, int channels, int samplesPerSec, long renderTimeMs, int bufferLength) {

 }

// 获取混音后的音频帧
 @Override
 public void onMixedAudioFrame(byte[] data, int audioFrameType, int samples, int bytesPerSample, int channels, int samplesPerSec, long renderTimeMs, int bufferLength) {

 }
```

#### API 参考

- [`registerAudioFrameObserver`](https://docs.agora.io/cn/Interactive%20Broadcast/API%20Reference/cpp/classagora_1_1media_1_1_i_media_engine.html#ae46ca0d20789787aaab2fb268a524100)
- [`setRecordingAudioFrameParameters`](https://docs.agora.io/cn/Interactive%20Broadcast/API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#a2c4717760b5fbf1bb8c1a3c16ca67fe5)
- [`setPlaybackAudioFrameParameters`](https://docs.agora.io/cn/Interactive%20Broadcast/API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#aa5f2f6eb3db5acaaf8c40818d90694f1)
- [`setMixedAudioFrameParameters`](https://docs.agora.io/cn/Interactive%20Broadcast/API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#a520ebcda51b5eb488339f3a12dfb8013)
- [`onRecordAudioFrame`](https://docs.agora.io/cn/Interactive%20Broadcast/API%20Reference/cpp/classagora_1_1media_1_1_i_audio_frame_observer.html#ac6ab0c792420daf929fed78f9d39f728)
- [`onPlaybackAudioFrame`](https://docs.agora.io/cn/Interactive%20Broadcast/API%20Reference/cpp/classagora_1_1media_1_1_i_audio_frame_observer.html#aefc7f9cb0d1fcbc787775588bc849bac)
- [`onPlaybackAudioFrameBeforeMixing`](https://docs.agora.io/cn/Interactive%20Broadcast/API%20Reference/cpp/classagora_1_1media_1_1_i_audio_frame_observer.html#ae04d85a65eefec5e7c1e0477bcaa067c)
- [`onMixedAudioFrame`](https://docs.agora.io/cn/Interactive%20Broadcast/API%20Reference/cpp/classagora_1_1media_1_1_i_audio_frame_observer.html#a78d095cbd0b8ee04f657430bb6de8100)