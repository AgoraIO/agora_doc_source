---
title: 如何设置日志？
platform: ["Web"]
updatedAt: 2021-03-22 09:18:26
Products: ["Voice", "Video", "live-streaming", "Interactive Broadcast"]
---

## 开启/关闭日志上传

你可以调用 `enableLogUpload` 方法将 Agora Web SDK 的日志上传到 Agora 的服务器，调用 `disableLogUpload` 方法停止上传。

为保证输出的日志完整，我们建议在创建 `Client` 前就调用 `enableLogUpload` 方法开启日志上传服务。

如果没有成功加入频道，则服务器上无法查看日志信息。

## 设置日志输出等级

你可以调用 `setLogLevel` 方法设置日志的输出等级。选择一个级别，你就可以看到在该级别及之前所有级别的日志信息。

按照输出日志最全到最少排列：

- DEBUG：输出所有 API 日志信息
- INFO：输出 INFO、WARNING 和 ERROR 级别的日志信息
- WARNING：输出 WARNING 和 ERROR 级别的日志信息
- ERROR：输出 ERROR 级别的日志信息
- NONE：不输出日志信息

## 示例代码

根据你使用的 Web SDK 版本查看示例代码。

### Web SDK 3.x

```js
// Javascript
// 开启日志上传功能
AgoraRTC.Logger.enableLogUpload();
// 将日志输出级别设置为 INFO
AgoraRTC.Logger.setLogLevel(AgoraRTC.Logger.INFO);
```

### Web SDK 4.x

```js
// Javascript
// 开启日志上传功能
AgoraRTC.enableLogUpload();
// 将日志输出级别设置为 INFO
AgoraRTC.setLogLevel(1);
```

## API 参考

### Web SDK 3.x

- [`enableLogUpload`](https://docs.agora.io/cn/Interactive%20Broadcast/API%20Reference/web/modules/agorartc.logger.html#enablelogupload)
- [`disableLogUpload`](https://docs.agora.io/cn/Interactive%20Broadcast/API%20Reference/web/modules/agorartc.logger.html#disablelogupload)
- [`setLogLevel`](https://docs.agora.io/cn/Interactive%20Broadcast/API%20Reference/web/modules/agorartc.logger.html#setloglevel)

### Web SDK 4.x

- [`enableLogUpload`](https://docs.agora.io/cn/Interactive%20Broadcast/API%20Reference/web_ng/interfaces/iagorartc.html#enablelogupload)
- [`disableLogUpload`](https://docs.agora.io/cn/Interactive%20Broadcast/API%20Reference/web_ng/interfaces/iagorartc.html#disablelogupload)
- [`setLogLevel`](https://docs.agora.io/cn/Interactive%20Broadcast/API%20Reference/web_ng/interfaces/iagorartc.html#setloglevel)
