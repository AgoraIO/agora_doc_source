本文提供在线 K 歌房场景定制化 Kotlin API。


## 方法

### initWithRtcEngine

```kotlin
fun initWithRtcEngine(
    engine: RtcEngine,
    channelName: String,
    musicCenter: IAgoraMusicContentCenter,
    player: IAgoraMusicPlayer,
    streamId: Int,
    ktvApiEventHandler: KTVApiEventHandler
)
```

初始化 KTV API。

调用该方法可以初始化 KTV API 模块内部变量和缓存数据，并注册相应的回调监听。

#### 注意事项

调用其他 KTV API 之前，你需要先调用本方法初始化。

#### 参数

- `engine`: [RtcEngine](https://docs.agora.io/cn/online-ktv/API%20Reference/java_ng/API/rtc_interface_class.html#class_irtcengine) 实例。
- `channelName`: 待加入的频道名。
- `musicCenter`: 版权音乐内容中心实例。详见 [IAgoraMusicContentCenter](https://docs.agora.io/cn/online-ktv/API%20Reference/java_ng/API/rtc_interface_class.html#class_imusiccontentcenter)。
- `player`: 音乐播放器实例。详见 [IAgoraMusicPlayer](https://docs.agora.io/cn/online-ktv/API%20Reference/java_ng/API/rtc_interface_class.html#class_imusicplayer)。
- `streamId`: 数据流（Data Stream）ID。
- `ktvApiEventHandler`: K 歌场景化 API 的事件句柄。详见[回调](#onplayerstatechanged)。


### release

```kotlin
fun release()
```

释放 KTV API 资源。

调用该方法可以清空 KTV API 模块内部变量和缓存数据，取消 `ktvApiEventHandler` 的事件监听，取消网络请求等。

### 用法示例

```kotlin
// K 歌房 Activity 销毁时调用 ktvApiProtocol 释放，随后释放创建的实例
@Override
protected void onDestroy() {
    super.onDestroy();
    ktvApiProtocol.release()
    // 释放 mRtcEngine、iAgoraMusicContentCenter、mPlayer、streamId
}
```

### loadSong

```kotlin
fun loadSong(
    songCode: Long,
    config: KTVSongConfiguration,
    onLoaded: (songCode: Long, lyricUrl: String, role: KTVSingRole, state: KTVLoadSongState) -> Unit
)
```

加载歌曲。

传入歌曲编号和 K 歌配置，调用 `loadSong` 加载歌曲。加载结果会异步地通过 `onLoaded` 回调通知你。

#### 参数

- `songCode`: 歌曲编号。
- `config`: K 歌配置。详见 [KTVSongConfiguration](#ktvsongconfiguration)。
- `onLoaded`: 歌词加载状态事件。


### playSong

```kotlin
fun playSong(songCode: Long)
```

播放歌曲。

建议在调用 `loadSong` 函数成功回调 `KTVLoadSongState.KTVLoadSongStateOK` 后再调用 `playSong`。

#### 参数

- `songCode`: 歌曲编号。

### stopSong

```kotlin
fun stopSong()
```

结束播放歌曲。

### resumePlay

```kotlin
fun resumePlay()
```

恢复播放歌曲。


### pausePlay

```kotlin
fun pausePlay()
```

暂停播放歌曲。

### seek

```kotlin
fun seek(time: Long)
```

跳转到指定时间播放歌曲。

#### 参数

- `time`: 跳转的时间点。单位为毫秒。

### selectTrackMode

```kotlin
fun selectTrackMode(mode: KTVPlayerTrackMode)
```

选择歌曲的音轨。

歌曲的音轨包含原唱和伴奏。调用该方法可以选择播放的音轨。

#### 参数

- `mode`: 音轨的类型。详见 [KTVPlayerTrackMode](#ktvplayertrackmode)。

### setLycView

```kotlin
fun setLycView(view: LrcControlView)
```

设置歌词控制视图。

歌词控制视图用于显示歌词和控制歌词滚动等操作。调用该方法后，可以将歌词控制视图和 KTV 模块进行绑定，从而实现歌词的同步滚动。

#### 参数

- `view`: 歌词控制视图，`LrcControlView` 对象。


## 回调

### onPlayerStateChanged

```kotlin
interface KTVApiEventHandler {
    fun onPlayerStateChanged(controller: KTVApi, state: Constants.MediaPlayerState, error: Constants.MediaPlayerError, isLocal: Boolean)
}
```
播放器状态改变回调。

#### 参数

- `controller`: KTVApi 实例。
- `state`: 播放器的当前状态。详见 [MediaPlayerState](https://docs.agora.io/cn/online-ktv/API%20Reference/java_ng/API/enum_mediaplayerstate.html?platform=Android)。
- `error`: 播放器的错误码。详见 [MediaPlayerError](https://docs.agora.io/cn/online-ktv/API%20Reference/java_ng/API/enum_mediaplayererror.html?platform=Android)。
- `isLocal`: 是否为本地事件：
    - `true`: 是本地事件。
    - `false`: 不是本地事件。


## Enum class

### KTVSongType

```kotlin
enum class KTVSongType {
    KTVSongTypeSolo,
    KTVSongTypeChorus
}
```
K 歌场景类型：
- `KTVSongTypeSolo`: 独唱场景
- `KTVSongTypeChorus`: 合唱场景

### KTVSingRole

```kotlin
enum class KTVSingRole {
    KTVSingRoleMainSinger,
    KTVSingRoleCoSinger,
    KTVSingRoleAudience
}
```
K 歌用户角色类型：
- `KTVSingRoleMainSinger`: 主唱
- `KTVSingRoleCoSinger`: 伴唱
- `KTVSingRoleAudience`: 观众

### KTVPlayerTrackMode

```kotlin
enum class KTVPlayerTrackMode {
    KTVPlayerTrackOrigin,
    KTVPlayerTrackAcc
}
```

K 歌播放音轨类型：
- `KTVPlayerTrackOrigin`: 原唱
- `KTVPlayerTrackAcc`: 伴奏


### KTVLoadSongState

```kotlin
enum class KTVLoadSongState {
    KTVLoadSongStateOK,
    KTVLoadSongStateInProgress,
    KTVLoadSongStateNoLyricUrl,
    KTVLoadSongStatePreloadFail,
    KTVLoadSongStateIdle
}
```

歌曲加载的状态：
- `KTVLoadSongStateOK`: 加载成功
- `KTVLoadSongStateInProgress`: 正在加载中
- `KTVLoadSongStateNoLyricUrl`: 歌曲无法加载，缺少歌词地址
- `KTVLoadSongStatePreloadFail`: 加载失败
- `KTVLoadSongStateIdle`: 空闲状态，未加载歌曲


## Data class

### KTVSongConfiguration

```kotlin
data class KTVSongConfiguration(
    val type: KTVSongType,
    val role: KTVSingRole,
    val songCode: Long,
    val mainSingerUid: Int,
    val coSingerUid: Int
)
```

K 歌配置：

- `type`: K 歌场景类型，详见 [KTVSongType](#ktvsongtype)
- `role`: K 歌用户角色类型，详见 [KTVSingRole](#ktvsingrole)
- `songCode`: 歌曲的编号
- `mainSingerUid`: 主唱的 UID
- `coSingerUid`: 伴唱的 UID

UID 指用户 ID，用于标识频道内的用户，频道内的每个 UID 都必须是唯一。UID 是 32 位无符号整数，建议取值范围为 [1,2<sup>32</sup>-1]。