---
title: 实现码流传输
platform: Android
updatedAt: 2020-11-24 07:15:14
---
## 初始化和监听事件
在加入频道开始数据传输之前，你需要先调用 `AgoraRtcService.init` 方法初始化 RTD 服务。

在该方法中，你需要：

* 填入获取到的 App ID 和用户 ID。只有 App ID 相同的应用程序才能进入同一个频道进行互通。
* 设置事件回调 AgoraRtcEvents，用以通知 SDK 在运行过程中发生的事件。
* 设置用于存放 SDK 日志的目录（填写 nullptr 表示使用默认目录）。

示例代码如下，仅供参考：

~~~java
private final AgoraRtcEvents event_listener = new AgoraRtcEvents() {
	@Override
	public void onJoinChannelSuccess(String channel, int elapsed) {}

	@Override
	public void onConnectionLost(String channel) {}

	@Override
	public void onRejoinChannelSuccess(String channel, int elapsed) {}

	@Override
public void onWarning(String channel, int war, String msg) {}

	@Override
	public void onError(String channel, int err, String msg) {}

	@Override
	public void onUserJoined(String channel, int uid, int elapsed) {}

	@Override
	public void onUserOffline(String channel, int uid, int elapsed) {}

	@Override
	public void onUserMuteAudio(String channel, int uid, boolean is_muted) {}

	@Override
	public void onUserMuteVideo(String channel, int uid, boolean is_muted) {}

	@Override
	public void onKeyFrameGenReq(String channel, int remote_uid, byte stream_id) {}

	@Override
	public void onAudioData(String channel, int uid, char sent_ts, byte codec, byte[] bytes) {}

	@Override
	public void onVideoData(String channel, int uid, char sent_ts, byte codec, byte stream_id, boolean is_key_frame, byte[] bytes) {}

	@Override
	public void onDecBitrate(String s, int i) {}

	@Override
	public void onIncBitrate(String s, int i) {}
};

private void initSdk() {
	if (isAllPermissionsGranted()) {
		AgoraRtcService.init(AppIdAndCert.APP_ID, 0, event_listener, null);
	}
}
~~~

## 加入频道
调用 `AgoraRtcService.joinChannel `方法加入频道。

在该方法中，你需要：
* 传入能标识频道的频道 ID。输入相同频道 ID 的用户会进入同一个频道。
* 传入能标识用户角色和权限的 Token。如果安全要求不高，使用的是 App ID，可以将该值设为 null。

用户与频道的关系如下：
* 一个频道内的用户可以互相传输数据流。
* 一个用户可以同时加入多个频道。该用户加入的所有频道都能接收到他发送的音视频数据流。

成功加入频道后，SDK 会触发 `onJoinChannelSuccess` 回调。

示例代码如下，仅供参考：

~~~java
private void joinChannel() {
	AgoraRtcService.joinChannel("my_first_channel", null);
}
~~~

## 发送/获取数据流
成功加入频道后，你可以：

* 监听 `AgoraRtcEvents.onAudioData` 方法接收所有你已加入的频道内的音频数据流。
* 监听 `AgoraRtcEvents.onVideoData` 方法接收所有你已加入的频道内视频数据流。
* 调用 `AgoraRtcService.sendAudioData` 方法向指定或所有你已加入的频道发送音频数据流。
* 调用 `AgoraRtcService.sendVideoData` 方法向指定或所有你已加入的频道发送视频数据流。

示例代码如下，仅供参考：

~~~java
private final AgoraRtcEvents event_listener = new AgoraRtcEvents() {
	@Override
	public void onAudioData(String channel, int uid, char sent_ts, byte codec, byte[] bytes) {
		Log.i(Config.TAG, "onAudioData");
	}

	@Override
	public void onVideoData(String channel,
																								int uid,
																								char sent_ts,
																								byte codec,
																								byte stream_id,
																								boolean is_key_frame,
																								byte[] bytes) {
		Log.i(Config.TAG, "onVideoData");
	}
};

AgoraRtcService.sendVideoData(Config.CHANNEL_NAME,
																														Config.VIDEO_CODEC,
																														Config.VIDEO_STREAM_ID,
																														should_be_key,
																														videoFrame);

AgoraRtcService.sendAudioData(Config.CHANNEL_NAME,
																														Config.AUDIO_CODEC,
																														audioFrame);
~~~

## 离开频道
调用 `AgoraRtcService.leaveChannel`  方法离开指定频道，结束在该频道的数据传输。

示例代码如下，仅供参考：

~~~java
private void leaveChannel() {
	AgoraRtcService.leaveChannel("my_first_channel");
}
~~~