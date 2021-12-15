---
title: 跑通示例项目
platform: Web
updatedAt: 2020-12-23 11:44:15
---

## 概览

Agora 在 GitHub 上提供一个开源的[一对一视频通话示例项目](https://github.com/AgoraIO/Basic-Video-Call/tree/master/One-to-One-Video/Agora-Web-Tutorial-1to1)，本文介绍如何快速跑通该示例项目，体验 Agora 视频通话效果。 你也可以直接观看我们的视频教程。

## 快速跑通示例项目

如果你是第一次使用声网的服务，我们推荐观看下面的视频，了解关于声网服务的基本信息以及如何快速跑通示例项目。

<div class="alert info">点击参与<a href="https://www.wenjuan.com/s/7FbeEz6/" target="_blank">视频教程问卷调查</a>，帮助我们改进体验。</div>

<video src="https://web-cdn.agora.io/docs-files/1599190966315" poster="https://web-cdn.agora.io/docs-files/1599191154523"   controls width = 100% height = auto>你的浏览器不支持 <code>video</code> 标签。</video>

<div class="alert note">视频中展示的 UI 可能有部分调整更新，请以当前最新版为准。</div>

## 前提条件

- 可以连接到互联网的 Windows 或 macOS 计算机。如果你的网络环境部署了防火墙，请参考[应用企业防火墙限制](https://docs.agora.io/cn/Agora%20Platform/firewall)以正常使用 Agora 服务。
- 计算机搭载 2.2 GHz Intel 第二代 i3/i5/i7 处理器或同等性能的其他处理器。
- 内置摄像头或外置 USB 摄像头。
- 安装最新稳定版 [Chrome 浏览器](https://www.google.cn/chrome/)。
- 有效的 Agora [开发者账号](https://docs.agora.io/cn/Agora%20Platform/sign_in_and_sign_up)。

## 操作步骤

### 1. 创建 Agora 项目

按照以下步骤，在控制台创建一个 Agora 项目。

1. 登录 [Agora 控制台](https://console.agora.io/)，点击左侧导航栏 ![img](https://web-cdn.agora.io/docs-files/1594283671161) **项目管理**按钮进入**[项目管理](https://dashboard.agora.io/projects)**页面**。**

2. 在**项目管理**页面，点击**创建**按钮。

![创建项目](https://web-cdn.agora.io/docs-files/1594287028966)

3. 在弹出的对话框内输入**项目名称**，选择**鉴权机制**为 **APP ID + Token。**

4. 点击**提交**，新建的项目就会显示在**项目管理**页中。

### 2. 获取 Agora 项目的 App ID

Agora 会给每个项目自动分配一个 App ID 作为项目唯一标识。

在 [Agora 控制台](https://console.agora.io/)的**项目管理**页面，找到你的项目，点击 App ID 右侧的眼睛图标就可以直接复制项目的 App ID。

![获取appid](https://web-cdn.agora.io/docs-files/1603974707121)

<div class="alert info">你需要在运行示例项目时填写 App ID。</div>

### 3. 生成临时 Token

为提高项目的安全性，Agora 使用 Token（动态密钥）对即将加入频道的用户进行鉴权。

为了方便测试，Agora 控制台提供生成临时 Token 的功能，具体步骤如下：

1. 在控制台的**项目管理**页面，点击已创建项目的 ![](https://web-cdn.agora.io/docs-files/1574923151660) 图标，打开 **Token** 页面。

   ![](https://web-cdn.agora.io/docs-files/1574922827899)

2. 输入一个频道名，例如 test，然后点击**生成临时 Token**。临时 Token 的有效期为 24 小时。

   ![](https://web-cdn.agora.io/docs-files/1574928082984)

<div class="alert note">临时 Token 仅作为演示和测试用途。在生产环境中，你需要自行部署服务器签发 Token，详见<a href="token_server">生成 Token</a >。</div>

<div class="alert info">你需要在运行示例项目时填写临时 Token。</div>

### 4. 集成 Agora SDK

按照以下步骤将 Agora SDK 集成到示例项目中。

1. 下载 [Basic-Video-Call](https://github.com/AgoraIO/Basic-Video-Call) 仓库，找到 Agora-Web-Tutorial-1to1 示例项目文件夹（位于 Basic-Video-Call/One-to-One-Video 目录下）。
2. 下载最新版[视频通话 Web SDK](https://docs.agora.io/cn/Agora Platform/downloads) 并解压。
3. 将 SDK 包中以 `AgoraRTCSDK` 开头的 `.js` 文件复制到 Agora-Web-Tutorial-1to1 示例项目的 `assets` 文件夹下，并重命名为 `AgoraRTCSDK.js`。

### 5. 运行示例项目

按照以下步骤运行示例项目，开始视频通话：

1. 在 Chrome 浏览器中打开示例项目中的 `index.html` 文件，你会看到 **Basic Communication** 页面：
   ![basic communication index](https://web-cdn.agora.io/docs-files/1605176227661)
2. 按照上文步骤获取 App ID、生成临时 Token，并在该页面填入，在 Channel 栏填入用于生成临时 Token 的频道名。
3. 点击 **JOIN**，浏览器会弹出对话框要求麦克风和摄像头权限，点击**允许**，即可在页面上看到本地的视频画面。
4. 如果想体验双人视频通话效果，可以在浏览器中复制当前标签页，输入相同的 App ID、频道名和 Token 并点击 **JOIN**。

如果页面没有正常工作，可以打开浏览器的控制台查看错误信息进行排查。常见的错误信息包括：

- `INVALID_VENDOR_KEY`：App ID 或 Token 错误，检查你填写的 App ID 及 Token。
- `DYNAMIC_USE_STATIC_KEY`：你的 Agora 项目启用了 App 证书，需要在加入频道时填写 Token。
- `Media access:NotFoundError`：检查你的摄像头和麦克风是否正常工作。

## 示例项目结构

下表列出示例项目的代码结构，你可以参考示例项目的代码，根据自己的需求进行调整。

| 文件/文件夹         | 描述                                                 |
| :------------------ | :--------------------------------------------------- |
| `index.html`        | 项目前端页面及实现主要功能的代码。                   |
| `assets/common.css` | 页面样式代码。                                       |
| `vendor`            | 该文件夹中均为用于实现项目样式和布局的第三方库文件。 |

## 相关链接

除本文介绍的示例项目外，我们在 GitHub 上还提供以下开源的视频通话示例项目供你参考：

- [Agora-Web-Tutorial-1to1-Webpack](https://github.com/AgoraIO/Basic-Video-Call/tree/master/One-to-One-Video/Agora-Web-Tutorial-1to1-Webpack)
- [Agora-Web-Tutorial-1to1-Vue](https://github.com/AgoraIO/Basic-Video-Call/tree/master/One-to-One-Video/Agora-Web-Tutorial-1to1-Vue)
- [Agora-Web-Tutorial-1to1-React](https://github.com/AgoraIO/Basic-Video-Call/tree/master/One-to-One-Video/Agora-Web-Tutorial-1to1-React)
- [OpenVideoCall](https://github.com/AgoraIO/Basic-Video-Call/tree/master/Group-Video/OpenVideoCall-Web)
