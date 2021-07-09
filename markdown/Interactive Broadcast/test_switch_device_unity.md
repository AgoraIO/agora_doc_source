---
title: 音视频设备测试
platform: Unity
updatedAt: 2020-03-08 16:01:32
---
## 功能描述

为保证通话或直播质量，我们推荐在进入频道前进行音视频设备测试，检测麦克风、摄像头等音视频设备能否正常工作。该功能对于有高质量要求的场景，如在线教育等，尤为适用。

## 实现方法

请确保你已经了解如何实现音视频通话或互动直播。详见快速开始：

- [实现语音通话](start_call_audio_unity)或[实现音频互动直播](start_live_audio_unity)
- [实现视频通话](start_call_unity)或[实现视频互动直播](start_live_unity)

参考以下方法测试音视频设备：

- 调用 `StartAudioRecordingDeviceTest` 或 `StartEchoTest` 测试音频采集设备。若想停止测试，调用 `StopAudioRecordingDeviceTest` 或 `StopEchoTest`。
- 调用 `StartAudioPlaybackDeviceTest` 或 `StartEchoTest` 测试音频播放设备。若想停止测试，调用 `StopAudioPlaybackDeviceTest` 或 `StopEchoTest`。
- 调用 `StartPreview` 方法测试视频设备。若想停止测试，调用 `StopPreview`。

<div class="alert note">所有测试设备的方法都必须在加入频道之前调用。</div>

### 音频采集设备测试

- 用途：测试本地音频采集设备，如麦克风，是否正常工作。
- 测试方法及原理：调用 `StartAudioRecordingDeviceTest 或 StartEchoTest`；用户说话，如果采集设备正常工作，SDK 会触发 `OnVolumeIndicationHandler` 回调并报告音量信息（UID 为 0 表示本地音量）。若想停止测试，调用 `StopAudioRecordingDeviceTest` 或 `StopEchoTest`。

#### 示例代码

```c#
// 适用于 Windows 或 macOS 设备。
public void loadEngine(string appId)
{
    // 初始化 IRtcEngine。
    mRtcEngine = IRtcEngine.GetEngine (appId);
    mRtcEngine.OnVolumeIndication = OnVolumeIndicationHandler;
    // 获取 AudioRecordingDeviceManager 类。
    AudioRecordingDeviceManager audioRecordingDeviceManager = (AudioRecordingDeviceManager)mRtcEngine.GetAudioRecordingDeviceManager();
    // 创建 AudioRecordingDeviceManager 实例。
    audioRecordingDeviceManager.CreateAAudioRecordingDeviceManager();
    // 获取系统中被索引的音频采集设备的总数。
    int count = audioRecordingDeviceManager.GetAudioRecordingDeviceCount();
    // 获取某个被索引的音频采集设备 ID。index 为指定的索引值，必须小于 GetAudioRecordingDeviceCount 的返回值。
    audioRecordingDeviceManager.GetAudioRecordingDevice(0, ref deviceNameA, ref deviceIdA);
    // 通过设备 ID 设置指定的音频采集设备。
    audioRecordingDeviceManager.SetAudioRecordingDevice(deviceIdA);
    // 启用音频音量回调功能。
    mRtcEngine.EnableAudioVolumeIndication(300, 3, true);
    // 开始音频采集设备测试。
    audioRecordingDeviceManager.StartAudioRecordingDeviceTest(300);
    // 停止音频采集设备测试。
    audioRecordingDeviceManager.StopAudioRecordingDeviceTest();
    // 释放 AudioRecordingDeviceManager 实例。
    audioRecordingDeviceManager.ReleaseAAudioRecordingDeviceManager();
}
      
// 实现音频音量回调接口。
void OnVolumeIndicationHandler(AudioVolumeInfo[] speakers, int speakerNumber, int totalVolume)
{
  
}
```

```c#
// 适用于 Android 或 iOS 设备。
public void loadEngine(string appId)
{
    // 初始化 IRtcEngine。
    mRtcEngine = IRtcEngine.GetEngine (appId);  
    // 开始音频设备测试。
    mRtcEngine.StartEchoTest(10);
    // 停止音频设备测试。
    mRtcEngine.StopEchoTest();
}
```

#### API 参考

- [`CreateAAudioRecordingDeviceManager`](./API%20Reference/unity/classagora__gaming__rtc_1_1_audio_recording_device_manager.html#ad9fb9e47b11e58219a531b092ed2f542)
- [`GetAudioRecordingDeviceManager`](./API%20Reference/unity/classagora__gaming__rtc_1_1_i_rtc_engine.html#a5e91acecd848f60d3f7b6e1feedd8ec2)
- [`GetAudioRecordingDeviceCount`](./API%20Reference/unity/classagora__gaming__rtc_1_1_audio_recording_device_manager.html#a506b83d43a439a5c70522250efcd18fa)
- [`GetAudioRecordingDevice`](./API%20Reference/unity/classagora__gaming__rtc_1_1_audio_recording_device_manager.html#a915dc0e346e47a20b12c9b4153f2f8ff)
- [`SetAudioRecordingDevice`](./API%20Reference/unity/classagora__gaming__rtc_1_1_audio_recording_device_manager.html#aba3adae3ee4b65ca9d4ad96ec90ea85e)
- [`OnVolumeIndicationHandler`](./API%20Reference/unity/namespaceagora__gaming__rtc.html#ac1916abed6e6e714c05997f415ec8686)
- [`EnableAudioVolumeIndication`](./API%20Reference/unity/classagora__gaming__rtc_1_1_i_rtc_engine.html#a9fcbc19f8c908171dd06be102b3cc84c)
- [`StartAudioRecordingDeviceTest`](./API%20Reference/unity/classagora__gaming__rtc_1_1_audio_recording_device_manager.html#af9b3a6b30159c8f408150195553db973)
- [`StopAudioRecordingDeviceTest`](./API%20Reference/unity/classagora__gaming__rtc_1_1_audio_recording_device_manager.html#a0763233b634c0f52521d20aae6e31d58)
- [`ReleaseAAudioRecordingDeviceManager`](./API%20Reference/unity/classagora__gaming__rtc_1_1_audio_recording_device_manager.html#a5c9812b4b2ae51ba8ca69f717e6d0fd9)
- [`StartEchoTest`](./API%20Reference/unity/classagora__gaming__rtc_1_1_i_rtc_engine.html#a98242534c8fbbe6451aef90f115bf253)
- [`StopEchoTest`](./API%20Reference/unity/classagora__gaming__rtc_1_1_i_rtc_engine.html#afa82ea6348ed0952ad4941aec6020553)

### 音频播放设备测试

- 用途：测试本地音频播放设备，如外放设备，是否正常工作。
- 测试方法及原理：调用 `StartAudioPlaybackDeviceTest 或 StartEchoTest`，并指定播放的音频文件。如果能听到声音，则说明播放设备正常工作。若想停止测试，调用 `StopAudioPlaybackDeviceTest 或 StopEchoTest`。

#### 示例代码

```c#
// 适用于 Windows 或 macOS 设备。
public void loadEngine(string appId)
{
    // 初始化 IRtcEngine。
    mRtcEngine = IRtcEngine.GetEngine (appId);
    mRtcEngine.OnVolumeIndication = OnVolumeIndicationHandler;
    // 获取 AudioPlaybackDeviceManager 类。
    AudioPlaybackDeviceManager audioPlaybackDeviceManager = (AudioPlaybackDeviceManager)mRtcEngine.GetAudioPlaybackDeviceManager();
    // 创建 AudioPlaybackDeviceManager 实例。
    audioPlaybackDeviceManager.CreateAAudioPlaybackDeviceManager();
    // 获取系统中被索引的音频播放设备的总数。
    int count = audioPlaybackDeviceManager.GetAudioPlaybackDeviceCount();
    // 获取某个被索引的音频播放设备 ID。index 为指定的索引值，必须小于 GetAudioPlaybackDeviceCount 的返回值。
    audioPlaybackDeviceManager.GetAudioPlaybackDevice(0, ref deviceNameA, ref deviceIdA);
    // 通过设备 ID 设置指定的音频播放设备。
    audioPlaybackDeviceManager.SetAudioPlaybackDevice(deviceIdA);
    // 启用音频音量回调功能。
    mRtcEngine.EnableAudioVolumeIndication(300, 3, true);
    // 开始音频播放设备测试。
    audioPlaybackDeviceManager.StartAudioPlaybackDeviceTest(300);
    // 停止音频播放设备测试。
    audioPlaybackDeviceManager.StopAudioPlaybackDeviceTest();
    // 释放 AudioPlaybackDeviceManager 实例。
    audioPlaybackDeviceManager.ReleaseAAudioPlaybackDeviceManager();
}
      
// 实现音频音量回调接口。
void OnVolumeIndicationHandler(AudioVolumeInfo[] speakers, int speakerNumber, int totalVolume)
{
  
}
```

```c#
// 适用于 Android 或 iOS 设备。
public void loadEngine(string appId)
{
    // 初始化 IRtcEngine。
    mRtcEngine = IRtcEngine.GetEngine (appId);  
    // 开始音频设备测试。
    mRtcEngine.StartEchoTest(10);
    // 停止音频设备测试。
    mRtcEngine.StopEchoTest();
}
```

#### API 参考

- [`CreateAAudioPlaybackDeviceManager`](./API%20Reference/unity/classagora__gaming__rtc_1_1_audio_playback_device_manager.html#a450d22b7a62e19ef904b25497ca37a9f)
- [`GetAudioPlaybackDeviceManager`](./API%20Reference/unity/classagora__gaming__rtc_1_1_i_rtc_engine.html#a80ef3b11d711fd8b7151184b53f3e9ad)
- [`GetAudioPlaybackDeviceCount`](./API%20Reference/unity/classagora__gaming__rtc_1_1_audio_playback_device_manager.html#a1146b8b47de6f2bb484036fe148940bf)
- [`GetAudioPlaybackDevice`](./API%20Reference/unity/classagora__gaming__rtc_1_1_audio_playback_device_manager.html#ac2a33d9a4a6cc5e595c8ed97d5abd9f6)
- [`SetAudioPlaybackDevice`](./API%20Reference/unity/classagora__gaming__rtc_1_1_audio_playback_device_manager.html#a5e3887205c686a3ee1ba5b019ce890d0)
- [`OnVolumeIndicationHandler`](./API%20Reference/unity/namespaceagora__gaming__rtc.html#ac1916abed6e6e714c05997f415ec8686)
- [`EnableAudioVolumeIndication`](./API%20Reference/unity/classagora__gaming__rtc_1_1_i_rtc_engine.html#a9fcbc19f8c908171dd06be102b3cc84c)
- [`StartAudioPlaybackDeviceTest`](./API%20Reference/unity/classagora__gaming__rtc_1_1_audio_playback_device_manager.html#af22121da6b72efd95de5567dcef250b8)
- [`StopAudioPlaybackDeviceTest`](./API%20Reference/unity/classagora__gaming__rtc_1_1_audio_playback_device_manager.html#a258fd90156636b7b4a0ccd3cef048563)
- [`ReleaseAAudioPlaybackDeviceManager`](./API%20Reference/unity/classagora__gaming__rtc_1_1_audio_playback_device_manager.html#a1cabc394e77fe075416b999610301c04)
- [`StartEchoTest`](./API%20Reference/unity/classagora__gaming__rtc_1_1_i_rtc_engine.html#a98242534c8fbbe6451aef90f115bf253)
- [`StopEchoTest`](./API%20Reference/unity/classagora__gaming__rtc_1_1_i_rtc_engine.html#afa82ea6348ed0952ad4941aec6020553)

### 视频设备测试

- 用途：测试本地视频设备，如摄像头和显示器，是否正常功能。
- 测试方法及原理：调用 `EnableVideo` 和 `EnableVideoObserver` 开启视频模块和视频观测器后，调用 `StartPreview`，如果能看到本地采集的图像，则说明视频设备正常工作。若想停止测试，调用 `StopPreview`。

<div class="alert note"><li>为获取原始视频数据，需同时调用 <tt>EnableVideo</tt> 和 <tt>EnableVideoObserver</tt> 方法。<br><li>在 Unity 中无法获取准确的窗口句柄，Agora 不建议使用 <tt>StartVideoDeviceTest</tt> 方法测试视频设备。</div>

#### 示例代码

```c#
// 适用于 Windows 或 macOS 设备。
public void loadEngine(string appId)
{
    // 初始化 IRtcEngine。
    mRtcEngine = IRtcEngine.GetEngine (appId);
    // 获取 VideoDeviceManager 对象。
    VideoDeviceManager videoDeviceManager = (VideoDeviceManager)mRtcEngine.GetVideoDeviceManager();
    // 创建 VideoDeviceManager 实例。
    videoDeviceManager.CreateAVideoDeviceManager();
    // 获取系统中被索引的视频设备总数。
    videoDeviceManager.GetVideoDeviceCount();
    // 获取某个被索引的视频设备 ID。index 为指定的索引值，必须小于 GetVideoDeviceCount 的返回值。
    videoDeviceManager.GetVideoDevice(0, deviceNameA, deviceIdA);
    // 通过设备 ID 设置指定的视频设备。
    videoDeviceManager.SetVideoDevice(deviceIdA);
    // 开启视频模块。
    int mRtcEngine.EnableVideo();
    // 开启视频观测器。
    int mRtcEngine.EnableVideoObserver();
    // 开启视频预览。
    int mRtcEngine.StartPreview();
    // 停止视频预览。
    int mRtcEngine.StopPreview();
    // 释放 VideoDeviceManager 实例。
    videoDeviceManager.ReleaseAVideoDeviceManager();
}
```

#### API 参考

- [`CreateAVideoDeviceManager`](./API%20Reference/unity/classagora__gaming__rtc_1_1_video_device_manager.html#aa1b7dac0847168bf1785c809ea365448)
- [`GetVideoDeviceManager`](./API%20Reference/unity/classagora__gaming__rtc_1_1_i_rtc_engine.html#a043b46e8ec12ca5dab99d10e75c7e385)
- [`GetVideoDeviceCount`](./API%20Reference/unity/classagora__gaming__rtc_1_1_video_device_manager.html#a6b1bfd5cb7e1749861b8dc1167a98725)
- [`GetVideoDevice`](./API%20Reference/unity/classagora__gaming__rtc_1_1_video_device_manager.html#a2564c374c51d6a352394fe3c87abc8fa)
- [`SetVideoDevice`](./API%20Reference/unity/classagora__gaming__rtc_1_1_video_device_manager.html#aa85b06e3ecff61b799fce74f31af88e4)
- [`EnableVideo`](./API%20Reference/unity/classagora__gaming__rtc_1_1_i_rtc_engine.html#a1372df5a9a62a56996dbdb839b375116)
- [`EnableVideoObserver`](./API%20Reference/unity/classagora__gaming__rtc_1_1_i_rtc_engine.html#ace979cd59611a0cc39e13f8ea33c0f7c)
- [`StartPreview`](./API%20Reference/unity/classagora__gaming__rtc_1_1_i_rtc_engine.html#a50cd2959d23dc061a08cab28f40ee212)
- [`StopPreview`](./API%20Reference/unity/classagora__gaming__rtc_1_1_i_rtc_engine.html#a46072182b9da72eced255d7d5b9d989f)
- [`ReleaseAVideoDeviceManager`](./API%20Reference/unity/classagora__gaming__rtc_1_1_video_device_manager.html#a2e24fdc1ecd02fbd9add649f2e070278)

## 开发注意事项

- 请确保进行测试时，相应的音视频设备没有被其他应用程序占用。
- 测试结束后，请务必调用相应的 `Stop` 方法停止测试，然后再调用 `JoinChannelByKey` 加入频道。