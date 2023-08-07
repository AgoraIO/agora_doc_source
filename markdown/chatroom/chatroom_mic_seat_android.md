本文介绍如何在语聊房中进行麦位管理麦位管理包含如下操作：

- 上麦：听众与房主连麦，连麦听众可以发言，与房主语音互动。
- 下麦：连麦听众下麦后成为普通听众，无法发言也无法与房主语音互动。
- 静音：房主不允许某个连麦听众发言。
- 锁麦：房主不允许任何用户占据该麦位。
- 换麦：连麦听众从一个麦位更换到另一个麦位。

![](https://web-cdn.agora.io/docs-files/1689239633856)

## 示例项目

声网在 [agora-ent-scenarios](https://github.com/AgoraIO-Usecase/agora-ent-scenarios) 仓库中提供[语聊房（普通版）](https://github.com/AgoraIO-Usecase/agora-ent-scenarios/tree/v3.1.0-voice-Android/Android/scenes/voice)源代码供你参考。

## 前提条件

### 实现基础功能

实现该进阶功能前，请确保你已实现基础的语聊房功能，例如登录即时通讯系统、获取房间列表、创建房间、加入房间。详见[基础功能](https://docs.agora.io/cn/chatroom/chatroom_integration_android?platform=All%20Platforms)。

### 注册回调

进行麦位管理前，你需要通过声网云服务中 `voiceServiceProtocol` 类的 `subscribeEvent` 方法注册回调事件，监听房间内的回调事件。

```kotlin
voiceServiceProtocol.subscribeEvent(object : VoiceRoomSubscribeDelegate{
    ...
})
```

## 上麦

本节介绍如何让听众上麦并在麦位上发送音频流。上麦的方式分为房主邀请或听众主动申请。

### 房主邀请上麦

![](https://web-cdn.agora.io/docs-files/1690957941173)

1. 房主调用 `voiceServiceProtocol` 对象的 `startMicSeatInvitation` 方法，开始邀请听众上麦。

    ```kotlin
    // 邀请上麦
    voiceServiceProtocol.startMicSeatInvitation(chatUid, micIndex, completion = { error, result ->
        ...
    })
    ```

2. 房间内其他所有用户都通过 `subscribeEvent` 注册的 `onReceiveSeatInvitation` 回调获取房主邀请上麦的通知。

    ```kotlin
    // 接收到邀请通知
    fun onReceiveSeatInvitation(message: ChatMessageData) {}
    ```

3. 收到房主上麦邀请的听众会看到邀请弹窗，听众可以选择是否接受邀请：

    - 调用 `voiceServiceProtocol` 对象的 `acceptMicSeatInvitation` 方法接受邀请。
    - 调用 `voiceServiceProtocol` 对象的 `refuseInvite` 方法拒绝邀请。

    ```kotlin
    // 接受邀请
    voiceServiceProtocol.acceptMicSeatInvitation(micIndex, completion = { error, result ->
        ...
    })
    ```

    ```kotlin
    // 拒绝邀请
    fun refuseInvite(completion: (error: Int, result: Boolean) -> Unit) {
        ...
    }
    ```

4. 如果听众接受上麦邀请，那么你需要让房内其他用户都收到麦位更新的通知。

    ```kotlin
    // 麦位更新
    fun onSeatUpdated(roomId: String, attributeMap: Map<String, String>, fromId: String) {}
    ```

    <div class="alert note">房主邀请多个听众上麦时，如果多个听众同时点击接受上麦邀请，那么可能出现听众 A 刚上麦就被后面上麦的用户 B 踢下麦位。因此，为了避免多个听众同时主动修改麦位时造成互踢的冲突，声网推荐你在集成逻辑中控制上麦由房主决定，而不是听众决定。</div>

### 听众申请上麦

![](https://web-cdn.agora.io/docs-files/1690957949791)

1. 听众调用 `voiceServiceProtocol` 对象的 `startMicSeatApply` 方法向房主发送申请上麦的请求。

    ```kotlin
    // 申请上麦
    voiceServiceProtocol.startMicSeatApply(micIndex, completion = { error, result ->
        ...
    })
    ```

2. （可选）如果听众希望取消上麦申请，可以调用 `voiceServiceProtocol` 对象的 `cancelMicSeatApply` 方法。

    ```kotlin
    // 听众取消自己的上麦申请
    voiceServiceProtocol.cancelMicSeatApply(chatroomId, chatUid, completion = { error, result ->
        ...
    })
    ```

3. 房主通过 `subscribeEvent` 注册的 `onReceiveSeatRequest` 回调获取听众申请上麦的信息更新，从而刷新上麦申请列表。

    ```kotlin
    // 房主收到申请上麦信息
    fun onReceiveSeatRequest( message: ChatMessageData) {}
    ```

4. 房主调用 `voiceServiceProtocol` 对象的 `acceptMicSeatApply` 方法，以同意某个听众的上麦申请。

    ```kotlin
    // 房主同意听众上麦申请
    voiceServiceProtocol.acceptMicSeatApply(micIndex, chatUid, completion = { error, result ->
        ...
    })
    ```

5. 如果房主同意某个听众的上麦申请，那么你需要让房内其他用户都收到麦位更新的通知。

    ```kotlin
    // 收到同意申请上麦
    fun onSeatUpdated(roomId: String, attributeMap: Map<String, String>, fromId: String) {}
    ```

### 切换用户角色

不管是房主邀请，还是听众主动申请，在听众成为连麦听众后，你需要调用声网 RTC SDK 中 [`setClientRole`](https://docportal.shengwang.cn/cn/live-streaming-premium-4.x/API%20Reference/java_ng/API/toc_core_method.html#api_irtcengine_setclientrole) 方法将其角色从听众（`AUDIENCE`）切换成主播（`BROADCASTER`），以让连麦听众拥有发送音频流的权限。

```kotlin
rtcEngine?.setClientRole(Constants.CLIENT_ROLE_BROADCASTER)
```

## 下麦

本节介绍如何让连麦听众下麦并在下麦后无法发送音频流。下麦的方式分为连麦听众主动下麦和被踢下麦。

### 主动下麦

连麦听众调用 `voiceServiceProtocol` 对象的 `leaveMic` 方法可以主动下麦。

```kotlin
// 主动下麦
voiceServiceProtocol.leaveMic(micIndex, completion = { error, result ->
    ...
})
```

### 被踢下麦

房主调用 `voiceServiceProtocol` 对象的 `kickOff` 方法可以将连麦听众踢下麦。

```kotlin
// 踢连麦听众下麦
voiceServiceProtocol.kickOff(micIndex, completion = { error, result ->
    ...
})
```

### 麦位更新回调

不管是连麦听众主动下麦还是被踢下麦，在连麦听众成为普通听众后，你需要让房内其他用户都收到麦位更新的通知。

```kotlin
fun onSeatUpdated(roomId: String, attributeMap: Map<String, String>, fromId: String) {}
```

### 切换用户角色

不管是连麦听众主动下麦还是被踢下麦，在连麦听众成为普通听众后，你需要调用声网 RTC SDK 中 [`setClientRole`](https://docportal.shengwang.cn/cn/live-streaming-premium-4.x/API%20Reference/ios_ng/API/toc_core_method.html#api_irtcengine_setclientrole) 方法将其角色从主播（`BROADCASTER`）切换成听众（`AUDIENCE`），以让其失去发送音频流的权限。

```kotlin
rtcEngine?.setClientRole(Constants.CLIENT_ROLE_AUDIENCE)
```

## 设置是否静音

听众上麦后，你可以设置麦位是否静音，以达到禁言的目的。将麦位静音意味着不允许该连麦听众发言；将麦位取消静音意味着恢复该连麦听众发言的权限。

### 麦位静音

你可以通过 `voiceServiceProtocol` 对象的 `forbidMic` 方法将某个麦位标记为静音。

```kotlin
// 禁言指定麦位
voiceServiceProtocol.forbidMic(micIndex, completion = { error, result ->
    ...
})
```

### 麦位取消静麦

你可以通过 `voiceServiceProtocol` 对象的 `unForbidMic` 方法将某个麦位标记为取消静音。

```kotlin
// 取消禁言指定麦位
voiceServiceProtocol.unForbidMic(micIndex, completion = { error, result ->
    ...
})
```

### 麦位更新回调

将麦位静音或取消静音后，你需要让房内其他用户收到麦位更新的通知。

```kotlin
fun onSeatUpdated(roomId: String, attributeMap: Map<String, String>, fromId: String) {}
```

### 停止或恢复发送音频流

标记麦位静音或取消静音后，通过声网 RTC SDK 中 [`muteLocalAudioStream`](https://docportal.shengwang.cn/cn/live-streaming-premium-4.x/API%20Reference/java_ng/API/toc_stream_management.html#api_irtcengine_mutelocalaudiostream) 方法停止发送或恢复发送麦位上的连麦听众的音频流，以达到静音或取消静音的效果。

```kotlin
// 参数 mute 为 true 代表静音
// 参数 mute 为 false 代表取消静音
rtcEngine?.muteLocalAudioStream(true)
```

## 设置是否锁麦

锁麦意味着不允许任何用户占据该麦位。将某个麦位锁住后，用户无法占据该麦位。将某个麦位解锁后，麦位恢复空闲状态，用户可以占据该麦位。

### 锁麦

你可以调用 `voiceServiceProtocol` 对象的 `lockMic` 方法将某个麦位锁住。

```kotlin
// 锁麦
voiceServiceProtocol.lockMic(micIndex, completion = { error, result ->
    ...
})
```

### 取消锁麦

你可以调用 `voiceServiceProtocol` 对象的 `unLockMic` 方法将某个麦位解锁。


```kotlin
// 取消锁麦
voiceServiceProtocol.unLockMic(micIndex, completion = { error, result ->
    ...
})
```

### 麦位更新回调

将麦位锁住或解锁后，你需要让房内其他用户收到麦位更新的通知。

```kotlin
fun onSeatUpdated(roomId: String, attributeMap: Map<String, String>, fromId: String) {}
```

## 换麦

1. 换麦指将把连麦听众从当前麦位更换到另一个空闲麦位。你可以调用 `voiceServiceProtocol` 对象的 `changeMic` 方法更换麦位。

    ```kotlin
    voiceServiceProtocol.changeMic(oldIndex, newIndex, completion = { error, result ->
        ...
    })
    ```

2. 如果换麦成功，那么此时你需要让房内其他用户收到麦位更新的通知。

    ```kotlin
    fun onSeatUpdated(roomId: String, attributeMap: Map<String, String>, fromId: String) {}
    ```