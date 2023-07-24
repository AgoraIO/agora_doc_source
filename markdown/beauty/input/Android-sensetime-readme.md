# 商汤美颜场景化API

## 前提条件
- 项目使用Kotlin插件
- 项目里已经集成了Agora RTC SDK
- 联系商汤客服拿到商汤的美颜SDK

## 快速集成
1. (可选)解压商汤SDK并将以下aar库、资源文件、证书配置到项目对应目录下

| 商汤SDK文件/目录                                                              | 项目目录                             |
|-------------------------------------------------------------------------|----------------------------------|
| Android/models                                                          | assets/beauty_sensetime          |
| Android/smaple/SenseMeEffects/app/src/main/assets/sticker_face_shape    | assets/beauty_sensetime          |
| Android/smaple/SenseMeEffects/app/src/main/assets/style_lightly         | assets/beauty_sensetime          |
| Android/aar/STMobileJNI-release.aar                                     | libs                             |
| Android/smaple/SenseMeEffects/app/libs/SenseArSourceManager-release.aar | libs                             |
| Android/smaple/SenseMeEffects/app/libs/HardwareBuffer-release.aar       | libs                             |
| SenseME.lic                                                             | assets/beauty_sensetime/license  |

2. 复制以下场景化接口及实现到项目里
> 请保留原有包名目录，以便于代码升级
```xml
src/main/java/io/agora/beautyapi/sensetime
    ├── SenseTimeBeautyAPI.kt
    ├── SenseTimeBeautyAPIImpl.kt
    └── utils
```

3. 初始化
```kotlin
private val mSTRenderKit by lazy {
    STRenderKit(this, "beauty_sensetime")
}
private val mSenseTimeApi by lazy {
    createSenseTimeBeautyAPI()
}

mSenseTimeApi.initialize(
    Config(
        mRtcEngine,
        mSTRenderKit,
        captureMode = CaptureMode.Agora,
        statsEnable = BuildConfig.DEBUG,
        eventCallback = object: IEventCallback{
            override fun onBeautyStats(stats: BeautyStats) {
                Log.d(TAG, "BeautyStats stats = $stats")
            }
        }
    ))
```

4. 美颜开关(默认关)
```kotlin
mSenseTimeApi.enable(true)
```

5. 本地渲染
```kotlin
mSenseTimeApi.setupLocalVideo(mBinding.localVideoView, Constants.RENDER_MODE_FIT)
```

6. 设置推荐美颜参数
```kotlin
mSenseTimeApi.setBeautyPreset(BeautyPreset.DEFAULT) // BeautyPreset.CUSTOM：关闭推荐美颜参数
```

7. 销毁美颜
```kotlin
mRtcEngine.leaveChannel()
// 必须在leaveChannel后销毁
mSenseTimeApi.release()
mSTRenderKit.release()
```

## 自定义采集模式
美颜场景API除了能够内部直接使用RTC 祼数据接口进行美颜处理，也支持由外部传入视频帧进行处理，实现步骤如下：

1. 初始化时配置captureMode为CaptureMode.Custom
```kotlin
mSenseTimeApi.initialize(
    Config(
        mRtcEngine,
        mSTRenderKit,
        captureMode = CaptureMode.Custom,
        statsEnable = BuildConfig.DEBUG,
        eventCallback = object: IEventCallback{
            override fun onBeautyStats(stats: BeautyStats) {
                Log.d(TAG, "BeautyStats stats = $stats")
            }
        }
    ))
```
2. 将外部数据帧通过onFrame接口传入，处理成功会替换VideoFrame的buffer数据，即videoFrame参数既为输入也为输出
```kotlin
override fun onCaptureVideoFrame(
    sourceType: Int,
    videoFrame: VideoFrame?
) : Boolean {
    when(mSenseTimeApi.onFrame(videoFrame!!)){
        ErrorCode.ERROR_OK.value -> {
            shouldMirror = false
            return true
        }
        ErrorCode.ERROR_FRAME_SKIPPED.value -> {
            shouldMirror = false
            return false
        }
        else -> {
            val mirror = videoFrame.sourceType == VideoFrame.SourceType.kFrontCamera
            if(shouldMirror != mirror){
                shouldMirror = mirror
                return false
            }
            return true
        }
    }
}
```
