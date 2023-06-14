# 客户端实现 (iOS)

本文介绍如何实现虚拟人直播。
## 示例项目

声网在 [Agora-MetaWorld](https://github.com/AgoraIO-Community/Agora-MetaWorld/) 仓库的 `dev_metasdk1.0` 分支提供[虚拟人直播](https://github.com/AgoraIO-Community/Agora-MetaWorld/tree/dev_metasdk1.0/ios)源代码供你参考。

## 准备开发环境

### 前提条件

- [Git](https://git-scm.com/downloads)
- [Xcode](https://apps.apple.com/cn/app/xcode/id497799835?mt=12) 12.0 及以上
- iOS 设备，版本 11.0 及以上
    <div class="alert note">声网推荐使用真机运行项目。部分模拟机可能存在功能缺失或者性能问题。</div>
- 有效的苹果开发者账号
- 有效的[声网账户](https://docportal.shengwang.cn/cn/Agora%20Platform/get_appid_token?platform=All%20Platforms#%E5%88%9B%E5%BB%BA%E5%A3%B0%E7%BD%91%E8%B4%A6%E5%8F%B7)和[声网项目](https://docportal.shengwang.cn/cn/Agora%20Platform/get_appid_token?platform=All%20Platforms#%E5%88%9B%E5%BB%BA%E5%A3%B0%E7%BD%91%E9%A1%B9%E7%9B%AE)

### 开通 Meta 服务

参考以下步骤开通虚拟人直播服务：

1. 获取 App ID。详情请参考[开始使用声网平台](https://docportal.shengwang.cn/cn/Agora%20Platform/get_appid_token?platform=All%20Platforms#获取-app-id)。

2. 联系销售并提供你的 App ID，用于开通声网内容中心的权限。

//TODO: 跑通中的其他字段，如面捕appid、面捕certificate等是否也需要？

### 集成 SDK

1. 联系技术支持获取 MetaWorld SDK，下载并解压。//TODO: 联系谁

2. 将 SDK 包内 `libs` 及路径下的文件，拷贝到你的项目路径下。

3. 打开 Xcode，[添加对应动态库](https://help.apple.com/xcode/mac/current/#/dev51a648b07)，确保添加的动态库 **Embed** 属性设置为 **Embed & Sign**。

<div class="alert note"><li>根据 Apple 官方要求，app 的 Extension 中不允许包含动态库。如果项目中的 Extension 需要集成 SDK，则添加动态库时需将文件状态改为 **Do Not Embed**。</li><li>声网 SDK 默认使用 libc++ (LLVM)，如需使用 libstdc++ (GNU)，请联系 <a href="mailto:sales@agora.io">sales@agora.io</a>。SDK 提供的库是 FAT Image，包含 32/64 位模拟器、32/64 位真机版本。</li></div>

### 配置依赖库

1. 添加 [OpenSSL](https://www.openssl.org/source/) 依赖库 `libcrypto.a` 和 `libssl.a`。

2. 添加 `libz.tbd` 依赖库。


## 实现虚拟人直播

本节介绍在集成 MetaSDK 后，如何实现虚拟人直播的核心业务模块的功能。

实现流程中需要用到声网 SDK 的以下接口类：

- `AgoraRtcEngineKit` 类：提供实时音视频功能。
- `AgoraMetaServiceKit` 类：MetaSDK 所有接口的入口，用于创建 `AgoraMetaScene` 对象，负责获取、下载和删除场景资源。
- `AgoraMetaScene` 类：负责进出场景、场景视频渲染、场景相关参数设置等场景相关操作。
- `AgoraLocalUserAvatar` 类：用于设置用户昵称、徽章、Avatar 模型、捏脸换装等详细信息。
- `AgoraMetaEventDelegate` 类：`AgoraMetaServiceKit` 的异步方法的事件回调类。
- `AgoraMetaSceneEventDelegate` 类：`AgoraMetaScene` 的异步方法的事件回调类。

![](https://web-cdn.agora.io/docs-files/1686650391606)

### 1. 初始化

在创建虚拟人直播场景前，你需要创建并初始化 RTC 引擎和 Meta 服务。本节展示调用 `sharedEngine` 初始化 `AgoraRtcEngineKit` 对象和调用 `sharedMetaServiceWithConfig` 初始化 `AgoraMetaServiceKit` 对象的示例代码。

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

初始化完成后，请参考如下代码调用 `getSceneAssetsInfo` 和 `downloadSceneAssets` 获取、下载场景资源。

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

### 3. 创建虚拟人直播场景

搭建元语聊首先需要创建 3D 场景。

```swift
func createScene(_ delegate: MetaChatSceneViewController) {
    // 场景配置信息
    let config = AgoraMetaSceneConfig()
    config.delegate = delegate
    // 支持面捕
    config.enableFaceCapture = true
    config.faceCaptureCertificate = KeyCenter.FACE_CAPTURE_APP_ID
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
     
    metachatScene = scene
    DispatchQueue.main.async {
        // 创建 render view
        guard let view = scene?.createRenderView(CGRect(x: 0, y: 0, width: width, height: height)) else { return }
        // 开启视频
        rtcEngine?.enableVideo()
    }
}
```

### 4. 获取并设置用户信息

```swift
// 设置avatar信息
localUserAvatar = metachatScene?.getLocalUserAvatar()
localUserAvatar?.setUserInfo(currentUserInfo)
localUserAvatar?.setModelInfo(avatarInfo)
```

支持自定义捏脸换装，详见。

### 5. 进入虚拟人直播场景

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
    localUserAvatar = metachatScene?.getLocalUserAvatar()
    localUserAvatar?.setUserInfo(currentUserInfo)
    localUserAvatar?.setModelInfo(avatarInfo)
    // avatar装扮信息
    let dict = ["avatar": "girl", "dress": [10000, 10100], "face": [["key": "eyeBlink_L", "val": 30] as [String : Any]], "2dbg": ""] as [String : Any]
    let data = try? JSONSerialization.data(withJSONObject: dict, options: [])
    let extraInfo = String(data: data!, encoding: String.Encoding.utf8)
    localUserAvatar?.setExtraInfo(extraInfo!.data(using: String.Encoding.utf8))
    // 进入场景
    metachatScene?.enter(enterSceneConfig)
}
 
 
// 进入场景后回调
func metaScene(_ scene: AgoraMetaScene, onEnterSceneResult errorCode: Int) {}
```

### 6. 加入频道并开启虚拟人直播

```swift
func joinRtcChannel(success: @escaping () -> Void) {
    // RTCEngine加入频道
    rtcEngine?.joinChannel(byToken: KeyCenter.RTC_TOKEN, channelId: KeyCenter.CHANNEL_ID, info: nil, uid: KeyCenter.RTC_UID, joinSuccess: { String, UInt, Int in
    DLog("joinChannel 回调 ======= ",String,UInt,Int)
    success()
})
}
```

### 7. 离开并释放资源

```swift
private func leaveScene() {
    // 退出频道
    rtcEngine?.leaveChannel()
    // 退出场景
    metaScene?.leave()
}
// 离开场景回调
func metaScene(_ scene: AgoraMetaScene, onLeaveSceneResult errorCode: Int) {
    // 销毁场景
    metaScene?.destroy()
    metaScene = nil
}
// 场景销毁回调
func metaScene(_ scene: AgoraMetaScene, onReleasedScene errorCode: Int) {
    // 销毁 AgoraMetaServiceKit
    AgoraMetaServiceKit.destroy()
    metaService = nil
    // 销毁 AgoraRtcEngineKit
    AgoraRtcEngineKit.destroy()
    rtcEngine = nil
}
```
