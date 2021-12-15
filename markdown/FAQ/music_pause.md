---
title: 为什么 Android 设备上挂断系统电话后音乐文件不会自动恢复播放？
platform: ["Android"]
updatedAt: 2021-02-04 08:55:54
Products: ["Voice", "Video", "Interactive Broadcast", "live-streaming", "Audio Broadcast"]
---

## 问题描述

在 Android 设备上调用 `startAudioMixing` 方法播放音乐文件，播放过程中使用系统自带的电话软件接听或者拨打了电话，挂断电话后音乐文件没有自动恢复播放。

## 问题原因

SDK 无法判断系统电话是否结束使用音频输出设备，所以音乐文件不会自动恢复播放。

## 解决方案

调用 `startAudioMixing` 方法后，建议使用安卓原生方法 `PhoneStateListener` 监听电话事件，并执行以下步骤：

1. 接听或拨打电话时，调用 `getAudioMixingCurrentPosition` 方法获取音乐文件的播放进度。
2. 挂断电话后，重新调用 `startAudioMixing` 方法播放音乐文件，再调用 `setAudioMixingPosition` 方法恢复到之前的播放进度。
