---
title: 动态码率推荐
platform: Android
updatedAt: 2019-08-15 11:55:45
---

## 功能描述

为提升数据传输量和避免网络拥塞，RTD 会根据网络带宽状况的变化建议开发者实时调整发送码率。

有以下两种情况：

- 网络拥塞时，SDK 会触发 `onDecBitrate` 回调，建议某频道应该降低编码码率。收到此回调后，发送端应该降低给定的码率。
- 网络状况良好时，SDK 会触发 `onIncBitrate` 回调，建议某频道应该升高编码码率。收到此回调后，发送端应该提高给定的码率。

## 实现方法

以下为示例代码，仅供参考：

```java
final public static int VIDEO_TARGET_BPS_MAX = 1 << 23; // 8Mbps
final public static int VIDEO_TARGET_BPS_MIN = 1 << 16; // 64Kbps

static int checkTargetBps(int bps) {
	// Make sure the target bps is valid
	if (bps > VIDEO_TARGET_BPS_MAX) {
		bps = VIDEO_TARGET_BPS_MAX;
	} else if (bps < VIDEO_TARGET_BPS_MAX) {
		bps = VIDEO_TARGET_BPS_MIN;
	}
	return bps;
	}

private final AgoraRtcEvents event_listener = new AgoraRtcEvents() {
	@Override
	public void onDecBitrate(String s, int i) {
		VideoEncoder video_encoder = getVideoEncoder(channel);
		final int target_bps = checkTargetBps(video_encoder.getTargetBps() - bps);
		video_encoder.setTargetBps(target_bps);
	}

	@Override
	public void onIncBitrate(String s, int i) {
		VideoEncoder video_encoder = getVideoEncoder(channel);
		final int target_bps = checkTargetBps(video_encoder.getTargetBps() + bps);
		video_encoder.setTargetBps(target_bps);
	}

	// ...
};
```

## 开发注意事项

- 这两个回调返回的是 bps，不要和 kbps 及 Bps 混淆。
- 这两个回调只表明网络好坏：`inc_bitrate` 表示网络可用带宽充足，可以增加编码码率；`dec_bitrate `表示网络可用带宽不够，应该减少编码码率。开发者应该自行控制码率上限和下限，确保码率不过大或过小。
