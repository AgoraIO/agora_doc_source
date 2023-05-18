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

该方法用于获取各类歌曲榜单，并提供一个回调函数用于处理异步调用的结果。

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
    - 3：权限错误或歌曲不存在。请确保你的项目已开通声网音乐内容中心权限。
    - 4：内部数据解析错误。
    - 5：歌曲加载时出错。
    - 6：歌曲解密时出错。
  - `list`：[`MusicChartInfo`](https://docportal.shengwang.cn/cn/extension_customer/API%20Reference/java_ng/API/class_musicchartinfo.html?platform=Android) 对象数组，包含歌曲榜单信息。

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
- `page`：当前页面编号，默认从 1 开始。
- `pageSize`：当前音乐资源列表的总页面数量，最大值为 50。
- `jsonOption`：扩展 JSON 字段，可依据特殊需要进行定制，默认为 `NULL`。
- `onMusicCollectionResultListener`：获取歌曲资源列表回调，包含以下参数：
  - `requestId`：请求 ID。本次请求的唯一标识。
  - `status`：请求状态。
    - 0：请求成功。
    - 1：一般错误，无明确归因。
    - 2：网关异常。可能的原因有：
      - 当前使用的 Token 已过期。请重新生成 Token。
      - 传入的 Token 无效。请确保你使用的是 RTM Token。
      - 网络错误。请检查你的网络。
    - 3：权限错误或歌曲不存在。请确保你的项目已开通声网音乐内容中心权限。
    - 4：内部数据解析错误。
    - 5：歌曲加载时出错。
    - 6：歌曲解密时出错。
  - `page`：当前页面编号，默认从 1 开始。
  - `pageSize`：当前歌曲资源列表的总页面数量，最大值为 50。
  - `total`：列表内歌曲资源的总数量。
  - `list`：[`Music`](https://docportal.shengwang.cn/cn/online-ktv/API%20Reference/java_ng/API/class_music.html) 对象数组，包含歌曲的详细信息。

### searchMusicByKeyword

```kotlin
fun searchMusicByKeyword(
        keyword: String,
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

通过关键词搜索歌曲。

此方法提供一个回调函数用于处理异步调用的结果。

#### 参数

- `keyword`：搜索关键词，支持歌曲名、歌手搜索。
- `page`：想要获取的音乐资源列表的目标页编号。
- `pageSize`：每页所展示的音乐资源的最大数量，最大值为 50。
- 扩展 JSON 字段，可依据特殊需要进行定制，默认为 `NULL`。
- `onMusicCollectionResultListener`：获取歌曲资源列表回调，包含以下参数：
  - `requestId`：请求 ID。本次请求的唯一标识。
  - `status`：请求状态。
    - 0：请求成功。
    - 1：一般错误，无明确归因。
    - 2：网关异常。可能的原因有：
      - 当前使用的 Token 已过期。请重新生成 Token。
      - 传入的 Token 无效。请确保你使用的是 RTM Token。
      - 网络错误。请检查你的网络。
    - 3：权限错误或歌曲不存在。请确保你的项目已开通声网音乐内容中心权限。
    - 4：内部数据解析错误。
    - 5：歌曲加载时出错。
    - 6：歌曲解密时出错。
  - `page`：当前页面编号，默认从 1 开始。
  - `pageSize`：当前歌曲资源列表的总页面数量，最大值为 50。
  - `total`：列表内歌曲资源的总数量。
  - `list`：[`Music`](https://docportal.shengwang.cn/cn/online-ktv/API%20Reference/java_ng/API/class_music.html) 对象数组，包含歌曲的详细信息。

### loadMusic [1/2]

```kotlin
fun loadMusic(
    songCode: Long,
    config: KTVLoadMusicConfiguration,
    musicLoadStateListener: IMusicLoadStateListener
)
```

加载歌曲和歌词。

传入歌曲编号和加载配置，调用 `loadMusic` 加载歌曲和歌词。加载结果会通过 `IMusicLoadStateListener` 回调异步通知你。

#### 参数

- `songCode`: 歌曲编号，用于标识一个音乐资源。你可以通过 `searchMusicByMusicChartId` 或 `searchMusicByKeyword` 获取需要加载的歌曲编号，也可以通过 RESTful API 来获取[获取曲库所有歌曲列表](https://docportal.shengwang.cn/cn/online-ktv/ktv_song_rest?platform=Android#a-namegeta获取曲库所有歌曲列表)或[增量歌曲列表](https://docportal.shengwang.cn/cn/online-ktv/ktv_song_rest?platform=Android#获取增量歌曲列表)。
- `config`: 加载配置。详见 [KTVLoadMusicConfiguration](#ktvsongconfiguration)。
- `musicLoadStateListener`: 歌曲加载状态，详见 [`IMusicLoadStateListener`](#IMusicLoadStateListener)。

## loadMusic [2/2]

```kotlin
fun loadMusic(
    url: String,
    config: KTVLoadMusicConfiguration
)
```

加载歌曲和歌词。

传入歌曲的 URL 和加载配置，调用 `loadMusic` 加载歌曲和歌词。加载结果会通过 `IMusicLoadStateListener` 回调异步通知你。

#### 参数

- `url`：歌曲的 URL。
- `config`：加载配置。详见 [KTVLoadMusicConfiguration](#ktvsongconfiguration)。


### switchSingerRole

```kotlin
fun switchSingerRole(
    newRole: KTVSingRole,
    switchRoleStateListener: ISwitchRoleStateListener?
)
```

切换 K 歌时的用户角色。

KTV API 初始化时默认用户角色为听众，如果需要开始独唱或加入合唱，需要调用 `switchSingerRole` 来切换至相应的角色。你可以参考[切换说明](link)来进行角色切换。

KTV API 内部会根据角色的切换来控制演唱过程中音乐播放器的播放、同步，以及订阅和发布音频流的行为。角色切换的结果会通过 `ISwitchRoleStateListener` 回调异步通知你。

#### 参数

- `newRole`: 切换后的用户角色，详见 [`KTVSingRole`](#KTVSingRole)。
- `switchRoleStateListener`：用户角色切换结果回调，详见 [`ISwitchRoleStateListener`](#ISwitchRoleStateListener)。

### startSing [1/2]

```kotlin
fun startSing(songCode: Long, startPos: Long)
```

播放歌曲。

如果你在调用 `loadMusic` 加载歌曲时，将 `autoPlay` 设为 `true` (仅独唱角色可设为该值)，歌曲在加载完成后会自动播放，无需再调用该方法播放歌曲。如果将 `autoPlay` 设为 `false`，则需在收到 `onMusicLoadSuccess` 回调后再调用该方法来播放歌曲。<mark>实际上观众不需要调用startsing，只有独唱需要？根据hugo的解释，伴唱也不用播放。</mark>

#### 参数

- `songCode`：歌曲编号，用于标识一个音乐资源。你可以通过 `searchMusicByMusicChartId` 或 `searchMusicByKeyword` 获取需要加载的歌曲编号，也可以通过 RESTful API 来获取[获取曲库所有歌曲列表](https://docportal.shengwang.cn/cn/online-ktv/ktv_song_rest?platform=Android#a-namegeta获取曲库所有歌曲列表)或[增量歌曲列表](https://docportal.shengwang.cn/cn/online-ktv/ktv_song_rest?platform=Android#获取增量歌曲列表)。
- `startPos`：起始播放位置，单位为毫秒。

### startSing [2/2]

```kotlin
fun startSing(url: String, startPos: Long)
```

播放歌曲。

你可以通过传入歌曲的 URL 来进行播放。

如果你在调用 `loadMusic[2/2]` 加载歌曲时，将 `autoPlay` 设为 `true` (仅独唱角色可设为该值)，歌曲在加载完成后会自动播放，无需再调用该方法播放歌曲。如果将 `autoPlay` 设为 `false`，则需在收到 `onMusicLoadSuccess` 回调后再调用该方法来播放歌曲。

#### 参数

- `url`：歌曲的 URL。
- `startPos`：起始播放位置，单位为毫秒。

### resumeSing

```kotlin
fun resumeSing()
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