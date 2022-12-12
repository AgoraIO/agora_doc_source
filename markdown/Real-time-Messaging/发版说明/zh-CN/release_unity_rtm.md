<div class="alert note">Agora 云信令（原实时消息）的以下功能即将停服，如果你尚未集成该功能，Agora 建议你不要使用：<ul><li>发送和接收图片或文件消息</li><li>历史消息查询</li><li>离线消息缓存</li></ul></div>

## 1.4.10 版

该版本于 2022 年 8 月 17 日发布。

修复了 iOS 上 RTM 和 RTC 同时使用的崩溃问题。


## 已知问题和局限性

SDK 自 1.4.8 版本起对  iOS 15 和 macOS Monterey 12 进行了兼容性适配。对于 1.4.8 以下版本，在 iOS 15 和 macOS Monterey 12 上高概率会发生崩溃。为避免该问题，请务必将 SDK 升级至 1.4.8 或之后版本。

## 1.4.8 版

该版本于 2021 年 8 月 18 日发布。

#### 升级必看

**兼容性变更**

对 iOS 15 和 macOS Monterey 12 进行了兼容性适配。

#### 改进

- 修复了 iOS 15 和 macOS Monterey 12 兼容性适配引发的潜在崩溃问题，提高了 SDK 稳定性。
- 提高了弱网状态下的登录成功率和消息投递成功率。
- 更新 Info.plist 文件内的 SDK 版本信息到最新版本。

#### 问题修复

- 修复了 SDK 内存泄露的问题。
- 修复了一些崩溃问题。


## 1.4.4 版

该版本于 2021 年 4 月 20 日发布。

本次发版为云信令 Unity SDK 的首次发版。你可以参考以下文档集成 SDK，实现相应的实时消息发送和接收功能：

- [快速实现消息发送和接收](https://docs.agora.io/cn/Real-time-Messaging/start_messaging_unity?platform=Unity)
- [API 参考](https://docs.agora.io/cn/Real-time-Messaging/APIReference/RTM_Unity/index.html)

Agora 提供了开源的 [Agora-Unity-RTM-SDK](https://github.com/AgoraIO-Community/Agora-Unity-RTM-SDK/) 示例项目，你也可以前往下载并体验。