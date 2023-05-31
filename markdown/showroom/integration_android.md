## 基础流程图

### 创建房间

![](https://web-cdn.agora.io/docs-files/1685528911266)


### 进房退房

![](https://web-cdn.agora.io/docs-files/1685528919199)
### 主播 PK

![](https://web-cdn.agora.io/docs-files/1685528929039)
### 观众连麦

![](https://web-cdn.agora.io/docs-files/1685528935784)

## API 时序图

<pic>

## 示例代码

### RTC 初始化

```
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

### 加入频道

```
private fun joinChannel(eventListener: VideoSwitcher.IChannelEventListener) {
    val rtcConnection = mMainRtcConnection
    val uid = UserManager.getInstance().user.id
    val channelName = mRoomInfo.roomId
    val channelMediaOptions = ChannelMediaOptions()
    channelMediaOptions.clientRoleType =
        if (isRoomOwner) Constants.CLIENT_ROLE_BROADCASTER else Constants.CLIENT_ROLE_AUDIENCE
    channelMediaOptions.autoSubscribeVideo = true
    channelMediaOptions.autoSubscribeAudio = true
    channelMediaOptions.publishCameraTrack = isRoomOwner
    channelMediaOptions.publishMicrophoneTrack = isRoomOwner
    // 如果是观众 把 ChannelMediaOptions 的 audienceLatencyLevel 设置为 AUDIENCE_LATENCY_LEVEL_LOW_LATENCY（超低延时）
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

### 主播本地预览

```
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

### 观众远端渲染

```
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

### PK 加入/退出对方频道

```
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


# class VideoSwitcherImpl
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
            //remoteVideoCanvasList.filter { canvas -> canvas.connection.equal(conn) }.forEach { it.release()
            // 移除播放中的MediaPlayer
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

### 连麦角色切换

```
// 观众切换成主播角色
val channelMediaOptions = ChannelMediaOptions()
channelMediaOptions.publishCameraTrack = true
channelMediaOptions.publishMicrophoneTrack = true
channelMediaOptions.publishCustomAudioTrack = false
channelMediaOptions.enableAudioRecordingOrPlayout = true
channelMediaOptions.autoSubscribeVideo = true
channelMediaOptions.autoSubscribeAudio = true
channelMediaOptions.clientRoleType = Constants.CLIENT_ROLE_BROADCASTER
mRtcEngine.updateChannelMediaOptionsEx(channelMediaOptions, rtcConnection)


// 主播切换成观众角色
val channelMediaOptions = ChannelMediaOptions()
val rtcConnection = mMainRtcConnection
channelMediaOptions.publishCameraTrack = false
channelMediaOptions.publishMicrophoneTrack = false
channelMediaOptions.publishCustomAudioTrack = false
channelMediaOptions.enableAudioRecordingOrPlayout = true
channelMediaOptions.autoSubscribeVideo = true
channelMediaOptions.autoSubscribeAudio = true
channelMediaOptions.clientRoleType = Constants.CLIENT_ROLE_AUDIENCE
channelMediaOptions.audienceLatencyLevel = Constants.AUDIENCE_LATENCY_LEVEL_LOW_LATENCY
mRtcEngine.updateChannelMediaOptionsEx(channelMediaOptions, rtcConnection)
```

### RTC 销毁

```
fun destroy() {
    innerVideoSwitcher?.let {
        it.unloadConnections()
        innerVideoSwitcher = null
    }
    innerRtcEngine?.let {
        workingExecutor.execute { RtcEngine.destroy() }
        innerRtcEngine = null
    }
    innerBeautyProcessor?.let { processor ->
        processor.release()
        innerBeautyProcessor = null
    }
}


// innerVideoSwitcher
// class VideoSwitcherImpl
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