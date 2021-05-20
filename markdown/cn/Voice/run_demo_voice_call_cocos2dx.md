---
title: 跑通示例项目
platform: Cocos2d-x
updatedAt: 2021-02-18 02:41:54
---
Agrora 在 GitHub 上提供一个开源的示例项目 [Cocos2d-x](https://github.com/AgoraIO-Community/Agora-Cocos-Quickstart/tree/master/Cocos2d-x)，展示如何在 Cocos2d-x 游戏中集成 Agora SDK，实现基础的音视频通话。

本文介绍如何快速跑通该示例项目，体验 Agora 语音通话效果。

## 前提条件

### 开发环境要求

- 如果你的目标平台为 Android, 你的开发环境需要满足以下需求：
  - Android Studio 3.0 及以上。
  - Android 4.1 或以上设备。部分模拟机可能存在功能缺失或者性能问题，所以推荐使用真机。
  - NDK r18b 或以上。
  - cmake。
- 如果你的目标平台为 iOS, 你的开发环境需要满足以下需求：
  - Xcode 9.0 或以上版本 。
  - iOS 8.0 或以上设备。部分模拟机可能存在功能缺失或者性能问题，所以推荐使用真机。

### 其他要求

- Cocos2d-x 3.0 或以上。

  <div class="alert info">本示例项目基于 Cocos2d-x 3.17.2 开发，如果你使用 Cocos2d-x 4.0 或以上版本，请参考 <a href="https://docs.cocos.com/cocos2d-x/v4/manual/zh/upgradeGuide/migration.html">Cocos 官方指南</a >从 v3 升级至 v4。</div>

- 有效的 Agora [开发者账号](/cn/Agora%20Platform/sign_in_and_sign_up?platform=All%20Platforms)。

  <div class="alert note">如果你的网络环境部署了防火墙，请参考<a href="https://docs.agora.io/cn/Agora%20Platform/firewall?platform=All%20Platforms">应用企业防火墙限制</a >以正常使用 Agora 服务。</div>


## 操作步骤

### 1. 创建 Agora 项目

按照以下步骤，在控制台创建一个 Agora 项目。

1. 登录 [Agora 控制台](https://console.agora.io/)，点击左侧导航栏 ![img](https://web-cdn.agora.io/docs-files/1594283671161) **项目管理**按钮进入**[项目管理](https://console.agora.io/projects)**页面**。**

2. 在**项目管理**页面，点击**创建**按钮。

 ![创建项目](https://web-cdn.agora.io/docs-files/1594287028966)

3. 在弹出的对话框内输入**项目名称**，选择**鉴权机制**为 **APP ID + Token。**

4. 点击**提交**，新建的项目就会显示在**项目管理**页中。

### 2. 获取 App ID

Agora 会给每个项目自动分配一个 App ID 作为项目唯一标识。

在 [Agora 控制台](https://console.agora.io/)的**项目管理**页面，找到你的项目，点击 App ID 右侧的眼睛图标就可以直接复制项目的 App ID。

![获取appid](https://web-cdn.agora.io/docs-files/1603974707121)

### 3. 生成临时 Token

为提高项目的安全性，Agora 使用 Token（动态密钥）对即将加入频道的用户进行鉴权。

为了方便测试，Agora 控制台提供生成临时 Token 的功能，具体步骤如下：

1. 在控制台的[项目管理](https://console.agora.io/projects)页面，点击已创建项目的 ![](https://web-cdn.agora.io/docs-files/1574923151660) 图标，打开 **Token** 页面。

	![](https://web-cdn.agora.io/docs-files/1574922827899)

2. 输入一个频道名，例如 test，然后点击**生成临时Token**。临时 Token 的有效期为 24 小时。

	![](https://web-cdn.agora.io/docs-files/1574928082984)

<div class="alert note">临时 Token 仅作为演示和测试用途。在生产环境中，你需要自行部署服务器签发 Token，详见<a href="token_server">生成 Token</a >。</div>

### 4. 配置 App ID 和 Token

下载 [Agora-Cocos-Quickstart](https://github.com/AgoraIO-Community/Agora-Cocos-Quickstart) 仓库至本地，找到 `Agora-Cocos-Quickstart-master/Cocos2d-x` 示例项目文件夹，在 `Classes/HelloWorldScene.h` 文件中填写你从声网控制台获取到的 App ID 和临时 Token。

<div class="alert note">为缩短项目路径，建议你将 <code>Cocos2d-x</code> 示例项目文件夹移到工作磁盘的根目录下。否则，编译 Android 项目时可能会因项目路径过长而失败。</div>

```c++
// 将 <#YOUR APP ID#> 替换成你的 App ID，并加引号，如"xxxxx"。
#define AGORA_APP_ID <#YOUR APP ID#>
// 将 <#YOUR TOKEN#> 替换成你的临时 Token，并加引号，如"xxxxx"。
#define AGORA_TOKEN <#YOUR TOKEN#>
```

### 5. 集成 Agora SDK

参考以下步骤将 Agora 音频 SDK 集成到示例项目中。

**Andriod 平台**

1. 前往 [Agora Android 平台的下载页面](https://docs.agora.io/cn/Voice/downloads?platform=Android)，下载最新版的 Agora 音频 SDK 并解压。

2. 将 SDK 包中 `libs` 文件夹里的如下文件拷贝到示例项目对应的文件夹下：

   | 文件或文件夹             | 项目路径                      |
   | :----------------------- | :---------------------------- |
   | `agora-rtc-sdk.jar` 文件 | `Cocos2d-x/sdk/android/lib`   |
   | `arm-v8a` 文件夹         | `Cocos2d-x/sdk/android/agora` |
   | `armeabi-v7a` 文件夹     | `Cocos2d-x/sdk/android/agora` |
   | `include` 文件夹         | `Cocos2d-x/sdk/android/agora` |
   | `x86 文件夹`             | `Cocos2d-x/sdk/android/agora` |
   | `x86_64` 文件夹          | `Cocos2d-x/sdk/android/agora` |

**iOS 平台**

1. 前往 [Agora iOS 平台的下载页面](https://docs.agora.io/cn/Voice/downloads?platform=iOS)，下载最新版的 Agora 音频 SDK 并解压。

2. 将 `libs` 文件夹下的 `AgoraRtcKit.framework` 和 `AgoraRtcCryptoLoader.framework` 文件夹复制到 `Cocos2d-x/sdk/ios/agora` 文件夹下。

  <div class="alert note">如果你需要支持模拟器，则需要将 <code>libs/ALL_ARCHITECTURE</code> 文件夹下的 <code>AgoraRtcKit.framework</code> 和 <code>AgoraRtcCryptoLoader.framework</code> 文件夹复制到 <code>Cocos2d-x/sdk/ios/agora</code> 文件夹下。该路径下的动态库包含 x86_64 架构，会影响 app 在 App Store 的发布，你需要在将 app 发布至 App Store 前移除 x86_64 架构。</div> 


### 6. 集成 Cocos2d-x 引擎

1. 前往 [Cocos2d-x 下载页面](https://www.cocos.com/cocos2dx)，选择任意版本的 Cocos2d-x 引擎并点击下载。
2. 将解压后所有文件及文件夹复制到示例项目下的 `cocos2d` 文件夹下。

### 7. 编译并运行示例项目

**在 Android 设备上运行**：

1. 开启 Android 设备的开发者选项，打开 USB 调试，通过 USB 连接线将 Android 设备接入电脑。
2. 用 Android Studio 打开 `Cocos2d-x/proj.android` 文件夹。
3. 选择 **File > Project Structure > SDK Location**, 在 **Android NDK Location** 下填入你的 NDK 本地存储路径，点击 **Apply > OK**。
4. 点击 **Sync Project with Gradle Files** 按钮，同步项目。
5. 点击 **Run app** 按钮。

**在 iOS 设备上运行**：

1. 使用 Xcode 打开 `Cocos2d-x/proj.ios_mac/Hello-Cocos2d-Agora.xcodeproj` 文件。
2. 通过 USB 线将 iOS 设备接入你的电脑。
3. 在 Xcode 中，点击 **Build and run** 按钮。

运行成功后，你会在设备上看到如下画面。你可以填入频道名，点击 Join Channel，开始音频通话。

<div class="alert note">确保此处填入的频道名，和生成临时 Token 时填入的频道名是一致的。</div>


![](https://web-cdn.agora.io/docs-files/1606017122027)


## 常见问题

如果你使用的 Cocos2d-x 版本为 3.17.2 且在编译 iOS 项目时遇到 `error: argument value 10880 is outside the valid range [0, 255] [-Wargument-outside-range]` 错误，你可以在示例项目中搜索 `btVector3.h` 文件并做如下修改：

```c++
// 修改前
#define BT_SHUFFLE(x,y,z,w) ((w)<<6 | (z)<<4 | (y)<<2 | (x))
// 修改后
#define BT_SHUFFLE(x,y,z,w) (((w)<< 6 | (z)<< 4 | (y)<< 2 | (x)) & 0xff)
```