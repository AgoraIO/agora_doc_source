---
title: 为什么用 Unity 组件播放背景音乐会无声？
platform: ["Unity"]
updatedAt: 2020-03-09 10:12:26
Products: ["Voice", "Video", "Interactive Broadcast"]
---

## 问题描述

在 iOS 设备中，用 Unity 组件（AudioSource 和 AudioClip）播放背景音乐，你可能会遇到以下问题：

- 加入频道前可以听见背景音乐，但加入频道后听不见。
- 加入频道后可以听见背景音乐，但离开频道后听不见。

## 问题原因

当你在频道外使用 Unity 组件播放背景音乐时，系统的 `AudioSession` 为 `active` 状态。在你加入频道或离开频道后，Agora Unity SDK 会将系统的 `AudioSession` 改为 `deactive` 状态，所以你在加入频道或离开频道后无法听到背景音乐。

## 解决方案

在加入频道前调用 `mRtcEngine.SetParameters("{\"che.audio.keep.audiosession\":true}");` 接口，保证系统的 `AudioSession` 状态不被改变。之后，即使你多次进出频道，也都能听到背景音乐。
