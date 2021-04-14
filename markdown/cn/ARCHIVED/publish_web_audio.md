---
title: 发布和订阅音频流
platform: Web
updatedAt: 2018-12-11 15:27:46
---
# 发布或订阅音频流
## 创建音频流
使用 `AgoraRTC.createStream` 方法创建音频流对象。

示例代码中设置了以下参数：

- `streamID`：音视频流 ID。设置为用户 ID （uid），可通过 `client.join` 的回调获取。
- `audio`: 是否开启音频。
- `video`: 是否开启视频。
- `screen`: 是否开启屏幕共享功能。请勿将 `video` 和 `screen` 同时设置为 true 。

```javascript
var localStream = AgoraRTC.createStream({
    streamID: uid,
    audio: true,
    video: false,
    screen: false}
);
```

## 初始化音频流
接下来调用 `stream.init` 方法初始化创建的音频流。

```javascript
localStream.init(function() {
  console.log("getUserMedia successfully");
  localStream.play('agora_local');

}, function (err) {
  console.log("getUserMedia failed", err);
});
```


## 发布本地音频流
初始化完成后，在成功的回调中通过 `client.publish` 方法发布音频流。

```javascript
client.publish(localStream, function (err) {
  console.log("Publish local stream error: " + err);
});

client.on('stream-published', function (evt) {
  console.log("Publish local stream successfully");
});
```

## 订阅远端音频流
订阅远端音频流步骤如下：

1. 监听 `client.on('stream-added')` 事件, 当有人发布音频流到频道里时，会收到该事件。
2. 收到事件后，在回调中调用 `client.subscribe` 方法订阅远端音频流。

```javascript
client.on('stream-added', function (evt) {
  var stream = evt.stream;
  console.log("New stream added: " + stream.getId());

  client.subscribe(stream, function (err) {
    console.log("Subscribe stream failed", err);
  });
});
client.on('stream-subscribed', function (evt) {
  var remoteStream = evt.stream;
  console.log("Subscribe remote stream successfully: " + remoteStream.getId());
  remoteStream.play('agora_remote' + remoteStream.getId());
})
```

## 播放音频流
在初始化流成功和订阅流成功后，都可以在回调中调用 `stream.play` 在页面上播放流。 `stream.play` 接受一个 dom 元素的 id 作为参数，SDK 会在这个 dom 下面创建一个 `<video>` 标签并播放音频。

- 初始化流成功时，播放本地流

	```javascript
localStream.init(function() {
	console.log("getUserMedia successfully");
	// 这里使用agora_local作为dom元素的id。
	localStream.play('agora_local');
}, function (err) {
	console.log("getUserMedia failed", err);
});
	```

- 订阅流成功时，播放远端流

	```javascript
client.on('stream-subscribed', function (evt) {
	var remoteStream = evt.stream;
	console.log("Subscribe remote stream successfully: " + remoteStream.getId());
	// 这里使用agora_remote + remoteStream.getId()作为dom元素的id。
	remoteStream.play('agora_remote' + remoteStream.getId());
})
	```