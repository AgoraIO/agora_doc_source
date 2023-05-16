本文通过声动互娱项目介绍如何在在语聊房中进行麦位管理。

麦位管理涉及用户上下麦、麦位静音和状态锁定等操作。声网即时通讯（环信）SDK 提供消息通讯的能力，声网 RTC SDK 提供控制用户音视频流收发的能力。

## 1. 麦位操作

通过 ChatRoomServiceImp 类的 subscribeEvent 方法注册回调事件，监听房间内的变化。

```swift
ChatRoomServiceImp.getSharedInstance().subscribeEvent(with: self)
```

### 上麦

#### 房主邀请用户上麦

![](https://web-cdn.agora.io/docs-files/1684231366436)

1. 房主调用 ChatRoomServiceImp 的 startMicSeatInvitation 方法，开始邀请用户上麦。

```swift
// 邀请上麦
private func inviteUser(user: VRUser?) {
    SVProgressHUD.show()
    let chat_uid: String = user?.chat_uid ?? ""
    ChatRoomServiceImp.getSharedInstance().startMicSeatInvitation(chatUid: chat_uid, index: idx < 0 ? nil:idx) { error, flag in
        SVProgressHUD.dismiss()
        self.view.makeToast(flag == true ? "Invitation sent!".localized() : "Invited failed!".localized())
    }
}
```

2. 房间内其他所有用户都注册 onReceiveSeatInvitation 回调，以获取房主邀请上麦的通知。

```swift
// 接收到邀请通知
func onReceiveSeatInvitation(roomId: String, user: VRUser) {
    self.showInviteMicAlert(index: user.mic_index)
}
```

3. 收到房主上麦邀请的用户会看到邀请弹窗，观众可以选择是否接受邀请：

    - 用户可以调用 ChatRoomServiceImp 的 acceptMicSeatInvitation 方法接受邀请。
    - 用户也可以调用 ChatRoomServiceImp 的 refuseInvite 方法拒绝邀请。


```swift
// 接受邀请
func agreeInvite(index: Int?) {
    var idx: Int?
    if index != -1, index != 0 {
        idx = index
    }
    ChatRoomServiceImp.getSharedInstance().acceptMicSeatInvitation(index: idx,completion: { error, mic in
        if error == nil,let mic = mic {
            self.rtcView.updateUser(mic)
            self.local_index = mic.mic_index
            self.rtckit.setClientRole(role: .owner)
            self.chatBar.refresh(event: .handsUp, state: .disable, asCreator: self.isOwner)
            self.chatBar.refresh(event: .mic, state: .unSelected, asCreator: self.isOwner)
            self.rtckit.muteLocalAudioStream(mute: mic.status != 0)
            self.checkEnterSeatAudioAuthorized()
        } else {
            self.view.makeToast("\(error?.localizedDescription ?? "")",point: self.toastPoint, title: nil, image: nil, completion: nil)
        }
    })
}
```

```swift
// 拒绝邀请
func refuse() {
    ChatRoomServiceImp.getSharedInstance().refuseInvite(chat_uid: self.roomInfo?.room?.owner?.chat_uid ?? "") { _, _ in
    }
}
```

4. 如果用户接受上麦邀请，那么房内其他用户都会收到麦位更新的通知。

```swift
// 麦位更新
func onSeatUpdated(roomId: String, mics: [VRRoomMic], from fromId: String) {
    self.updateMic(mics, fromId: fromId)
}
```

注意：多个观众同时主动修改麦位时会产生冲突。例如，房主邀请多观众，然后多个观众同时点击，可能会出现A观众上麦之后被B观众踢下去的情况。后续集成方案会修改成由房主决定谁上麦而不是观众决定自己上麦。

#### 用户申请上麦

![](https://web-cdn.agora.io/docs-files/1684231374938)

1. 用户调用 ChatRoomServiceImp 的 startMicSeatApply 方法向房主发送申请上麦的请求。

```swift
// 申请上麦
func requestSpeak(index: Int?) {
    ChatRoomServiceImp.getSharedInstance().startMicSeatApply(index: index) { error, flag in
        if error == nil {
            if flag {
                self.chatBar.refresh(event: .handsUp, state: .selected, asCreator: false)
                self.view.makeToast("Apply success!".localized(), point: self.toastPoint, title: nil, image: nil, completion: nil)
            } else {
                self.view.makeToast("Apply failed!".localized(), point: self.toastPoint, title: nil, image: nil, completion: nil)
            }
        } else {
        }
    }
}
```

2. 如果用户希望取消上麦申请，可以调用 ChatRoomServiceImp 的 cancelMicSeatApply 方法。

```swift
// 观众取消自己的上麦申请
func cancelRequestSpeak(index: Int?) {
    ChatRoomServiceImp.getSharedInstance().cancelMicSeatApply(chat_uid: self.roomInfo?.room?.owner?.chat_uid ?? "") { error, flag in
        if error == nil {
            self.view.makeToast("Cancel apply success!".localized(), point: self.toastPoint, title: nil, image: nil, completion: nil)
            self.chatBar.refresh(event: .handsUp, state: .unSelected, asCreator: false)
        } else {
            self.view.makeToast("Cancel apply failed!".localized(), point: self.toastPoint, title: nil, image: nil, completion: nil)
        }
    }
}
```

3. 房间内其他所有用户都注册 onReceiveSeatRequest 回调，以获取用户申请上麦的信息更新，从而刷新上麦申请列表。

```swift
// 房主收到申请上麦信息
func onReceiveSeatRequest(roomId: String, applicant: VoiceRoomApply) {
    self.chatBar.refresh(event: .handsUp, state: .unSelected, asCreator: true)
}
```

4. 房主调用 ChatRoomServiceImp 的 acceptMicSeatApply 方法，以同意某个用户的上麦申请。

```swift
// 房主同意观众上麦申请
private func agreeUserApply(user: VoiceRoomApply?) {
    SVProgressHUD.show()
    guard let user1 = user?.member else { return }
    ChatRoomServiceImp.getSharedInstance().acceptMicSeatApply(chatUid: user1.chat_uid ?? "", completion: { error,mic  in
        SVProgressHUD.dismiss()
        if self.agreeApply != nil,let mic = mic {
            self.agreeApply!(mic)
        }
        self.tableView.reloadData()
        let warningMessage = (error == nil ? "Agree success!".localized():"Agree failed!".localized())
        self.view.makeToast(warningMessage)
    })
}
```

5. 如果房主同意某个用户的上麦申请，那么房内其他用户都收到麦位更新的通知。

如果房主同意上麦申请，房间内所有用户收到麦位更新消息，更新之后的RTC操作请参考RTC上麦和RTC下麦操作

```swift
// 收到同意申请上麦
func onSeatUpdated(roomId: String, mics: [VRRoomMic], from fromId: String) {
    self.updateMic(mics, fromId: fromId)
}
```

注意：目前声动互娱没有提供房主拒绝上麦申请的 API。

#### 切换上麦用户角色

不论是房主邀请，还是用户主动申请，在用户上麦后，你需要将其角色从观众切换成主播（broadcaster），以让用户可以发送音频流。

```swift
rtcKit.setClientRole(.broadcaster)
```

### 2. 下麦

#### 1. 主动下麦

通过ChatRoomServiceImp的leaveMic方法

```swift
// 主动下麦
func leaveMic(with index: Int) {
    chatBar.refresh(event: .mic, state: .selected, asCreator: false)
    ChatRoomServiceImp.getSharedInstance().leaveMic(mic_index: index) { error, mic in
        if error == nil,let mic = mic {
            self.rtcView.updateUser(mic)
            self.rtckit.setClientRole(role: .audience)
            self.local_index = nil
            self.chatBar.refresh(event: .handsUp, state: .unSelected, asCreator: self.isOwner)
            self.chatBar.refresh(event: .mic, state: .selected, asCreator: self.isOwner)
        }
    }
}
```

#### 2. 被踢下麦

通过ChatRoomServiceImp的kickOff方法

```swift
// 踢用户下麦
func kickoff(with index: Int) {
    ChatRoomServiceImp.getSharedInstance().kickOff(mic_index: index) { error, mic in
        if error == nil,let mic = mic {
            self.rtcView.updateUser(mic)
        }
    }
}
```

#### 麦位更新回调

触发上述两个下麦操作，那么此时房间内其他人会收到麦位更新通知

```swift
func onSeatUpdated(roomId: String, mics: [VRRoomMic], from fromId: String) {
    self.updateMic(mics, fromId: fromId)
}
```

### 3. 麦位静音/取消静音

#### 1. 静麦

标记为不允许指定连麦主播发言，通过该标记触发RTC相关静音操作，通过ChatRoomServiceImp.forbidMic方法

```swift
// 禁言指定麦位
func mute(with index: Int) {
    ChatRoomServiceImp.getSharedInstance().forbidMic(mic_index: index) { error, mic in
        if error == nil,let mic = mic {
            self.rtcView.updateUser(mic)
        }
    }
}
```

#### 2. 取消静麦

标记为恢复连麦主播的发言权限，通过该标记触发RTC相关取消静音操作，通过ChatRoomServiceImp.unForbidMic方法

```swift
// 取消禁言指定麦位
func unMute(with index: Int) {
    if let user = roomInfo?.mic_info?[index] {
        if user.status == 1 && index != 0 && isOwner { return }
    }
    ChatRoomServiceImp.getSharedInstance().unForbidMic(mic_index: index) { error, mic in
        if error == nil {
            self.chatBar.refresh(event: .handsUp, state: .unSelected, asCreator: false)
            if let mic = mic {
                self.rtcView.updateUser(mic)
            }
        }
    }
}
```

#### 麦位更新回调

触发上述两个操作，那么此时房间内其他人会收到麦位更新通知，后续的RTC操作请参考RTC静音/取消静音

```swift
func onSeatUpdated(roomId: String, mics: [VRRoomMic], from fromId: String) {
    self.updateMic(mics, fromId: fromId)
}
```

### 4. 锁麦/取消锁麦

#### 1. 锁麦

该操作执行后不允许任何人上该麦位，通过调用ChatRoomServiceImp的lockMic方法

```
// 锁麦
func lock(with index: Int) {
    ChatRoomServiceImp.getSharedInstance().lockMic(mic_index: index) { error, mic in
        if error == nil,let mic = mic {
            self.rtcView.updateUser(mic)
        }
    }
}
```

#### 2. 取消锁麦

该操作使指定麦位恢复空闲状态，观众可以在该麦位申请上麦，通过调用ChatRoomServiceImp的unLockMic方法

```
// 取消锁麦
func unLock(with index: Int) {
    ChatRoomServiceImp.getSharedInstance().unLockMic(mic_index: index) { error, mic in
        if error == nil,let mic = mic {
            self.rtcView.updateUser(mic)
        }
    }
}
```

#### 麦位更新回调

触发上述两个操作，那么此时房间内其他人会收到麦位更新通知

```swift
func onSeatUpdated(roomId: String, mics: [VRRoomMic], from fromId: String) {
    self.updateMic(mics, fromId: fromId)
}
```

### 5. 换麦

从当前麦位切换到另一个空闲麦，通过调用ChatRoomServiceImp的changeMic方法

```swift
func changeMic(from: Int, to: Int) {
    if let mic: VRRoomMic = roomInfo?.mic_info?[to] {
        if mic.status == 3 || mic.status == 4 {
            view.makeToast("Mic Closed".localized())
            return
        }
    }

    ChatRoomServiceImp.getSharedInstance().changeMic(old_index: from, new_index: to) { error, micMap in
        if error == nil,let old_mic = micMap?[from],let new_mic = micMap?[to] {
            self.local_index = to
            self.roomInfo?.mic_info?[from] = old_mic
            self.roomInfo?.mic_info?[to] = new_mic
            self.rtcView.updateUser(old_mic)
            self.rtcView.updateUser(new_mic)
            guard let mic = ChatRoomServiceImp.getSharedInstance().mics.first(where: {
                VoiceRoomUserInfo.shared.user?.chat_uid ?? "" == $0.member?.chat_uid ?? ""
            }) else { return }
            self.micMuteManager(mic: mic)
        }
    }
}
```

如果换麦成功，那么此时房间内其他人会收到麦位更新通知

```swift
func onSeatUpdated(roomId: String, mics: [VRRoomMic], from fromId: String) {
    self.updateMic(mics, fromId: fromId)
}
```

## 2. 相关RTC处理

### 上麦

需要把用户角色改为主播，发送音频流

```swift
rtcKit.setClientRole(.broadcaster)
```

### 下麦

需要把角色切换为观众，停止发送音频流

```swift
rtcKit.setClientRole(.audience)
```

### 静音/取消静音

```swift
public func muteLocalAudioStream(mute: Bool) -> Int32 {
    return rtcKit.muteLocalAudioStream(mute)
}
```