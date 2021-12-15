---
title: 如何监听频道内用户的麦克风和摄像头状态？
platform:
  [
    "Android",
    "iOS",
    "macOS",
    "Web",
    "Windows",
    "Linux",
    "Unity",
    "微信小程序",
    "Cocos Creator",
    "Electron",
    "React Native",
    "Flutter",
  ]
updatedAt: 2020-05-11 14:28:42
Products: ["Voice", "Video", "Interactive Broadcast", "Real-time-Messaging"]
---

## 简介

使用 Agora RTC SDK 实现音视频通话或直播时，若需监听频道内用户的麦克风和摄像头状态，你还需要使用 Agora RTM SDK。

## 实现方法

你可以使用 Agora RTM SDK 的如下功能进行监听：

- 用户属性：监听频道内指定用户的麦克风和摄像头状态
- 频道属性：监听频道内所有用户的麦克风和摄像头状态

### 监听指定用户

1. 加入频道后，调用 `addOrUpdateLocalUserAttributes` 添加或更新本地用户的麦克风和摄像头属性。
2. 调用 `getUserAttributesByKeys` 获取频道内指定用户的麦克风和摄像头属性，从而获知麦克风和摄像头的状态。

### 监听所有用户

1. （此步骤仅适用于 Linux/Windows C++ 平台，其他平台可跳过）加入频道后，调用 `createChannelAttribute` 创建并返回一个 `IRtmChannelAttribute` 实例。

<div class="alert note">获取麦克风和摄像头状态后，需调用 <tt>release</tt> 释放 <tt>IRtmChannelAttribute</tt> 实例。</div>

2. 调用 `addOrUpdateChannelAttributes` 添加或更新指定频道内所有用户的麦克风和摄像头属性。
3. 调用 `getChannelAttributesByKeys` 获取指定频道内所有用户的麦克风和摄像头属性，从而获取麦克风和摄像头的状态。

## 相关链接

详细的集成步骤及 API 描述，请参考以下文档：

- [RTM 快速开始](https://docs.agora.io/cn/Real-time-Messaging/messaging_android?platform=Android)
- [RTM 用户属性相关 API 参考](https://docs.agora.io/cn/Real-time-Messaging/API%20Reference/RTM_java/index.html#attributes)
- [RTM 频道属性相关 API 参考](https://docs.agora.io/cn/Real-time-Messaging/API%20Reference/RTM_java/index.html#channelattributes)
