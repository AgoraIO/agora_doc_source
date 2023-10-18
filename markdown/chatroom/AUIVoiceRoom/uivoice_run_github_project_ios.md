本文介绍如何快速跑通 [AUIVoiceRoom/iOS](https://github.com/AgoraIO-Community/AUIVoiceRoom/tree/main/iOS) 示例项目，体验在线语聊房。

如需更深入了解项目代码，请参考 [AScenesKit](https://github.com/AgoraIO-Community/AUIVoiceRoom/tree/main/iOS/AScenesKit) 和 [AUIKit](https://github.com/AgoraIO-Community/AUIKit/blob/main/iOS/README_zh.md)。

## 项目技术架构

![](https://web-cdn.agora.io/docs-files/1697538180703)

架构解释：

- `AUIVoiceRoom`：代表语聊房 App。
    - Controller：用于管理语聊 App 中房间列表页面和单个房间的详情页面。
- `AScenesKit`：为语聊场景提供业务逻辑的组装模块。
    - `VoiceChatUIKit`：负责统一调度 `VoiceChatRoomView` 和 `VoiceChatRoomService`，并管理房间。
    - `VoiceChatRoomView`：语聊房的容器 View。用于管理 AUIKit 提供的 UI。
    - `VoiceChatRoomService`：语聊房的 Service。用于管理 AUIKit 提供的 Service。
    - ViewBinder：用于将 `VoiceChatRoomView` 和 `VoiceChatRoomService` 绑定。
- `AUIKit`：基础库。
    - UI：基础 UI 组件。
    - Service：上麦、聊天、送礼物等业务能力。


## 前提条件

- [Git](https://git-scm.com/downloads)
- [CocoaPods](https://guides.cocoapods.org/using/getting-started.html#getting-started)
- [Xcode](https://apps.apple.com/cn/app/xcode/id497799835?mt=12) 13.0 及以上
- iOS 设备，版本 13.0 及以上
- 有效的苹果开发者账号
- 有效的声网[开发者账号](https://docs.agora.io/cn/Agora%20Platform/sign_in_and_sign_up)

<div class="alert note">声网推荐使用真机运行项目。部分模拟机可能存在功能缺失或者性能问题。</div>

## 克隆仓库

1. 在根目录下运行以下命令克隆 `AUIVoiceRoom` 仓库到本地：

    ```shell
    git clone git@github.com:AgoraIO-Community/AUIVoiceRoom.git
    ```

2. 在 `AUIVoiceRoom/iOS/AUIVoiceRoom` 目录下运行 `pod update`，然后等待依赖库安装完成。

## 配置示例项目

1. 参考[使用语聊后端服务](//TODO)进行部署。

2. 在 `AUIVoiceRoom/iOS/AUIVoiceRoom/AUIVoiceRoom/KeyCenter.swift` 文件中设置你的后端服务主机地址：

    ```swift
    static var HostUrl: String = <#Your Host Url#>
    ```

    如果你暂无意部署后端服务，可以使用 `KeyCenter.swift` 里默认的地址。默认地址仅用于测试体验，请你不要商用。

## 编译并运行示例项目

1. 连接上 iOS 设备，点击 `AUIVoiceRoom.xcworkspace` 文件以通过 Xcode 打开项目，并在 **iOS Device** 选项中勾选上你的 iOS 设备。

2. 在项目 **TARGETS** 下的 **Signing & Capabilities** 界面勾选 **Automatically manage signing**，配置你的苹果开发者账号和 **Bundle Identifier**。Bundle ID 用于在设备上唯一标识应用程序。在开发应用时，你需要设置 Bundle ID。

3. 点击 <img src="https://web-cdn.agora.io/docs-files/1639710560035" width="25" style="display: inline;"/> 开始编译。

4. 编译成功后，你的 iOS 设备上会出现语聊应用。在 iOS 系统设置中将该应用设为信任开发者后你才能打开应用。

5. 打开应用，即可进行体验。房主可以创建语聊房；观众可以加入语聊房。