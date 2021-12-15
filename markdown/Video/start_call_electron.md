---
title: 实现视频通话
platform: Electron
updatedAt: 2020-11-16 03:26:04
---

本文介绍如何使用 Agora Electron SDK 快速实现音视频通话。

## Demo 体验

Agora 在 GitHub 提供一个开源的 [Agora Electron Quickstart](https://github.com/AgoraIO-Community/Agora-Electron-Quickstart) 示例项目。在实现相关功能前，你可以下载并查看源代码。

## 开发环境要求

- Node.js 6.9.1 及以上
- Electron 1.8.3 及以上

<div class="alert note">使用 Windows 平台进行开发时，请运行 npm install -D —arch = ia32 electron 安装 32 位的 Electron。</div>
<div class="alert note">如果你的网络环境部署了防火墙，请根据<a href="https://docs.agora.io/cn/Agora%20Platform/firewall?platform=All%20Platforms">应用企业防火墙限制</a>打开相关端口。</div>

## 准备开发环境

本节介绍如何创建项目，将 Agora SDK 集成进你的项目中，并添加相应的依赖项。

### 创建项目

参考 [Writing Your First Electron App](https://electronjs.org/docs/tutorial/first-app) 创建一个 Electron 项目。若已有 Electron 项目，可以直接参考 [集成 SDK](#integrate_sdk)。

<a name="integrate_sdk"></a>

### 集成 SDK

选择如下任意一种方式将 Agora SDK 集成到你的项目中。

**方法一：通过 npm 直接安装 SDK**

1. 在你的项目文件路径，运行如下命令行安装最新版的 Agora SDK for Electron：

   `npm install agora-electron-sdk`

2. 然后通过如下代码将 SDK 引入至你的项目中

   `import AgoraRtcEngine from 'agora-electron-sdk'`

**方法二：官网下载 SDK 并引入**

<div class="alert note">如果你选择官网下载并引入的方式，请务必使用 Eletron 3.0.6。</div>

1. 前往官网 [SDK Downloads](https://docs.agora.io/cn/Agora%20Platform/downloads) 页面下载 Agora SDK for Electron
2. 将下载下来的 SDK 拷贝至你的项目根目录下
3. 通过如下代码将 SDK 引入至你的项目中

   `import AgoraRtcEngine from 'agora-electron-sdk'`

### 修改 .npmrc 文件切换预编译版本

Agora 默认使用 1.8.3 版本的 Electron 进行编译。请根据你的 Electron 版本修改 .npmrc 文件，切换预编译版本：

```javascript
// 下载使用 Electron 1.8.3 预编译的版本
agora_electron_dependent = 1.8.3
// 下载使用 Electron 3.0.6 预编译的版本
agora_electron_dependent = 3.0.6
// 下载使用 Electron 4.2.8 预编译的版本
agora_electron_dependent = 4.2.8
// 下载使用 Electron 5.0.8 预编译的版本
agora_electron_dependent = 5.0.8
```

### 安装依赖项

在你的项目文件夹下运行 `npm install` 安装依赖项。安装会自动触发 `npm run download`，你也可以到对应路径下手动安装。

如果你想用 Xcode 或 Visual Studio 调试，可以执行 `npm run debug` 命令行生成项目文件及带符号表的 SDK 文件。

至此，你已经将 Agora SDK for Electron 集成到你的项目中了。

## 实现音视频通话

请参考 [Agora Electron Quickstart](https://github.com/AgoraIO-Community/Agora-Electron-Quickstart) 示例项目在你的项目中实现相关的实时音视频功能。

## SDK 开源

[Agora SDK for Electron](https://www.npmjs.com/package/agora-electron-sdk) 在 GitHub 上开源，你可以前往参考或查阅源代码。Agora 也欢迎开发者贡献代码，以提高 Electron SDK 的易用性。
