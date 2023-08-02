本文介绍如何实现秀场直播。

## 示例项目

声网在 [agora-ent-scenarios](https://github.com/AgoraIO-Usecase/agora-ent-scenarios) 仓库中提供[秀场直播](https://github.com/AgoraIO-Usecase/agora-ent-scenarios/tree/v3.0.0.1-all-Android/Android/scenes/show)源代码供你参考。

## 业务流程图

~464cb0d0-1bd1-11ee-b391-19a59cc2656e~

## 准备开发环境

### 前提条件

- [Android Studio](https://developer.android.com/studio/) 4.1 及以上。
- Android 手机，版本 Android 5.0（API Level 21）及以上。
- 可以访问互联网的计算机。确保你的网络环境没有部署防火墙，否则无法正常使用声网服务。
- 有效的声网[开发者账号](https://docs.agora.io/cn/Agora%20Platform/sign_in_and_sign_up)和声网项目，请参考[开始使用声网平台](https://docs.agora.io/cn/Agora%20Platform/get_appid_token?platform=All%20Platforms)，从声网控制台获取以下信息：
  - App ID：声网随机生成的字符串，用于识别你的 app。
  - 临时 Token：你的 app 客户端加入频道时会使用 Token 对用户进行鉴权。临时 Token 的有效期为 24 小时。
  - 频道名称：用于标识直播频道的字符串。

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
3. 将商汤美颜 SDK 集成到你的项目中。请联系商汤技术支持获取美颜 SDK、测试证书、集成步骤。

4. 添加网络及设备权限。

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

## 实现秀场直播

如下[时序图](#api-时序图)如何创建直播间、加入直播间、PK 连麦、观众连麦、退出直播间。声网 RTC SDK 承担实时音视频的业务，声网云服务承担信令消息和数据存储的业务。本节会详细介绍如何调用 RTC SDK 的 API 完成这些逻辑，但是信令消息的逻辑需要你参考时序图和[示例项目](https://github.com/AgoraIO-Usecase/agora-ent-scenarios/tree/v3.0.0.1-all-Android/Android/scenes/show)自行实现。

<div class="alert note">声网云服务为内部自研服务，暂不对外提供。你可以调用声网云服务的 API 用于测试，但是对于正式环境，声网建议你参考文档自行实现相似的一套服务。如需协助，请<a href="https://docs.agora.io/cn/Agora%20Platform/ticket?platform=All%20Platforms">提交工单</a>。</div>



### 1. 创建房间

创建房间时，你需要初始化 RTC 引擎、注册原始视频数据以设置商汤美颜、为主播设置本地视图并进行预览。本节展示初始化 RTC 引擎和注册原始视频数据的示例代码。

你需要调用 [`create`](https://docportal.shengwang.cn/cn/live-streaming-premium-4.x/API%20Reference/java_ng/API/toc_core_method.html#api_irtcengine_initialize) 方法创建 RTC 引擎，并在 `config` 参数中配置上下文 Context、项目的 App ID、注册事件回调。调用 [`registerVideoFrameObserver`](https://docportal.shengwang.cn/cn/live-streaming-premium-4.x/API%20Reference/java_ng/API/toc_video_observer.html#api_imediaengine_registervideoframeobserver) 注册原始视频数据 `beautyProcessor`，用于后续设置商汤美颜。再调用 [`enableVideo`](https://docportal.shengwang.cn/cn/live-streaming-premium-4.x/API%20Reference/java_ng/API/toc_video_process.html#api_irtcengine_enablevideo) 开启视频。


![](https://web-cdn.agora.io/docs-files/1688633295261)

```kotlin
val rtcEngine: RtcEngineEx
    get() {
        if (innerRtcEngine == null) {
            val config = RtcEngineConfig()
            config.mContext = AgoraApplication.the()
            config.mAppId = io.agora.scene.base.BuildConfig.AGORA_APP_ID
            config.mEventHandler = object : IRtcEngineEventHandler() {
                override fun onError(err: Int) {
                    super.onError(err)
                    ToastUtils.showToast(
                        "Rtc Error code:$err, msg:" + RtcEngine.getErrorDescription(err)
                    )
                }
            }
            innerRtcEngine = (RtcEngine.create(config) as RtcEngineEx).apply {
                registerVideoFrameObserver(beautyProcessor)
                enableVideo()
            }
        }
        return innerRtcEngine!!
    }
```

### 2. 加入房间

加入房间时，你需要在主播和观众端都设置并渲染主播视频，再加入频道。本节展示加入频道的示例代码。

调用 [`joinChannelEx`](https://docportal.shengwang.cn/cn/live-streaming-premium-4.x/API%20Reference/java_ng/API/toc_multi_channel.html#api_irtcengineex_joinchannelex) 加入频道。频道用于传输直播间中的音视频流，云服务用于传输直播间中的信令消息和存储数据。用户在频道内可以进行实时音视频互动。频道内的用户有两种角色：

- 主播：可以发送和接收音视频流。直播间的房主即为主播。
- 观众：只可以接收音视频流。

![](https://web-cdn.agora.io/docs-files/1688633303525)

```kotlin
private fun joinChannel(eventListener: VideoSwitcher.IChannelEventListener) {
    val rtcConnection = mMainRtcConnection
    val uid = UserManager.getInstance().user.id
    val channelName = mRoomInfo.roomId
    val channelMediaOptions = ChannelMediaOptions()
    channelMediaOptions.clientRoleType =
        if (isRoomOwner) Constants.CLIENT_ROLE_BROADCASTER else Constants.CLIENT_ROLE_AUDIENCE
    channelMediaOptions.autoSubscribeVideo = true
    channelMediaOptions.autoSubscribeAudio = true
    // 对于房主，发布音视频流
    // 对于观众，不发布音视频流
    channelMediaOptions.publishCameraTrack = isRoomOwner
    channelMediaOptions.publishMicrophoneTrack = isRoomOwner
    // 对于观众，把延时等级设置为 LOW_LATENCY，以便体验低延时的音视频互动
    if (!isRoomOwner) {
        channelMediaOptions.audienceLatencyLevel = AUDIENCE_LATENCY_LEVEL_LOW_LATENCY
    }
    mRtcVideoSwitcher.joinChannel(
        rtcConnection,
        channelMediaOptions,
        eventListener
    )
}


// class VideoSwitcherImpl
override fun joinChannel(
    connection: RtcConnection,
    mediaOptions: ChannelMediaOptions,
    eventListener: VideoSwitcher.IChannelEventListener
) {
    connectionsJoined.firstOrNull{ it.isSameChannel(connection)}
        ?.let {
            ShowLogger.d(tag, "joinChannel joined connection=$it")
            it.rtcEventHandler?.setEventListener(eventListener)
            return
        }
    connectionsPreloaded.firstOrNull { it.isSameChannel(connection) }
        ?.let {
            ShowLogger.d(tag, "joinChannel preloaded connection=$it")
            it.rtcEventHandler?.setEventListener(eventListener)
            it.rtcEventHandler?.subscribeMediaTime = SystemClock.elapsedRealtime()
            it.mediaOptions = mediaOptions
            rtcEngine.updateChannelMediaOptionsEx(mediaOptions, it)
            connectionsPreloaded.remove(it)
            connectionsJoined.add(it)
            return
        }
    val connectionWrap = RtcConnectionWrap(connection)
    connectionWrap.mediaOptions = mediaOptions
    ShowLogger.d(tag, "joinChannel connection=$connectionWrap")
    joinRtcChannel(connectionWrap, eventListener)
    connectionsJoined.add(connectionWrap)
    mainHandler.removeCallbacks(preLoadRun)
    if (connectionsJoined.size == 1 || connectionsPreloaded.size <= 0) {
        mainHandler.postDelayed(preLoadRun, 500)
    }
}
```

### 3. 主播设置本地视图

加入房间时，你需要在主播和观众端都设置并渲染主播视频，再加入频道。本节展示调用 [`setupLocalVideo`](https://docportal.shengwang.cn/cn/live-streaming-premium-4.x/API%20Reference/java_ng/API/toc_video_process.html#api_irtcengine_setuplocalvideo) 在主播端设置并渲染主播视频的示例代码。


```kotlin
mRtcVideoSwitcher.setupLocalVideo(
    VideoSwitcher.VideoCanvasContainer(
        it,
        mBinding.videoLinkingLayout.videoContainer,
        0
    )
)


// class VideoSwitcherImpl
override fun setupLocalVideo(container: VideoSwitcher.VideoCanvasContainer) {
    localVideoCanvas?.let {
        if (it.lifecycleOwner == container.lifecycleOwner && it.renderMode == container.renderMode && it.uid == container.uid) {
            val videoView = it.view
            val viewIndex = container.container.indexOfChild(videoView)
            if (viewIndex == container.viewIndex) {
                return
            }
            (videoView.parent as? ViewGroup)?.removeView(videoView)
            container.container.addView(videoView, container.viewIndex)
            return
        }
    }
    var videoView = container.container.getChildAt(container.viewIndex)
    if (!(videoView is TextureView)) {
        videoView = TextureView(container.container.context)
        container.container.addView(videoView, container.viewIndex)
    }

    val local = LocalVideoCanvasWrap(
        container.lifecycleOwner,
        videoView, container.renderMode, container.uid
    )
    local.mirrorMode = Constants.VIDEO_MIRROR_MODE_DISABLED
    rtcEngine.setupLocalVideo(local)
}
```

### 4. 观众渲染主播视频

加入房间时，你需要在主播和观众端都设置并渲染主播视频，再加入频道。本节展示调用 [`setupRemoteVideoEx`](https://docportal.shengwang.cn/cn/live-streaming-premium-4.x/API%20Reference/java_ng/API/toc_multi_channel.html#api_irtcengineex_setupremotevideoex) 在观众端渲染远端视频（即主播的视频）的示例代码。


```kotlin
mRtcVideoSwitcher.setupRemoteVideo(
    rtcConnection,
    VideoSwitcher.VideoCanvasContainer(it, mBinding.videoLinkingLayout.videoContainer, mRoomInfo.ownerId.toInt())
)


// class VideoSwitcherImpl
override fun setupRemoteVideo(
    connection: RtcConnection,
    container: VideoSwitcher.VideoCanvasContainer
) {
    remoteVideoCanvasList.firstOrNull {
        it.connection.isSameChannel(connection) && it.uid == container.uid && it.renderMode == container.renderMode && it.lifecycleOwner == c
    }?.let {
        val videoView = it.view
        val viewIndex = container.container.indexOfChild(videoView)
        if (viewIndex == container.viewIndex) {
            if (it.connection.rtcEventHandler?.isJoinChannelSuccess == true) {
                rtcEngine.setupRemoteVideoEx(
                    it,
                    it.connection
                )
            }
            return
        }
        it.release()
    }
    var videoView = container.container.getChildAt(container.viewIndex)
    if (videoView !is TextureView) {
        videoView = TextureView(container.container.context)
        container.container.addView(videoView, container.viewIndex)
    } else {
        container.container.removeViewInLayout(videoView)
        videoView = TextureView(container.container.context)
        container.container.addView(videoView, container.viewIndex)
    }
    var connectionWrap = connectionsJoined.firstOrNull { it.isSameChannel(connection) }
    if(connectionWrap == null){
        connectionWrap = connectionsPreloaded.firstOrNull { it.isSameChannel(connection) }
    }
    if(connectionWrap == null){
        connectionWrap = RtcConnectionWrap(connection)
    }
    val remoteVideoCanvasWrap = RemoteVideoCanvasWrap(
        connectionWrap,
        container.lifecycleOwner,
        videoView,
        container.renderMode,
        container.uid
    )
    if(connectionWrap.rtcEventHandler?.isJoinChannelSuccess == true){
        rtcEngine.setupRemoteVideoEx(
            remoteVideoCanvasWrap,
            connectionWrap
        )
    }
}
```

### 5. 主播 PK 连麦

房主跨直播间 PK 连麦意味着不同频道内的主播加入对方频道进行连麦。当房间内用户收到房主 PK 连麦的信令消息后，房间内用户的代码逻辑如下：

- 房间 A：
    - 房主 A 通过 [`joinChannelEx`](https://docportal.shengwang.cn/cn/live-streaming-premium-4.x/API%20Reference/java_ng/API/toc_multi_channel.html#api_irtcengineex_joinchannelex) 加入频道 B，并且设置订阅频道 B 内音视频流，但不发送音视频流。同时通过 [`setupRemoteVideoEx`](https://docportal.shengwang.cn/cn/live-streaming-premium-4.x/API%20Reference/java_ng/API/toc_multi_channel.html#api_irtcengineex_setupremotevideoex) 渲染频道 B 中主播的视频。
    - 观众通过 `joinChannelEx` 加入频道 B，并且设置订阅频道 B 内音视频流，但不发送音视频流。同时通过 `setupRemoteVideoEx` 渲染频道 B 中主播的视频。
- 房间 B：
    - 房主 B 通过 `joinChannelEx` 加入频道 A，并且设置订阅频道 A 内音视频流，但不发送音视频流。同时通过 `setupRemoteVideoEx` 渲染频道 A 中主播的视频。
    - 观众通过 `joinChannelEx` 加入频道 A，并且设置订阅频道 A 内音视频流，但不发送音视频流。同时通过 `setupRemoteVideoEx` 渲染频道 A 中主播的视频。

完成这些逻辑后，观众可以同时接收频道 A 和 B 的音视频流，因此可以同时看到两个房间的房主。房主仅在自己的频道发流，在对方的频道内不发流仅收流，因此，房主可以（在对方频道）看到对方，达到连麦的效果。

结束 PK 连麦时，房间内用户都需要调用 [`leaveChannelEx`](https://docportal.shengwang.cn/cn/live-streaming-premium-4.x/API%20Reference/java_ng/API/toc_multi_channel.html#api_irtcengineex_leavechannelex) 离开对方频道。

本节展示用户加入对方频道和离开对方频道的示例代码，如需查阅 `setupRemoteVideoEx` 方法调用逻辑，请参考 [GitHub 示例项目](#示例项目)。

![](https://web-cdn.agora.io/docs-files/1688633311661)

```kotlin
// 加入对方频道
mRtcVideoSwitcher.joinChannel(
    pkRtcConnection, channelMediaOptions, eventListener
)


// class VideoSwitcherImpl
override fun joinChannel(
    connection: RtcConnection,
    mediaOptions: ChannelMediaOptions,
    eventListener: VideoSwitcher.IChannelEventListener
) {
    connectionsJoined.firstOrNull{ it.isSameChannel(connection)}
        ?.let {
            ShowLogger.d(tag, "joinChannel joined connection=$it")
            it.rtcEventHandler?.setEventListener(eventListener)
            return
        }
    connectionsPreloaded.firstOrNull { it.isSameChannel(connection) }
        ?.let {
            ShowLogger.d(tag, "joinChannel preloaded connection=$it")
            it.rtcEventHandler?.setEventListener(eventListener)
            it.rtcEventHandler?.subscribeMediaTime = SystemClock.elapsedRealtime()
            it.mediaOptions = mediaOptions
            rtcEngine.updateChannelMediaOptionsEx(mediaOptions, it)
            connectionsPreloaded.remove(it)
            connectionsJoined.add(it)
            return
        }
    val connectionWrap = RtcConnectionWrap(connection)
    connectionWrap.mediaOptions = mediaOptions
    ShowLogger.d(tag, "joinChannel connection=$connectionWrap")
    joinRtcChannel(connectionWrap, eventListener)
    connectionsJoined.add(connectionWrap)
    mainHandler.removeCallbacks(preLoadRun)
    if (connectionsJoined.size == 1 || connectionsPreloaded.size <= 0) {
        mainHandler.postDelayed(preLoadRun, 500)
    }
}


// 退出对方频道
mRtcVideoSwitcher.leaveChannel(
    RtcConnection(
        interactionInfo!!.roomId,
        UserManager.getInstance().user.id.toInt()
    )
)


// class VideoSwitcherImpl
override fun leaveChannel(connection: RtcConnection): Boolean {
    connectionsJoined.firstOrNull { it.isSameChannel(connection) }
        ?.let { conn ->
            val options = conn.mediaOptions
            options.clientRoleType = Constants.CLIENT_ROLE_AUDIENCE
            options.audienceLatencyLevel = Constants.AUDIENCE_LATENCY_LEVEL_LOW_LATENCY
            options.autoSubscribeVideo = false
            options.autoSubscribeAudio = false
            rtcEngine.updateChannelMediaOptionsEx(options, conn)
            conn.rtcEventHandler?.setEventListener(null)
            connectionsJoined.remove(conn)
            connectionsPreloaded.add(conn)
            conn.audioMixingPlayer?.stop()
            return true
        }
    connectionsPreloaded.firstOrNull { it.isSameChannel(connection) }
        ?.let {
            leaveRtcChannel(it)
            connectionsPreloaded.remove(it)
            return true
        }
    return false
}
```

### 6. 观众连麦

观众与主播连麦时，你可以通过信令让主播邀请观众连麦，或观众向主播申请连麦。让待上麦观众更新频道媒体选项、预览并设置本地视图。让其他用户收到观众连麦通知后，渲染该连麦观众的视频。完成这些逻辑后，直播间内观众可以看到主播和上麦观众的连麦直播。

结束连麦时，你需要让待下麦观众更新频道媒体选项、停止预览并取消本地试图。让其他用户收到该观众下麦通知后，取消渲染该观众的视频。完成这些逻辑后，直播间观众可以看到仅有主播的直播画面。

本节展示观众连麦和结束连麦时更新频道媒体选项的示例代码。通过 [`updateChannelMediaOptionsEx`](https://docportal.shengwang.cn/cn/live-streaming-premium-4.x/API%20Reference/java_ng/API/toc_multi_channel.html#api_irtcengineex_updatechannelmediaoptionsex) 方法在观众加入频道后更新频道媒体选项，例如是否开启本地音频采集，是否发布本地音频流等。观众的用户角色为 `CLIENT_ROLE_AUDIENCE`，因此无法在频道内发布音频流。如果观众想与主播连麦，需要将用户角色修改为 `CLIENT_ROLE_BROADCASTER`。

![](https://web-cdn.agora.io/docs-files/1688633319673)


```kotlin
// 观众上麦时，用户角色从 AUDIENCE 切换成 BROADCASTER
val channelMediaOptions = ChannelMediaOptions()
// 发布音视频流
channelMediaOptions.publishCameraTrack = true
channelMediaOptions.publishMicrophoneTrack = true
channelMediaOptions.publishCustomAudioTrack = false
channelMediaOptions.enableAudioRecordingOrPlayout = true
channelMediaOptions.autoSubscribeVideo = true
channelMediaOptions.autoSubscribeAudio = true
channelMediaOptions.clientRoleType = Constants.CLIENT_ROLE_BROADCASTER
mRtcEngine.updateChannelMediaOptionsEx(channelMediaOptions, rtcConnection)


// 连麦观众下麦时，用户角色从 BROADCASTER 切换成 AUDIENCE
val channelMediaOptions = ChannelMediaOptions()
val rtcConnection = mMainRtcConnection
// 不发布音视频流
channelMediaOptions.publishCameraTrack = false
channelMediaOptions.publishMicrophoneTrack = false
channelMediaOptions.publishCustomAudioTrack = false
channelMediaOptions.enableAudioRecordingOrPlayout = true
channelMediaOptions.autoSubscribeVideo = true
channelMediaOptions.autoSubscribeAudio = true
// 注意：角色为观众时，即使 publishCameraTrack 和 publishMicrophoneTrack 设为 true，也无法发音视频流。如需发布音视频流，必须将角色设为主播。
channelMediaOptions.clientRoleType = Constants.CLIENT_ROLE_AUDIENCE
channelMediaOptions.audienceLatencyLevel = Constants.AUDIENCE_LATENCY_LEVEL_LOW_LATENCY
mRtcEngine.updateChannelMediaOptionsEx(channelMediaOptions, rtcConnection)
```

### 7. 离开并销毁房间

直播结束时，主播和观众离开房间，你可以离开频道并销毁 RTC 引擎。

本节展示调用 [`destroy`](https://docportal.shengwang.cn/cn/live-streaming-premium-4.x/API%20Reference/java_ng/API/toc_core_method.html#api_irtcengine_release) 销毁 RTC 引擎的示例代码。

![](https://web-cdn.agora.io/docs-files/1688633329030)

```kotlin
fun destroy() {
    // 移除所有消息和定时任务
    innerVideoSwitcher?.let {
        it.unloadConnections()
        innerVideoSwitcher = null
    }
    // 销毁 RTC 引擎
    innerRtcEngine?.let {
        workingExecutor.execute { RtcEngine.destroy() }
        innerRtcEngine = null
    }
    // 释放 beautyProcessor
    innerBeautyProcessor?.let { processor ->
        processor.release()
        innerBeautyProcessor = null
    }
}


// innerVideoSwitcher
// class VideoSwitcherImpl
// unloadConnections 函数中执行的具体操作
override fun unloadConnections() {
    mainHandler.removeCallbacksAndMessages(null)
    connectionsJoined.forEach {
        leaveRtcChannel(it)
    }
    connectionsPreloaded.forEach {
        leaveRtcChannel(it)
    }
    localVideoCanvas?.release()
    connectionsForPreloading.clear()
    connectionsPreloaded.clear()
    connectionsJoined.clear()
    ShowLogger.d(tag, "unloadConnections")
}
```

### API 时序图

下图展示实现本文全部流程所需的 API 调用时序。

![](https://web-cdn.agora.io/docs-files/1688633286510)
