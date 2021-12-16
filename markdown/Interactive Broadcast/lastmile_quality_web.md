---
title: 通话前检测网络质量
platform: Web
updatedAt: 2020-12-30 09:02:04
---
<div class="alert note">本文仅适用于 Agora Web SDK 3.x 版本。</div>

## 功能描述

在正式开始通话前进行网络质量探测，可以判断或预测用户当前的网络状况是否良好，可以满足音频码率或者当前选定的视频属性的目标码率。

在对网络质量要求高的场景下，Agora 建议在加入频道前进行探测，保证通信顺畅。

## 实现方法

开始检测网络质量前，请确保你已在项目中实现了基本的音视频通信或直播功能。详见[开始音视频通话](start_call_web)或[开始互动直播](start_live_web)。

在正式加入频道前，你可以在本地创建两个 Client，然后创建两路流，进入一个测试用的频道。其中一路流用来测上行网络的连接状况，另一路测下行网络的连接状况。
- 调用 `Stream.publish` 方法发布一路流后，你可以调用 `getStats` 方法获取上行网络连接数据 `LocalStreamStats`。你可以通过 `LocalStreamStats` 中 `accessDelay` 的值大致判断上行网络的质量：
	- [0,100) 上行网络质量好
	- [100,200) 上行网络质量较差
	- ≧ 200 上行网络质量很差
- 调用 `Stream.subscribe` 成功订阅第二路流后，你也可以调用 `getStats` 方法获取下行网络连接数据 `RemoteStreamStats`。你可以通过 `RemoteStreamStats` 中 `accessDelay` 的值大致判断下行网络的质量：
	- [0,200) 下行网络质量好
	- [200,400) 下行网络质量较差
	- ≧ 400 下行网络质量很差

### API 调用时序

参考如下时序在你的项目中进行通话前网络质量探测。

![](https://web-cdn.agora.io/docs-files/1569477203196)


### 示例代码

参考下文示例代码在你的项目中进行通话前网络质量探测。

```javascript
localStream.getStats((stats) => {
    console.log(`Local Stream accessDelay: ${stats.accessDelay}`);
    console.log(`Local Stream audioSendBytes: ${stats.audioSendBytes}`);
    console.log(`Local Stream audioSendPackets: ${stats.audioSendPackets}`);
    console.log(`Local Stream audioSendPacketsLost: ${stats.audioSendPacketsLost}`);
    console.log(`Local Stream videoSendBytes: ${stats.videoSendBytes}`);
    console.log(`Local Stream videoSendFrameRate: ${stats.videoSendFrameRate}`);
    console.log(`Local Stream videoSendPackets: ${stats.videoSendPackets}`);
    console.log(`Local Stream videoSendPacketsLost: ${stats.videoSendPacketsLost}`);
    console.log(`Local Stream videoSendResolutionHeight: ${stats.videoSendResolutionHeight}`);
    console.log(`Local Stream videoSendResolutionWidth: ${stats.videoSendResolutionWidth}`);
});


remoteStream.getStats((stats) => {
    console.log(`Remote Stream accessDelay: ${stats.accessDelay}`);
    console.log(`Remote Stream audioReceiveBytes: ${stats.audioReceiveBytes}`);
    console.log(`Remote Stream audioReceiveDelay: ${stats.audioReceiveDelay}`);
    console.log(`Remote Stream audioReceivePackets: ${stats.audioReceivePackets}`);
    console.log(`Remote Stream audioReceivePacketsLost: ${stats.audioReceivePacketsLost}`);
    console.log(`Remote Stream endToEndDelay: ${stats.endToEndDelay}`);
    console.log(`Remote Stream videoReceiveBytes: ${stats.videoReceiveBytes}`);
    console.log(`Remote Stream videoReceiveDecodeFrameRate: ${stats.videoReceiveDecodeFrameRate}`);
    console.log(`Remote Stream videoReceiveDelay: ${stats.videoReceiveDelay}`);
    console.log(`Remote Stream videoReceiveFrameRate: ${stats.videoReceiveFrameRate}`);
    console.log(`Remote Stream videoReceivePackets: ${stats.videoReceivePackets}`);
    console.log(`Remote Stream videoReceivePacketsLost: ${stats.videoReceivePacketsLost}`);
    console.log(`Remote Stream videoReceiveResolutionHeight: ${stats.videoReceiveResolutionHeight}`);
    console.log(`Remote Stream videoReceiveResolutionWidth: ${stats.videoReceiveResolutionWidth}`);
});
```

同时，我们在 GitHub 提供一个开源的 [Agora-WebRTC-Troubleshooting](https://github.com/AgoraIO/Tools/tree/master/TroubleShooting/Agora-WebRTC-Troubleshooting) 示例项目。你可以[在线体验](https://webdemo.agora.io/agora_webrtc_troubleshooting/)，或者查看 [App.Vue](https://github.com/AgoraIO/Tools/blob/master/TroubleShooting/Agora-WebRTC-Troubleshooting/src/App.vue) 文件中的源代码。

### API 参考

- [`getStats`](./API%20Reference/web/interfaces/agorartc.stream.html#getstats)
- [`LocalStreamStats`](./API%20Reference/web/interfaces/agorartc.localstreamstats.html)
- [`RemoteStreamStats`](./API%20Reference/web/interfaces/agorartc.remotestreamstats.html)

## 开发注意事项

- 一个 Client 只能发布一路流，因此你需要创建两个 Client。
- 调用 `getStats` 方法获取的网络连接统计数据，部分可能存在延迟。
- 由于浏览器限制，`LocalStreamStats` 和 `RemoteStreamStats` 数据的某些字段可能会缺失。