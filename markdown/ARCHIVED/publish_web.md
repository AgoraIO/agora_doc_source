---
title: 发布和订阅音视频流
platform: Web
updatedAt: 2019-03-25 18:22:40
---

在发布和订阅音视频流前，请确保你已经实现了[加入频道](./join_video_web)。

## 发布本地流

成功加入频道后，我们就可以创建并发布本地流了。

将以下代码复制粘贴到 `demo.html` 文件中 `// 创建本地流` 下面：

```javascript
localStream = AgoraRTC.createStream({
  streamID: userID,
  audio: true,
  video: true,
  screen: false,
});

// 初始化本地流
localStream.init(
  function () {
    // 播放本地流
    localStream.play("local");
    console.log("getUserMedia successfully");
    // 发布本地流
    client.publish(localStream, function (err) {
      console.log("Publish local stream error: " + err);
    });

    client.on("stream-published", function (evt) {
      console.log("Publish local stream successfully");
    });
  },
  function (err) {
    console.log("getUserMedia failed", err);
  },
);
```

这里需要注意的是要在 [Stream.init](./API%20Reference/web/interfaces/agorartc.stream.html#init) 成功的回调中调用 [Client.publish](./API%20Reference/web/interfaces/agorartc.client.html#publish) 来发布本地流。

## 订阅远端流

当远端流加入频道时，会触发 `stream-added` 事件，我们需要通过 `Client.on` 监听该事件并在回调中订阅新加入的远端流。

> 必须在成功加入频道后开始监听事件。

将以下代码复制粘贴到 `demo.html` 文件中 `// 订阅远端流` 下面：

```javascript
// 监听 stream-added 事件
client.on("stream-added", function (evt) {
  var remoteStream = evt.stream;
  console.log("New stream added: " + remoteStream.getId());
  console.log("Subscribe to ", remoteStream.getId());
  // 在回调中订阅远端流
  client.subscribe(remoteStream, function (err) {
    console.log("Subscribe stream failed", err);
  });
  client.on("stream-subscribed", function (evt) {
    console.log("Subscribed to remote stream successfully: " + remoteStream.getId());
    // 播放远端流
    remoteStream.play("remote");
  });
});
// 当有用户离开通话时
client.on("peer-leave", function (evt) {
  var stream = evt.stream;
  stream.stop("remote");
  alert("User " + stream.getId() + " has left.");
  console.log(evt.uid + " left from this channel");
});
```

现在 demo.html 里 join 的功能已经全部定义完成了，我们还需要加上离开频道的功能，点击左侧菜单栏**快速开始**下的**离开频道**查看具体代码。
