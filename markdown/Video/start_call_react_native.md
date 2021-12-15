---
title: 实现视频通话
platform: React Native
updatedAt: 2021-02-07 01:46:06
---

本文介绍如何使用 Agora React Native SDK 快速实现视频通话。

## 示例项目

Agora 在 GitHub 提供一个开源的视频通话示例项目 [Agora-RN-Quickstart](https://github.com/AgoraIO-Community/Agora-RN-Quickstart)。在实现相关功能前，你可以下载并体验。

## 前提条件

### 开发环境要求

如果你的目标平台为 iOS，你的开发环境需要满足以下需求：

- React Native 0.59.10 或以上版本
- macOS 操作系统
- Node 10 或以上
- Xcode 9.4 或以上
- CocoaPods
- iOS 8.0 或以上设备

如果你的目标平台为 Android，你的开发环境需要满足以下需求：

- React Native 0.59.10 或以上版本
- macOS 、Windows 或 Linux 操作系统
- Node 10 或以上
- Java Development Kit (JDK) 8 或以上
- 最新版本的 Android Studio
- Android 5.0 或以上设备

<div class="alert info">关于搭建开发环境的更多注意事项，详见<a href="https://reactnative.dev/docs/environment-setup">搭建开发环境</a >。</div>

### 其他要求

有效的 Agora [开发者账号](/cn/Agora%20Platform/sign_in_and_sign_up?platform=All%20Platforms)。

<div class="alert note">如果你的网络环境部署了防火墙，请根据<a href="/cn/Agora%20Platform/firewall?platform=All%20Platforms">应用企业防火墙限制</a >。</div>

## 创建项目

1. 确保你已根据你使用的操作系统、针对的目标平台，完成了开发环境的搭建。

2. 运行以下命令创建并初始化一个新项目。

```
npx react-native init ProjectName
```

运行完成后，会自动生成一个简单的示例项目。

3. 启动你的 Andoird 或 iOS 模拟器，执行以下命令运行你的项目：

   a. 在项目根目录下执行 `npx react-native start` 启动 Metro。
   b. 在项目目录下再打开一个终端，执行 `npx react-native run-android` 运行 Android 应用或执行 `npx react-native run-ios` 运行 iOS 应用。

如果配置没有问题，你可以看到应用自动安装到模拟器上并开始运行。

你也可以在 Android 或 iOS 真机上运行应用，详见[在设备上运行](https://reactnative.dev/docs/running-on-device)。

现在你已经成功运行了项目，可以开始尝试集成 Agora SDK 并修改项目。

## 集成 SDK

本节介绍如何在 React Native 0.60.0 或以上版本集成 Agora React Native SDK。

<div class="alert note">如果你使用的 React Native 版本为 0.59.x， 请参考<a href="https://github.com/AgoraIO-Community/react-native-agora/blob/master/README.zh.md#安装在-react-native--059x">安装在（React Native == 0.59.x）</a >。</div>

1. 下载最新版的 Agora React Native SDK：

   **方法一**：使用 npm 下载

   ```
    npm i --save react-native-agora
   ```

   **方法二**：使用 yarn 下载

   ```
    // 安装 yarn
    npm install -g yarn
    // 使用 yarn 下载 Agora React Native SDK
    yarn add react-native-agora
   ```

   <div class="alert note">React Native 0.60.0 或以上版本支持自动链接原生模块，请勿手动链接。详见  <a href="https://github.com/react-native-community/cli/blob/master/docs/autolinking.md">Autolinking</a >。</div>

2. 如果你的目标平台是 iOS， 执行 `npx pod-install` 安装 SDK。

<div class="alert note"> 请确保你已安装 <b>CocoaPods</b>。你可以参考 <a href="https://guides.cocoapods.org/using/getting-started.html#getting-started">Getting Started with CocoaPods</a >。</div>

3. Agora React Native SDK 原生层基于 Swift 语言开发，请确保你的工程支持编译 Swift，否则编译 iOS 应用时会报错。

a. 用 Xcode 打开 `ios/ProjectName.xcworkspace` 文件夹。
b. 点击 **File > New > File**， 选择 **iOS** > **Swift File**，点击 **Next** > **Create**，新建一个空的 `File.swift` 文件。

## 添加 TypeScript 支持

本文中的示例代码使用 TypeScript 编写。如果你想直接使用本文中的示例代码，需要在项目中添加对 TypeScript 的支持。

1. 在项目根目录下执行以下命令安装 TypeScript 相关依赖。

   **方法一**：使用 npm 安装
   `npm install --save-dev typescript @types/jest @types/react @types/react-native @types/react-test-renderer `
   **方法二**：使用 yarn 安装
   确保你已经安装 yarn。
   `yarn add --dev typescript @types/jest @types/react @types/react-native @types/react-test-renderer `

2. 在项目根目录下创建 `tsconfig.json` 文件，并复制以下代码到该文件：

```
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

```
module.exports = {
   preset: 'react-native',
   moduleFileExtensions: ['ts', 'tsx', 'js', 'jsx', 'json', 'node']
};
```

4. 将根目录下的 `App.js` 文件重命名为 `App.tsx` 文件。

<div class="alert info">关于在 React Native 项目中使用 TypeSscript 的更多信息，详见<a href="https://reactnative.dev/docs/typescript">使用 TypeScript</a >。</div>

## 基本流程

### 1. 自定义用户界面

根据场景需要，为你的项目创建视频通话的用户界面。

在视频通话中，Agora 推荐你添加如下用户界面元素：

- 开始通话按钮
- 结束通话按钮
- 本地视频窗口
- 远端视频窗口

你可以参考 `Agora-RN-Quickstart` 示例项目，新建一个 `components` 文件夹并在该文件夹下创建 `Style.ts` 文件，集中存放定义界面元素样式的代码，以便在其他组件的渲染函数中引用。

`Agora-RN-Quickstart` 示例项目中定义样式的代码如下：

```
import {Dimensions, StyleSheet} from 'react-native'

const dimensions = {
    width: Dimensions.get('window').width,
    height: Dimensions.get('window').height,
}

export default StyleSheet.create({
    max: {
        flex: 1,
    },
    buttonHolder: {
        height: 100,
        alignItems: 'center',
        flex: 1,
        flexDirection: 'row',
        justifyContent: 'space-evenly',
    },
    button: {
        paddingHorizontal: 20,
        paddingVertical: 10,
        backgroundColor: '#0093E9',
        borderRadius: 25,
    },
    buttonText: {
        color: '#fff',
    },
    fullView: {
        width: dimensions.width,
        height: dimensions.height - 100,
    },
    remoteContainer: {
        width: '100%',
        height: 150,
        position: 'absolute',
        top: 5
    },
    remote: {
        width: 150,
        height: 150,
        marginHorizontal: 2.5
    },
    noUserText: {
        paddingHorizontal: 10,
        paddingVertical: 5,
        color: '#0093E9',
    },
})

```

### 2. 导入类

打开 `App.tsx` 文件，删除所有代码。在 `App.tsx` 文件的开头添加如下代码：

```
import React, {Component} from 'react'
import {Platform, ScrollView, Text, TouchableOpacity, View} from 'react-native'
// 导入 RtcEngine 类和视图渲染组件。
import RtcEngine, {RtcLocalView, RtcRemoteView, VideoRenderMode} from 'react-native-agora'
// 导入自定义的用户界面样式。
import styles from './components/Style'

```

### 3. 获取设备权限（仅 Android 平台）

<div class="alert note">此步骤仅适用于 Android 平台，在 iOS 平台不会执行。</div>

在 Android 设备上，要获得麦克风和摄像头的使用权限，需要弹出提示框供用户选择。

`App.tsx` 文件中添加如下代码，设置获取设备麦克风和摄像头使用权限的提示框。

```
const requestCameraAndAudioPermission = async () =>{
    try {
        const granted = await PermissionsAndroid.requestMultiple([
            PermissionsAndroid.PERMISSIONS.CAMERA,
            PermissionsAndroid.PERMISSIONS.RECORD_AUDIO,
        ])
        if (
            granted['android.permission.RECORD_AUDIO'] === PermissionsAndroid.RESULTS.GRANTED
            && granted['android.permission.CAMERA'] === PermissionsAndroid.RESULTS.GRANTED
        ) {
            console.log('You can use the cameras & mic')
        } else {
            console.log('Permission denied')
        }
    } catch (err) {
        console.warn(err)
    }
}

```

### 4. 创建 App 组件

创建 App 组件时，需要定义 App ID，Token 和频道名，用于初始化 `RtcEngine` 和加入频道。

- `appId`：你的 Agora 项目的 App ID。详见[获取 App ID](/cn/Agora%20Platform/token?platform=All%20Platforms#a-name--appida使用-app-id-鉴权)。

- `channelName`：传入能标识频道的频道 ID。App ID 相同、频道 ID 相同的用户会进入同一个频道。

- `token`：传入能标识用户角色和权限的 Token。该 Token 必须是使用上述 App ID 和频道名生成的 Token。可设为如下一个值：

  - 临时 Token。临时 Token 服务有效期为 24 小时。你可以在控制台里生成一个临时 Token，详见[获取临时 Token](/cn/Agora%20Platform/token?platform=All%20Platforms#get-a-temporary-token)。

  - 在你的服务器端生成的 Token。在安全要求高的场景下，我们推荐你使用此种方式生成的 Token，详见[生成 Token](/cn/Video/token_server?platform=All%20Platforms)。

    <div class="alert note">若项目已启用 App 证书，请使用 Token。</div>

```
// 定义一个 Props 接口。
interface Props {
}

// 定义一个 State 接口。
interface State {
    appId: string,
    channelName: string,
    token: string,
    joinSucceed: boolean,
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
            appId: 'yourAppId',
            channelName: 'yourChannel',
            token: 'yourToken',
            joinSucceed: false,
            peerIds: [],
        }
        if (Platform.OS === 'android') {
            requestCameraAndAudioPermission().then(() => {
                console.log('requested!')
            })
        }
    }
    // 其他代码，见步骤 5 至步骤 10。
    ...
}

```

### 5. 初始化 RtcEngine

在调用其他 Agora API 前，需要创建并初始化 `RtcEngine` 对象。

你还可以根据场景需要，在初始化时注册想要监听的回调事件，如本地用户加入频道，远端用户加入频道及远端用户离开频道等。

在 App 组件 `// 其他代码` 的下方添加如下代码：

```
// 将组件挂载到 DOM 中。
componentDidMount() {
    this.init()
}
// 通过 this.state 传入你的 App ID, 创建并初始化 RtcEngine 实例。
init = async () => {
    const {appId} = this.state
    this._engine = await RtcEngine.create(appId)
    // 启用视频模块。
    await this._engine.enableVideo()
    // 开启本地视频预览。
    await this._engine.startPreview()

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

```
// 通过 this.state.token 和 this.state.channelName 获取传入的 Token 和频道名。
// 本地用户的 ID。数据类型为整型，且频道内每个用户的 uid 必须是唯一的。若将 uid 设为 0，则 SDK 会自动分配一个 uid，并在 JoinChannelSuccess 回调中报告。
startCall = async () => {
        await this._engine?.joinChannel(this.state.token, this.state.channelName, null, 0)
    }

```

### 7. 渲染用户界面

在 App 组件中调用 `render()` 方法渲染界面元素，并处理点击按钮事件。

```
render() {
        return (
            <View style={styles.max}>
                <View style={styles.max}>
                    <View style={styles.buttonHolder}>
                        <TouchableOpacity
                            onPress={this.startCall}
                            style={styles.button}>
                            <Text style={styles.buttonText}> Start Call </Text>
                        </TouchableOpacity>
                        <TouchableOpacity
                            onPress={this.endCall}
                            style={styles.button}>
                            <Text style={styles.buttonText}> End Call </Text>
                        </TouchableOpacity>
                    </View>
                    {this._renderVideos()}
                </View>
            </View>
        )
    }

```

### 8. 渲染本地用户的视图

设置本地用户的视图，加入频道后，用户可以看到自己的画面。你还可以在加入频道前调用 `startPreview` 开启本地视频预览。

```
_renderVideos = () => {
        const {joinSucceed} = this.state
        return joinSucceed ? (
            <View style={styles.fullView}>
                // 将视频渲染模式设为 Hidden, 即优先保证视窗被填满。
                <RtcLocalView.SurfaceView
                    style={styles.max}
                    channelId={this.state.channelName}
                    renderMode={VideoRenderMode.Hidden}/>
                {this._renderRemoteVideos()}
            </View>
        ) : null
    }

```

### 9. 渲染远端用户的视图

视频通话中，通常也需要看到其他用户。在加入频道后，传入远端用户的 uid，设置远端用户的视图。

```
_renderRemoteVideos = () => {
        const {peerIds} = this.state
        return (
            <ScrollView
                style={styles.remoteContainer}
                contentContainerStyle={{paddingHorizontal: 2.5}}
                horizontal={true}>
                {peerIds.map((value, index, array) => {
                    return (
                        // 将视频渲染模式设为 Hidden, 即优先保证视窗被填满。
                        <RtcRemoteView.SurfaceView
                            style={styles.remote}
                            uid={value}
                            channelId={this.state.channelName}
                            renderMode={VideoRenderMode.Hidden}
                            zOrderMediaOverlay={true}/>
                    )
                })}
            </ScrollView>
        )
    }

```

### 10. 离开频道

根据场景需要，如结束通话、关闭 App 或 App 切换至后台时，调用 `leaveChannel` 离开当前通话频道。

```
endCall = async () => {
        await this._engine?.leaveChannel()
        this.setState({peerIds: [], joinSucceed: false})
    }

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

运行一段时间后，应用就安装到设备上了。当成功开始视频通话时，你可以同时看到本地和远端的视图。
