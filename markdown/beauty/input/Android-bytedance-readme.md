本文介绍如何通过声网场景化 API 集成字节火山美颜到实时音视频中。

## 前提条件

- 项目使用Kotlin插件
- 项目里已经集成了Agora RTC SDK
- 联系字节技术支持拿到美颜 SDK、资源、证书

## 快速集成
1. (可选)解压字节/火山SDK并将以下aar库、资源文件、证书配置到项目对应目录下

| 字节/火山SDK文件/目录                                 | 项目目录                            |
|-----------------------------------------------|---------------------------------|
| resource/LicenseBag.bundle                    | assets/beauty_bytedance         |
| resource/ModelResource.bundle                 | assets/beauty_bytedance         |
| resource/ComposeMakeup.bundle                 | assets/beauty_bytedance         |
| resource/StickerResource.bundle               | assets/beauty_bytedance         |
| resource/StickerResource.bundle               | assets/beauty_bytedance         |
| byted_effect_andr/libs/effectAAR-release.aar  | libs                            |

2. 复制以下场景化接口及实现到项目里
> 请保留原有包名目录，以便于代码升级
```xml
src/main/java/io/agora/beautyapi/bytedance
   ├── ByteDanceBeautyAPI.kt
   ├── ByteDanceBeautyAPIImpl.kt
   └── utils
```

3. 初始化

```kotlin
// 初始化声网 RtcEngine
private val mRtcEngine by lazy {
    RtcEngine.create(RtcEngineConfig().apply {
        mContext = applicationContext
        mAppId = BuildConfig.AGORA_APP_ID
        mEventHandler = object : IRtcEngineEventHandler() {}
    }).apply {
        // 开启声网 clear_vision 视频插件
        enableExtension("agora_video_filters_clear_vision", "clear_vision", true)
    }
}

// 创建声网 Beauty API 对象
private val mByteDanceApi by lazy {
    createByteDanceBeautyAPI()
}

// 通过第三方库 beauty_bytedance 创建美颜特效管理器
private val mEffectManager by lazy {
    val resourceHelper =
        AssetsResourcesHelper(this, "beauty_bytedance")
    EffectManager(
        this,
        resourceHelper,
        resourceHelper.getLicensePath(LICENSE_NAME)
    )
}

// 初始化声网 Beauty API 对象
mByteDanceApi.initialize(
    Config(
        // RtcEngine
        mRtcEngine,
        // 美颜特效管理器
        mEffectManager,
        // 视频采集模式
        // CaptureMode.Agora 意味着使用声网模块采集的视频数据
        // CaptureMode.Custom 意味着使用开发者自定义采集的视频数据
        captureMode = CaptureMode.Agora,
        // 是否开启美颜统计数据
        // 开启后，SDK 会周期性触发 onBeautyStats 回调
        statsEnable = BuildConfig.BUILD,
        // 用于监听 Beauty API 的回调事件
        eventCallback = EventCallback(
            // 美颜统计数据回调
            onBeautyStats = {stats ->
                Log.d(TAG, "BeautyStats stats = $stats")
            },
            // 美颜特效初始化完成回调
            onEffectInitialized = {
                Log.d(TAG, "onEffectInitialized")
            },
            // 美颜特效销毁回调
            onEffectDestroyed = {
                Log.d(TAG, "onEffectInitialized")
            }
        )
    ))
```

4. 美颜开关

```kotlin
mByteDanceApi.enable(true)
```

5. 设置本地渲染视图

设置本地渲染视图（View），以让带有美颜特效的本地视频在视图上渲染出来。

```kotlin
mRtcEngine.setVideoEncoderConfiguration(mVideoEncoderConfiguration)
mRtcEngine.enableVideo()
mByteDanceApi.setupLocalVideo(mBinding.localVideoView, Constants.RENDER_MODE_FIT)
mRtcEngine.joinChannel(null, mChannelName, 0, ChannelMediaOptions().apply {
    channelProfile = Constants.CHANNEL_PROFILE_LIVE_BROADCASTING
    clientRoleType = Constants.CLIENT_ROLE_BROADCASTER
    publishCameraTrack = true
    publishMicrophoneTrack = false
    autoSubscribeAudio = false
    autoSubscribeVideo = true
})
```

6. 设置是否使用默认的美颜参数

推荐你使用默认（DEFAULT）的美颜参数，以获得全方面效果均衡的美颜效果。如果你不想使用默认的美颜参数，你可以使用自定义（CUSTOM）的美颜参数。


```kotlin
// 使用默认的美颜参数设置美颜效果
mByteDanceApi.setBeautyPreset(BeautyPreset.DEFAULT)
```

```kotlin
// 关闭之前使用默认的美颜参数
// 使用自定义的美颜参数
mByteDanceApi.setBeautyPreset(BeautyPreset.CUSTOM)
```

7. 销毁美颜

必须在 leaveChannel 后再销毁


```kotlin
// 离开 RTC 频道
mRtcEngine.leaveChannel()
// 销毁 Beauty API 对象
mByteDanceApi.release()
// 销毁美颜特效管理器
mEffectManager.destroy()
// 销毁 RtcEngine
RtcEngine.destroy()
```

## 自定义采集模式

美颜场景API除了能够内部直接使用RTC 祼数据接口进行美颜处理，也支持由外部传入视频帧进行处理，实现步骤如下：

1. 初始化时配置captureMode为CaptureMode.Custom

```kotlin
mByteDanceApi.initialize(
    Config(
        mRtcEngine,
        mEffectManager,
        captureMode = CaptureMode.Custom,
        statsEnable = BuildConfig.BUILD,
        eventCallback = EventCallback(
            onBeautyStats = {stats ->
                Log.d(TAG, "BeautyStats stats = $stats")
            },
            onEffectInitialized = {
                Log.d(TAG, "onEffectInitialized")
            },
            onEffectDestroyed = {
                Log.d(TAG, "onEffectInitialized")
            }
        )
    ))
```
2. 将外部数据帧通过onFrame接口传入，处理成功会替换VideoFrame的buffer数据，即videoFrame参数既为输入也为输出

```kotlin
// 注册原始视频数据观测器
// 当 CaptureMode.Custom 时，你需要进行此设置
mRtcEngine.registerVideoFrameObserver(object : IVideoFrameObserver {
    // 定义镜像变量
    private var shouldMirror = true
    // 获取本地采集的视频原始数据
    // 并在返回值中设置是否让 SDK 接收第三方处理后的视频帧
    override fun onCaptureVideoFrame(
        sourceType: Int,
        // 你可以从 VideoFrame 中拿到原始视频数据
        // 也可以将处理后的视频传入 VideoFrame 中
        videoFrame: VideoFrame?
    ) : Boolean {
        // 将原始视频数据传递给 Beauty API 进行美颜处理
        when(mByteDanceApi.onFrame(videoFrame!!)){
            // 情况 1，如果处理成功，那么关闭镜像，设置声网 SDK 接收处理后的视频帧
            ErrorCode.ERROR_OK.value -> {
                shouldMirror = false
                return true
            }
            //  情况 2，如果处理失败且需丢弃这一帧，那么关闭镜像，设置声网 SDK 丢弃处理后的视频帧
            ErrorCode.ERROR_FRAME_SKIPPED.value ->{
                shouldMirror = false
                return false
            }
            else -> {
                // 情况 3，如果处理结果是其他情况，那么当视频帧来自前置摄像头时设置镜像，来自后置摄像头时不设置镜像
                // 如果视频帧的来源变化（比如从前置摄像头切换后置摄像头，或者相反情况），那么设置声网 SDK 丢弃这一帧
                // 如果视频帧的来源没有变化，那么设置声网 SDK 接收这一帧
                val mirror = videoFrame.sourceType == VideoFrame.SourceType.kFrontCamera
                if(shouldMirror != mirror){
                    shouldMirror = mirror
                    return false
                }
                return true
            }
        }
    }
}
```