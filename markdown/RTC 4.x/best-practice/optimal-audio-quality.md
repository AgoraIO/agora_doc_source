# 高音质最佳实践

本文适用于对音质体验要求较高的场景，包括但不限于K歌、播客和表演性质的语聊。你可以参考本文提供的实践方法，获得高清晰度、高还原度的音频效果。

<div class="alert info">本文以 Android 客户端为例。如需设置其他平台，请参考对应平台的同名 API。</div>

## 通用设置

### 设置音频编码属性

调用 [`setAudioProfile`[2/2]](https://docportal.shengwang.cn/cn/video-call-4.x/API%20Reference/java_ng/API/toc_audio_process.html#api_irtcengine_setaudioprofile2) 设置音频编码属性为 `MUSIC_HIGH_QUALITY_STEREO(5)`，即 48 kHz 采样率，音乐编码，双声道，编码码率最大值为 128 Kbps。

```java
setAudioProfile(Constants.MUSIC_HIGH_QUALITY_STEREO)
```

### 设置音频场景

调用 [`setAudioScenario`](https://docportal.shengwang.cn/cn/video-call-4.x/API%20Reference/java_ng/API/toc_audio_process.html#api_irtcengine_setaudioscenario) 设置音频场景为 `AUDIO_SCENARIO_GAME_STREAMING(3)`，即高音质场景。

```java
setAudioScenario(Constants.AUDIO_SCENARIO_GAME_STREAMING)
```


## 声卡用户设置

### 关闭 3A

使用声卡的前提下是没有回声噪声问题，因此可以调用 [`setParameters`](https://docportal.shengwang.cn/cn/video-call-4.x/API%20Reference/java_ng/API/toc_network.html?platform=Android#api_irtcengine_setparameters) 关闭默认开启的回声消除 (AEC)、降噪 (ANS) 和增效控制 (AGC)。

```java
setParameters("{"che.audio.aec.enable":false}");  // 关闭回音消除
setParameters("{"che.audio.ans.enable":false}");  // 关闭降噪
setParameters("{"che.audio.agc.enable":false}");  // 关闭增益控制
```

### 打开立体声采集

调用 [`setAdvancedAudioOptions`](https://docportal.shengwang.cn/cn/video-call-4.x/API%20Reference/java_ng/API/toc_audio_process.html?platform=Android) 设置音频前处理声道数为 `AGORA_AUDIO_STEREO_PROCESSING(2)`，即采用双声道，采集并发送立体声。

```java
AdvancedAudioOptions options;
options.audioProcessingChannels = 2;
m_lpAgoraEngine->setAdvancedAudioOptions(options);
```