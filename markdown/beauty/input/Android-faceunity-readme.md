# 相芯美颜场景化API


## 前提条件
- 项目使用Kotlin插件
- 项目里已经集成了Agora RTC SDK
- 联系相芯客户拿到美颜资源以及证书

## 快速集成
1. (可选)配置相芯
- 配置依赖库
```groovy
allprojects {
    repositories {
        maven {
            url 'http://maven.faceunity.com/repository/maven-public/'
            allowInsecureProtocol = true
        }
    }
}

dependencies {
    implementation 'com.faceunity:core:8.3.0'
    implementation 'com.faceunity:model:8.3.0'
}
```
- 配置美颜资源/证书

| 美颜资源                 | 项目路径                            |
|----------------------|---------------------------------|
| 美妆资源(如naicha.bundle) | assets/beauty_faceunity/makeup  |
| 贴纸资源(如fashi.bundle)  | assets/beauty_faceunity/sticker |
| 证书authpack.java      | src                             |

2. 复制以下场景化接口及实现到项目里
> 请保留原有包名目录，以便于代码升级
```xml
src/main/java/io/agora/beautyapi/faceunity
   ├── FaceUnityBeautyAPI.kt
   ├── FaceUnityBeautyAPIImpl
   └── utils
```

3. 初始化
```kotlin
private val mFaceUnityApi by lazy {
    createFaceUnityBeautyAPI()
}
private val mFuRenderKit by lazy {
    FURenderer.getInstance().setup(this, authpack.A())
    FURenderKit.getInstance()
}

mFaceUnityApi.initialize(
    Config(
        mRtcEngine,
        mFuRenderKit,
        captureMode = CaptureMode.Agora,
        statsEnable = true,
        eventCallback = object: IEventCallback{
            override fun onBeautyStats(stats: BeautyStats) {
                Log.d(TAG, "BeautyStats stats = $stats")
            }
        }
    ))
```

4. 美颜开关(默认关)
```kotlin
mFaceUnityApi.enable(true)
```

5. 本地渲染
```kotlin
mFaceUnityApi.setupLocalVideo(mBinding.localVideoView, Constants.RENDER_MODE_FIT)
```

6. 设置推荐美颜参数
```kotlin
mFaceUnityApi.setBeautyPreset(BeautyPreset.DEFAULT) // BeautyPreset.CUSTOM：关闭推荐美颜参数
```

7. 销毁美颜
```kotlin
mRtcEngine.leaveChannel()
// 必须在leaveChannel后销毁
mFaceUnityApi.release()
FURenderer.getInstance().release()
mFuRenderKit.release()
```

## 自定义采集模式
美颜场景API除了能够内部直接使用RTC 祼数据接口进行美颜处理，也支持由外部传入视频帧进行处理，实现步骤如下：

1. 初始化时配置captureMode为CaptureMode.Custom
```kotlin
mFaceUnityApi.initialize(
    Config(
        mRtcEngine,
        mFuRenderKit,
        captureMode = CaptureMode.Custom,
        statsEnable = true,
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
) : Boolean{
    when(mFaceUnityApi.onFrame(videoFrame!!)){
        ErrorCode.ERROR_OK.value -> {
            shouldMirror = false
            return true
        }
        ErrorCode.ERROR_FRAME_SKIPPED.value ->{
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