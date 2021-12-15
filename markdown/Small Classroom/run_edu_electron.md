---
title: 快速跑通 eEducation 示例项目
platform: All Platforms
updatedAt: 2021-04-01 08:21:52
---

## 概览

Agora 在 GitHub 上提供一个开源的 [eEducation 示例项目](https://github.com/AgoraIO-Usecase/eEducation)，演示了如何通过 Agora 房间管理服务，并配合 Agora RTC SDK、Agora RTM SDK、Agora 云端录制和第三方 Netless 白板 SDK，实现基本的在线互动教学场景。

你可参考本文编译并运行基于 Electron 框架的的 eEducation 示例项目，体验在线互动教学。在此基础上，你可以基于我们提供的示例项目进行修改适配，快速上线项目。

## 前提条件

- 开发环境：
  - 可以连接到互联网的 Windows 或 macOS 计算机。
  - 麦克风、摄像头和屏幕录制的权限。
  - 安装 [Node.js](https://nodejs.org/)。
- 有效的 Agora [开发者账号](https://docs.agora.io/cn/Agora%20Platform/sign_in_and_sign_up)。
- 有效的第三方白板 [Netless 账号](https://console.netless.link/zh-CN/login/)。
- 如你需要使用白板课件服务，你需要配置阿里云 OSS 账号。可参考[阿里云 OSS 配置指南](https://github.com/AgoraIO-Usecase/eEducation/wiki/阿里云-OSS-配置指南)以及阅读[阿里云 OSS 官方文档](https://help.aliyun.com/document_detail/31890.html?spm=a2c4g.11186623.6.614.2b5533e14wr1Lh)。

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

### 4. 获取互动白板服务的 App Identifier 和 SDK Token

参考以下步骤步骤获取 Agora 互动白板服务的 App Identifier 和 SDK Token：

1. 登录 [Agora 控制台](https://console.agora.io/#onboarding)，为你在第一步创建的 Agora 项目[开启互动白板服务](https://docs.agora.io/cn/whiteboard/enable_whiteboard?platform=Android#开启互动白板服务)。
2. [获取互动白板服务的 App Identifier](https://docs.agora.io/cn/whiteboard/enable_whiteboard?platform=Android#获取-app-identifier)。你需要保存此 App Identifier。
3. [获取互动白板服务的 SDK Token](https://docs.agora.io/cn/whiteboard/enable_whiteboard?platform=Android#获取-sdk-token)。你需要保存此 SDK Token。

### 5. 在 Agora 控制台进行配置

参考以下步骤在 Agora 控制台对 eEducation 示例项目的白板和云端录制功能进行配置。

1. 登录 [Agora 控制台](https://console.agora.io/)，进入**项目管理**页面，找到你刚刚创建的项目，点击该项目的**编辑**按钮进入**项目编辑**页面，然后点击 **aPaaS 配置**按钮。

![apaas配置](https://web-cdn.agora.io/docs-files/1611024994160)

2. 进入 aPaaS 配置页面，**勾选**白板和云端录制以开通这两个功能，然后参考下文分别传入相应的 JSON 配置对象，点击**更新**。返回**项目管理**页面后，再点击**保存**以确保 aPaaS 配置生效。

![apaas配置](https://web-cdn.agora.io/docs-files/1611025023884)

**白板**

白板的 JSON 配置对象包含以下字段：

| 字段    | 类型   | 描述                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| :------ | :----- | :---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `appId` | string | （必填）你在第四步获取到的互动白板 App Identifier。如不设置，则无法进入课堂。                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| `token` | string | （必填）你在第四步获取到的互动白板 SDK Token。如不设置，则无法进入课堂。                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| `oss`   | object | （选填）阿里云 OSS 配置，用于储存你在课堂中上传的课件。如不设置，则无法使用白板中的课件上传功能。包含以下字段：<ul><li>`region`: String 类型，阿里云 OSS 指定的地区信息，例如 `"oss-cn-shanghai"`。</li><li>`bucket`: String 类型，阿里云 OSS 的 Bucket 名称，例如 `"agora-whiteboard"`。</li><li>`folder`: String 类型，阿里云 OSS 中的资源路径，例如 `"whiteboard"`。</li><li>`accessKey`：String 类型，阿里云访问密钥 AccessKey 中的 `AccessKeyId`。详见[阿里云文档](https://help.aliyun.com/document_detail/53045.html)。</li><li>`secretKey`：String 类型，阿里云访问密钥 AccessKey 中的 `AccessKeySecret`。详见[阿里云文档](https://help.aliyun.com/document_detail/53045.html)。</li><li>`endpoint`: String 类型，阿里云 OSS [访问域名](https://help.aliyun.com/document_detail/31837.html?spm=a2c4g.11186623.6.625.49002345WzP07l)，例如 `"oss-cn-shanghai.aliyuncs.com"`。</ul><p>**注意事项**：当前白板只支持阿里云 OSS。 |

白板 JSON 示例：

```
{
      "appId": "<your_whiteboard_app_id>",
      "token": "<your_whiteboard_sdk_token>",
      "oss": {
          "region": "oss-cn-shanghai",
          "bucket": "<your_bucket_name>",
          "folder": "whiteboard",
          "accessKey": "<your_access_key>",
          "secretKey": "<your_secret_key>",
          "endpoint": "https://agora-whiteboard.oss-cn-shanghai.aliyuncs.com"
      }
}
```

**云端录制**

云端录制的 JSON 配置对象包含以下字段：

| 字段              | 类型   | 描述                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| :---------------- | :----- | :--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `recordingConfig` | object | （选填）录制设置。如不设置，则使用[合流录制模式](https://docs.agora.io/cn/Agora%20Platform/composite_recording_mode)且只录制老师的音视频。如需更改录制行为，请参考[云端录制设置](https://docs.agora.io/cn/cloud-recording/cloud_recording_api_rest?platform=RESTful#recordingConfig)。                                                                                                                                                                                                                                                                                                                                                               |
| `storageConfig`   | object | （选填）云存储设置，用于储存你的录制文件。如不设置，你的录制文件会存储在 Agora 的阿里云 OSS 账号中。如需使用你自己的云存储，请参考[云存储设置](https://docs.agora.io/cn/cloud-recording/cloud_recording_api_rest?platform=RESTful#storageConfig)进行配置。<p>**注意事项**：`storageConfig` 中的 `endpoint` 字段为由阿里云 Bucket 名称和[访问域名](https://help.aliyun.com/document_detail/31837.html?spm=a2c4g.11186623.6.625.49002345WzP07l)拼成的完整路径。假设你的 Bucket 名称为 `"agora-whiteboard"`，阿里云 OSS 访问域名为 `"oss-cn-shanghai.aliyuncs.com"`，则 `endpoint` 字段设为 `"https://agora-whiteboard.oss-cn-shanghai.aliyuncs.com"`。 |

云端录制 JSON 示例

```
{
      "recordingConfig": {},
      "storageConfig": {
          "vendor": 2,
          "region": 1,
          "bucket": "<your_bucket_name>",
          "accessKey": "<your_access_key>",
          "secretKey": "<your_secret_key>",
          "fileNamePrefix": ["directory1","directory2"],
          "endpoint": "https://xxx.oss-cn-shanghai.aliyuncs.com"
      }
}
```

### 6. 在示例项目中配置相关字段

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
// 如果你需要使用白板课件服务，你还需要配置以下阿里云 OSS 相关参数。如不使用，可忽略。
REACT_APP_YOUR_OWN_OSS_BUCKET_NAME=your_oss_bucket_name
REACT_APP_YOUR_OWN_OSS_BUCKET_FOLDER=your_oss_bucket_folder
REACT_APP_YOUR_OWN_OSS_BUCKET_REGION=your_bucket_region
REACT_APP_YOUR_OWN_OSS_BUCKET_KEY=your_bucket_ak
REACT_APP_YOUR_OWN_OSS_BUCKET_SECRET=your_bucket_sk
REACT_APP_YOUR_OWN_OSS_CDN_ACCELERATE=your_cdn_accelerate_endpoint
```

### 7. 编译并运行示例项目

#### macOS 平台

参考下列步骤在 macOS 平台编译并运行示例项目：

1. 在终端中进入 `eEducation/education_web` 目录，然后安装依赖环境。

```
cd eEducation/education_web
npm install
```

如由于网络问题无法成功安装依赖环境，可通过以下命令设置环境变量进行加速：

```
export ELECTRON_MIRROR="https://npm.taobao.org/mirrors/electron/"
export ELECTRON_CUSTOM_DIR="7.1.14"
export SASS_BINARY_SITE="https://npm.taobao.org/mirrors/node-sass/"
export ELECTRON_BUILDER_BINARIES_MIRROR="https://npm.taobao.org/mirrors/electron-builder-binaries/"
```

2. 输入以下命令运行示例项目。

```
npm run electron
```

运行成功后，你可以看到如下界面。

![](https://web-cdn.agora.io/docs-files/1608551610821)

你可以点击**设置**按钮，检测设备权限。示例项目会请求麦克风和摄像头的权限。你需要在系统偏好设置 > 安全性与隐私中，选择麦克风或摄像头，然后勾选终端旁边的复选框以允许其访问麦克风和摄像头及进行屏幕录制，如下图所示。后续如果你需要使用屏幕共享功能，你需要以相同的方式获取屏幕录制的权限。

![](https://web-cdn.agora.io/docs-files/1608551644103)

成功获取权限后，你可以输入房间名和用户名，并选择房间类型和角色，然后加入课堂。

3. 输入以下命令发布示例项目。

```
npm run pack:mac
```

运行成功后 `education_web` 目录下会生成一个 `release` 文件夹，里面包含一个 `dmg` 安装文件。点击打开该文件然后将其移动到 Application 目录即可完成安装并运行。

#### Windows 平台

参考下列步骤在 Windows 平台编译并运行示例项目：

1. 打开 `eEducation/education_web/package.json` 文件，将里面的 `agora_electron` 替换成以下内容：

```
"agora_electron": {
 "electron_version": "7.1.2",//Agora Electron SDK 进行预编译使用的版本。
 "prebuilt": true,
 "platform": "win32",
 "arch": "ia32"
},
```

然后安装 electron 7.1.14：

```
npm install electron@7.1.14 --arch=ia32 --save-dev
```

2. 以管理员身份运行终端，进入 `eEducation/education_web` 目录，然后安装依赖环境。

```
cd eEducation/education_web
npm install
```

```
set ELECTRON_MIRROR=https://npm.taobao.org/mirrors/electron/
set ELECTRON_CUSTOM_DIR=7.1.14
set ELECTRON_BUILDER_BINARIES_MIRROR=https://npm.taobao.org/mirrors/electron-builder-binaries/
set SASS_BINARY_SITE=https://npm.taobao.org/mirrors/node-sass/
```

3. 输入以下命令运行示例项目。

```
npm run electron
```

运行成功后，你可以看到如下界面。你可以输入房间名和用户名，并选择房间类型和角色，然后加入课堂。

![](https://web-cdn.agora.io/docs-files/1608551610821)

4. 输入以下命令发布示例项目。

```
npm run pack:win
```

运行成功后 `education_web` 目录下会生成一个 `release` 文件夹，里面包含一个 `exe` 安装文件。以 Windows 管理员打开该文件即可进行安装。
