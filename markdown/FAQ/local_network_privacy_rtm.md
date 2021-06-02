---
title: 为什么在运行集成声网 RTM SDK 的 iOS app 时会看到查找本地网络设备的弹窗提示？
platform: ["iOS"]
updatedAt: 2020-12-18 03:24:07
Products: ["Real-time-Messaging"]
---
## 问题现象

iOS 系统版本升级至 14.0 版本后，用户使用集成了声网 RTM SDK 的 app 时会看到查找本地网络设备的弹窗提示。默认弹窗界面如下图所示：

![](https://web-cdn.agora.io/docs-files/1599798269838)

## 问题原因

iOS 14.0 版本新增了关于本地网络设备的隐私权限，app 需要向用户获取 **Privacy - Local Network Usage Description** 权限，才能访问用户的本地网络设备。RTM SDK 会通过域名访问 Agora 服务器，当终端设备使用的域名解析服务器处于同一网段时，会触发弹窗。

## 解决方案

### 方案 1. 使用 1.4.1 及以上版本 RTM SDK

1.4.1 修复了 RTM SDK 在 iOS 14.0 版本的弹窗提示问题。修复之后，弹窗不会出现，RTM 服务可用性也不会受到影响。

### 方案 2. 修改项目权限描述

用户在 iOS 14.0 设备上运行 app 时看到的弹窗提示默认为：**此 App 将可发现和连接到您所用网络上的设备**。声网建议你结合你的业务需求修改弹窗提示内容，修改步骤如下：

1. 打开 Xcode 项目，在 `info.plist` 文件中，点击 **+** 图标添加 **Privacy - Local Network Usage Description**。

 <div class="alert info">在 Xcode 11 中，你需要添加 <b>NSLocalNetworkUsageDescription</b>。</div>

2. 结合你的业务需求，在 **Privacy - Local Network Usage Description** 的 **Value** 栏中填写获取本地网络设备权限的目的。例如：此 app 不会连接到您所用网络上的设备，只会检测与您本地网关的连通性。
 ![](https://web-cdn.agora.io/docs-files/1599798333919)
	 
修改后，用户使用 app 时收到的弹窗界面如下图所示：
![](https://web-cdn.agora.io/docs-files/1599798346549)


- 如果用户点击**好**， app 可以通过本地路由器的域名查询结果获得更多 RTM 服务节点。
- 如果用户点击**不允许**， app 不会通过本地路由器进行域名查询来获得额外的 RTM 服务节点，但也不会对 RTM 服务可用性造成明显影响。


## 相关链接

- [Privacy - Local Network Usage Description](https://developer.apple.com/documentation/bundleresources/information_property_list/nslocalnetworkusagedescription)
- [Support local network privacy in your app](https://developer.apple.com/videos/play/wwdc2020/10110/)