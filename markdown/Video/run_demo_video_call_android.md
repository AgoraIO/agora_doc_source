---
title: 跑通示例项目
platform: Android
updatedAt: 2021-02-18 02:42:10
---

## 概览

Agora 在 GitHub 上提供一个开源的一对一视频通话示例项目 [Agora-Android-Tutorial-1to1](https://github.com/AgoraIO/Basic-Video-Call/tree/master/One-to-One-Video/Agora-Android-Tutorial-1to1)。本文介绍如何快速跑通该示例项目，体验 Agora 视频通话效果。

如果你是第一次使用声网的服务，我们推荐观看下面的视频，了解关于声网服务的基本信息以及如何快速跑通示例项目。

<video src="https://web-cdn.agora.io/docs-files/1584613510967" poster="https://web-cdn.agora.io/docs-files/1597911141441"   controls width = 100% height = auto>你的浏览器不支持 <code>video</code> 标签。</video>

<div class="alert note">视频中展示的 UI 可能有部分调整更新，请以当前最新版为准。</div>

## 前提条件

- 开发环境要求：
  - [Java Development Kit](https://www.oracle.com/java/technologies/javase-downloads.html)
  - Android Studio 3.0 及以上
- 如果你的网络环境部署了防火墙，请根据[应用企业防火墙限制](https://docs.agora.io/cn/Agora%20Platform/firewall?platform=Android)打开相关端口。
- 一台真实的 Android 设备。部分模拟机可能存在功能缺失或者性能问题，所以推荐使用真机。
- 有效的 Agora [开发者账号](https://docs.agora.io/cn/Agora%20Platform/sign_in_and_sign_up)。

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

2. 输入一个频道名，例如 test，然后点击**生成临时 Token**。临时 Token 的有效期为 24 小时。加入频道时，请确保填入的频道名与生成临时 Token 时填入的频道名一致。

   ![](https://web-cdn.agora.io/docs-files/1574928082984)

<div class="alert note">临时 Token 仅作为演示和测试用途。在生产环境中，你需要自行部署服务器签发 Token，详见<a href="token_server">生成 Token</a >。</div>

<div class="alert note">对于本示例项目，请将频道名设为 demoChannel1。</div>
 
 ### 4. 配置示例项目

参考以下步骤配置示例项目：

1. 克隆 [Basic-Video-Call](https://github.com/AgoraIO/Basic-Video-Call) 仓库至本地。
2. 找到 Basic-Video-Call/One-to-One-Video/Agora-Android-Tutorial-1to1 示例项目文件夹，在 `app/src/main/res/values/strings.xml` 文件中填写你从声网控制台获取到的 App ID 和临时 Token。

```java
// 把 <#YOUR APP ID#> 替换成你的 App ID，字符串格式
<string name="agora_app_id"><#YOUR APP ID#></string>
// 把 <#YOUR ACCESS TOKEN#> 替换成你的临时 Token，字符串格式
<string name="agora_access_token"><#YOUR ACCESS TOKEN#></string>
```

### 5. 集成 Agora SDK

按照以下步骤将 Agora 视频通话 SDK 集成到示例项目中。

1. 下载最新版[视频通话 Android SDK](https://docs.agora.io/cn/Video/downloads?platform=Android) 并解压。

2. 将 SDK 包中 `libs` 文件夹下如下文件拷贝到示例项目对应的文件夹下：

   | 文件或文件夹           | 项目路径               |
   | :--------------------- | :--------------------- |
   | agora-rtc-sdk.jar 文件 | /app/libs/             |
   | arm-v8a 文件夹         | /app/src/main/jniLibs/ |
   | armeabi-v7a 文件夹     | /app/src/main/jniLibs/ |
   | x86 文件夹             | /app/src/main/jniLibs/ |
   | x86_64 文件夹          | /app/src/main/jniLibs/ |

### 6. 编译并运行示例项目

连接上 Android 设备后，用 Android Studio 打开 Agora-Android-Tutorial-1to1 示例项目，然后编译并运行示例项目。

运行成功后，你会在 Android 设备上看到如下画面。

![](https://web-cdn.agora.io/docs-files/1606203935417)

你已默认加入了 demoChannel1 频道。如果想体验一对一视频通话效果，你可以通过声网的 [Web 端示例应用](https://webdemo.agora.io/agora-web-showcase/examples/Agora-Web-Tutorial-1to1-Web/)，输入相同的 App ID、频道名和临时 Token，加入同一频道与 Android 端互通。
