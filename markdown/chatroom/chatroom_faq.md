本文总结使用声动语聊方案时可能遇到的常见问题和解决方法。

## 禁止人声但不禁止背景音乐

### 问题

如何实现某用户调用 [`startAudioMixing`](https://docportal.shengwang.cn/cn/live-streaming-premium-4.x/API%20Reference/java_ng/API/toc_audio_process.html#api_irtcengine_startaudiomixing2) 播放背景音乐时，不想让频道内其他人听到自己说话的声音，只想让别人听到自己播放的背景音乐？

### 解决方法

该用户可以调用 [`adjustRecordingSignalVolume`](https://docportal.shengwang.cn/cn/live-streaming-premium-4.x/API%20Reference/java_ng/API/toc_audio_process.html#api_irtcengine_adjustrecordingsignalvolume) 将音量设置为 0。

## 禁止人声和背景音乐

### 问题

如何实现某用户调用 [`startAudioMixing`](https://docportal.shengwang.cn/cn/live-streaming-premium-4.x/API%20Reference/java_ng/API/toc_audio_process.html#api_irtcengine_startaudiomixing2) 播放背景音乐时，不想让自己说话的声音和背景音乐被频道内其他人听到？

### 解决方法

该用户可以调用 [`muteLocalAudioStream`](https://docportal.shengwang.cn/cn/live-streaming-premium-4.x/API%20Reference/java_ng/API/toc_stream_management.html#api_irtcengine_mutelocalaudiostream) 取消发布本地音频流。

## 不听说话者声音

### 问题

如何实现某用户在语聊房间内，想知道谁在说话，但不想听到说话者的声音？

### 解决方法

该用户可以调用 [`adjustUserPlaybackSignalVolume`](https://docportal.shengwang.cn/cn/live-streaming-premium-4.x/API%20Reference/java_ng/API/toc_audio_process.html#api_irtcengine_adjustuserplaybacksignalvolume) 设置某个说话者的播放音量为 0，或者调用 [`adjustPlaybackSignalVolume`](https://docportal.shengwang.cn/cn/live-streaming-premium-4.x/API%20Reference/java_ng/API/toc_audio_process.html#api_irtcengine_adjustplaybacksignalvolume) 设置频道内所有人的播放音量为 0。


## 处理第三方应用音频

### 问题

- 如何实现集成声网 SDK 后，该应用与第三方应用的音频可以同时播放？
- 如何实现集成声网 SDK 后，使用该应用时会打断第三方应用的音频播放？

### 解决方法

你可以在加入频道前设置如下私有参数：

```cpp
// 与第三方应用的音频可以同时播放
setParameters(“{\"che.audio.mix_with_others\": true}”)
```

```cpp
// 打断第三方应用的音频播放
setParameters("{\"che.audio.mix_with_others\":false}")
```

## 处理第三方播放器音频

### 问题

如果你使用声网 SDK 和第三方播放器集成语聊房应用，那么可能出现用户进入声网 RTC 频道后会自动打断第三方播放器的音视频播放现象，比如使第三方播放器播放卡顿或者不断被打断。如何避免第三方播放器音频被打断？

### 解决方法

你可以在加入频道前设置如下私有参数：

```cpp
// 防止音频被打断
setParameters("{\"che.audio.keep.audiosession\":true}");
```

## 断网重连导致鬼麦

### 问题

当用户使用声动语聊方案时，如果网络突然中断，你的业务服务器会将该用户从正常的用户列表中移除。但是，如果网络恢复，声网会自动进行断线重连，使该用户可以再次加入原来的语聊房间，此时你的业务服务器无法管理该用户，会导致出现“鬼麦”现象。如何避免断网重连导致的“鬼麦”现象？

### 解决方法

如下步骤可以避免断网重连导致的“鬼麦”现象：

1. 通过声网服务让业务服务器将失联用户标记为已离线：
    - 可以使用声网即时通讯（IM）SDK 判断用户失联的时间。比如，当用户失联超过 30 秒时，业务服务器会将该用户标记为已离线。
    - 可以使用声网消息通知服务。当用户快断线时，该服务会提前 20 秒告知用户即将离线。此时业务服务器可以做已离线标记。

2. 当用户的网络再次连接时，业务服务器会与之同步该用户的状态。如果业务服务器标记该用户为已离线，该就可以调用 [`leaveChannel`](https://docportal.shengwang.cn/cn/live-streaming-premium-4.x/API%20Reference/java_ng/API/toc_core_method.html#api_irtcengine_leavechannel) 让该用户离开原来的频道。从而，避免“鬼麦”现象。