## CDN观众 

### rtc房间内的语音流旁路推流到CDN

一般，语音聊天室中的音频还可能会被旁路推流到CDN，主要使用场景有以下两种：

1. 在语聊房应用中，可以通过H5链接的方式分享整个房间到微信、QQ等社交平台，其它人通过点击H5链接的方式收听整个聊天室中的内容，同时可以引导新用户下载语聊应用。

2. 语音留档审核，一般语音聊天室的内容需要存储一段时间用来做审核，所以可以通过CDN流的方式让审核方做录制审核。

![](https://docimg5.docs.qq.com/image/AgAACiNGFGPHrQbz9fFBZ418uV0dvsQN.png?w=1056&h=352)

声网提供服务端旁路推流服务，可以把频道内的所有主播的声音混流成一路推流到第三方CDN，详情请参考 [声网旁路推流服务](https://docs-preprod.agora.io/cn/media-push/streaming_product?platform=All%20Platforms)。

### 观众通过播放器拉CDN流播放 

语音聊天室的音频经过声网旁路推流服务推流到CDN之后，观众端可以使用声网SDK中自带的播放器做CDN流播放。 

示例代码(iOS)：

```
@interface MIMediaPlayer : NSObject<AgoraRtcMediaPlayerProtocol>

@end

@interface ViewController ()<AgoraRtcEngineDelegate,AgoraRtcMediaPlayerDelegate>
@property (nonatomic,strong) AgoraRtcEngineKit *agoraKit;
@property (nonatomic,strong) MIMediaPlayer *miPlayer;
@property (weak, nonatomic) IBOutlet UIView *playerView;

@end

@implementation ViewController

- (void)initAgoraEngine
{
    AgoraRtcEngineConfig *config = [[AgoraRtcEngineConfig alloc] init];
    // 传入 App ID。
    config.appId = @"";
    // 设置频道场景为直播。
    config.channelProfile = AgoraChannelProfileLiveBroadcasting;
    // 创建并初始化 AgoraRtcEngineKit 实例。
    self.agoraKit = [AgoraRtcEngineKit sharedEngineWithConfig:config delegate:self];

    self.miPlayer = [self.agoraKit createMediaPlayerWithDelegate:self];
}

- (void)playCdnStream
{
    NSString *cdnPlayUrl = @"";  // CDN拉流地址
    [self.miPlayer setView:self.playerView];
    self.playerView.backgroundColor = [UIColor redColor];
    [self.miPlayer open:musicPath startPos:0];
}

- (void)AgoraRtcMediaPlayer:(id<AgoraRtcMediaPlayerProtocol> _Nonnull)playerKit
          didChangedToState:(AgoraMediaPlayerState)state
                      error:(AgoraMediaPlayerError)error
{
    if (state == AgoraMediaPlayerStateOpenCompleted) {
        [self.miPlayer play];
    }
}
@end
```

示例代码(Android)：

```
public class MainActivity extends AppCompatActivity {

    private RtcEngine mRtcEngine;
    private IMediaPlayer mPlayer;

	private final  IMediaPlayerObserver mMiPlayerHandler = new IMediaPlayerObserver() {
        @Override
        public void onPlayerStateChanged(io.agora.mediaplayer.Constants.MediaPlayerState state, io.agora.mediaplayer.Constants.MediaPlayerError error) {
            if (state == io.agora.mediaplayer.Constants.MediaPlayerState.PLAYER_STATE_OPEN_COMPLETED){
                mPlayer.play();
            }
        }

        @Override
        public void onPositionChanged(long position_ms) {}

        @Override
        public void onPlayerEvent(io.agora.mediaplayer.Constants.MediaPlayerEvent eventCode, long elapsedTime, String message) {}

        @Override
        public void onMetaData(io.agora.mediaplayer.Constants.MediaPlayerMetadataType type, byte[] data) {}

        @Override
        public void onPlayBufferUpdated(long playCachedBuffer) {}

        @Override
        public void onPreloadEvent(String src, io.agora.mediaplayer.Constants.MediaPlayerPreloadEvent event) {}

        @Override
        public void onCompleted() {}

        @Override
        public void onAgoraCDNTokenWillExpire() {}

        @Override
        public void onPlayerSrcInfoChanged(SrcInfo from, SrcInfo to) {}

        @Override
        public void onPlayerInfoUpdated(PlayerUpdatedInfo info) {}

        @Override
        public void onAudioVolumeIndication(int volume) {}
    };


    private void mPlayerToPlay(){
        mPlayer.open("",0);  // 打开播放的视频，可以是在线地址，也可以是本地视频
    }

    private void initializeEngine(){
        try {
            mRtcEngine = RtcEngine.create(getBaseContext(),getString(R.string.agora_app_id),mRtcEventHandler);
            // 其它rtc engine配置
            mPlayer =  mRtcEngine.createMediaPlayer();
            mPlayer.registerPlayerObserver(mMiPlayerHandler);

            VideoCanvas videoCanvas = new VideoCanvas(mLocalView, Constants.RENDER_MODE_HIDDEN, Constants.VIDEO_MIRROR_MODE_AUTO,
                Constants.VIDEO_SOURCE_MEDIA_PLAYER,  mPlayer.getMediaPlayerId(), 0);
        mRtcEngine.setupLocalVideo(videoCanvas);
        }catch (Exception e){
            throw new RuntimeException("NEED TO check rtc sdk init fatal error\n"+ Log.getStackTraceString(e));
        }
    }
}

```

# 竞品相关

火山引擎

[https://www.volcengine.com/docs/6348/117919](https://www.volcengine.com/docs/6348/117919)

zego

[https://doc-zh.zego.im/article/15943.html](https://doc-zh.zego.im/article/15943.html)

TRTC

[https://cloud.tencent.com/document/product/647/46252](https://cloud.tencent.com/document/product/647/46252)

阿里

[https://help.aliyun.com/document_detail/176832.htm](https://help.aliyun.com/document_detail/176832.htm)