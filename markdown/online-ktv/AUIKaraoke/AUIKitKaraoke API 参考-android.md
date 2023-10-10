# AUIKaraoke Kotlin API (Android)

本文介绍 AUIKaraoke 组件的 API。你可以在 GitHub 上查看[源码文件](https://github.com/AgoraIO-Community/AUIKaraoke/blob/main/Android)。

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

初始化 AUIKaraoke。

在调用 `KaraokeUIKit` 类下的其他 API 前，你需要先调用该方法进行初始化。

**参数**

- `config`：初始化设置，详见 [AUICommonConfig](#AUICommonConfig)。
- `ktvApi`：K 歌房[场景化 API](https://docportal.shengwang.cn/cn/online-ktv/ktv_api_kotlin?platform=Android) 实例。如果你的项目中还未使用场景化 API，请传入 `null`，AUIKaraoke 内部会自行创建场景化 API 实例。
- `rtcEngineEx`：[RtcEngineEx](https://docportal.shengwang.cn/cn/online-ktv/API%20Reference/java_ng/API/rtc_interface_class.html#class_irtcengineex) 实例。如果的你的项目中还未使用声网 RTC SDK，请传入 `null`，AUIKaraoke 内部会自行创建 `RtcEngineEx` 实例。
- `rtmClient`：[RtmClient](https://doc.shengwang.cn/doc/rtm2/java/landing-page) 实例。如果的你的项目中还未使用声网 RTM SDK，请传入 `null`，AUIKaraoke 内部会自行创建 `RtmClient` 实例。

### createRoom

```kotlin
fun createRoom(
    createRoomInfo: AUICreateRoomInfo,
    success: (AUIRoomInfo) -> Unit,
    failure: (AUIException) -> Unit
)
```

创建 K 歌房间。

在 K 歌场景下，创建房间的人自动成为房主。异步调用成功后，会返回成功创建的房间信息。

**参数**

- `createRoomInfo`：房间信息，详见 [AUICreateRoomInfo](#AUICreateRoomInfo)。
- `success`：回调函数，当房间创建成功时调用。接受一个 `AUIRoomInfo` 参数，表示成功创建的房间信息，无返回值。
- `failure`：回调函数，当房间创建失败时调用。接受一个 `AUIException` 参数表示房间创建失败的异常，无返回值。

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

- `startTime`：房间创建的时间，用于筛选在该时间之后创建的房间。
- `pageSize`：每一页房间列表所展示的房间数量。
- `success`：回调函数，当成功获取到 K 歌房间列表时调用，会返回一个房间信息列表，详见 [AUIRoomInfo](#AUIRoomInfo)。
- `failure`：回调函数，当房间创建失败时调用，接受一个 `AUIException` 参数表示房间创建失败的异常，无返回值。

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

释放 AUIKaraoke 的所有资源。

### subscribeError

```kotlin
fun subscribeError(roomId: String, delegate: AUIRtmErrorProxyDelegate)
```

订阅房间相关的异常回调。

你可以通过该方法订阅房间相关的异常回调，如 Token 过期、网络连接等问题。

**参数**

- `roomId`：房间 ID。

- `delegate`：[AUIRtmErrorProxyDelegate](https://github.com/AgoraIO-Community/AUIKaraoke/blob/main/Android/README.zh.md#auirtmerrorproxydelegate) 实例，用于处理异常回调。

### unsubscribeError

```kotlin
fun unsubscribeError(roomId: String, delegate: AUIRtmErrorProxyDelegate)
```

取消订阅房间相关的异常回调。

你可以调用该方法取消订阅与指定 `roomId` 相关的房间的异常回调。取消订阅后，不再接收与该房间相关的任何异常回调。

**参数**

- `roomId`：房间 ID。

- `delegate`：[AUIRtmErrorProxyDelegate](https://github.com/AgoraIO-Community/AUIKaraoke/blob/main/Android/README.zh.md#auirtmerrorproxydelegate) 实例，用于处理异常回调。

### bindRespDelegate

```kotlin
fun bindRespDelegate(delegate: AUIRoomManagerRespDelegate)
```


绑定对应房间的响应。

你可以调用该方法将实现了 `AUIRoomManagerRespDelegate` 的对象绑定到当前事件，以便在事件完成时，回调或通知这个对象以处理相应的结果或响应，例如房间被销毁、用户被踢出、房间的信息更新等。

请确保你的 `AUIRoomManagerRespDelegate` 对象实现了 `AUIRoomManagerRespDelegate` 中的方法，以便能够正确处理响应。

**参数**

- `delegate`：[AUIRoomManagerRespDelegate](https://github.com/AgoraIO-Community/AUIKaraoke/blob/main/Android/README.zh.md#auiroommanagerrespdelegate) 实例，用于处理与房间操作相关的各种响应事件。你可以根据你的业务需求选择性实现该接口类中的方法。

### unbindRespDelegate

```kotlin
fun unbindRespDelegate(delegate: AUIRoomManagerRespDelegate)
```

取消绑定对应房间的响应。

你可以调用该方法取消已绑定到当前操作或事件的 `AUIRoomManagerRespDelegate` 对象。解除绑定后，将不再通知 `AUIRoomManagerRespDelegate` 对象与房间管理操作相关的结果或响应。

**参数**

`delegate`：[AUIRoomManagerRespDelegate](https://github.com/AgoraIO-Community/AUIKaraoke/blob/main/Android/README.zh.md#auiroommanagerrespdelegate) 实例，用于处理与房间操作相关的各种响应事件。你可以根据你的业务需求选择性实现该接口类中的方法。

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
- `createTime`：房间创建的时间，单位为毫秒。

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

- `code`：错误码。
- `message`：错误信息。

### <h3 className="anchor" id="AUIRoomConfig">AUIRoomConfig</h3>

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

K 歌房间设置。

**参数**

- `channelName`：RTM 频道的频道名，该频道用于同步数据信息、传输信令。

- `rtmToken`：登陆 RTM 系统时用的 RTM Token。

  <Admonition type="caution" title="注意">

  请确保你使用的 RTM Token 是 AccessToken2。

  </Admonition>

- `rtcToken`：加入 RTM 频道时使用的 RTC Token。
  <Admonition type="caution" title="注意">

  请确保你使用的 RTC Token 是 AccessToken2。详见[使用 Token 鉴权](https://doc.shengwang.cn/doc/rtc/ios/basic-features/token-authentication)。

  </Admonition>

- `rtcChannelName`：主频道的频道名。在合唱场景下，领唱需要加入两个频道，在主频道发布人声和播放器的混流，在合唱频道发布麦克风采集的音频流。伴唱需要加入合唱频道来同步领唱的人声。

- `rtcRtcToken`：加入主频道的 RTC Token。

- `rtcRtmToken`：RTM Token，用于音乐内容中鉴权。

- `rtcChorusChannelName`：合唱频道名。独唱场景下，该参数可为空。

- `rtcChorusRtcToken`：根据合唱频道名和用户 ID 生成的 RTC Token，用于加入合唱频道时进行鉴权。独唱场景下，该参数可为空。



