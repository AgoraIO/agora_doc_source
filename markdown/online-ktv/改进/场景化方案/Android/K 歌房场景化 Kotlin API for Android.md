本文提供在线 K 歌房场景定制化 Kotlin API。你可以在 GitHub 上查看源码文件 [KTVApi.kt](https://github.com/AgoraIO-Usecase/agora-ent-scenarios/blob/v2.3.1-Android/Android/scenes/ktv/src/main/java/io/agora/scene/ktv/live/KTVApi.kt) 和 [KTVApiImpl.kt](https://github.com/AgoraIO-Usecase/agora-ent-scenarios/blob/v2.3.1-Android/Android/scenes/ktv/src/main/java/io/agora/scene/ktv/live/KTVApiImpl.kt)。

<div class="alert note">本文适用于 K 歌场景化 API v3.0.0。</div>


## KTVApi

该类提供实现 K 歌场景的核心方法。

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

### renewToken

```kotlin
fun renewToken(
    rtmToken: String,
    chorusChannelRtcToken: String
)
```

更新 Token。

当你收到 `onTokenPrivilegeWillExpire` 回调报告 Token 即将过期时，需要主动调用此方法更新 Token。

#### 参数

- `rtmToken`：用于音乐内容中心鉴权的 RTM Token。
- `chorusChannelRtcToken`：加入频道 2 的 Token。在合唱场景下，领唱需要加入两个频道，频道 1 用户发布人声和播放器的混流，加入频道 2 发布麦克风采集的音频流，伴唱需要加入频道 2 来同步领唱的人声。

### addEventHandler

```kotlin
fun addEventHandler(ktvApiEventHandler: IKTVApiEventHandler)
```

注册 KTV API 事件。你可以多次调用该方法注册多个事件回调。

#### 参数

- `ktvApiEventHandler`：KTV API 的事件句柄，详见[IKTVApiEventHandler](#IKTVApiEventHandler)。

### removeEventHandler

```kotlin
fun removeEventHandler(ktvApiEventHandler: IKTVApiEventHandler)
```

取消注册 KTV API 事件。

#### 参数

- `ktvApiEventHandler`：KTV API 的事件句柄，详见[IKTVApiEventHandler](#IKTVApiEventHandler)。

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
  - `list`：[MusicChartInfo](https://docportal.shengwang.cn/cn/extension_customer/API%20Reference/java_ng/API/class_musicchartinfo.html?platform=Android) 对象数组，包含歌曲榜单信息。

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
- `pageSize`：每页所展示的音乐资源的最大数量，最大值为 50。
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
  - `list`：[Music](https://docportal.shengwang.cn/cn/online-ktv/API%20Reference/java_ng/API/class_music.html) 对象数组，包含歌曲的详细信息。

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

### loadMusic [1/2]

```kotlin
fun loadMusic(
    songCode: Long,
    config: KTVLoadMusicConfiguration,
    musicLoadStateListener: IMusicLoadStateListener
)
```

通过歌曲编号加载歌曲和歌词。

传入歌曲编号和加载配置，调用 `loadMusic` 加载歌曲和歌词。加载结果会通过 `IMusicLoadStateListener` 回调异步通知你。

#### 注意

目前一次仅支持加载一首歌曲，请在一首歌曲加载完成后再加载下一首。

#### 参数

- `songCode`: 歌曲编号，用于标识一个音乐资源。你可以通过 `searchMusicByMusicChartId` 或 `searchMusicByKeyword` 获取需要加载的歌曲编号，也可以通过 RESTful API 来获取[获取曲库所有歌曲列表](https://docportal.shengwang.cn/cn/online-ktv/ktv_song_rest?platform=Android#a-namegeta获取曲库所有歌曲列表)或[增量歌曲列表](https://docportal.shengwang.cn/cn/online-ktv/ktv_song_rest?platform=Android#获取增量歌曲列表)。
- `config`: 加载配置。详见 [KTVLoadMusicConfiguration](#KTVLoadMusicConfiguration)。
- `musicLoadStateListener`: 歌曲加载状态，详见 [`IMusicLoadStateListener`](#IMusicLoadStateListener)。

### loadMusic [2/2]

```kotlin
fun loadMusic(
    url: String,
    config: KTVLoadMusicConfiguration
)
```

通过歌曲 URL 加载歌曲和歌词。

传入歌曲的 URL 和加载配置，调用 `loadMusic` 加载歌曲和歌词。

#### 注意

目前一次仅支持加载一首歌曲，请在一首歌曲加载完成后再加载下一首。

#### 参数

- `url`：歌曲的 URL。
- `config`：加载配置。详见 [KTVLoadMusicConfiguration](#KTVLoadMusicConfiguration)。


### switchSingerRole

```kotlin
fun switchSingerRole(
    newRole: KTVSingRole,
    switchRoleStateListener: ISwitchRoleStateListener?
)
```

切换 K 歌时的用户角色。

KTV API 初始化时默认用户角色为听众，如果需要开始独唱或加入合唱，需要调用 `switchSingerRole` 来切换至相应的角色。你可以参考[切换说明](https://docportal.shengwang.cn/cn/online-ktv/ktv_integration_android?platform=Android#4-切换角色)来进行角色切换。

KTV API 内部会根据角色的切换来控制演唱过程中音乐播放器的播放、同步，以及订阅和发布音频流的行为。角色切换的结果会通过 `ISwitchRoleStateListener` 回调异步通知你。

#### 参数

- `newRole`: 切换后的用户角色，详见 [`KTVSingRole`](#KTVSingRole)。
- `switchRoleStateListener`：用户角色切换结果回调，详见 [`ISwitchRoleStateListener`](#ISwitchRoleStateListener)。

### startSing [1/2]

```kotlin
fun startSing(songCode: Long, startPos: Long)
```

播放歌曲。

如果你在调用 `loadMusic[1/2]` 加载歌曲时，将 `autoPlay` 设为 `true` (仅独唱角色可设为该值)，歌曲在加载完成后会自动播放，无需再调用该方法播放歌曲。如果将 `autoPlay` 设为 `false`，则需在收到 `onMusicLoadSuccess` 回调后再调用该方法来播放歌曲。

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


### pauseSing

```kotlin
fun pauseSing()
```

暂停播放歌曲。

### seekSing

```kotlin
fun seekSing(time: Long)
```

跳转到指定时间播放歌曲。

#### 参数

- `time`: 跳转的时间点，单位为毫秒。

### setMicStatus

```kotlin
fun setMicStatus(isOnMicOpen: Boolean)
```

同步麦克风的开关状态。

如果你调用 [`adjustRecordSignalVolume`](https://docportal.shengwang.cn/cn/online-ktv/API%20Reference/java_ng/API/toc_audio_process.html?platform=Android#api_irtcengine_adjustrecordingsignalvolume) 将 `volume` 设为 0（即闭麦），你需要调用此方法将 `isOnMicOpen` 设为 `false` 来将闭麦状态设置给歌词打分组件。

#### 参数

- `isOnMicOpen`：当前麦克风的开关状态：
  - `true`：麦克风开启。
  - `false`：（默认）麦克风关闭。

### setLrcView

```kotlin
fun setLrcView(view: ILrcView)
```

设置歌词控制视图。

歌词控制视图用于显示歌词和控制歌词滚动等操作。调用该方法后，可以将歌词控制视图和 KTV 模块进行绑定，从而实现歌词的同步滚动。

#### 参数

- `view`: 歌词控制视图，`ILrcView` 对象。你需要继承 `ILrcView` 类，并实现 `ILrcView` 下的接口。

### setAudioPlayoutDelay

```kotlin
fun setAudioPlayoutDelay(audioPlayoutDelay: Int)
```

设置音频播放延迟时间。

在音频自采集的情况下，你需要调用该方法传入音频帧处理和播放开始前的时间差以便播放器的实时同步。

#### 参数

- `audioPlayoutDelay`：音频帧处理和播放开始前的时间差，单位为毫秒。

### getMediaPlayer

```kotlin
fun getMediaPlayer() : IMediaPlayer
```

获取媒体播放器实例。

#### 返回值

-  [IMediaPlayer](https://docportal.shengwang.cn/cn/online-ktv/API%20Reference/java_ng/API/rtc_interface_class.html#class_imediaplayer) 实例。

### getMusicContentCenter

```kotlin
fun getMusicContentCenter() : IAgoraMusicContentCenter
```

获取音乐内容中心实例。

返回值

- [`IAgoraMusicContentCenter`](https://docportal.shengwang.cn/cn/online-ktv/API%20Reference/java_ng/API/rtc_interface_class.html#class_imusiccontentcenter) 实例。

### renewInnerDataStreamId

```kotlin
fun renewInnerDataStreamId()
```

更新 KTV API 内部使用的数据流 ID。

如果你调用 `leaveChannel` 离开当前频道，之前创建的数据流会失效，你需要在调用 `joinChannel` 加入频道后，重新调用该方法更新数据流的 ID 。

<div class="alert info">由于每个频道中最多只能创建 5 个数据流，因此请勿再一个频道内多次调用该方法。  
</div>

## ILrcView 

该类提供歌词组件的相关回调。在调用 `setLrcView` 设置歌词控制视图时，你需要继承此接口类并实现其下的方法。

### onUpdatePitch

```kotlin
fun onUpdatePitch(pitch: Float?)
```

人声音调更新回调。

你需要实现该回调来获取实时的人声音调传递给 KTV API 内部，便于打分组件使用。

#### 参数

- `pitch`：音调值。

### onUpdateProgress

```kotlin
fun onUpdateProgress(progress: Long?)
```

当歌曲播放进度更新时，会触发该回调报告歌曲的实时播放进度。该回调每 50 ms 触发一次。

#### 参数

- `progress`：当前歌曲的播放进度，单位为毫秒。

### onDownloadLrcData

```kotlin
fun onDownloadLrcData(url: String?)
```

当获取到歌词下载地址后，会触发调该回调报告歌词的下载地址。

#### 注意

请在这个回调内完成歌词下载。

#### 参数

- `url`：歌词的下载地址。

## IMusicLoadStateListener 

<a name="IMusicLoadStateListener"></a>

该接口类提供歌曲加载状态的相关回调。

### onMusicLoadSuccess

```kotlin
fun onMusicLoadSuccess(songCode: Long, lyricUrl: String)
```

歌曲加载成功回调。

当你调用 `loadMusic` 成功加载歌曲后，会触发该回调。

#### 参数

- `songCode`：歌曲编号，与你调用  `loadMusic` 时传入的歌曲编号一致。
- `lyricUrl`：歌词下载地址。

### onMusicLoadFail

```kotlin
fun onMusicLoadFail(songCode: Long, reason: KTVLoadSongFailReason)
```

歌曲加载失败。

当你调用 `loadMusic` 加载歌曲，加载失败后会触发该回调报告失败的原因。

#### 参数

- `songCode`：歌曲编号，与你调用  `loadMusic` 时传入的歌曲编号一致。
- `reason`：歌曲加载失败的原因，详见 [KTVLoadSongFailReason](#KTVLoadSongFailReason)。

### onMusicLoadProgress

```kotlin
fun onMusicLoadProgress(songCode: Long, percent: Int, status: MusicLoadStatus, msg: String?, lyricUrl: String?)
```

歌曲加载进度回调。

你可以通过该回调来获取当前歌曲的加载进度和状态。

#### 参数

- `songCode`：歌曲编号，与你调用  `loadMusic` 时传入的歌曲编号一致。
- `percent`：歌曲加载进度，取值范围为 [0,100]，100 表示加载完成。
- `status`：歌曲加载状态，详见 [MusicLoadStatus](#MusicLoadStatus)。
- `msg`：本次请求返回的消息。`ok` 表示请求成功。
- `lyricUrl`：歌词下载地址。

## ISwitchRoleStateListener 

<a name="ISwitchRoleStateListener"></a>

该接口类提供用户角色切换状态的相关回调。

### onSwitchRoleSuccess

```kotlin
fun onSwitchRoleSuccess()
```

用户角色切换成功回调。

当你调用 `switchSingerRole` 成功切换用户角色后，会触发该回调。

### onSwitchRoleFail

```kotlin
fun onSwitchRoleFail(reason: SwitchRoleFailReason)
```

用户角色切换失败回调。

当你调用 `switchSingerRole` 切换用户角色失败，会触发该回调。你可以通过该回调获取切换失败的原因。

#### 参数

- `reason`：切换角色失败的原因，详见 [SwitchRoleFailReason](#SwitchRoleFailReason)。

## IKTVApiEventHandler

<a name="IKTVApiEventHandler"></a>

该接口类提供 K 歌场景的核心回调。

### onMusicPlayerStateChanged

```kotlin
open fun onMusicPlayerStateChanged(
    state: Constants.MediaPlayerState,
    error: Constants.MediaPlayerError,
    isLocal: Boolean
) {}
```

播放器状态改变回调。

#### 参数

- `state`：播放器的当前状态。详见 [MediaPlayerState](https://docs.agora.io/cn/online-ktv/API%20Reference/java_ng/API/enum_mediaplayerstate.html?platform=Android)。
- `error`：播放器的错误码。详见 [MediaPlayerError](https://docs.agora.io/cn/online-ktv/API%20Reference/java_ng/API/enum_mediaplayererror.html?platform=Android)。
- `isLocal`: 是否为本地事件：
  - `true`: 代表是本地播放器的状态改变。可用于主唱和伴唱监听本地播放器状态。
  - `false`: 是远端播放器的状态改变。可用于伴唱和听众知晓主唱的播放器状态，从而方便后续进行多端播放同步。

举例来说，在合唱场景下，主唱、伴唱、听众收到的 `onMusicPlayerStateChanged` 回调有如下区别：

- 主唱：收到一个 `isLocal` 为 `true` 的回调，报告主唱播放器的状态改变。
- 伴唱：收到一个 `isLocal` 为 `true` 的回调，报告伴唱播放器的状态改变；同时，还收到一个 `isLocal` 为 `false` 的回调，报告主唱播放器的状态改变。
- 听众：收到一个 `isLocal` 为 `false` 的回调报告主唱端播放器的状态改变。

### onSingerRoleChanged

```kotlin
open fun onSingerRoleChanged(oldRole: KTVSingRole, newRole: KTVSingRole) {}
```

用户角色改变回调。

当你调用 `switchSingerRole` 成功切换用户角色后，会触发该回调报告切换前后的用户角色。

#### 参数

- `oldRole`：切换前的用户角色，详见 [KTVSingRole](#KTVSingRole)。
- `newRole`：切换后的用户角色，详见 [KTVSingRole](#KTVSingRole)。


### onTokenPrivilegeWillExpire

```kotlin
open fun onTokenPrivilegeWillExpire() {}
```

Token 即将过期回调。

当用于音乐内容中心鉴权的 RTM Token 或用于加入合唱频道鉴权的 Token 即将过期时，会触发该回调。

在收到该回调后，你需要调用 `renewToken` 来更新 Token。

### onChorusChannelAudioVolumeIndication

```kotlin
open fun onChorusChannelAudioVolumeIndication(
        speakers: Array<out IRtcEngineEventHandler.AudioVolumeInfo>?,
        totalVolume: Int) {}
```

领唱的人声音量回调。
开始合唱后，该回调会每 50 ms 触发一次，报告领唱的人声音量信息。

#### 参数

- `speaker`：领唱的音量信息，详见 [AudioVolumeInfo](https://docportal.shengwang.cn/cn/extension_customer/API%20Reference/java_ng/API/class_audiovolumeinfo.html?platform=Android) 数组。
- `totalVolume`：混音后的总音量，取值范围为 [0, 255]。


## Enum class

### KTVSingRole

<a name="KTVSingRole"></a>

```kotlin
enum class KTVSingRole(val value: Int) {
    SoloSinger(0),
    CoSinger(1),
    LeadSinger(2),
    Audience(3)
}
```

K 歌用户角色类型：

- `SoloSinger`：(0) 独唱者。
- `CoSinger`：(1) 伴唱。
- `LeadSinger`：(2) 领唱。
- `Audience`：(3) 听众。

### KTVLoadSongFailReason

<a name="KTVLoadSongFailReason"></a>

```kotlin
enum class KTVLoadSongFailReason(val value: Int) {
    NO_LYRIC_URL(0),
    MUSIC_PRELOAD_FAIL(1),
    CANCELED(2)
}
```

歌曲加载失败的原因：

- `NO_LYRIC_URL`：(0)  无歌词下载地址。
- `MUSIC_PRELOAD_FAIL`：(1) 歌曲加载失败。请检查你的网络链接或检查 Token 是否过期。
- `CANCELED`：(2) 歌曲加载因出现错误而终止。

### KTVSwitchRoleFailReason
<a name="SwitchRoleFailReason"/>

```kotlin
enum class KTVSwitchRoleFailReason(val value: Int) {
    JOIN_CHANNEL_FAIL(0),
    NO_PERMISSION(1)
}
```

用户角色切换失败的原因：

- `JOIN_CHANNEL_FAIL`：(0) 加入频道失败。
- `NO_PERMISSION`：(1) 不支持从当前角色切换为目标角色，请参考[切换说明](https://docportal.shengwang.cn/cn/online-ktv/ktv_integration_android?platform=Android#4-切换角色)进行角色切换。

### KTVLoadMusicMode 

<a name="KTVLoadMusicMode"></a>

```kotlin
enum class KTVLoadMusicMode(val value: Int) {
    LOAD_MUSIC_ONLY(0),
    LOAD_LRC_ONLY(1),
    LOAD_MUSIC_AND_LRC(2)
}
```

歌曲加载模式：

- `LOAD_MUSIC_ONLY`：(0) 仅加载歌曲。用户在加入合唱成为伴唱时使用此模式。
- `LOAD_LRC_ONLY`：(1) 仅加载歌词。用户角色为观众时使用此模式。
- `LOAD_MUSIC_AND_LRC`：(2) (默认) 加载歌词和歌曲。用户角色为独唱者时使用此模式。

### MusicLoadStatus

<a name="MusicLoadStatus"></a>

```kotlin
enum class MusicLoadStatus(val value: Int) {
    COMPLETED(0),
    FAILED(1),
    INPROGRESS(2),
}
```

歌曲加载的状态：

- `COMPLETED`: (0) 加载成功。
- `FAILED`: (1) 加载失败。
- `INPROGRESS`: (2) 正在加载中。

### KTVType

<a name="KTVType"></a>

```kotlin
enum class KTVType(val value: Int)  {
    Normal(0),
    SingBattle(1)
}
```

K 歌的场景：

- `Normal`：(0) 独唱、合唱场景。
- `SingBattle`：(1) 抢唱场景。


## Data class

<a name="KTVApiConfig"></a>

### KTVApiConfig

```kotlin
data class KTVApiConfig(
    val appId: String,
    val rtmToken: String,
    val engine: RtcEngine,
    val channelName: String,
    val localUid: Int,
    val chorusChannelName: String,
    val chorusChannelToken: String,
	  val maxCacheSize: Int = 10,
    val type: KTVType = KTVType.Normal
)
```

K 歌配置：

- `appId`：你的项目的 App ID。

- `rtmToken`：RTM Token，用于音乐内容中心鉴权。

  <div class="alert info">你可以获取临时 RTM Token 用于测试，但在正式生产环境中，你需要自己部署一个 RTM Token 服务器来生成、更新 Token，详见<a href="https://docportal.shengwang.cn/cn/Real-time-Messaging/token_upgrade_rtm#参考">使用 RTM Token 鉴权</a>。</div>

- `engine`：[`RtcEngine`](https://docportal.shengwang.cn/cn/online-ktv/API%20Reference/java_ng/API/rtc_interface_class.html#class_irtcengine) 对象。

- `channelName`：频道名。

- `localUid`：本地用户的 ID。频道内的每个用户 ID 都必须是唯一，需是 32 位无符号整数，建议取值范围为 [1,2<sup>32</sup>-1]。

- `chorusChannelName`: 在合唱场景下，领唱需要加入两个频道，频道 1 用户发布人声和播放器的混流，加入频道 2 发布麦克风采集的音频流，伴唱需要加入频道 2 来同步领唱的人声。在独唱场景下，该参数可以为空。

- `chorusChannelToken`：根据频道 2 的名称和用户 ID 生成的 Token，用于加入频道 2 时进行鉴权。在独唱场景下，该参数可以为空。

- `maxCacheSize`：可缓存的音乐资源数量，最多不能超过 50。

- `type`：K 歌场景，详见 [KTVType](#KTVType)。

### KTVLoadMusicConfiguration

<a name="KTVLoadMusicConfiguration"></a>

```kotlin
data class KTVLoadMusicConfiguration(
    val autoPlay: Boolean = false,
    val mainSingerUid: Int,
    val mode: KTVLoadMusicMode = KTVLoadMusicMode.LOAD_MUSIC_AND_LRC
)
```

歌曲加载设置：

- `autoPlay`：歌曲加载完成后是否自动播放：
  - `true`：自动播放。通常用户角色为独唱者时，推荐设为该值；用户角色为听众时，请勿设为该值。
  - `false`：（默认）不自动播放。
- `mainSingerUid`：独唱者的用户 ID。
- `mode`：歌曲加载的模式，详见 [KTVLoadMusicMode](#KTVLoadMusicMode)。