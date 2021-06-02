---
title: 客户端录制
platform: Windows
updatedAt: 2020-03-03 16:35:20
---
## 功能描述

在通话的过程中，将通话各方的声音录制下来，存放在本地，相当于手机上面的通话录音功能，录制下来的声音可用于回放。

Agora SDK 支持通话过程中在客户端进行录音。该方法录制频道内所有用户的音频，并生成一个包含所有用户声音的录音文件，录音文件格式可以为：

- WAV：文件大，音质保真度高
- AAC：文件小，有一定的音质损失

## 实现方法

开始前请确保已在你的项目中实现基本的实时音视频功能。 详见[开始音视频通话](start_call_windows)或[开始互动直播](start_live_windows)。

```C++
// 开始本地音频文件录制
#ifdef UNICODE
 CHAR aFilePath[MAX_PATH];
 ::WideCharToMultiByte(CP_UTF8, 0, filePath, -1, aFilePath, MAX_PATH, NULL, NULL);
int nRet = rtcEngine.startAudioRecording(aFilePath, // 本地合法文件路径
	AUDIO_RECORDING_QUALITY_TYPE::AUDIO_RECORDING_QUALITY_HIGH // 录音音质 AUDIO_RECORDING_QUALITY_HIGH|MEDIUM|LOW
	);
#else
int nRet = rtcEngine.startAudioRecording(filePath, AUDIO_RECORDING_QUALITY_TYPE::AUDIO_RECORDING_QUALITY_HIGH);
#endif

// 结束音频文件录制
int nRet = rtcEngine.stopAudioRecording();
```

### API 参考

* [`startAudioRecording`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#a3c05d82c97a9d63ebda116b9a1e5ca3f)
* [`stopAudioRecording`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#adb392026425663e5b9f90fe90130e5a5)

## 开发注意事项

- 开启录音须在进入频道之后调用
- 离开频道会自动停止录音
