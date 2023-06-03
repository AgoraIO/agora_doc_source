本文提供在线 K 歌房场景定制化 Objective-C API。你可以在 GitHub 上查看源码文件 [KTVApi.h](https://github.com/AgoraIO-Usecase/agora-ent-scenarios/blob/v2.1.1-ktv-iOS/iOS/AgoraEntScenarios/Scenes/KTV/ViewController/KTV/KTVApi.h) 和 [KTVApi.m](https://github.com/AgoraIO-Usecase/agora-ent-scenarios/blob/v2.1.1-ktv-iOS/iOS/AgoraEntScenarios/Scenes/KTV/ViewController/KTV/KTVApi.m)。

<div class="alert note">本文适用于场景化 API v2.1.1。</div>

## 方法

### initWithRtcEngine:channel:musicCenter:player:dataStreamId:delegate:

```objective-c
- (id)initWithRtcEngine:(AgoraRtcEngineKit *)engine
    channel:(NSString*)channelName
    musicCenter:(AgoraMusicContentCenter*)musicCenter
    player:(nonnull id<AgoraMusicPlayerProtocol>)rtcMediaPlayer
    dataStreamId:(NSInteger)streamId
    delegate:(id<KTVApiDelegate>)delegate;
```

初始化 KTVApi 模块。

调用该方法可以初始化 KTV API 模块内部变量和缓存数据，并注册相应的回调监听。

#### 注意事项

调用其他 KTV API 之前，你需要先调用本方法完成初始化。

#### 参数

- `engine`: [AgoraRtcEngineKit](https://docs.agora.io/cn/online-ktv/API%20Reference/ios_ng/API/rtc_interface_class.html#class_irtcengine)。
- `channel`: 待加入的频道名。
- `musicCenter`: 版权音乐内容中心实例。详见 [AgoraMusicContentCenter](https://docs.agora.io/cn/online-ktv/API%20Reference/ios_ng/API/rtc_interface_class.html#class_imusiccontentcenter)。
- `player`: 音乐播放器实例。详见 [AgoraMusicPlayerProtocol](https://docs.agora.io/cn/online-ktv/API%20Reference/ios_ng/API/rtc_interface_class.html#class_imusicplayer)。
- `dataStreamId`: 数据流（Data Stream）ID。
- `delegate`: [KTVApiDelegate](#controllersongdidchangedtostatelocal)。

#### 返回值

KTVApi 实例。


### loadSong:withConfig:withCallback:

```objective-c
- (void)loadSong:(NSInteger)songCode
withConfig:(nonnull KTVSongConfiguration *)config
withCallback:(void (^ _Nullable)(NSInteger songCode, NSString* lyricUrl, KTVSingRole role, KTVLoadSongState state))block
```

加载歌曲。

传入歌曲编号和 K 歌配置，调用 `loadSong` 加载歌曲。加载结果会异步地通过 `block` 回调通知你。

#### 参数

- `songCode`: 歌曲编号。
- `config`: K 歌配置。详见 [KTVSongConfiguration](#ktvsongconfiguration)。
- `block`: 歌词加载状态事件，包含如下参数：
    - `songCode`: 歌曲编号。
    - `lyricUrl`: 歌词文件的 URL。
    - `role`: 当前用户角色，详见 [KTVSingRole](#ktvsingrole)。
    - `state`: 歌曲加载状态，详见 [KTVLoadSongState](#ktvloadsongstate)。


### playSong:

```objective-c
- (void)playSong:(NSInteger)songCode
```

播放歌曲。

建议在调用 `loadSong` 函数并收到 `block` 回调的 `KTVLoadSongStateOK` 状态后再调用 `playSong`。

#### 参数

- `songCode`: 歌曲编号。

### stopSong

```objective-c
- (void)stopSong;
```

结束播放歌曲。

### resumePlay

```objective-c
- (void)resumePlay;
```

恢复播放歌曲。


### pausePlay

```objective-c
- (void)pausePlay;
```

暂停播放歌曲。

### seek:

```objective-c
- (void)seek:(time: NSInteger);
```

跳转到指定时间播放歌曲。

#### 参数

- `time`: 跳转的时间点。单位为毫秒。取值不得超过歌曲总时长。

### selectTrackMode:

```objective-c
- (void)selectTrackMode:(KTVPlayerTrackMode)mode;
```

选择播放的音轨。

歌曲的音轨包含原唱和伴奏。调用该方法可以选择播放的音轨。

#### 参数

- `mode`: 音轨的类型。详见 [KTVPlayerTrackMode](#ktvplayertrackmode)。

### setKaraokeView:

```objective-c
@property(nonatomic, weak) KaraokeView* karaokeView;

- (void)setKaraokeView:(KaraokeView *)karaokeView{
    _karaokeView = karaokeView;
    _karaokeView.delegate = self;
}
```

设置歌词控制视图。

歌词控制视图用于显示歌词和控制歌词滚动等操作。调用该方法后，可以将歌词控制视图和 KTV 模块进行绑定，从而实现歌词的同步滚动。

#### 参数

- `karaokeView`: 歌词控制视图，`KaraokeView` 对象。

## 回调

### controller:song:didChangedToState:local:

```objective-c
@protocol KTVApiDelegate <NSObject>
    - (void)controller:(KTVApi*)controller song:(NSInteger)songCode didChangedToState:(AgoraMediaPlayerState)state local:(BOOL)local;
@end
```
播放器状态改变回调。

#### 参数

- `controller`: KTVApi 实例。
- `songCode`: 歌曲编号。
- `state`: 播放器的当前状态。详见 [AgoraMediaPlayerState](https://docs.agora.io/cn/online-ktv/API%20Reference/ios_ng/API/enum_mediaplayerstate.html?platform=iOS)。
- `local`: 是否为本地事件：
    - `YES`: 代表是本地播放器的状态改变。可用于主唱和伴唱监听本地播放器状态。
    - `NO`: 是远端播放器的状态改变。可用于伴唱和听众知晓主唱的播放器状态，从而方便后续进行多端播放同步。

举例来说，在合唱场景下，主唱、伴唱、听众收到的 `didChangedToState` 回调有如下区别：

- 主唱：收到一个 `local` 为 `YES` 的回调，报告主唱播放器的状态改变。
- 伴唱：收到一个 `local` 为 `YES` 的回调，报告伴唱播放器的状态改变；同时，还收到一个 `local` 为 `NO` 的回调，报告主唱播放器的状态改变。
- 听众：收到一个 `local` 为 `NO` 的回调报告主唱端播放器的状态改变。


## Enum

### KTVSongType

```objective-c
typedef enum : NSUInteger {
    KTVSongTypeUnknown = 0,
    KTVSongTypeSolo,
    KTVSongTypeChorus
} KTVSongType;
```
K 歌场景类型：
- `KTVSongTypeUnknown`: 未知
- `KTVSongTypeSolo`: 独唱场景
- `KTVSongTypeChorus`: 合唱场景

### KTVSingRole

```objective-c
typedef enum : NSUInteger {
    KTVSingRoleUnknown = 0,
    KTVSingRoleMainSinger,
    KTVSingRoleCoSinger,
    KTVSingRoleAudience
} KTVSingRole;
```
K 歌用户角色类型：
- `KTVSingRoleUnknown`: 未知
- `KTVSingRoleMainSinger`: 主唱
- `KTVSingRoleCoSinger`: 伴唱
- `KTVSingRoleAudience`: 观众

### KTVPlayerTrackMode

```objective-c
typedef enum : NSUInteger {
    KTVPlayerTrackOrigin = 0,
    KTVPlayerTrackAcc = 1
} KTVPlayerTrackMode;
```

K 歌播放音轨类型：
- `KTVPlayerTrackOrigin`: 原唱
- `KTVPlayerTrackAcc`: 伴奏


### KTVLoadSongState

```objective-c
typedef enum : NSUInteger {
    KTVLoadSongStateIdle = 0,
    KTVLoadSongStateOK,
    KTVLoadSongStateInProgress,
    KTVLoadSongStateNoLyricUrl,
    KTVLoadSongStatePreloadFail,
} KTVLoadSongState;
```

歌曲加载的状态：
- `KTVLoadSongStateIdle`: 空闲状态，未加载歌曲
- `KTVLoadSongStateOK`: 加载成功
- `KTVLoadSongStateInProgress`: 正在加载中
- `KTVLoadSongStateNoLyricUrl`: 歌曲无法加载，缺少歌词地址
- `KTVLoadSongStatePreloadFail`: 加载失败

## Interface

### KTVSongConfiguration

```objective-c
@interface KTVSongConfiguration : NSObject
@property(nonatomic, assign)KTVSongType type;
@property(nonatomic, assign)KTVSingRole role;
@property(nonatomic, assign)NSInteger songCode;
@property(nonatomic, assign)NSInteger mainSingerUid;
@property(nonatomic, assign)NSInteger coSingerUid;
+(KTVSongConfiguration*)configWithSongCode:(NSInteger)songCode;
@end
```

K 歌配置：

- `type`: K 歌场景类型，详见 [KTVSongType](#ktvsongtype)
- `role`: K 歌用户角色类型，详见 [KTVSingRole](#ktvsingrole)
- `songCode`: 歌曲的编号
- `mainSingerUid`: 主唱的 UID
- `coSingerUid`: 伴唱的 UID

UID 指用户 ID，用于标识频道内的用户，频道内的每个 UID 都必须是唯一。UID 是 32 位无符号整数，建议取值范围为 [1,2<sup>32</sup>-1]。