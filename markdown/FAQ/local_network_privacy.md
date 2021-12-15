---
title: 为什么在运行集成 RTC SDK 的 iOS app 时会看到查找本地网络设备的弹窗提示？
platform: ["iOS"]
updatedAt: 2020-12-18 03:21:00
Products: ["Voice", "Video", "Interactive Broadcast", "Audio Broadcast"]
---

## 问题描述

iOS 系统版本升级至 14.0 版本后，用户首次使用集成了声网 iOS 语音或视频 SDK 的 app 时会看到查找本地网络设备的弹窗提示。默认弹窗界面如下图所示：

![](https://web-cdn.agora.io/docs-files/1599798269838)

## 问题原因

iOS 14.0 版本新增了关于本地网络设备的隐私权限，app 需要向用户获取 **Privacy - Local Network Usage Description** 权限，才能访问用户的本地网络设备。

3.1.2 之前版本的 iOS 语音或视频 SDK 会检测客户端与用户本地网关连通质量，并通过 [`reportRtcStats`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:reportRtcStats:) 的 [`gatewayRtt`](./API%20Reference/oc/Classes/AgoraChannelStats.html#//api/name/gatewayRtt) 参数报告客户端到本地路由器的往返延时。iOS 系统将该连通性检测判断为查找本地网络设备。因此，虽然 app 不会连接用户本地网络上的任何设备，但用户首次使用 app 时会看到查找本地网络设备的弹窗提示。

## 解决方案

### 方案 1. 使用 3.1.2 及以上版本 SDK

声网在 3.1.2 版 iOS SDK 中关闭了本地网络连通质量报告功能，如果你的业务不依赖该功能，声网建议你选择此方案。

在你的 app 中集成 3.1.2 及以上版本 SDK，用户使用 app 时就不会看到查找本地网络设备的弹窗提示。自 3.1.2 版本起，`reportRtcStats` 的 `gatewayRtt` 参数会失效（值恒为 `-1`），请不要使用该参数获取客户端到本地路由器的往返延时。

### 方案 2. 修改项目权限描述

如果你的业务需要获取客户端到本地路由器的往返延时，声网建议你选择此方案。

在你的 app 中集成 3.1.2 以下版本 SDK，用户在 iOS 14.0 设备上首次使用 app 时看到的弹窗提示默认为：**此 App 将可发现和连接到您所用网络上的设备**。声网建议你结合你的业务需求修改弹窗提示内容，修改步骤如下：

1. 打开 Xcode 项目，在 `info.plist` 文件中，点击 **+** 图标添加 **Privacy - Local Network Usage Description**。

 <div class="alert info">在 Xcode 11 中，你需要添加 <b>NSLocalNetworkUsageDescription</b>。</div>

2. 结合你的业务需求，在 **Privacy - Local Network Usage Description** 的 **Value** 栏中填写获取本地网络设备权限的目的。例如：**此 app 不会连接到您所用网络上的设备，只会检测与您本地网关的连通性**。
   ![](https://web-cdn.agora.io/docs-files/1599798333919)

修改后，用户首次使用 app 时收到的弹窗界面如下图所示：
![](https://web-cdn.agora.io/docs-files/1599798346549)

- 如果用户点击**好**，app 可以通过 `reportRtcStats` 的 `gatewayRtt` 参数获取客户端到本地路由器的往返延时。
- 如果用户点击**不允许**，`reportRtcStats` 的 `gatewayRtt` 参数会失效（值恒为 `-1`），app 无法通过该参数获取客户端到本地路由器的往返延时。

用户也可以在 iOS 设备的**设置->隐私->本地网络**界面修改 app 的权限设置。

## 相关链接

- [Privacy - Local Network Usage Description](https://developer.apple.com/documentation/bundleresources/information_property_list/nslocalnetworkusagedescription)
- [Support local network privacy in your app](https://developer.apple.com/videos/play/wwdc2020/10110/)
