# AUIKitKaraoke Kotlin API (Android)

本文介绍 AUIKitKaraoke 组件的 API。

源码文件？

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

- `config`：初始化设置，详见 [AUICommonConfig](#AUICommonConfig)。
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

- `createRoomInfo`：房间信息，详见 [AUICreateRoomInfo](#AUICreateRoomInfo)。
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

//TODO 和destroyRoom 方法之间是否有调用先后时序要求。

## 数据模型

### <h3 className="anchor" id="AUICommonConfig"> AUICommonConfig</h3>

```kotlin
public class AUICommonConfig {
    public @NonNull Context context;
    public @NonNull String appId = "";
    public @NonNull String userId = "";
    public @NonNull String userName = "";
    public @NonNull String userAvatar = "";
}
```

通用设置。

**参数**

- `context`：安卓活动上下文。
- `appId`：你的项目在控制台注册的 App ID，详见[获取 App ID](https://docportal.shengwang.cn/cn/Agora%20Platform/get_appid_token?platform=All%20Platforms#获取-app-id)。
- `userId`：用户 ID。
- `userName`：用户名。
- `userAvatar`：用户头像。

### <h3 className="anchor" id="AUICreateRoomInfo">AUICreateRoomInfo</h3>

```kotlin
public class AUICreateRoomInfo implements Serializable {
    public @NonNull String roomName = "";       //房间名称
    public @NonNull String thumbnail = "";      //房间列表上的缩略图
    public int micSeatCount = 8;                   //麦位个数
    public @Nullable String password;           //房间密码
    public String micSeatStyle = "";            //麦位样式
}
```

需要创建的 K 歌房间的相关信息。

**参数**

- `roomName`：房间名。
- `thumbnail`：房间列表上的缩略图？是指用户头像图片的url吗？
- `micSeatCount`：房间中的麦位数量。//TODO 是否有取值范围？
- `password`：房间密码。
- `micSeatStyle`：麦位样式//TODO 什么样式？

### <h3 className="anchor" id="AUIRoomInfo">AUIRoomInfo</h3>

```kotlin
public class AUIRoomInfo extends AUICreateRoomInfo implements Serializable {
    public @NonNull String roomId = ""; 
    public @Nullable AUIUserThumbnailInfo roomOwner; 
    public int onlineUsers = 0;
    public long createTime = 0;
}
```

已创建的 K 歌房间的相关信息。

**参数**

- `roomId`：房间 ID。
- `roomOwner`：房主信息，详见 [AUIUserThumbnailInfo](#AUIUserThumbnailInfo)。
- `onlineUsers`：房间内的人数。
- `createTime`：房间创建的时间（单位？//TODO）

### <h3 className="anchor" id="AUIUserThumbnailInfo">AUIUserThumbnailInfo</h3>

```kotlin
public class AUIUserThumbnailInfo implements Serializable {

    public @NonNull String userId = "";
    public @NonNull String userName = "";
    public @NonNull String userAvatar = "";

}
```

K 歌中房主的相关信息。

**参数**

- `userId`：房主的 ID。
- `userName`：房主的用户名。
- `userAvatar`：房主的头像。

### <h3 className="anchor" id="AUIException">AUIException</h3>

```kotlin
public AUIException(int code, String message)
```

错误码及信息。

**参数**

- `code`：错误码// TODO 有哪些？
- `message`：错误信息。

### <h3 className="anchor" id="AUIRoomConfig">AUIRoomConfig</h3>

K 歌房间设置。

```kotlin
public class AUIRoomConfig {

    @NonNull public String channelName = "";     //正常rtm使用的频道
    @NonNull public String rtmToken = "";     //rtm login用，只能007
    @NonNull public String rtcToken = "";     //rtm join用
    @NonNull public String rtcChannelName = "";  //rtc使用的频道
    @NonNull public String rtcRtcToken = "";  //rtc join使用
    @NonNull public String rtcRtmToken = "";  //rtc mcc使用，只能006
    @NonNull public String rtcChorusChannelName = "";  //rtc 合唱使用的频道
    @NonNull public String rtcChorusRtcToken = "";  //rtc 合唱join使用

    public AUIRoomConfig(@NonNull String roomId) {
        channelName = roomId;
        rtcChannelName = roomId + "_rtc";
        rtcChorusChannelName = roomId + "_rtc_ex";
    }
}
```

**参数**

- `channelName`：主频道名，一般为 `roomId`。在合唱场景下，领唱需要加入两个频道，在主频道发布人声和播放器的混流，在合唱频道发布麦克风采集的音频流，伴唱需要加入合唱频道来同步领唱的人声。

- `rtmToken`：加入主频道时的 RTM Token。//TODO 这个 token 是用于什么鉴权？

  <Admonition type="caution" title="注意">

  请确保你使用的 RTM Token 是 AccessToken2。

  </Admonition>

- `rtcToken`：加入主频道时用于鉴权的 RTC Token。

- `rtcChannelName`：音视频频道名，一般为{roomId}_rtc。//TODO 音视频频道和主频道之间有什么区别？

- `rtcRtcToken`：

- `rtcRtmToken`：用于音乐内容中心鉴权的 RTM Token。

  <Admonition type="caution" title="注意">

  请确保你使用的 RTM Token 是 AccessToken。//rtc mcc 使用是啥意思？

  </Admonition>

- `rtcChorusChannelName`：合唱频道名。在合唱场景下，领唱需要加入两个频道，在主频道发布人声和播放器的混流，在合唱频道发布麦克风采集的音频流，伴唱需要加入合唱频道来同步领唱的人声。//TODO 独唱场景下，这个参数为空？

- `rtcChorusRtcToken`：根据合唱频道名和用户 ID 生成的 RTC Token，用于加入合唱频道时进行鉴权。//TODO 在独唱场景下，该参数可以为空？



 