---
title: 跑通 Agora Live 示例项目
platform: iOS
updatedAt: 2020-12-16 03:01:32
---

## 概览

Agora 在 GitHub 上提供一个开源的 [Agora Live 示例项目](https://github.com/AgoraIO-Usecase/AgoraLive)，演示了如何使用 Agora RTC SDK、Agora RTM SDK 和第三方美颜 SDK，实现基本的单主播、连麦直播、虚拟主播、视频 PK 连麦和电商直播的场景。

本文展示如何编译并运行 iOS 平台的 Agora Live 示例项目，体验各个场景的互动直播。

## 前提条件

开始前，你确保你的开发环境满足如下条件：

- Xcode 10.0 或以上版本。

- Cocoapods。你可以参考 [Getting Started with CocoaPods](https://guides.cocoapods.org/using/getting-started.html#getting-started) 安装。

- iOS 8.0 或以上版本的设备。部分模拟机可能无法支持本项目的全部功能，所以推荐使用真机。

## 操作步骤

### 获取示例项目

前往 GitHub 下载或克隆 [Agora Live 示例项目](https://github.com/AgoraIO-Usecase/AgoraLive)。

### 导入 FaceUnity Bundle 文件

点击下载 [FaceUnity 的 Bundle 文件](https://download.agora.io/components/release/Faceunity.zip)。解压后，将 `Faceunity` 文件夹移动到 `AgoraLive-iOS/Resource` 路径下。

### 导入 FaceUnity 证书文件

联系 [FaceUnity](http://faceunity.com/docs_develop/#/markdown/Demo) 获取一个 `authpack.h` 证书文件，然后将这个 `authpack.h` 文件移动到 `AgoraLive/iOS/Resource/Faceunity` 路径下。

### 安装依赖库

进入 `AgoraLive-iOS/AgoraLive` 路径，运行如下命令链接项目需要的依赖库。

```
pod install
```

如果链接依赖库时间过长，可以将 `AgoraLive-iOS/AgoraLive/Podfile` 中的 `source` 一行按如下方式进行替换，保存后重新运行上述命令添加依赖库。

```
// 替换前
source 'https://github.com/CocoaPods/Specs.git'
// 替换后
source 'https://cdn.cocoapods.org/'
```

### 运行示例项目

1. 使用 Xcode 打开 `AgoraLive-iOS/AgoraLive/AgoraLive.xcworkspace` 文件夹。
2. 通过 USB 线将 iOS 设备接入你的电脑。
3. 在 Xcode 中，点击 **Build and run** 按钮。运行一段时间后，**Agora Live** 应用就安装到 iOS 设备上了。
4. 打开 **Agora Live** 应用，选择自己感兴趣的场景进行体验。
   ![](https://web-cdn.agora.io/docs-files/1604664696370)

## 编译常见问题

在编译示例项目过程中，如果 Xcode 报错 "`Error: Multiple commands produce`"，可以参考如下步骤进行错误排查：

1. 在 Xcode 中，点击 **File** > **Workspace Settings**。
2. 在弹出的面板中，点击 **Shared Workspace Settings** 区域的 **Build System** 框，将 **New Build System (Default)** 切换为 **Legacy Build System**。
