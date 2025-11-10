---
title: 跑通 Livecast 示例项目
platform: Android
updatedAt: 2021-03-31 08:46:36
---

Agora 在 GitHub 上提供开源的互动播客示例项目 [Livecast](https://github.com/AgoraIO-Usecase/InteractivePodcast)。本文介绍如何快速跑通该示例项目，体验 Agora 互动播客。


## 前提条件

- Android Studio 4.0.0 或以上版本。
- Android 4.1 或以上版本的设备。 Agora 推荐使用真机，部分模拟机可能无法支持本项目的全部功能。
- 有效的 [Agora 开发者账号](https://docs.agora.io/cn/AgoraPlatform/sign_in_and_sign_up)。
<div class="alert note">如果你的网络环境部署了防火墙，请参考<a href="https://docs.agora.io/cn/AgoraPlatform/firewall?platform=iOS">应用企业防火墙限制</a>以正常使用 Agora 服务。</div>

## 操作步骤


### 1. 创建 Agora 项目

按照以下步骤，在控制台创建一个 Agora 项目。

1. 登录 [Agora 控制台](https://console.agora.io/)，点击左侧导航栏 ![img](https://web-cdn.agora.io/docs-files/1594283671161) **项目管理**按钮进入**[项目管理](https://dashboard.agora.io/projects)**页面**。 **

2. 在**项目管理**页面，点击**创建**按钮。

   [![img](https://web-cdn.agora.io/docs-files/1594287028966)](https://dashboard.agora.io/projects)

3. 在弹出的对话框内输入**项目名称**，选择**鉴权机制**为 **APP ID。**

4. 点击**提交**，新建的项目就会显示在**项目管理**页中。


### 2. 获取 App ID

Agora 会给每个项目自动分配一个 App ID 作为项目唯一标识。

在 [Agora 控制台](https://console.agora.io/)的**项目管理**页面，找到你的项目，点击 App ID 右侧的眼睛图标就可以直接复制项目的 App ID。

![](https://web-cdn.agora.io/docs-files/1617009204142)

### 3. 获取第三方云存储服务

Agora 提供的互动播客示例项目使用了第三方云存储服务，因此你还需要获取该云存储服务的有关信息。具体步骤如下：

1. 前往[第三方云存储控制台](https://console.leancloud.cn/)注册账号，创建一个新的应用。
2. 应用创建成功后，点击![](https://web-cdn.agora.io/docs-files/1617009267331)> **应用 Keys**，就能看到该应用的 AppID、AppKey 和 REST API 服务器地址。

![img](https://confluence.agoralab.co/download/attachments/721393255/image2021-3-19_17-26-25.png?version=1&modificationDate=1616145985834&api=v2)

### 4. 运行示例项目

按照以下步骤运行示例项目，体验互动播客：
1. 进入你的示例项目文件夹，打开 `strings_config.xml` 文件。
2. 将 `Your App ID` 替换为在第 2 步获取的 Agora App ID。
3. 将 `Your LeanCloud App ID`、`Your LeanCloud App Key`、`Your LeanCloud Server Url` 分别替换为在第 3 步获取的 AppID、AppKey、REST API 服务器地址。
4. 连接 Android 设备，在 Android Studio 中打开示例项目，点击 Sync Project with Gradle Files 按钮同步项目。
5. 点击 Run 按钮运行项目。
6. 运行成功后，你会在设备上看到安装好的 Livecast 应用，打开应用即可体验互动播客。