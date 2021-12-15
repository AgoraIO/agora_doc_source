---
title: 跑通示例项目
platform: Web
updatedAt: 2020-12-23 13:01:53
---

## 概览

Agora 在 GitHub 上提供一个开源的[视频互动直播示例项目](https://github.com/AgoraIO/Basic-Video-Broadcasting/tree/master/OpenLive-Web)，本文介绍如何快速跑通该示例项目，体验 Agora 视频互动直播效果。

同时，你可以通过我们的[在线 Web 应用](https://webdemo.agora.io/agora-web-showcase/examples/OpenLive-Web/#/)快速体验 Agora 实现的互动直播效果。

## 前提条件

- 可以连接到互联网的 Windows 或 macOS 计算机。如果你的网络环境部署了防火墙，请参考[应用企业防火墙限制](https://docs.agora.io/cn/Agora%20Platform/firewall)以正常使用 Agora 服务。
- 计算机搭载 2.2 GHz Intel 第二代 i3/i5/i7 处理器或同等性能的其他处理器。
- 内置摄像头或外置 USB 摄像头。
- 安装最新稳定版 [Chrome 浏览器](https://www.google.cn/chrome/)。
- 有效的 Agora [开发者账号](https://docs.agora.io/cn/Agora%20Platform/sign_in_and_sign_up)。
- [Node.js LTS](https://nodejs.org/zh-cn/download/)（长期支持版）。

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

1. 下载 [Basic-Video-Broadcasting](https://github.com/AgoraIO/Basic-Video-Broadcasting) 仓库，找到 OpenLive-Web 示例项目文件夹。
2. 在命令行中进入 OpenLive-Web 目录。
3. 运行 `npm install` 命令，安装依赖库并集成 Agora Web SDK。

### 5. 运行示例项目

按照以下步骤运行示例项目：

1. 将示例项目文件夹中的 `.env.example` 文件重命名为 `.env`。
<div class="alert note">该文件为隐藏文件，你可能需要修改系统设置以显示该文件。</div>

2. 打开 `.env` 文件，将 <#YOUR Agora.io APP ID#> 替换为你的 Agora 项目的 App ID，将 `<#YOUR Agora.io APP TOKEN#>` 替换为你在控制台生成的临时 Token。
   <div class="alert note">此处填写的 App ID 和 Token 均为字符串格式，如下图所示。
	<img src="https://web-cdn.agora.io/docs-files/1605177740288"></img>
</div>

3. 在命令行中进入 OpenLive-Web 目录，然后运行 `npm run dev` 命令，启动示例应用。

   运行命令后示例应用的页面会自动在你的默认浏览器打开，如下图所示：
   ![](https://web-cdn.agora.io/docs-files/1605178564539)

  <div class="alert info">如果页面没有自动打开，你可以打开浏览器，通过访问 <code>http://localhost:3000</code> 打开示例应用。</div>

4. 输入生成临时 Token 时使用的频道名，点击 **Start Live Streaming**，以主播（host）的角色开始直播。浏览器会弹出对话框要求麦克风和摄像头权限，点击**允许**，即可在页面上看到本地的视频画面。

  <div class="alert info">你也可以在开始直播前选择角色为观众（audience）。以观众角色加入直播，浏览器不会请求麦克风和摄像头权限，页面也不会显示本地视频画面。</div>

如果页面没有正常工作，可以打开浏览器的控制台查看错误信息进行排查。常见的错误信息包括：

- `INVALID_VENDOR_KEY`：App ID 或 Token 错误，检查你填写的 App ID 及 Token。
- `DYNAMIC_USE_STATIC_KEY`：你的 Agora 项目启用了 App 证书，需要在加入频道时填写 Token。
- `Media access:NotFoundError`：检查你的摄像头和麦克风是否正常工作。
