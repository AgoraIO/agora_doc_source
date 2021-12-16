---
title: 为什么在调用 Stream.init 时设备会报错？
platform: ["Web"]
updatedAt: 2020-12-23 08:07:05
Products: ["Voice","Video","Interactive Broadcast","live-streaming"]
---
以下为初始化音视频流时常见的设备错误：

- `NotAllowedError`: 用户拒绝授予对应的摄像头或麦克风权限。
- `NotReadableError`: 尽管用户已经授权使用相应的设备，操作系统、浏览器或者网页层面发生的硬件错误导致该设备无法被访问。你可以尝试刷新页面或者更新设备驱动。部分 Windows 10 笔记本电脑上使用 Chrome 浏览器时，需要以兼容 Windows 7 的模式运行 Chrome 才能使用摄像头。
- `NotFoundError`: 找不到指定的媒体流。检查你的麦克风和摄像头是否正常工作。
- `MEDIA_NOT_SUPPORT`：没有使用 HTTPS 协议。如果需要打开摄像头，请务必使用 HTTPS 协议或者 localhost。
- `OverConstrainedError`：某个指定的采集参数无法被任何可用设备满足，一般是由于采集设备被占用或者不支持指定的分辨率。

更多的错误请参考 [`Stream.init`](https://docs.agora.io/cn/Interactive%20Broadcast/API%20Reference/web/v3.3.1/interfaces/agorartc.client.html#init) 中的描述。