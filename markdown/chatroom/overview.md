# 说明

本文档是一个语音聊天室解决方案的框架文档，目的就是让开发者通过一篇文档能清楚理解声网在语聊房场景中能提供哪些服务，确保开发者使用的是最佳方案，快速的让开发者真正体验到声网新进技术。 

# 场景介绍

## 场景描述

语音聊天室是指网络虚拟聊天房，主要是由主播和观众组成。房间是由用户(房主)创建，并设有麦位，房主可以邀请观众上麦进行语音互动直播。 同时，房间内有文字聊天弹幕，在语音聊天的同时可以根据弹幕增强与观众的互动。 

![](https://docimg2.docs.qq.com/image/AgAACiNGFGP2aryuALtNjqC6SoFO1lVC.png?imageMogr2/thumbnail/1600x%3E/ignore-error/1)![](https://docimg2.docs.qq.com/image/AgAACiNGFGPnEH7tGlRN5LHHElUFG9Wm.png?imageMogr2/thumbnail/1600x%3E/ignore-error/1)

(主播视角一张图、观众视角一张图，标注具体的功能模块)

一般语音聊天室内的角色有：

房主

创建此语音聊天室的用户，拥有整个房间的管理能力，具体包括：邀请人上&下麦、禁言、踢人等麦位管理权限，以及销毁房间。该用户能在房间内语音互动，是一个主播角色。

麦上嘉宾

观众进入语音聊天室后，通过自己申请上麦或者房主邀请上麦，跟房主和其他上麦的嘉宾可以进行语音聊天。 一般一个房间内会有多个麦位。

麦下观众

麦下观众只能在房间内倾听麦上嘉宾及房主聊天，一般一个用户进入一个房间后都默认是观众，可以接受房主的邀请成为麦上嘉宾。

老板位观众

房间内礼物打赏最多的观众会在老板位上一段时间，时间到后会空出来，是一个观众角色。 有的语音聊天室有设置老板位观众，有的则没有。

## 玩法模式

- 单人语音直播/FM语音电台：单人语音直播模式一般大多数是情感陪护房，话题多样。一般该场景中会同时播放背景音乐烘托气氛，麦下观众可以通过赠送礼物实现与主播之间的语音连麦。 

- K歌玩法：K歌玩法多样，具体有猜歌、抢唱、接唱等独唱玩法，还有多人合唱玩法。独唱一般是指在同一时刻只能有一个人在麦上唱歌其它人在房间内收听，当上个人唱完自动轮到下个人唱歌。多人合唱就是多人同时合唱一首歌，房间内其它人收听。 

- 一起看电影：在语音聊天室内，播放一个电影(也可以是赛事直播、综艺节目等)或者音乐，房间内的人一起观看讨论，能营造氛围活跃房间气氛。

- 游戏开黑房：在语聊应用中新建一个开黑房间，玩游戏时同一战队的好友进入这个房间进行语音交流。与当前世界最火爆的开黑工具Discord一样。

- 游戏派对房：在语音聊天室内玩狼人杀、剧本杀、真心话大冒险、你画我猜等，该场景一般是根据业务逻辑控制玩家的发言权限。 

- 大型重度游戏语音：类似王者荣耀、吃鸡等大型游戏语音场景，一般有大频道语音和小队语音，空间音频特性在该场景中也会被经常用到。

## 功能列表

主要功能

功能描述

多人实时语音

房间内麦上嘉宾之间实时语音互动(主播之间聊天)。

高音质

互动娱乐房间一般需要音频高音质。

伴奏音效

麦上主播可以播放伴奏音乐，或者房间内预设好的BGM音效。

耳返

麦上主播可以开启耳返实时监听自己的声音。

变声混响

麦上主播可以启用房间内预设的变声混响功能。

麦位管理

房主或者主持可以对房间诶的麦位进行管理，包括邀请观众上麦、下麦、禁麦等。

安全审核

对语音内容、文本消息、图片消息等做安全审核。

防炸房

防止非法用户进入虚拟房间内捣乱。

AI降噪

在某些嘈杂外部环境中，可以启用AI降噪让房间内的声音听的更清楚。

# 技术实现

## 方案架构

![](https://docimg6.docs.qq.com/image/AgAACiNGFGPqsnXYVn9PVaqJMEznJyDL.png?w=1172&h=782)

架构说明：

- 房主、麦上嘉宾通过AgoraSDK做语音互动，房间内观众通过AgoraSDK收听。 

- IM服务用来做一些麦位状态同步、文字以及礼物消息。

- 声网提供的服务端OpenAPI包含：消息通知服务、RestfulAPI服务、旁路推流服务。

  - 消息通知服务：需要开发者提供一个服务器地址来接收声网频道内消息通知，比如加入频道、角色变化(主播变观众、观众变主播)、离开频道等。当然，消息通知服务还包含其它的消息通知。

  - RestfulAPI服务：服务端api提供频道内用户信息查询以及解散房间和踢人操作等。

  - 旁路推流服务：通过服务端API可以把rtc频道内的音视频推流到CDN做音视频分发。

  - 还有其他相关服务，详情可查阅声网官网。

- APP业务服务器需要做的功能主要包含以下几点：

  - Token生成：加入声网频道时需要用到的一个秘钥，要按照声网规则生成。

  - 麦位管理：要维护合法用户的麦位信息。

  - 频道内用户信息查询，踢人相关等。

- 本地录制服务：使用声网linux sdk可以对频道内音视频做录制。这种方式相较于云录制成本更低。 

- 云录制：直接使用声网OpenAPI接口，配置好第三方云存储后，就可以发起云录制，把频道内的音视频存储到指定云存储中。

## 核心功能时序图

### 加入频道

![](https://docimg2.docs.qq.com/image/AgAACiNGFGNo4fwZxj9MHr8tjIYjJoJA.png?w=806&h=330)

示例代码(iOS)：

```
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

```
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

### 观众上麦

![](https://docimg6.docs.qq.com/image/AgAACiNGFGN7J6C5ucpOoads4fGrLrBf.png?w=857&h=320)

示例代码(iOS)：

```
- (void)mChangeRoleToBroadcaster:(NSUInteger)mUid
{
    AgoraRtcChannelMediaOptions *options = [AgoraRtcChannelMediaOptions new];
    options.clientRoleType = AgoraClientRoleBroadcaster;
    options.publishMicrophoneTrack = YES;    // 发送自己的麦克风声音
    [self.agoraKit updateChannelWithMediaOptions:options];
}
```

示例代码(Android)：

```
private void mChangeRoleToBroadcaster(int mUid){
    ChannelMediaOptions options = new ChannelMediaOptions();
    options.clientRoleType = Constants.CLIENT_ROLE_BROADCASTER;
    options.publishMicrophoneTrack = true;
    mRtcEngine.updateChannelMediaOptions(options);
}
```

### 主播下麦

![](https://docimg6.docs.qq.com/image/AgAACiNGFGME2yzjIStLvoNoTwDqTpWQ.png?w=846&h=304)

示例代码(iOS)：

```
- (void)mChangeRoleToAudience:(NSUInteger)mUid
{
    AgoraRtcChannelMediaOptions *options = [AgoraRtcChannelMediaOptions new];
    options.clientRoleType = AgoraClientRoleAudience;
    options.publishMicrophoneTrack = NO;    // 禁止发送自己的麦克风声音
    [self.agoraKit updateChannelWithMediaOptions:options];
}

```

示例代码(Android):

```
private void mChangeRoleToAudience(int mUid){
    ChannelMediaOptions options = new ChannelMediaOptions();
    options.clientRoleType = Constants.CLIENT_ROLE_BROADCASTER;
    options.publishMicrophoneTrack = false;
    mRtcEngine.updateChannelMediaOptions(options);
}

```

## 麦位控制 

麦位控制相关具体流程图如下。 

![](https://docimg2.docs.qq.com/image/AgAACiNGFGM2O24ZNfZBTLZYUANmTogk.png?w=528&h=776)

## 高音质设置

特别是娱乐交友房里面，高音质是非常重要的一个特性。 高音质实践里面如果主播使用声卡，建议设置以下参数，具体可以分成几类：

### 带声卡

```
setAudioProfile(Constants.MUSIC_HIGH_QUALITY_STEREO)
setAudioScenario(Constants.AUDIO_SCENARIO_GAME_STREAMING)
setParameters("{"che.audio.enable.aec":false}");
setParameters("{"che.audio.enable.ns":false}");
setParameters("{"che.audio.enable.agc":false}");
setParameters("{\"che.audio.custom_payload_type\":78}");
setParameters("{\"che.audio.custom_bitrate\":128000}");
setRecordingDeviceVolume(128)
setParameters("{\"che.audio.input_channels\":2}");

```

### 不带声卡

```
setAudioProfile(Constants.MUSIC_HIGH_QUALITY_STEREO)
setAudioScenario(Constants.AUDIO_SCENARIO_GAME_STREAMING)
setParameters("{\"che.audio.custom_bitrate\":128000}");
setParameters("{\"che.audio.custom_payload_type\":78}");
```

注意：上面配置是针对于娱乐房场景的高音质配置，如其他场景有音质需求，可以联系声网服务人员咨询。 

## 耳返

对于耳返功能，延迟是一个最重要的指标。iOS 耳返延迟平均在 50ms 左右；Android 设备由于手机生产厂家众多且机型众多，所以耳返延迟不一，有的设备能达到 100ms 之内，有的在 200ms~300ms 之间。

对于 Android 设备，声网使用了 Opensl 自研耳返算法，对于有的 Android 设备做到耳返延迟最低在 50ms 以内，而有的设备耳返延迟还是在200ms~ 300ms 左右。 

使用声网SDK开启耳返

iOS：

```
- (int)enableInEarMonitoring:(BOOL)enabled;
```

Android:

```
public abstract int enableInEarMonitoring(boolean enabled, int includeAudioFilters);
```

## 背景音乐&音效

在语音聊天室里面，主播都可以选择一个在线音乐播放，让音乐的声音和自己的声音混在一起发到聊天室里面，让整个聊天室充满轻松欢快的气氛。 

### 本地音乐文件或在线音乐文件

音乐文件如果是本地文件或者在线音乐文件，播放方式有两种。 

1.使用startAudioMixing方法 [播放音效或音乐文件](https://docs.agora.io/cn/live-streaming-premium-4.x/API%20Reference/ios_ng/API/toc_audio_process.html#api_irtcengine_startaudiomixing)

```
- (int)startAudioMixing:(NSString *  _Nonnull)filePath
               loopback:(BOOL)loopback
                replace:(BOOL)replace
                  cycle:(NSInteger)cycle;

```

2.使用SDK中带的MediaPlayerKit播放器播放，详情可以参考 [内置媒体播放器](https://docs.agora.io/cn/live-streaming-premium-4.x/API%20Reference/ios_ng/API/toc_mediaplayer.html)

### 声网DRM音乐

当前声网和音集协合作，有数十万首热门歌曲，支持直播间BGM版权，因此我们建议您采用声网SDK中自带的DRM模块来使用声网版权音乐。 具体步骤建议如下：

1.  联系声网服务人员，开通版权音乐使用权限。

2.  自己业务服务器通过OpenAPI向声网版权音乐服务获取歌曲信息，保存在自己服务端；

3.  做一个客户端歌曲搜索与点歌页面，当用户点击某一首歌曲后，可以拿到歌曲的SongCode，然后跟去SongCode通过声网SDK做歌曲预加载和播放；

4. 如果需要歌词展示，声网SDK还可以直接通过SongCode获取具体的歌词文件地址，获取歌词后就可以做歌词展示。 

5.  歌曲播放时，要使用声网SDK里面的MediaPlayerKit播放器，通过SongCode播放。 

注意：声网DRM版权音乐不仅仅能用户聊天室中的背景音乐，还可以用来做K歌，更多关于版权音乐相关请参考 [声网歌曲内容中心](https://docs.agora.io/cn/online-ktv/ktv_song_rest?platform=All%20Platforms)

### 第三方版权音乐(比如：AME)

版权来源还可以来自第三方版权音乐服务商，比如AME。 一般第三方音乐服务商都会提供一个SDK，通过SDK做音乐播放。

声网SDK可以很好的适配第三方版权音乐，具体流程如下(拿AME举例来说)：

1.  歌曲搜索点歌等逻辑都是APP业务逻辑及第三方版权音乐相关的逻辑。

2.  用户确认歌曲后，只需要AME SDK对音乐做解码，禁止声音播放。

3. 从AME SDK的音乐裸数据回调中，拿到PCM裸数据然后使用声网自采集相关API送给声网SDK，声网SDK内部自动把麦克风声音和AME音乐声音混到一起往声网频道内发送。音频裸数据使用请参考 [声网自定义音频采集](https://docs.agora.io/cn/live-streaming-premium-4.x/custom_audio_src_apple_ng?platform=iOS)。

4.  声网SDK启用localPlayback模式，目的是让AME解码出来的PCM数据用声网SDK播放。

5.  总结来说就是： 音频自采集+localPlayback 。

## 音量波纹提示

在语聊房中，房间内的观众一般需要知道谁在说话，通常是使用波纹提示。该功能可以直接使用声网SDK中的 [enableAudioVolumeIndication](https://docs.agora.io/cn/live-streaming-premium-4.x/API%20Reference/ios_ng/API/toc_audio_process.html#api_irtcengine_enableaudiovolumeindication) 方法启用音量提示功能，建议设置音量提示时间间隔为500ms;

在 [onAudioVolumeIndication](https://docs.agora.io/cn/live-streaming-premium-4.x/API%20Reference/java_ng/API/toc_audio_process.html#callback_irtcengineeventhandler_onaudiovolumeindication) 回调中，包含本地和远端讲话者的音量信息，一般在volume值大于20的时候给到音量提示。

## 录制&审核

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

1. 通过SDK的 onAudioVolumeIndication 回调，获知当前正在讲话人的uid, 然后和业务服务器记录的正常用户的uid做对比，判断其是否非法；

2. 通过Agora Restful API /dev/v1/channel/user/property/{apid}/{uid}/{channelName} 查询频道内当前在线用户列表，和业务服务器记录的正常用户做对比，找出非法用户；

3.  通过消息通知服务告知的上麦的用户uid和业务服务器记录的正常用户做对比；找出非法用户。

### 处理捣乱者

处理捣乱者有两种方式，一种是从源头上禁止捣乱者；另一种是让频道内的观众不接收捣乱者的语音。所以具体处理可以按照下面方式：

1.  发现捣乱者后，可以调用声网的Restful API 做出踢人处理；

2.  服务端通过IM消息告知频道内所有观众，禁止收听捣乱者的声音；

以上两种策略都依赖一个非重要的工作即合法用户状态列表维护，用户进入频道、离开频道、上麦、下麦、禁麦等状态都要维护好，一旦和发用户状态列表维护的有问题，那么当炸房发生时也不知道捣乱的人是否是非法用户或合法用户处在异常状态。炸房问题处理详细文档请参考 [炸房捣乱现象的预防和应对](https://docs.agora.io/cn/live-streaming-premium-legacy/prevent_stream_bombing?platform=Android)



### SEI的使用

#### 什么是SEI

SEI即补充增强信息(Supplemental Enhancement Information),它可被用来向码流中增加额外信息，该信息可以和视频流一起被传输。在直播场景中，该信息可以用来告知观众端在解析到SEI信息时做一些动画效果或者一些UI变化。

H264码流是一个个的NAL单元组成，这些NAL单元中一般包含I、B、P帧及SPS、PPS等关键帧信息。当NAL单元的类型是6的时候即表示是SEI，NAL type值对应的帧内容如下：

NALU Type

具体内容

5

I帧

6

SEI信息

7

SPS信息

8

PPS信息

SEI的结构：

![](https://docimg2.docs.qq.com/image/AgAACiNGFGNoqZEzs5tLsLpUworEnBVE.png?w=1036&h=158)

声网SEI结构：

![](https://docimg5.docs.qq.com/image/AgAACiNGFGOLGVBQMgdNy4buI43SfIoN.png?w=1046&h=160)

详细声网SEI信息请参考 https://docs.agora.io/cn/All/faq/sei ，从上面结构可以得出如下结论：

1.  声网SEI信息里面的用户定义帧类型是100，这个是可以修改的；

2.  声网SEI信息里面没有payload uuid这个字段；

3.  声网SEI信息内容，除了SEI type是6不可修改之外，其它均可自定义；

#### 发送SEI

声网有三种方式可以写入SEI信息，具体有：

1.  如果是客户端旁路转码旁路推流到CDN，可以通过LiveTranscoding中的transcodingExtraInfo(iOS) userConfigExtraInfo(Android)属性用户自定义参数打到SEI里面。

2.  客户端通过在SDK里面发送dataStream，然后声网可以配置把dataStream通道中的内容打到SEI里面。

3.  客户端通过在SDK里面发送MetaData信息，然后声网可以配置把MetaData信息灌入到SEI里面。 

声网使用SEI信息一般是发生在旁路推流的时候，旁路推流可以由客户端SDK发起和服务端OpenAPI方式发起，需要注意：

1. 客户端发起旁路推流，想要把客户端发送的dataStream、MetaDta信息灌入推流视频中，必须要声网后台开通相关权限。 

2.  服务端OpenaAPI方式，不用特意开通，只需要在seiOptions中设置。 

#### 解析SEI

和传统SEI结构相比，声网的SEI信息结构把前面预留给uuid的16个字节全部用来写数据了，一般默认是不会把这16个字节的uid抛给用户的，所以声网MediaPlayerKit播放器解析SEI时有一些相关的私参如下。 

```
mediaPlayerKit.setPlayerOption("enable_search_metadata", value: 1)  //打开SEI解析
mediaPlayerKit.setPlayerOption("set_sei_filter_type", value: 100)  //设置解析类型
mediaPlayerKit.setPlayerOption("sei_data_with_uuid", value: 1) //设置为1表示sei数据包括16字节的uuid部分，设置为0表示会去掉16字节的uuid部分；

```

声网SDK中播放器解析SEI的回调(iOS)：

```
- (void)AgoraRtcMediaPlayer:(id<AgoraRtcMediaPlayerProtocol> _Nonnull)playerKit
             didReceiveData:(NSString *_Nullable)data
                     length:(NSInteger)length
{
}
```

声网SDK中播放器解析SEI的回调(Android)：

```
void onMetaData(Constants.MediaPlayerMetadataType type, byte[] data);
```

### 音量波纹提示

此时主播的音量信息可以通过SEI发送到CDN流里面，观众端直接解析CDN流拿到具体音量值做波纹提示。 

# Demo与场景搭建介绍

AD to do @张乾泽，建议直接使用声动互娱开源代码的demo 