本文通过声动互娱项目介绍如何在在语聊房中进行麦位管理，包含上麦、下麦、控制麦位是否静音、设置是否锁麦、换麦的操作。声网即时通讯（环信）SDK 提供消息通讯服务，声网 RTC SDK 提供实时音视频流互动的能力。

//TODO
上麦之前应该介绍集成 RTC SDK、环信（是否需要，没有在文档里看到用到？）、引入 ChatRoomServiceProtocol 类、初始化 ChatRoomService、subscribeEvent、creteRoom、joinRoom。

语聊房的礼物打赏可以后期补充。

ChatRoomServiceProtocol 是场景化 API 吗？需要提供 API 文档吗，还是用源代码中的注释即可？

用户不是调用 ChatRoomServiceProtocol 的方法，而是 ChatRoomServiceImp 吗？

～～～～

通过 ChatRoomServiceImp 类的 subscribeEvent 方法注册回调事件，监听房间内的变化。

```swift
ChatRoomServiceImp.getSharedInstance().subscribeEvent(with: self)
```

## 1. 上麦

本节介绍如何让用户上麦和在麦位上发送音频流。上麦的方式分为房主邀请或用户主动申请。

### 房主邀请上麦

![](https://web-cdn.agora.io/docs-files/1684231366436)

1. 房主调用 ChatRoomServiceImp 类的 startMicSeatInvitation 方法，开始邀请用户上麦。

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

    - 用户可以调用 ChatRoomServiceImp 类的 acceptMicSeatInvitation 方法接受邀请。
    - 用户也可以调用 ChatRoomServiceImp 类的 refuseInvite 方法拒绝邀请。


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

4. 如果用户接受上麦邀请，那么你需要让房内其他用户都收到麦位更新的通知。

```swift
// 麦位更新
func onSeatUpdated(roomId: String, mics: [VRRoomMic], from fromId: String) {
    self.updateMic(mics, fromId: fromId)
}
```

注意：房主邀请多个用户上麦时，如果多个用户同时点击接受上麦邀请，那么可能会出现用户 A 上麦后又被新上麦的用户 B 踢下麦位。因此，为了避免多个用户同时主动修改麦位时造成互踢的冲突，声网推荐你在集成逻辑中控制用户上麦由房主决定，而不是用户自身决定。

### 用户申请上麦

![](https://web-cdn.agora.io/docs-files/1684231374938)

1. 用户调用 ChatRoomServiceImp 类的 startMicSeatApply 方法向房主发送申请上麦的请求。

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

2. 如果用户希望取消上麦申请，可以调用 ChatRoomServiceImp 类的 cancelMicSeatApply 方法。

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
//TODO 原始 input 是“房间内所有用户”？
3. 房主注册 onReceiveSeatRequest 回调，以获取用户申请上麦的信息更新，从而刷新上麦申请列表。

```swift
// 房主收到申请上麦信息
func onReceiveSeatRequest(roomId: String, applicant: VoiceRoomApply) {
    self.chatBar.refresh(event: .handsUp, state: .unSelected, asCreator: true)
}
```

4. 房主调用 ChatRoomServiceImp 类的 acceptMicSeatApply 方法，以同意某个用户的上麦申请。

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

5. 如果房主同意某个用户的上麦申请，那么你需要让房内其他用户都收到麦位更新的通知。

```swift
// 收到同意申请上麦
func onSeatUpdated(roomId: String, mics: [VRRoomMic], from fromId: String) {
    self.updateMic(mics, fromId: fromId)
}
```

注意：目前声动互娱没有提供房主拒绝上麦申请的 API。

### 切换上麦用户角色

不管是房主邀请，还是用户主动申请，在用户上麦后，你需要将其角色从观众（audience）切换成主播（broadcaster），以让用户拥有发送音频流的权限。

```swift
rtcKit.setClientRole(.broadcaster)
```

## 2. 下麦

本节介绍如何让在麦位上的用户下麦和在下麦后无法发送音频流。下麦的方式分为用户主动下麦和被踢下麦。

### 用户主动下麦

在麦位上的用户调用 ChatRoomServiceImp 类的 leaveMic 方法可以主动下麦。

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

### 用户被踢下麦

房主调用 ChatRoomServiceImp 类的 kickoff 方法可以将麦位上的用户踢下麦。

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

### 麦位更新回调

不管是用户主动下麦，还是用户被踢下麦，在用户下麦后，你需要让房内其他用户都收到麦位更新的通知。

```swift
func onSeatUpdated(roomId: String, mics: [VRRoomMic], from fromId: String) {
    self.updateMic(mics, fromId: fromId)
}
```

### 切换下麦用户角色

不管是用户主动下麦，还是用户被踢下麦，在用户下麦后，你需要将其角色从主播（broadcaster）切换成观众（audience），以让用户失去发送音频流的权限。

```swift
rtcKit.setClientRole(.audience)
```

## 3. 控制麦位是否静音

用户上麦后，你可以控制麦位是否静音，以达到禁言的目的。将麦位静音意味着不允许该麦位上的用户发言。将麦位取消静音意味着恢复该麦位上的用户发言的权限。

### 麦位静音

你可以通过 ChatRoomServiceImp 类的 forbidMic 方法将某个麦位标记为静音。

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

### 麦位取消静麦

你可以通过 ChatRoomServiceImp 类的 unForbidMic 方法将某个麦位标记为取消静音。

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


### 麦位更新回调

将麦位静音或取消静音后，你需要让房内其他用户收到麦位更新的通知。

```swift
func onSeatUpdated(roomId: String, mics: [VRRoomMic], from fromId: String) {
    self.updateMic(mics, fromId: fromId)
}
```

### 停止或恢复发送音频流

标记麦位静音或取消静音后，通过 RTC SDK 的 [`muteLocalAudioStream`](https://docportal.shengwang.cn/cn/live-streaming-premium-4.x/API%20Reference/java_ng/API/toc_stream_management.html#api_irtcengine_mutelocalaudiostream) 方法停止发送或恢复发送麦位上用户的音频流，以达到静音或取消静音的效果。

```swift
// 参数 mute 为 true 代表静音
// 参数 mute 为 false 代表取消静音
public func muteLocalAudioStream(mute: Bool) -> Int32 {
    return rtcKit.muteLocalAudioStream(mute)
}
```

## 4. 设置是否锁麦

锁麦意味着不允许任何用户占据该麦位。将某个麦位锁住后，用户无法向该位置上麦。将某个麦位解锁后，麦位恢复空闲状态，用户可以向该位置上麦。

### 锁麦

你可以调用 ChatRoomServiceImp 类的 lockMic 方法将某个麦位锁住。


```swift
// 锁麦
func lock(with index: Int) {
    ChatRoomServiceImp.getSharedInstance().lockMic(mic_index: index) { error, mic in
        if error == nil,let mic = mic {
            self.rtcView.updateUser(mic)
        }
    }
}
```

### 取消锁麦

你可以调用 ChatRoomServiceImp 类的 unLockMic 方法将某个麦位解锁。


```swift
// 取消锁麦
func unLock(with index: Int) {
    ChatRoomServiceImp.getSharedInstance().unLockMic(mic_index: index) { error, mic in
        if error == nil,let mic = mic {
            self.rtcView.updateUser(mic)
        }
    }
}
```

### 麦位更新回调

将麦位锁住或解锁后，你需要让房内其他用户收到麦位更新的通知。

```swift
func onSeatUpdated(roomId: String, mics: [VRRoomMic], from fromId: String) {
    self.updateMic(mics, fromId: fromId)
}
```

## 5. 换麦

1. 换麦指将把上麦用户从当前麦位更换到另一个空闲麦位。你可以调用 ChatRoomServiceImp 类的 changeMic 方法更换麦位。

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

2. 如果换麦成功，那么此时你需要让房内其他用户收到麦位更新的通知。


```swift
func onSeatUpdated(roomId: String, mics: [VRRoomMic], from fromId: String) {
    self.updateMic(mics, fromId: fromId)
}
```