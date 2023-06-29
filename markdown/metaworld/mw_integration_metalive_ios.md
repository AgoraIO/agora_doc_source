# 客户端实现 (iOS)

本文介绍如何实现元直播。

## 示例项目 //TODO fragment-1

声网在 GitHub 上提供一个开源的 [MetaWorld 示例项目](https://github.com/AgoraIO-Community/Agora-MetaWorld/tree/dev_metasdk1.0) 供你参考。

## 实现元直播

完成[集成声网 Meta SDK](./mw_integrate_sdk_ios) 后，你可以参考本节实现元直播。

实现流程中需要用到声网 SDK 的以下接口类：

- `AgoraRtcEngineKit` 类：提供实时音视频功能。
- `AgoraMetaServiceKit` 类：Meta SDK 所有接口的入口，用于创建 `AgoraMetaScene` 对象，负责获取、下载和删除场景资源。
- `AgoraMetaScene` 类：负责进出场景、场景视频渲染、场景相关参数设置等场景相关操作。
- `AgoraMetaLocalUserAvatar` 类：用于设置用户昵称、徽章、Avatar 模型、捏脸换装等详细信息。
- `AgoraMetaEventDelegate` 类：`AgoraMetaServiceKit` 的异步方法的事件回调类。
- `AgoraMetaSceneEventDelegate` 类：`AgoraMetaScene` 的异步方法的事件回调类。

元直播的 API 调用时序见下图：

![](https://web-cdn.agora.io/docs-files/1687685321495)

### 1. 初始化 RTC 引擎和 Meta 服务

在创建元直播场景前，你需要创建并初始化 RTC 引擎和 Meta 服务。

- 调用 `sharedEngine` 创建并初始化 `AgoraRtcEngineKit` 对象：

    ```swift
    func createRtcEngine() {
        guard let token = KeyCenter.RTM_TOKEN else { return }
        // 配置 AgoraRtcEngineKit
        let rtcEngineConfig = AgoraRtcEngineConfig()
        rtcEngineConfig.appId = KeyCenter.APP_ID // 声网签发的 App ID
        rtcEngineConfig.areaCode = .global
        // 创建和初始化 AgoraRtcEngineKit 对象
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
    ```

- 调用 `sharedMetaServiceWithConfig` 创建并初始化 `AgoraMetaServiceKit` 对象。调用 `sharedMetaServiceWithConfig` 时，你需要在 `AgoraMetaServiceConfig` 中设置如下参数：
    - `appId`：从声网控制台获取的 App ID。
    - `rtmToken` ：用于登录声网 RTM 系统的动态密钥。开启动态鉴权后可用。集成及测试阶段请将 `token` 设置为 `nil`。详见[使用 RTM Token 鉴权](https://docportal.shengwang.cn/cn/Real-time-Messaging/token2_server_rtm?platform=All%20Platforms)。
    //TODO: Meta SDK 现在用的应该是 RTM 1.x，我先给了个 1.x 的链接，后面升级了再改成 2.x 的
    - `userId`：登录声网 RTM 系统的用户 ID。该字符串不可超过 64 字节。可以通过以下方式和声网 RTC 用户 ID 绑定：
        - （推荐）使用 Int 型的 RTC 用户 ID，RTM 用户 ID 设为相同的数字字符串。
        - 使用 String 型的 RTC 用户 ID，RTM 用户 ID 设为相同的字符串。
        - 使用 Int 型的 RTC 用户 ID，RTM 用户 ID 设为不同的数字字符串，并且自行维护二者的映射关系。
    - `delegate`：`AgoraMetaServiceKit` 的异步回调事件。
    - `localDownloadPath` ：场景资源下载到本地的保存路径。
    - `rtcEngine`：`AgoraRtcEngineKit` 实例.

    ```swift
    func createMetaService(userName: String, avatarUrl: String, delegate: AgoraMetaEventDelegate?) {
        playerName = userName

        currentUserInfo = AgoraMetaUserInfo.init()
        currentUserInfo?.userId = KeyCenter.RTM_UID
        currentUserInfo?.userName = userName
        currentUserInfo?.userIconUrl = avatarUrl

        // 配置 AgoraMetaServiceKit
        let metaServiceConfig = AgoraMetaServiceConfig()
        metaServiceConfig.appId = KeyCenter.APP_ID // 声网签发的 App ID
        metaServiceConfig.rtmToken = KeyCenter.RTM_TOKEN ?? "" // RTM token
        metaServiceConfig.userId = KeyCenter.RTM_UID // RTM 用户 ID
        metaServiceConfig.delegate = delegate // AgoraMetaServiceKit 的异步回调接口类

        let paths = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)
        metaServiceConfig.localDownloadPath = paths.first! // 场景资源的本地下载路径
        metaServiceConfig.rtcEngine = rtcEngine // RTC 引擎
        // 创建和初始化 AgoraMetaServiceKit 对象
        metaService = AgoraMetaServiceKit.sharedMetaServiceWithConfig(_: metaServiceConfig)
    }
    ```

### 2. 获取并下载场景资源

初始化完成后，请参考如下代码调用 `getSceneAssetsInfo` 和 `downloadSceneAssets` 获取并下载场景资源。

```swift
// 获取场景资源信息
metaService?.getSceneAssetsInfo()
// 获取场景资源信息回调
func onGetSceneAssetsInfoResult(_ scenes: NSMutableArray, errorCode: Int)

// 下载场景资源信息
metaService?.downloadSceneAssets(_ sceneId: Int)
// 下载场景资源信息回调
func onDownloadSceneAssetsProgress(_ sceneId: Int, progress: Int, state: AgoraMetaDownloadStateType)

// 取消下载场景资源信息 (按需调用)
metaService?.cancelDownloadSceneAssets(_ sceneId: Int)
```

### 3. 创建元直播场景

搭建元直播首先需要调用 `createScene` 创建场景。为增加直播趣味性，声网推荐你开启面部捕捉，使用同步人脸表情的 Avatar 形象。你需要在 `AgoraMetaSceneConfig` 中设置 `enableFaceCapture` 为 `true`，并在 `faceCaptureAppId` 和 `faceCaptureCertificate` 中传入面部捕捉插件的 ID 和 Key。

```swift
func createScene(_ delegate: MetaChatSceneViewController) {
    // 配置场景信息
    let config = AgoraMetaSceneConfig()
    config.delegate = delegate // AgoraMetaScene 的异步回调接口类
    config.enableFaceCapture = true // 支持面部捕捉
    config.faceCaptureCertificate = KeyCenter.FACE_CAPTURE_CERTIFICATE // 传入面部捕捉插件
    config.faceCaptureAppId = KeyCenter.FACE_CAPTURE_APP_ID // 传入面部捕捉插件
    // 创建场景
    metaService?.createScene(config)
}

// 创建场景回调
func onCreateSceneResult(_ scene: AgoraMetaScene?, errorCode: Int) {
    if errorCode != 0 {
        print("create scene error: \(errorCode)")
        return
    }

    metaScene = scene
    DispatchQueue.main.async {
        // 创建渲染视图
        guard let view = scene?.createRenderView(CGRect(x: 0, y: 0, width: width, height: height)) else { return }
        rtcEngine?.enableVideo()
    }
}
```

### 4. 设置用户信息并进入场景

进入场景之前，你可以先设置好用户的基本信息、模型信息、装扮和捏脸信息等。如下示例代码展示设置用户信息后进入场景：

- 调用 `setUserInfo` 设置用户基本信息。
- 调用 `setModelInfo` 设置模型信息。
- 调用 `setExtraInfo` 设置自定义信息，此处设置了用户的捏脸和换装信息。
- 调用 `enterScene` 进入场景。

```swift
func enterScene(view: UIView) {
    guard let sceneInfo = currentSceneInfo else {
        return
    }
    // 设置 avatar 模型信息
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
    // 配置进入场景信息
    let enterSceneConfig = AgoraMetaEnterSceneConfig()
    enterSceneConfig.roomName = KeyCenter.CHANNEL_ID // 场景的频道名
    enterSceneConfig.sceneView = view // 场景的渲染视图，iOS 上使用调用 createRenderView 创建的场景视图
    enterSceneConfig.sceneId = sceneInfo.sceneId // 场景 ID
    // 示例项目中，sceneIndex 的 0 为元直播场景，1 为元语聊场景，在实际场景中，你可以根据业务需求调整自定义扩展信息
    let dict = ["sceneIndex": kSceneIndex.rawValue]
    let data = try? JSONSerialization.data(withJSONObject: dict, options: [])
    let extraInfo = String(data: data!, encoding: String.Encoding.utf8)
    enterSceneConfig.extraInfo = extraInfo!.data(using: String.Encoding.utf8)
    localUserAvatar = metaScene?.getLocalUserAvatar()
    // 设置场景中展示的用户信息
    localUserAvatar?.setUserInfo(currentUserInfo)
    // 设置用户的 avatar 模型信息
    localUserAvatar?.setModelInfo(avatarInfo)
    // 设置用户的自定义捏脸、换装信息
    let dict = ["avatar": "girl", "dress": [10000, 10100], "face": [["key": "eyeBlink_L", "val": 30] as [String : Any]], "2dbg": ""] as [String : Any]
    let data = try? JSONSerialization.data(withJSONObject: dict, options: [])
    let extraInfo = String(data: data!, encoding: String.Encoding.utf8)
    localUserAvatar?.setExtraInfo(extraInfo!.data(using: String.Encoding.utf8))
    // 进入场景
    metaScene?.enter(enterSceneConfig)
}

// 进入场景后回调
func metaScene(_ scene: AgoraMetaScene, onEnterSceneResult errorCode: Int) {}
```

<div class="alert note"><ul><li>本小节展示在<b>进入场景前</b>设置用户和模型信息，如需在<b>进入场景后</b>变更设置，需调用 <code>applyInfo</code> 使设置生效。</li><li>声网 Meta SDK 支持自定义装扮捏脸功能，详见 //TODO: 待链接。</li></ul></div>


### 5. 加入频道并开启元直播

进入场景后，你需要将主播端 Avatar 形象的视频流发布到 RTC 频道中，使 3D 场景中的用户都能看到直播：

- 调用 `enableVideoCapture` 开启场景渲染画面捕获，开启对主播 Avatar 形象的视频采集；`enable` 设置为 `true`，把场景画面和 Avatar 形象发布到频道；`enable` 设置为 `false`，把摄像头采集的主播真人画面发布到频道。
- 调用 `joinChannel` 使主播加入 RTC 频道。

<div class="alert note">发送 Avatar 视频前，请确保 <code>AgoraMetaSceneConfig</code> 中已设置开启面部捕捉。</div>

```swift
func joinRtcChannel(success: @escaping () -> Void) {
        rtcEngine?.joinChannel(byToken: KeyCenter.RTC_TOKEN, channelId: KeyCenter.CHANNEL_ID, info: nil, uid: KeyCenter.RTC_UID, joinSuccess: { String, UInt, Int in
        DLog("joinChannel 回调 ======= ",String,UInt,Int)
        success()
    })
}

// Swift 中的 enableVideoCapture 对应 Objective-C API 中的 enableSceneVideoCapture
scene?.enableVideoCapture(view!, enable: true)
```

### 6. 离开频道并释放资源

直播结束时，你可以离开频道并释放资源。

```swift
private func leaveScene() {
    // 退出频道
    rtcEngine?.leaveChannel()
    // 离开场景
    metaScene?.leave()
}
// 离开场景回调
func metaScene(_ scene: AgoraMetaScene, onLeaveSceneResult errorCode: Int) {
    // 销毁场景
    metaScene?.destroy()
    metaScene = nil
}
// 销毁场景回调
func metaScene(_ scene: AgoraMetaScene, onReleasedScene errorCode: Int) {
    // 销毁 AgoraMetaServiceKit
    AgoraMetaServiceKit.destroy()
    metaService = nil
    // 销毁 AgoraRtcEngineKit
    AgoraRtcEngineKit.destroy()
    rtcEngine = nil
}
```