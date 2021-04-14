---
title: 小程序 SDK 相关
platform: 小程序 SDK 相关
updatedAt: 2019-12-10 12:21:13
---
### 推流/拉流处理

推流/拉流处理可以参考或直接使用 [GitHub 上开源代码](https://github.com/AgoraIO/Agora-Miniapp-Tutorial)。

### 退后台处理

可以通过设置小程序的 live-pusher 组件中的 waiting-image 属性来处理。设置后，推流端退到后台时，可以推送静态图片来维持推流，其他端会收到本端预设的 waiting-image 图片来代替视频流。 除非通过一些方式 (例如后台播放背景音乐)，小程序会在某些场景下断开 websocket 或者 rtmp 连接，例如点击右上角按钮将程序退到后台。这种情况下，若回到前台后收到 error code 904 或 501，则应使用 SDK 进行重连，具体方法请参考 重新加入频道 rejoin 中的描述。

### 只启用小程序的音频功能，不需要发送视频，应该如何设置？

直接使用微信小程序的接口处理即可。在小程序的 live-pusher 组件中，通过设置 enable-camera 来实现开启/关闭摄像头。详见 [小程序 live-pusher 组件文档](https://developers.weixin.qq.com/miniprogram/dev/component/live-pusher.html)。

### 小程序和 Native 互通有问题？

在使用小程序 SDK 过程中，请确保已在 Native 端调用如下接口完成设置，否则可能会出现无法互动，Native 端听不到小程序声音等问题：
请调用设置用户角色 `setClientRole`，并将 Role 设置为 AgoraClientRoleBroadcaster = 1：主播；

### 小程序和 Web 互通时，Web 端可以看到小程序的视频，但小程序看不到 Web 端的视频？

Web 与小程序互通时，Web 端只支持 H264 模式的编码，不支持 VP8。将 Web SDK 的 `index.html` 文件修改为如下设置即可：
`client = AgoraRtc.createClient({mode: 'h264_interop'})`；

### 小程序的 live-pusher 组件里的 src 应该写什么？

客户端调用 client.publish 方法后，会回调一个以 rtmp 开头的临时地址，这个地址就分别是 live-player 和 live-pusher 组件中的 rtmp 播放地址 和 rtmp 推流地址。

### 集成小程序 SDK 时，如何打开和保存日志？

调用如下 API 实现保存和打开日志：

* 保存日志：
```
AgoraMiniappSDK.LOG.onlog = (text) => {
  Utils.log(text);
};
```

* 打开日志：
`AgoraMiniappSDK.LOG.setLogLevel(-1)`;

### 出现客户端初始化失败之后，该如何做?

1. 退出后重新加入频道；
2.  如果步骤 1 无法生效，请换台设备试试；
3. 如果步骤 2 仍旧无效，请联系客户支持。

### 出现错误码

Agora Miniapp SDK for WeChat 在调用 API 或运行时，可能会返回一个错误码对象，也可能会返回一个错误码。详细可以参考 [错误码和警告码](./the_error_wechat) 进行排查。