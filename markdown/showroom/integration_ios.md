本文介绍如何实现秀场直播。

## 示例项目

声网在 [agora-ent-scenarios](https://github.com/AgoraIO-Usecase/agora-ent-scenarios) 仓库中提供[秀场直播](https://github.com/AgoraIO-Usecase/agora-ent-scenarios/tree/v3.0.0-all-iOS/iOS/AgoraEntScenarios/Scenes/Show)源代码供你参考。

## 业务流程图

~464cb0d0-1bd1-11ee-b391-19a59cc2656e~

## 准备开发环境

### 前提条件

- [Xcode](https://apps.apple.com/cn/app/xcode/id497799835?mt=12) 12.0 及以上。
- iOS 设备，版本 13.0 及以上。
- 有效的苹果开发者账号。
- 可以访问互联网的计算机。确保你的网络环境没有部署防火墙，否则无法正常使用声网服务。
- 有效的声网[开发者账号](https://docs.agora.io/cn/Agora%20Platform/sign_in_and_sign_up)和声网项目。请参考[开始使用声网平台](https://docs.agora.io/cn/Agora%20Platform/get_appid_token?platform=All%20Platforms)从声网控制台获得以下信息：
  - App ID：声网随机生成的字符串，用于识别你的项目。
  - 临时 Token：Token 也称为动态密钥，在客户端加入频道时对用户鉴权。临时 token 的有效期为 24 小时。
  - 频道名：用于标识频道的字符串。


### 创建项目

在 Xcode 中进行以下操作，在你的 app 中实现秀场直播功能：

1. [创建一个新的项目](https://help.apple.com/xcode/mac/current/#/dev07db0e578)，**Application** 选择 **App**，**Interface** 选择 **Storyboard**，**Language** 选择 **Swift**。

    <div class="alert note">如果你没有添加过开发团队信息，会看到 <b>Add account…</b> 按钮。点击该按钮并按照屏幕提示登入 Apple ID，点击 <b>Next</b>，完成后即可选择你的 Apple 账户作为开发团队。</div>

2. 为你的项目设置[自动签名](https://help.apple.com/xcode/mac/current/#/dev23aab79b4)。

3. 设置部署你的 app 的[目标设备](https://help.apple.com/xcode/mac/current/#/deve69552ee5)。

4. 添加项目的设备权限。在项目导航栏中打开 `info.plist` 文件，编辑[属性列表](https://help.apple.com/xcode/mac/current/#/dev3f399a2a6)，添加以下属性：

    | key                                    | type   | value                                                        |
    | -------------------------------------- | ------ | ------------------------------------------------------------ |
    | Privacy - Microphone Usage Description | String | 使用麦克风的目的，例如 for a live interactive streaming |
    | Privacy - Camera Usage Description       | String | 使用摄像头的目的，例如 for a live interactive streaming |

    <div class="alert note"><ul><li>如果你的项目中需要添加第三方插件或库（例如第三方摄像头），且该插件或库的签名与项目的签名不一致，你还需勾选 <b>Hardened Runtime</b> > <b>Runtime Exceptions</b> 中的 <b>Disable Library Validation</b>。</li><li>更多注意事项，可以参考 <a href="https://developer.apple.com/documentation/xcode/preparing_your_app_for_distribution">Preparing Your App for Distribution</a >。</li></ul></div>

5. 将声网视频 SDK 集成到你的项目。开始前请确保你已安装 CocoaPods，如尚未安装 CocoaPods，参考 [Getting Started with CocoaPods](https://guides.cocoapods.org/using/getting-started.html#getting-started) 安装说明。

    1. 在终端里进入项目根目录，并运行 `pod init` 命令。项目文件夹下会生成一个 `Podfile` 文本文件。
    2. 打开 `Podfile` 文件，修改文件为如下内容。注意将 `Your App` 替换为你的 Target 名称。

    ```shell
    platform :ios, '9.0'
    target 'Your App' do
    # x.y.z 请填写具体的 SDK 版本号，如 4.0.1 或 4.0.0.4。
    # 可通过互动直播发版说明获取最新版本号。
    pod 'AgoraRtcEngine_iOS', 'x.y.z'
    end
    ```
6. 将商汤美颜 SDK 集成到你的项目中。请联系商汤技术支持获取美颜 SDK、测试证书、集成步骤。

7. 在终端内运行 <code>pod install</code> 命令安装声网 SDK。成功安装后，Terminal 中会显示 <code>Pod installation complete!</code>。

8. 成功安装后，项目文件夹下会生成一个后缀为 <code>.xcworkspace</code> 的文件，通过 Xcode 打开该文件进行后续操作。


## 实现秀场直播

如下[时序图](#api-时序图)中展示了如何创建直播间、加入直播间、PK 连麦、观众连麦、退出直播间。声网 RTC SDK 承担实时音视频的业务，声网云服务承担信令消息和数据存储的业务。本节会详细介绍如何调用 RTC SDK 的 API 完成这些逻辑，但是信令消息的逻辑需要你参考时序图和[示例项目](https://github.com/AgoraIO-Usecase/agora-ent-scenarios/tree/v3.0.0-all-iOS/iOS/AgoraEntScenarios/Scenes/Show)自行实现。

<div class="alert note">声网云服务为内部自研服务，暂不对外提供。你可以调用声网云服务的 API 用于测试，但是对于正式环境，声网建议你参考文档自行实现相似的一套服务。如需协助，请<a href="https://docs.agora.io/cn/Agora%20Platform/ticket?platform=All%20Platforms">提交工单</a>。</div>


### 1. 创建房间

创建房间时，你需要初始化 RTC 引擎、注册原始视频数据以设置商汤美颜、为主播设置本地视图并进行预览。本节展示调用 [`sharedEngineWithConfig`](https://docportal.shengwang.cn/cn/live-streaming-premium-4.x/API%20Reference/ios_ng/API/toc_core_method.html#api_irtcengine_initialize) 初始化 RTC 引擎的示例代码。

![](https://web-cdn.agora.io/docs-files/1688633685329)

```swift
fileprivate(set) lazy var agoraKit: AgoraRtcEngineKit = {
    let kit = AgoraRtcEngineKit.sharedEngine(with: rtcEngineConfig, delegate: nil)
    showLogger.info("load AgoraRtcEngineKit, sdk version: \(AgoraRtcEngineKit.getSdkVersion())", context: kShowLogBaseContext)
    return kit
}()
```

### 2. 加入房间

加入房间时，你需要在主播和观众端都设置并渲染主播视频，再加入频道。本节展示加入频道的示例代码。

调用 [`joinChannelExByToken`](https://docportal.shengwang.cn/cn/live-streaming-premium-4.x/API%20Reference/ios_ng/API/toc_multi_channel.html#api_irtcengineex_joinchannelex) 加入频道。频道用于传输直播间中的音视频流，云服务用于传输直播间中的信令消息和存储数据。用户在频道内可以进行实时音视频互动。频道内的用户有两种角色：

- 主播：可以发送和接收音视频流。直播间的房主即为主播。
- 观众：只可以接收音视频流。

![](https://web-cdn.agora.io/docs-files/1688633724495)

```swift
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
        // 对于观众，把延时等级设置为 lowLatency，以便体验低延时的音视频互动
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

### 3. 主播设置本地视图

加入房间时，你需要在主播和观众端都设置并渲染主播视频，再加入频道。本节展示调用 [`setupLocalVideo`](https://docportal.shengwang.cn/cn/live-streaming-premium-4.x/API%20Reference/ios_ng/API/toc_video_process.html#api_irtcengine_setuplocalvideo) 在主播端设置并渲染主播视频的示例代码。

```swift
self.agoraKitManager.setupLocalVideo(uid: uid, canvasView: self.liveView.canvasView.localView)


// ShowAgoraKitManager.swift
func setupLocalVideo(uid: UInt, canvasView: UIView) {
    canvas.view = canvasView
    canvas.uid = uid
    canvas.mirrorMode = .disabled
    // 设置原始视频数据，以便后续设置商汤美颜
    agoraKit.setVideoFrameDelegate(self)
    // 设置耳返
    agoraKit.setDefaultAudioRouteToSpeakerphone(true)
    // 开启音频
    agoraKit.enableAudio()
    // 开启视频
    agoraKit.enableVideo()
    // 设置本地视图
    agoraKit.setupLocalVideo(canvas)
    // 开启本地视频预览
    agoraKit.startPreview()
    showLogger.info("setupLocalVideo target uid:\(uid), user uid\(UserInfo.userId)", context: kShowLogBaseContext)
}
```

### 4. 观众渲染主播视频

加入房间时，你需要在主播和观众端都设置并渲染主播视频，再加入频道。本节展示调用 [`setupRemoteVideoEx`](https://docportal.shengwang.cn/cn/live-streaming-premium-4.x/API%20Reference/ios_ng/API/toc_multi_channel.html#api_irtcengineex_setupremotevideoex) 在观众端渲染远端视频（即主播的视频）的示例代码。

```swift
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

### 5. 主播 PK 连麦

房主跨直播间 PK 连麦意味着不同频道内的主播加入对方频道进行连麦。当房间内用户收到房主 PK 连麦的信令消息后，房间内用户的代码逻辑如下：

- 房间 A：
    - 房主 A 通过 [`joinChannelExByToken`](https://docportal.shengwang.cn/cn/live-streaming-premium-4.x/API%20Reference/ios_ng/API/toc_multi_channel.html#api_irtcengineex_joinchannelex) 加入频道 B，并且设置订阅频道 B 内音视频流，但不发送音视频流。同时通过 [`setupRemoteVideoEx`](https://docportal.shengwang.cn/cn/live-streaming-premium-4.x/API%20Reference/ios_ng/API/toc_multi_channel.html#api_irtcengineex_setupremotevideoex) 渲染频道 B 中主播的视频。
    - 观众通过 `joinChannelEx` 加入频道 B，并且设置订阅频道 B 内音视频流，但不发送音视频流。同时通过 `setupRemoteVideoEx` 渲染频道 B 中主播的视频。
- 房间 B：
    - 房主 B 通过 `joinChannelEx` 加入频道 A，并且设置订阅频道 A 内音视频流，但不发送音视频流。同时通过 `setupRemoteVideoEx` 渲染频道 A 中主播的视频。
    - 观众通过 `joinChannelEx` 加入频道 A，并且设置订阅频道 A 内音视频流，但不发送音视频流。同时通过 `setupRemoteVideoEx` 渲染频道 A 中主播的视频。

完成这些逻辑后，观众可以同时接收频道 A 和 B 的音视频流，因此可以同时看到两个房间的房主。房主仅在自己的频道发流，在对方的频道内不发流仅收流，因此，房主可以（在对方频道）看到对方，达到连麦的效果。

结束 PK 连麦时，房间内用户都需要调用 [`leaveChannelEx`](https://docportal.shengwang.cn/cn/live-streaming-premium-4.x/API%20Reference/ios_ng/API/toc_multi_channel.html#api_irtcengineex_leavechannelex) 离开对方频道。


![](https://web-cdn.agora.io/docs-files/1688633733256)

```swift
// 加入对方频道
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


// 退出对方频道
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

### 6. 观众连麦

观众与主播连麦时，你可以通过信令让主播邀请观众连麦，或观众向主播申请连麦。让待上麦观众更新频道媒体选项、预览并设置本地视图。让其他用户收到观众连麦通知后，渲染该连麦观众的视频。完成这些逻辑后，直播间内观众可以看到主播和上麦观众的连麦直播。

结束连麦时，你需要让待下麦观众更新频道媒体选项、停止预览并取消本地试图。让其他用户收到该观众下麦通知后，取消渲染该观众的视频。完成这些逻辑后，直播间观众可以看到仅有主播的直播画面。

本节展示观众连麦和结束连麦时更新频道媒体选项、设置视图的示例代码。通过 [`updateChannelExWithMediaOptions`](https://docportal.shengwang.cn/cn/live-streaming-premium-4.x/API%20Reference/ios_ng/API/toc_multi_channel.html#api_irtcengineex_updatechannelmediaoptionsex) 方法在观众加入频道后更新频道媒体选项，例如是否开启本地音频采集，是否发布本地音频流等。观众的用户角色为 `audience`，因此无法在频道内发布音频流。如果观众想与主播连麦，需要将用户角色修改为 `broadcaster`。

![](https://web-cdn.agora.io/docs-files/1688633742612)

```swift
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

### 7. 离开并销毁房间

直播结束时，主播和观众离开房间，你可以离开频道并销毁 RTC 引擎。

本节展示调用 [`destroy`](https://docportal.shengwang.cn/cn/live-streaming-premium-4.x/API%20Reference/ios_ng/API/toc_core_method.html#api_irtcengine_release) 销毁 RTC 引擎的示例代码。

![](https://web-cdn.agora.io/docs-files/1688633750502)

```swift
// ShowAgoraKitManager.swift
deinit {
    AgoraRtcEngineKit.destroy()
    showLogger.info("deinit-- ShowAgoraKitManager")
}
```

### API 时序图

下图展示实现本文全部流程所需的 API 调用时序。

![](https://web-cdn.agora.io/docs-files/1688633675704)