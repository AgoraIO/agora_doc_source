#TODO 内容如何整合到文档中
## 加入频道

![](https://docimg2.docs.qq.com/image/AgAACiNGFGNo4fwZxj9MHr8tjIYjJoJA.png?w=806&h=330)

示例代码(iOS)：

```objective-c
/// @brief 创建声网引擎
-(void)mInitAgoraEngine
{
    AgoraRtcEngineConfig *config = [[AgoraRtcEngineConfig alloc] init];
    // 传入 App ID。
    config.appId = @"";
    self.agoraKit = [AgoraRtcEngineKit sharedEngineWithConfig:config delegate:self];
}

// 加入频道
/// @brief 加入声网频道
/// @param mChannel 频道名
/// @param mToken 根据频道名、uid、过期时间 生成的Token
/// @param mUid 频道内用户id
- (void)mJoinAgoraChannelWith:(NSString *)mChannel token:(NSString *)mToken uid:(NSUInteger)mUid{
    [self.agoraKit enableAudio];
    [self.agoraKit setDefaultAudioRouteToSpeakerphone:YES];

    [self.agoraKit setAudioScenario:AgoraAudioScenarioGameStreaming];
    [self.agoraKit setAudioProfile:AgoraAudioProfileMusicHighQuality];

    AgoraRtcChannelMediaOptions *options = [AgoraRtcChannelMediaOptions new];
    options.channelProfile = AgoraChannelProfileLiveBroadcasting;  // 设置为直播模式
    options.publishCameraTrack = NO;
    options.publishMicrophoneTrack = YES;    // 发送麦克风声音
    options.publishCustomAudioTrack = NO;
    options.autoSubscribeAudio = YES;            // 订阅频道内其它人的声音
    options.autoSubscribeVideo = NO;
    options.clientRoleType = AgoraClientRoleBroadcaster;  // 设置角色位主播
    [self.agoraKit joinChannelByToken:mToken channelId:mChannel uid:mUid mediaOptions:options joinSuccess:nil];
}
```


示例代码(Android)：

```java
private void mInitAgoraEngine(){
    try {
        RtcEngineConfig cfg =  new RtcEngineConfig();
        cfg.mAppId = getString(R.string.agora_app_id);
        mRtcEngine = RtcEngine.create(getBaseContext(),getString(R.string.agora_app_id),mRtcEventHandler);
    }catch (Exception e){
        throw new RuntimeException("NEED TO check rtc sdk init fatal error\n"+ Log.getStackTraceString(e));
    }
}

private void mJoinAgoraChannel(String token,String channelName,int uid){
    this.mRtcEngine.enableAudio();
    this.mRtcEngine.setDefaultAudioRoutetoSpeakerphone(true);
    this.mRtcEngine.setAudioProfile(Constants.AUDIO_PROFILE_MUSIC_HIGH_QUALITY);
    this.mRtcEngine.setAudioScenario(Constants.AUDIO_SCENARIO_GAME_STREAMING);

    ChannelMediaOptions options = new ChannelMediaOptions();
    options.channelProfile = Constants.CHANNEL_PROFILE_LIVE_BROADCASTING;
    options.publishCameraTrack = false;
    options.publishMicrophoneTrack = true;
    options.publishCustomAudioTrack = false;
    options.autoSubscribeAudio = true;
    options.autoSubscribeVideo = false;
    options.clientRoleType = Constants.CLIENT_ROLE_BROADCASTER;
    this.mRtcEngine.joinChannel(token,channelName,uid,options);
}
```

## 观众上麦

![](https://docimg6.docs.qq.com/image/AgAACiNGFGN7J6C5ucpOoads4fGrLrBf.png?w=857&h=320)

示例代码(iOS)：

```objective-c
- (void)mChangeRoleToBroadcaster:(NSUInteger)mUid
{
    AgoraRtcChannelMediaOptions *options = [AgoraRtcChannelMediaOptions new];
    options.clientRoleType = AgoraClientRoleBroadcaster;
    options.publishMicrophoneTrack = YES;    // 发送自己的麦克风声音
    [self.agoraKit updateChannelWithMediaOptions:options];
}
```

示例代码(Android)：

```java
private void mChangeRoleToBroadcaster(int mUid){
    ChannelMediaOptions options = new ChannelMediaOptions();
    options.clientRoleType = Constants.CLIENT_ROLE_BROADCASTER;
    options.publishMicrophoneTrack = true;
    mRtcEngine.updateChannelMediaOptions(options);
}
```

## 主播下麦

![](https://docimg6.docs.qq.com/image/AgAACiNGFGME2yzjIStLvoNoTwDqTpWQ.png?w=846&h=304)

示例代码(iOS)：

```objective-c
- (void)mChangeRoleToAudience:(NSUInteger)mUid
{
    AgoraRtcChannelMediaOptions *options = [AgoraRtcChannelMediaOptions new];
    options.clientRoleType = AgoraClientRoleAudience;
    options.publishMicrophoneTrack = NO;    // 禁止发送自己的麦克风声音
    [self.agoraKit updateChannelWithMediaOptions:options];
}

```

示例代码(Android):

```java
private void mChangeRoleToAudience(int mUid){
    ChannelMediaOptions options = new ChannelMediaOptions();
    options.clientRoleType = Constants.CLIENT_ROLE_BROADCASTER;
    options.publishMicrophoneTrack = false;
    mRtcEngine.updateChannelMediaOptions(options);
}

```

## 麦位管理

麦位控制相关具体流程图如下。 

![](https://docimg2.docs.qq.com/image/AgAACiNGFGM2O24ZNfZBTLZYUANmTogk.png?w=528&h=776)

## 高音质设置

在娱乐交友房中，高音质是一个非常重要的特性。如果主播使用声卡，建议设置以下参数以实现高音质：

### 带声卡

```java
setAudioProfile(Constants.MUSIC_HIGH_QUALITY_STEREO)
setAudioScenario(Constants.AUDIO_SCENARIO_GAME_STREAMING)
setParameters("{\"che.audio.enable.aec\":false}");
setParameters("{\"che.audio.enable.ns\":false}");
setParameters("{\"che.audio.enable.agc\":false}");
setParameters("{\"che.audio.custom_payload_type\":78}");
setParameters("{\"che.audio.custom_bitrate\":128000}");
setRecordingDeviceVolume(128)
setParameters("{\"che.audio.input_channels\":2}");
```

### 不带声卡

```java
setAudioProfile(Constants.MUSIC_HIGH_QUALITY_STEREO)
setAudioScenario(Constants.AUDIO_SCENARIO_GAME_STREAMING)
setParameters("{\"che.audio.custom_bitrate\":128000}");
setParameters("{\"che.audio.custom_payload_type\":78}");
```

注意：上述配置适用于娱乐房场景的高音质设置。如果在其他场景中需要音质，可以联系声网服务人员进行咨询。

## 背景音乐 & 音效

在语音聊天室中，主播可以选择在线音乐播放，让音乐的声音和自己的声音混合在一起发送到聊天室中，让整个聊天室充满轻松欢快的气氛。

### 本地音乐文件或在线音乐文件

如果音乐文件是本地文件或在线音乐文件，播放方式有两种：

1. 使用 startAudioMixing 方法 [播放音效或音乐文件](https://docs.agora.io/cn/live-streaming-premium-4.x/API%20Reference/ios_ng/API/toc_audio_process.html#api_irtcengine_startaudiomixing)

```objective-c
- (int)startAudioMixing:(NSString *  _Nonnull)filePath
               loopback:(BOOL)loopback
                replace:(BOOL)replace
                  cycle:(NSInteger)cycle;
```

2. 使用 SDK 中带的 MediaPlayerKit 播放器播放，详情可以参考 [内置媒体播放器](https://docs.agora.io/cn/live-streaming-premium-4.x/API%20Reference/ios_ng/API/toc_mediaplayer.html)。

### 声网 DRM 音乐

目前声网和音集协合作提供了数十万首热门歌曲，支持直播间 BGM 版权。我们建议您使用声网 SDK 中自带的 DRM 模块来使用声网版权音乐。具体步骤如下：

1. 联系声网服务人员，开通版权音乐使用权限。

2. 自己业务服务器通过 OpenAPI 向声网版权音乐服务获取歌曲信息，保存在自己的服务端。

3. 做一个客户端歌曲搜索与点歌页面。当用户点击某一首歌曲后，可以获得歌曲的 SongCode，然后通过声网 SDK 进行歌曲预加载和播放。

4. 如果需要歌词展示，声网 SDK 还可以直接通过 SongCode 获取具体的歌词文件地址，获取歌词后就可以展示。

5. 在歌曲播放时，需要使用声网 SDK 中的 MediaPlayerKit 播放器，通过 SongCode 播放。

注意：声网 DRM 版权音乐不仅能用于聊天室中的背景音乐，还可以用于 K 歌等应用。更多关于版权音乐的信息，请参考[声网歌曲内容中心](https://docs.agora.io/cn/online-ktv/ktv_song_rest?platform=All%20Platforms)。

### 第三方版权音乐（例如：AME）

版权来源还可以来自第三方版权音乐服务商，例如 AME。一般第三方音乐服务商都会提供一个 SDK，用于音乐播放。

声网 SDK 可以很好地适配第三方版权音乐。具体流程如下（以 AME 为例）：

1. 歌曲搜索、点歌等逻辑都与 APP 业务逻辑及第三方版权音乐相关。

2. 用户确认歌曲后，只需要 AME SDK 对音乐进行解码，禁止声音播放。

3. 从 AME SDK 的音乐裸数据回调中，获取 PCM 裸数据，然后使用声网自采集相关 API 将其发送给声网 SDK，声网 SDK 内部自动将麦克风声音和 AME 音乐声音混合后发送到声网频道中。音频裸数据的使用请参考[声网自定义音频采集](https://docs.agora.io/cn/live-streaming-premium-4.x/custom_audio_src_apple_ng?platform=iOS)。

4. 声网 SDK 启用 localPlayback 模式，以使 AME 解码出来的 PCM 数据能够用声网 SDK 播放。

5. 总结来说就是：音频自采集 + localPlayback。

## 音量波纹提示

在语聊房中，房间内的观众一般需要知道谁在说话，通常是使用波纹提示。该功能可以直接使用声网 SDK 中的 [enableAudioVolumeIndication](https://docs.agora.io/cn/live-streaming-premium-4.x/API%20Reference/ios_ng/API/toc_audio_process.html#api_irtcengine_enableaudiovolumeindication) 方法启用音量提示功能，建议设置音量提示时间间隔为 500ms。

在 [onAudioVolumeIndication](https://docs.agora.io/cn/live-streaming-premium-4.x/API%20Reference/java_ng/API/toc_audio_process.html#callback_irtcengineeventhandler_onaudiovolumeindication) 回调中，包含本地和远端讲话者的音量信息，一般在 volume 值大于 20 的时候给到音量提示。
