---
title: 应用崩溃后对云端录制有什么影响？
platform: ["RESTful"]
updatedAt: 2020-06-04 09:24:38
Products: ["cloud-recording"]
---
集成云端录制的应用崩溃，不会影响录制进程。你仍然可以使用当前录制进程的 resource ID 和录制 ID 控制录制实例，例如查询录制状态或者停止录制。

<div class="alert note">请勿使用相同的 App ID、频道名以及 UID 再次调用 <code>acquire</code> 和 <code>start</code> 方法。该操作会导致报错或创建新的录制实例。</div>