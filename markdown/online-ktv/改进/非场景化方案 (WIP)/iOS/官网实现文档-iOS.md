本文介绍如何通过声网音频 SDK 在你的 iOS 项目里实现在线 K 歌房的主要功能。

<div class="alert note">如果你想简化集成步骤，请参考<a href="/cn/online-ktv/ktv_integration_ios?platform=iOS">场景化 API 解决方案</a>。</div>

## 技术原理

在线 K 歌房内用户角色说明如下：

| 角色     | 描述                                                         |
| :------- | :----------------------------------------------------------- |
| 房主     | 歌房创建者。可以收、发音频流。                               |
| 连麦主播 | 进入歌房后，通过上麦成为连麦主播，可以收、发音频流。         |
| 主唱     | 连麦主播点歌后进行排麦演唱，正在演唱者成为主唱，可以收、发音频流。 |
| 合唱者   | 主唱发起合唱后，连麦主播接受邀请，成为合唱者，可以收、发音频流。 |
| 听众     | 进入歌房的倾听者，只能接收音频流。                           |

实现在线 K 歌房场景中不同角色流程如下：

### 房主实现流程

1. 房主通过第三方云服务发起指令创建歌房，创建成功后调用 `joinChannelByToken`方法加入歌房。
   - 加入歌房前，调用 `sharedEngineWithConfig` 方法创建并初始化 `AgoraRtcEngineKit` 实例，并将实例的音频场景设置为合唱（`AgoraAudioScenarioChorus`）。
   - 调用 `setClientRole` 方法将用户角色设置为主播（ `AgoraClientRoleBroadcaster`）。
2. 房主自动上麦成为连麦主播，可以点歌成为主唱，并邀请其他连麦主播进行合唱；也可以接受主唱的邀请，成为合唱者。
3. 房主可以通过第三方云服务对连麦主播发起下麦指令，同时房间内所有用户会收到该连麦主播的下麦信息并更新房间内麦位信息。
4. 房主离开歌房后，房间对象自动销毁，其他成员自动离开歌房。

### 主唱实现流程

参考下图实现在线 K 歌房场景的主唱端流程：

![](https://web-cdn.agora.io/docs-files/1652095268172)

1. 用户选择歌房，调用 `joinChannelByToken` 方法加入歌房。
   加入歌房前，调用 `sharedEngineWithConfig` 方法创建并初始化 `AgoraRtcEngineKit` 实例，并将实例的音频场景设置为合唱（`AgoraAudioScenarioChorus`）。
2. 用户通过第三方云服务发起上麦指令，并调用 `setClientRole` 方法将用户角色设置为主播（ `AgoraClientRoleBroadcaster`）。上麦后成为连麦主播，此时可以与房间内其他连麦主播进行语音互动。同时房间内所有用户收到主播端的上麦信息并更新房间内麦位信息。
3. 用户可以点歌，从[声网内容中心](https://docs.agora.io/cn/online-ktv/ktv_song_rest?platform=All%20Platforms)获取歌单，并下载歌曲文件和歌词文件，成为主唱。
4. 主唱可以独唱，也可以发起合唱邀请指令，邀请房间内其他连麦主播一起合唱歌曲。
5. 主唱调用 `AgoraRtcMediaPlayerProtocol` 类的方法播放歌曲，并伴随歌曲唱歌。如需切换原唱或伴奏模式，可以调用 `setAudioDualMonoMode` 方法。同时，主唱调用 `joinChannelExByToken` 方法，实现合唱。
6. 主唱在唱歌的同时，调用 `sendStreamMessage` 方法获将当前歌曲播放进度同步到房间内所有用户。合唱者和听众可以结合歌词组件实现歌词同步显示，并自定义歌词界面，详见[歌词组件教程](https://docs.agora.io/cn/online-ktv/ktv_lrcview_ios?platform=iOS)。
7. 主唱通过第三方云服务发起下麦指令，并调用 `leaveChannel` 方法离开歌房。

### 合唱者实现流程

![](https://web-cdn.agora.io/docs-files/1652095336541)

1. 用户选择歌房，调用 `joinChannelByToken` 方法加入歌房。
   加入歌房前，调用 `sharedEngineWithConfig` 方法创建并初始化 `AgoraRtcEngineKit` 实例，并将实例的音频场景设置为合唱（`AgoraAudioScenarioChorus`）。
2. 用户通过第三方云服务发起上麦指令，并调用 `setClientRole` 方法将用户角色设置为主播（ `AgoraClientRoleBroadcaster`）。上麦后成为连麦主播，此时可以与房间内其他连麦主播进行语音互动。同时房间内所有用户收到主播端的上麦信息并更新房间内麦位信息。
3. 主唱点歌并发出合唱邀请指令后，连麦主播可以接受主唱的邀请，并下载歌曲文件和歌词文件，成为合唱者。
4. 合唱者调用 `AgoraRtcMediaPlayerProtocol` 类的方法播放本地歌曲，并伴随歌曲与主唱一起唱歌，并调用 `muteRemoteAudioStream` 方法静音主唱的歌曲。
5. 合唱者通过 `receiveStreamMessageFromUid` 回调接收主唱发送的数据流，实现歌曲同步。同时结合歌词组件实现歌词同步显示，并自定义歌词界面，详见[歌词组件教程](https://docs.agora.io/cn/online-ktv/ktv_lrcview_ios?platform=iOS)。
6. 合唱者通过第三方云服务发起下麦指令，并调用 `leaveChannel` 方法离开歌房。

### 听众实现流程

1. 用户选择歌房，调用 `joinChannelByToken` 方法加入歌房。
 - 加入歌房前，调用 `sharedEngineWithConfig` 方法创建并初始化 `AgoraRtcEngineKit` 实例，并将实例的音频场景设置为合唱（`AgoraAudioScenarioChorus`）。
 - 调用 `setClientRole` 方法将用户角色设置为听众（ `AgoraClientRoleAudience`）。

1. 主播上麦成为主唱后，听众通过第三方云服务同步房间内麦位信息。

2. 主唱发起指令设置当前歌曲 ID，听众接收主唱指令并更新当前歌曲 ID。主唱唱歌时，听众接收主唱的音频流。

   听众如需上麦，需要再次调用 `setClientRole` 方法将用户角色设为 `AgoraClientRoleBroadcaster`，才可以在房间内发布音频流。

3. 听众通过第三方云服务发起获取当前歌词指令，并下载歌词。同时结合 `receiveStreamMessageFromUid` 回调和歌词组件，实时同步歌词进度。

4. 听众调用 `leaveChannel` 方法离开歌房。

## 前提条件

开始前，请确保你的开发环境满足以下条件：

- Xcode 12.0 或以上版本。
- 已安装 [Cocoapods](https://guides.cocoapods.org/using/getting-started.html#getting-started)。
- iOS 11.0 或以上版本的设备。部分模拟机可能无法支持本项目的全部功能，所以推荐使用真机。
- [Python](https://www.python.org/) 3.X。
- 第三方云服务[命令行工具](https://leancloud.cn/docs/leanengine_cli.html)。
- 有效的声网[开发者账号](https://docs.agora.io/cn/AgoraPlatform/sign_in_and_sign_up)。
- 有效的声网项目，获取项目的 App ID 以及一个 RTM Token。详情请参考[使用 RTM Token 鉴权](https://docs.agora.io/cn/Real-time-Messaging/token_upgrade_rtm#参考)。
<div class="alert info">在线 K 歌房仅使用 RTM Token 进行鉴权，不会产生云信令服务费用。</div>
- 如果你的网络环境部署了防火墙，请参考[应用企业防火墙限制](https://docs.agora.io/cn/AgoraPlatform/firewall?platform=iOS)以正常使用声网服务。

## 项目配置

根据下表提供的链接，下载对应平台的 SDK 并集成到你的项目中，并[开通内容中心服务](https://docs.agora.io/cn/online-ktv/ktv_song_rest?platform=All%20Platforms#开通服务)。

| 产品              | SDK 下载                                                     | 集成文档                                                     |
| :---------------- | :----------------------------------------------------------- | :----------------------------------------------------------- |
| 声网音频 SDK v4.x | [声网音频 SDK v4.x](https://docs.agora.io/cn/voice-call-4.x/downloads?platform=iOS) | [实现音频通话](https://docs.agora.io/cn/voice-call-4.x/start_call_audio_ios_ng?platform=iOS) |
| 第三方云服务      | [第三方云服务 SDK](https://leancloud.cn/docs/sdk_down.html)  | [SDK 安装指南](https://leancloud.cn/docs/start.html)<div class="alert note"> 你可以联系声网技术支持获取第三方云服务测试环境，或自行集成第三方云服务。</div> |
| 声网歌词组件      | [源码](https://github.com/AgoraIO-Community/LrcView-iOS)     | [歌词组件教程](https://docs.agora.io/cn/online-ktv/ktv_lrcview_ios?platform=iOS) |

## 实现在线 K 歌

参考如下 API 时序图实现在线 K 歌房场景，同时你可以[提交工单](https://docs.agora.io/cn/Agora%20Platform/ticket?platform=All%20Platforms)获取示例项目。

**创建和加入歌房**

![](https://web-cdn.agora.io/docs-files/1675651409380)


**实时独唱**

![](https://web-cdn.agora.io/docs-files/1675651442442)

**实时合唱**

![](https://web-cdn.agora.io/docs-files/1675651462123)


### 初始设置

加入歌房前，调用以下方法进行初始设置：

| API                      | 实现功能                                                     |
| :----------------------- | :----------------------------------------------------------- |
| `sharedEngineWithConfig` | 调用其他 API 之前，需要调用该方法创建并初始化 `AgoraRtcEngineKit`，并将 `AgoraRtcEngineConfig` 中的 `audioScenario` 设置为 `AgoraAudioScenarioChorus(7)`。 |

示例代码如下：

```objective-c
// Objective-C
AgoraRtcEngineConfig *config = [AgoraRtcEngineConfig new];
config.appId = appId;
config.audioScenario = AgoraAudioScenarioChorus;
config.channelProfile = AgoraChannelProfileLiveBroadcasting;
AgoraRtcEngineKit *rtcEngine = [AgoraRtcEngineKit sharedEngineWithConfig:config delegate:self];
```


```swift
// Swift
let config = AgoraRtcEngineConfig();
config.appId = BuildConfig.AppId
config.audioScenario = .chorus
config.channelProfile = .liveBroadcasting
rtcEngine = AgoraRtcEngineKit.sharedEngine(with: config, delegate: self)
```

### 加入/离开歌房

调用以下方法加入或离开歌房：

| API                               | 实现功能                                                     |
| :-------------------------------- | :----------------------------------------------------------- |
| `joinChannelByToken`              | 加入歌房。用户加入歌房后才能接收或发布音频流。               |
| `updateChannelWithMediaOptions`   | 加入歌房后更新媒体选项。                                     |
| `leaveChannel`                    | 离开歌房。房主离开歌房后，房间对象自动销毁，其他成员会自动离开歌房。 |
| `joinChannelExByToken`            | 合唱场景下，主唱需要调用 `joinChannelByToken` 发布麦克风采集的音频流，调用 `joinChannelExByToken` 发布播放器的音频流。两次调用必须设置不同的 `uid`。 |
| `updateChannelExWithMediaOptions` | 合唱场景下，主唱加入另一个频道后更新媒体选项。               |
| `leaveChannelEx`                  | 合唱场景下，主唱停止合唱后离开频道。                         |

独唱场景下，主唱发布播放器音频流和麦克风采集音频流，示例代码如下：

```objective-c
// Objective-C
id<AgoraRtcMediaPlayerProtocol> rtcMediaPlayer = [rtcEngine createMediaPlayerWithDelegate:self];
AgoraRtcChannelMediaOptions *option = [AgoraRtcChannelMediaOptions new];
option.publishMicrophoneTrack = YES;
option.publishMediaPlayerAudioTrack = YES;
option.enableAudioRecordingOrPlayout = YES;
option.publishMediaPlayerId = [rtcMediaPlayer getMediaPlayerId];
NSInteger ret = [rtcEngine joinChannelByToken:nil channelId:channelId uid:uid mediaOptions:option joinSuccess:nil];
```

```swift
// Swift
rtcMediaPlayer = rtcEngine.createMediaPlayer(with: self)
let option = AgoraRtcChannelMediaOptions()
option.publishMicrophoneTrack = .of(true)
option.publishMediaPlayerAudioTrack = .of(true)
option.enableAudioRecordingOrPlayout = .of(true)
option.publishMediaPlayerId = rtcMediaPlayer.getMediaPlayerId()
let ret = rtcEngine.joinChannel(byToken: nil, channelId: channelId, uid: uid, mediaOptions: option)
```

合唱场景下，主唱调用 `joinChannelExByToken` 发布另一路音频流，示例代码如下：

```objective-c
// Objective-C
id<AgoraRtcMediaPlayerProtocol> rtcMediaPlayer = [rtcEngine createMediaPlayerWithDelegate:self];
AgoraRtcChannelMediaOptions *option = [AgoraRtcChannelMediaOptions new];
option.autoSubscribeAudio = NO;
option.autoSubscribeVideo = NO;
option.publishMicrophoneTrack = NO;
option.publishMediaPlayerId = [rtcMediaPlayer getMediaPlayerId];
/// 发布播放器音频流
option.publishMediaPlayerAudioTrack = YES;
option.enableAudioRecordingOrPlayout = NO;
AgoraRtcConnection *connection = [AgoraRtcConnection new];
connection.channelId = @"";
connection.localUid = 0;

NSInteger ret = [rtcEngine joinChannelExByToken:@"" connection:connection delegate:self mediaOptions:option joinSuccess:nil];
```

```swift
// Swift
rtcMediaPlayer = rtcEngine.createMediaPlayer(with: self)
rtcMediaPlayer.open(url, 0);
let option = AgoraRtcChannelMediaOptions()
option.autoSubscribeAudio = AgoraRtcBoolOptional.of(false)
option.autoSubscribeVideo = AgoraRtcBoolOptional.of(false)
option.publishMicrophoneTrack = .of(false)
option.publishMediaPlayerId = rtcMediaPlayer.getMediaPlayerId();
// 发布播放器音频流
option.publishMediaPlayerAudioTrack = .of(true)
option.enableAudioRecordingOrPlayout = .of(false)
let connection = AgoraRtcConnection()
connection.channelId = ""
connection.localUid = 0

int ret = rtcEngine?.joinChannelEx(byToken: nil, connection: connection, delegate: self, mediaOptions: mediaOption, joinSuccess: nil)
```

### 上麦/下麦

调用以下方法进行上麦或下麦：

| API             | 实现功能                                                     |
| :-------------- | :----------------------------------------------------------- |
| `setClientRole` | 设置用户角色。<br>加入歌房时，需要将主唱的用户角色设为 `AgoraClientRoleBroadcaster`、听众的用户角色设为 `AgoraClientRoleAudience`。听众成功上麦后，需要先调用该方法将用户角色切换为 `AgoraClientRoleBroadcaster`，才能在房间里发布音频流。 |

### 音频相关

主唱调用以下方法设置音频流：

| API                           | 实现功能                       |
| :---------------------------- | :----------------------------- |
| `setAudioProfile` [2/2]       | 设置音频编码属性。             |
| `muteLocalAudioStream`        | 主唱可以关闭或开启本地麦克风。 |
| `adjustRecordingSignalVolume` | 调节人声音量。                 |


### 播放器相关

参考以下示例代码使用音乐播放器播放音乐资源。

1. 注册曲库并初始化 `AgoraMusicContentCenter`。

```objective-c
// Objective-C
AgoraMusicContentCenterConfig *config = [AgoraMusicContentCenterConfig new];
// 填入已开启音乐内容中心项目的 App ID
config.appId = xxx
// 用户 ID，该 ID 可以和你加入 RTC 频道时使用的 uid 一致，但不能为 0。
config.mccUid = xxx
// 填入用于鉴权的 Token。
config.token = xxx
// AgoraRtcEngineKit 实例。
config.rtcEngine = xxx
AgoraMusicContentCenter *amcc = [AgoraMusicContentCenter sharedContentCenterWithConfig:config];
```

```swift
// Swift
let config = AgoraMusicContentCenterConfig()
// 填入已开启音乐内容中心项目的 App ID
config.appId = xxx
// 用户 ID，该 ID 可以和你加入 RTC 频道时使用的 uid 一致，但不能为 0。
config.mccUid = xxx
// 填入用于鉴权的 Token。
config.token = xxx
// AgoraRtcEngineKit 实例。
config.rtcEngine = xxx
amcc = AgoraMusicContentCenter.sharedContentCenter(with: config)
```

2. 创建音乐播放器。如果你需要播放音乐内容中心的音乐资源，需要使用此播放器进行播放。

```objective-c
// Objective-C
id<AgoraMusicPlayerProtocol> musicPlayer = [amcc createMusicPlayerWithDelegate:self];
```

```swift
// Swift
musicPlayer = amcc.createMusicPlayer(with:sdkEvent as! AgoraRtcMediaPlayerDelegate)
```

3. 获取音乐榜单列表或搜索音乐资源。

你可以通过以下 API 来获取音乐资源：
-  `getMusicCharts`：获取曲库中全部的音乐榜单。
-   `getMusicCollectionWithMusicChartId`：通过音乐榜单的 ID 获取指定榜单的音乐资源列表。
-  `searchMusicWithKeyWord`：通过关键词搜索并获取音乐资源。

```objective-c
// Objective-C
[amcc getMusicCharts];
[amcc getMusicCollectionWithMusicChartId:musicChartId page:page pageSize:pageSize jsonOption: jsonOption];
[amcc searchMusicWithKeyWord:keyword page:page pageSize:pageSize jsonOption:nil];
```

```swift
// Swift
amcc.getMusicCharts()
amcc.getMusicCollection(musicChartId: musicChartId, page: page, pageSize: pageSize, jsonOption: jsonOption)
amcc.searchMusic(with:keyword, page:page, pageSize:pageSize, jsonOption:jsonOption)
```

你还可以通过 [searchMusicWithKeyWord]() 和 [getMusicCollectionWithMusicChartId]() 中的 `jsonOption` 字段来筛选有副歌片段、支持打分的音乐资源。`jsonOption` 字段的具体说明见对应方法的 API 文档。

筛选支持打分的音乐资源：

```swift
amcc.searchMusic(keyWord: "千里之外", page: 1, pageSize: 50, jsonOption: "{\"pitchType\":1}")
amcc.getMusicCollection(musicChartId: 3, page: 1, pageSize: 10, jsonOption: "{\"pitchType\":1}")
```

筛选有副歌片段的音乐资源：

```swift
amcc.searchMusic(keyWord: "千里之外", page: 1, pageSize: 50, jsonOption: "{\"needHighPart\":true}")
amcc.getMusicCollection(musicChartId: 3, page: 1, pageSize: 10, jsonOption: "{\"needHighPart\":true}")
```

4. 预加载音乐资源。

调用 `preloadWithSongCode` 方法来预加载需要播放的音乐资源。你可以调用 `isPreloadedWithSongCode` 方法来检测音乐资源是否已被预加载，该方法可同步调用且不包含耗时操作。

<div class="alert info">在播放音乐资源之前，请确保你已收到 <code>onPreLoadEvent</code> 回调报告音乐资源加载完成。</div>

```objective-c
// Objective-C
[amcc preloadWithSongCode:songCode jsonOption:nil];
[amcc isPreloadedWithSongCode:songCode];
```

```swift
// Swift
amcc.preload(songCode: songCode, jsonOption: nil)
amcc.isPreloaded(songCode: songCode)
```

如果你需要预加载的是某一音乐资源独立的副歌片段，在预加载之前你还需要调用 [getInternalSongCode](#link) 来获取该片段的资源编号（`internalSongCode`）。

```swift
// 获取副歌片段的资源编号，详细参数解释请参考该方法的 API 文档。
songCode = amcc.getInternalSongCode(songCode: songCode, jsonOption: "{\"format\":{\"highpart\":0}}")
// 将获取到的副歌片段资源编号传入 songCode 参数来预加载该片段。
let requestId = amcc.preload(songCode: songCode)
```

<div class="alert note">在调用相应方法打开、移除副歌片段时，请将该片段的资源编号传入相应方法中的 <code>songCode</code> 参数。</div>

5. 打开音乐资源。

调用 `openMediaWithSongCode` 方法打开音乐资源。

```objective-c
// Objective-C
[musicPlayer openMediaWithSongCode:songCode startPos:0];
```

```swift
// Swift
mPlayer.openMedia(withSongCode: songCode, startPos: startPos)
```

<div class="alert note">调用 <code>openMediaWithSongCode</code> 后，请确保收到 <code>didChangedToState</code> 回调报告状态为 <code>AgoraMediaPlayerStateOpenCompleted</code> 再调用 <code>play</code> 来进行播放。</div>

6. 销毁播放器及引擎。
当你无需再使用音乐播放器时，你需要：
a. 调用 `destroyMediaPlayer` 销毁音乐播放器；
b. 调用 `AgoraMusicContentCenter` 下的 `destroy` 销毁音乐内容中心对象；
c. 调用 `AgoraRtcEngineKit` 的 `destroy` 销毁引擎。

```objective-c
func destroy() {
    self.agoraKit?.destroyMediaPlayer(self.mpk)
    self.mpk = nil
 
    amcc?.register(nil)
    AgoraMusicContentCenter.destroy()
    self.amcc = nil
 
    AgoraRtcEngineKit.destroy()
    self.agoraKit = nil
 
}
```

你可以参考[版权音乐 API 文档](./API%20Reference/ios_ng/API/toc_drm.html)了解更多详细信息，音乐播放器的参数调节、推流设置、事件回调等请参考 [内置媒体播放器 API 文档](./API%20Reference/ios_ng/API/toc_mediaplayer.html)。

### 歌曲/歌词同步

| API                           | 实现功能                                                     |
| :---------------------------- | :----------------------------------------------------------- |
| `createDataStream` [2/2]      | 主唱创建数据流。用于同步歌曲播放进度。                       |
| `sendStreamMessage`           | 主唱发送数据流到歌房内所有用户。                             |
| `receiveStreamMessageFromUid` | 歌房内所有用户接收主唱发送的数据流，结合歌词组件实现歌词进度的同步更新。 |



示例代码如下：

```objective-c
// Objective-C
AgoraDataStreamConfig *config = [AgoraDataStreamConfig new];
config.ordered = NO;
config.syncWithAudio = NO;
NSInteger dataStreamId = -1;
int ret = [rtcEngine createDataStream:&dataStreamId config:config];
if (ret < 0) {
NSLog(@"createDataStream error");
}
ret = [rtcEngine sendStreamMessage:dataStreamId data:[NSData new]];
if (ret < 0) {
NSLog(@"sendStreamMessage error");
}
/// receiveStreamMessage in remote
- (void)rtcEngine:(AgoraRtcEngineKit * _Nonnull)engine receiveStreamMessageFromUid:(NSUInteger)uid streamId:(NSInteger)streamId data:(NSData * _Nonnull)data {
}
```

```swift
// Swift
let config = AgoraDataStreamConfig()
config.ordered = false
config.syncWithAudio = false
var ret = rtc.createDataStream(&dataStreamId, config: config)
if ret < 0 {
     print("createDataStream error")
}

let ret = rtcEngine.sendStreamMessage(streamId, data: jsonData)
if code < 0 {
    print("sendRtcStreamMessage error")
}

func rtcEngine(_: AgoraRtcEngineKit, receiveStreamMessageFromUid uid: UInt, streamId: Int, data: Data) {
}
```

### 原唱及伴奏切换

| 音乐资源类型                       | 切换原唱\伴奏方式                                            |
| :--------------------------------- | :----------------------------------------------------------- |
| 左声道伴奏、右声道原唱的单音轨歌曲 | <br>切换至原唱：调用 `setAudioDualMonoMode`，将 `mode` 设为 `AgoraAudioDualMonoR`(2)。<br>切换至伴奏：调用 `setAudioDualMonoMode`，将 `mode` 设为 `AgoraAudioDualMonoL`(1)。<br><div class="alert info">必须设置只播放左声道或右声道，否则会因为左、右声道音源不同导致音质变差。</div> |
|多音轨的歌曲（第一个音轨为原唱，第二个音轨为伴奏）    | <br>切换至原唱：调用 `selectAudioTrack` 将 `index` 设为 `0`。<br>切换至伴奏：调用 `selectAudioTrack` 将 `index` 设为 `1`。


## 参考信息

### 附加功能

#### 人声音效

调用 `setAudioEffectPreset` 方法，在不改变原声的性别特征的前提下，设置人声音效。设置音效后，频道内所有用户都能听到该效果。详见[设置人声效果](https://docs.agora.io/cn/voice-call-4.x/voice_changer_apple_ng?platform=iOS)。

#### 耳返

调用 `enableInEarMonitoring` [2/2] 方法开启主唱的耳返功能。

#### 歌唱评分

调用 `enableAudioVolumeIndication` 方法开启歌唱评分功能，并通过 `reportAudioVolumeIndicationOfSpeakers` 回调，结合声网歌词组件实现歌唱评分效果，详见[歌词打分组件](https://docportal.shengwang.cn/cn/online-ktv/ktv_karaoke_view_ios?platform=iOS)。


### 常见问题

[如何使用连麦鉴权功能？](https://docs.agora.io/cn/InteractiveBroadcast/faq/token_cohost)

### 相关文档

- [声网内容中心](https://docs.agora.io/cn/online-ktv/ktv_song_rest?platform=All%20Platforms)
- [歌词组件](https://docs.agora.io/cn/online-ktv/ktv_lrcview_ios?platform=iOS)
- [RTC API 参考](./API%20Reference/ios_ng/API/rtc_api_overview_ng.html)

