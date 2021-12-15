---
title: 快速跑通 eEducation 示例项目
platform: All Platforms
updatedAt: 2021-04-01 08:21:39
---

## 概览

Agora 在 GitHub 上提供一个开源的 [eEducation 示例项目](https://github.com/AgoraIO-Usecase/eEducation)，演示了如何通过 Agora 教育云服务，并配合 Agora RTC SDK、Agora RTM SDK、Agora 云端录制和第三方 Netless 白板 SDK，实现基本的在线互动教学场景。

你可参考本文编译并运行 Web 平台的 eEducation 示例项目，体验在线互动教学。在此基础上，你可以基于我们提供的示例项目进行修改适配，快速上线项目。

## 前提条件

- 开发环境：
  - 可以连接到互联网的 Windows 或 macOS 计算机。
  - 安装 [Node.js](https://nodejs.org/)。
- 安装最新稳定版 [Chrome 浏览器](https://www.google.cn/chrome/)。
- 有效的 Agora [开发者账号](https://docs.agora.io/cn/Agora%20Platform/sign_in_and_sign_up)。
- 有效的第三方白板 [Netless 账号](https://console.netless.link/zh-CN/login/)。

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

### 3. 获取 Agora 的客户 ID 和客户密钥

由于该示例项目需要使用 RESTful API，因此你需要进行 HTTP 基本认证，即使用 Agora 提供的客户 ID 和客户密钥生成一个 **Authorization 字段**（使用 Base64 算法编码）。

1. 登录 [Agora 控制台](https://console.agora.io/)，点击页面右上角的用户名，在下拉列表中打开 **RESTful API** 页面。
2. 点击**下载**，即可获取客户 ID（`customerId`）和客户密钥（`customerSecret`）。

### 4. 获取 Netless 的 AppIdentifier 和 sdkToken

参考以下步骤步骤获取第三方白板 Netless 的 AppIdentifier 和 sdkToken：

1. 登录 [Netless 控制台](https://console.netless.link/)，点击左侧导航栏**应用管理**按钮，保存此 AppIdentifier。

![获取 AppIdentifier](https://web-cdn.agora.io/docs-files/1603975237931)

2. 点击对应应用的**配置**按钮，点击**生成 sdkToken**，然后复制此 sdkToken。

![获取 sdktoken](https://web-cdn.agora.io/docs-files/1603975258941)

### 5. 在示例项目中配置相关字段

按照以下步骤，在示例项目中配置相关字段。

1. 打开终端，克隆 [eEducation 项目](https://github.com/AgoraIO-Usecase/eEducation)仓库至本地。

```
git clone https://github.com/AgoraIO-Usecase/eEducation.git
```

2. 将 eEducation/education_web 文件夹中的 `.env.example` 文件重命名为 `.env`，并在此文件中填写以下字段：
   - Agora 的 App ID
   - Agora 的客户 ID 和客户密钥
   - Netless 的 AppIdentifier

```ts
REACT_APP_AGORA_APP_ID=agora appId
REACT_APP_AGORA_CUSTOMER_ID=customer_id
REACT_APP_AGORA_CUSTOMER_CERTIFICATE=customer_certificate
REACT_APP_NETLESS_APP_ID=netless appId
```

### 6. 编译并运行示例项目

参考下列步骤编译并运行示例项目：

1. 在命令行中进入 eEducation/education_web 目录，然后安装依赖环境。

```
cd eEducation/education_web
npm install
```

2. 运行以下命令启动示例应用。

```
npm run dev
```

运行命令后示例应用的页面会自动在你的默认浏览器打开，如下图所示。如果页面没有自动打开，你可以打开浏览器，通过访问 `http://localhost:3000` 打开示例应用。你需要输入房间名和用户名，并选择房间类型，然后加入课堂。

![](https://web-cdn.agora.io/docs-files/1604042695033)
