---
title: 客户端录制
platform: iOS
updatedAt: 2019-09-29 16:19:57
---
## 功能描述

在通话的过程中，将通话各方的声音录制下来，存放在本地，相当于手机上面的通话录音功能，录制下来的声音可用于回放。

Agora SDK 支持通话过程中在客户端进行录音。该方法录制频道内所有用户的音频，并生成一个包含所有用户声音的录音文件，录音文件格式可以为：

- WAV：文件大，音质保真度高
- AAC：文件小，有一定的音质损失

## 实现方法

开始前请确保已在你的项目中实现基本的实时音视频功能。详见快速开始文档：
- iOS: [实现音视频通话](start_call_ios)/[实现互动直播](start_live_ios)
- macOS: [实现音视频通话](start_call_mac)/[实现互动直播](start_live_mac)

加入频道后调用 `startAudioRecording` 即可开始录音。

```swift
// Swift
// 开始录音
// 录音文件的本地保存路径，由用户自行指定，需精确到文件名及格式
// 录音音质，分LOW, MEDIUM, HIGH
agoraKit.startAudioRecording("recording file path", quality: .high)

// 结束录音
agoraKit.stopAudioRecording()
```

```oc
// Objective-C
// 开始录音（Objective-C）
// 录音文件的本地保存路径，由用户自行指定，需精确到文件名及格式
// 录音音质，分LOW, MEDIUM, HIGH
[agoraKit startAudioRecording:@"recording file path", quality: AgoraAudioRecordingQualityHigh];

// 结束录音
[agoraKit stopAudioRecording];
```

### API 参考

- [`startAudioRecording`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/startAudioRecording:quality:)
- [`stopAudioRecording`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/stopAudioRecording)

## 开发注意事项

- 开启录音须在进入频道之后调用
- 离开频道会自动停止录音