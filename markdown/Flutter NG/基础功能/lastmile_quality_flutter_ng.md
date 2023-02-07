# 通话前检测

在对音视频质量要求较高的场景下，需要在通话前进行检测，以确保设备的运转状态良好、设备与声网平台之间的网络状态正常。 此操作能够提前识别并排除潜在的故障，从而改善用户体验。

本文介绍如何在 app 中实施网络和设备检测。


## 技术原理

在通信场景中，可通过检测了解网络状态。 例如，简单发送一条空消息以查看目标地址是否存在。

进行网络检测时需要重点关注以下指标：

- 带宽：通常以 bit/s 为单位，表示信息传输的最大速率
- 吞吐量：信息传输的实际速率
- 时延：信息从发送方到接收方所需要的时间，包括接收方的解码时间，以及每一个网络节点进行数据处理的时间
- 抖动：接收方收到数据包的延迟变化
- 错误率：以百分比或分数表示损坏的信息占发送信息总数的比例

进行设备检测可以保证设备获取的音频在经过网络传输后可以正常播放。 首先，声网会从设备的麦克风获取音频，然后将其发送到声网平台，并定义一个等待时间（例如：5 秒）。 等待时间过后，声网平台将音频发送回设备，并在设备扬声器中播放。 然后，你可以判断音频的质量是否良好。

声网建议你先进行设备测试，然后进行网络检测。

### 设备检测

SDK 提供了`startEchoTest` 方法，用于测试网络连接和音频设备（例如麦克风和扬声器）是否正常工作。

### 网络检测

SDK 提供了 `startLastmileProbeTest` 方法，用于在加入频道前检测 last mile 网络并返回有关网络质量的统计信息，包括往返时延、丢包率和网络带宽。

各 API 的调用时序如下：

![](https://web-cdn.agora.io/docs-files/1675740215059)

在进行 last mile 检测时，视频 SDK 根据视频配置文件调整实际比特率。


## 前提条件

在进行操作之前，请确保你已经在项目中实现了基本的实时音视频功能。 有关详细信息，请参考[实现视频通话](./start_call_flutter_ng)或[实现视频直播](./start_live_flutter_ng)。


## 操作步骤

请参考以下步骤在 app 中实施通话前检测。

### 设备检测

#### 语音通话检测

测试系统的音频设备和网络连接是否正常，请参考以下步骤。

1. 在加入频道之前，调用 `startEchoTest`。 你需要在该方法中设置 `intervalInSeconds` 参数来通知 SDK 何时上报本次测试的结果。 取值范围为 [2~10]，默认值为 10（单位：秒）。
2. 当回声测试开始后，引导用户说一句话。 如果在设置的时间间隔后回放录音，则表示音频设备和网络连接正常。
3. 获得测试结果后，先调用` stopEchoTest` 停止测试，再调用 `joinChannelByToken` 加入频道。

请参考以下示例代码来实现该功能。

```dart
// 开始回声测试
// 只有主播才能调用 startEchoTest
await _engine.startEchoTest();
 
// 等待并检查是否可以听到自己的声音回放

// 停止回声测试
// 必须调用 stopEchoTest 结束回声测试。否则，你将无法进行另一次回声测试或加入频道
await _engine.stopEchoTest();
```

#### 音频录制设备检测

测试本地音频录制设备（如麦克风）是否正常工作，请参考以下步骤。

1. 调用 `startRecordingDeviceTest`，并将 `indicationInterval` 参数设置为触发回调的时间间隔。
2. 引导用户说一句话，SDK 会在 `onAudioVolumeIndication` 回调中报告 `uid` = 0 及设备的音量信息。
3. 完成测试后，调用 `stopRecordingDeviceTest` 停止录制设备测试。

<div class="alert note">建议将 <code>indicationInterval</code> 参数设置到大于 200 毫秒，最小不得少于 10 毫秒，否则会收不到 <code>onAudioVolumeIndication</code> 回调。</div>

```dart
// 选择一个音频采集设备
await _audioDeviceManager.setRecordingDevice(deviceId);
 
// 实现音频音量回调接口
onAudioVolumeIndication: (RtcConnection connection,
    List<AudioVolumeInfo> speakers, int speakerNumber, int totalVolume) {
  logSink.log('[onAudioVolumeIndication] speakers: ${speakers.toString()}, speakerNumber: $speakerNumber, totalVolume: $totalVolume');
},
 
// 开始音频采集设备测试
await _audioDeviceManager.startRecordingDeviceTest(1000);
 
// 停止音频采集设备测试。
await _audioDeviceManager.stopRecordingDeviceTest();
```

#### 音频播放设备检测

测试本地音频播放设备（如外放设备）是否正常工作，请参考以下步骤。

1. 调用 `startPlaybackDeviceTest`，并将 `audioFileName ` 参数设置为待播放的音频文件的绝对路径。
2. 如果能听到声音，说明播放设备能正常工作。SDK 会触发一次 `onAudioVolumeIndication` 回调，报告 `uid `= 1 及播放设备的音量信息。
3. 完成测试后，调用 `stopPlaybackDeviceTest` 停止播放设备测试。

```dart
// 选择一个音频播放设备
await _audioDeviceManager.setPlaybackDevice(_selectedPlaybackDeviceId);

// 指定音频文件的绝对路径，启动播放设备测试
await _audioDeviceManager.startPlaybackDeviceTest(filePath);
 
// 停止音频播放设备测试
await _audioDeviceManager.stopPlaybackDeviceTest();
```

#### 音频设备回路检测

测试本地音频设备回路是否正常，请参考以下步骤。

1. 调用 `startAudioDeviceLoopbackTest`，并将 `indicationInterval` 参数设置为触发回调的时间间隔。
2. 引导用户说一句话，麦克风会采集声音然后用扬声器播放，同时 SDK 会返回两个 `onAudioVolumeIndication` 回调，分别报告音频采集设备（`uid`= 0）和音频播放设备（`uid`= 1）的音量信息。
3. 完成测试后，调用 `stopAudioDeviceLoopbackTest` 停止录制设备测试。

<div class="alert note">建议将 <code>indicationInterval</code> 参数设置到大于 200 毫秒，最小不得少于 10 毫秒，否则会收不到 <code>onAudioVolumeIndication</code> 回调。</div>

```dart
await _audioDeviceManager.startAudioDeviceLoopbackTest(1000);
 
await _audioDeviceManager.stopAudioDeviceLoopbackTest();
```


### 网络检测

请参考以下步骤进行网络检测。

1. 在加入频道或切换用户角色之前，调用 `startLastmileProbeTest` 启动网络检测。 你需要在此方法中设置你预期的上行和下行比特率。

2. 调用该方法后，SDK 将返回以下两个回调：
   - `onLastmileQuality`：在调用 `startLastmileProbeTest` 2 秒后返回。 该回调通过打分反馈上下行网络质量，更贴近主观感受。
   - `onLastmileProbeResult`：在调用 `startLastmileProbeTest` 30 秒后返回。 该回调提了网络质量的实时统计数据，更加客观。

3. 获取网络质量统计信息后，调用 `stopLastmileProbeTest` 停止网络检测。

```dart
// 配置一个 LastmileProbeConfig 实例
LastmileProbeConfig config = const LastmileProbeConfig(
  probeUplink: true,  // 确认探测上行网络质量
  probeDownlink: true,  // 确认探测下行网络质量
  expectedUplinkBitrate: 100000,  // 期望的最高发送码率，单位为 bps，范围为 [100000,5000000]
  expectedDownlinkBitrate: 100000,  // 期望的最高接收码率，单位为 bps，范围为 [100000,5000000]
);
// 开启网络探测
await _engine.startLastmileProbeTest(config);
 
 
// 停止网络检测
await _engine.stopLastmileProbeTest();
```

## 参考信息

介绍本文中使用方法的更多信息以及相关页面的链接。

### 示例项目

声网在 GitHub 上提供了一个开源的[通话前检测](https://github.com/AgoraIO/API-Examples/tree/4.0.0-GA/windows/APIExample/APIExample/Advanced/PreCallTest)示例项目。 你可以下载体验或查看其中的源代码。

### API 参考

- [`startRecordingDeviceTest`](./API%20Reference/flutter_ng/API/toc_audio_device_management.html?platform=Flutter#api_iaudiodevicemanager_startrecordingdevicetest)
- [`stopRecordingDeviceTest`](./API%20Reference/flutter_ng/API/toc_audio_device_management.html?platform=Flutter#api_iaudiodevicemanager_stoprecordingdevicetest)
- [`startPlaybackDeviceTest`](./API%20Reference/flutter_ng/API/toc_audio_device_management.html?platform=Flutter#api_iaudiodevicemanager_startplaybackdevicetest)
- [`stopPlaybackDeviceTest`](./API%20Reference/flutter_ng/API/toc_audio_device_management.html?platform=Flutter#api_iaudiodevicemanager_stopplaybackdevicetest)
- [`startAudioDeviceLoopbackTest`](./API%20Reference/flutter_ng/API/toc_audio_device_management.html?platform=Flutter#api_iaudiodevicemanager_startaudiodeviceloopbacktest)
- [`stopAudioDeviceLoopbackTest`](./API%20Reference/flutter_ng/API/toc_audio_device_management.html?platform=Flutter#api_iaudiodevicemanager_stopaudiodeviceloopbacktest)
- [`startEchoTest`](./API%20Reference/flutter_ng/API/toc_network.html?platform=Flutter#api_irtcengine_startechotest2)
- [`stopEchoTest`](./API%20Reference/flutter_ng/API/toc_network.html?platform=Flutter#api_irtcengine_stopechotest)
- [`startLastmileProbeTest`](./API%20Reference/flutter_ng/API/toc_network.html?platform=Flutter#api_irtcengine_startlastmileprobetest)
- [`stopLastmileProbeTest`](./API%20Reference/flutter_ng/API/toc_network.html?platform=Flutter#api_irtcengine_stoplastmileprobetest)
- [`onLastmileQuality`](./API%20Reference/flutter_ng/API/toc_network.html?platform=Flutter#callback_irtcengineeventhandler_onlastmilequality)
- [`onLastmileProbeResult`](./API%20Reference/flutter_ng/API/toc_network.html?platform=Flutter#callback_irtcengineeventhandler_onlastmileproberesult)