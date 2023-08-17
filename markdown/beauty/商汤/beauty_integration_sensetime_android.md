本文介绍如何通过声网场景化 API 集成商汤美颜到实时音视频中。

## 示例项目

声网在 GitHub 上提供开源 [BeautyAPI](https://github.com/AgoraIO-Community/BeautyAPI/tree/main) 示例项目供你参考。

## 准备开发环境

### 前提条件

- [Git](https://git-scm.com/downloads)
- [Java Development Kit](https://www.oracle.com/java/technologies/javase-downloads.html) 11
- [Android Studio](https://developer.android.com/studio/) 3.5 及以上
- Android 手机，版本 Android 5.0（API Level 21）及以上
- 有效的声网[开发者账号](https://docs.agora.io/cn/Agora%20Platform/sign_in_and_sign_up)
- 已联系商汤技术获取最新的美颜 SDK、美颜资源、美颜证书
- 已在项目中添加 Kotlin 插件

## 创建声网项目

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
        // x.y.z，请填写具体的 SDK 版本号，如：4.0.0 或 4.1.0-1。
        // 通过互动直播产品发版说明获取最新版本号。
        implementation 'io.agora.rtc:full-sdk:x.y.z'
     }
   ```
3. 将字节火山美颜 SDK 集成到你的项目中。请联系字节技术支持获取美颜 SDK、美颜资源、证书等文件。下载并解压文件，然后添加到美颜项目对应的文件路径下：

    | 文件                                                            | 项目路径                                             |
    |--------------------------------------------------------------------|------------------------------------------------------|
    | Android/models                                                      | app/src/main/assets/beauty_sensetime/models         |
    | Android/sample/SenseMeEffects/app/src/main/assets/sticker_face_shape | app/src/main/assets/beauty_sensetime/sticker_face_shape |
    | Android/sample/SenseMeEffects/app/src/main/assets/style_lightly      | app/src/main/assets/beauty_sensetime/style_lightly      |
    | Android/sample/SenseMeEffects/app/src/main/assets/makeup_lip         | app/src/main/assets/beauty_sensetime/makeup_lip         |
    | SenseME.lic                                                         | app/src/main/assets/beauty_sensetime/license/SenseME.lic |


4. 将声网场景化 API 集成到你的项目中。添加 [Android/lib_bytedance/src/main/java/io/agora/beautyapi/bytedance](https://github.com/AgoraIO-Community/BeautyAPI/tree/main/Android/lib_bytedance/src/main/java/io/agora/beautyapi/bytedance) //TODO 目录下的文件到项目中，具体文件如下：
    - `utils` 文件夹
    - `SenseTimeBeautyAPI.kt` 文件
    - `SenseTimeBeautyAPIImpl.kt` 文件

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

如下[时序图](#api-时序图)展示如何在直播间内实现美颜功能。声网 RTC SDK 承担实时音视频的业务，字节火山美颜 SDK 提供美颜功能，声网 Beauty API 封装了两个 SDK 中的 API 调用逻辑以简化你需要实现的代码逻辑。通过 Beauty API，你可以实现基础美颜功能，但是如果你需要更丰富的美颜效果，例如贴纸、美妆风格，你可以直接调用美颜 SDK 中的 API。



### 1. 初始化资源

本节介绍如何初始化 `RtcEngine`、`EffectManager`、Beauty API 对象。

1. 调用声网 RTC SDK 中的 create 创建并初始化 RtcEngine 对象。

2. 初始化美颜 SDK 的 `EffectManager` 对象。

3. 调用 `createByteDanceBeautyAPI` 创建 Beauty API 对象。Beauty API 对象是基于 `EffectManager` 对象封装。

4. 调用 `initialize` 初始化 Beauty API 对象。你需要在 `config` 参数中传入如下字段：

    - `mRtcEngine`：传入之前初始化的 `RtcEngine` 对象。
    - `mEffectManager`：传入之前初始化的 `EffectManager` 对象。
    - `captureMode`：视频的采集模式：
        - 如果你使用声网模块采集视频，请传入 `CaptureMode.Agora`。
        - 如果自定义采集视频，请传入 `CaptureMode.CUSTOM`。
    - `statsEnable`：是否开启美颜统计数据回调。`true` 代表开启，`false` 代表不开启。开启后，会有周期性的 `onBeautyStats` 回调事件
    - `eventCallback`：你希望监听的回调事件。

//TODO

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

### 2. 设置是否开启美颜

调用 Beauty API 的 `enable` 方法开启美颜。

```kotlin
mSenseTimeApi.enable(true)
```

### 3. 开启视频采集

开发者可以使用声网模块采集视频，也可以自定义采集视频。本节介绍在这两种场景下如何开启视频采集。

#### 使用声网模块采集视频

使用声网模块采集视频视频时，你需要先调用 `RtcEngine` 类的 `enableVideo` 开启声网 SDK 的视频模块，然后调用 Beauty API 的 `setupLocalVideo` 开启本地视图。

```kotlin
mSenseTimeApi.setupLocalVideo(mBinding.localVideoView, Constants.RENDER_MODE_FIT)
```

//TODO

#### 自定义视频采集 //TODO 研发 review

自定义视频采集时，你需要先调用 `RtcEngine` 类的 `enableVideo` 开启声网 SDK 的视频模块，然后通过 `RtcEngine` 类的 `registerVideoFrameObserver` 注册原始视频数据观测器并在其中实现 `onCaptureVideoFrame` 函数。

通过 Beauty API 的 `onFrame` 函数，你可以将外部自采集的视频数据传入并进行处理。当处理成功时，用自采集的视频数据替代 `onCaptureVideoFrame` 函数中的 `VideoFrame`，并传入声网 SDK。

//TODO

将外部数据帧通过onFrame接口传入，处理成功会替换VideoFrame的buffer数据，即videoFrame参数既为输入也为输出
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


### 4. 加入频道

调用 `RtcEngine` 类的 `joinChannel` 加入频道，同时传入如下参数：

- `token`：用于鉴权的动态密钥。如果在[创建声网项目](#创建声网项目)时启用调试模式，那么 token 传空；如果启用安全模式，那么你先参考[使用 Token 鉴权](https://docportal.shengwang.cn/cn/live-streaming-premium-4.x/token_server_android_ng?platform=Android)在你的业务服务端生成 Token，然后在这个参数中传入。
- `channelId`：频道名。
- `options`：频道媒体设置选项。

//TODO



### 5. 设置美颜效果

调用 Beauty API 中 `setBeautyPreset` 方法设置使用的美颜参数的类型：

- `DEFAULT`：默认且推荐的美颜参数。
- `CUSTOM`：开发者自定义的美颜参数。

不同的美颜参数会带来不同的美颜效果。如果你没有特殊偏好，推荐你使用 `DEFAULT`。


```kotlin
mSenseTimeApi.setBeautyPreset(BeautyPreset.DEFAULT) // BeautyPreset.CUSTOM：关闭推荐美颜参数 //TODO
```

### 6. 离开频道

调用 `RtcEngine` 类的 `leaveChannel` 离开频道。//TODO



### 7. 销毁资源

调用 Beauty API 的 `release`、`EffectManager` 的 `destroy`、`RtcEngine` 的 `destroy` 销毁 Beauty API、`EffectManager`、`RtcEngine` 对象，释放资源。

```kotlin
mRtcEngine.leaveChannel()
// 必须在leaveChannel后销毁
mSenseTimeApi.release()
mSTRenderKit.release()
```

### API 时序图

//TODO


