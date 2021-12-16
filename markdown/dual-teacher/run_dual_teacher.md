---
title: 快速跑通示例项目
platform: Windows
updatedAt: 2021-02-07 08:34:55
---
## 概览

Agora 在 GitHub 上提供一个开源的[双师课堂示例项目](https://github.com/AgoraIO-Usecase/AgoraDualTeacher)，演示了如何通过 Agora RTC SDK、Agora RTM SDK 和 Agora 房间管理服务实现基本的双师课堂教学场景。

你可参考本文编译并运行该示例项目体验双师课堂教学场景。在此基础上，你可以基于我们提供的示例项目进行修改适配，快速上线项目。

## 前提条件

- 开发环境：
  - QT 5.12.9 x86
  - Visual Studio 2017
- 一台 Windows 设备，一个外接显示器，建议配备两个摄像头，外接和内置皆可。
- 有效的 [Agora 账号](https://docs.agora.io/cn/Agora%20Platform/sign_in_and_sign_up)。

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

由于该示例项目需要使用 Agora RESTful API，因此你需要进行 HTTP 基本认证。你需要获取 Agora 提供的客户 ID 和客户密钥。

1. 登录 [Agora 控制台](https://console.agora.io/)，点击页面右上角的用户名，在下拉列表中打开 RESTful API 页面。
2. 点击**添加密钥**按钮。在下方的页面中会生成新的客户 ID 和客户密钥，在右边的操作栏点击**提交**按钮。
3. 页面显示**创建成功**提示信息后，在相应的客户密钥栏点击**下载**按钮。
4. 保存下载下来的 **key_and_secret.txt** ，里面包含客户 ID 和客户密钥。

### 4. 在 Agora 控制台配置

参考以下步骤在 Agora 控制台进行配置以接通 Agora 房间管理服务。

1. 登录 [Agora 控制台](https://console.agora.io/)，进入**项目管理**页面，找到你刚刚创建的项目，点击该项目的**编辑**按钮进入**项目编辑**页面，然后点击 **aPaaS 配置**按钮。

  ![apaas配置](https://web-cdn.agora.io/docs-files/1611024994160)
	
2. 进入 aPaaS 配置页面，直接点击**更新**按钮。

 ![](https://web-cdn.agora.io/docs-files/1612685504363)

### 5. 在示例项目中配置相关字段

按照以下步骤，在示例项目中配置相关字段。

1. 克隆[双师课堂示例项目](https://github.com/AgoraIO-Usecase/AgoraDualTeacher)代码至本地。
2. 打开 Visual Studio 2017， 选择 Open an existing Visual Studio project，打开 `AgoraEduSDK.sln` 解决方案。
3. 选择 **agora_edu_demo** 项目，在 `agora_edu_demo\util.h` 文件中填写以下字段：
   - Agora 的 App ID
   - Agora 的客户 ID 和客户密钥
	```
#define APP_ID "Your_app_id"
#define CUSTOMER_ID "Your_customer_id"
#define CUSTOMER_CERTIFICATE "Your_customer_certificate"
```

### 6. 编译并运行示例项目

选择 X86 编译模式，点击三角按钮编译并运行示例项目。

![](https://web-cdn.agora.io/docs-files/1610692629092)

编译成功后，你将会看到如下界面。

![](https://web-cdn.agora.io/docs-files/1610692654204)