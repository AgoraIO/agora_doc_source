---
title: 跑通示例项目
platform: Unity
updatedAt: 2021-01-25 09:30:40
---
## 概览

Agora 在 GitHub 上提供一个开源的视频直播示例项目 [OpenLive-macOS](https://github.com/AgoraIO/Basic-Video-Broadcasting/tree/master/OpenLive-macOS)。本文介绍如何快速跑通该示例项目，体验 Agora 视频直播效果。你也可以直接观看下面的视频教程。

<video src="https://web-cdn.agora.io/docs-files/1593741447106" poster="https://web-cdn.agora.io/docs-files/1597911446287" controls width = 100% height = auto>你的浏览器不支持 <code>video</code> 标签。</video>

<div class="alert note">视频中展示的 UI 可能有部分调整更新，请以当前最新版为准。</div>

## 前提条件

- Xcode 10.0 或以上版本（本文 Xcode 的界面描述以 Xcode 11.0 为例）
- macOS 10.10 或以上版本的设备
- 有效的 [Agora 账户](https://docs.agora.io/cn/Agora%20Platform/sign_in_and_sign_up?platform=macOS)



<div class="alert note">如果你的网络环境部署了防火墙，请参考<a href="https://docs.agora.io/cn/Agora Platform/firewall?platform=macOS">应用企业防火墙限制</a>以正常使用 Agora 服务。</div>

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

### 4. 配置示例项目

1. 克隆 [Basic-Video-Broadcasting](https://github.com/AgoraIO/Basic-Video-Broadcasting) 仓库至本地，找到 `OpenLive-macOS` 示例项目文件夹。
2. 打开 `OpenLive/KeyCenter.swift` 文件，将 `<#Your App Id#>` 替换为你的 Agora 项目的 App ID，将 `<#Temp Access Token#>` 替换为你在控制台生成的临时 Token。

```swift
struct KeyCenter {
    static let AppId: String = <#Your App Id#>   
    static var Token: String? = <#Temp Access Token#>
}
```

###  5. 集成 Agora SDK

按照以下步骤将 Agora macOS SDK 集成到示例项目中。

1. 前往 [SDK 下载页面](https://docs.agora.io/cn/All/downloads?platform=macOS)，获取最新版的 Agora SDK，然后解压。
2. 将 `libs` 文件夹下的所有文件复制到 `OpenLive` 文件夹下即可。

### 6. 运行示例项目

按照以下步骤运行示例项目：

1. 在 macOS 设备上打开并运行 `OpenLive.xcodeproj` 示例项目。运行成功后，你会看到如下画面。
![](https://web-cdn.agora.io/docs-files/1605689559892)

2. 选择你的角色，输入你之前生成 Token 时使用的频道名，并点击 **Start Live Streaming** 开始直播。如果你选择的角色为主播，则示例应用会弹出对话框要求麦克风和摄像头权限，点击**允许**，即可在页面上看到本地的视频画面。

如果想体验直播效果，你可以通过声网的 [Web 端示例应用](https://webdemo.agora.io/agora-web-showcase/examples/Agora-Web-Tutorial-1to1-Web/)，输入相同的 App ID、频道名和临时 Token，加入同一频道与 macOS 端互通。

## 示例项目结构

下表列出示例项目的代码结构，你可以参考示例项目的代码，根据自己的需求进行调整。

| 文件/文件夹                | 描述                             |
| :------------------------- | :------------------------------- |
| `RoomViewController.swift` | 主要功能及频道内页面样式的代码。 |
| `KeyCenter.swift`          | 鉴权代码。                       |
| `MainViewController.swift` | 频道外页面样式的代码。           |

## 相关链接

除本文介绍的示例项目外，我们在 GitHub 上还提供 [OpenLive-macOS-Objective-C](https://github.com/AgoraIO/Basic-Video-Broadcasting/tree/master/OpenLive-macOS-Objective-C) 示例项目供你参考。