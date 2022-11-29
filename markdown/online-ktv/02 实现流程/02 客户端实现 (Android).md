本文介绍如何通过 Agora 音频 SDK v4.x 在你的 Android 项目里实现在线 K 歌房的主要功能。

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

1. 房主通过第三方云服务发起指令创建歌房，创建成功后调用 `joinChannel`方法加入歌房。
   - 加入歌房前，调用 `create [2/2]` 方法创建并初始化 `RtcEngine` 实例，并将实例的音频场景设置为合唱（`CHORUS`）。
   - 调用 `setClientRole` 方法将用户角色设置为主播（ `BROADCASTER`）。
2. 房主自动上麦成为连麦主播，可以点歌成为主唱，并邀请其他连麦主播进行合唱；也可以接受主唱的邀请，成为合唱者。
3. 房主可以通过第三方云服务对连麦主播发起下麦指令，同时房间内所有用户会收到该连麦主播的下麦信息并更新房间内麦位信息。
4. 房主离开歌房后，房间对象自动销毁，其他成员自动离开歌房。

### 主唱实现流程

参考下图实现在线 K 歌房场景的主唱端流程：

![](https://web-cdn.agora.io/docs-files/1652095268172)

1. 用户选择歌房，调用 `joinChannel` 方法加入歌房。
   加入歌房前，调用 `create [2/2]` 方法创建并初始化 `RtcEngine` 实例，并将实例的音频场景设置为合唱（`CHORUS`）。
2. 用户通过第三方云服务发起上麦指令，并调用 `setClientRole` 方法将用户角色设置为主播（ `BROADCASTER`）。上麦后成为连麦主播，此时可以与房间内其他连麦主播进行语音互动。同时房间内所有用户收到主播端的上麦信息并更新房间内麦位信息。
3. 用户可以点歌，从 [Agora 内容中心](https://docs.agora.io/cn/online-ktv/ktv_song_rest?platform=All%20Platforms)获取歌单，并下载歌曲文件和歌词文件，成为主唱。
4. 主唱可以独唱，也可以发起合唱邀请指令，邀请房间内其他连麦主播一起合唱歌曲。
5. 主唱调用 `IMediaPlayer` 类的方法播放歌曲，并伴随歌曲唱歌。如需切换原唱或伴奏模式，可以调用 `setAudioDualMonoMode` 方法。同时，主唱调用 `joinChannelEx` 方法，实现合唱。
6. 主唱在唱歌的同时，调用 `sendStreamMessage` 方法获将当前歌曲播放进度同步到房间内所有用户。合唱者和听众可以结合歌词组件实现歌词同步显示，并自定义歌词界面，详见[歌词组件教程](https://docs.agora.io/cn/online-ktv/ktv_lrcview_android?platform=Android)。
7. 主唱通过第三方云服务发起下麦指令，并调用 `leaveChannel` 方法离开歌房。

### 合唱者实现流程

![](https://web-cdn.agora.io/docs-files/1652095336541)

1. 用户选择歌房，调用 `joinChannel` 方法加入歌房。
   加入歌房前，调用 `create [2/2]` 方法创建并初始化 `RtcEngine` 实例，并将实例的音频场景设置为合唱（`CHORUS`）。
2. 用户通过第三方云服务发起上麦指令，并调用 `setClientRole` 方法将用户角色设置为主播（ `BROADCASTER`）。上麦后成为连麦主播，此时可以与房间内其他连麦主播进行语音互动。同时房间内所有用户收到主播端的上麦信息并更新房间内麦位信息。
3. 主唱点歌并发出合唱邀请指令后，连麦主播可以接受主唱的邀请，并下载歌曲文件和歌词文件，成为合唱者。
4. 合唱者调用 `IMediaPlayer` 类的方法播放本地歌曲，并伴随歌曲与主唱一起唱歌，并调用 `muteRemoteAudioStream` 方法静音主唱的歌曲。
5. 合唱者通过 `onStreamMessage` 回调接收主唱发送的数据流，实现歌曲同步。同时结合歌词组件实现歌词同步显示，并自定义歌词界面，详见[歌词组件教程](https://docs.agora.io/cn/online-ktv/ktv_lrcview_android?platform=Android)。
6. 合唱者通过第三方云服务发起下麦指令，并调用 `leaveChannel` 方法离开歌房。

### 听众实现流程

1. 用户选择歌房，调用 `joinChannel` 方法加入歌房。
 - 加入歌房前，调用 `create [2/2]` 方法创建并初始化 `RtcEngine` 实例，并将实例的音频场景设置为合唱（`CHORUS`）。
 - 调用 `setClientRole` 方法将用户角色设置为听众（ `AUDIENCE`）。

1. 主播上麦成为主唱后，听众通过第三方云服务同步房间内麦位信息。

2. 主唱发起指令设置当前歌曲 ID，听众接收主唱指令并更新当前歌曲 ID。主唱唱歌时，听众接收主唱的音频流。

   听众如需上麦，需要再次调用 `setClientRole` 方法将用户角色设为 `BROADCASTER`，才可以在房间内发布音频流。

3. 听众通过第三方云服务发起获取当前歌词指令，并下载歌词。同时结合 `onStreamMessage` 回调和歌词组件，实时同步歌词进度。

4. 听众调用 `leaveChannel` 方法离开歌房。

## 前提条件

开始前，请确保你的开发环境满足以下条件：

- Android Studio 4.0.0 或以上版本。
- Android 4.1 或以上版本的设备。Agora 推荐使用真机，部分模拟机可能无法支持本项目的全部功能。
- [Python](https://www.python.org/) 3.X。
- 第三方云服务[命令行工具](https://leancloud.cn/docs/leanengine_faq.html#hash-864044521)。
- 有效的 Agora [开发者账号](https://docs.agora.io/cn/AgoraPlatform/sign_in_and_sign_up)。
- 有效的 Agora 项目，获取项目的 App ID 以及一个 RTM Token。详情请参考[开始使用 Agora 平台](https://docs.agora.io/cn/Agora%20Platform/get_appid_token?platform=All%20Platforms)。
- 如果你的网络环境部署了防火墙，请参考[应用企业防火墙限制](https://docs.agora.io/cn/AgoraPlatform/firewall?platform=iOS)以正常使用 Agora 服务。

## 项目配置

根据下表提供的链接，下载对应平台的 SDK 并集成到你的项目中，并[开通内容中心服务](https://docs.agora.io/cn/online-ktv/ktv_song_rest?platform=All%20Platforms#开通服务)。

| 产品                                                         | SDK 下载                                                     | 集成文档                                                     |
| :----------------------------------------------------------- | :----------------------------------------------------------- | :----------------------------------------------------------- |
| Agora 音频 SDK v4.x | [Agora 音频 SDK v4.x ](https://docs.agora.io/cn/voice-call-4.x/downloads?platform=Android) | [实现音频通话](https://docs.agora.io/cn/voice-call-4.x/start_call_audio_android_ng?platform=Android) |
| 第三方云服务                        | [第三方云服务 SDK](https://leancloud.cn/docs/sdk_down.html)  | [SDK 安装指南](https://leancloud.cn/docs/start.html)<div class="alert note"> 你可以联系 Agora 技术支持获取第三方云服务测试环境，或自行集成第三方云服务。</div> |
| Agora 歌词组件 |[源码](https://github.com/AgoraIO-Community/LrcView-Android)                                                         | [歌词组件教程](https://docs.agora.io/cn/online-ktv/ktv_lrcview_android?platform=Android) |

## 实现在线 K 歌

参考如下 API 时序图实现在线 K 歌房场景，同时你可以[提交工单](https://agora-ticket.agora.io/)获取示例项目。

**创建和加入歌房**

![](https://web-cdn.agora.io/docs-files/1662706194762)

**实时独唱**
![](https://web-cdn.agora.io/docs-files/1662706208064)

**实时合唱**

![](https://web-cdn.agora.io/docs-files/1662706221913)

### 核心 API 参考

下表提供 Agora 音频 SDK v4.x 的核心 API 参考，与第三方云服务相关的功能需要自行实现。

#### 初始设置

加入歌房前，调用以下方法进行初始设置：

| API            | 实现功能                                                     |
| :------------- | :----------------------------------------------------------- |
| [`create [2/2]`](https://docs.agora.io/cn/voice-call-4.x/API%20Reference/java_ng/API/class_irtcengine.html#api_create2) | 调用其他 API 之前，需要调用该方法创建并初始化 `RtcEngine`，并将 [`RtcEngineConfig`](https://docs.agora.io/cn/video-call-4.x/API%20Reference/java_ng/API/rtc_api_data_type.html#class_rtcengineconfig_ng) 中的 `mAudioScenario` 设置为 `AUDIO_SCENARIO_CHORUS (7)`。 |

示例代码如下：

```java
RtcEngineConfig config = new RtcEngineConfig();
config.mContext = mContext;
config.mAppId = appid;
config.mEventHandler = mIRtcEngineEventHandler;
config.mChannelProfile = Constants.CHANNEL_PROFILE_LIVE_BROADCASTING;
config.mAudioScenario = Constants.AUDIO_SCENARIO_CHORUS;
mRtcEngine = RtcEngine.create(config);
```

#### 加入/离开歌房

调用以下方法加入或离开歌房：

| API                                                          | 实现功能                                                     |
| :----------------------------------------------------------- | :----------------------------------------------------------- |
| [`joinChannel`](https://docs.agora.io/cn/voice-call-4.x/API%20Reference/java_ng/API/class_irtcengine.html#api_joinchannel) | 加入歌房。用户加入歌房后才能接收或发布音频流。               |
| [`updateChannelMediaOptions`](https://docs.agora.io/cn/voice-call-4.x/API%20Reference/java_ng/API/class_irtcengine.html#api_updatechannelmediaoptions) | 加入歌房后更新媒体选项。                                     |
| [`leaveChannel`](https://docs.agora.io/cn/voice-call-4.x/API%20Reference/java_ng/API/class_irtcengine.html#api_leavechannel) | 离开歌房。房主离开歌房后，房间对象自动销毁，其他成员会自动离开歌房。 |
| [`joinChannelEx`](https://docs.agora.io/cn/voice-call-4.x/API%20Reference/java_ng/API/class_irtcengineex.html#api_irtcengineex_joinchannelex) | 合唱场景下，主唱需要调用 `joinChannel` 发布播放器音频流，调用 `joinChannelEx` 发布麦克风采集音频流。两次调用必须设置不同的 `uid`。 |
| [`updateChannelMediaOptionsEx`](https://docs.agora.io/cn/voice-call-4.x/API%20Reference/java_ng/API/class_irtcengineex.html#api_irtcengineex_updatechannelmediaoptionsex)     | 合唱场景下，主唱加入另一个频道后更新媒体选项。         |
| [`leaveChannelEx`](https://docs.agora.io/cn/voice-call-4.x/API%20Reference/java_ng/API/class_irtcengineex.html#api_irtcengineex_leavechannelex) | 合唱场景下，主唱停止合唱后离开频道。                         |

独唱场景下，主唱发布播放器音频流和麦克风采集音频流，示例代码如下：

```java
mediaPlayer = engine.createMediaPlayer();
mediaPlayer.registerPlayerObserver(this);
mediaPlayer.open(url, 0);
ChannelMediaOptions options = new ChannelMediaOptions();
options.autoSubscribeVideo = true;
options.autoSubscribeAudio = true;
options.publishScreenCaptureVideo = false;
options.publishCameraTrack = false;
// 发布麦克风采集音频流
options.publishMicrophoneTrack = true;
options.enableAudioRecordingOrPlayout = true;
options.publishMediaPlayerId = mediaPlayer.getMediaPlayerId();
// 发布播放器音频流
options.publishMediaPlayerAudioTrack = true;
engine.updateChannelMediaOptions(options);
```

合唱场景下，主唱调用 `joinChannelEx` 发布另一路音频流，示例代码如下：

```java
mediaPlayer = engine.createMediaPlayer();
mediaPlayer.registerPlayerObserver(this);
mediaPlayer.open(url, 0);
ChannelMediaOptions mediaOptions = new ChannelMediaOptions();
mediaOptions.autoSubscribeAudio = true;
mediaOptions.autoSubscribeVideo = true;
// 发布麦克风采集音频流
mediaOptions.publishMicrophoneTrack = true;
mediaOptions.publishCameraTrack = false;
mediaOptions.publishMediaPlayerId = mediaPlayer.getMediaPlayerId();
// 发布播放器音频流
mediaOptions.publishMediaPlayerAudioTrack = true;
options.enableAudioRecordingOrPlayout = false;
mediaOptions.clientRoleType = Constants.CLIENT_ROLE_BROADCASTER;
rtcConnection.channelId = channel2;
rtcConnection.localUid = channel2Uid;
int ret = engine.joinChannelEx(null, rtcConnection, mediaOptions, iRtcEngineEventHandler2);
```

#### 上麦/下麦

调用以下方法进行上麦或下麦：

| API                                                          | 实现功能                                                     |
| :----------------------------------------------------------- | :----------------------------------------------------------- |
| [`setClientRole`](https://docs.agora.io/cn/voice-call-4.x/API%20Reference/java_ng/API/class_irtcengine.html#api_setclientrole) | 设置用户角色。<br>加入歌房时，需要将主唱的用户角色设为 `BROADCASTER`、听众的用户角色设为 `AUDIENCE`。听众成功上麦后，需要先调用该方法将用户角色切换为 `BROADCASTER`，才能在房间里发布音频流。 |

#### 音频相关

主唱调用以下方法设置音频流：

| API                                                          | 实现功能                       |
| :----------------------------------------------------------- | :----------------------------- |
| [`setAudioProfile [2/2]`](https://docs.agora.io/cn/voice-call-4.x/API%20Reference/java_ng/API/class_irtcengine.html#api_setaudioprofile2) | 设置音频编码属性。             |
| [`muteLocalAudioStream`](https://docs.agora.io/cn/voice-call-4.x/API%20Reference/java_ng/API/class_irtcengine.html#api_mutelocalaudiostream) | 主唱可以关闭或开启本地麦克风。 |
| [`adjustRecordingSignalVolume`](https://docs.agora.io/cn/voice-call-4.x/API%20Reference/java_ng/API/class_irtcengine.html#api_adjustrecordingsignalvolume)                                | 调节人声音量。                 |

#### 播放器相关

参考以下示例代码使用音乐播放器播放音乐资源。

1. 注册曲库并获取 `IAgoraMusicContentCenter`。

 ```java
RtcEngine.loadExtensionProvider("agora_drm_loader_extension");
mcc = IAgoraMusicContentCenter.create(rtcEngine());
```

2. 初始化 `IAgoraMusicContentCenter`。

 ```java
AgoraMusicContentCenterConfiguration contentCenterConfiguration = new AgoraMusicContentCenterConfiguration();
//  已开启音乐内容中心项目的 App ID。
contentCenterConfiguration.appId = "填入你的 App ID";
// 使用音乐内容中心的用户 ID。该 ID 可以和你加入 RTC 频道时使用的 uid 一致，但不能为 0。
contentCenterConfiguration.mccUid = 填入当前使用音乐内容中心用户的 uid;
// 用于鉴权的 RTM Token。
contentCenterConfiguration.rtmToken = "xxxxxxxxxxxx";
// 创建 IAgoraMusicContentCenterEventHandler，用于 SDK 向客户端发送音乐内容中心事件通知。
contentCenterConfiguration.eventHandler = new IAgoraMusicContentCenterEventHandler();
// 初始化 IAgoraMusicContentCenter。
mcc.initialize(contentCenterConfiguration);
```

3. 创建音乐播放器。如果你需要播放音乐内容中心的音乐资源，需要使用此播放器进行播放。

 ```
musicPlayer = mcc.createMusicPlayer();
```

4. 获取音乐榜单列表或搜索音乐资源。

 你可以通过以下 API 来获取音乐资源：
 -  `getMusicCharts`：获取曲库中全部的音乐榜单。
 -   `getMusicCollectionByMusicChartId`：通过音乐榜单的 ID 获取指定榜单的音乐资源列表。
 -  `searchMusic` ：通过关键词搜索并获取音乐资源。

 ```java
mcc.getMusicCharts();
mcc.getMusicCollectionByMusicChartId(0,0,10);
mcc.searchMusic("hello",0,10);
```

5. 预加载音乐资源。

 调用 `preload` 方法来预加载需要播放的音乐资源。加载音乐资源之后，你可以调用 `isPreload` 方法来检测音乐资源是否已被预加载，该方法可同步调用且不包含耗时操作。</div>

 <div class="alert info">在播放音乐资源之前，请确保你已收到 `onPreLoadEvent` 回调报告音乐资源加载完成。</div>

 ```java
mcc.preload(songCode, null);
mcc.isPreload(songCode);
```

6. 打开音乐资源。

 调用 `open` 方法打开音乐资源。

 ```java
musicPlayer.open(songCode, 0);
```

 <div class="alert note">调用 <code>open</code> 后，请确保收到 <code>onPlayerStateChanged</code> 回调报告状态为 <code>PLAYER_STATE_OPEN_COMPLETED(2)</code> 再调用 <code>play</code> 来进行播放。</div>

| 音乐播放器核心 API                 | 实现功能                                       |
| :--------------------------------- | :--------------------------------------------- |
| `initialize`                       | 初始化 `IAgoraMusicContentCenter` 。           |
| `createMusicPlayer`                | 创建音乐播放器。                               |
| `getMusicCharts`                   | 获取全部的音乐榜单。                           |
| `getMusicCollectionByMusicChartId` | 通过音乐榜单的 ID 获取指定榜单的音乐资源列表。 |
| `searchMusic`                      | 搜索音乐资源。                                 |
| `preload`                          | 预加载音乐资源。                               |
| `isPreloaded`                      | 检测音乐资源是否已被预加载。                   |
| `getLyric`                         | 获取音乐资源的歌词下载地址。                   |
| `open`                             | 打开音乐资源。                                 |
| `onPreLoadEvent`                   | 报告预加载音乐资源的事件。                     |
| `onMusicCollectionResult`          | 音乐资源列表回调。                             |
| `onMusicChartsResult`              | 音乐榜单回调。                                 |
| `onLyricResult`                    | 歌词下载地址回调。                             |


你可以参考[音乐播放器 API 文档](https://docs.agora.io/cn/online-ktv/ktv_api_android?platform=Android)了解更多详细信息，音乐播放器的参数调节、推流设置、事件回调等请参考 [IMediaPlayer 类](https://docs.agora.io/cn/video-call-4.x/API%20Reference/java_ng/API/class_imediaplayer.html)。

#### 歌曲/歌词同步

| API                                                          | 实现功能                                                     |
| :----------------------------------------------------------- | :----------------------------------------------------------- |
| [`createDataStream [2/2]`](https://docs.agora.io/cn/voice-call-4.x/API%20Reference/java_ng/API/class_irtcengine.html#api_createdatastream) | 主唱创建数据流。用于同步歌曲播放进度。                       |
| [`sendStreamMessage`](https://docs.agora.io/cn/voice-call-4.x/API%20Reference/java_ng/API/class_irtcengine.html#api_sendstreammessage) | 主唱发送数据流到歌房内所有用户。                             |
| [`onStreamMessage`](https://docs.agora.io/cn/voice-call-4.x/API%20Reference/java_ng/API/class_irtcengineeventhandler.html#callback_onstreammessage) | 歌房内所有用户接收主唱发送的数据流，结合歌词控件实现歌词进度的同步更新。 |

示例代码如下：
	
```java
DataStreamConfig cfg = new DataStreamConfig();
cfg.syncWithAudio = true;
cfg.ordered = true;
mStreamId = getRtcEngine().createDataStream(cfg);
private void sendSyncLrc(String lrcId, long duration, long time) {
    Map<String, Object> msg = new HashMap<>();
    msg.put("cmd", "setLrcTime");
    msg.put("lrcId", lrcId);
    msg.put("duration", duration);
    msg.put("time", time);//ms
    JSONObject jsonMsg = new JSONObject(msg);
    int streamId = RoomManager.Instance(mContext).getStreamId();
    int ret = RoomManager.Instance(mContext).getRtcEngine().sendStreamMessage(streamId, jsonMsg.toString().getBytes());
    if (ret < 0) {
        mLogger.e("sendSyncLrc() sendStreamMessage called returned: ret = [%s]", ret);
    }
}
@Override
public void onStreamMessage(int uid, int streamId, byte[] data) {
    JSONObject jsonMsg;
        String strMsg = new String(data);
        jsonMsg = new JSONObject(strMsg);
        if (jsonMsg.getString("cmd").equals("setLrcTime")) {
            long position = jsonMsg.getLong("time");
            if (position == 0) {
                mHandler.obtainMessage(ACTION_ON_RECEIVED_PLAY, uid).sendToTarget();
            } else if (position == -1) {
                mHandler.obtainMessage(ACTION_ON_RECEIVED_PAUSE, uid).sendToTarget();
            } else {
                Bundle bundle = new Bundle();
                bundle.putInt("uid", uid);
                bundle.putLong("time", position);
                Message message = Message.obtain(mHandler, ACTION_ON_RECEIVED_SYNC_TIME);
                message.setData(bundle);
                message.sendToTarget();
            }
        }
}
```

## 参考信息

### 附加功能

#### 人声音效

调用 [`setAudioEffectPreset`](https://docs.agora.io/cn/live-streaming-premium-4.x/API%20Reference/java_ng/API/class_irtcengine.html?platform=Android#api_setaudioeffectpreset) 方法，在不改变原声的性别特征的前提下，设置人声音效。设置音效后，频道内所有用户都能听到该效果。详见[设置人声效果](https://docs.agora.io/cn/voice-call-4.x/voice_changer_android_ng?platform=Android)。

#### 耳返

调用 [`enableInEarMonitoring [2/2]`](https://docs.agora.io/cn/live-streaming-premium-4.x/API%20Reference/java_ng/API/class_irtcengine.html?platform=Android#api_enableinearmonitoring2) 方法开启主唱的耳返功能。

#### 歌唱评分

调用 [`enableAudioVolumeIndication`](https://docs.agora.io/cn/live-streaming-premium-4.x/API%20Reference/java_ng/API/class_irtcengine.html#api_enableaudiovolumeindication) 方法开启歌唱评分功能，并通过 [`onAudioVolumeIndication`](https://docs.agora.io/cn/live-streaming-premium-4.x/API%20Reference/java_ng/API/class_irtcengineeventhandler.html#callback_onaudiovolumeindication) 回调，结合 Agora 歌词组件实现歌唱评分效果，详见[评分功能教程](https://docs.agora.io/cn/online-ktv/ktv_score_android?platform=All%20Platforms)。

### 常见问题

[如何使用连麦鉴权功能？](https://docs.agora.io/cn/InteractiveBroadcast/faq/token_cohost)

### 相关文档

- [Agora 内容中心](https://docs.agora.io/cn/online-ktv/ktv_song_rest?platform=All%20Platforms)
- [歌词组件](https://docs.agora.io/cn/online-ktv/ktv_lrcview_android?platform=Android)