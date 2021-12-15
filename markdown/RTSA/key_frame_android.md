---
title: 关键帧
platform: Android
updatedAt: 2019-08-15 11:55:33
---

## 功能描述

关键帧是自带全部解码信息的独立视频帧，解码时无需参考其他图像，只需要本帧数据就可以完成。关键帧的设置会影响视频编解码效率和数据空间占用。

## 实现方法

### 发送端

发送端在调用 `sendVideoData` 方法发送视频帧时通过 `is_key` 参数告知 SDK 该视频帧是否为关键帧。

示例代码如下，仅供参考：

```java
final byte codec_type = 97;
final byte stream_id = 0;
final boolean is_key = true;
AgoraRtcService.sendVideoData("my_first_channel",
                              codec_type,
                              stream_id,
                              is_key,//Whether or not the video frame is a keyframe
                              video_data);
```

发送端长时间没有发送关键帧、关键帧丢失或损坏时，SDK 会通过 `onKeyFrameGenReq` 回调告知发送端为指定的视频流编码一个新的关键帧。

示例代码如下，仅供参考：

```java
private final AgoraRtcEvents event_listener = new AgoraRtcEvents() {
	@Override
	public void onKeyFrameGenReq(String channel, int remote_uid, byte stream_id) {
	// Ask the encoder to do an IDR on the specified stream
	getVideoEncoder(channel).idr(stream_id);
	}

	// ...
};
```

### 接收端

接收端解码出错时，可主动调用 `requestVideoKeyFrame` 方法请求关键帧。

示例代码如下，仅供参考：

```java
// Ask the remote user with ID 666 to send a key frame for video stream 0
AgoraRtcService.requestVideoKeyFrame("my_first_channel", 666, 0);
```

## API 参考

- [`sendVideoData`](./API%20Reference/rtsa_java/classio_1_1agora_1_1rtc_1_1_agora_rtc_service.html#a2a142857573c94612b73317dc48bee62)
- [`requestVideoKeyFrame`](./API%20Reference/rtsa_java/classio_1_1agora_1_1rtc_1_1_agora_rtc_service.html#acfb7b14a40cb2b68ff2ef3a96c4c68a2)
- [`onKeyFrameGenReq`](./API%20Reference/rtsa_java/interfaceio_1_1agora_1_1rtc_1_1_agora_rtc_events.html#afd8655f5ae07f86253d0f553e2518aba)

## 开发注意事项

为了提升用户体验，我们建议视频编码器定期主动编码关键帧。
