本文介绍如何通过声网场景化 API 集成字节美颜到实时音视频中。

## 示例项目

声网在 GitHub 上提供开源 [BeautyAPI](https://github.com/AgoraIO-Community/BeautyAPI/tree/main) 示例项目供你参考。

## 准备开发环境

### 前提条件 //TODO 是否需要 certificate 和 token？

- [Git](https://git-scm.com/downloads)
- [Java Development Kit](https://www.oracle.com/java/technologies/javase-downloads.html) 11
- [Android Studio](https://developer.android.com/studio/) 3.5 及以上
- Android 手机，版本 Android 5.0（API Level 21）及以上
- 有效的声网[开发者账号](https://docs.agora.io/cn/Agora%20Platform/sign_in_and_sign_up)
- 已联系字节技术获取最新的美颜 SDK、美颜资源、美颜证书
- 已在项目中添加 Kotlin 插件

### 创建项目

按照以下步骤准备开发环境：

1. 如需创建新项目，在 **Android Studio** 里，依次选择 **Phone and Tablet > Empty Activity**，创建 [Android 项目](https://developer.android.com/studio/projects/create-project)。

   <div class="alert note">创建项目后，<b>Android Studio</b> 会自动开始同步 gradle, 稍等片刻至同步成功后再进行下一步操作。</div>

2. 使用 Maven Central 将声网视频 SDK 集成到你的项目中。

   a. 在 `/Gradle Scripts/build.gradle(Project: <projectname>)` 文件中添加如下代码，添加 Maven Central 依赖：

   ```java
    buildscript {
        repositories {
            ...
            mavenCentral()
        }
        ...
   }

     allprojects {
        repositories {
            ...
            mavenCentral()
        }
   }
   ```

    <div class="alert note">如果你的 Android 项目设置了 <a href="https://docs.gradle.org/current/userguide/declaring_repositories.html#sub:centralized-repository-declaration">dependencyResolutionManagement</a>，添加 Maven Central 依赖的方式可能存在差异。</div>

   b. 在 `/Gradle Scripts/build.gradle(Module: <projectname>.app)` 文件中添加如下代码，将声网视频 SDK 集成到你的 Android 项目中：

   ```java
   ...
    dependencies {
        ...
        // x.y.z，请填写具体的 SDK 版本号，如：4.0.0 或 4.1.0-1。
        // 通过互动直播产品发版说明获取最新版本号。
        implementation 'io.agora.rtc:full-sdk:x.y.z'
     }
   ```
3. 将字节美颜 SDK 集成到你的项目中。请联系字节技术支持获取美颜 SDK、美颜资源、证书等文件。下载并解压文件，然后添加到美颜项目对应的文件路径下：

    | 文件    |  项目路径   |
    |-----|-----|
    | resource/LicenseBag.bundle                       | app/src/main/assets/beauty_bytedance           |
    | resource/ModelResource.bundle                    | app/src/main/assets/beauty_bytedance           |
    | resource/ComposeMakeup.bundle                    | app/src/main/assets/beauty_bytedance           |
    | resource/StickerResource.bundle                  | app/src/main/assets/beauty_bytedance           |
    | resource/StickerResource.bundle                    | app/src/main/assets/beauty_bytedance           |
    | byted_effect_andr/libs/effectAAR-release.aar  | app/libs   |

4. 将声网场景化 API 集成到你的项目中。添加 [Android/lib_bytedance/src/main/java/io/agora/beautyapi/bytedance 目录](https://github.com/AgoraIO-Community/BeautyAPI/tree/main/Android/lib_bytedance/src/main/java/io/agora/beautyapi/bytedance)下的文件到项目中，具体文件如下：
    - `utils` 文件夹
    - `ByteDanceBeautyAPI.kt` 文件
    - `ByteDanceBeautyAPIImpl.kt` 文件

    为方便后续代码升级，请不要修改你添加的这些文件的名称。

5. 添加网络及设备权限。

   在 `/app/Manifests/AndroidManifest.xml` 文件中，在 `</application>` 后面添加如下权限：

   ```xml
    <uses-permission android:name="android.permission.INTERNET"/>
    <uses-permission android:name="android.permission.CAMERA"/>
    <uses-permission android:name="android.permission.RECORD_AUDIO"/>
    <uses-permission android:name="android.permission.MODIFY_AUDIO_SETTINGS"/>
    <uses-permission android:name="android.permission.ACCESS_WIFI_STATE"/>
    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE"/>
    <uses-permission android:name="android.permission.BLUETOOTH"/>
    <!-- 对于 Android 12.0 及以上且集成 v4.1.0 以下声网 SDK 的设备，还需要添加以下权限 -->
    <uses-permission android:name="android.permission.BLUETOOTH_CONNECT"/>
    <!-- 对于 Android 12.0 及以上设备，还需要添加以下权限 -->
    <uses-permission android:name="android.permission.READ_PHONE_STATE"/>
    <uses-permission android:name="android.permission.BLUETOOTH_SCAN"/>
   ```

5. 在 `/Gradle Scripts/proguard-rules.pro` 文件中添加如下行，以防止声网 SDK 的代码被混淆：

   ```java
   -keep class io.agora.**{*;}
   -dontwarn javax.**
   -dontwarn com.google.devtools.build.android.**
   ```

## 实现美颜

### 1. 初始化

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
        captureMode = if (isCustomCaptureMode) CaptureMode.Custom else
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

### 2. 设置是否开启美颜

```kotlin
if (beautyEnableDefault) {
    mByteDanceApi.enable(true)
}
```

### 3. 设置本地渲染视图

设置本地渲染视图（View），以让带有美颜特效的本地视频在视图上渲染出来。

```kotlin
#TODO 是否需要补充这些
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

### 4. 设置是否使用默认的美颜参数

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

### 5. 销毁美颜

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

## 视频自采集时实现美颜

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