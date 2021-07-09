---
title: 跑通示例项目
platform: Unity
updatedAt: 2020-11-30 08:39:55
---
## 概览

Agora 在 GitHub 上提供一个开源的示例项目 [API-Example-Unity](https://github.com/AgoraIO/Agora-Unity-Quickstart/tree/master/API-Example-Unity)。本文介绍如何快速跑通该示例项目，体验 Agora 语音通话效果。你也可以直接观看下面的视频教程。

<video src="https://web-cdn.agora.io/docs-files/1585033937464" poster="https://web-cdn.agora.io/docs-files/1597911667355" controls width = 100% height = auto>你的浏览器不支持 <code>video</code> 标签。</video>

<div class="alert note">视频中展示的 UI 可能有部分调整更新，请以当前最新版为准。</div>

## 前提条件

- Unity 2017 或以上版本（本文 Unity 的界面描述以 Unity 2018.4.28f1 为例）

- Unity Hub 1.0.0 或以上版本（本文 Unity Hub 的界面描述以 Unity Hub 2.4.3 为例）

- 操作系统与集成开发环境要求：

  | 开发平台 | 操作系统版本       | 集成开发环境版本                    |
  | :------- | :----------------- | :---------------------------------- |
  | Android  | Android 4.1 或以上 | Android Studio 3.0 或以上           |
  | iOS      | iOS 8.0 或以上     | Xcode 9.0 或以上                    |
  | macOS    | macOS 10.10 或以上 | Xcode 9.0 或以上                    |
  | Windows  | Windows 7 或以上   | Microsoft Visual Studio 2017 或以上 |

- 有效的 [Agora 账户](https://docs.agora.io/cn/Agora%20Platform/sign_in_and_sign_up?platform=Unity)

<div class="alert note">如果你的网络环境部署了防火墙，请参考<a href="https://docs.agora.io/cn/Agora%20Platform/firewall?platform=Unity">应用企业防火墙限制</a>以正常使用 Agora 服务。</div>

## 操作步骤

### 1. 创建 Agora 项目 

按照以下步骤，在控制台创建一个 Agora 项目。

1. 登录 [Agora 控制台](https://console.agora.io/)，点击左侧导航栏 ![img](https://web-cdn.agora.io/docs-files/1594283671161) **项目管理**按钮进入**[项目管理](https://console.agora.io/projects)**页面**。**

2. 在**项目管理**页面，点击**创建**按钮。

 ![创建项目](https://web-cdn.agora.io/docs-files/1594287028966)

3. 在弹出的对话框内输入**项目名称**，选择**鉴权机制**为 **APP ID + Token。**

4. 点击**提交**，新建的项目就会显示在**项目管理**页中。

### <a name="appid"></a>2. 获取 App ID

Agora 会给每个项目自动分配一个 App ID 作为项目唯一标识。

在 [Agora 控制台](https://console.agora.io/)的**项目管理**页面，找到你的项目，点击 App ID 右侧的眼睛图标就可以直接复制项目的 App ID。

![获取appid](https://web-cdn.agora.io/docs-files/1603974707121)
<div class="alert info">你需要在运行示例项目时填写 App ID。</div>

### <a name="temptoken"></a>3. 生成临时 Token

为提高项目的安全性，Agora 使用 Token（动态密钥）对即将加入频道的用户进行鉴权。

为了方便测试，Agora 控制台提供生成临时 Token 的功能，具体步骤如下：

1. 在控制台的[项目管理](https://console.agora.io/projects)页面，点击已创建项目的 ![](https://web-cdn.agora.io/docs-files/1574923151660) 图标，打开 **Token** 页面。

	![](https://web-cdn.agora.io/docs-files/1574922827899)

2. 输入一个频道名，例如 test，然后点击**生成临时Token**。临时 Token 的有效期为 24 小时。加入频道时，请确保填入的频道名与生成临时 Token 时填入的频道名一致。

	![](https://web-cdn.agora.io/docs-files/1574928082984)

<div class="alert note">临时 Token 仅作为演示和测试用途。在生产环境中，你需要自行部署服务器签发 Token，详见<a href="token_server">生成 Token</a >。</div>

<div class="alert info">你需要在运行示例项目时填写临时 Token。</div>

### 4. 集成 Agora SDK

按照以下步骤将 Agora Unity SDK 集成到示例项目中。

1. 克隆 [Agora-Unity-Quickstart](https://github.com/AgoraIO/Agora-Unity-Quickstart) 仓库至本地。
2. 打开 Unity Hub，进入**安装**面板。点击**安装**，选择你所需要的 Unity 版本和模块，并点击**完成**。
3. 安装完成后，进入**项目**面板，点击**添加**，添加 `Agora-Unity-Quickstart/API-Example-Unity` 示例项目。
4. 在项目列表中选择 Unity 版本，点击 **API-Example-Unity**，仔细阅读弹出对话框的内容，并点击**确认**。系统会通过 Unity 打开该示例项目。
5. 在 Unity 中，进入 **Asset Store** 面板，找到 Agora Voice SDK for Unity 并点击 **Download** 下载。
6. 下载成功后，点击 **Import** 按钮打开 **Import Unity Package** 窗口。
7. 点击 **Import Unity Package** 窗口上的 **Import** 按钮导入 SDK。导入完成后，你可以在 **Project** 面板中看到 `AgoraEngine` 文件夹。

### 5. 配置示例项目

1. 在 Unity 的 **Project** 面板上，打开 `Assets/API-Example/audio-sample` 文件夹。
2. 双击 **MainScene**，并点击 **Hierarchy** 面板上的 **Canvas**。
3. 在 **Inspector** 面板上，找到 **Hello Agora Voice** 脚本。输入你从声网控制台获取到的 App ID、临时 Token 和生成临时 Token 时使用的频道名。

![](https://web-cdn.agora.io/docs-files/1606468933370)

### 6. 编译并运行示例项目

连接你的设备，然后运行示例项目。

以 macOS 设备为例，运行成功后，你会看到如下画面。

![](https://web-cdn.agora.io/docs-files/1606468963921)

如果想体验一对一通话效果，你可以通过声网的 [Web 端示例应用](https://webdemo.agora.io/agora-web-showcase/examples/Agora-Web-Tutorial-1to1-Web/)，输入相同的 App ID、频道名和临时 Token，加入同一频道与 macOS 端互通。

## 示例项目结构

你可以参考示例项目的 `HelloAgoraVoice.cs` 文件中的主要功能代码，根据自己的需求进行调整。