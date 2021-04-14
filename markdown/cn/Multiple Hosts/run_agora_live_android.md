---
title: 跑通 Agora Live 示例项目
platform: Android
updatedAt: 2020-12-16 03:49:29
---
## 概览

Agora 在 GitHub 上提供一个开源的 [Agora Live 示例项目](https://github.com/AgoraIO-Usecase/AgoraLive)，演示了如何使用 Agora RTC SDK、Agora RTM SDK 和第三方美颜 SDK，实现基本的单主播、连麦直播、虚拟主播、视频 PK 连麦和电商直播的场景。

本文展示如何编译并运行 Android 平台的 Agora Live 示例项目，体验各个场景的互动直播。

## 前提条件

开始前，请确保你的开发环境满足如下条件：

- Android Studio 3.0 或以上版本。

- Android 4.1 或以上版本的设备。部分模拟机可能无法支持本项目的全部功能，所以推荐使用真机。


## 操作步骤

### 获取示例项目

前往 GitHub 下载或克隆 [Agora Live 示例项目](https://github.com/AgoraIO-Usecase/AgoraLive)。

### 接入 FaceUnity SDK

1. 下载 [FaceUnity SDK v6.4](https://github.com/Faceunity/FULiveDemoDroid/releases/download/v6.4/Faceunity-Android-v6.4.zip) 官方包。如果因网络等原因无法下载，也可以点击[此处](https://download.agora.io/components/release/Faceunity-Android-v6.4.zip)下载。
2. 解压下载的 SDK 包，然后将 SDK 包中的下列文件，添加到示例项目对应的文件路径下：

| SDK 文件                         | 项目路径                                     |
| :------------------------------- | :------------------------------------------- |
| `/FaceUnity/Android/assets`        | `AgoraLive-Android/faceunity/src/main/assets`  |
| `/FaceUnity/Android/jniLibs`       | `AgoraLive-Android/faceunity/src/main/jniLibs` |
| `/FaceUnity/Android/libs/nama.jar` | `AgoraLive-Android/faceunity/libs`             |

###  替换 FaceUnity 证书

联系 [FaceUnity](http://www.faceunity.com/) 获取一个名为 `authpack.java` 的证书文件，然后使用它替换 `AndroidLive-Android/faceunity/src/main/java/com/faceunity/authpack.java` 文件。

### 获取虚拟形象资源

如果你想要体验或实现虚拟主播场景，还需要点击[这里](https://download.agora.io/demo/release/AgoraLiveVirtualImage.zip)下载并获取 FaceUnity 的虚拟形象资源。

解压下载后的资源包，并将如下文件拷贝到示例项目的 `Agora-Live/faceunity/app/src/main/assets` 路径下：

- `bg.bundle`
- `girl.bundle`
- `hashiqi.bundle`

### 运行示例项目

1. 开启 Android 设备的开发者选项，通过 USB 连接线将 Android 设备接入电脑。
2. 用 Android Studio 打开 `AndroidLive-Android` 文件夹。
3. 在 Android Studio 中，点击 **Sync Project with Gradle Files** 按钮，同步项目。
4. 点击 **Run app** 按钮。运行一段时间后，**Agora Live** 应用就安装到 Android 设备上了。
5. 打开 **Agora Live** 应用，选择自己感兴趣的场景进行体验。
 ![](https://web-cdn.agora.io/docs-files/1604664409591)