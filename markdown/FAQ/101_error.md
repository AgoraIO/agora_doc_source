---
title: 为什么云端录制 SDK 会返回 101 错误？
platform: ["RESTful"]
updatedAt: 2020-07-09 21:21:57
Products: ["cloud-recording"]
---
日志文件中报错 `"ErrorUint32":101`，一般为 Token 错误引起，可能有以下几种原因：

- Token 填写错误
- Token 过期
- Native/Web SDK 使用了 Token，云端录制未使用
- 云端录制使用了 Token，Native/Web SDK 未使用