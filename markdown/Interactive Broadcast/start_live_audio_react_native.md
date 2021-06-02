---
title: 实现音频直播
platform: React Native
updatedAt: 2021-02-07 02:00:57
---
本文介绍如何使用 Agora React Native SDK 快速实现音频直播。

## 示例项目

Agora 在 GitHub 提供一个开源的视频通话示例项目 [Agora-RN-Quickstart](https://github.com/AgoraIO-Community/Agora-RN-Quickstart)。在实现相关功能前，你可以下载并体验。

## 前提条件

### 开发环境要求

如果你的目标平台为 iOS，你的开发环境需要满足以下需求：

- React Native 0.59.10 或以上
- macOS 操作系统
- Node 10 或以上
- Xcode 9.4 或以上
- CocoaPods
- iOS 8.0 或以上设备 

如果你的目标平台为 Android，你的开发环境需要满足以下需求：

- React Native 0.59.10 或以上
- macOS 、Windows 或 Linux 操作系统
- Node 10 或以上
- Java Development Kit (JDK) 8 或以上
- 最新版本的 Android Studio
- Android 5.0 或以上设备 

<div class="alert info">关于搭建开发环境的更多注意事项，详见<a href="https://reactnative.dev/docs/environment-setup">搭建开发环境</a >。</div>


###  其他要求

有效的 Agora [开发者账号](/cn/Agora%20Platform/sign_in_and_sign_up?platform=All%20Platforms)。

<div class="alert note">如果你的网络环境部署了防火墙，请参考<a href="/cn/Agora%20Platform/firewall?platform=All%20Platforms">应用企业防火墙限制</a >以正常使用 Agora 服务。</div>

## 创建项目

1. 确保你已根据你使用的操作系统、针对的目标平台，完成了开发环境的搭建。

2. 运行以下命令，在 `ProjectName` 处填入你的项目名称，创建并初始化一个新项目。
 ```shell
 npx react-native init ProjectName
 ```
 
   运行完成后，会在执行该命令的路径下自动生成一个简单的示例项目。

3. 启动你的 Andoird 或 iOS 模拟器，执行以下命令运行你的项目：

   a. 在项目根目录下执行 `npx react-native start` 启动 Metro。
   b. 在项目目录下再打开一个终端，执行 `npx react-native run-android` 运行 Android 应用或执行 `npx react-native run-ios` 运行 iOS 应用。

如果配置没有问题，你可以看到应用自动安装到模拟器上并开始运行。

<div class="alert info">你也可以在 Android 或 iOS 真机上运行应用，详见<a href="https://reactnative.dev/docs/running-on-device">在设备上运行</a >
。</div>

现在你已经成功运行了项目，可以开始尝试集成 Agora SDK 并修改项目。

## 集成 SDK

本节介绍如何在 React Native 0.60.0 或以上版本集成 Agora React Native SDK。

<div class="alert note">如果你使用的 React Native 版本为 0.59.x， 请参考<a href="https://github.com/AgoraIO-Community/react-native-agora/blob/master/README.zh.md#安装在-react-native--059x">安装在（React Native == 0.59.x）</a >。</div>

1. 下载最新版的 Agora React Native SDK：

   **方法一**：使用 npm 下载

   ```shell
	 npm i --save react-native-agora
	 ```
	 
   **方法二**：使用 yarn 下载

   ```shell
	 // 安装 yarn
	 npm install -g yarn
	 // 使用 yarn 下载 Agora React Native SDK
	 yarn add react-native-agora
	 ```
	<div class="alert note">React Native 0.60.0 或以上版本支持自动链接原生模块，请勿手动链接。详见  <a href="https://github.com/react-native-community/cli/blob/master/docs/autolinking.md">Autolinking</a >。</div>

2. 如果你的目标平台是 iOS， 还需要执行 `npx pod-install` 安装 SDK。

   <div class="alert note"> 请确保你已安装 <b>CocoaPods</b>。你可以参考 <a href="https://guides.cocoapods.org/using/getting-started.html#getting-started">Getting Started with CocoaPods</a >。</div>

3.  Agora React Native SDK 原生层基于 Swift 语言开发，请确保你的工程支持编译 Swift，否则编译 iOS 应用时会报错。

   a. 用 Xcode 打开 `ios/ProjectName.xcworkspace` 文件夹。
   b. 点击 **File > New > File**， 选择 **iOS** > **Swift File**，点击 **Next** > **Create**，新建一个空的 `File.swift` 文件。

## 添加 TypeScript 支持

本文中的示例代码使用 TypeScript 编写。如果你想直接使用本文中的示例代码，需要在项目中添加对 TypeScript 的支持。

1. 在项目根目录下执行以下命令安装 TypeScript 相关依赖。

   **方法一**：使用 npm 安装
   ```shell
   npm install --save-dev typescript @types/jest @types/react @types/react-native @types/react-test-renderer
   ```
	 
	 **方法二**：使用 yarn 安装
	 确保你已经安装 yarn。
	 ```shell
  yarn add --dev typescript @types/jest @types/react @types/react-native @types/react-test-renderer
	 ```


2. 在项目根目录下创建 `tsconfig.json` 文件，并复制以下代码到该文件：

 ```json
 {
  "compilerOptions": {
    "allowJs": true,
    "allowSyntheticDefaultImports": true,
    "esModuleInterop": true,
    "isolatedModules": true,
    "jsx": "react",
    "lib": ["es6"],
    "moduleResolution": "node",
    "noEmit": true,
    "strict": true,
    "target": "esnext"
  },
  "exclude": [
    "node_modules",
    "babel.config.js",
    "metro.config.js",
    "jest.config.js"
  ]
 }
 ```

3. 在项目根目录下创建 `jest.config.js` 文件，并复制以下代码到该文件：

 ```javascript
 module.exports = {
    preset: 'react-native',
    moduleFileExtensions: ['ts', 'tsx', 'js', 'jsx', 'json', 'node']
};
```

4. 将根目录下的 `App.js` 文件重命名为 `App.tsx` 文件。

<div class="alert info">关于在 React Native 项目中使用 TypeScript 的更多信息，详见<a href="https://reactnative.dev/docs/typescript">使用 TypeScript</a >。</div>


## 实现音频互动直播

本节介绍如何实现音频互动直播。

### 1. 导入类

在项目中导入 `RtcEngine` 类和视图渲染组件。

```
import RtcEngine, {RtcLocalView, RtcRemoteView, VideoRenderMode} from 'react-native-agora'
```

### 2. 初始化 RtcEngine

在调用其他 Agora API 前，需要创建并初始化 `RtcEngine` 对象。

你还可以根据场景需要，在初始化时注册想要监听的回调事件，如本地用户加入频道，远端用户加入频道及远端用户离开频道等。

```
async function init() {
    // 填入你的 App ID, 创建并初始化 RtcEngine 实例。
    const engine = await RtcEngine.create(appId)
    // 注册 JoinChannelSuccess 回调。
    // 本地用户成功加入频道时，会触发该回调。
    engine.addListener('JoinChannelSuccess', (channel, uid, elapsed) => {})
    // 注册 UserJoined 回调。
    // 远端用户成功加入频道时，会触发该回调。
    engine.addListener('UserJoined', (uid, elapsed) => {})
    // 注册 UserOffline 回调。
    // 远端用户离开频道时，会触发该回调。
    engine.addListener('UserOffline', (uid, reason) => {})
}
```

### 3. 设置频道场景

初始化结束后，调用 `setChannelProfile` 方法，将频道场景设为直播。

```
engine.setChannelProfile(ChannelProfile.LiveBroadcasting)
```

### 4. 设置用户角色

直播频道有两种用户角色：主播和观众，其中默认的角色为观众。设置频道场景为直播后，可以参考如下步骤设置用户角色：

1. 让用户选择自己的角色是主播还是观众。
2. 调用 `setClientRole` 方法，然后使用用户选择的角色进行传参。

注意，直播频道内的用户，只能看到主播的画面、听到主播的声音。加入频道后，如果你想切换用户角色，也可以再次调用 `setClientRole` 方法。

```
// 设置用户角色为主播。
engine.setClientRole(ClientRole.Broadcaster)
```

### 5. 加入频道

完成设置用户角色后，你就可以调用 `joinChannel` 方法加入频道。你需要在该方法中传入如下参数：

- `token`：传入能标识用户角色和权限的 Token。可设为如下一个值：

  - `null` 或者空字符串。
  - 临时 Token。临时 Token 服务有效期为 24 小时。你可以在控制台里生成一个临时 Token，详见[获取临时 Token](https://docs.agora.io/cn/Agora%20Platform/token?platform=All%20Platforms#get-a-temporary-token)。
  - 在你的服务器端生成的 Token。在安全要求高的场景下，我们推荐你使用此种方式生成的 Token，详见[生成 Token](https://docs.agora.io/cn/Video/token_server)。
  
	 <div class="alert note">若项目已启用 App 证书，请使用 Token。</div>

- `channelName`：传入能标识频道的频道 ID。App ID 相同、频道 ID 相同的用户会进入同一个频道。

- `uid`： 本地用户的 ID。数据类型为整型，且频道内每个用户的 uid 必须是唯一的。若将 `uid` 设为 0，则 SDK 会自动分配一个 `uid`，并在 `JoinChannelSuccess` 回调中报告。

```
engine.joinChannel(token, channelName, null, 0)
```

### 6. 离开频道

根据场景需要，如结束直播、关闭 app 或 app 切换至后台时，调用 `leaveChannel` 离开当前频道。

```
engine.leaveChannel();
```

## 运行项目

在 Android 或 iOS 设备中运行该项目。当成功开始音频直播时，观众可以听到主播的声音。