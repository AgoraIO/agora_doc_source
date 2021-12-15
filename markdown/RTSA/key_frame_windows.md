---
title: 关键帧
platform: macOS
updatedAt: 2019-08-15 11:55:40
---

## 功能描述

关键帧是自带全部解码信息的独立视频帧，解码时无需参考其他图像，只需要本帧数据就可以完成。关键帧的设置会影响视频编解码效率和数据空间占用。

## 实现方法

### 发送端

发送端在调用 `agora_rtc_send_video_data` 方法发送视频帧时通过 `is_key_frame` 参数告知 SDK 该视频帧是否为关键帧。

示例代码如下，仅供参考：

```c++
const uint8_t codec_type = 97;
const uint8_t stream_id = 0;
const int is_key = 1;
agora_rtc_send_video_data ("my_first_channel",
                           codec_type,
                           stream_id,
                           is_key,
                           video_data,
                           num_video_data_bytes);
```

发送端长时间没有发送关键帧、关键帧丢失或损坏时，SDK 会通过 `on_key_frame_gen_req` 回调告知发送端为指定的视频流编码一个新的关键帧。

示例代码如下，仅供参考：

```c++
static void OnKeyFrameGenReq (const char *channel, uint32_t remote_uid, uint8_t stream_id)
{
	GetVideoEncoder (channel).Idr (stream_id); // Ask the encoder to do an IDR on the stream
}

static const agora_rtc_event_handler_t listener = {
		.on_key_frame_gen_req = OnKeyFrameGenReq,
		// ...
};
```

### 接收端

接收端解码出错时，可主动调用 `agora_rtc_request_video_key_frame` 方法请求关键帧。

示例代码如下，仅供参考：

```c++
// Ask the remote user with ID 666 to send a key frame for video stream 0
agora_rtc_request_video_key_frame ("my_first_channel", remote_uid, 0);
```

## API 参考

- [`agora_rtc_send_video_data`](./API%20Reference/rtsa_c/agora__rtc__api_8h.html#aa5ad8d63976f32c02984ca5ede1be727)
- [`agora_rtc_request_video_key_frame`](./API%20Reference/rtsa_c/agora__rtc__api_8h.html#ab6b6285057f6f572abbd19b97c0d20b0)
- [`on_key_frame_gen_req`](./API%20Reference/rtsa_c/structagora__rtc__event__handler__t.html#a568bc92359deb1629de443b7bb131301)

## 开发注意事项

为了提升用户体验，我们建议视频编码器定期主动编码关键帧。
