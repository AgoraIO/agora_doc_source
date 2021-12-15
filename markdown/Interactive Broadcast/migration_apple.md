---
title: 升级至 3.0.1 版本 (iOS/macOS)
platform: iOS
updatedAt: 2021-02-03 06:25:43
---

本文描述 Agora iOS SDK 和 Agora macOS SDK 从旧版本升级到 3.0.1 版本时，用户需要注意的集成方法变更。

## 重要变更

自 3.0.1 版本起，下载的 SDK 内仅包含动态库 **AgoraRtcKit.framework**。各版本库文件区别如下：

| SDK 版本     | 库名              | 库类型         |
| ------------ | ----------------- | -------------- |
| 3.0.1 及以上 | AgoraRtcKit       | 动态库         |
| 3.0.0        | AgoraRtcKit       | 动态库、静态库 |
| 3.0.0 以下   | AgoraRtcEngineKit | 静态库         |

## 从 3.0.0 静态库版本升级到 3.0.1 版本

<div class="alert note">如果你使用的是 3.0.0 动态库版本 SDK，则无需重新集成 SDK。</div>

- 复制 3.0.1 版本 SDK 的 **AgoraRtcKit.framework** 文件至项目路径下，替换 3.0.0 版本 SDK 的静态库文件。
- 打开 Xcode（以 Xcode 11.0 为例），进入 **TARGETS > Project Name > General > Frameworks, Libraries, and Embedded Content** 菜单，并点击 **-** 移除以下库文件：

<table>
     <tr>
         <td>操作系统</td>
         <td>库文件</td>
      </tr>
     <tr>
         <td>iOS</td>
         <td><li>Accelerate.framework<li>AudioToolbox.framework<li>AVFoundation.framework<li>CoreMedia.framework<li>libc++.tbd<li>libresolv.tbd<li>SystemConfiguration.framework<li>CoreTelephony.framework（仅音频）<li>CoreML.framework（仅视频）<li>VideoToolbox.framework（仅视频）</li></td>
     </tr>
     <tr>
         <td>macOS</td>
         <td><li>Accelerate.framework<li>CoreWLAN.framework<li>libc++.tbd<li>libresolv.9.tbd
<li>SystemConfiguration.framework<li>VideoToolbox.framework（仅视频）</li></td>
     </tr>
 </table>

- 将 **AgoraRtcKit.framework** 文件状态改为 **Embed & Sign**。

## 从 3.0.0 之前版本升级到 3.0.1 版本

- 打开 Xcode（以 Xcode 11.0 为例），在项目导航栏中移除 **AgoraRtcEngineKit.framework** 库文件。
- 进入 **TARGETS > Project Name > General > Frameworks, Libraries, and Embedded Content** 菜单，点击 **-** 移除以下库文件：

<table>
    <tr>
        <td>操作系统</td>
        <td>库文件</td>
    </tr>
    <tr>
        <td>iOS</td>
        <td><li>AgoraRtcEngineKit.framework<li>Accelerate.framework<li>AudioToolbox.framework<li>AVFoundation.framework<li>CoreMedia.framework<li>libc++.tbd<li>libresolv.tbd<li>SystemConfiguration.framework<li>CoreTelephony.framework（仅音频）<li>CoreML.framework（仅视频）<li>VideoToolbox.framework（仅视频）</li></td>
    </tr>
    <tr>
        <td>macOS</td>
        <td><li>AgoraRtcEngineKit.framework<li>Accelerate.framework<li>CoreWLAN.framework<li>libc++.tbd<li>libresolv.9.tbd
<li>SystemConfiguration.framework<li>VideoToolbox.framework（仅视频）</li></td>
    </tr>
</table>

- 点击 **+** 添加 **AgoraRtcKit.framework** 文件，再点击 **Add Other…**，找到本地动态库文件打开，并将文件状态改为 **Embed & Sign**。
