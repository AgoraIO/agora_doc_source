---
title: 原始音频数据
platform: iOS
updatedAt: 2020-12-07 04:54:11
---
## 功能描述

音视频传输过程中，我们可以对采集到的音视频数据进行前处理和后处理，获取想要的播放效果。

对于有自行处理音视频数据需求的场景，Agora 提供原始数据功能，你可以在将数据发送给编码器前进行前处理，对捕捉到的语音信号或视频帧进行修改；也可以在将数据发送给解码器后进行后处理，对接收到的语音信号或视频帧进行修改。

Native SDK 通过提供 `IAudioFrameObserver` 类，实现采集、修改原始音频数据功能。

## 示例项目

Agora 在 GitHub 上提供以下实现了原始音频数据功能的开源示例项目：

- iOS：[RawMediaData](https://github.com/AgoraIO/API-Examples/blob/master/iOS/APIExample/Examples/Advanced/RawMediaData/RawMediaData.swift)
- macOS：[RawMediaData](https://github.com/AgoraIO/API-Examples/blob/master/macOS/APIExample/Examples/Advanced/RawMediaData/RawMediaData.swift)

你可以下载体验并参考源代码。


## 实现方法
在使用原始数据功能前，请确保你已在项目中完成基本的实时音视频功能。

参考如下步骤，在你的项目中实现原始音频数据功能：

1. 加入频道前调用 `registerAudioFrameObserver` 方法注册语音观测器，并在该方法中实现一个 `IAudioFrameObserver` 类。
2. 成功注册后，SDK 通过 `onRecordAudioFrame`、`onPlaybackAudioFrame`、`onPlaybackAudioFrameBeforeMixing` 或 `onMixedAudioFrame` 回调发送采集到的原始音频数据。
3. 拿到音频数据后，你需要根据场景需要自行进行处理。完成音频数据处理后，你可以直接进行自播放，或根据场景需求再通过 `onRecordAudioFrame`、`onPlaybackAudioFrame`、`onPlaybackAudioFrameBeforeMixing` 或 `onMixedAudioFrame` 回调发送给 SDK。

<div class= "alert note">由于 Agora 仅提供 C++ 语言的音频原始数据接口，实现上述步骤需要在 iOS 或 macOS 上调用 C++ 语言的 API，因此在相关实现中，请注意如下项：<ul></ul><li>代码中涉及 Objective-C 与 C++ 混编的逻辑需要在 <code>.mm</code> 文件中实现。</li><li><code>.mm</code> 文件的开头需要引入 C++ 头文件。
	</li><li>调用 <code>registerAudioFrameObserver</code> 注册语音观测器前，需要先调用 <code>getNativeHandler</code> 获取 C++ 的回调句柄，否则会收不到相关回调。</li></ul></div>
	
### 数据流转图

下图展示了原始音频数据的流转：

![](https://web-cdn.agora.io/docs-files/1604634304743)

你可以通过 `onRecordAudioFrame`、`onPlaybackAudioFrame`、`onPlaybackAudioFrameBeforeMixing` 或 `onMixedAudioFrame` 回调：

- 获取原始音频数据。
- 对原始音频数据进行处理并返回到 SDK。


### API 时序图

下图展示使用原始音频数据的 API 调用时序：

![](https://web-cdn.agora.io/docs-files/1569209374977)

### 示例代码

你可以对照 API 时序图，参考下面的示例代码片段，在项目中实现音频原始数据功能：

**1. 初始化 AgoraRtcEngineKit**

调用 sharedEngineWithConfig 初始化 AgoraRtcEngineKit。

```swift
// Swift
// 初始化 AgoraRtcEngineKit
let config = AgoraRtcEngineConfig()
agoraKit = AgoraRtcEngineKit.sharedEngine(with: config, delegate: self)
```

**2. 注册语音数据观测器**

由于 Agora 仅提供 C++ 语言的音频原始数据相关接口，我们需要通过在 iOS 或 macOS 上调用 C++ 接口，实现注册音频数据观测器。

<div class="alert note">该步骤代码需要在 .mm 文件中执行。</div>

```C++
// 引入 C++ 头文件
#import <AgoraRtcKit/IAgoraMediaEngine.h>
#import <AgoraRtcKit/IAgoraRtcEngine.h>
 
 
- (void)registerAudioRawDataObserver:(ObserverAudioType)observerType {
    // 获取 Native SDK 的 C++ 句柄
    agora::rtc::IRtcEngine* rtc_engine = (agora::rtc::IRtcEngine*)self.agoraKit.getNativeHandle;
    // 创建 IMediaEngine 实例
    agora::util::AutoPtr<agora::media::IMediaEngine> mediaEngine;
    // 必须使用 IMediaEngine 实例调用 queryInterface 设置 agora::AGORA_IID_MEDIA_ENGINE 接口，否则无法使用 mediaEngine 执行 registerAudioFrameObserver
    mediaEngine.queryInterface(rtc_engine, agora::AGORA_IID_MEDIA_ENGINE);
     
    NSInteger oldValue = self.observerAudioType;
    self.observerAudioType |= observerType;
     
    if (mediaEngine && oldValue == 0)
    {
        // 注册音频帧观测器
        mediaEngine->registerAudioFrameObserver(&s_audioFrameObserver);
        s_audioFrameObserver.mediaDataPlugin = self;
    }
}
```

**3. 设置音频数据采集参数**

如果想要设置采集到的音频数据的采样率、修改模式、声道数、采样间隔等，可以在加入频道前，调用如下方法分别设置对应回调内返回的原始音频数据格式。

```swift
// Swift
// 设置 onRecordAudioFrame 回调返回的音频数据格式
agoraKit.setRecordingAudioFrameParametersWithSampleRate(44100, channel: 1, mode: .readWrite, samplesPerCall: 4410)
// 设置 onMixedAudioFrame 回调返回的音频数据格式
agoraKit.setMixedAudioFrameParametersWithSampleRate(44100, samplesPerCall: 4410)
// 设置 onPlaybackAudioFrame 回调返回的音频数据格式
agoraKit.setPlaybackAudioFrameParametersWithSampleRate(44100, channel: 1, mode: .readWrite, samplesPerCall: 4410)
```

**4. 加入频道**

调用 `joinChannelByToken` 加入频道。

```swift
// Swift
agoraKit.joinChannel(byToken: nil, channelId: channelName, info: nil, uid: 0) {[unowned self] (channel, uid, elapsed)}
```

**5. 获取采集到的音频数据**

加入频道后，你可以通过 `IAudioFrameObserver` 类中的回调接收采集到的音频数据。完成音频数据处理后，你还可以通过这些回调将处理过的数据再发送回给 SDK。

```swift
// Swift
// 获取本地用户的原始音频数据，处理后再发送回 SDK
func mediaDataPlugin(_mediaDataPlugin: AgoraMediaDataPlugin, didRecord audioRawData: AgoraAudioRawDate) -> AgoraAudioRawData {
  return audioRawData
}
 
// 获取所有远端用户的原始音频数据，处理后再发送回 SDK
func mediaDataPlugin(_mediaDataPlugin: AgoraMediaDataPlugin, willPlaybackAudioRawData audioRawData: AgoraRawData) -> AgoraAudioRawData {
  return audioRawData
}
 
// 获取特定远端用户的原始音频数据，处理后再发送回 SDK
func mediaDataPlugin(_mediaDataPlugin: AgoraMediaDataPlugin, willPlaybackBeforeMixing audioRawData: AgoraAudioRawData, ofUid uid: uint) -> AgoraAudioRawData {
  return audioRawData
}
 
// 获取本地用户和所有远端用户的原始音频数据，处理后再发送回 SDK
func mediaDataPlugin(_mediaDataPlugin: AgoraMediaDataPlugin, didMixedAudioRawData audioRawData: AgoraAudioRawData) -> AgoraAudioRawData {
  return audioRawData
}
```

在 `.mm` 文件中调用 C++ 的 API 实现获取原始音频数据的回调。

```swift
// Swift
class AgoraMediaDataPluginAudioFrameObserver : public agora::media::IAudioFrameObserver
{
public:
    AgoraMediaDataPlugin *mediaDataPlugin;
 
    // 定义原始音频数据的格式
    AgoraAudioRawData* getAudioRawDataWithAudioFrame(AudioFrame& audioFrame)
    {
        AgoraAudioRawData *data = [[AgoraAudioRawData alloc] init];
        data.samples = audioFrame.samples;
        data.bytesPerSample = audioFrame.bytesPerSample;
        data.channels = audioFrame.channels;
        data.samplesPerSec = audioFrame.samplesPerSec;
        data.renderTimeMs = audioFrame.renderTimeMs;
        data.buffer = (char *)audioFrame.buffer;
        data.bufferSize = audioFrame.samples * audioFrame.bytesPerSample;
        return data;
    }
     
    // 定义处理原始音频数据的格式
    void modifiedAudioFrameWithNewAudioRawData(AudioFrame& audioFrame, AgoraAudioRawData *audioRawData)
    {
        audioFrame.samples = audioRawData.samples;
        audioFrame.bytesPerSample = audioRawData.bytesPerSample;
        audioFrame.channels = audioRawData.channels;
        audioFrame.samplesPerSec = audioRawData.samplesPerSec;
        audioFrame.renderTimeMs = audioRawData.renderTimeMs;
    }
     
    // 通过 onRecordAudioFrame 回调获取本地用户的原始音频数据
    virtual bool onRecordAudioFrame(AudioFrame& audioFrame) override
    {
         
        if (!mediaDataPlugin && ((mediaDataPlugin.observerAudioType >> 0) == 0)) return true;
        @autoreleasepool {
            if ([mediaDataPlugin.audioDelegate respondsToSelector:@selector(mediaDataPlugin:didRecordAudioRawData:)]) {
                AgoraAudioRawData *data = getAudioRawDataWithAudioFrame(audioFrame);
                AgoraAudioRawData *newData = [mediaDataPlugin.audioDelegate mediaDataPlugin:mediaDataPlugin didRecordAudioRawData:data];
                modifiedAudioFrameWithNewAudioRawData(audioFrame, newData);
            }
        }
 
        // 返回值设为 true，表示将音频数据发送回 SDK
        return true;
    }
     
    // 通过 onPlaybackAudioFrame 回调获取所有远端用户的原始音频数据
    virtual bool onPlaybackAudioFrame(AudioFrame& audioFrame) override
    {
         
        if (!mediaDataPlugin && ((mediaDataPlugin.observerAudioType >> 1) == 0)) return true;
        @autoreleasepool {
            if ([mediaDataPlugin.audioDelegate respondsToSelector:@selector(mediaDataPlugin:willPlaybackAudioRawData:)]) {
                AgoraAudioRawData *data = getAudioRawDataWithAudioFrame(audioFrame);
                AgoraAudioRawData *newData = [mediaDataPlugin.audioDelegate mediaDataPlugin:mediaDataPlugin willPlaybackAudioRawData:data];
                modifiedAudioFrameWithNewAudioRawData(audioFrame, newData);
            }
        }
        // 返回值设为 true，表示将音频数据发送回 SDK
        return true;
    }
 
    // 通过 onPlaybackAudioFrameBeforeMixing 回调获取特定远端用户的原始音频数据   
    virtual bool onPlaybackAudioFrameBeforeMixing(unsigned int uid, AudioFrame& audioFrame) override
    {
         
        if (!mediaDataPlugin && ((mediaDataPlugin.observerAudioType >> 2) == 0)) return true;
        @autoreleasepool {
            if ([mediaDataPlugin.audioDelegate respondsToSelector:@selector(mediaDataPlugin:willPlaybackBeforeMixingAudioRawData:ofUid:)]) {
                AgoraAudioRawData *data = getAudioRawDataWithAudioFrame(audioFrame);
                AgoraAudioRawData *newData = [mediaDataPlugin.audioDelegate mediaDataPlugin:mediaDataPlugin willPlaybackBeforeMixingAudioRawData:data ofUid:uid];
                modifiedAudioFrameWithNewAudioRawData(audioFrame, newData);
            }
        }
        // 返回值设为 true，表示将音频数据发送回 SDK
        return true;
    }
     
    // 通过 onMixedAudioFrame 回调获取本地和远端所有远端用户的原始音频数据
    virtual bool onMixedAudioFrame(AudioFrame& audioFrame) override
    {
         
        if (!mediaDataPlugin && ((mediaDataPlugin.observerAudioType >> 3) == 0)) return true;
        @autoreleasepool {
            if ([mediaDataPlugin.audioDelegate respondsToSelector:@selector(mediaDataPlugin:didMixedAudioRawData:)]) {
                AgoraAudioRawData *data = getAudioRawDataWithAudioFrame(audioFrame);
                AgoraAudioRawData *newData = [mediaDataPlugin.audioDelegate mediaDataPlugin:mediaDataPlugin didMixedAudioRawData:data];
                modifiedAudioFrameWithNewAudioRawData(audioFrame, newData);
            }
        }
        // 返回值设为 true，表示将音频数据发送回 SDK
        return true;
    }
};
```

**6. 取消注册音频帧观测器**

调用 `registerAudioFrameObserver(NULL)` 方法取消注册音频帧观测器。

<div class="alert note">该步骤代码需要在 .mm 文件中执行。</div>

```C++
- (void)deregisterAudioRawDataObserver:(ObserverAudioType)observerType {
    agora::rtc::IRtcEngine* rtc_engine = (agora::rtc::IRtcEngine*)self.agoraKit.getNativeHandle;
    agora::util::AutoPtr<agora::media::IMediaEngine> mediaEngine;
    mediaEngine.queryInterface(rtc_engine, agora::AGORA_IID_MEDIA_ENGINE);
 
    self.observerAudioType ^= observerType;
 
    if (mediaEngine && self.observerAudioType == 0)
    {
        mediaEngine->registerAudioFrameObserver(NULL);
        s_audioFrameObserver.mediaDataPlugin = nil;
    }
}
```


### API 参考

- [`registerAudioFrameObserver`](./API%20Reference/cpp/classagora_1_1media_1_1_i_media_engine.html#ae46ca0d20789787aaab2fb268a524100)
- [`setRecordingAudioFrameParameters`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#a2c4717760b5fbf1bb8c1a3c16ca67fe5)
- [`setPlaybackAudioFrameParameters`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#aa5f2f6eb3db5acaaf8c40818d90694f1)
- [`setMixedAudioFrameParameters`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#a520ebcda51b5eb488339f3a12dfb8013)
- [`onRecordAudioFrame`](./API%20Reference/cpp/classagora_1_1media_1_1_i_audio_frame_observer.html#ac6ab0c792420daf929fed78f9d39f728)
- [`onPlaybackAudioFrame`](./API%20Reference/cpp/classagora_1_1media_1_1_i_audio_frame_observer.html#aefc7f9cb0d1fcbc787775588bc849bac)
- [`onPlaybackAudioFrameBeforeMixing`](./API%20Reference/cpp/classagora_1_1media_1_1_i_audio_frame_observer.html#ae04d85a65eefec5e7c1e0477bcaa067c)
- [`onMixedAudioFrame`](./API%20Reference/cpp/classagora_1_1media_1_1_i_audio_frame_observer.html#a78d095cbd0b8ee04f657430bb6de8100)






## 开发注意事项

原始音频数据功能需要使用 C++ 的 API 实现。因此有如下注意项：

- 代码中涉及 Objective-C 和 C++ 混编的逻辑需要在 `.mm` 文件中实现。
- `.mm` 文件开头需要使用如下行引入 C++ 头文件。

```
#import <AgoraRtcKit/IAgoraMediaEngine.h>
#import <AgoraRtcKit/IAgoraRtcEngine.h>
```

- 在调用 `registerAudioFrameObserver` 注册语音观测器前，需要先调用 `getNativeHandler` 获取 C++ 的回调句柄。

```
agora::rtc::IRtcEngine* rtc_engine = (agora::rtc::IRtcEngine*)self.agoraKit.getNativeHandle;
```

在 iOS 或 macOS 上调用 C++ 方法的完整代码可以参考 [AgoraMediaDataPlugin.mm](https://github.com/AgoraIO/API-Examples/blob/master/iOS/APIExample/Common/RawDataApi/AgoraMediaDataPlugin.mm)。


