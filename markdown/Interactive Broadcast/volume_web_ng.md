---
title: 调整通话音量
platform: Web
updatedAt: 2020-12-30 09:08:15
---

<div class="alert note">本文仅适用于 Agora Web SDK 4.x 版本。如果你使用的是 Web SDK 3.x 或更早版本，请查看<a href="./volume_web?platform=Web">调整通话音量</a>。</li></div>

## 功能描述

在使用 Agora Web SDK 时，你可以对 SDK 采集到的声音及 SDK 播放的声音音量进行调整，以满足产品在声音上的个性化需求。比如进行双人通话时，可以通过这个功能调整麦克风采集音量或者远端用户音量。

## 实现方法

开始前，请确保你已参考快速开始在你的项目中实现基本的实时音视频功能。

SDK 为本地音频轨道和远端音频轨道对象分别提供 `setVolume` 方法用于调整本地音频的采集音量和远端音频的播放音量。

### 示例代码

**调节远端音频的播放音量**

以下示例中 `remoteUser` 是指已订阅的远端用户对象。

```javascript
// 将音量减少一半
remoteUser.audioTrack.setVolume(50);
// 将音量增大一倍
remoteUser.audioTrack.setVolume(200);
// 将远端音量设置为 0
remoteUser.audioTrack.setVolume(0);
```

**调节本地音频的采集音量**

以下示例中 `localAudioTrack` 是指自己创建的本地音频轨道对象。

```javascript
AgoraRTC.createMicrophoneAudioTrack().then(localAudioTrack => {
  // 麦克风音量减半
  localAudioTrack.setVolume(50);
  // 麦克风音量增大一倍
  localAudioTrack.setVolume(200);
  // 将麦克风音量设置为 0
  localAudioTrack.setVolume(0);
});
```

### API 参考

- [`LocalAudioTrack.setVolume`](./API%20Reference/web/v4.2.1/interfaces/ilocalaudiotrack.html#setvolume)
- [`RemoteAudioTrack.setVolume`](./API%20Reference/web/v4.2.1/interfaces/iremoteaudiotrack.html#setvolume)

## 开发注意事项

音量设置太大在某些设备上可能出现爆音现象。
