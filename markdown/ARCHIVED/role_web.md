---
title: 切换用户角色
platform: Web
updatedAt: 2020-12-30 09:01:40
---

在切换用户角色前，请确保你已完成环境准备、安装包获取等步骤，详见[客户端集成](/cn/Interactive%20Broadcast/web_prepare)。

## 实现方法

Web 平台通过如下 3 个接口控制用户角色的切换：

- `client.publish`：发布本地音视频流

  ```javascript
  client.publish(localStream, function (err) {
    console.log("Publish local stream error: " + err);
  });

  client.on("stream-published", function (evt) {
    console.log("Publish local stream successfully");
  });
  ```

- `client.unpublish`：取消发布本地音视频流

  ```javascript
  client.unpublish(localStream, function (err) {
    console.log("Unpublish local stream error: " + err);
  });

  client.on("stream-unpublished", function (evt) {
    console.log("Unpublish local stream successfully");
  });
  ```

- `client.subscribe`：订阅远端音视频流

  ```javascript
  client.on("stream-added", function (evt) {
    var stream = evt.stream;
    console.log("New stream added: " + stream.getId());

    client.subscribe(stream, function (err) {
      console.log("Subscribe stream failed", err);
    });
  });
  client.on("stream-subscribed", function (evt) {
    var remoteStream = evt.stream;
    console.log("Subscribe remote stream successfully: " + remoteStream.getId());
    remoteStream.play("agora_remote" + remoteStream.getId());
  });
  ```

各接口与角色切换关系如下：

- 设置用户角色为主播：

  - `client.publish`
  - `client.subscribe`

- 用户角色由主播切换为观众：

  - `client.unpublish`

- 设置用户角色为观众：

  - `client.subscribe`

- 用户角色由观众切换为主播：

  - `client.publish`

> 在调用 `client.publish` 发布本地音视频流前，需要先创建并初始化音视频流，详见 [发布或订阅音视频流](/cn/Interactive%20Broadcast/publish_web_live) 中的描述。

## 相关文档

直播频道中的用户角色切换为主播后，可以使用 Agora SDK，实现如下功能进行互动直播：

- [发布和订阅音视频流](/cn/Interactive%20Broadcast/publish_web_live)

如果在直播过程中，对音量、音效、视频分辨率等有特殊需求，你还可以：

- [调整通话音量](/cn/Interactive%20Broadcast/volume_web)
- [播放音效/音乐混音](/cn/Interactive%20Broadcast/effect_mixing_web)
- [设置视频属性](/cn/Interactive%20Broadcast/videoProfile_web)
