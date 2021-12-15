---
title: 如何处理视频黑屏问题？
platform: ["Android", "iOS", "macOS", "Web", "Windows", "Unity", "微信小程序", "Electron", "React Native", "Flutter"]
updatedAt: 2021-01-05 04:44:29
Products: ["Video", "Interactive Broadcast"]
---

## 问题描述

常见的视频黑屏问题有以下三种情况：

- 本地视频黑屏远端视频正常。
- 本地视频正常远端视频黑屏。
- 本地远端视频都黑屏。

## 问题原因

可能出现黑屏的原因有很多，其中最重要的原因是：

- Token 出错。当你在加入频道前设置了本地或远端用户视图，但用户加入频道失败，如 Token 传值有误，那么本地预览的本地或远端用户视图会出现黑屏。
- 网络问题：如果本地网络连接很差或者中断，就会看不到其他用户的视频。如果通话中有一方的网络出现问题，其他人也看不到这个用户的视频。
- 用户主动关闭了视频，也会出现黑屏。

## 解决方案

### 步骤 1：自检

首先确认 Token 是否正确设置。你可以参考 FAQ：[如何处理 Token 相关错误码](https://docs.agora.io/cn/All/faq/token_error)进行问题排查。

如果确认 Token 无误，你可以参考如下步骤进行自检。
<a name="localblack"></a>
**本地视频黑屏远端视频正常**

这种情况一般是摄像头故障或者被占用等原因导致本地视频采集出现问题，请按以下步骤排查：

- 摄像头硬件问题。打开系统自带的拍摄视频程序看是否可以录像，如果不行，需要换摄像头。
- 如果摄像头没有问题，看下摄像头权限有没有打开。Android 和 iOS 系统都有权限管理，请在系统设置中检查。
   <div class="alert note"><ul><li>开通 Android 权限详见<a href="https://docs.agora.io/cn/Interactive%20Broadcast/start_live_android?platform=Android#添加项目权限">添加项目权限</a >和<a href="https://docs.agora.io/cn/Interactive%20Broadcast/start_live_android?platform=Android#3-获取设备权限">获取设备权限</a >。</li><li>开通 iOS 权限详见<a href="https://docs.agora.io/cn/Interactive%20Broadcast/start_live_ios?platform=iOS#添加媒体设备权限">添加媒体设备权限</a >。</li></ul></div>

- 是否有其他应用占据了摄像头。关闭其他应用然后打开我们的应用测试；重启手机再测试。
- 检查是否是用户禁用了本地视频。
- 如果是自采集，需要确认外部采集数据是否有问题。

**本地视频正常远端视频黑屏**

这种情况可能是远端采集问题或者本地下行网络原因导致，请按以下步骤排查：

- 检查用户是否禁用了远端视频。
- 如果没有禁用远端视频，建议更换网络看下是否还存在问题来排除网络原因。
- 检查是否远端用户使用[媒体流加密](https://docs.agora.io/cn/Video/channel_encryption_windows?platform=Windows)功能，但本地用户未使用。
- 检查远端用户能否在自己的设备上看到自己的画面。如果看不到，则是远端用户的视频问题。请参考<a href="#localblack">本地视频黑屏远端视频正常</a>中的步骤来排查问题。

**本地远端视频都黑屏**

这种情况可能是渲染出现问题或者没有启用视频，请按以下步骤排查：

- 检查是否有调用 `enableVideo` 方法启用视频。
- 检查是否有禁用本地及远端视频。
- 如果上述都没有问题，可能是渲染问题，Windows 端检查 SDK 日志，看渲染方式（render type）是什么。如果是 D2D 渲染，很可能是显卡驱动不是最新，建议去显卡官网更新显卡至最新版。如果更新完官方驱动还是不行，建议走设置 GDI 渲染方式，即加入频道前调用下面的方法：
  - `AParameter apm(*pRTCEngine);`
  - `nRet = apm->setInt("che.video.renderer.type", 9);`
- 如果是自渲染，需要确认渲染方式是否有问题。
- 检查是否使用了纯音频 SDK，而没有使用视频 SDK。
- 检查本地和远端视图是否设置正确，如视图的宽高是否均不为 0，视频显示窗口是否被黑色视图遮挡。

### 步骤 2：联系技术支持

如果按照上述步骤没有解决问题，请收集下面的信息并联系技术支持：

- 已经做过的排查步骤及结果。
- 出现黑屏时，发送端和接收端的 UID。
- 黑屏用户的 UID。
- 黑屏的具体时间段。
- SDK 日志文件，参考[如何设置日志文件](https://docs.agora.io/cn/faq/logfile)。

### 步骤 3：水晶球监控通话质量

你可以使用 Agora 控制台中的[水晶球](https://dashboard.agora.io/analytics/call/search)功能对通话质量进行跟踪和反馈，详见[水晶球教程](https://docs.agora.io/cn/Agora%20Platform/aa_guide?platform=All%20Platforms)。
