---
title: 如何处理视频大头或黑边问题？
platform: ["Android","iOS","macOS","Windows","Unity","Electron","React Native","Flutter"]
updatedAt: 2020-07-09 21:33:57
Products: ["Video","Interactive Broadcast"]
---
## 步骤 1：自检

这种情况一般是由于视频尺寸与显示视窗尺寸不一致，有下面几种情况：

* 如果是视频宽高和摄像头输出不一致，会在编码前发生裁剪导致视频放大；
* 如果接收端渲染使用的是 hidden 模式，并且视频尺寸与显示视窗尺寸不一致时，会发生裁剪导致视频放大；
* 如果接收端渲染使用的是 fit 模式，并且视频尺寸与显示视窗尺寸不一致时，会发生缩放导致黑边。

## 步骤 2：联系技术支持

如果排除上述几种情况后问题仍存在，请联系技术支持并提供下列信息：

* 发送方的 SDK 日志；
* 发送方如果是手机，检查发送方是横屏还是竖屏；
* 接收方的窗口长宽比。