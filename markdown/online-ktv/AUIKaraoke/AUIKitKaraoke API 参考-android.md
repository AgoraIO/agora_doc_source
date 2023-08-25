# AUIKitKaraoke API 参考

本文介绍 AUIKitKaraoke 组件的 API。

## KaraokeUIKit

提供 `AUIKitKaraoke` 的核心类，可用于实现组件初始化、创建、销毁房间等基础功能。

### setup

```kotlin
fun setup(
    config: AUICommonConfig,
    ktvApi: KTVApi? = null,
    rtcEngineEx: RtcEngineEx? = null,
    rtmClient: RtmClient? = null
)
```

初始化 `scenekit`。

在调用 `KaraokeUIKit` 类下的其他 API 前，你需要先调用该方法进行初始化。

**参数**

- `config`：`AUICommonConfig` 这个里面包含了哪些东西？input里面写的是用户信息和appid等。没找到这个commonconfig的类型定义
- `ktvApi`：[场景化 API](https://docportal.shengwang.cn/cn/online-ktv/ktv_api_kotlin?platform=Android) 实例。如果你的项目中还未集成场景化 API，请传入 `null`，`scenekit` 内部会自行创建场景化 API 实例。
- `rtcEngineEx`：[RtcEngineEx](https://docportal.shengwang.cn/cn/online-ktv/API%20Reference/java_ng/API/rtc_interface_class.html#class_irtcengineex) 实例。如果的你的项目中还未集成声网 RTC SDK，请传入 `null`，`scenekit` 内部会自行创建 `RtcEngineEx` 实例。
- `rtmClient`：[RtmClient](https://doc.shengwang.cn/doc/rtm2/java/landing-page) 实例。如果的你的项目中还未集成声网 RTM SDK，请传入 `null`，`scenekit` 内部会自行创建 `RtmClient` 实例。

### createRoom

```kotlin
fun createRoom(
    createRoomInfo: AUICreateRoomInfo,
    success: (AUIRoomInfo) -> Unit,
    failure: (AUIException) -> Unit
)
```

创建 K 歌房间。

在 K 歌场景下，创建房间的人自动成为房主。成功创建房间后，会返回创建的房间信息。//TODO

**参数**

- `createRoomInfo`：需要创建的房间信息，详见 `AUICreateRoomInfo`。//TODO
- `success`：回调函数，当房间创建成功时调用。接受一个 `AUIRoomInfo` 参数，表示成功创建的房间信息，无返回值。//TODO
- `failure`：回调函数，当房间创建失败时调用。接受一个 `AUIException` 参数表示房间创建失败的异常，             无返回值。

### getRoomList

```kotlin
fun getRoomList(
  startTime: Long?,
  pageSize: Int,
  success: (List<AUIRoomInfo>) -> Unit,
  failure: (AUIException) -> Unit
)
```

获取 K 歌房间列表。

你可以调用该方法获取当前的已创建的 K 歌房间列表。

**参数**

- `startTime`：开始时间 //TODO 是指获取某一特定时间之后创建的房间列表吗？
- `pageSize`：房间列表页数，默认从 0 还是从 1开始？//TODO
- `success`：回调函数，当成功获取到 K 歌房间列表时调用，会返回一个房间信息列表，详见 [AUIRoomInfo](#AUIRoomInfo)。
- `failure`：回调函数，当房间创建失败时调用。接受一个 `AUIException` 参数表示房间创建失败的异常，             无返回值。

### launchRoom

```kotlin
fun launchRoom(
    roomInfo: AUIRoomInfo,
    config: AUIRoomConfig,
    karaokeView: KaraokeRoomView,
)
```

拉起 K 歌房间。

当你成功调用 `createRoom` 创建房间后，你可以调用该方法拉起房间。

**参数**

- `roomInfo`：需要拉起的房间信息，详见 [AUIRoomInfo](#AUIRoomInfo)。
- `config`：房间配置，详见 [AUIRoomConfig](#AUIRoomConfig)。
- `karaokeView`： `KaraokeRoomView` 实例，用于显示 K 歌房间的界面。

### destroyRoom

```kotlin
fun destroyRoom(roomId: String?)
```

销毁 K 歌房间。

**参数**

- `roomId`：要销毁的房间的 ID。

### release

```kotlin
fun release()
```

释放 `scenekit` 资源。

//TODO 和destroyRoom 方法之间是否有调用先后时许要求。

## 数据模型

### AUICommonConfig

```kotlin

```

房间相关设置。//TODO 这个shortdesc有点怪

**参数**

- `context`：安卓活动上下文。
- `appId`：你的项目在控制台注册的 App ID，详见[获取 App ID](https://docportal.shengwang.cn/cn/Agora%20Platform/get_appid_token?platform=All%20Platforms#获取-app-id)。
- `userId`：用户 ID。
- `userName`：用户名。
- `userAvatar`：用户头像。

### AUIRoomInfo

```kotlin

```

K 歌房间的相关信息。

**参数**

- `roomId`：房间 ID。
- `roomOwner`：房主信息，详见 [AUIUserThumbnailInfo](#AUIUserThumbnailInfo)。
- `onlineUsers`：房间内的人数。
- `createTime`：房间创建的时间（单位？//TODO）

### AUIUserThumbnailInfo

```kotlin

```

K 歌房主相关信息。

**参数**

- `userId`：房主的 ID。
- `userName`：房主的用户名。
- `userAvatar`：房主的头像。

### AUIException

```kotlin

```

错误码及信息。

**参数**

- `code`：错误码// TODO 有哪些？
- `message`：错误信息。

### AUIRoomConfig

K 歌房间设置。

```kotlin

```

**参数**

- `channelName`：主频道名（是指主唱所在的频道吗？），一般为 `roomId`。
- 



 