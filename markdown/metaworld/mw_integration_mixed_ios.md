本文介绍如何实现元语聊和元直播的融合场景。

## 示例项目

声网在 GitHub 上提供开源 [Agora-MetaWorld](https://github.com/AgoraIO-Community/Agora-MetaWorld/tree/dev_metasdk1.0) 示例项目供你参考。

如果你还需了解 Unity 部分的工程文件和功能指南，请联系 [sales@agora.io](mailto:sales@agora.io) 获取。

## 实现元语聊和元直播融合场景

完成[集成声网 Meta SDK](./mw_integrate_sdk_ios) 后，你可以参考本节实现元语聊和元直播的融合场景。

下图展示实现元语聊和元直播融合场景的 API 调用时序：

![](https://web-cdn.agora.io/docs-files/1688613004099)

实现步骤需用到如下类：

- `AgoraRtcEngineKit` 类：提供实时音视频功能的核心类。
- `AgoraMetaServiceKit` 类：提供 Meta 服务的核心类。可用于获取场景资源列表、下载场景资源、删除本地场景资源等场景资源管理，还可用于创建 `AgoraMetaScene`。
- `AgoraMetaScene` 类：场景资源相关操作。
- `AgoraMetaLocalUserAvatar` 类：包含在 `AgoraMetaScene` 中，生命周期和 `AgoraMetaScene` 相同，用于设置虚拟形象（Avatar）。
- `AgoraMetaEventDelegate` 类：`AgoraMetaServiceKit` 的异步方法的事件回调类。
- `AgoraMetaSceneEventDelegate` 类：`AgoraMetaScene` 的异步方法的事件回调类。

### 1. 初始化 RTC 引擎和 Meta 服务

调用 [`sharedEngineWithConfig`](https://docportal.shengwang.cn/cn/live-streaming-premium-4.x/API%20Reference/ios_ng/API/toc_core_method.html#api_irtcengine_initialize) 创建 `AgoraRtcEngineKit`。调用 [`sharedMetaServiceWithConfig`](./mw_api_ref_ios?platform=All%20Platforms#sharedmetaservicewithconfig) 创建并初始化 `AgoraMetaServiceKit`。

初始化 `AgoraMetaServiceKit` 时，需要在 `AgoraMetaServiceConfig` 里设置如下重要的字段：
- `rtcEngine`：通过 `sharedEngineWithConfig` 方法创建的 `AgoraRtcEngineKit` 实例。
- `appId`：在声网控制台获取的 App ID。详见[集成声网 Meta SDK](./mw_integrate_sdk_ios)。
- `userId`：登录声网 RTM 系统的用户 ID。推荐取值详见 [API 参考](./mw_api_ref_ios?platform=All%20Platforms#agorametaserviceconfig)。
- `rtmToken`：用于登录声网 RTM 系统的动态密钥。开启动态鉴权后可用。详见[生成 Token](https://docportal.shengwang.cn/cn/Real-time-Messaging/messaging_ios?platform=iOS#4-生成-token)。
- `localDownloadPath`：场景资源下载到本地的保存路径。
- `delegate`：`AgoraMetaServiceKit` 的回调事件。

声网项目有两种 Token 和 UID，请不要搞混淆：
- RTC UID：用于在实时音视频通讯中标志用户身份的用户 ID。推荐取值详见 [joinChannelByToken 的参数解释](https://docportal.shengwang.cn/cn/live-streaming-premium-4.x/API%20Reference/ios_ng/API/toc_core_method.html#api_irtcengine_joinchannel)。
- RTM UID：用于在云信令系统中标志用户身份的用户 ID。推荐取值详见 [AgoraMetaServiceConfig 的字段解释](./mw_api_ref_ios?platform=All%20Platforms#agorametaserviceconfig)。
- RTC Token：用于保障实时音视频通讯安全的动态密钥。详见[如何生成 RTC Token 进行鉴权](https://docportal.shengwang.cn/cn/live-streaming-premium-4.x/token_server_ios_ng?platform=iOS)。
- RTM Token：用于保障云信令系统安全的动态密钥。详见[如何生成 RTM Token 进行鉴权](https://docportal.shengwang.cn/cn/Real-time-Messaging/token2_server_rtm?platform=All%20Platforms)。

```swift
func createRtcEngine() {
    guard let token = KeyCenter.RTM_TOKEN else { return }
    // 设置 AgoraRtcEngineKit 配置信息
    let rtcEngineConfig = AgoraRtcEngineConfig()
    // 声网项目的 App ID，从控制台获取
    rtcEngineConfig.appId = KeyCenter.APP_ID
    rtcEngineConfig.areaCode = .global
    // 创建和初始化 AgoraRtcEngineKit
    rtcEngine = AgoraRtcEngineKit.sharedEngine(with: rtcEngineConfig, delegate: self)

    rtcEngine?.setVideoFrameDelegate(self)
    rtcEngine?.setParameters("{\"rtc.audio.force_bluetooth_a2dp\": true}")
    // 设置频道为直播模式
    rtcEngine?.setChannelProfile(.liveBroadcasting)
    // 设置角色为主播
    rtcEngine?.setClientRole(.broadcaster)
    // 设置视频编码属性
    let vec = AgoraVideoEncoderConfiguration(size: resolution!, frameRate: .fps30, bitrate: AgoraVideoBitrateStandard, orientationMode: .adaptative, mirrorMode: .enabled)
    rtcEngine?.setVideoEncoderConfiguration(vec)
}

func createMetaService(userName: String, avatarUrl: String, delegate: AgoraMetaEventDelegate?) {
    playerName = userName

    currentUserInfo = AgoraMetaUserInfo.init()
    currentUserInfo?.userId = KeyCenter.RTM_UID
    currentUserInfo?.userName = userName
    currentUserInfo?.userIconUrl = avatarUrl

    // 设置 AgoraMetaServiceKit 配置信息
    let metaServiceConfig = AgoraMetaServiceConfig()
    // 声网项目的 App ID，从控制台获取
    metaServiceConfig.appId = KeyCenter.APP_ID
    // 声网 RTM（云信令）Token，保障安全
    // 声网项目有 RTC Token 和 RTM Token，不要搞混淆
    metaServiceConfig.rtmToken = KeyCenter.RTM_TOKEN ?? ""
    // 声网 RTM（云信令）UID，用户 ID，标志用户身份
    // 声网项目有 RTC UID 和 RTM UID，不要搞混淆
    metaServiceConfig.userId = KeyCenter.RTM_UID
    metaServiceConfig.delegate = delegate

    let paths = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)
    // 设置场景资源的下载路径
    metaServiceConfig.localDownloadPath = paths.first!
    // RtcEngine 实例
    metaServiceConfig.rtcEngine = rtcEngine
    // 创建和初始化 AgoraMetaServiceKit
    metaService = AgoraMetaServiceKit.sharedMetaServiceWithConfig(_: metaServiceConfig)
}
```

### 2. 获取并下载场景资源

调用 `AgoraMetaServiceKit` 类的 [`getSceneAssetsInfo`](./mw_api_ref_ios?platform=All%20Platforms#getsceneassetsinfo) 获取场景资源，并通过 `AgoraMetaEventDelegate` 类的 [`onGetSceneAssetsInfoResult`](./mw_api_ref_ios?platform=All%20Platforms#ongetsceneassetsinforesult) 回调监听获取场景资源时的事件。

调用 `AgoraMetaServiceKit` 类的 [`downloadScene`](./mw_api_ref_ios?platform=All%20Platforms#downloadscene) 获取场景资源，并通过 `AgoraMetaEventDelegate` 类的 [`onDownloadSceneAssetsProgress`](./mw_api_ref_ios?platform=All%20Platforms#ondownloadsceneassetsprogress) 回调监听获取场景资源时的事件。

```swift
// 判断是否下载场景资源
metaService?.isSceneAssetsDownloaded(_ sceneId: Int)

// 获取场景资源
metaService?.getSceneAssetsInfo()

// 监听获取场景资源的回调事件
func onGetSceneAssetsInfoResult(_ scenes: NSMutableArray, errorCode: Int)

// 下载场景资源
metaService?.downloadSceneAssets(_ sceneId: Int)

// 监听下载场景资源的回调事件
func onDownloadSceneAssetsProgress(_ sceneId: Int, progress: Int, state: AgoraMetaDownloadStateType)
```

### 3. 创建场景

调用 `AgoraMetaServiceKit` 类的 [`createScene`](./mw_api_ref_ios?platform=All%20Platforms#createscene) 创建 `AgoraMetaScene`，并在 `AgoraMetaSceneConfig` 中设置场景配置信息。为增加直播趣味性，声网推荐你开启面部捕捉，使用同步人脸表情的 Avatar 形象。你需要在 `AgoraMetaSceneConfig` 中设置 `enableFaceCapture` 为 `true`，并在 `faceCaptureAppId` 和 `faceCaptureCertificate` 中传入面部捕捉插件的 ID 和 Key。

通过 `AgoraMetaEventDelegate` 类的 [`onCreateSceneResult`](./mw_api_ref_ios?platform=All%20Platforms#oncreatesceneresult) 和 [`onConnectionStateChanged`](./mw_api_ref_ios?platform=All%20Platforms#onconnectionstatechanged) 回调监听创建场景和连接状态的事件。

```swift
func createScene(_ delegate: MetaChatSceneViewController) {
    // 配置场景信息
    let config = AgoraMetaSceneConfig()
    config.delegate = delegate
    // 设置是否开启面部捕捉
    // 融合场景中，建议开启面部捕捉
    config.enableFaceCapture = true
    // 传入面部捕捉插件的 App ID 和 Certificate
    config.faceCaptureCertificate = KeyCenter.FACE_CAPTURE_CERTIFICATE
    config.faceCaptureAppId = KeyCenter.FACE_CAPTURE_APP_ID
    // 创建场景
    metaService?.createScene(config)
}

// 监听创建场景的回调事件
func onCreateSceneResult(_ scene: AgoraMetaScene?, errorCode: Int) {
    if errorCode != 0 {
        print("create scene error: \(errorCode)")
        return
    }

    metaScene = scene
    DispatchQueue.main.async {
        // 创建场景渲染所需的视图
        guard let view = scene?.createRenderView(CGRect(x: 0, y: 0, width: width, height: height)) else { return }
        // 开启视频模块
        rtcEngine?.enableVideo()
    }
}

// 监听连接状态
func onConnectionStateChanged(_ state: AgoraMetaConnectionStateType, reason: AgoraMetaConnectionChangedReasonType) {
    if state == .disconnected {
        // 一些处理操作，详见源代码
        ......
    } else if state == .aborted {
        // 一些处理操作，详见源代码
        ......
    }
}
```

### 4. 设置用户信息并进入场景

要完成进入场景的操作，参考如下步骤：
1. 调用 `AgoraMetaLocalUserAvatar` 类的 [`setUserInfo`](./mw_api_ref_ios?platform=All%20Platforms#setuserinfo) 和 [`setModelInfo`](./mw_api_ref_ios?platform=All%20Platforms#setmodelinfo) 设置用户的基本信息和虚拟形象（Avatar）的模型信息。
2. 调用 `AgoraMetaLocalUserAvatar` 类的 [`setExtraInfo`](./mw_api_ref_ios?platform=All%20Platforms#setextrainfo) 设置用户的捏脸、换装信息。
3. 调用 `AgoraMetaScene` 类的 [`enterScene`](./mw_api_ref_ios?platform=All%20Platforms#enterscene) 进入场景，并通过 `config` 设置配置信息。
4. 通过 `AgoraMetaSceneEventDelegate` 类的 [`onEnterSceneResult`](./mw_api_ref_ios?platform=All%20Platforms#onentersceneresult) 回调监听进入场景的结果。

```swift
func enterScene(view: UIView) {
    guard let sceneInfo = currentSceneInfo else {
        return
    }
    // 用户的虚拟形象模型信息
    let avatarInfo = AgoraMetaAvatarModelInfo.init()
    for info in sceneInfo.bundles {
        if info.bundleType == .avatar {
            avatarInfo.bundleCode = info.bundleCode;
            break
        }
    }
    avatarInfo.localVisible = true
    avatarInfo.remoteVisible = true
    avatarInfo.syncPosition = true

    // 设置进入场景时的配置信息
    let enterSceneConfig = AgoraMetaEnterSceneConfig()
    enterSceneConfig.roomName = KeyCenter.CHANNEL_ID
    //  场景资源渲染时所需要的视图，从 createRenderView 创建获得
    enterSceneConfig.sceneView = view
    // 内容中心对应的 ID
    enterSceneConfig.sceneId = sceneInfo.sceneId
    // 设置加载场景资源时需要的额外自定义信息，只支持字符串
    // 在这里指设置 sceneIndex，取值 0 代表元直播场景，取值 1 代表元语聊场景
    // 在业务逻辑中包含多个场景的情况下，你可以用 sceneIndex 来区分不同的场景，Unity 场景脚本可以根据 sceneIndex 来确定进入哪个场景，并执行相应的逻辑
    let dict = ["sceneIndex": kSceneIndex.rawValue]
    let data = try? JSONSerialization.data(withJSONObject: dict, options: [])
    let extraInfo = String(data: data!, encoding: String.Encoding.utf8)
    enterSceneConfig.extraInfo = extraInfo!.data(using: String.Encoding.utf8)
    // 获得 localUserAvatar 对象
    localUserAvatar = metaScene?.getLocalUserAvatar()
    // 设置用户的基本信息
    localUserAvatar?.setUserInfo(currentUserInfo)
    // 设置用户的虚拟形象模型信息
    localUserAvatar?.setModelInfo(avatarInfo)
    // 设置用户的捏脸、换装信息
    let dict = ["avatar": "girl", "dress": [10000, 10100], "face": [["key": "eyeBlink_L", "val": 30] as [String : Any]], "2dbg": ""] as [String : Any]
    let data = try? JSONSerialization.data(withJSONObject: dict, options: [])
    let extraInfo = String(data: data!, encoding: String.Encoding.utf8)
    localUserAvatar?.setExtraInfo(extraInfo!.data(using: String.Encoding.utf8))
    // 进入场景
    metaScene?.enter(enterSceneConfig)
}

// 监听进入场景的回调事件
func metaScene(_ scene: AgoraMetaScene, onEnterSceneResult errorCode: Int) {}
```

<div class="alert note"><ul><li>本小节展示在<b>进入场景前</b>设置用户和模型信息，如需在<b>进入场景后</b>变更设置，需调用 <code>applyInfo</code> 使设置生效。</li><li>声网 Meta SDK 支持自定义装扮捏脸功能，详见 <a href="https://docportal.shengwang.cn/cn/metaworld/mw_dress_face_customization_ios">换装和捏脸</a>。</li></ul></div>


### 5. 加入频道并开启直播

进入场景后，你需要在场景中添加一个视图，将主播端 Avatar 形象的视频流发布到 RTC 频道中，使 3D 场景中的用户都能看到直播。参考如下步骤：
1. 调用 `AgoraRtcEngineKit` 类的 [`setupLocalVideo`](https://docportal.shengwang.cn/cn/video-call-4.x/API%20Reference/ios_ng/API/toc_video_process.html?platform=iOS#api_irtcengine_setuplocalvideo) 初始化本地视图，用于摄像头画面本地预览。
2. 调用 `AgoraRtcEngineKit` 类的 [`joinChannelByToken`](https://docportal.shengwang.cn/cn/video-call-4.x/API%20Reference/ios_ng/API/toc_core_method.html#api_irtcengine_joinchannel) 使主播加入 RTC 频道。
3. 调用 `AgoraMetaScene` 类的 [`addSceneView`](./mw_api_ref_ios?platform=All%20Platforms#addsceneview) 在场景中添加一个视图，用于在频道内发布主播的 Avatar 形象。
4. 通过 `AgoraMetaSceneEventDelegate` 类的 [`onAddSceneViewResult`](./mw_api_ref_ios?platform=All%20Platforms#onaddsceneviewresult) 回调监听添加场景显示视图的结果。
5. 调用 `AgoraMetaScene` 类的 [`enableSceneVideoCapture`](./mw_api_ref_ios?platform=All%20Platforms#enablescenevideocapture) 并将 `enable` 设置为 `true` 开启场景渲染画面捕获，发布主播的 Avatar 形象到 RTC 频道。

<div class="alert note">发送 Avatar 视频前，请确保 <code>AgoraMetaSceneConfig</code> 中已设置开启面部捕捉。</div>

```swift
func startPreview(_ view: UIView) {
    if canvas0 != nil {
        canvas0 = nil
    }
    // 创建 AgoraRtcVideoCanvas 对象，用于设置本地视频画面的显示属性
    canvas0 = AgoraRtcVideoCanvas()
    canvas0?.uid = KeyCenter.RTC_UID
    canvas0?.renderMode = .hidden
    canvas0?.view = view
    // 设置显示摄像头采集后的原始画面
    canvas0?.position = .postCaptureOrigin
    // 设置本地视频画面的参数，并开启本地视频预览
    rtcEngine?.setupLocalVideo(canvas0)
    rtcEngine?.startPreview()
}

// 加入频道
func joinRtcChannel(success: @escaping () -> Void) {
        // 传入声网 RTC Token、频道名和 UID
        rtcEngine?.joinChannel(byToken: KeyCenter.RTC_TOKEN, channelId: KeyCenter.CHANNEL_ID, info: nil, uid: KeyCenter.RTC_UID, joinSuccess: { String, UInt, Int in
        DLog("joinChannel 回调 ======= ",String,UInt,Int)
        success()
    })
}

// 在场景中添加一个新的视图，用于发布主播的 Avatar 形象
func addSceneView() {
    if avatarView == nil {
        guard let view = scene?.createRenderView(CGRect(x: 100, y: 100, width: 120, height: 120)) else { return }
        avatarView = view
    }
    avatarView?.layer.masksToBounds = true
    avatarView?.layer.cornerRadius = 10
    // 创建 AgoraMetaSceneDisplayConfig 对象，用于设置场景视图的宽度和高度
    let config = AgoraMetaSceneDisplayConfig()
    config.width = 200
    config.height = 200
    // 场景中添加view
    metaScene?.add(avatarView!, sceneDisplayConfig: config)
    // 开启场景渲染画面捕获
    // 默认为 false，即发送摄像头采集的视频画面，在融合场景中，建议设置为 true，把场景画面和主播的 Avatar 形象发布到频道
    // Swift 中的 enableVideoCapture 对应 Objective-C API 中的 enableSceneVideoCapture
    metaScene?.enableVideoCapture(avatarView!, enable: true)
}

// 监听添加场景显示视图的回调事件
func metaScene(_ scene: AgoraMetaScene, onAddSceneViewResult view: UIView, errorCode: Int) {
    print("====== addSceneViewResult ====== errorCode: ", errorCode)
}
```

### 6. 离开频道并释放资源

离开场景时，参考如下步骤：
1. 调用 `AgoraMetaScene` 类的 [`removeSceneView`](./mw_api_ref_ios?platform=All%20Platforms#removesceneview) 将 Avatar 直播画面从场景中移除。
2. 通过 `AgoraMetaSceneEventDelegate` 类的 [`onRemoveSceneViewResult`](./mw_api_ref_ios?platform=All%20Platforms#onremovesceneviewresult) 回调监听移除场景显示视图的结果。
3. 调用 `AgoraRtcEngineKit` 类的 [`leaveChannel`](https://docportal.shengwang.cn/cn/video-call-4.x/API%20Reference/ios_ng/API/toc_core_method.html#api_irtcengine_leavechannel) 离开直播频道。
4. 调用 `AgoraMetaScene` 类的 [`leaveScene`](./mw_api_ref_ios?platform=All%20Platforms#leavescene) 离开场景。
5. 通过 `AgoraMetaSceneEventDelegate` 类的 [`onLeaveSceneResult`](./mw_api_ref_ios?platform=All%20Platforms#onleavesceneresult) 回调得知成功离开场景后，调用 [`destroy`](./mw_api_ref_ios?platform=All%20Platforms#destroy-1) 释放 `AgoraMetaScene`。
6. 通过 `AgoraMetaSceneEventDelegate` 类的 [`onReleasedScene`](./mw_api_ref_ios?platform=All%20Platforms#onreleasedscene) 回调监听 `AgoraMetaScene` 是否释放成功。
7. 依次调用 `AgoraMetaServiceKit` 和 `AgoraRtcEngineKit` 类的 `destroy` 方法销毁 `AgoraMetaServiceKit` 和 `AgoraRtcEngineKit`。

```swift
// 移除场景显示视图，将 Avatar 直播画面从场景中移除
func removeSceneView() {
    guard let view = avatarView else { return }
    let scene = MetaServiceEngine.sharedEngine.metaScene
    scene?.remove(view)
    scene?.enableVideoCapture(view, enable: false)

    if let index = localVideoCV.items.firstIndex(where: { $0 as? UIView == view }) {
        localVideoCV.items.remove(at: index)
    }
    localVideoCV.collectionView.reloadData()
}

// 监听移除场景显示视图的回调事件
func metaScene(_ scene: AgoraMetaScene, onRemoveSceneViewResult view: UIView, errorCode: Int) {
    print("====== onRemoveSceneViewResult ====== errorCode: ", errorCode)
}

private func leaveScene() {
    // 退出频道
    rtcEngine?.leaveChannel()
    // 离开场景
    metaScene?.leave()
}

// 监听离开场景的回调事件
func metaScene(_ scene: AgoraMetaScene, onLeaveSceneResult errorCode: Int) {
    // 销毁场景
    metaScene?.destroy()
    metaScene = nil
}
// 监听释放 AgoraMetaScene 的回调事件
func metaScene(_ scene: AgoraMetaScene, onReleasedScene errorCode: Int) {
    // 销毁 AgoraMetaServiceKit
    AgoraMetaServiceKit.destroy()
    metaService = nil
    // 销毁 AgoraRtcEngineKit
    AgoraRtcEngineKit.destroy()
    rtcEngine = nil
}
```

## 参考信息

### 开发注意事项

使用 3D 场景的过程中，不能销毁调用 [`createRenderView`](./mw_api_ref_ios?platform=All%20Platforms#createrenderview) 创建的视图。该视图只有退出整个 app 时才能销毁。