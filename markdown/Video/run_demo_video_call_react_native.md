---
title: 跑通示例项目
platform: React Native
updatedAt: 2020-11-16 01:46:53
---
Agora 在 GitHub 上提供一个开源的视频通话示例项目 [Agora-RN-Quickstart](https://github.com/AgoraIO-Community/Agora-RN-Quickstart)，本文介绍如何快速跑通该示例项目，体验 Agora 视频通话效果。

## 前提条件

### 开发环境要求

如果你的目标平台为 iOS，你的开发环境需要满足以下需求：

- React Native 0.59.10 或以上版本
- macOS 操作系统
- Node 10 或以上
- Xcode 9.4 或以上版本 
- CocoaPods
- iOS 8.0 或以上设备 （真机或模拟器）

如果你的目标平台为 Android，你的开发环境需要满足以下需求：

- React Native 0.59.10 或以上版本
- macOS、Windows 或 Linux 操作系统
- Node 10 或以上
- Java Development Kit (JDK) 8 或以上
- 最新版本的 Android Studio
- Android 5.0 或以上设备 （真机或模拟器）

<div class="alert info">关于搭建开发环境的更多注意事项，详见<a href="https://reactnative.dev/docs/environment-setup">搭建开发环境</a >。</div>

### 其他要求

一个有效的 Agora [开发者账号](/cn/Agora%20Platform/sign_in_and_sign_up?platform=All%20Platforms)。

<div class="alert note">如果你的网络环境部署了防火墙，请根据<a href="/cn/Agora%20Platform/firewall?platform=All%20Platforms">应用企业防火墙限制</a >。</div>

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

###  3. 生成临时 Token

为提高项目的安全性，Agora 使用 Token（动态密钥）对即将加入频道的用户进行鉴权。

为了方便测试，Agora 控制台提供生成临时 Token 的功能，具体步骤如下：

1. 在控制台的[项目管理](https://console.agora.io/projects)页面，点击已创建项目的 ![](https://web-cdn.agora.io/docs-files/1574923151660) 图标，打开 **Token** 页面。

	![](https://web-cdn.agora.io/docs-files/1574922827899)

2. 输入一个频道名，例如 test，然后点击**生成临时Token**。临时 Token 的有效期为 24 小时。加入频道时，请确保填入的频道名与生成临时 Token 时填入的频道名一致。

	![](https://web-cdn.agora.io/docs-files/1574928082984)

<div class="alert note">临时 Token 仅作为演示和测试用途。在生产环境中，你需要自行部署服务器签发 Token，详见<a href="token_server">生成 Token</a >。</div>

###  4. 运行示例项目

1. 下载 [Agora-RN-Quickstart](https://github.com/AgoraIO-Community/Agora-RN-Quickstart) 仓库。打开 `Agora-RN-Quickstart-master/App.tsx` 文件并填入获取到的项目 App ID，临时 Token 和频道名。

 ```
constructor(props) {
        super(props)
        this.state = {
            // 把 YourAppId 替换成你的 App ID，并加引号，如'xxxxxx'。
            // 把 YourToken 替换成你的临时 Token，并加引号，如'xxxxxxxxx'。
            // 将频道名 channel-x 替换为生成临时 Token 时使用的频道名。
            appId: YourAppId,
            token: YourToken,
            channelName: 'channel-x',
            joinSucceed: false,
            peerIds: [],
        }
```

2. 在项目根目录下运行 `npm install` 或 `yarn` 命令安装依赖项。

3. 如果目标平台为 iOS，在 `Agora-RN-Quickstart-master/ios` 路径下执行 `pod install`。

4. 运行示例项目。

 - 运行 Android 应用：

    启动 Android 模拟器或连接真机，在项目根目录下执行 `npx react-native run-android` 运行应用。

 - 运行 iOS 应用：
    - 方法一：启动 iOS 模拟器，在项目根目录下执行 `npx react-native run-ios` 运行应用。（该方法仅支持在模拟器上运行项目。）
    - 方法二：启动模拟器或连接真机，用 Xcode 打开 `Agora-RN-Quickstart-master\ios\AgoraRNQuickstart.xcworkspace` 文件夹，点击 **Build and run** 按钮。

## 示例项目结构

下表列出示例项目的代码结构，你可以参考示例项目的代码，根据自己的需求进行调整。

```
.
├── android
├── components
│ └── Permission.ts
│ └── Style.ts
├── ios
├── App.tsx
├── index.js
.
```



| 文件/文件夹                           | 描述                                                         |
| :------------------------------------ | :----------------------------------------------------------- |
| `android`                             | 原生 Android 项目文件夹                                      |
| `components/Permission.ts` | 自定义组件：声明组件所需的设备权限 （仅适用于 Android 平台）定义组件的样式 |
| `components/Style.ts` | 定义组件的样式 |
| `ios`                                 | 原生 iOS 项目文件夹                                          |
| `App.tsx`                             | 示例项目默认显示内容的源码文件                               |
| `index.js`                            | React Native 项目的入口文件                                  |

## 常见问题

如果运行项目时遇到 `Error: listen EADDRINUSE: address already in use :::8081` 报错，表示端口号 8081 被占用，你可以尝试更换端口号并重新运行项目。

**运行 Android 应用**：

```
npx react-native run-android --port xxxx
```

**运行 iOS 应用**：

1. 在项目根目录下全局搜索 8081，并替换为未被占用的端口号，如 9999。
2. 连接模拟器或真机，用 Xcode 打开 `Agora-RN-Quickstart-master\ios\AgoraRNQuickstart.xcworkspace` 文件夹，点击 **Build and run** 按钮。

