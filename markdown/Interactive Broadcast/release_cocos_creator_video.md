---
title: 发版说明
platform: Cocos Creator
updatedAt: 2020-12-15 09:24:22
---

本文提供 Agora Cocos Creator SDK 的发版说明。

## 1.3.1_3.1 版

该版本于 2020 年 12 月 9 日发布，适配了 Agora Android SDK v3.1.3 和 Agora iOS SDK v3.1.2。

#### 新增特性

**1. 多平台支持**

该版本支持在 Android 和 iOS 平台中集成 Agora 视频 SDK。

**2. AgoraVideoRender 云组件**

该版本新增 AgoraVideoRender 云组件，用于渲染本地或远端视频。

#### 改进

**1. Agora RTC 服务**

该版本将服务名称由 **Agora Voice** 改为 **Agora RTC**。开通 Agora RTC 服务后，你可以根据需要选择使用 Agora 音频 SDK（**Audio**）或 Agora 视频 SDK（**Video**）。

![](https://web-cdn.agora.io/docs-files/1608023088621)

**2. 加密库**

该版本在 Agora RTC 服务面板中新增**是否加密**选项，支持灵活集成加密库。该版本默认不集成加密库，如需使用加密功能，你需要勾选**是否加密**。

#### 问题修复

该版本修复了如下问题：

- 部分回调导致 app 崩溃的问题。
- 偶现的内存泄露问题。

#### 新增文档

为帮助你快速实现视频通话和视频直播，该版本新增如下示例项目及文档：

- [视频通话](https://github.com/AgoraIO-Community/Agora-Cocos-Quickstart/tree/master/CocosCreator)示例项目
- [实现视频通话](./start_call_cocos_creator)
- [实现视频互动直播](./start_live_cocos_creator)
- [API 参考](./API%20Reference/cocos_creator/index.html)

## 1.2.1_3.1.2 版

该版本于 2020 年 10 月 30 日发布。

#### 主要特性

**1. 平台支持**

该版本支持在 Android、iOS 和 Web 平台中集成 Agora 音频 SDK。

**2. 支持与 Web 互通**

该版本自动开启与 Agora Web SDK 的互通。

**3. 加密**

该版本支持加密功能，你可以对音频流进行加密。

**4. 云代理服务**

该版本支持使用云代理服务，方便部署企业防火墙的用户正常使用 Agora 的服务。

**5. 区域访问限制**

该版本支持 `initWithAreaCode` 方法，你可以在初始化 Agora 引擎时指定服务器的访问区域。该功能为高级设置，适用于有访问安全限制的场景。目前支持的区域有中国大陆、北美、欧洲、亚洲（中国大陆除外）、日本、印度和全球（默认）。

#### 相关文档

你可以参考以下文档集成 SDK，实现相应的实时音频功能：

- [实现语音通话](./start_call_audio_cocos_creator)或[实现音频互动直播](./start_live_audio_cocos_creator)
- [API 参考](./API%20Reference/cocos_creator/index.html)

Agora 提供了开源的 [Voice-Call-for-Mobile-Gaming](https://github.com/AgoraIO/Voice-Call-for-Mobile-Gaming/tree/master/Basic-Voice-Call-for-Gaming/Hello-CocosCreator-Voice-Agora) 示例项目，你可以前往下载并体验。
