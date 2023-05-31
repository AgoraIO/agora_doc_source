## 示例代码

### RTC 初始化

```
fileprivate(set) lazy var agoraKit: AgoraRtcEngineKit = {
    let kit = AgoraRtcEngineKit.sharedEngine(with: rtcEngineConfig, delegate: nil)
    showLogger.info("load AgoraRtcEngineKit, sdk version: \(AgoraRtcEngineKit.getSdkVersion())", context: kShowLogBaseContext)
    return kit
}()
```

### 加入频道

```
private func joinChannel(needUpdateCavans: Bool = true) {
    agoraKitManager.setRtcDelegate(delegate: self, roomId: roomId)
    guard let channelId = room?.roomId, let ownerId = room?.ownerId else {
        return
    }
    currentChannelId = channelId
    self.joinStartDate = Date()
    let uid: UInt = UInt(ownerId)!
    agoraKitManager.joinChannelEx(currentChannelId: channelId,
                                  targetChannelId: channelId,
                                  ownerId: uid,
                                  options: self.channelOptions,
                                  role: role) { [weak self] in
        guard let self = self else { return }
        if needUpdateCavans {
            if self.role == .audience {
                self.agoraKitManager.setupRemoteVideo(channelId: channelId,
                                                      uid: uid,
                                                      canvasView: self.liveView.canvasView.localView)
            } else {
                self.agoraKitManager.setupLocalVideo(uid: uid, canvasView: self.liveView.canvasView.localView)
            }
        }
    }

    liveView.canvasView.setLocalUserInfo(name: room?.ownerName ?? "", img: room?.ownerAvatar ?? "")

    self.muteLocalVideo = false
    self.muteLocalAudio = false
}


// ShowAgoraKitManager.swift
private func _joinChannelEx(currentChannelId: String,
                            targetChannelId: String,
                            ownerId: UInt,
                            token: String,
                            options:AgoraRtcChannelMediaOptions,
                            role: AgoraClientRole) {
    if exConnectionMap[targetChannelId] == nil {
        let subscribeStatus = role == .audience ? false : true
        let mediaOptions = AgoraRtcChannelMediaOptions()
        mediaOptions.autoSubscribeAudio = subscribeStatus
        mediaOptions.autoSubscribeVideo = subscribeStatus
        mediaOptions.clientRoleType = role
        // 极速直播
        if role == .audience {
            mediaOptions.audienceLatencyLevel = .lowLatency
        }else{
            updateVideoEncoderConfigurationForConnenction(currentChannelId: currentChannelId)
        }

        let connection = AgoraRtcConnection()
        connection.channelId = targetChannelId
        connection.localUid = UInt(VLUserCenter.user.id) ?? 0

        let proxy = delegateMap[currentChannelId]
        let date = Date()
        showLogger.info("try to join room[\(connection.channelId)] ex uid: \(connection.localUid)", context:
kShowLogBaseContext)
        let ret =
        agoraKit.joinChannelEx(byToken: token,
                               connection: connection,
                               delegate: proxy,
                               mediaOptions: mediaOptions) { channelName, uid, elapsed in
            let cost = Int(-date.timeIntervalSinceNow * 1000)
            showLogger.info("join room[\(channelName)] ex success uid: \(uid) cost \(cost) ms", context:
kShowLogBaseContext)
        }
        agoraKit.updateChannelEx(with: mediaOptions, connection: connection)
        exConnectionMap[targetChannelId] = connection

        if ret == 0 {
            showLogger.info("join room ex: channelId: \(targetChannelId) ownerId: \(ownerId)",
                            context: "AgoraKitManager")
        }else{
            showLogger.error("join room ex fail: channelId: \(targetChannelId) ownerId: \(ownerId) token = \(token),
\(ret)",
                             context: kShowLogBaseContext)
        }
    }
}
```

### 主播本地预览

```
self.agoraKitManager.setupLocalVideo(uid: uid, canvasView: self.liveView.canvasView.localView)


// ShowAgoraKitManager.swift
func setupLocalVideo(uid: UInt, canvasView: UIView) {
    canvas.view = canvasView
    canvas.uid = uid
    canvas.mirrorMode = .disabled
    agoraKit.setVideoFrameDelegate(self)
    agoraKit.setDefaultAudioRouteToSpeakerphone(true)
    agoraKit.enableAudio()
    agoraKit.enableVideo()
    agoraKit.setupLocalVideo(canvas)
    agoraKit.startPreview()
    showLogger.info("setupLocalVideo target uid:\(uid), user uid\(UserInfo.userId)", context: kShowLogBaseContext)
}
```

### 观众远端渲染

```
self.agoraKitManager.setupRemoteVideo(channelId: channelId,
                                      uid: uid,
                                      canvasView: self.liveView.canvasView.localView)


// ShowAgoraKitManager.swift
func setupRemoteVideo(channelId: String, uid: UInt, canvasView: UIView) {
    guard let connection = exConnectionMap[channelId] else {
        showLogger.error("_joinChannelEx fail: connection is empty")
        return
    }

    let videoCanvas = AgoraRtcVideoCanvas()
    videoCanvas.uid = uid
    videoCanvas.view = canvasView
    videoCanvas.renderMode = .hidden
    let ret = agoraKit.setupRemoteVideoEx(videoCanvas, connection: connection)

    showLogger.info("setupRemoteVideoEx ret = \(ret), uid:\(uid) localuid: \(UserInfo.userId) channelId: \(channelId)", context:
kShowLogBaseContext)
}
```

### PK 加入/退出对方频道

```
// 加入频道
agoraKitManager.joinChannelEx(currentChannelId: roomId,
                              targetChannelId: interactionRoomId,
                              ownerId: uid,
                              options: self.channelOptions,
                              role: role) {
    showLogger.info("\(self.roomId) updateLoadingType _onStartInteraction---------- \(self.roomId)")
    if self.role == .broadcaster {
        self.agoraKitManager.setupRemoteVideo(channelId: interactionRoomId,
                                              uid: uid,
                                              canvasView: self.liveView.canvasView.remoteView)
    }else{
        self.updateLoadingType(loadingType: self.loadingType)
    }
}


// ShowAgoraKitManager.swift
private func _joinChannelEx(currentChannelId: String,
                            targetChannelId: String,
                            ownerId: UInt,
                            token: String,
                            options:AgoraRtcChannelMediaOptions,
                            role: AgoraClientRole) {
    if exConnectionMap[targetChannelId] == nil {
        let subscribeStatus = role == .audience ? false : true
        let mediaOptions = AgoraRtcChannelMediaOptions()
        mediaOptions.autoSubscribeAudio = subscribeStatus
        mediaOptions.autoSubscribeVideo = subscribeStatus
        mediaOptions.clientRoleType = role
        // 极速直播
        if role == .audience {
            mediaOptions.audienceLatencyLevel = .lowLatency
        }else{
            updateVideoEncoderConfigurationForConnenction(currentChannelId: currentChannelId)
        }

        let connection = AgoraRtcConnection()
        connection.channelId = targetChannelId
        connection.localUid = UInt(VLUserCenter.user.id) ?? 0

        let proxy = delegateMap[currentChannelId]
        let date = Date()
        showLogger.info("try to join room[\(connection.channelId)] ex uid: \(connection.localUid)", context: kShowLogBaseContext)
        let ret =
        agoraKit.joinChannelEx(byToken: token,
                               connection: connection,
                               delegate: proxy,
                               mediaOptions: mediaOptions) { channelName, uid, elapsed in
            let cost = Int(-date.timeIntervalSinceNow * 1000)
            showLogger.info("join room[\(channelName)] ex success uid: \(uid) cost \(cost) ms", context: kShowLogBaseContext)
        }
        agoraKit.updateChannelEx(with: mediaOptions, connection: connection)
        exConnectionMap[targetChannelId] = connection

        if ret == 0 {
            showLogger.info("join room ex: channelId: \(targetChannelId) ownerId: \(ownerId)",
                            context: "AgoraKitManager")
        }else{
            showLogger.error("join room ex fail: channelId: \(targetChannelId) ownerId: \(ownerId) token = \(token), \(ret)",
                             context: kShowLogBaseContext)
        }
    }
}


// 退出频道
agoraKitManager.leaveChannelEx(roomId: self.roomId, channelId: interaction.roomId)


// ShowAgoraKitManager.swift
func leaveChannelEx(roomId: String, channelId: String) {
    guard let connection = exConnectionMap[channelId] else { return }
    let depMap: [String: ShowRTCLoadingType]? = exConnectionDeps[channelId]
    guard depMap?.count ?? 0 == 0 else {
        showLogger.info("leaveChannelEx break, depcount: \(depMap?.count ?? 0), roomId: \(roomId), channelId: \(channelId)", context:
kShowLogBaseContext)
        return
    }
    showLogger.info("leaveChannelEx roomId: \(roomId), channelId: \(channelId)", context: kShowLogBaseContext)
    agoraKit.leaveChannelEx(connection)
    exConnectionMap[channelId] = nil
}
```

### 连麦角色切换

```
agoraKitManager.switchRole(role: role,
                           channelId: roomId,
                           options: self.channelOptions,
                           uid: interaction.userId,
                           canvasView: liveView.canvasView.remoteView)


// ShowAgoraKitManager.swift
func switchRole(role: AgoraClientRole,
                channelId: String,
                options:AgoraRtcChannelMediaOptions,
                uid: String?,
                canvasView: UIView?) {
    guard let uid = UInt(uid ?? ""), let canvasView = canvasView else {
        showLogger.error("switchRole fatel")
        return
    }
    options.clientRoleType = role
    updateChannelEx(channelId:channelId, options: options)
    if "\(uid)" == VLUserCenter.user.id {
        setupLocalVideo(uid: uid, canvasView: canvasView)
    } else {
        setupRemoteVideo(channelId: channelId, uid: uid, canvasView: canvasView)
    }
}


func updateChannelEx(channelId: String, options: AgoraRtcChannelMediaOptions) {
    guard let connection = exConnectionMap[channelId] else {
        showLogger.error("updateChannelEx fail: connection is empty")
        return
    }

    agoraKit.updateChannelEx(with: options, connection: connection)
}
```

### RTC 销毁

```
// ShowAgoraKitManager.swift
deinit {
    AgoraRtcEngineKit.destroy()
    showLogger.info("deinit-- ShowAgoraKitManager")
}
```