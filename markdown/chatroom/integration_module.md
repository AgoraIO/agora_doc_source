
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

## 耳返

对于耳返功能，延迟是一个最重要的指标。在 iOS 设备上，耳返延迟平均在 50ms 左右。而在 Android 设备上，由于手机生产厂家众多且机型众多，因此耳返延迟不尽相同，有的设备能达到 100ms 之内，而有的则在 200ms 至 300ms 之间。

针对 Android 设备，声网使用了自主开发的 Opensl 耳返算法，使得在某些设备上能将耳返延迟降至 50ms 以下，但在某些设备上，耳返延迟仍然在 200ms 至 300ms 之间。

使用声网 SDK 开启耳返：

iOS：

```objective-c
- (int)enableInEarMonitoring:(BOOL)enabled;
```

Android:

```java
public abstract int enableInEarMonitoring(boolean enabled, int includeAudioFilters);
```

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

## 声网 DRM 音乐

目前声网和音集协合作提供了数十万首热门歌曲，支持直播间 BGM 版权。我们建议您使用声网 SDK 中自带的 DRM 模块来使用声网版权音乐。具体步骤如下：

1. 联系声网服务人员，开通版权音乐使用权限。

2. 自己业务服务器通过 OpenAPI 向声网版权音乐服务获取歌曲信息，保存在自己的服务端。

3. 做一个客户端歌曲搜索与点歌页面。当用户点击某一首歌曲后，可以获得歌曲的 SongCode，然后通过声网 SDK 进行歌曲预加载和播放。

4. 如果需要歌词展示，声网 SDK 还可以直接通过 SongCode 获取具体的歌词文件地址，获取歌词后就可以展示。

5. 在歌曲播放时，需要使用声网 SDK 中的 MediaPlayerKit 播放器，通过 SongCode 播放。

注意：声网 DRM 版权音乐不仅能用于聊天室中的背景音乐，还可以用于 K 歌等应用。更多关于版权音乐的信息，请参考[声网歌曲内容中心](https://docs.agora.io/cn/online-ktv/ktv_song_rest?platform=All%20Platforms)。

## 第三方版权音乐（例如：AME）

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

## 录制 & 审核

录制可以通过云录制和本地录制来实现；语音审核可以通过第三方审核语音审核平台数美或依图等。对于录制而言，使用云录制简单方便，使用本地服务端录制业务复杂但费用较云录制便宜。

- 录制服务
  - [声网云录制](https://docs.agora.io/cn/cloud-recording/product_cloud_recording?platform=All%20Platforms)
  - [本地服务端录制](https://docs.agora.io/cn/Recording/product_recording?platform=Linux)
- 语音审核
  - [数美语音审核](https://docs.agora.io/cn/extension_customer/quickstart_shumei_moderation_audio?platform=All%20Platforms)
  - [依图语音审核](https://docs.agora.io/cn/extension_customer/quickstart_yitu_moderation_audio?platform=All%20Platforms)

## 防炸房

在语音聊天室中，炸房问题是场景化安全问题。所谓的炸房就是非法用户通过一定技术手段侵入语聊房内部恶意发言，干扰正常的聊天秩序，该现象也常被称为“鬼麦”或“炸麦”。解决炸房问题主要从两方面入手，一方面是发现捣乱者，另一方面是发现捣乱者后所做的处理。炸房相关的业务架构如下图所示。

![](https://docimg8.docs.qq.com/image/AgAACiNGFGOlBDNhfGBN-ZtFNraDxa1V.png?w=795&h=788)

对于炸房的处理一般从两个方面，一方面是发现捣乱者，另一方面是处理捣乱者。

### 发现捣乱者

一般而言，合法进入直播间的用户客户的业务服务器是有所记录的，发现非法用户的方式有如下几种：

1. 通过 SDK 的 onAudioVolumeIndication 回调，获知当前正在讲话人的 uid，然后和业务服务器记录的正常用户的 uid 做对比，判断其是否非法；
2. 通过频道管理服务的 /dev/v1/channel/user/property/{apid}/{uid}/{channelName} API 查询频道内当前在线用户列表，和业务服务器记录的正常用户做对比，找出非法用户；
3. 通过消息通知服务告知的上麦的用户 uid 和业务服务器记录的正常用户做对比，找出非法用户。

### 处理捣乱者

处理捣乱者有两种方式，一种是从源头上禁止捣乱者，另一种是让频道内的观众不接收捣乱者的语音。所以具体处理可以按照下面方式：

1. 发现捣乱者后，可以调用声网的频道管理 API 做出踢人处理；
2. 服务端通过 IM 消息告知频道内所有观众，禁止收听捣乱者的声音；

以上两种策略都依赖一个非常重要的工作——合法用户状态列表维护。用户进入频道、离开频道、上麦、下麦、禁麦等状态都要维护好，一旦和发用户状态列表维护的有问题，那么当炸房发生时也不知道捣乱的人是否是非法用户或合法用户处在异常状态。炸房问题处理详细文档请参考[炸房捣乱现象的预防和应对](https://docs.agora.io/cn/live-streaming-premium-legacy/prevent_stream_bombing?platform=Android)。