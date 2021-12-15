---
title: 实现语音通话
platform: React Native
updatedAt: 2021-02-07 01:55:32
---

本文介绍如何建立一个简单的 React Native 项目并使用 Agora React Native SDK 实现基础的语音通话。

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

### 其他要求

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

3. Agora React Native SDK 原生层基于 Swift 语言开发，请确保你的工程支持编译 Swift，否则编译 iOS 应用时会报错。

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
  "exclude": ["node_modules", "babel.config.js", "metro.config.js", "jest.config.js"]
}
```

3. 在项目根目录下创建 `jest.config.js` 文件，并复制以下代码到该文件：

```javascript
module.exports = {
  preset: "react-native",
  moduleFileExtensions: ["ts", "tsx", "js", "jsx", "json", "node"],
};
```

4. 将根目录下的 `App.js` 文件重命名为 `App.tsx` 文件。

<div class="alert info">关于在 React Native 项目中使用 TypeScript 的更多信息，详见<a href="https://reactnative.dev/docs/typescript">使用 TypeScript</a >。</div>

## 基本流程

### 1. 自定义用户界面

根据场景需要，为你的项目创建语音通话的用户界面。

在语音通话中，Agora 推荐你添加如下用户界面元素：

- 加入/离开频道按钮
- 启用/禁用麦克风按钮

你可以在项目根目录下新建一个 `components/Style.ts` 文件，并在该文件中添加定义界面元素的样式的代码，如下：

```typescript
import {StyleSheet} from "react-native";

export default StyleSheet.create({
  container: {
    flex: 1,
  },
  float: {
    position: "absolute",
    right: 0,
    bottom: 0,
  },
  top: {
    width: "100%",
  },
  input: {
    borderColor: "gray",
    borderWidth: 1,
  },
});
```

### 2. 导入类

打开 `App.tsx` 文件，删除所有代码。在 `App.tsx` 文件的开头添加如下代码：

```typescript
import React, {Component} from "react";
import {Platform, Button, TextInput, View} from "react-native";
// 导入 RtcEngine 类。
import RtcEngine from "react-native-agora";
// 导入自定义的用户界面样式。
import styles from "./components/Style";
```

### 3. 获取设备权限（仅 Android 平台）

<div class="alert note">此步骤仅适用于 Android 平台，在 iOS 平台不会执行。</div>

在 Android 设备上，要获得麦克风的使用权限，需要弹出提示框供用户选择。

在 `App.tsx` 文件中添加如下代码，设置获取设备麦克风使用权限的提示框。

```typescript
const requestCameraAndAudioPermission = async () => {
  try {
    const granted = await PermissionsAndroid.requestMultiple([PermissionsAndroid.PERMISSIONS.RECORD_AUDIO]);
    if (granted["android.permission.RECORD_AUDIO"] === PermissionsAndroid.RESULTS.GRANTED) {
      console.log("You can use the mic");
    } else {
      console.log("Permission denied");
    }
  } catch (err) {
    console.warn(err);
  }
};
```

### 4. 创建 App 组件

创建 App 组件时，需要定义 App ID，Token 和频道名，用于初始化 `RtcEngine` 和加入频道。

- `appId`：你的 Agora 项目的 App ID。详见[获取 App ID](/cn/Agora%20Platform/token?platform=All%20Platforms#a-name--appida使用-app-id-鉴权)。

- `channelName`：传入能标识频道的频道 ID。App ID 相同、频道 ID 相同的用户会进入同一个频道。

- `token`：传入能标识用户角色和权限的 Token。该 Token 必须是使用上述 App ID 和频道名生成的 Token。可设为如下一个值：

  - 临时 Token。临时 Token 服务有效期为 24 小时。你可以在控制台里生成一个临时 Token，详见[获取临时 Token](/cn/Voice/token?platform=All%20Platforms#get-a-temporary-token)。

  - 在你的服务器端生成的 Token。在安全要求高的场景下，我们推荐你使用此种方式生成的 Token，详见[生成 Token](/cn/Video/token_server?platform=All%20Platforms)。

 <div class="alert note">若项目已启用 App 证书，则必须使用 Token。</div>

```
// 定义一个 Props 接口。
interface Props {
}

// 定义一个 State 接口。
interface State {
    appId: string,
    token: string,
    channelName: string,
    joinSucceed: boolean,
    openMicrophone: boolean,
    enableSpeakerphone: boolean,
    peerIds: number[],
}

// 创建一个 App 组件，该组件继承了 Props 和 State 的属性。
export default class App extends Component<Props, State> {
    _engine?: RtcEngine

    // 添加一个构造函数，在该函数中为 this.state 赋初始值，其中：
    // 将 yourAppId 替换为你的 Agora 项目的 App ID。
    // 将 yourChannel 替换为加入频道时的频道名称。
    // 将 yourToken 替换为你用上述 App ID 和频道名生成的 Token。

    constructor(props) {
        super(props)
        this.state = {
            appId: `yourAppId`,
            token: 'yourToken',
            channelName: 'yourChannel',
            openMicrophone: true,
            enableSpeakerphone: true,
            joinSucceed: false,
            peerIds: [],
        }
        if (Platform.OS === 'android') {
            // Request required permissions from Android
            requestCameraAndAudioPermission().then(() => {
                console.log('requested!')
            })
        }
    }
    // 其他代码，见步骤 5 至步骤 9。
    ...
}

```

### 5. 初始化 RtcEngine

在调用其他 Agora API 前，需要创建并初始化 `RtcEngine` 对象。

你还可以根据场景需要，在初始化时注册想要监听的回调事件，如本地用户加入频道，远端用户加入频道及远端用户离开频道等。

在 App 组件 `// 其他代码` 的下方添加如下代码：

```typescript
// 将组件挂载到 DOM 中。
componentDidMount() {
    this.init()
}
// 通过 this.state 传入你的 App ID, 创建并初始化 RtcEngine 实例。
init = async () => {
    const {appId} = this.state
    this._engine = await RtcEngine.create(appId)
    // 启用音频模块。
    await this._engine.enableAudio()

    // 注册 UserJoined 回调。
    // 远端用户成功加入频道时，会触发该回调，并返回该用户的 id。
    this._engine.addListener('UserJoined', (uid, elapsed) => {
        console.log('UserJoined', uid, elapsed)
        const {peerIds} = this.state
        if (peerIds.indexOf(uid) === -1) {
            this.setState({
                peerIds: [...peerIds, uid]
            })
        }
    })

    // 注册 UserOffline 回调。
    // 远端用户离开频道时，会触发该回调，并返回该用户的 id。
    this._engine.addListener('UserOffline', (uid, reason) => {
        console.log('UserOffline', uid, reason)
        const {peerIds} = this.state
        this.setState({
            // Remove peer ID from state array
            peerIds: peerIds.filter(id => id !== uid)
        })
    })

    // 注册 JoinChannelSuccess 回调。
    // 本地用户成功加入频道时，会触发该回调。
    this._engine.addListener('JoinChannelSuccess', (channel, uid, elapsed) => {
        console.log('JoinChannelSuccess', channel, uid, elapsed)
        this.setState({
            joinSucceed: true
        })
    })
}

```

### 6. 加入频道

完成初始化后，你就可以调用 `joinChannel` 方法加入频道。

```typescript
// 通过 this.state.token 和 this.state.channelName 获取传入的 Token 和频道名。
// 本地用户的 ID。数据类型为整型，且频道内每个用户的 uid 必须是唯一的。若将 uid 设为 0，则 SDK 会自动分配一个 uid，并在 JoinChannelSuccess 回调中报告。
_joinChannel = async () => {
  await this._engine?.joinChannel(this.state.token, this.state.channelName, null, 0);
};
```

### 7. 切换语音设备

开始语音通话后，用户可以点击界面按钮，选择静音或取消静音，切换音频播放设备。

```typescript
// 开启或关闭麦克风。
_switchMicrophone = () => {
  const {openMicrophone} = this.state;
  this._engine
    ?.enableLocalAudio(!openMicrophone)
    .then(() => {
      this.setState({openMicrophone: !openMicrophone});
    })
    .catch(err => {
      console.warn("enableLocalAudio", err);
    });
};

// 选择音频播放设备为扬声器或耳机。
_switchSpeakerphone = () => {
  const {enableSpeakerphone} = this.state;
  this._engine
    ?.setEnableSpeakerphone(!enableSpeakerphone)
    .then(() => {
      this.setState({enableSpeakerphone: !enableSpeakerphone});
    })
    .catch(err => {
      console.warn("setEnableSpeakerphone", err);
    });
};
```

### 8. 渲染用户界面

在 App 组件中调用 render () 方法渲染界面元素，并处理点击按钮事件。

```typescript
render() {
        const {
            channelName,
            joinSucceed,
            openMicrophone,
            enableSpeakerphone,
          } = this.state;
        return (
            <View style={styles.container}>
              <View style={styles.top}>
                <TextInput
                  style={styles.input}
                  onChangeText={(text) => this.setState({ channelName: text })}
                  placeholder={'Channel Name'}
                  value={channelName}
                />
                <Button
                  onPress={joinSucceed ? this._leaveChannel : this._joinChannel}
                  title={`${joinSucceed ? 'Leave' : 'Join'} channel`}
                />
              </View>
              <View style={styles.float}>
                <Button
                  onPress={this._switchMicrophone}
                  title={`Microphone ${openMicrophone ? 'on' : 'off'}`}
                />
                <Button
                  onPress={this._switchSpeakerphone}
                  title={enableSpeakerphone ? 'Speakerphone' : 'Earpiece'}
                />
              </View>
            </View>
        )
 }

```

### 9. 离开频道

根据场景需要，如结束通话、关闭 App 或 App 切换至后台时，调用 `leaveChannel` 离开当前通话频道。

```typescript
_leaveChannel = async () => {
  await this._engine?.leaveChannel();
  this.setState({peerIds: [], joinSucceed: false});
};
```

## 运行项目

部分模拟机可能无法支持本项目的全部功能，建议你在真机中运行该项目。

**在 Android 设备上运行：**

1. 开启 Android 设备的开发者选项，通过 USB 连接线将 Android 设备接入电脑。
2. 在项目根目录下执行 `npx react-native run-android`。

**在 iOS 设备上运行：**

1. 使用 Xcode 打开 `ProjectName/ios/ProjectName.xcworkspace` 文件夹。
2. 通过 USB 线将 iOS 设备接入你的电脑。
3. 在 Xcode 中，点击 **Build and run** 按钮。

运行一段时间后，应用就安装到设备上了。当成功开始语音通话时，你可以听到对方的说话声音。
