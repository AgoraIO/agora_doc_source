---
title: 通话前网络和设备检测
platform: Windows
updatedAt: 2021-03-04 09:10:14
---
## 功能描述

在对质量要求高的场景下，进行通话前检测可以帮助提前识别并排查问题，保证实时通信体验。通话前检测通常可以从如下两个角度开展：

- 网络质量探测：通过探测当前的上下行 last mile 网络质量，判断或预测用户当前的网络状况是否良好。
- 设备质量检测：检测本地音频采集设备和播放设备是否能正常工作。

Agora SDK 提供了完备的网络探测及设备检测接口，帮助你实现如上功能，保证用户的使用体验。本文介绍如何使用相关 API 实现上述功能。

## 示例项目

Agora 在 GitHub 上提供已实现[通话前检测](https://github.com/AgoraIO/API-Examples/tree/master/windows/APIExample/APIExample/Advanced/PerCallTest)功能的开源示例项目。你可以下载体验或查看其中的源代码。

## 网络质量探测

从 v2.4.0 起，Agora RTC Native SDK 提供了一个 `startLastmileProbeTest` 方法，支持用户在加入频道前进行网络质量探测，然后通过回调将当前网络质量的相关数据，包括往返时延、上下行丢包率、上下行网络带宽等返回给 app。

### 实现方法

开始检测网络质量前，请确保你已在项目中实现了基本的音视频通信或直播功能。详见[开始音视频通话](start_call_windows)或[开始互动直播](start_live_windows)。

参考如下步骤了解相关 API 的工作原理。

1. 在用户加入频道或上麦前，调用 `startLastmileProbeTest` 进行网络质量探测，向用户反馈上下行网络的带宽、丢包、网络抖动和往返时延。
2. 启用该方法后，SDK 会依次返回如下 2 个回调：
- `onLastmileQuality`：约 2 秒内返回。该回调通过打分反馈上下行网络质量，更贴近主观感受
- `onLastmileProbeResult`：约 30 秒内返回。该回调通过客观数据反馈上下行网络质量，更客观
3. 获取到网络质量数据后，调用 `stopLastmileProbeTest` 停止通话前网络质量探测。

各 API 的调用时序如下图所示： 

![](https://web-cdn.agora.io/docs-files/1569465803488)

### 示例代码

你可以参考如下示例代码实现网络质量探测功能。

```cpp
// 注册回调接口
// 开始 Last-mile 网络探测后，约 2 秒后发生该回调
void onLastmileQuality(int quality) {
}

// 开始 Last-mile 网络探测后，约 30 秒后发生该回调
void onLastmileProbeResult(LastmileProbeResult) {
  // (1)可以选择在回调内部结束测试。在测试结束前，Agora 建议不要调用其他 API 方法
  lpAgoraEngine->stopLastmileProbeTest();
}

// 配置一个 LastmileProbeConfig 实例
LastmileProbeConfig config;
// 确认探测上行网络质量
config.probeUplink = true;
// 确认探测下行网络质量
config.probeDownlink = true;
// 期望的最高发送码率，单位为 bps，范围为 [100000,5000000]
config.expectedUplinkBitrate = 100000;
// 期望的最高接收码率，单位为 bps，范围为 [100000,5000000]
config.expectedDownlinkBitrate = 100000;
// 加入频道前开始 Last-mile 网络探测
lpAgoraEngine->startLastmileProbeTest(config);

// (2)也可以选择在其他时候结束测试。在测试结束前，Agora 建议不要调用其他 API 方法
lpAgoraEngine->stopLastmileProbeTest();
```


### API 参考
* [`startLastmileProbeTest`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#adb3ab7a20afca02f5a5ab6fafe026f2b)
* [`stopLastmileProbeTest`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#a94f3494035429684a750e1dee7ef1593)
* [`onLastmileQuality`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine_event_handler.html#ac7e14d1a26eb35ef236a0662d28d2b33)
* [`onLastmileProbeResult`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a44134dfda5d412831fa8e44fa533fca5)


## 设备质量检测

为保证通话或直播质量，我们推荐在进入频道前进行音视频设备测试，检测麦克风、摄像头等音视频设备能否正常工作。该功能对于有高质量要求的场景，如在线教育等，尤为适用。

## 实现方法

开始前请确保已在项目中实现了基本的音视频通话或直播功能。详见[实现音视频通话](start_call_windows)或[互动直播](start_live_windows)。

参考以下步骤测试音视频设备：

- 选择以下一种方式测试音频设备：
	- 调用 `startEchoTest` 测试系统的音频设备（耳麦、扬声器等）和网络连接。
	- 调用 `startRecordingDeviceTest` 测试录音设备，调用 `startPlaybackDeviceTest` 测试音频播放设备。
	- 调用 `startAudioDeviceLoopbackTest` 测试音频设备回路（包括录音设备和音频播放设备）。
- 调用 `startDeviceTest` 方法测试视频采集设备。

<div class="alert note">所有测试设备的方法都必须在加入频道之前调用。</div>

### 语音通话测试

- 用途：测试系统的音频设备（耳麦、扬声器等）和网络连接，是否正常工作。
- 测试方法和原理：调用 `startEchoTest`，并使用该方法的 `intervalInSeconds` 参数设置返回测试结果的时间间隔；用户说话；SDK 在设定的时间间隔后，如果能正常播放该用户说的话，则说明音频设备及网络连接正常。

```C++
// 开启回声测试
rtcEngine.startEchoTest(10);

// 等待并检查是否可以听到自己的声音回放

// 停止测试
rtcEngine.stopEchoTest;
```

### 音频录制设备测试

- 用途：测试本地音频录制设备，如麦克风，是否正常工作。
- 测试方法及原理：调用 `startRecordingDeviceTest`；用户说话，如果录制设备正常工作，SDK 会触发 `onAudioVolumeIndication` 回调并报告音量信息。UID 为 0 表示本地音量。完成测试后，需调用 `stopRecordingDeviceTest` 停止录制设备测试。

```C++
// 枚举所有音频设备
AAudioDeviceManager* lpDeviceManager = new AAudioDeviceManager(lpRtcEngine);
IAudioDeviceCollection *lpRecordingDeviceCollection = (*lpDeviceManager)->enumerateRecordingDevices();

UINT lCount = (UINT) lpRecordingDeviceCollection->getCount();

CString strDeviceName;
CString strDeviceID;

for (UINT nIndex = 0; nIndex < lCount; nIndex++){
    int nRet = lpRecordingDeviceCollection->getDevice(nIndex, strDeviceName, strDeviceID);
	...
}

// 选择一个音频采集设备
lpDeviceManager->setRecordingDevice(strDeviceID); // device ID chosen

// 实现音频音量回调接口
virtual void onAudioVolumeIndication(const AudioVolumeInfo* speakers, unsigned int speakerNumber, int totalVolume) {
        (void)speakers;
        (void)speakerNumber;
        (void)totalVolume;
    }

// 启用音频音量回调功能
rtcEngine.enableAudioVolumeIndication(1000, // 回调间隔，以毫秒为单位
	10 // 顺滑度
	);

// 开始音频采集设备测试
(*lpDeviceManager)->startRecordingDeviceTest(1000);

// 停止音频采集设备测试
(*lpDeviceManager)->stopRecordingDeviceTest();
```



### 音频播放设备测试

- 用途：测试本地音频播放设备，如外放设备，是否正常工作。
- 测试方法及原理：调用 `startPlaybackDeviceTest`，并指定播放的音频文件。如果能听到声音，则说明播放设备正常工作。完成测试后，需调用 `stopPlaybackDeviceTest` 停止播放设备测试。

```C++
AAudioDeviceManager* lpDeviceManager = new AAudioDeviceManager(lpRtcEngine);
IAudioDeviceCollection *lpPlaybackDeviceCollection = (*lpDeviceManager)->enumeratePlaybackDevices();

UINT lCount = (UINT) lpPlaybackDeviceCollection->getCount();

CString strDeviceName;
CString strDeviceID;

for (UINT nIndex = 0; nIndex < lCount; nIndex++){
    int nRet = lpPlaybackDeviceCollection->getDevice(nIndex, strDeviceName, strDeviceID);
	...
}

// 选择一个音频播放设备
lpDeviceManager->setPlaybackDevice(strDeviceID); // device ID chosen

#ifdef UNICODE
	CHAR wdFilePath[MAX_PATH];
	::WideCharToMultiByte(CP_UTF8, 0, filePath, -1, wdFilePath, MAX_PATH, NULL, NULL);
	(*lpDeviceManager)->startPlaybackDeviceTest(wdFilePath);
#else
	(*lpDeviceManager)->startPlaybackDeviceTest(filePath);
#endif


// 停止音频播放设备测试
(*lpDeviceManager)->stopPlaybackDeviceTest();
```

### 音频设备回路测试

- 用途：测试本地音频设备回路是否正常工作。
- 测试方法和原理：调用 `startAudioDeviceLoopbackTest`；用户说话，麦克风会采集本地讲话声音，然后用扬声器播放，同时 SDK 会在 `onAudioVolumeIndication` 回调中报告音量信息。UID 为 0 表示本地音量。完成测试后，需调用 `stopAudioDeviceLoopbackTest` 停止录制设备测试。

### 视频设备测试

- 用途：测试本地视频设备，如摄像头和显示器，是否正常功能。
- 测试方法及原理：调用 `enableVideo` 开启视频模块后，调用 `startDeviceTest`，并指定显示图像的窗口句柄，如果能看到本地采集的图像，则说明视频设备正常工作。完成测试后，需调用 `stopDeviceTest` 停止视频设备测试。

```C++
// 枚举所有视频采集设备
AVideoDeviceManager* lpDeviceManager = new AVideoDeviceManager(lpRtcEngine);
IVideoDeviceCollection *lpVideoDeviceCollection = (*lpDeviceManager)->enumerateVideoDevices();

UINT lCount = (UINT) lpVideoDeviceCollection->getCount();

CString strDeviceName;
CString strDeviceID;

for (UINT nIndex = 0; nIndex < lCount; nIndex++){
    int nRet = lpVideoDeviceCollection->getDevice(nIndex, strDeviceName, strDeviceID);
	...
}

// 选择一个视频采集设备
lpDeviceManager->setDevice(strDeviceID); // device ID chosen

// 开始视频采集设备测试，如果正常的话，你将会看到画面预览
(*lpDeviceManager)->startDeviceTest(view); // pass a window handler to it

// 停止视频采集设备测试
(*lpDeviceManager)->stopDeviceTest();
```



### API 参考

* [`startEchoTest`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#a842ed126b6e21a39059adaa4caa6d021)
* [`stopEchoTest`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#ae779da1c3fe153d73e8dfb2eb59ba9e4)
* [`enableAudioVolumeIndication`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#a4b30a8ff1ae50c4c114ae4f909c4ebcb)
* [`enumerateRecordingDevices`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_audio_device_manager.html#a1ea4f53d60dc91ea83960885f9ab77ee)
* [`setRecordingDevice`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_audio_device_manager.html#a723941355030636cd7d183d53cc7ace7)
* [`enumeratePlaybackDevices`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_audio_device_manager.html#aa13c99d575d89e7ceeeb139be723b18a)
* [`setPlaybackDevice`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_audio_device_manager.html#a1ee23eae83165a27bcbd88d80158b4f1)
* [`startRecordingDeviceTest`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_audio_device_manager.html#a9e732d31f179a90d388998f5b86ebf06)
* [`stopRecordingDeviceTest`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_audio_device_manager.html#a796e7b8a58eb303f18f04e1e9d12a94b)
* [`startAudioDeviceLoopbackTest`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_audio_device_manager.html#ac78c08f3212dc3efa000e197207dec53)
* [`stopAudioDeviceLoopbackTest`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_audio_device_manager.html#aad01da1e0bacd3f2fd355483f9e3befb)
* [`enumerateVideoDevices`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_video_device_manager.html#aef51744162ec544abf2aaf0488ca062d)
* [`startDeviceTest`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_video_device_manager.html#ac148cafcb191841fd4aa7f5b6166b16d)
* [`stopDeviceTest`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_video_device_manager.html#ae3fe9f7ad1ddf4d5cda5e30d14b9d321)

## 开发注意事项

- Last-mile 测试必须在加入通话频道之前。在结束测试之前，Agora 不建议调用其他 API 方法。
- `onLastmileQuality` 回调第一次报告的结果有一定概率是 unknown, 可通过之后的几次回调获得结果。
- 纯语音产品使用 48 Kbps 的固定探测码率；视频产品会根据当前选定的视频属性调整探测码率。
- 请确保进行测试时，相应的音视频设备没有被其他应用程序占用。
- 测试结束后，请务必调用相应的 stop 方法停止测试，然后再调用 `joinChannel` 加入频道。