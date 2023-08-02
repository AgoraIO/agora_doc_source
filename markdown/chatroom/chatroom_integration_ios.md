本文介绍如何实现语聊房。

## 示例项目

声网在 [agora-ent-scenarios](https://github.com/AgoraIO-Usecase/agora-ent-scenarios) 仓库中提供[语聊房（普通版）](https://github.com/AgoraIO-Usecase/agora-ent-scenarios/tree/v3.0.0-all-iOS/iOS/AgoraEntScenarios/Scenes/VoiceChatRoom)供你参考。

## 业务流程图

本节展示语聊房中常见的业务流程。

### 进出房间

下图展示创建、进入、退出房间的流程。

![](https://web-cdn.agora.io/docs-files/1690957909911)

### 房主邀请听众上麦

下图展示房主邀请听众上麦的流程。在这个流程中，房主发起上麦邀请，如果听众接受邀请，房主会收到通知。听众上麦并修改麦位，然后发布自己的音频流。

![](https://web-cdn.agora.io/docs-files/1690957919691)

### 听众申请上麦

下图展示听众向房主申请上麦的流程。在这个流程中，听众主动发起上麦申请，如果房主接受申请，房主修改麦位信息以让听众上麦。听众收到上麦消息后，发布自己的音频流。

![](https://web-cdn.agora.io/docs-files/1690957930139)

## 准备开发环境

### 前提条件

- [Xcode](https://apps.apple.com/cn/app/xcode/id497799835?mt=12) 13.0 及以上。
- iOS 设备，版本 13.0 及以上。
- 有效的苹果开发者账号。
- 可以访问互联网的计算机。确保你的网络环境没有部署防火墙，否则无法正常使用声网服务。
- 参考[开始使用声网平台](https://docportal.shengwang.cn/cn/Agora%20Platform/get_appid_token?platform=All%20Platforms)创建声网开发者账号和声网项目。

### 创建项目

秀场直播用到声网 RTC SDK 和即时通讯（IM）SDK。本节介绍如何在 Xcode 创建项目并集成这两个 SDK：

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

5. 将声网 RTC 和即时通讯 SDK 集成到你的项目。开始前请确保你已安装 CocoaPods，如尚未安装 CocoaPods，参考 [Getting Started with CocoaPods](https://guides.cocoapods.org/using/getting-started.html#getting-started) 安装说明。

    1. 在终端里进入项目根目录，并运行 `pod init` 命令。项目文件夹下会生成一个 `Podfile` 文本文件。
    2. 打开 `Podfile` 文件，修改文件为如下内容。注意将 `Your App` 替换为你的 Target 名称。

        ```shell
        platform :ios, '11.0'
        target 'Your App' do
        # 集成 RTC SDK
        # x.y.z 请填写具体的 SDK 版本号，如 4.0.1 或 4.0.0.4。
        # 可通过互动直播发版说明获取最新版本号。
        pod 'AgoraRtcEngine_iOS', 'x.y.z'
        # 集成即时通讯 SDK
        pod 'Agora_Chat_iOS'
        end
        ```

6. 在终端内运行 <code>pod install</code> 命令安装 SDK。成功安装后，Terminal 中会显示 <code>Pod installation complete!</code>。

## 实现语聊房

如下[时序图](#api-时序图)展示了如何登录即时通讯系统、获取房间列表、创建房间、进入房间、加入 RTC 频道、麦位管理、退出房间、离开 RTC 频道。声网云服务（Service）实现了房间列表的存储和房间生命周期的管理，声网即时通讯（IM）SDK 实现房间内的信令通信，声网 RTC SDK 承担实时音视频的业务。本节会详细介绍如何调用声网云服务（ChatRoomServiceProtocol）、IM SDK API、RTC SDK API 完成这些逻辑。

<div class="alert note">声网云服务为内部自研服务，暂不对外提供。你可以调用声网云服务的 API 用于测试，但是对于正式环境，声网建议你参考文档自行实现相似的一套服务。如需协助，请<a href="https://docs.agora.io/cn/Agora%20Platform/ticket?platform=All%20Platforms">提交工单</a>。</div>


### 1. 获取房间列表

调用声网云服务中 `ChatRoomServiceImp` 类的 `fetchRoomList` 方法获取房间列表。获取到房间列表后刷新 UI 并将房间列表展示在界面上。

```swift
ChatRoomServiceImp.getSharedInstance().fetchRoomList(page: 0) { error, rooms in
    self.roomList.refreshControl?.endRefreshing()
    if error == nil {
        guard let rooms = rooms else {return}
        let roomsEntity: VRRoomsEntity = VRRoomsEntity()
        roomsEntity.rooms = rooms
        roomsEntity.total = rooms.count
        self.fillDataSource(rooms: roomsEntity)
        self.roomList.reloadData()
        self.empty.isHidden = (rooms.count > 0)
    } else {
        self.view.makeToast("\(error?.localizedDescription ?? "")")
    }
}
```

### 2. 登录即时通讯系统

参考如下步骤登录即时通讯（IM）系统：

1. 根据[前提条件](#前提条件)在声网控制台创建声网项目后，参考[开启和配置即时通讯服务](https://docs-preprod.agora.io/cn/agora-chat/enable_agora_chat?platform=All%20Platforms)，在声网控制台为你的声网项目开启并配置即时通讯服务。
2. 参考[即时通讯集成概述](https://docs-preprod.agora.io/cn/agora-chat/integration_overview_ios?platform=iOS#用户登录)，获取登录即时通讯系统所需的用户名（ID）和 Token。
3. 调用声网即时通讯（IM）SDK 中 `AgoraChatClient` 类的 [`loginWithUsername:token:completion:`](https://docs-preprod.agora.io/cn/agora-chat/API%20Reference/im_oc/v1.1.0/interface_agora_chat_client.html#ad1f4dbc685867ed236fcb57c2d29c2b0) 方法并传入即时通讯服务的用户名和 Token 以登录即时通讯系统。


```swift
@objc public func loginIM(userName: String, token: String, completion: @escaping (String, AgoraChatError?) -> Void) {
    if AgoraChatClient.shared().isLoggedIn {
        completion(AgoraChatClient.shared().currentUsername ?? "", nil)
    } else {
        // 登录即时通讯系统
        // 此处的 Token 为声网 Chat Token
        // 不要和声网 RTC Token 混淆
        AgoraChatClient.shared().login(withUsername: userName, token: token, completion: completion)
    }
}
```

### 3. 初始化 AgoraRtcEngineKit

参考如下步骤初始化 AgoraRtcEngineKit：

1. 根据[前提条件](#前提条件)在声网控制台创建声网项目后，复制界面的 App ID。
2. 调用声网 RTC SDK 中的 [`sharedEngineWithAppId`](https://docportal.shengwang.cn/cn/live-streaming-premium-4.x/API%20Reference/ios_ng/API/toc_core_method.html#api_irtcengine_create) 方法初始化 `AgoraRtcEngineKit`。

```swift
let rtcKit: AgoraRtcEngineKit = AgoraRtcEngineKit.sharedEngine(withAppId: KeyCenter.AppId, delegate: nil)
```
### 4. 创建并进入房间

1. 调用 `ChatRoomServiceImp` 类中的 `createRoom` 方法创建一个房间。

    ```swift
    ChatRoomServiceImp.getSharedInstance().createRoom(room: entity) { error, room in
        SVProgressHUD.dismiss()
        self.view.window?.isUserInteractionEnabled = true
        if let room = room,error == nil {
            self.entryRoom(room: room)
        } else {
            SVProgressHUD.showError(withStatus: "Create failed!".localized())
        }
    }
    ```

2. 调用 `ChatRoomServiceImp` 类的 `joinRoom` 方法进入房间。

    在这一步里需要填写声网 RTC Token。你可以参考[开始使用声网平台](https://docs.agora.io/cn/Agora%20Platform/get_appid_token?platform=All%20Platforms)从声网控制台获得临时用途的声网 RTC Token。你也可以参考[使用 Token 鉴权](https://docportal.shengwang.cn/cn/live-streaming-premium-4.x/token_server_ios_ng?platform=iOS)获取正式用途的声网 RTC Token。临时 Token 的有效期为 24 小时，建议你仅在测试用途下使用。

    ```swift
    // 显示加载提示
    SVProgressHUD.show(withStatus: "Loading".localized())
    // 生成声网 RTC Token
    // 不要和声网 Chat Token 搞混淆
    NetworkManager.shared.generateToken(channelName: room.channel_id ?? "", uid: VLUserCenter.user.id, tokenType: .token007, type: .rtc) { token in
        VLUserCenter.user.agoraRTCToken = token ?? ""
        // 进入房间
        ChatRoomServiceImp.getSharedInstance().joinRoom(room.room_id ?? "") { error, room_entity in
            SVProgressHUD.dismiss()
            if VLUserCenter.user.chat_uid.isEmpty || VLUserCenter.user.im_token.isEmpty || self.initialError != nil {
                SVProgressHUD.showError(withStatus: "Fetch IMconfig failed!")
                return
            }
            self.mapUser(user: VLUserCenter.user)
            let info: VRRoomInfo = VRRoomInfo()
            info.room = room
            info.mic_info = nil
            self.isDestory = false
            let vc = VoiceRoomViewController(info: info)
            self.navigationController?.pushViewController(vc, animated: true)
            self.normal.roomList.isUserInteractionEnabled = true
        }
    }
    ```

3. 语聊房里需要有消息聊天和语音聊天，因此你还需进行如下操作：

    - 调用声网 IM SDK 中 `joinChatRoom` 实现房间内的消息互动。方法中的参数含义和支持取值请参考 [`joinChatRoom`](https://docs-preprod.agora.io/cn/agora-chat/API%20Reference/im_oc/v1.1.0/protocol_i_agora_chatroom_manager-p.html#ad8d19bd36e60c8af8d04c1f8b4daa2f0)。

        ```swift
        // 实现房间内的消息互动
        @objc func joinedChatRoom(roomId: String, completion: @escaping ((AgoraChatroom?, AgoraChatError?) -> Void)) {
            AgoraChatClient.shared().roomManager?.joinChatroom(roomId, completion: { room, error in
                if error == nil, let id = room?.chatroomId {
                    self.currentRoomId = id
                }
                completion(room, error)
            })
        }
        ```

    - 调用声网 RTC SDK 中 `AgoraRtcEngineKit` 类的 `joinChannelByToken` 加入 RTC 频道以实现房间内的实时音频通话。方法中的参数含义和支持取值请参考 [`joinChannelByToken`](https://docportal.shengwang.cn/cn/live-streaming-premium-4.x/API%20Reference/ios_ng/API/toc_core_method.html#api_irtcengine_joinchannel)。

        ```swift
        // 实现房间内的语音互动
        rtcKit.delegate = self
        rtcKit.enableAudioVolumeIndication(200, smooth: 3, reportVad: true)
        self .setParametersWithMD()
        // 在线 K 歌房和泛娱乐社交场景下推荐设置
        if type == .ktv || type == .social {
            // 设置频道属性为直播
            rtcKit.setChannelProfile(.liveBroadcasting)
            // 设置 48 kHz 采样率，音乐编码，单声道，编码码率最大值为 96 Kbps
            rtcKit.setAudioProfile(.musicHighQuality)
            // 设置为高音质场景
            rtcKit.setAudioScenario(.gameStreaming)
        } else if type == .game {
            // 1 对 1 游戏陪玩通话场景下推荐
            // 设置频道属性为通信
            rtcKit.setChannelProfile(.communication)
        } else if type == .anchor {
            // 专业直播场景下推荐设置
            // 设置频道属性为直播
            rtcKit.setChannelProfile(.liveBroadcasting)
            // 指定 48 kHz 采样率，音乐编码，双声道，编码码率最大值为 128 Kbps
            rtcKit.setAudioProfile(.musicHighQualityStereo)
            // 设置为高音质场景
            rtcKit.setAudioScenario(.gameStreaming)
            // 设置私有参数以获得好的实时音频互动体验
            rtcKit.setParameters("{\"che.audio.custom_payload_type\":73}")
            rtcKit.setParameters("{\"che.audio.custom_bitrate\":128000}")
            rtcKit.setParameters("{\"che.audio.input_channels\":2}")
        }
        setAINS(with: .mid)
        rtcKit.setParameters("{\"che.audio.start_debug_recording\":\"all\"}")
        rtcKit.setEnableSpeakerphone(true)
        rtcKit.setDefaultAudioRouteToSpeakerphone(true)
        // 加入 RTC 频道
        // 此处的 Token 为声网 RTC Token
        let code: Int32 = rtcKit.joinChannel(byToken: token, channelId: channelName, info: nil, uid: UInt(rtcUid ?? 0))
        ```

### 5. 麦位管理

具体步骤详见[麦位管理](./chatroom_mic_seat_ios)。

### 6. 退出房间

1. 调用 `ChatRoomServiceImp` 类的 `leaveRoom` 方法离开房间。

    ```swift
    ChatRoomServiceImp.getSharedInstance().leaveRoom(self.roomInfo?.room?.room_id ?? "") { _, _ in
    }
    ```


2. 调用 `AgoraRtcEngineKit` 类的 [`leaveChannel`](https://docportal.shengwang.cn/cn/live-streaming-premium-4.x/API%20Reference/ios_ng/API/toc_core_method.html#api_irtcengine_leavechannel) 方法离开 RTC 频道。

    ```swift
    rtcKit.leaveChannel(nil)
    ```

3. 调用 [`leaveChatroom:completion:`](https://docs-preprod.agora.io/cn/agora-chat/API%20Reference/im_oc/v1.1.0/protocol_i_agora_chatroom_manager-p.html#ae9b671ece1a36ad8ac26375d91755467) 离开聊天室，调用 [`destroyChatroom:`](https://docs-preprod.agora.io/cn/agora-chat/API%20Reference/im_oc/v1.1.0/protocol_i_agora_chatroom_manager-p.html#a1e3a6bacf44a96ff37b34d2068c84386) 销毁聊天室。调用 [`destroy`](https://docportal.shengwang.cn/cn/live-streaming-premium-4.x/API%20Reference/ios_ng/API/toc_core_method.html#api_irtcengine_release) 销毁 RTC 引擎。

    ```swift
    AgoraChatClient.shared().roomManager?.leaveChatroom(currentRoomId, completion: { error in
    })
    AgoraChatClient.shared().roomManager?.destroyChatroom(currentRoomId)
    AgoraRtcEngineKit.destroy()
    rtcKit.delegate = nil
    ```

### API 时序图

![](https://web-cdn.agora.io/docs-files/1690957961923)