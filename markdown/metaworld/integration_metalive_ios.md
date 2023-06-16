# 客户端实现 (iOS)

本文介绍如何实现元直播。

## 示例项目

声网在 [Agora-MetaWorld](https://github.com/AgoraIO-Community/Agora-MetaWorld/) 仓库的 `dev_metasdk1.0` 分支提供[元直播](https://github.com/AgoraIO-Community/Agora-MetaWorld/tree/dev_metasdk1.0/ios)源代码供你参考。

## 开通 Meta 服务

### 创建声网项目

1. 进入声网控制台的[项目管理](https://console.agora.io/projects)页面。

2. 在项目管理页面，点击**创建**按钮。

3. 在弹出的对话框内输入项目名称、使用场景，然后选择**安全模式：** **APP ID + Token**。

4. 点击**提交**按钮。新建的项目会显示在项目管理页中。

### 获取 ID 及证书

1. 创建项目后，从控制台获取声网项目的 [App ID](https://docportal.shengwang.cn/cn/Agora%20Platform/get_appid_token?platform=All%20Platforms#获取-app-id) 和 [App 证书](https://docportal.shengwang.cn/cn/Agora%20Platform/get_appid_token?platform=All%20Platforms#获取-app-证书)。

2. 联系 [sales@agora.io](mailto:sales@agora.io) 并供你的声网项目 App ID，用于开通声网内容中心的权限并获取声网面捕插件。

## 准备开发环境

### 前提条件

- [Git](https://git-scm.com/downloads)
- [Xcode](https://apps.apple.com/cn/app/xcode/id497799835?mt=12) 12.0 及以上
- iOS 设备，版本 11.0 及以上
    <div class="alert note">声网推荐使用真机运行项目。部分模拟机可能存在功能缺失或者性能问题。</div>
- 有效的苹果开发者账号

### 创建项目

在 Xcode 中进行以下操作，在你的 app 中实现元直播功能：

1. [创建一个新的项目](https://help.apple.com/xcode/mac/current/#/dev07db0e578)，**Application** 选择 **App**，**Interface** 选择 **Storyboard**，**Language** 选择 **Swift**。

    <div class="alert note">如果你没有添加过开发团队信息，会看到 <b>Add account…</b> 按钮。点击该按钮并按照屏幕提示登入 Apple ID，点击 <b>Next</b>，完成后即可选择你的 Apple 账户作为开发团队。</div>

2. 为你的项目设置[自动签名](https://help.apple.com/xcode/mac/current/#/dev23aab79b4)。

3. 设置部署你的 app 的[目标设备](https://help.apple.com/xcode/mac/current/#/deve69552ee5)。

4. 添加项目的设备权限。在项目导航栏中打开 `info.plist` 文件，编辑[属性列表](https://help.apple.com/xcode/mac/current/#/dev3f399a2a6)，添加以下属性：

    | key   | type   | value   |
    | ------------------- | ------ | ------------------------------------------------------------ |
    | Privacy - Microphone Usage Description | String | 使用麦克风的目的，例如 for a live interactive streaming |
    | Privacy - Camera Usage Description       | String | 使用摄像头的目的，例如 for a live interactive streaming |

    <div class="alert note"><ul><li>如果你的项目中需要添加第三方插件或库（例如第三方摄像头），且该插件或库的签名与项目的签名不一致，你还需勾选 <b>Hardened Runtime</b> > <b>Runtime Exceptions</b> 中的 <b>Disable Library Validation</b>。</li><li>更多注意事项，可以参考 <a href="https://developer.apple.com/documentation/xcode/preparing_your_app_for_distribution">Preparing Your App for Distribution</a >。</li></ul></div>

5. 将 Meta SDK 集成到你的项目中。

    1. 联系 [sales@agora.io](mailto:sales@agora.io) 获取 Meta SDK，下载并解压。
    2. 将 SDK 包内 `libs` 及路径下的文件，拷贝到你的项目路径下。
    3. 打开 Xcode，[添加对应动态库](https://help.apple.com/xcode/mac/current/#/dev51a648b07)，确保添加的动态库 **Embed** 属性设置为 **Embed & Sign**。

<div class="alert note"><li>根据 Apple 官方要求，app 的 Extension 中不允许包含动态库。如果项目中的 Extension 需要集成 SDK，则添加动态库时需将文件状态改为 <b>Do Not Embed</b>。</li><li>声网 SDK 默认使用 libc++ (LLVM)，如需使用 libstdc++ (GNU)，请联系 <a href="mailto:sales@agora.io">sales@agora.io</a>。SDK 提供的库是 FAT Image，包含 32/64 位模拟器、32/64 位真机版本。</li></div>

6. 除 SDK 外，你还需要添加以下依赖库：

    1. 添加 [OpenSSL](https://www.openssl.org/source/) 依赖库 `libcrypto.a` 和 `libssl.a`。
    2. 添加 `libz.tbd` 依赖库。

    ![](https://web-cdn.agora.io/docs-files/1686901281260)


## 实现元直播

本节介绍在集成 Meta SDK 后，如何实现元直播的核心业务模块的功能。

实现流程中需要用到声网 SDK 的以下接口类：

- `AgoraRtcEngineKit` 类：提供实时音视频功能。
- `AgoraMetaServiceKit` 类：Meta SDK 所有接口的入口，用于创建 `AgoraMetaScene` 对象，负责获取、下载和删除场景资源。
- `AgoraMetaScene` 类：负责进出场景、场景视频渲染、场景相关参数设置等场景相关操作。
- `AgoraLocalUserAvatar` 类：用于设置用户昵称、徽章、Avatar 模型、捏脸换装等详细信息。
- `AgoraMetaEventDelegate` 类：`AgoraMetaServiceKit` 的异步方法的事件回调类。
- `AgoraMetaSceneEventDelegate` 类：`AgoraMetaScene` 的异步方法的事件回调类。

![](https://web-cdn.agora.io/docs-files/1686901281260)

### 1. 初始化

在创建元直播场景前，你需要创建并初始化 RTC 引擎和 Meta 服务。本节展示调用 `sharedEngine` 初始化 `AgoraRtcEngineKit` 对象和调用 `sharedMetaServiceWithConfig` 初始化 `AgoraMetaServiceKit` 对象的示例代码。

```swift
// 创建并初始化 RTC 引擎
func createRtcEngine() {
    guard let token = KeyCenter.RTM_TOKEN else { return }
    // 配置 AgoraRtcEngineConfig 并设置 App ID
    let rtcEngineConfig = AgoraRtcEngineConfig()
    rtcEngineConfig.appId = KeyCenter.APP_ID
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

```swift
// 创建并初始化 Meta 服务
func createMetaService(userName: String, avatarUrl: String, delegate: AgoraMetaEventDelegate?) {
    playerName = userName
            
    currentUserInfo = AgoraMetaUserInfo.init()
    currentUserInfo?.userId = KeyCenter.RTM_UID
    currentUserInfo?.userName = userName
    currentUserInfo?.userIconUrl = avatarUrl
    
    // 配置 AgoraMetaServiceConfig 并设置 App ID、RTM Token、RTM UID 和回调接口
    let metaServiceConfig = AgoraMetaServiceConfig()
    metaServiceConfig.appId = KeyCenter.APP_ID
    metaServiceConfig.rtmToken = KeyCenter.RTM_TOKEN ?? ""
    metaServiceConfig.userId = KeyCenter.RTM_UID
    metaServiceConfig.delegate = delegate
    
    // 设置场景资源的本地下载路径和 RTC 引擎
    let paths = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)
    metaServiceConfig.localDownloadPath = paths.first!
    metaServiceConfig.rtcEngine = rtcEngine
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
 
// 取消下载场景资源信息
metaService?.cancelDownloadSceneAssets(_ sceneId: Int)
```

### 3. 创建元直播场景

搭建元直播首先需要调用 `createScene` 创建场景。

```swift
func createScene(_ delegate: MetaChatSceneViewController) {
    // 场景配置信息
    let config = AgoraMetaSceneConfig()
    config.delegate = delegate
    // 支持面部捕捉
    config.enableFaceCapture = true
    // 传入面部捕捉 Certificate
    config.faceCaptureCertificate = KeyCenter.FACE_CAPTURE_CERTIFICATE
    // 传入面部捕捉 App ID
    config.faceCaptureAppId = KeyCenter.FACE_CAPTURE_APP_ID
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
        // 启用视频功能
        rtcEngine?.enableVideo()
    }
}
```

### 4. 设置用户信息并进入场景

进入场景之前，你可以先设置好用户的基本信息、模型信息、装扮信息、捏脸信息等。

```swift
func enterScene(view: UIView) {
    guard let sceneInfo = currentSceneInfo else {
        return
    }
    // 设置avatar模型信息
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
    // 设置进入场景信息
    let enterSceneConfig = AgoraMetaEnterSceneConfig()
    enterSceneConfig.roomName = KeyCenter.CHANNEL_ID
    // 该view为场景场合后创建的renderView
    enterSceneConfig.sceneView = view
    enterSceneConfig.sceneId = sceneInfo.sceneId
    // sceneIndex目前0为元直播场景，1为元语聊场景
    let dict = ["sceneIndex": kSceneIndex.rawValue]
    let data = try? JSONSerialization.data(withJSONObject: dict, options: [])
    let extraInfo = String(data: data!, encoding: String.Encoding.utf8)
    enterSceneConfig.extraInfo = extraInfo!.data(using: String.Encoding.utf8)
    // 设置avatar信息
    localUserAvatar = metaScene?.getLocalUserAvatar()
    localUserAvatar?.setUserInfo(currentUserInfo)
    localUserAvatar?.setModelInfo(avatarInfo)
    // avatar装扮信息
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

进入场景后，你需要调用 `enableSceneVideoCapture` 开启场景渲染画面捕获，并调用 `joinChannel` 加入频道并把场景渲染的画面发布到 RTC 频道内。

```swift
func joinRtcChannel(success: @escaping () -> Void) {
        rtcEngine?.joinChannel(byToken: KeyCenter.RTC_TOKEN, channelId: KeyCenter.CHANNEL_ID, info: nil, uid: KeyCenter.RTC_UID, joinSuccess: { String, UInt, Int in
        DLog("joinChannel 回调 ======= ",String,UInt,Int)
        success()
    })
}

```

//TODO: 话说这里为啥没用到 `enableSceneVideoCapture`，swift和oc api name 的区别，以及 true 和 false 的设置

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