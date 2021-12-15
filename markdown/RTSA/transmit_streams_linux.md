---
title: 实现码流传输
platform: Linux
updatedAt: 2021-03-31 06:38:18
---

本页介绍实现码流传输涉及的 API 方法和调用流程。

## 初始化和监听事件

首先，调用 `agora_rtc_init` 方法初始化 RTSA 服务。

在该方法中，你需要：

- 设置 `app_id` 参数，传入你获取到的 App ID。了解[获取 App ID](./demo_guide_windows?platform=Windows#创建-agora-账号并获取-app-id)。
- 设置 `uid` 参数传入用户 ID。为 32 位整型，取值范围为 1 到 2<sup>32</sup> - 1。0 是无效的 `uid`，如果将 `uid` 设为 0，系统将自动分配一个 UID。
- 设置 `event_handler` 参数，设置事件回调 `agora_rtc_event_handler_t`，用以通知 SDK 在运行过程中发生的事件。
- 设置 `sdk_log_dir` 参数，用于存放 SDK 日志。如填写 `nullptr`，则使用默认目录，即应用程序的当前工作目录。

示例代码如下，仅供参考：

```c++
static void OnJoinChannelSuccess (const char *channel, int elapsed) {}
static void OnConnectionLost (const char *channel) {}
static void OnRejoinChannelSuccess (const char *channel, int elapsed) {}
static void OnWarning (const char *channel, int war, const char *msg) {}
static void OnError (const char *channel, int err, const char *msg) {}
static void OnUserJoined (const char *channel, uint32_t uid, int elapsed) {}
static void OnUserOffline (const char *channel, uint32_t uid, int reason) {}
static void OnUserMuteAudio (const char *channel, uint32_t uid, int muted) {}
static void OnUserMuteVideo (const char *channel, uint32_t uid, int muted) {}
static void OnKeyFrameGenReq (const char *channel, uint32_t remote_uid, uint8_t stream_id) {}
static void OnAudioData (const char *channel, const uint32_t uid, uint16_t sent_ts, uint8_t codec, const void *data, size_t data_len) {}
static void OnVideoData (const char *channel, const uint32_t uid, uint16_t sent_ts, uint8_t codec, uint8_t stream_id, int is_key_frame, const void *data, size_t data_len) {}
static void OnDecBitrate (const char *channel, uint32_t bps) {}
static void OnIncBitrate (const char *channel, uint32_t bps) {}

static const agora_rtc_event_handler_t listener = {
	.on_join_channel_success = OnJoinChannelSuccess,
	.on_connection_lost = OnConnectionLost,
	.on_rejoin_channel_success = OnRejoinChannelSuccess,
	.on_warning = OnWarning,
	.on_error = OnError,
	.on_user_joined = OnUserJoined,
	.on_user_offline = OnUserOffline,
	.on_user_mute_audio = OnUserMuteAudio,
	.on_user_mute_video = OnUserMuteVideo,
	.on_key_frame_gen_req = OnKeyFrameGenReq,
	.on_audio_data = OnAudioData,
	.on_video_data = OnVideoData,
	.on_dec_bitrate = OnDecBitrate,
	.on_inc_bitrate = OnIncBitrate,
};

agora_rtc_init ("My APP ID", 111, &listener, nullptr)
```

## 加入频道

初始化后，调用 `agora_rtc_join_channel` 方法加入频道。

我们把一个客户端比作一栋大楼的话，频道就好比大楼里面的一个房间。频道是由你调用 API 时在客户端创建，第一个用户加入时自动创建频道，最后一个用户离开时频道会自动销毁，无需维护。

用户与频道的关系如下：

- 一个频道内的用户可以互相传输数据流。
- 一个用户可以同时加入多个频道。该用户加入的所有频道都能接收到他发送的音视频数据流。

加入频道时，你需要：

- 设置 `channel` 参数。这是频道名，是频道的唯一标识。长度在 64 字节以内的字符串。以下为支持的字符集范围（共 89 个字符）：
  - 26 个小写英文字母 a-z
  - 26 个大写英文字母 A-Z
  - 10 个数字 0-9
  - 空格
  - "!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "\_", "{", "}", "|", "~", ","
- 设置 `token` 和 `len` 参数，用于设置能标识用户角色和权限的 Token 及其大小。这就好比加入房间所需要的钥匙或门卡。Agora 提供两种鉴权机制：App ID 和 token。详见[校验用户权限](https://docs.agora.io/cn/Agora%20Platform/token?platform=All%20Platforms)。如果安全要求不高，使用 App ID 作为鉴权机制，可将 `token` 设为 nullptr，`len` 设为 0。

成功加入频道后，SDK 会触发 `on_join_channel_success` 回调。

示例代码如下，仅供参考：

```c++
agora_rtc_join_channel ("my_first_channel", nullptr, 0);
```

## 发送/接收数据流

成功加入频道后，可以：

- 调用 `agora_rtc_send_audio_data` 方法向指定频道或所有你已加入的频道发送音频数据流。
- 调用 `agora_rtc_send_video_data` 方法向指定频道或所有你已加入的频道发送视频数据流。
- 监听 `on_audio_data` 回调接收所有你已加入的频道内的音频数据流。
- 监听 `on_video_data` 回调接收所有你已加入的频道内的视频数据流。

示例代码如下，仅供参考：

```c++
static void OnAudioData (const char *channel,
                         const uint32_t uid,
                         uint16_t sent_ts,
                         uint8_t codec,
                         const void *data,
                         size_t data_len)
{
	std::cout << __FUNCTION__ << std::endl;
	// ...
}

static void OnVideoData (const char *channel,
                         const uint32_t uid,
                         uint16_t sent_ts,
                         uint8_t codec,
                         uint8_t stream_id,
                         int is_key_frame,
                         const void *data,
                         size_t data_len)
{
	std::cout << __FUNCTION__ << std::endl;
	// ...
}

static const agora_rtc_event_handler_t listener = {
		.on_audio_data = OnAudioData,
		.on_video_data = OnVideoData,
		// ...
};

agora_rtc_send_audio_data ("my_first_channel",
                           2,
                           audio_frame,
                           num_audio_frame_bytes);

agora_rtc_send_video_data ("my_first_channel",
                           3,
                           0,
                           1,
                           video_frame,
                           num_video_frame_bytes);
```

## 离开频道

调用 `agora_rtc_leave_channel` 方法离开指定频道，结束在该频道的数据传输。

示例代码如下，仅供参考：

```c++
agora_rtc_leave_channel ("my_first_channel")
```
