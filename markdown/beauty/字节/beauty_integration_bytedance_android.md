本文介绍如何通过声网场景化 API 集成字节火山美颜到实时音视频中。

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

2. 使用 Maven Central 将声网 RTC SDK 集成到你的项目中。

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

   b. 在 `/Gradle Scripts/build.gradle(Module: <projectname>.app)` 文件中添加如下代码，将声网 RTC SDK 集成到你的 Android 项目中：

   ```java
   ...
    dependencies {
        ...
        // x.y.z，请填写具体的 SDK 版本号，如：4.0.0 或 4.1.0-1。
        // 通过互动直播产品发版说明获取最新版本号。
        implementation 'io.agora.rtc:full-sdk:x.y.z'
     }
   ```
3. 将字节火山美颜 SDK 集成到你的项目中。请联系字节技术支持获取美颜 SDK、美颜资源、证书等文件。下载并解压文件，然后添加到美颜项目对应的文件路径下：

    | 文件    |  项目路径   |
    |-----|-----|
    | resource/LicenseBag.bundle                       | app/src/main/assets/beauty_bytedance           |
    | resource/ModelResource.bundle                    | app/src/main/assets/beauty_bytedance           |
    | resource/ComposeMakeup.bundle                    | app/src/main/assets/beauty_bytedance           |
    | resource/StickerResource.bundle                  | app/src/main/assets/beauty_bytedance           |
    | resource/StickerResource.bundle                    | app/src/main/assets/beauty_bytedance           |
    | byted_effect_andr/libs/effectAAR-release.aar  | app/libs   |

4. 将声网场景化 API 集成到你的项目中。添加 [Android/lib_bytedance/src/main/java/io/agora/beautyapi/bytedance](https://github.com/AgoraIO-Community/BeautyAPI/tree/main/Android/lib_bytedance/src/main/java/io/agora/beautyapi/bytedance) 目录下的文件到项目中，具体文件如下：
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

如下[时序图](#api-时序图)展示如何在直播间内实现美颜功能。声网 RTC SDK 承担实时音视频的业务，第三方美颜 SDK 承担美颜特效的业务，Beauty API 封装了两个 SDK 中的 API 调用逻辑以简化你需要实现的代码逻辑。通过 Beauty API，你可以实现第三方的基础美颜，但是如果你需要更丰富的贴纸滤镜等美颜效果，你可以直接调用第三方美颜 SDK 中的 API。

### 1. 初始化资源

本节介绍如何初始化 `RtcEngine`、`EffectManager`、Beauty API 对象。

1. 调用声网 RTC SDK 中的 create 创建并初始化 RtcEngine 对象。

    ```kotlin
    // 初始化声网 RtcEngine
    private val mRtcEngine by lazy {
        RtcEngine.create(RtcEngineConfig().apply {
            mContext = applicationContext
            // 传入你从控制台获取的声网项目的 APP ID
            mAppId = BuildConfig.AGORA_APP_ID
            mEventHandler = object : IRtcEngineEventHandler() {}
        }).apply {
            // 开启声网 clear_vision 视频插件
            enableExtension("agora_video_filters_clear_vision", "clear_vision", true)
        }
    }

2. 初始化美颜 SDK 的 `EffectManager` 对象。

    ```kotlin
    // 初始化字节火山美颜 SDK 提供的 EffectManager
    private val mEffectManager by lazy {
        val resourceHelper =
            AssetsResourcesHelper(this, "beauty_bytedance")
        EffectManager(
            this,
            resourceHelper,
            resourceHelper.getLicensePath(LICENSE_NAME)
        )
    }


3. 调用 `createByteDanceBeautyAPI` 创建 Beauty API 对象。Beauty API 对象是基于 `EffectManager` 对象封装。

    ```kotlin
    // 创建 Beauty API 对象
    private val mByteDanceApi by lazy {
        createByteDanceBeautyAPI()
    }

4. 调用 `initialize` 初始化 Beauty API 对象。你需要在 `config` 参数中传入如下字段：

    - `mRtcEngine`：传入之前初始化的 `RtcEngine` 对象。
    - `mEffectManager`：传入之前初始化的 `EffectManager` 对象。
    - `captureMode`：视频的采集模式：
        - 如果你使用声网模块采集视频，请传入 `CaptureMode.Agora`。
        - 如果自定义采集视频，请传入 `CaptureMode.CUSTOM`。
    - `statsEnable`：是否开启美颜统计数据回调。`true` 代表开启，`false` 代表不开启。开启后，会有周期性的 `onBeautyStats` 回调事件
    - `eventCallback`：你希望监听的回调事件。

    ```kotlin
    // 初始化 Beauty API 对象
    mByteDanceApi.initialize(
        Config(
            // RtcEngine
            mRtcEngine,
            // 美颜特效管理器
            mEffectManager,
            // 设置视频采集模式
            // CaptureMode.Agora 意味着使用声网模块采集视频
            // CaptureMode.Custom 意味着使用开发者自定义采集视频
            captureMode = if (isCustomCaptureMode) CaptureMode.Custom else
            CaptureMode.Agora,
            // 是否开启美颜统计数据
            // 开启后，会有周期性的 onBeautyStats 回调事件
            statsEnable = true,
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

调用 Beauty API 的 `enable` 方法开启美颜。

```kotlin
mByteDanceApi.enable(true)
```

### 3. 开启视频采集

开发者可以使用声网模块采集视频，也可以自定义采集视频。本节介绍在这两种场景下如何开启视频采集。

#### 使用声网模块采集视频

使用声网模块采集视频视频时，你需要先调用 `RtcEngine` 类的 `enableVideo` 开启声网 SDK 的视频模块，然后调用 Beauty API 的 `setupLocalVideo` 开启本地视图。

```kotlin
// 开启视频模块
mRtcEngine.enableVideo()
// 设置本地视图
mByteDanceApi.setupLocalVideo(mBinding.localVideoView, Constants.RENDER_MODE_FIT)
```

#### 自定义视频采集 //TODO 研发 review

自定义视频采集时，你需要先调用 `RtcEngine` 类的 `enableVideo` 开启声网 SDK 的视频模块，然后通过 `RtcEngine` 类的 `registerVideoFrameObserver` 注册原始视频数据观测器并在其中实现 `onCaptureVideoFrame` 函数。

通过 Beauty API 的 `onFrame` 函数，你可以将外部自采集的视频数据传入并进行处理。当处理成功时，用自采集的视频数据替代 `onCaptureVideoFrame` 函数中的 `VideoFrame`，并传入声网 SDK。


```kotlin
// 开启视频模块
mRtcEngine.enableVideo()
// 注册原始视频数据观测器
// 自定义视频采集时，即 CaptureMode 为 Custom 时，你需要注册原始视频观测器
mRtcEngine.registerVideoFrameObserver(object : IVideoFrameObserver {

    private var shouldMirror = true


    override fun onCaptureVideoFrame(
        sourceType: Int,
        videoFrame: VideoFrame?
    ) : Boolean {

        // 将原始视频数据传递给 Beauty API 并进行处理
        when(mByteDanceApi.onFrame(videoFrame!!)){
            // 情况 1，如果处理成功，那么关闭镜像，并通过返回值设置声网 RTC SDK 接收处理后的视频帧
            ErrorCode.ERROR_OK.value -> {
                shouldMirror = false
                return true
            }
            //  情况 2，如果处理失败且需丢弃这一帧，那么关闭镜像，并通过返回值设置声网 RTC SDK 丢弃处理后的视频帧
            ErrorCode.ERROR_FRAME_SKIPPED.value ->{
                shouldMirror = false
                return false
            }
            else -> {
                // 情况 3，如果处理结果是其他情况，那么当视频帧来自前置摄像头时设置镜像，来自后置摄像头时不设置镜像
                // 如果视频帧的来源变化（比如从前置摄像头切换后置摄像头，或者相反情况），那么设置声网 RTC SDK 丢弃这一帧
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

    // 设置是否对原始视频数据作镜像处理
    override fun getMirrorApplied() = shouldMirror

    // 设置观测点为本地采集时的视频数据
    override fun getObservedFramePosition() = IVideoFrameObserver.POSITION_POST_CAPTURER

    // override 视频观测器中的其他回调函数
    ......
}
```


### 4. 加入频道

调用 `RtcEngine` 类的 `joinChannel` 加入频道，同时传入如下参数：

- `token`：用于保障安全的 Token。如果你在控制台创建声网项目时选择了 xx 则传 null 即可。如果你在控制台创建声网项目时选择了 xx 则需要传入 Token 值。取值分为 xx //TODO
- `channelName`：频道名。
- `mediaOptions`：频道媒体选项，即，加入频道的用户的发流和收流等音视频行为。


```kotlin
mRtcEngine.joinChannel(null, mChannelName, 0, ChannelMediaOptions().apply {
    channelProfile = Constants.CHANNEL_PROFILE_LIVE_BROADCASTING
    clientRoleType = Constants.CLIENT_ROLE_BROADCASTER
    publishCameraTrack = true //TODO 自采集的时候是 publishCustomVideoTrack 吗
    publishMicrophoneTrack = false
    autoSubscribeAudio = false
    autoSubscribeVideo = true
})
```

### 5. 设置美颜效果

调用 Beauty API 中 `setBeautyPreset` 方法设置使用的美颜参数的类型：

- `DEFAULT`：默认且推荐的美颜参数。
- `CUSTOM`：开发者自定义的美颜参数。

不同的美颜参数会带来不同的美颜效果。如果你没有特殊偏好，推荐你使用 `DEFAULT`。

```kotlin
// 使用默认的美颜参数
mByteDanceApi.setBeautyPreset(BeautyPreset.DEFAULT)
```

```kotlin
// 使用自定义的美颜参数
mByteDanceApi.setBeautyPreset(BeautyPreset.CUSTOM)
```

**注意**：通过 Beauty API，你可以实现第三方的基础美颜，但是如果你需要更丰富的贴纸滤镜等进阶美颜效果，你可以直接调用第三方美颜 SDK 中的 API。

### 6. 离开频道

调用 `RtcEngine` 类的 `leaveChannel` 离开频道。

```kotlin
// 离开 RTC 频道
mRtcEngine.leaveChannel()
```

### 7. 销毁资源

调用 Beauty API 的 `release`、`EffectManager` 的 `destroy`、`RtcEngine` 的 `destroy` 销毁 Beauty API、`EffectManager`、`RtcEngine` 对象，释放资源。

```kotlin
// 销毁 Beauty API 对象
mByteDanceApi.release()
// 销毁 EffectManager
mEffectManager.destroy()
// 销毁 RtcEngine
RtcEngine.destroy()
```

### API 时序图

//TODO