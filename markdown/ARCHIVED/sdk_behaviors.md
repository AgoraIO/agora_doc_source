---
title: SDK 断线重连机制
platform: NULL
updatedAt: 2019-05-21 18:23:27
---

### 声网 SDK 有断线重连机制吗？

断线一般分两种情况：断网、进程被杀。

#### 断网

假设有 A， B 两个用户处于同一个频道内进行音视频直播 / 通话，通话过程中 A 用户失去了网络连接。

1.  A 失去网络连接（A 用户在 4 秒内没有收到服务器数据）：
    - 如果 A 是 Android， Windows，或 Linux 平台，A 有回调： `onConnectionInterrupted`
    - 如果 A 是 iOS 或 mac 平台： `rtcEngineConnectionDidInterrupted`
    - 如果 A 是 Web 平台，A 没有回调。
2.  失去连接后， A 尝试重连其他服务器,直到重连成功：

    - 如果 A 在 10 秒内未连接成功，会有回调：
      -       	如果 A 是 Android， Windows，或 Linux 平台： `onConnectionLost`
      -       如果 A 是 iOS 或 mac 平台： `rtcEngineConnectionDidLost`
      -       如果 A 是 Web 平台，A 没有回调。
    - 如果 B 在一定时间内没有收到 A 的包，B 有回调：
      - 如果 B 是 Android， Windows，或 Linux 平台，20 秒内没有收到 A 的包： `onUserOffline`
      - 如果 B 是 iOS 或 mac 平台，20 秒内没有收到 A 的包： `didOfflineOfUid`
      - 如果 B 是 Web 平台，10 秒内没有收到 A 的包：`client.on('stream-removed')`
    - 如果 A 重连成功：

      - 如果 A 是 Android， Windows，或 Linux 平台，A 有回调： `didRejoinChannel`
      - 如果 A 是 iOS 或 mac 平台，A 有回调： `didRejoinChannel`
      - 如果 A 是 Web 平台，A 没有回调。

      如果此前 B 未收到 A 重连失败的回调，B 不会因为 A 重连成功而收到回调；如果此前 B 已经收到 A 重连失败的回调，则此时 B 有回调：

      - 如果 B 是 Android， Windows，或 Linux 平台：`onUserJoined`
      - 如果 B 是 iOS 或 mac 平台： `didJoinedOfUid`
      - 如果 B 是 Web 平台： `client.on('stream-added')`

#### 进程被杀

进程被杀包括以下各种情况：

- 通信模式/直播模式
- 打开/关闭 voip 模式
- 前台/后台运行时进程被杀
- 网页关闭（Web 端）

假设有 A， B 两个用户处于同一个频道内进行音视频直播/通话。
当 A 进程被杀：

- 如果 A 是 iOS 或 mac 平台：A 自动触发 `leaveChannel`，B 有回调：

  - 如果 B 是 Android， Windows，或 Linux 平台：` onUserOffline`
  - 如果 B 是 iOS 或 mac 平台： `didOfflineOfUid`
  - 如果 B 是 Web 平台： `client.on('peer-leave')`

- 如果 A 是 Android， Windows，或 Linux 平台，且 B 使用的是 Native SDK：
  - 如果 20 秒内， A 没有重启 app 并加入原频道，B 有回调：
    - 如果 B 是 Android， Windows，或 Linux 平台： `onUserOffline`
    - 如果 B 是 iOS 或 mac 平台：` didOfflineOfUid`
  - 如果 20 秒内， A 重启 app 并加入原频道，B 不会收到回调。
- 如果 A 是 Android， Windows，或 Linux 平台，且 B 使用的是 Web SDK：
  - 如果 10 秒内， A 没有重启 app 并加入原频道，B 有回调：`client.on('stream-removed')`
  - 如果 10 秒内， A 重启 app 并加入原频道，B 不会收到回调。
- 如果 A 使用的是 Web SDK，进程被杀与掉线的行为是一样的。
- 如果 A 是频道内最后一个用户，服务端会在 10s 后销毁频道
