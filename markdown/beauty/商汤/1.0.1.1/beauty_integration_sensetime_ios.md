本文介绍如何通过声网美颜场景化 API (Beauty API) 集成商汤美颜到实时音视频互动中。

## 示例项目

声网在 GitHub 上提供开源 [BeautyAPI](https://github.com/AgoraIO-Community/BeautyAPI/tree/1.0.1.1) 示例项目供你参考。

## 准备开发环境

### 前提条件

- [Git](https://git-scm.com/downloads)
- [CocoaPods](https://guides.cocoapods.org/using/getting-started.html#getting-started)
- [Xcode](https://apps.apple.com/cn/app/xcode/id497799835?mt=12) 12.0 及以上
- iOS 设备，版本 13.0 及以上
- 有效的苹果开发者账号
- 有效的声网[开发者账号](https://docs.agora.io/cn/Agora%20Platform/sign_in_and_sign_up)
- 已联系商汤技术获取最新的美颜 SDK、美颜资源、美颜证书


### 创建声网项目

~f42d44d0-2ac7-11ee-b391-19a59cc2656e~

跑通示例项目时，你需要将**鉴权机制**设置为**调试模式：APP ID**。从头搭建 Android 项目集成美颜功能时，声网推荐你将**鉴权机制**设置为**安全模式：APP ID + Token**，以保障安全性。


### 创建 iOS 项目

在 Xcode 中进行以下操作，在你的 app 中实现场景化美颜功能：

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

5. 将商汤美颜 SDK 集成到你的项目中。请联系商汤技术支持获取美颜 SDK、美颜资源、证书等文件。下载并解压文件，然后添加到美颜项目对应的文件路径下：

    | 文件   | 项目路径      |
    |------------------|----------------|
    | SenseMe/remoteSourcesLib    | iOS/SenseLib/remoteSourcesLib              |
    | SenseMe/st_mobil_sdk | iOS/SenseLib/st_mobile_sdk  |
    |SenseMe/st_mobil_sdk/license/SENSEME.lic   | iOS/SenseLib/SENSEME.lic |

6. 将声网美颜场景化 API 集成到你的项目中。添加 [iOS/BeautyAPi/BeautyAPI](https://github.com/AgoraIO-Community/BeautyAPI/tree/1.0.1.1/iOS/BeautyAPi/BeautyAPI) 目录下的文件到项目中，具体文件如下：

    - `Render/SenseRender` 文件夹
    - `SenseRender` 文件夹
    - `BeautyAPI.h` 文件
    - `BeautyAPI.m` 文件
    - `BeautyConfig.h` 文件
    - `BeautyConfig.m` 文件

    <div class="alert note">为方便后续代码升级，请不要修改你添加的这些文件的名称和路径。</div>

7. 将声网 RTC SDK 和商汤美颜依赖库集成到你的项目。

    1. 在终端里进入项目根目录，并运行 `pod init` 命令。项目文件夹下会生成一个 `Podfile` 文本文件。
    2. 打开 `Podfile` 文件，修改文件为如下内容。注意将 `Your App` 替换为你的 Target 名称。

    ```shell
    platform :ios, '9.0'
    # 替换成你的 target 名称
    target 'Your App' do
    # x.y.z 请填写具体的 RTC SDK 版本号，如 4.0.1 或 4.0.0.4
    # 可通过互动直播发版说明获取最新版本号
    pod 'AgoraRtcEngine_iOS', 'x.y.z'
    # 配置商汤美颜的依赖库
    pod 'SenseLib', :path => 'sense.podspec'
    end
    ```


8. 在终端内运行 <code>pod install</code> 命令安装声网 RTC SDK 和商汤美颜依赖。

9. 成功安装后，Terminal 中会显示 <code>Pod installation complete!</code>。项目文件夹下会生成一个后缀为 <code>.xcworkspace</code> 的文件，通过 Xcode 打开该文件进行后续操作。

## 实现美颜

本节展示如何在直播间内实现美颜功能，参考 [API 时序图](#api-时序图)可查看总览。声网 RTC SDK 承担实时音视频的业务，商汤美颜 SDK 提供美颜功能，声网 Beauty API 封装了两个 SDK 中的 API 调用逻辑以简化你需要实现的代码逻辑。通过 Beauty API，你可以实现基础美颜功能，但是如果你还需要更丰富的美颜效果，例如贴纸、美妆风格，你可以直接调用美颜 SDK 中的 API。

### 1. 初始化 AgoraRtcEngineKit

调用声网 RTC SDK 中的 `sharedEngineWithConfig` 创建并初始化 `AgoraRtcEngineKit` 对象。调用 `enableVideo` 开启声网 SDK 的视频模块。

```swift
// 初始化 AgoraRtcEngineKit
private lazy var rtcEngine: AgoraRtcEngineKit = {
    let config = AgoraRtcEngineConfig()
    // 传入你从控制台获取的声网项目的 APP ID
    config.appId = KeyCenter.AppId
    config.channelProfile = .liveBroadcasting
    let rtc = AgoraRtcEngineKit.sharedEngine(with: config, delegate: self)
    // 设置用户角色为主播，主播可以发送音视频流也可以接收音视频流
    rtc.setClientRole(.broadcaster)
    // 开启 SDK 音频模块
    rtc.enableAudio()
    // 开启 SDK 视频模块
    rtc.enableVideo()
    // 设置默认音频路由为扬声器
    rtc.setDefaultAudioRouteToSpeakerphone(true)
    return rtc
}()
```

### 2. 初始化美颜和 Beauty API

创建 SenseBeautyRender 和 Beauty API 对象。Beauty API 对象基于 `SenseBeautyRender` 对象封装。


```swift
private lazy var senseRender = SenseBeautyRender()
private lazy var beautyAPI = BeautyAPI()
```


调用 `initialize` 初始化 Beauty API 对象。你需要在 `config` 参数中传入如下字段：

- `AgoraRtcEngineKit`：传入之前初始化的 `AgoraRtcEngineKit` 对象。
- `beautyRender`：传入之前初始化的 `SenseBeautyRender` 对象。
- `captureMode`：视频的采集模式：
    - 如果你使用声网模块采集视频，请传入 `CaptureMode.Agora`。
    - 如果自定义采集视频，请传入 `CaptureMode.Custom`。
- `statsEnable`：是否开启美颜统计数据回调。`true` 代表开启，`false` 代表不开启。开启后，会有周期性回调事件。
- `statsDuration`：美颜统计数据回调的周期。单位为秒。
- `eventCallback`：监听的美颜统计数据回调事件。


```swift
let config = BeautyConfig()
// AgoraRtcEngineKit
config.rtcEngine = rtcEngine
// 设置视频采集模式
// .agora 意味着使用声网模块采集视频
// .custom 意味着使用开发者自定义采集视频
config.captureMode = capture == "Custom" ? .custom : .agora
// SenseBeautyRender
config.beautyRender = senseRender
// 是否开启美颜统计数据
// 开启后，会有周期性回调事件
config.statsEnable = false
// 设置美颜统计数据的统计区间为 1 秒（默认）
config.statsDuration = 1
// Beauty API 的回调事件
config.eventCallback = { stats in
    print("min == \(stats.minCostMs)")
    print("max == \(stats.maxCostMs)")
    print("averageCostMs == \(stats.averageCostMs)")
}

// 初始化 Beauty API 对象
let result = beautyAPI.initialize(config)
if result != 0 {
    print("initialize error == \(result)")
}
```


### 3. 开启美颜

调用 Beauty API 的 `enable` 方法并将参数设为 `true` 开启美颜。

```swift
beautyAPI.enable(true)
```

### 4. 开启视频采集

开发者可以使用声网模块采集视频，也可以自定义采集视频。本节介绍在这两种场景下如何开启视频采集。

#### 使用声网模块采集视频

使用声网模块采集视频视频时，调用 Beauty API 的 `setupLocalVideo` 开启本地视图。

```swift
beautyAPI.setupLocalVideo(localView, renderMode: .hidden)
```


#### 自定义视频采集

自定义视频采集时，你需要通过 `AgoraRtcEngineKit` 类的 `setVideoFrameDelegate` 注册原始视频数据观测器并在其中实现 `onCaptureVideoFrame` 函数。

通过 Beauty API 的 `onFrame` 函数，你可以将外部自采集的视频数据传入并进行处理。


```swift
if capture == "Custom" {
    // 注册原始视频数据观测器
    // 自定义视频采集时，即 CaptureMode 为 Custom 时，你需要注册原始视频观测器
    rtcEngine.setVideoFrameDelegate(self)
}

extension BeautyViewController: AgoraVideoFrameDelegate {
    func onCapture(_ videoFrame: AgoraOutputVideoFrame, sourceType: AgoraVideoSourceType) -> Bool {
        // 将外部自采集的视频数据传入声网 SDK
        guard let pixelBuffer = videoFrame.pixelBuffer else { return true }
        beautyAPI.onFrame(pixelBuffer) { pixelBuffer in
            videoFrame.pixelBuffer = pixelBuffer
        }

        return true
    }

    // 设置是否对原始视频数据作镜像处理
    func getMirrorApplied() -> Bool {
        beautyAPI.isFrontCamera
    }

    // 设置观测点为本地采集时的视频数据
    func getObservedFramePosition() -> AgoraVideoFramePosition {
        .postCapture
    }

    // 实现视频观测器中的其他回调函数
    ...
}
```



### 5. 加入频道

调用 `AgoraRtcEngineKit` 类的 `joinChannelByToken` 加入频道，同时传入如下参数：

- `token`：用于鉴权的动态密钥。如果在[创建声网项目](#创建声网项目)时启用**调试模式**，那么将 `token` 参数传空。如果启用**安全模式**，那么你先参考[使用 Token 鉴权](https://docportal.shengwang.cn/cn/live-streaming-premium-4.x/token_server_ios_ng?platform=iOS)在你的业务服务端生成 Token，然后将生成的 Token 传入该参数。
- `channelId`：频道名。
- `mediaOptions`：频道媒体设置选项。



```swift
let mediaOption = AgoraRtcChannelMediaOptions()
mediaOption.clientRoleType = isBroadcast ? .broadcaster : .audience
// 设置进入频道时是否自动订阅频道内其他用户的音频流
mediaOption.autoSubscribeAudio = true
// 设置进入频道时是否自动订阅频道内其他用户的视频流
mediaOption.autoSubscribeVideo = true
// 设置是否发布摄像头采集的视频流（适用于使用声网模块采集视频的情况）
// 用户角色为主播时，设置发布
// 用户角色为观众时，设置不发布
mediaOption.publishCameraTrack = mediaOption.clientRoleType == .broadcaster
// 设置是否发布自定义采集的视频流（适用于自定义采集视频的情况）
mediaOption.publishCustomVideoTrack = false
// 设置是否发布麦克风采集的音频流
// 用户角色为主播时，设置发布
// 用户角色为观众时，设置不发布
mediaOption.publishMicrophoneTrack = mediaOption.clientRoleType == .broadcaster

// 加入频道
let result = rtcEngine.joinChannel(byToken: nil, channelId: channelName ?? "", uid: 0, mediaOptions: mediaOption)
if result != 0 {
    print("join failed")
}
```


### 6. 设置美颜效果

调用 Beauty API 中 `setBeautyPreset` 方法设置使用的美颜参数的类型：

- `BeautyPresetModeDefault`：默认且推荐的美颜参数。
- `BeautyPresetModeCustom`：开发者自定义的美颜参数。

不同的美颜参数会带来不同的美颜效果。如果你没有特殊美颜要求，推荐你使用 `BeautyPresetModeDefault`。

```swift
beautyAPI.setBeautyPreset(.default)
```

<div class="alert note">通过 Beauty API 的 <code>setBeautyPreset</code> 方法，你可以实现基础美颜功能。但是如果你还需要更丰富的美颜效果，例如贴纸、美妆风格，你可以直接调用美颜 SDK 中的 API。</div>

### 7. 离开频道

调用 `AgoraRtcEngineKit` 类的 `leaveChannel` 离开频道。

```swift
rtcEngine.leaveChannel()
```


### 8. 销毁资源

调用 Beauty API 的 `destory` 销毁 Beauty API。

```swift
beautyAPI.destory()
```

<div class="alert note">Beauty API 1.0.1.1 版中 <code>destory</code>方法的命名存在笔误，会在 1.0.2 版本修正。</div>

调用 `AgoraRtcEngineKit` 的 `destroy` 销毁 `AgoraRtcEngineKit`。

```swift
AgoraRtcEngineKit.destroy()
```


### API 时序图

![](https://web-cdn.agora.io/docs-files/1693553315915)