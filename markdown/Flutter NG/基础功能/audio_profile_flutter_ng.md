# 设置音频编码属性和应用场景

不同的 app 需要设置不同的音频编码属性或应用场景。本文介绍如何使用 Agora RTC SDK 在你的 app 中设置合适的音频编码属性和应用场景。


## 技术原理

SDK 默认使用 `audioProfileDefault` 编码属性和 `audioScenarioDefault` 应用场景。如果默认设置无法满足你的需求，调用如下 API 设置音频编码属性和应用场景。

| API     | 描述   |
| :--------- | :------------------- |
| `initialize(context.audioScenario)` | 在创建 `RtcEngine` 实例时，设置音频应用场景。默认值为 `audioScenarioDefault`。 |
| `setAudioProfile(profile, scenario)`   | 在加入频道前后均可设置音频编码属性和应用场景。  |
| `setAudioScenario(scenario)`   | 在加入频道前后均可设置音频应用场景。  |


## 前提条件

在实现设置音频编码属性和应用场景前，请确保已在你的项目中实现基本的实时音视频功能。详见[开始视频通话](./start_call_flutter_ng)或[开始互动直播](./start_live_flutter_ng)。


## 实现方法

本节介绍如何为常见应用设置音频编码属性和应用场景。你可以将如下示例代码添加至你的项目中。

### 1 对 1 互动教学

1 对 1 互动教学主要要求保证通话质量、传输流畅。在你的项目中添加如下代码：

```dart
// 在初始化 IRtcEngine 实例时，设置音频应用场景
RtcEngineContext context;
context.audioScenario = AudioScenarioType.audioScenarioDefault;
await rtcEngine.initialize(context);

// 设置音频编码属性
await rtcEngine.setAudioProfile(AudioProfileType.audioProfileDefault);
```

### KTV

KTV 主要要求高音质、对音乐和歌声的表现力好。在你的项目中添加如下代码：

```dart
// 在初始化 IRtcEngine 实例时，设置音频应用场景
RtcEngineContext context;
context.audioScenario = AudioScenarioType.audioScenarioGameStreaming;
await rtcEngine.initialize(context);

// 设置音频编码属性
await rtcEngine.setAudioProfile(AudioProfileType.audioScenarioGameStreaming);
```

### 语音电台

语音电台一般会使用专业的音频设备，主要要求高音质和立体声。在你的项目中添加如下代码：

```dart
// 在初始化 IRtcEngine 实例时，设置音频应用场景
RtcEngineContext context;
context.audioScenario = AudioProfileType.audioScenarioChorus;
await rtcEngine.initialize(context);

// 设置音频编码属性
await rtcEngine.setAudioProfile(AudioProfileType.audioScenarioChorus);
```

### 音乐教学

该场景主要要求高音质，支持将扬声器播放的音效传输到远端。Agora 推荐如下设置：

```dart
// 在初始化 IRtcEngine 实例时，设置音频应用场景
RtcEngineContext context;
context.audioScenario = AudioProfileType.audioScenarioMeeting;
await rtcEngine.initialize(context);

// 设置音频编码属性
await rtcEngine.setAudioProfile(AudioProfileType.audioScenarioMeeting);
```


## 相关文档

本节提供在实现设置音频编码属性和应用场景时可能需要的文档。

### API 参考

- [`initialize`](./API%20Reference/flutter_ng/API/toc_core_method.html#api_irtcengine_initialize)
- [`setAudioProfile`](./API%20Reference/flutter_ng/API/toc_audio_process.html#api_irtcengine_setaudioprofile)
- [`setAudioScenario`](./API%20Reference/flutter_ng/API/toc_audio_process.html#api_irtcengine_setaudioscenario)