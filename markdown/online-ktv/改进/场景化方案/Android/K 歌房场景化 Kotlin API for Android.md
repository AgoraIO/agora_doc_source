本文提供在线 K 歌房场景定制化 Kotlin API。你可以在 GitHub 上查看源码文件 [KTVApi.kt](https://github.com/AgoraIO-Usecase/agora-ent-scenarios/blob/v2.3.1-Android/Android/scenes/ktv/src/main/java/io/agora/scene/ktv/live/KTVApi.kt) 和 [KTVApiImpl.kt](https://github.com/AgoraIO-Usecase/agora-ent-scenarios/blob/v2.3.1-Android/Android/scenes/ktv/src/main/java/io/agora/scene/ktv/live/KTVApiImpl.kt)。

## 方法

### initialize

```kotlin
fun initialize(config: KTVApiConfig)
```

初始化 KTV API 并进行初始化配置。

调用该方法可以初始化 KTV API 模块内部变量和缓存数据，并注册相应的回调监听。

#### 注意事项

调用其他 KTV API 之前，你需要先调用本方法初始化。

#### 参数

- `config`：初始化配置，详见 [KTVApiConfig](#KTVApiConfig)。


### release

```kotlin
fun release()
```

释放 KTV API 资源。

调用该方法可以清空 KTV API 模块内部变量和缓存数据，取消 `ktvApiEventHandler` 的事件监听，取消网络请求等。

#### 用法示例 ？为什么要加？

```kotlin
// K 歌房 Activity 销毁时调用 ktvApiProtocol 释放，随后释放创建的实例
@Override
protected void onDestroy() {
    super.onDestroy();
    ktvApiProtocol.release()
    // 释放 mRtcEngine、iAgoraMusicContentCenter、mPlayer、streamId
}
```

### addEventHandler

```kotlin
fun addEventHandler(ktvApiEventHandler: IKTVApiEventHandler)
```

注册 KTV API 事件。你可以多次调用该方法注册多个事件回调。

#### 参数

- `ktvApiEventHandler`：KTV API 的事件句柄，详见[IKTVApiEventHandler]()。

### removeEventHandler

```kotlin
fun removeEventHandler(ktvApiEventHandler: IKTVApiEventHandler)
```

取消注册 KTV API 事件。

#### 参数

- `ktvApiEventHandler`：KTV API 的事件句柄，详见[IKTVApiEventHandler]()。

### fetchMusicCharts

```kotlin
fun fetchMusicCharts(
    onMusicChartResultListener: (
        requestId: String?, 
        status: Int,
        list: Array<out MusicChartInfo>?
    ) -> Unit
)
```

获取歌曲榜单。

该方法用于获取歌曲榜单的信息，并提供一个回调函数用于处理异步调用的结果。

#### 参数

- `onMusicChartResultListener`：歌曲榜单列表回调，包含以下参数：
  - `requestId`：请求 ID。本次请求的唯一标识。
  - `status`：请求状态。
    - 0：请求成功。
    - 1：一般错误，无明确归因。
    - 2：网关异常。可能的原因有：
      - 当前使用的 Token 已过期。请重新生成 Token。
      - 传入的 Token 无效。请确保你使用的是 RTM Token。
      - 网络错误。请检查你的网络。
    - 3：权限错误或音乐资源不存在。请确保你的项目已开通声网音乐内容中心权限。
    - 4：内部数据解析错误。
    - 5：音乐资源加载时出错。
    - 6：音乐资源解密时出错。
  - `list`：[`MusicChartInfo`](https://docportal.shengwang.cn/cn/extension_customer/API%20Reference/java_ng/API/class_musicchartinfo.html?platform=Android) 对象数组。

### searchMusicByMusicChartId

```kotlin
fun searchMusicByMusicChartId(
    musicChartId: Int,
    page: Int,
    pageSize: Int,
    jsonOption: String,
    onMusicCollectionResultListener: (
        requestId: String?, 
        status: Int,         
        page: Int,
        pageSize: Int,
        total: Int,
        list: Array<out Music>?
    ) -> Unit
)
```

通过歌曲榜单的 ID 获取指定榜单的歌曲资源列表。

当你调用 `fetchMusicCharts` 获取歌曲榜单 ID 之后，可以通过此方法来检索对应的歌曲资源列表。此方法提供一个回调函数用于处理异步调用的结果。

#### 参数

- `musicChartId`：歌曲榜单 ID，可通过 `fetchMusicCharts` 获取。
- `page`：

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
- `onLoaded`: 歌词加载状态事件，包含如下参数：
    - `songCode`: 歌曲编号。
    - `lyricUrl`: 歌词文件的 URL。
    - `role`: 当前用户角色，详见 [KTVSingRole](#ktvsingrole)。
    - `state`: 歌曲加载状态，详见 [KTVLoadSongState](#ktvloadsongstate)。


### playSong

```kotlin
fun playSong(songCode: Long)
```

播放歌曲。

建议在调用 `loadSong` 函数并收到 `onLoaded` 回调的 `KTVLoadSongState.KTVLoadSongStateOK` 状态后再调用 `playSong`。

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

选择播放的音轨。

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