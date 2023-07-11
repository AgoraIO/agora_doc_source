本文介绍如何实现语聊房。

## 示例项目

声网在 [agora-ent-scenarios](https://github.com/AgoraIO-Usecase/agora-ent-scenarios) 仓库中提供[语聊房（普通版）](https://github.com/AgoraIO-Usecase/agora-ent-scenarios/tree/v3.0.0-all-iOS/iOS/AgoraEntScenarios/Scenes/VoiceChatRoom)和[语聊房（空间音效版）](https://github.com/AgoraIO-Usecase/agora-ent-scenarios/tree/v3.0.0-all-iOS/iOS/AgoraEntScenarios/Scenes/SpatialAudio)源代码供你参考。

## 业务流程图

### 进出房间

下图展示创建、进入、退出房间的流程。

#TODO

### 房主邀请观众上麦

下图展示房主邀请观众上麦的流程。在这个流程中，房主发起上麦邀请，如果观众接受邀请，房主会收到通知。观众上麦并修改麦位，然后发布自己的音频流。

#TODO

### 观众申请上麦

下图展示观众向房主申请上麦的流程。在这个流程中，观众主动发起上麦申请，如果房主接受申请，房主修改麦位信息以让观众上麦。观众收到上麦消息后，发布自己的音频流。

#TODO

## 准备开发环境

### 前提条件

- [Xcode](https://apps.apple.com/cn/app/xcode/id497799835?mt=12) 12.0 及以上。
 - iOS 设备，版本 13.0 及以上。
 - 有效的苹果开发者账号。
 - 可以访问互联网的计算机。确保你的网络环境没有部署防火墙，否则无法正常使用声网服务。
 - 有效的声网[开发者账号](https://docs.agora.io/cn/Agora%20Platform/sign_in_and_sign_up)和声网项目。请参考[开始使用声网平台](https://docs.agora.io/cn/Agora%20Platform/get_appid_token?platform=All%20Platforms)从声网控制台获得以下信息：
   - App ID：声网随机生成的字符串，用于识别你的项目。
   - 临时 Token：Token 也称为动态密钥，在客户端加入频道时对用户鉴权。临时 token 的有效期为 24 小时。
   - 频道名：用于标识频道的字符串。


### 创建项目

#TODO


## 实现语聊房

语聊房通过ChatRoomServiceProtocol(Service)来实现房间列表的存储和房间生命周期管理，依赖AgoraChat SDK(环信SDK)来实现房间内的信令通信，房间管理的时序图如下

### 1. 登录信令系统

首先在房间列表页需要获取环信的token和userName来进行登录操作

```swift
@objc public func loginIM(userName: String, token: String, completion: @escaping (String, AgoraChatError?) -> Void) {
    if AgoraChatClient.shared().isLoggedIn {
        completion(AgoraChatClient.shared().currentUsername ?? "", nil)
    } else {
        AgoraChatClient.shared().login(withUsername: userName, token: token, completion: completion)
    }
}
```

### 2. 获取房间列表

可以通过fetchRoomList来刷新

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

### 3. 创建房间

通过createRoom方法创建

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

### 4. 加入房间

通过joinRoom方法加入

加入房间后可以通过调用加入RTC频道来实现聊天室音频通话

```swift
SVProgressHUD.show(withStatus: "Loading".localized())
NetworkManager.shared.generateToken(channelName: room.channel_id ?? "", uid: VLUserCenter.user.id, tokenType: .token007, type: .rtc) { token in
    VLUserCenter.user.agoraRTCToken = token ?? ""
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

### 5. 麦位管理

#TODO

### 6. 退出房间

退出房间后需要调用离开RTC频道来结束音频聊通话

```swift
ChatRoomServiceImp.getSharedInstance().leaveRoom(self.roomInfo?.room?.room_id ?? "") { _, _ in
}
```
