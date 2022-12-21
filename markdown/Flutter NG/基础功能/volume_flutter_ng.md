# 调整通话音量

本文介绍如何设置音频采集和播放、音乐文件播放的音量。


## 技术原理

Agora RTC SDK 支持对 SDK 采集和播放的音频音量进行调整，以满足用户实际应用场景。例如，进行双人通话时，需要静音远端用户，可以通过调整播放音量的方法将音量设置为 0。

<div class="alert note">如果使用调整信号音量的方法将音量设置过大，在某些设备上可能会出现音频失真。</div>

下图展示了调整音量的工作流程。

![](https://web-cdn.agora.io/docs-files/1634715319820)

### 播放

**播放**是指音频信号从发送端进入到接收端，然后使用播放设备进行播放的过程。

![](https://web-cdn.agora.io/docs-files/1577959124720)

### 采集

**采集**是指音频信号由采集设备采集，然后传输到发送端的过程。

![](https://web-cdn.agora.io/docs-files/1577958939565)


## 前提条件

在实现调整通话音量前，请确保已在你的项目中实现基本的实时音视频功能。详见[开始视频通话](./start_call_flutter_ng)或[开始互动直播](./start_live_flutter_ng)。


## 实现方法

### 调整播放音量

调用 `adjustPlaybackSignalVolume` 或 `adjustUserPlaybackSignalVolume` 调整音频播放信号的音量。

```dart
  // 设置本地播放的所有远端用户音量为 50
  int vol = 50;
  await rtcEngine->adjustPlaybackSignalVolume(vol);
  // 设置本地播放的指定远端用户的音量为 50
  int vol = 50;
  await _rtcEngine->adjustUserPlaybackSignalVolume(vol);
```

### 获取用户音量（回调）

在音频采集、混音、播放的整个过程中，你都可以通过 `onAudioVolumeIndication` 回调获取频道内瞬时音量最高的三个用户（即说话者）的用户 ID 及他们的音量。返回的 `uid` 为 0 表示本地用户。

<div class="alert note">你需要开启 <code>enableAudioVolumeIndication</code> 方法才能收到该回调。</div>

```dart
// 获取瞬时说话音量最高的三个用户（即说话者）的用户 ID、他们的音量及本地用户是否在说话
rtcEngine.registerEventHandler(RtcEngineEventHandler(
onAudioVolumeIndication: (RtcConnection connection,
    List<AudioVolumeInfo> speakers, int speakerNumber, int totalVolume) {
  logSink.log(
    '[onAudioVolumeIndication] speakers: ${speakers.toString()}, speakerNumber: $speakerNumber, totalVolume: $totalVolume');
  }
));
```

### 调整采集音量

调用 `adjustRecordingSignalVolume` 调整音频采集信号的音量。

```dart
// 调整采集信号音量为 50
int vol = 50;
await _rtcEngine->adjustRecordingSignalVolume(vol);
```


## 相关文档

本节提供在实现调整通话音量时可能需要的文档。

### 示例项目

我们在 GitHub 上提供已实现调整采集、播放、耳返音量的开源示例项目 [join_channel_audio.dart](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/blob/main/example/lib/examples/basic/join_channel_audio/join_channel_audio.dart)。你可以下载体验并参考源代码。

实现调整通话音量过程中，你还可以参考如下文档：

- 如需调整混音或音效文件的播放音量，可以参考 [audio_mixing.dart](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/blob/main/example/lib/examples/advanced/audio_mixing/audio_mixing.dart)。
- [如何处理音量太小问题？](https://docs.agora.io/cn/faq/audio_low)

### API 参考

- [`adjustRecordingSignalVolume`](./API%20Reference/flutter_ng/API/toc_audio_process.html?platform=Flutter#api_irtcengine_adjustrecordingsignalvolume)
- [`adjustPlaybackSignalVolume`](./API%20Reference/flutter_ng/API/toc_audio_process.html?platform=Flutter#api_irtcengine_adjustplaybacksignalvolume)
- [`adjustUserPlaybackSignalVolume`](./API%20Reference/flutter_ng/API/toc_audio_process.html?platform=Flutter#api_irtcengine_adjustuserplaybacksignalvolume)
- [`adjustAudioMixingPlayoutVolume`](./API%20Reference/flutter_ng/API/toc_audio_process.html?platform=Flutter#api_irtcengine_adjustaudiomixingplayoutvolume)
- [`onAudioVolumeIndication`](./API%20Reference/flutter_ng/API/toc_audio_process.html?platform=Flutter#callback_irtcengineeventhandler_onaudiovolumeindication)