本文通过声动互娱项目介绍如何在在语聊房中进行麦位管理。

麦位管理涉及用户上下麦、麦位静音和状态锁定等操作。声网即时通讯（环信）SDK 提供消息通讯的能力，声网 RTC SDK 提供控制用户音视频流收发的能力。

## 上麦

## 下麦

## 静音

## 锁麦

## 换麦

-----



## 1. 对麦位操作

首先需要注册回调，注册之后才能收到房间变化的通知。

```swift
ChatRoomServiceImp.getSharedInstance().subscribeEvent(with: self)
```

### 1. 邀请/申请上麦

#### 1. 邀请上麦

<pic> //TODO

房主邀请用户上麦：调用 ChatRoomServiceImp 的 startMicSeatInvitation 方法。

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

监听上麦
房间内所有用户（除房主）注册

房间内所有用户都通过注册 onReceiveSeatInvitation 回调获取房主邀请上麦的通知。

```swift
// 接收到邀请通知
func onReceiveSeatInvitation(roomId: String, user: VRUser) {
    self.showInviteMicAlert(index: user.mic_index)
}
```

通过弹出邀请弹窗让观众选择接受邀请，通过调用 ChatRoomServiceImp 的 acceptMicSeatInvitation 方法。

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

如果需要拒绝邀请，则可以调用ChatRoomServiceImp的refuseInvite方法

```swift
// 拒绝邀请
func refuse() {
    ChatRoomServiceImp.getSharedInstance().refuseInvite(chat_uid: self.roomInfo?.room?.owner?.chat_uid ?? "") { _, _ in
    }
}
```

如果观众接受邀请，那么此时房间内其他人会收到麦位更新通知

```swift
// 麦位更新
func onSeatUpdated(roomId: String, mics: [VRRoomMic], from fromId: String) {
    self.updateMic(mics, fromId: fromId)
}
```

注意：多个观众同时主动修改麦位时会产生冲突。例如，房主邀请多观众，然后多个观众同时点击，可能会出现A观众上麦之后被B观众踢下去的情况。后续集成方案会修改成由房主决定谁上麦而不是观众决定自己上麦。

#### 2. 申请上麦

<pic> //TODO

发送申请上麦请求，通过调用ChatRoomServiceImp的startMicSeatApply方法

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

如果观众需要取消申请，通过调用ChatRoomServiceImp的cancelMicSeatApply方法请求

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

然后房间内所有用户通过注册回调的onReceiveSeatRequest获取到申请上麦信息的更新，刷新申请列表

```swift
// 房主收到申请上麦信息
func onReceiveSeatRequest(roomId: String, applicant: VoiceRoomApply) {
    self.chatBar.refresh(event: .handsUp, state: .unSelected, asCreator: true)
}
```

房主选择同意某一用户的上麦申请，通过调用ChatRoomServiceImp的acceptMicSeatApply发起请求

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

如果房主同意上麦申请，房间内所有用户收到麦位更新消息，更新之后的RTC操作请参考RTC上麦和RTC下麦操作

```swift
// 收到同意申请上麦
func onSeatUpdated(roomId: String, mics: [VRRoomMic], from fromId: String) {
    self.updateMic(mics, fromId: fromId)
}
```

注意：目前没有提供房主拒绝上麦申请的接口

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