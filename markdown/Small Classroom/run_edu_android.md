---
title: 快速跑通 eEducation 示例项目
platform: All Platforms
updatedAt: 2021-04-01 08:21:13
---
## 概览

Agora 在 GitHub 上提供一个开源的 [eEducation 示例项目](https://github.com/AgoraIO-Usecase/eEducation)，演示了如何通过 Agora 房间管理服务，并配合 Agora RTC SDK、Agora RTM SDK、Agora 云端录制和第三方 Netless 白板 SDK，实现基本的在线互动教学场景。

你可参考本文编译并运行Android的 eEducation 示例项目，体验在线互动教学。在此基础上，你可以基于我们提供的示例项目进行修改适配，快速上线项目。

## 前提条件

- 开发环境：
  - [Java Development Kit](https://www.oracle.com/java/technologies/javase-downloads.html)
  - Android Studio 2.0 及以上
- 一台 Android 设备。部分模拟机可能存在功能缺失或者性能问题，所以推荐使用真机。
- Android 4.4 及以上。
- 有效的 [Agora 账号](https://docs.agora.io/cn/Agora%20Platform/sign_in_and_sign_up)。
- 有效的第三方白板 [Netless 账号](https://console.netless.link/zh-CN/login/)。

## 操作步骤

### 1. 创建 Agora 项目 

按照以下步骤，在控制台创建一个 Agora 项目。

1. 登录 [Agora 控制台](https://console.agora.io/)，点击左侧导航栏 ![img](https://web-cdn.agora.io/docs-files/1594283671161) **项目管理**按钮进入**[项目管理](https://console.agora.io/projects)**页面**。**

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

参考以下步骤步骤获取 Agora 互动白板服务的 App Identifier 和 SDK Token：

1. 登录 [Agora 控制台](https://console.agora.io/#onboarding)，为你在第一步创建的 Agora 项目[开启互动白板服务](https://docs.agora.io/cn/whiteboard/enable_whiteboard?platform=Android#开启互动白板服务)。
2. [获取互动白板服务的 App Identifier](https://docs.agora.io/cn/whiteboard/enable_whiteboard?platform=Android#获取-app-identifier)。你需要保存此 App Identifier。
3. [获取互动白板服务的 SDK Token](https://docs.agora.io/cn/whiteboard/enable_whiteboard?platform=Android#获取-sdk-token)。你需要保存此 SDK Token。

### 5. 在示例项目中配置相关字段

按照以下步骤，在示例项目中配置相关字段。

1. 打开终端，克隆 [eEducation 项目](https://github.com/AgoraIO-Usecase/eEducation)仓库至本地。
 ```
git clone https://github.com/AgoraIO-Usecase/eEducation.git
```

2. 打开 Android Studio， 选择 Open an existing Android Studio project，打开 eEducation/education_Android/AgoraEducation 文件夹。打开后，Gradle 会自动开始构建。

3. 选择 **Project** 视图，在 `app/src/normal/res/values/string_configs.xml` 文件中填写以下字段：
  - Agora 的 App ID
  - Agora 的客户 ID 和客户密钥
  - Netless 的 AppIdentifier

 ```java
<string name="agora_app_id" translatable="false">Your AppId</string>
<string name="agora_customer_id" translatable="false">Your customerId</string>
<string name="agora_customer_cer" translatable="false">Your customerCer</string>
<string name="whiteboard_app_id" translatable="false">Your whiteboard appId</string>
```

### 6. 编译并运行示例项目

开启手机的开发者选项，通过 USB 连接线将 Android 设备接入电脑，点击三角按钮编译并运行示例项目。

![](https://web-cdn.agora.io/docs-files/1603975701953)

安装成功后，你能在 Android 设备上看到如下界面。

![](https://web-cdn.agora.io/docs-files/1603975951024)