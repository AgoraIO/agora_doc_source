---
title: 音视频设备测试
platform: Windows
updatedAt: 2020-03-06 16:02:18
---

## 功能描述

为保证通话或直播质量，我们推荐在进入频道前进行音视频设备测试，检测麦克风、摄像头等音视频设备能否正常工作。该功能对于有高质量要求的场景，如在线教育等，尤为适用。

## 实现方法

请确保你已经了解如何[实现音视频通话](start_call_windows)或[互动直播](start_live_windows)。

参考以下步骤测试音视频设备：

- 选择以下一种方式测试音频设备：
  - 调用 `startRecordingDeviceTest` 测试录音设备，调用 `startPlaybackDeviceTest` 测试音频播放设备。
  - 调用 `startAudioDeviceLoopbackTest` 测试音频设备回路（包括录音设备和音频播放设备）。
- 调用 `startDeviceTest` 方法测试视频采集设备。

<div class="alert note">所有测试设备的方法都必须在加入频道之前调用。</div>

### 音频录制设备测试

- 用途：测试本地音频录制设备，如麦克风，是否正常工作。
- 测试方法及原理：调用 `startRecordingDeviceTest`；用户说话，如果录制设备正常工作，SDK 会触发 `onAudioVolumeIndication` 回调并报告音量信息。UID 为 0 表示本地音量。完成测试后，需调用 `stopRecordingDeviceTest` 停止录制设备测试。

```C++
// 选择一个音频采集设备
lpDeviceManager->setRecordingDevice(strDeviceID);

// 实现音频音量回调接口
virtual void onAudioVolumeIndication(const AudioVolumeInfo* speakers, unsigned int speakerNumber, int totalVolume) {
        (void)speakers;
        (void)speakerNumber;
        (void)totalVolume;
    }

// 开始音频采集设备测试
(*lpDeviceManager)->startRecordingDeviceTest(1000);

// 停止音频采集设备测试
(*lpDeviceManager)->stopRecordingDeviceTest();
```

### 音频播放设备测试

- 用途：测试本地音频播放设备，如外放设备，是否正常工作。
- 测试方法及原理：调用 `startPlaybackDeviceTest`，并指定播放的音频文件。如果能听到声音，则说明播放设备正常工作。完成测试后，需调用 `stopPlaybackDeviceTest` 停止播放设备测试。

```C++
// 选择一个音频播放设备
lpDeviceManager->setPlaybackDevice(strDeviceID);

// 指定音频文件的绝对路径，启动播放设备测试。
(*lpDeviceManager)->startPlaybackDeviceTest(filePath);

// 停止音频播放设备测试。
(*lpDeviceManager)->stopPlaybackDeviceTest();
```

### 音频设备回路测试

- 用途：测试本地音频设备回路是否正常工作。
- 测试方法和原理：调用 `startAudioDeviceLoopbackTest`；用户说话，麦克风会采集本地讲话声音，然后用扬声器播放，同时 SDK 会在 `onAudioVolumeIndication` 回调中报告音量信息。UID 为 0 表示本地音量。完成测试后，需调用 `stopAudioDeviceLoopbackTest` 停止录制设备测试。

### 视频设备测试

- 用途：测试本地视频设备，如摄像头和显示器，是否正常功能。
- 测试方法及原理：调用 `enableVideo` 开启视频模块后，调用 `startDeviceTest`，并指定显示图像的窗口句柄，如果能看到本地采集的图像，则说明视频设备正常工作。完成测试后，需调用 `stopDeviceTest` 停止视频设备测试。

```C++
// 选择一个视频采集设备
lpDeviceManager->setDevice(strDeviceID);

// 开始视频采集设备测试，如果正常的话，你将会看到画面预览
(*lpDeviceManager)->startDeviceTest(view);

// 停止视频采集设备测试
(*lpDeviceManager)->stopDeviceTest();
```

### API 参考

- [`enableAudioVolumeIndication`](./API%20Reference/cpp/classagora_1_1rtc_1_1_rtc_engine_parameters.html#a59ae67333fbc61a7002a46c809e2ec4f)
- [`enumerateRecordingDevices`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_audio_device_manager.html#a1ea4f53d60dc91ea83960885f9ab77ee)
- [`setRecordingDevice`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_audio_device_manager.html#a723941355030636cd7d183d53cc7ace7)
- [`enumeratePlaybackDevices`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_audio_device_manager.html#aa13c99d575d89e7ceeeb139be723b18a)
- [`setPlaybackDevice`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_audio_device_manager.html#a1ee23eae83165a27bcbd88d80158b4f1)
- [`startRecordingDeviceTest`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_audio_device_manager.html#a9e732d31f179a90d388998f5b86ebf06)
- [`stopRecordingDeviceTest`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_audio_device_manager.html#a796e7b8a58eb303f18f04e1e9d12a94b)
- [`startAudioDeviceLoopbackTest`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_audio_device_manager.html#ac78c08f3212dc3efa000e197207dec53)
- [`stopAudioDeviceLoopbackTest`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_audio_device_manager.html#aad01da1e0bacd3f2fd355483f9e3befb)
- [`enumerateVideoDevices`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_video_device_manager.html#aef51744162ec544abf2aaf0488ca062d)
- [`startDeviceTest`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_video_device_manager.html#ac148cafcb191841fd4aa7f5b6166b16d)
- [`stopDeviceTest`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_video_device_manager.html#ae3fe9f7ad1ddf4d5cda5e30d14b9d321)

## 注意事项

- 请确保进行测试时，相应的音视频设备没有被其他应用程序占用。
- 测试结束后，请务必调用相应的 stop 方法停止测试，然后再调用 `joinChannel` 加入频道。
