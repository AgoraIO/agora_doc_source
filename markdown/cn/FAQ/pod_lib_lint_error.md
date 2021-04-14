---
title: 为什么使用 CocoaPods 集成 iOS SDK 后运行 pod lib lint 命令报错？
platform: ["iOS"]
updatedAt: 2021-03-17 07:01:18
Products: ["Voice","Video","Interactive Broadcast","live-streaming"]
---
## 问题描述

在 Xcode 12 或之后版本的环境中，如果你使用 CocoaPods 集成 3.3.0 或之后版本 iOS SDK，运行 `pod lib lint` 命令时，你可能会收到如下报错：

```shell
[iOS] xcodebuild: warning: [CP] Unable to find matching .xcframework slice in ' true ios-armv7_arm64/AgoraRtcKit.framework ios-x86_64-simulator/AgoraRtcKit.framework' for the current build architectures (arm64 x86_64).
```

## 问题原因

CocoaPods 未兼容 Xcode 12 和之后版本，所以无法在项目中链接 `.xcframework` 库。

## 解决方案

你可以按照如下步骤解决该问题：

1. 安装 Xcode 12 之前版本（以 Xcode 11 为例）。

2. 在终端运行如下命令切换 Xcode 版本。

 ```shell
 // 把 <xcode_path> 替换成 Xcode 11 所在路径。
 sudo xcode-select -s <xcode_path>
 ```

3. 运行 `pod lib lint` 命令检查是否成功链接 `.xcframework` 库。