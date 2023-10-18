本文介绍如何集成语聊 UIKit 来实现房间的创建、进入、和销毁。

## 示例项目

声网提供 [AUIVoiceRoom](https://github.com/AgoraIO-Community/AUIVoiceRoom/tree/main) 示例项目供你参考。


## 准备开发环境

### 前提条件

- [Xcode](https://apps.apple.com/cn/app/xcode/id497799835?mt=12) 13.0 及以上。
- iOS 设备，版本 13.0 及以上。
- 有效的苹果开发者账号。
- 可以访问互联网的计算机。确保你的网络环境没有部署防火墙，否则无法正常使用声网服务。
- 参考[开始使用声网平台](https://docportal.shengwang.cn/cn/Agora%20Platform/get_appid_token?platform=All%20Platforms)创建声网开发者账号和声网项目。

### 创建项目

本节介绍如何在 Xcode 创建项目：

1. [创建一个新的项目](https://help.apple.com/xcode/mac/current/#/dev07db0e578)，**Application** 选择 **App**，**Interface** 选择 **Storyboard**，**Language** 选择 **Swift**。

    <div class="alert note">如果你没有添加过开发团队信息，会看到 <b>Add account…</b> 按钮。点击该按钮并按照屏幕提示登入 Apple ID，点击 <b>Next</b>，完成后即可选择你的 Apple 账户作为开发团队。</div>

2. 为你的项目设置[自动签名](https://help.apple.com/xcode/mac/current/#/dev23aab79b4)。

3. 设置部署你的 app 的[目标设备](https://help.apple.com/xcode/mac/current/#/deve69552ee5)。

4. 添加项目的设备权限。在项目导航栏中打开 `info.plist` 文件，编辑[属性列表](https://help.apple.com/xcode/mac/current/#/dev3f399a2a6)，添加以下属性：

    | key                                    | type   | value                                                        |
    | -------------------------------------- | ------ | ------------------------------------------------------------ |
    | Privacy - Microphone Usage Description | String | 使用麦克风的目的，例如 for a live interactive streaming |
    | Privacy - Camera Usage Description       | String | 使用摄像头的目的，例如 for a live interactive streaming |

    <div class="alert note"><ul><li>如果你的项目中需要添加第三方插件或库（例如第三方摄像头），且该插件或库的签名与项目的签名不一致，你还需勾选 <b>Hardened Runtime</b> > <b>Runtime Exceptions</b> 中的 <b>Disable Library Validation</b>。</li><li>更多注意事项，可以参考 <a href="https://developer.apple.com/documentation/xcode/preparing_your_app_for_distribution">Preparing Your App for Distribution</a >。</li></ul></div>

### 集成依赖

本节介绍如何集成语聊项目所需的 AScenesKit 和 AUIKit 依赖：

1. 开始前请确保你已安装 CocoaPods，如尚未安装 CocoaPods，参考 [Getting Started with CocoaPods](https://guides.cocoapods.org/using/getting-started.html#getting-started) 安装说明。

2. 参考[克隆仓库](//TODO)在本地获取 `AUIVoiceRoom` 文件夹。

3. 将示例项目中如下文件复制到你的项目中：

    - `AUIVoiceRoom/iOS/AUIKit` 文件夹 //TODO yf确认删除
    - `AUIVoiceRoom/AScenesKit` 文件夹
    - `AUIVoiceRoom/iOS/AUIVoiceRoom/AUIVoiceRoomKeyCenter.swift`

    文件存放路径建议与示例项目中路径保持一致。

4. 在终端里进入你的项目根目录，并运行 `pod init` 命令。项目文件夹下会生成一个 `Podfile` 文本文件。

5. 打开 `Podfile` 文件，修改文件为如下内容。注意将 `Your App` 替换为你的 Target 名称。

    ```shell
    platform :ios, '13.0'
    target 'Your App' do
    # path 与依赖库所在的实际路径一致即可
    pod 'AScenesKit', :path => './AScenesKit'
    end
    ```

6. 在终端内运行 <code>pod install</code> 命令安装依赖。成功安装后，Terminal 中会显示 <code>Pod installation complete!</code>。

### 部署后端

参考[配置示例项目](//TODO)进行部署。

## 实现语聊房 //TODO

如下[时序图](#api-时序图)展示了如何登录即时通讯系统、获取房间列表、创建房间、进入房间、加入 RTC 频道、麦位管理、退出房间、离开 RTC 频道。声网云服务（Service）实现了房间列表的存储和房间生命周期的管理，声网即时通讯（IM）SDK 实现房间内的信令通信，声网 RTC SDK 承担实时音频的业务。本节会详细介绍如何调用声网云服务（`ChatRoomServiceProtocol`）、IM SDK API、RTC SDK API 完成这些逻辑。

<div class="alert note">声网云服务为内部自研服务，暂不对外提供。你可以调用声网云服务的 API 用于测试，但是对于正式环境，声网建议你参考文档自行实现相似的一套服务。如需协助，请<a href="https://docs.agora.io/cn/Agora%20Platform/ticket?platform=All%20Platforms">提交工单</a>。</div>


### 1. 初始化 VoiceRoomUIKit

The initEngine function initializes the VoiceChatUIKit shared instance by setting up some basic configuration information.

It first creates an AUICommonConfig object and sets the following properties:

host: The backend server host URL from KeyCenter.HostUrl
userId: The current user's ID from userInfo.userId
userName: The current user's name from userInfo.userName
userAvatar: The current user's avatar from userInfo.userAvatar
It then calls VoiceChatUIKit.shared.setup() and passes the AUICommonConfig along with nil for the rtcEngine and rtmClient since they will be created internally.

This configures the shared VoiceChatUIKit instance with the basic information it needs to interact with the backend services. The userId, userName, and userAvatar will be used to identify the local user. And the host specifies the server to connect to.

So in summary, initEngine initializes VoiceChatUIKit with some basic app and user configuration before it can be used.


```swift
    private func initEngine() {
        //设置基础信息到VoiceChatUIKit里
        let commonConfig = AUICommonConfig()
        commonConfig.host = KeyCenter.HostUrl
        commonConfig.userId = userInfo.userId
        commonConfig.userName = userInfo.userName
        commonConfig.userAvatar = userInfo.userAvatar
        VoiceChatUIKit.shared.setup(roomConfig: commonConfig,
                                  rtcEngine: nil,
                                  rtmClient: nil)
    }
```

### 2. 获取房间列表

The getRoomInfoList method in onRefreshAction is used to fetch the initial page of room list data from the server when the user pulls to refresh.

Some key points:

It calls getRoomInfoList on VoiceChatUIKit to fetch room data from the server.

It passes nil for lastCreateTime to indicate no filtering, and kListCountPerPage for pageSize to get the first page of results.

In the callback, it reloads the roomList and collectionView with the new data.

It adds a footer for pagination if the returned list is the full page size.

So in summary, getRoomInfoList here retrieves the initial page of rooms to show when the user refreshes the list.

```swift
VoiceChatUIKit.shared.getRoomInfoList(lastCreateTime: nil, pageSize: kListCountPerPage, callback: {[weak self] error, list in
})
```

### 3. 创建房间

The createRoom method on VoiceChatUIKit is used to create a new voice chat room.

It takes in an AUICreateRoomInfo object which contains details about the room to be created, like room name, number of seats etc.

It also takes in a completion handler closure that will be called once the room is created successfully. This closure is passed a AUIRoomInfo object containing details about the newly created room.

The method calls the createRoom method on the roomManager property of VoiceChatUIKit, which seems to make the actual API call to create the room on the server.

Once the room is created successfully, the completion handler closure is called, passing the AUIRoomInfo object containing room details. This info is then used to instantiate a RoomViewController and display the new room's screen.

So in summary, the createRoom method on VoiceChatUIKit provides an easy way to create a new voice chat room from the client side and get back details of the created room.



```swift
let room = AUICreateRoomInfo()
room.roomName = "room name"
room.thumbnail = self.userInfo.userAvatar
room.micSeatCount = UInt(AUIRoomContext.shared.seatCount)
room.micSeatStyle = UInt(AUIRoomContext.shared.seatType.rawValue)
VoiceChatUIKit.shared.createRoom(roomInfo: room) { roomInfo in
    let vc = RoomViewController()
    vc.roomInfo = roomInfo
    self.navigationController?.pushViewController(vc, animated: true)
} failure: { error in
    // 错误提示
    ...
}
```

### 4. 加载房间 //TODO

```swift
```

## 下一步

在创建、进入房间后，你可以参考如下业务流程图开发后续的麦位管理、聊天、礼物等功能模块。

![](https://web-cdn.agora.io/docs-files/1697095578162)