本文如何在语聊房中进行麦位管理麦位管理包含如下操作：

- 上麦：观众与房主连麦，连麦观众可以发言，与房主语音互动。
- 下麦：连麦观众下麦，成为普通观众，无法发言，无法与房主语音互动。
- 静音：房主不允许某个连麦观众发言。
- 锁麦：房主不允许任何用户占据该麦位。
- 换麦：连麦观众从一个麦位更换到另一个麦位。

![](https://web-cdn.agora.io/docs-files/1689239633856)

## 示例项目

声网在 [agora-ent-scenarios](https://github.com/AgoraIO-Usecase/agora-ent-scenarios) 仓库中提供[语聊房（普通版）](https://github.com/AgoraIO-Usecase/agora-ent-scenarios/tree/v3.0.0-all-iOS/iOS/AgoraEntScenarios/Scenes/VoiceChatRoom)供你参考。

## 前提条件

- 实现该进阶功能前，请确保你已实现基础的语聊房功能，例如登录即时通讯系统、获取房间列表、创建房间、加入房间。详见[基础功能](https://docs.agora.io/cn/chatroom/chatroom_integration_ios?platform=All%20Platforms)。

- 进行麦位管理时，你需要先通过声网云服务中 `ChatRoomServiceImp` 类的 `subscribeEvent` 方法注册回调事件，监听房间内的回调事件。

    ```kotlin
    voiceServiceProtocol.subscribeEvent(object : VoiceRoomSubscribeDelegate{
        // ...
    })
    ```

## 上麦

本节介绍如何让观众上麦并在麦位上发送音频流。上麦的方式分为房主邀请或观众主动申请。

### 房主邀请上麦

![](https://web-cdn.agora.io/docs-files/1689244539769)

1. 房主调用 `ChatRoomServiceImp` 类的 `startMicSeatInvitation` 方法，开始邀请观众上麦。

    ```kotlin
    // 邀请上麦
    voiceServiceProtocol.startMicSeatInvitation(chatUid, micIndex, completion = { error, result ->
        // ...
    })
    ```

2. 房间内其他所有用户都注册 `onReceiveSeatInvitation` 回调，以获取房主邀请上麦的通知。

    ```kotlin
    // 接收到邀请通知
    fun onReceiveSeatInvitation(message: ChatMessageData) {}
    ```

3. 收到房主上麦邀请的观众会看到邀请弹窗，观众可以选择是否接受邀请：

    - 调用 `ChatRoomServiceImp` 类的 `acceptMicSeatInvitation` 方法接受邀请。
    - 调用 `ChatRoomServiceImp` 类的 `refuseInvite` 方法拒绝邀请。


    ```kotlin
    // 接受邀请
    voiceServiceProtocol.acceptMicSeatInvitation(micIndex, completion = { error, result ->
        // ...
    })
    ```

    ```kotlin
    // 拒绝邀请
    fun refuseInvite(completion: (error: Int, result: Boolean) -> Unit) {
        // ...
    }
    ```

4. 如果观众接受上麦邀请，那么你需要让房内其他用户都收到麦位更新的通知。

    ```kotlin
    // 麦位更新
    fun onSeatUpdated(roomId: String, attributeMap: Map<String, String>, fromId: String) {}
    ```

    **注意**：房主邀请多个观众上麦时，如果多个观众同时点击接受上麦邀请，那么可能出现观众 A 刚上麦就被后面上麦的用户 B 踢下麦位。因此，为了避免多个观众同时主动修改麦位时造成互踢的冲突，声网推荐你在集成逻辑中控制上麦由房主决定，而不是观众决定。

### 观众申请上麦

![](https://web-cdn.agora.io/docs-files/1689244547406)

1. 观众调用 `ChatRoomServiceImp` 类的 `startMicSeatApply` 方法向房主发送申请上麦的请求。

    ```kotlin
    // 申请上麦
    voiceServiceProtocol.startMicSeatApply(micIndex, completion = { error, result ->
        // ...
    })
    ```

2. 如果观众希望取消上麦申请，可以调用 `ChatRoomServiceImp` 类的 `cancelMicSeatApply` 方法。

    ```kotlin
    // 观众取消自己的上麦申请
    voiceServiceProtocol.cancelMicSeatApply(chatroomId, chatUid, completion = { error, result ->
        // ...
    })
    ```

3. 房主注册 //TODO（注册？） `onReceiveSeatRequest` 回调，以获取观众申请上麦的信息更新，从而刷新上麦申请列表。

    ```kotlin
    // 房主收到申请上麦信息
    fun onReceiveSeatRequest( message: ChatMessageData) {}
    ```

4. 房主调用 `ChatRoomServiceImp` 类的 `acceptMicSeatApply` 方法，以同意某个观众的上麦申请。

    ```kotlin
    // 房主同意观众上麦申请
    voiceServiceProtocol.acceptMicSeatApply(micIndex, chatUid, completion = { error, result ->
        // ...
    })
    ```

5. 如果房主同意某个观众的上麦申请，那么你需要让房内其他用户都收到麦位更新的通知。

    ```kotlin
    // 收到同意申请上麦
    fun onSeatUpdated(roomId: String, attributeMap: Map<String, String>, fromId: String) {}
    ```

### 切换用户角色

不管是房主邀请，还是观众主动申请，在观众成为连麦观众后，你需要调用声网 RTC SDK 中 [`setClientRole`](https://docportal.shengwang.cn/cn/live-streaming-premium-4.x/API%20Reference/ios_ng/API/toc_core_method.html#api_irtcengine_setclientrole) 方法将其角色从观众（`audience`）切换成主播（`broadcaster`），以让连麦观众拥有发送音频流的权限。

```kotlin
rtcEngine?.setClientRole(Constants.CLIENT_ROLE_BROADCASTER)
```

## 下麦

本节介绍如何让连麦观众下麦并在下麦后无法发送音频流。下麦的方式分为连麦观众主动下麦和被踢下麦。

### 主动下麦

连麦观众调用 `ChatRoomServiceImp` 类的 `leaveMic` 方法可以主动下麦。

```kotlin
// 主动下麦
voiceServiceProtocol.leaveMic(micIndex, completion = { error, result ->
    // ...
})
```

### 被踢下麦

房主调用 `ChatRoomServiceImp` 类的 `kickoff` 方法可以将连麦观众踢下麦。

```kotlin
// 踢连麦观众下麦
voiceServiceProtocol.kickOff(micIndex, completion = { error, result ->
    // ...
})
```

### 麦位更新回调

不管是连麦观众主动下麦还是被踢下麦，在连麦观众成为普通观众后，你需要让房内其他用户都收到麦位更新的通知。

```kotlin
fun onSeatUpdated(roomId: String, attributeMap: Map<String, String>, fromId: String) {}
```

### 切换用户角色

不管是连麦观众主动下麦还是被踢下麦，在连麦观众成为普通观众后，你需要调用声网 RTC SDK 中 [`setClientRole`](https://docportal.shengwang.cn/cn/live-streaming-premium-4.x/API%20Reference/ios_ng/API/toc_core_method.html#api_irtcengine_setclientrole) 方法将其角色从主播（`broadcaster`）切换成观众（`audience`），以让其失去发送音频流的权限。

```kotlin
rtcEngine?.setClientRole(Constants.CLIENT_ROLE_AUDIENCE)
```

## 设置是否静音

观众上麦后，你可以设置麦位是否静音，以达到禁言的目的。将麦位静音意味着不允许该连麦观众发言。将麦位取消静音意味着恢复该连麦观众发言的权限。

### 麦位静音

你可以通过 `ChatRoomServiceImp` 类的 `forbidMic` 方法将某个麦位标记为静音。

```kotlin
// 禁言指定麦位
voiceServiceProtocol.forbidMic(micIndex, completion = { error, result ->
    // ...
})
```

### 麦位取消静麦

你可以通过 `ChatRoomServiceImp` 类的 `unForbidMic` 方法将某个麦位标记为取消静音。

```kotlin
// 取消禁言指定麦位
voiceServiceProtocol.unForbidMic(micIndex, completion = { error, result ->
    // ...
})
```

### 麦位更新回调

将麦位静音或取消静音后，你需要让房内其他用户收到麦位更新的通知。

```kotlin
fun onSeatUpdated(roomId: String, attributeMap: Map<String, String>, fromId: String) {}
```

### 停止或恢复发送音频流

标记麦位静音或取消静音后，通过声网 RTC SDK 中 [`muteLocalAudioStream`](https://docportal.shengwang.cn/cn/live-streaming-premium-4.x/API%20Reference/java_ng/API/toc_stream_management.html#api_irtcengine_mutelocalaudiostream) 方法停止发送或恢复发送麦位上的连麦观众的音频流，以达到静音或取消静音的效果。

```kotlin
// 参数 mute 为 true 代表静音
// 参数 mute 为 false 代表取消静音
rtcEngine?.muteLocalAudioStream(true)
```

## 设置是否锁麦

锁麦意味着不允许任何用户占据该麦位。将某个麦位锁住后，用户无法占据该麦位。将某个麦位解锁后，麦位恢复空闲状态，用户可以占据该麦位。

### 锁麦

你可以调用 `ChatRoomServiceImp` 类的 `lockMic` 方法将某个麦位锁住。

```kotlin
// 锁麦
voiceServiceProtocol.lockMic(micIndex, completion = { error, result ->
    // ...
})
```

### 取消锁麦

你可以调用 `ChatRoomServiceImp` 类的 `unLockMic` 方法将某个麦位解锁。


```kotlin
// 取消锁麦
voiceServiceProtocol.unLockMic(micIndex, completion = { error, result ->
    // ...
})
```

### 麦位更新回调

将麦位锁住或解锁后，你需要让房内其他用户收到麦位更新的通知。

```kotlin
fun onSeatUpdated(roomId: String, attributeMap: Map<String, String>, fromId: String) {}
```

## 换麦

1. 换麦指将把连麦观众从当前麦位更换到另一个空闲麦位。你可以调用 `ChatRoomServiceImp` 类的 `changeMic` 方法更换麦位。

    ```kotlin
    voiceServiceProtocol.changeMic(oldIndex, newIndex, completion = { error, result ->
        // ...
    })
    ```

2. 如果换麦成功，那么此时你需要让房内其他用户收到麦位更新的通知。

    ```kotlin
    fun onSeatUpdated(roomId: String, attributeMap: Map<String, String>, fromId: String) {}
    ```