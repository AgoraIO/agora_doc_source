---
title: 自定义音频采集和渲染
platform: iOS
updatedAt: 2021-01-21 03:45:10
---
## 功能介绍

实时音频传输过程中，Agora SDK 通常会启动默认的音频模块进行采集和渲染。在以下场景中，你可能会发现默认的音频模块无法满足开发需求：

- app 中已有自己的音频模块。
- 需要使用自定义的采集或播放处理。
- 某些音频采集设备被系统独占。

Agora SDK 支持使用自定义的音频源或渲染器，实现相关场景。本文介绍如何实现自定义音频采集和渲染。

## 示例项目

Agora 在 GitHub 提供了一个开源的 [API-Examples](https://github.com/AgoraIO/API-Examples/tree/master/iOS) 示例项目，其中包含实现自定义音频采集和渲染功能的示例。

下表列出示例项目中主要的代码文件：

| 文件 | 描述 |
| ---------------- | ---------------- |
| [CustomAudioSource.swift](https://github.com/AgoraIO/API-Examples/blob/master/iOS/APIExample/Examples/Advanced/CustomAudioSource/CustomAudioSource.swift)      | 自定义音频采集功能的示例，相关的主要方法如下：<ul><li>`setExternalAudioWithAgoraKit`: 设置自定义音频。</li><li>`enableExternalAudioSourceWithSampleRate`: 开启自定义音频采集。</li><li>`joinChannelWithToken`: 加入频道。</li><li>`willMove`: 停止自定义音频采集并离开频道。</li></ul>      |
| [CustomAudioRender.swift](https://github.com/AgoraIO/API-Examples/blob/master/iOS/APIExample/Examples/Advanced/CustomAudioRender/CustomAudioRender.swift) | 自定义音频渲染功能的示例，相关的主要方法如下：<ul><li>`setupExternalAudioWithAgoraKit`: 设置自定义音频。</li><li>`setParameters`: 关闭 SDK 的音频渲染。</li><li>`joinChannelWithToken`: 加入频道。</li><li>`willMove`: 停止自定义音频渲染并离开频道。</li></ul>  |
| [AudioController.h](https://github.com/AgoraIO/API-Examples/blob/master/iOS/APIExample/Common/ExternalAudio/AudioController.h)  | 定义 `AudioControllerDelegate` 类。实现这个类后，app 会在接收到采集或者待渲染的音频数据时，触发相关回调。|
| [AudioController.m](https://github.com/AgoraIO/API-Examples/blob/master/iOS/APIExample/Common/ExternalAudio/AudioController.m) | 实现了 AudioController.h 文件中的类和方法。 |
| [ExternalAudio.mm](https://github.com/AgoraIO/API-Examples/blob/master/iOS/APIExample/Common/ExternalAudio/ExternalAudio.mm)  | 包含设置自定义音频采集和渲染的具体实现，并在接收到采集的音频数据后，将音频数据推送给 SDK：<ul><li>`setupExternalAudioWithAgoraKit`: 设置自定义音频。该方法用于设置自定义音频的采样率、声道数、音频的采集渲染模式（自定义或者 SDK）。</li><li>`didCaptureData`: 接收到采集的音频数据。在该回调中调用 `pushExternalAudioFrameRawData` 将音频数据推送给 SDK。</li><li>`didRenderData`: 接收到待渲染的音频数据。在该回调中调用 `readAudioData` 进行渲染。</li></ul> |


## 自定义音频采集

### 实现步骤

参考如下步骤，在你的项目中实现自定义音频采集功能：

1. 加入频道前，调用 `enableExternalAudioSourceWithSampleRate` 方法指定使用自定义音频采集。
2. 启用自定义音频采集后，你需要根据场景需要，自行实现音频数据的采集或处理。
3. 完成音频数据采集或处理后，根据音频数据的格式，再通过 `pushExternalAudioFrameRawData` 或 `pushExternalAudioFrameSampleBuffer` 将数据推送给 SDK 进行播放及后续操作。

API 的调用时序如下图所示：

![](https://web-cdn.agora.io/docs-files/1605768286358)

### 示例代码

#### 1. 开启自定义音频采集

首先调用 SDK 的 `enableExternalAudioSourceWithSampleRate` 方法，告知 SDK 使用自采集的音频数据。

```swift
/**
 * 开启外部音频数据采集。
 * @param sampleRate 音频数据的采样率
 * @param channel 音频数据的采样声道数
 */
agoraKit.enableExternalAudioSource(withSampleRate: sampleRate, channelsPerFrame: channel)
```

开启自定义采集时，你需要自行定义音频采集的方法，并指定采集音频的采样率和声道数。在示例项目中，我们定义了一个 setUpAudioSessionWithSampleRate 方法，并通过调用 iOS 的原生方法实现采集。

```swift
/** 开启音频采集。
 * @param sampleRate 音频采样率
 * @param channels 采样声道数
 * @param audioCRMode 音频采样模式。SDK 根据该参数的设置选择使用 Agora 的 API 还是系统的 API 获取采集到的音频数据
 * @param ioType iOS 设备的音频播放通道设置
 */
[self.audioController setUpAudioSessionWithSampleRate:sampleRate channelCount:channels audioCRMode:audioCRMode IOType:ioType];
```

#### 2. 加入频道并开始采集

调用 SDK 的 `joinChannelByToken` 方法加入频道，并在成功加入频道后，告知系统开始采集音频数据。在示例项目中，我们定义了一个 `startWork` 方法来开启自定义的音频采集。

```swift
// 调用 SDK 的 joinChannelByToken 方法加入频道
let result = agoraKit.joinChannel(byToken: nil, channelId: channelName, info: nil, uid: 0) {[unowned self] (channel, uid, elapsed) -> Void in
        self.isJoined = true
        LogUtils.log(message: "Join \(channel) with uid \(uid) elapsed \(elapsed)ms", level: .info)
         
        // 调用 startWork 方法开启音频采集
        self.exAudio.startWork()
        try? AVAudioSession.sharedInstance().setPreferredSampleRate(Double(sampleRate))
             
    }
    if result != 0 {
        // 常见的报错原因是填入的参数无效
        self.showAlert(title: "Error", message: "joinChannel call failed: \(result), please check your params")
    }
```

#### 3. 将采集到的音频数据推送给 SDK

当系统采集到音频数据后，再调用 SDK 的 `pushExternalAudioFrameRawData` 方法，将采集到的数据推送给 SDK。SDK 接收到数据后，会自动进行播放。

首先你需要一个方法来接收采集到的音频数据。在示例项目中，我们定义了一个 `AudioController` 类，其中就包括一个 `didCaptureData` 回调，在接收到采集的音频数据时触发。

```swift
// 已接收到自定义采集的音频数据。你可以在该回调中获取采集的数据及数据字节大小
- (void)audioController:(AudioController *)controller didCaptureData:(unsigned char *)data bytesLength:(int)bytesLength {
    // 当前采集模式为使用自定义采集 + SDK 渲染
    if (self.audioCRMode != AudioCRModeExterCaptureSDKRender) {
        // 调用 SDK 的 pushExternalAudioFrameRawData 方法推送采集到的数据给 SDK
        [self.agoraKit pushExternalAudioFrameRawData:data samples:bytesLength / 2 timestamp:0];
    } 
}
```

#### 4. 停止采集

用户离开频道时，停止采集音频数据。

```swift
// 用户离开频道时，停止采集音频数据
if isJoined {
    exAudio.stopWork()
    // 调用 SDK 的 leaveChannel 方法离开频道
    agoraKit.leaveChannel { (stats) -> Void in
            LogUtils.log(message: "left channel, duration: \(stats.duration)", level: .info)
        }
    }
```

### API 参考

- [`enableExternalAudioSourceWithSampleRate`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/enableExternalAudioSourceWithSampleRate:channelsPerFrame:)
- [`disableExternalAudioSource`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/disableExternalAudioSource)
- [`pushExternalAudioFrameRawData`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/pushExternalAudioFrameRawData:samples:timestamp:)
- [`pushExternalAudioFrameSampleBuffer`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/pushExternalAudioFrameSampleBuffer:)

## 自定义音频渲染

### 实现步骤

Agora SDK 提供如下两种自定义音频渲染的方式，你可以选择其一实现：

**方式一**

1. 加入频道前，调用 `registerAudioFrameObserver` 方法注册音频帧观测器，并在该方法中实现一个 `IAudioFrameObserver` 类。成功注册后，你可以通过 `onPlaybackAudioFrame` 回调获取远端流的原始音频数据。
2. 调用 `setParameters("{\"che.audio.external_render\": false}")` 关闭 SDK 的音频渲染。
3. 在 `onPlaybackAudioFrame` 回调中自行渲染音频数据。

<div class="alert note">如果你使用该种方式，由于 Agora 仅提供 C++ 语言的音频原始数据接口，实现上述步骤需要在 iOS 或 macOS 上调用 C++ 语言的 API，因此在相关实现中，请注意如下项：
<ul>
	<li>代码中涉及 Objective-C 与 C++ 混编的逻辑需要在 .mm 文件中实现。</li>
	<li>.mm 文件的开头需要引入 C++ 头文件。</li>
	<li>在调用 C++ 方法前，你需要先调用 <code>getNativeHandle</code> 获取 C++ 的 IRtcEngine 对象。</li></ul></div>
	
API 调用时序如下图所示：
	
![](https://web-cdn.agora.io/docs-files/1605771813294)
	
**方式二**
	
1. 加入频道前，调用 `enableExternalAudioSink` 开启并设置外部音频渲染。
2. 成功加入频道后，根据音频数据格式，调用 `pullPlaybackAudioFrameRawData` 或 `pullPlaybackAudioFrameSampleBufferByLengthInByte` 方法拉取远端发送的音频数据。
3. 自行渲染并播放拉取到的音频数据。

API 调用时序如下图所示：

![](https://web-cdn.agora.io/docs-files/1605771974413)

### 示例代码

#### 1. 设置自定义音频

定义一个 `setupExternalAudioWithAgoraKit` 方法：首先设置自定义音频的采样率、声道数、采集和渲染模式及播放通道，然后调用 SDK 的 `registerAudioFrameObserver` 方法注册音频帧观测器。

```swift
// 定义一个 setupExternalAudioWithAgoraKit 方法来设置自定义音频。
- (void)setupExternalAudioWithAgoraKit:(AgoraRtcEngineKit *)agoraKit sampleRate:(uint)sampleRate channels:(uint)channels audioCRMode:(AudioCRMode)audioCRMode IOType:(IOUnitType)ioType {
   
  // 实现一个 AudioController 类。在合适的时候触发回调
  self.audioController = [AudioController audioController];
  self.audioController.delegate = self;
   
    // 调用 C++ 的方法，注册音频帧观测器
    agora::rtc::IRtcEngine* rtc_engine = (agora::rtc::IRtcEngine*)agoraKit.getNativeHandle;
    agora::util::AutoPtr<agora::media::IMediaEngine> mediaEngine;
    mediaEngine.queryInterface(rtc_engine, agora::AGORA_IID_MEDIA_ENGINE); 
 
    if (mediaEngine) {
        s_audioFrameObserver = new ExternalAudioFrameObserver();
        s_audioFrameObserver -> sampleRate = sampleRate;
        s_audioFrameObserver -> sampleRate_play = channels;
        mediaEngine->registerAudioFrameObserver(s_audioFrameObserver);
    }   
}
```

调用 `setupExternalAudioWithAudioKit` 对自定义音频进行设置，使用 SDK 采集自渲染模式。

```swift
exAudio.setupExternalAudio(withAgoraKit: agoraKit, sampleRate: UInt32(sampleRate), channels: UInt32(channel), audioCRMode: .sdkCaptureExterRender, ioType: .remoteIO)
```

#### 2. 关闭 SDK 的音频渲染

```swift
agoraKit.setParameters("{\"che.audio.external_render\": false}")
```

#### 3. 从 SDK 获取音频数据进行渲染

成功注册音频帧观测器后，SDK 会通过 onPlaybackAudioFrame 回调提供远端用户的原始音频数据。在该回调中渲染原始音频数据。

```swift
virtual bool onPlaybackAudioFrame(AudioFrame& audioFrame) override
{
// 实现渲染原始音频数据
}
```

#### 4. 加入频道并开始渲染

调用 SDK 的 `joinChannelByToken` 方法加入频道，并在成功加入频道后，告知系统开始渲染音频数据。

<div class="alert info">示例项目在 <a href="https://github.com/AgoraIO/API-Examples/blob/master/iOS/APIExample/Common/ExternalAudio/ExternalAudio.mm">ExternalAudio.mm</a> 文件中定义了 startWork 方法用来开启音频渲染。</div>

```swift
// 调用 SDK 的 joinChannelByToken 方法加入频道
let result = agoraKit.joinChannel(byToken: nil, channelId: channelName, info: nil, uid: 0) {[unowned self] (channel, uid, elapsed) -> Void in
        self.isJoined = true
        LogUtils.log(message: "Join \(channel) with uid \(uid) elapsed \(elapsed)ms", level: .info)
         
        // 调用 startWork 方法开启音频渲染
        self.exAudio.startWork()
             
    }
    if result != 0 {
        // 常见的报错原因是填入的参数无效
        self.showAlert(title: "Error", message: "joinChannel call failed: \(result), please check your params")
    }
```

#### 5. 停止渲染

在 [ExternalAudio.mm](https://github.com/AgoraIO/API-Examples/blob/master/iOS/APIExample/Common/ExternalAudio/ExternalAudio.mm) 文件中定义了 `stopWork` 和 `cancelRegister` 方法。

```swift
- (void)stopWork {
    [self.audioController stopWork];
    [self cancelRegister];
}
 
- (void)cancelRegister {
    agora::rtc::IRtcEngine* rtc_engine = (agora::rtc::IRtcEngine*)self.agoraKit.getNativeHandle;
    agora::util::AutoPtr<agora::media::IMediaEngine> mediaEngine;
    mediaEngine.queryInterface(rtc_engine, agora::AGORA_IID_MEDIA_ENGINE);
    // 取消注册音频帧观测器
    mediaEngine->registerAudioFrameObserver(NULL);
}
```

用户离开频道时，停止渲染音频数据。

```swift
// 用户离开频道时，停止渲染音频数据
if isJoined {
    exAudio.stopWork()
    // 调用 SDK 的 leaveChannel 方法离开频道
    agoraKit.leaveChannel { (stats) -> Void in
            LogUtils.log(message: "left channel, duration: \(stats.duration)", level: .info)
        }
    }
```

### API 参考

- [`enableExternalAudioSink`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/enableExternalAudioSink:channels:)
- [`disableExternalAudioSink`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/disableExternalAudioSink)
- [`pullPlaybackAudioFrameRawData`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/pullPlaybackAudioFrameRawData:lengthInByte:)
- [`pullPlaybackAudioFrameSampleBufferByLengthInByte`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/pullPlaybackAudioFrameSampleBufferByLengthInByte:)
- [`getNativeHandle`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/getNativeHandle)
- [`registerAudioFrameObserver`](./API%20Reference/cpp/classagora_1_1media_1_1_i_media_engine.html#ae46ca0d20789787aaab2fb268a524100)
- [`onPlaybackAudioFrame`](./API%20Reference/cpp/classagora_1_1media_1_1_i_audio_frame_observer.html#aefc7f9cb0d1fcbc787775588bc849bac)


## 开发注意事项

- 自定义音频采集和渲染场景中，需要开发者具有采集或渲染音频数据的能力：

	- 自定义音频采集场景中，你需要自行管理音频数据的采集和处理。
	- 自定义音频渲染场景中，你需要自行管理音频数据的处理和播放。

- 如果使用 `onPlaybackAudioFrame` 回调来获取原始音频数据进行渲染，必须要调用 `setParameters` 方法关闭 SDK 的音频渲染。
