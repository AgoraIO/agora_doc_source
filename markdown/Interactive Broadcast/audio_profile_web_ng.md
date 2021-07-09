---
title: 设置音频属性
platform: Web
updatedAt: 2020-12-30 09:08:15
---
<div class="alert note">本文仅适用于 Agora Web SDK 4.x 版本。如果你使用的是 Web SDK 3.x 或更早版本，请查看<a href="./audio_profile_web?platform=Web">设置音频属性</a>。</li></div>

## 功能描述
在一些比较专业的场景里，用户对声音的效果尤为敏感，比如语音电台，此时就需要对双声道和高音质的支持。
所谓的高音质指的是我们提供采样率为 48 kHz、码率 192 Kbps 的能力实现高逼真的音乐场景，这种能力在语音电台、唱歌比赛类直播场景中应用较多。

## 实现方法
开始前，请确保你已参考快速开始在你的项目中实现基本的实时音视频功能。

Agora Web SDK 提供以下三种方法创建本地音频轨道：
- `createMicrophoneAudioTrack`
- `createBufferSourceAudioTrack`
- `createCustomAudioTrack`

你可以通过修改这些方法中的 `encoderConfig` 参数来调整音频的编码配置。

`encoderConfig` 支持以下两种设置：

- 使用 SDK 预设的音频编码属性。
- 自定义各种音频编码参数的对象。

### 示例代码

**使用预设音频编码属性**

```javascript
AgoraRTC.createMicrophoneAudioTrack({
  encoderConfig: "high_quality_stereo",
}).then(/**...**/);
```

**自定义音频编码属性**

```javascript
AgoraRTC.createMicrophoneAudioTrack({
  encoderConfig: {
    sampleRate: 48000,
    stereo: true,
    bitrate: 128,
  },
}).then(/**...**/);
```


### API 参考

- [`createMicrophoneAudioTrack`](./API%20Reference/web/v4.2.1/interfaces/iagorartc.html#createmicrophoneaudiotrack)
- [`createBufferSourceAudioTrack`](./API%20Reference/web/v4.2.1/interfaces/iagorartc.html#createbuffersourceaudiotrack)
- [`createCustomAudioTrack`](./API%20Reference/web/v4.2.1/interfaces/iagorartc.html#createcustomaudiotrack)

## 开发注意事项

请在调用 `AgoraRTCClient.publish` 方法发布音频轨道之前设置好音频编码属性，音频轨道发布后无法修改音频编码属性。