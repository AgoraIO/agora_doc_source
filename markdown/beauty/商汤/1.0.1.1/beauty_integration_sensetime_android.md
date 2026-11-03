本文介绍如何通过声网美颜场景化 API (Beauty API) 集成商汤美颜到实时音视频互动中。

## 示例项目

声网在 GitHub 上提供开源 [BeautyAPI](https://github.com/AgoraIO-Community/BeautyAPI/tree/1.0.1.1) 示例项目供你参考。

## 准备开发环境

### 前提条件

- [Git](https://git-scm.com/downloads)
- [Java Development Kit](https://www.oracle.com/java/technologies/javase-downloads.html) 11
- [Android Studio](https://developer.android.com/studio/) 3.5 及以上
- Android 手机，版本 Android 5.0（API Level 21）及以上
- 有效的声网[开发者账号](https://docs.agora.io/cn/Agora%20Platform/sign_in_and_sign_up)
- 已联系商汤技术获取最新的美颜 SDK、美颜资源、美颜证书
- 已在项目中添加 Kotlin 插件

### 创建声网项目

~f42d44d0-2ac7-11ee-b391-19a59cc2656e~

跑通示例项目时，你需要将**鉴权机制**设置为**调试模式：APP ID**。从头搭建 Android 项目集成美颜功能时，声网推荐你将**鉴权机制**设置为**安全模式：APP ID + Token**，以保障安全性。


### 创建 Android 项目

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
        // x.y.z，请填写具体的 RTC SDK 版本号，如：4.0.0 或 4.1.0-1。
        // 通过互动直播产品发版说明获取最新版本号。
        implementation 'io.agora.rtc:full-sdk:x.y.z'
     }
   ```

3. 将商汤美颜 SDK 集成到你的项目中。请联系商汤技术支持获取美颜 SDK、美颜资源、证书等文件。下载并解压文件，然后添加到美颜项目对应的文件路径下：

    | 文件                                                            | 项目路径                                             |
    |--------------------------------------------------------------------|------------------------------------------------------|
    | Android/models                                                      | app/src/main/assets/beauty_sensetime/models         |
    | Android/sample/SenseMeEffects/app/src/main/assets/sticker_face_shape | app/src/main/assets/beauty_sensetime/sticker_face_shape |
    | Android/sample/SenseMeEffects/app/src/main/assets/style_lightly      | app/src/main/assets/beauty_sensetime/style_lightly      |
    | Android/sample/SenseMeEffects/app/src/main/assets/makeup_lip         | app/src/main/assets/beauty_sensetime/makeup_lip         |
    | SenseME.lic                                                         | app/src/main/assets/beauty_sensetime/license/SenseME.lic |


4. 将声网美颜场景化 API 集成到你的项目中。添加 [Android/lib_sensetime/src/main/java/io/agora/beautyapi/sensetime](https://github.com/AgoraIO-Community/BeautyAPI/tree/1.0.1.1/Android/lib_sensetime/src/main/java/io/agora/beautyapi/sensetime) 目录下的文件到项目中，具体文件如下：
    - `utils` 文件夹
    - `SenseTimeBeautyAPI.kt` 文件
    - `SenseTimeBeautyAPIImpl.kt` 文件

    <div class="alert note">为方便后续代码升级，请不要修改你添加的这些文件的名称和路径。</div>

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

本节展示如何在直播间内实现美颜功能，参考 [API 时序图](#api-时序图)可查看总览。声网 RTC SDK 承担实时音视频的业务，商汤美颜 SDK 提供美颜功能，声网 Beauty API 封装了两个 SDK 中的 API 调用逻辑以简化你需要实现的代码逻辑。通过 Beauty API，你可以实现基础美颜功能，但是如果你还需要更丰富的美颜效果，例如贴纸、美妆风格，你可以直接调用美颜 SDK 中的 API。

### 1. 初始化 RtcEngine

调用声网 RTC SDK 中的 `create` 创建并初始化 `RtcEngine` 对象。

```kotlin
// 初始化声网 RtcEngine
private val mRtcEngine by lazy {
    RtcEngine.create(RtcEngineConfig().apply {
        mContext = applicationContext
        // 传入你从控制台获取的声网项目的 APP ID
        mAppId = BuildConfig.AGORA_APP_ID
        mEventHandler = object : IRtcEngineEventHandler() {}
    }).apply {
        // 开启声网 clear_vision 高清视频插件
        enableExtension("agora_video_filters_clear_vision", "clear_vision", true)
    }
}
```

### 2. 初始化美颜 SDK

创建来自美颜 SDK 的 `STRenderKit` 实例。

```kotlin
private val mSTRenderKit by lazy {
    STRenderKit(
        this,
        "beauty_sensetime"
    )
}
```

### 3. 初始化 Beauty API

调用 `createSenseTimeBeautyAPI` 创建 Beauty API 对象。Beauty API 对象基于 `STRenderKit` 对象封装。

```kotlin
// 创建 Beauty API 对象
private val mSenseTimeApi by lazy {
    createSenseTimeBeautyAPI()
}
```

调用 `initialize` 初始化 Beauty API 对象。你需要在 `config` 参数中传入如下字段：

- `mRtcEngine`：传入之前初始化的 `RtcEngine` 对象。
- `mSTRenderKit`：传入之前初始化的 `STRenderKit` 对象。
- `captureMode`：视频的采集模式：
    - 如果你使用声网模块采集视频，请传入 `CaptureMode.Agora`。
    - 如果自定义采集视频，请传入 `CaptureMode.Custom`。
- `statsEnable`：是否开启美颜统计数据回调。`true` 代表开启，`false` 代表不开启。开启后，会有周期性的 `onBeautyStats` 回调事件。
- `statsDuration`：美颜统计数据回调的周期。单位为毫秒。
- `eventCallback`：你希望监听的回调事件。

```kotlin
// 初始化 Beauty API 对象
mSenseTimeApi.initialize(
    Config(
        // RtcEngine
        mRtcEngine,
        // STRenderKit
        mSTRenderKit,
        // 设置视频采集模式
        // CaptureMode.Agora 意味着使用声网模块采集视频
        // CaptureMode.Custom 意味着使用开发者自定义采集视频
        captureMode = if (isCustomCaptureMode) CaptureMode.Custom else CaptureMode.Agora,
        // 是否开启美颜统计数据
        // 开启后，会有周期性的 onBeautyStats 回调事件
        statsEnable = true,
        // 设置美颜统计数据的统计区间为 1000 毫秒（默认）
        statsDuration = 1000,
        // 用于监听 Beauty API 的回调事件
        eventCallback = object: IEventCallback{
            override fun onBeautyStats(stats: BeautyStats) {
                Log.d(TAG, "BeautyStats stats = $stats")
            }
        }
    )
)
```

### 4. 开启美颜

调用 Beauty API 的 `enable` 方法并将参数设为 `true` 开启美颜。

```kotlin
mSenseTimeApi.enable(true)
```

### 5. 开启视频采集

开发者可以使用声网模块采集视频，也可以自定义采集视频。本节介绍在这两种场景下如何开启视频采集。

#### 使用声网模块采集视频

使用声网模块采集视频视频时，你需要先调用 `RtcEngine` 类的 `enableVideo` 开启声网 SDK 的视频模块，然后调用 Beauty API 的 `setupLocalVideo` 开启本地视图。

```kotlin
// 开启视频模块
mRtcEngine.enableVideo()
// 设置本地视图
mSenseTimeApi.setupLocalVideo(mBinding.localVideoView, Constants.RENDER_MODE_FIT)
```

#### 自定义视频采集

自定义视频采集时，你需要先调用 `RtcEngine` 类的 `enableVideo` 开启声网 SDK 的视频模块，然后通过 `RtcEngine` 类的 `registerVideoFrameObserver` 注册原始视频数据观测器并在其中实现 `onCaptureVideoFrame` 函数。

通过 Beauty API 的 `onFrame` 函数，你可以将外部自采集的视频数据传入并进行处理。当处理结果不为 `SKIPPED`（忽略）时，用自采集的视频数据替代 `onCaptureVideoFrame` 函数中的 `VideoFrame`，并传入声网 SDK。

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
        when(mSenseTimeApi.onFrame(videoFrame!!)){
            // 当处理结果为 SKIPPED（忽略）时，代表你丢帧，即外部自采集的视频数据不传入声网 SDK
            // 当处理结果为其他时，外部自采集的视频数据传入声网 SDK
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

    // 设置是否对原始视频数据作镜像处理
    override fun getMirrorApplied() = shouldMirror

    // 设置观测点为本地采集时的视频数据
    override fun getObservedFramePosition() = IVideoFrameObserver.POSITION_POST_CAPTURER

    // override 视频观测器中的其他回调函数
    ...
})
```


### 6. 加入频道

调用 `RtcEngine` 类的 `joinChannel` 加入频道，同时传入如下参数：

- `token`：用于鉴权的动态密钥。如果在[创建声网项目](#创建声网项目)时启用**调试模式**，那么将 `token` 参数传空。如果启用**安全模式**，那么你先参考[使用 Token 鉴权](https://docportal.shengwang.cn/cn/live-streaming-premium-4.x/token_server_android_ng?platform=Android)在你的业务服务端生成 Token，然后将生成的 Token 传入该参数。
- `channelId`：频道名。
- `options`：频道媒体设置选项。


```kotlin
mRtcEngine.joinChannel(null, mChannelName, 0, ChannelMediaOptions().apply {
    // 设置频道场景为直播
    channelProfile = Constants.CHANNEL_PROFILE_LIVE_BROADCASTING
    // 设置用户角色为主播，主播可以在频道里发布和订阅音视频流
    clientRoleType = Constants.CLIENT_ROLE_BROADCASTER
    // 设置是否发布摄像头采集的视频流（适用于使用声网模块采集视频的情况）
    publishCameraTrack = true
    // 设置是否发布自定义采集的视频流（适用于自定义采集视频的情况）
    publishCustomVideoTrack = false
    // 设置是否发布麦克风采集的音频流
    publishMicrophoneTrack = false
    // 设置进入频道时是否自动订阅频道内其他用户的音频流
    autoSubscribeAudio = false
    // 设置进入频道时是否自动订阅频道内其他用户的视频流
    autoSubscribeVideo = true
})
```

### 7. 设置美颜效果

调用 Beauty API 中 `setBeautyPreset` 方法设置使用的美颜参数的类型：

- `DEFAULT`：默认且推荐的美颜参数。
- `CUSTOM`：开发者自定义的美颜参数。

不同的美颜参数会带来不同的美颜效果。如果你没有特殊美颜要求，推荐你使用 `DEFAULT`。

```kotlin
mSenseTimeApi.setBeautyPreset(if (enable) BeautyPreset.DEFAULT else BeautyPreset.CUSTOM)
```

<div class="alert note">通过 Beauty API 的 <code>setBeautyPreset</code> 方法，你可以实现基础美颜功能。但是如果你还需要更丰富的美颜效果，例如贴纸、美妆风格，你可以直接调用美颜 SDK 中的 API。</div>

### 8. 离开频道

调用 `RtcEngine` 类的 `leaveChannel` 离开频道。

```kotlin
mRtcEngine.leaveChannel()
```

### 9. 销毁资源

调用 Beauty API 的 `release` 销毁 Beauty API。

```kotlin
mSenseTimeApi.release()
```

调用美颜 SDK 的 `release` 销毁 `STRenderKit`。

```kotlin
mSTRenderKit.release()
```

调用 `RtcEngine` 的 `destroy` 销毁 `RtcEngine`。

```kotlin
RtcEngine.destroy()
```


### API 时序图

![](https://web-cdn.agora.io/docs-files/1693553307432)