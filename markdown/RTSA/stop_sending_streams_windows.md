---
title: 更改音视频流传输状态
platform: macOS
updatedAt: 2019-08-15 11:55:28
---

## 功能描述

用户成功加入频道并开始音视频流传输后，可以暂停向指定频道或所有频道发送流，也可以暂停接收指定频道或所有频道的流，从而灵活调整音视频流传输状态。

## 实现方法

### 发送端

**暂停/恢复发送本地音视频流**

可调用以下方法暂停或恢复发送本地音视频流：

- `agora_rtc_mute_local_audio`：暂停发送本地音频流。
- `agora_rtc_mute_local_video`：暂停发送本地视频流。

> 你既可以通过传入频道名暂停或恢复向指定频道发送数据，也可以将 `channel_name` 设置为 null 暂停或恢复向所有频道发送数据。

示例代码如下，仅供参考：

```c++
agora_rtc_mute_local_audio ("my_first_channel", 1); // Stop sending audio
agora_rtc_mute_local_video ("my_first_channel", 1); // Stop sending video
agora_rtc_mute_local_audio ("my_first_channel", 0); // Start sending audio
agora_rtc_mute_local_video ("my_first_channel", 0); // Start sending video
```

### 接收端

**提示频道内远端用户音视频流发送状态**

发送端调用 `agora_rtc_mute_local_audio` 或 `agora_rtc_mute_local_video` 方法更改本地音视频流传输状态后， SDK 会相应地触发以下回调，提示接收端频道内远端用户是否暂停发送音视频流：

- `on_user_mute_audio`：提示本地用户频道内远端用户是否暂停发送**音频**流。
- `on_user_mute_video`：提示本地用户频道内远端用户是否暂停发送**视频**流。

示例代码如下，仅供参考：

```c++
static void OnUserMuteAudio (const char *channel, uint32_t uid, int muted)
{
	std::cout << __FUNCTION__ << std::endl;
}

static void OnUserMuteVideo (const char *channel, uint32_t uid, int muted)
{
	std::cout << __FUNCTION__ << std::endl;
}

static const agora_rtc_event_handler_t listener = {
	.on_user_mute_audio = OnUserMuteAudio,
	.on_user_mute_video = OnUserMuteVideo,
	// ...
};
```

**暂停/恢复接收远端音视频流**
可调用以下方法暂停或恢复接收指定频道内指定用户的音视频流：

- `agora_rtc_mute_remote_audio`：暂停接收远端**音频**流。
- `agora_rtc_mute_remote_video`：暂停接收远端**视频**流。

> 你既可以通过填写频道名暂停接收指定频道的数据，也可以将 `channel_name` 设置为 null 暂停接收所有频道的数据。

```c++
const uint32_t remote_uid = 666;
agora_rtc_mute_remote_audio ("my_first_channel", remote_uid, 1); // Stop receiving audio from a remote user
agora_rtc_mute_remote_video ("my_first_channel", remote_uid, 1); // Stop receiving video from a remote user
agora_rtc_mute_remote_audio ("my_first_channel", remote_uid, 0); // Start receiving audio from a remote user
agora_rtc_mute_remote_video ("my_first_channel", remote_uid, 0); // Start receiving video from a remote user
```
