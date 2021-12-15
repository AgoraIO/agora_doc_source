---
title: 屏幕共享
platform: iOS
updatedAt: 2020-12-07 04:54:10
---

## 功能描述

在视频通话或互动直播中进行屏幕共享，可以将说话人或主播的屏幕内容，以视频的方式分享给其他说话人或观众观看，以提高沟通效率。

屏幕共享在如下场景中应用广泛：

- 视频会议场景中，屏幕共享可以将讲话者本地的文件、数据、网页、PPT 等画面分享给其他与会人；
- 在线课堂场景中，屏幕共享可以将老师的课件、笔记、讲课内容等画面展示给学生观看。

## 示例项目

Agora 在 GitHub 提供一个开源的 iOS 屏幕共享[示例项目](https://github.com/AgoraIO/API-Examples/tree/master/iOS/APIExample/Examples/Advanced/ScreenShare)，你可以下载体验，并参考源代码。

以下是示例项目的主要代码文件：

| 文件/文件夹                                                                                                                             | 描述                                                                                                                                                                                                                                                                                                                                                                                                             |
| :-------------------------------------------------------------------------------------------------------------------------------------- | :--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [Agora-ScreenShare-Extension](https://github.com/AgoraIO/API-Examples/tree/master/iOS/Agora-ScreenShare-Extension)                      | 用于屏幕共享进程的 Extension，主要的代码文件如下：[SampleHandler.swift](https://github.com/AgoraIO/API-Examples/blob/master/iOS/Agora-ScreenShare-Extension/SampleHandler.swift)：使用 Apple ReplayKit 进行屏幕录制。[AgoraUploader.swift](https://github.com/AgoraIO/API-Examples/blob/master/iOS/Agora-ScreenShare-Extension/AgoraUploader.swift)：使用 SDK 自采集功能获取系统录屏数据，发送给频道中其他用户。 |
| [ScreenShare.swift](https://github.com/AgoraIO/API-Examples/blob/master/iOS/APIExample/Examples/Advanced/ScreenShare/ScreenShare.swift) | 屏幕共享 app 的主要代码，实现本地用户加入频道和开启屏幕共享的功能。                                                                                                                                                                                                                                                                                                                                              |

## 实现方法

在实现屏幕共享前，请确保已在你的项目中实现基本的实时音视频功能。详见[开始音视频通话](https://docs.agora.io/cn/Interactive%20Broadcast/start_call_ios)或[开始互动直播](https://docs.agora.io/cn/Interactive%20Broadcast/start_live_ios)。

iOS 端的屏幕共享是通过在 Extension 中使用 iOS 原生的 ReplayKit 框架实现录制屏幕，然后将屏幕共享流作为一个用户加入频道实现的。由于 Apple 不支持 Extension 进程与主 app 进程通信，因此你需要为屏幕共享流单独创建一个进程。

![](https://web-cdn.agora.io/docs-files/1606368135907)

实现屏幕共享的主要步骤如下：

- 创建一个 Broadcast Upload Extension 用于开启屏幕共享的进程。
- 使用 Apple ReplayKit 框架进行屏幕录制。
- 将录屏数据作为自定义视频源发送给 SDK，并使用 SDK 进行视频流的传输。

本文的实现方法适用于 iOS 12.0 或更高版本。

### 1. 创建屏幕共享 Extension

参考以下步骤，创建一个 Broadcast Upload Extension。

1. 用 Xcode 打开项目的工程文件，在菜单栏中选择 **Editor > Add Target...。**

2. 在弹出窗口中，选择 iOS 页的 **Broadcast Upload Extension**，点击 **Next**。

   ![](https://web-cdn.agora.io/docs-files/1606368184836)

3. 在 **Product Name** 一栏输入 Extension 的名字，如 Agora-ScreenShare，然后点击 **Finish**。
   创建完成后，你会在项目中看到该 Extension 的文件夹，用于存放屏幕共享功能的实现代码。

   ![](https://web-cdn.agora.io/docs-files/1606368200676)

4. 打开项目中的 Podfile，为 Extension 添加依赖项：

   ```
   target 'Agora-ScreenShare-Extension' do

     use_frameworks!

     pod 'AgoraRtcEngine_iOS', '~> 3.1.1'

     # 如果需要媒体流加密功能，使用下面的代码
     # pod 'AgoraRtcEngine_iOS_Crypto', '~> 3.1.1'

   end
   ```

5. 在项目根目录下运行 `pod install` 命令，安装依赖项。

### 2. 在项目中使用屏幕共享 Extension

将 `RPSystemBroadcastPickerView` 作为启动屏幕录制的按钮添加到 app 的 view 中。

```
// Swift
func prepareSystemBroadcaster() {
    if #available(iOS 12.0, *) {
        let frame = CGRect(x: 0, y:0, width: 60, height: 60)
        let systemBroadcastPicker = RPSystemBroadcastPickerView(frame: frame)
        systemBroadcastPicker.autoresizingMask = [.flexibleTopMargin, .flexibleRightMargin]
        if let url = Bundle.main.url(forResource: "Agora-ScreenShare-Extension", withExtension: "appex", subdirectory: "PlugIns") {
            if let bundle = Bundle(url: url) {
                systemBroadcastPicker.preferredExtension = bundle.bundleIdentifier
            }
        }
        broadcasterPickerContainer.addSubview(systemBroadcastPicker)
    } else {
        self.showAlert(message: "Minimum support iOS version is 12.0")
    }

}
```

### 3. 设置自定义视频源

通过 SDK 自定义视频采集的功能，实现将系统录制的屏幕数据发送给远端用户，进行屏幕共享。

为屏幕共享流创建一个 `AgoraRtcEngineKit` 实例，并设置自定义视频采集。

```
// Swift
private static let sharedAgoraEngine: AgoraRtcEngineKit = {
    let kit = AgoraRtcEngineKit.sharedEngine(withAppId: KeyCenter.AppId, delegate: nil)

    kit.enableVideo()
    // 使用自定义视频源
    kit.setExternalVideoSource(true, useTexture: true, pushMode: true)

    // 不接收所有远端用户的视频流和音频流
    kit.muteAllRemoteVideoStreams(true)
    kit.muteAllRemoteAudioStreams(true)

    return kit
}()
```

### 4. 获取屏幕数据

使用 Apple 原生的 ReplayKit 框架实现屏幕录制。

1. 在屏幕共享 Extension 的 `Info.plist` 文件中，将 `RPBroadcastProcessMode` 设置为 `RPBroadcastProcessModeSampleBuffer`。

2. 在 `broadcastStarted` 回调中开始录制屏幕。

  <div class="alert note"> 示例代码中将频道名固定设置为 ScreenShare；如果你需要让用户输入频道名，必须使用 App Group 将主进程的参数值传递给 Extension。</div>

```
// Swift
override func broadcastStarted(withSetupInfo setupInfo: [String : NSObject]?) {
    AgoraUploader.startBroadcast(to: "ScreenShare")

    DispatchQueue.main.async {
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) {[weak self] (timer:Timer) in
            guard let weakSelf = self else {return}
            let elapse = Int64(Date().timeIntervalSince1970 * 1000) - weakSelf.lastSendTs
            print("elapse: \(elapse)")
            // 视频帧间隔过长时，重新发送上一帧。
            if(elapse > 300) {
                if let buffer = weakSelf.bufferCopy {
                    weakSelf.processSampleBuffer(buffer, with: .video)
                }
            }
        }
    }
}
```

3. 系统采集到数据后发送给 SDK。

   ```
   // Swift
   override func processSampleBuffer(_ sampleBuffer: CMSampleBuffer, with sampleBufferType: RPSampleBufferType) {
    DispatchQueue.main.async {[weak self] in
        switch sampleBufferType {
        case .video:
            if let weakSelf = self {
                weakSelf.bufferCopy = sampleBuffer
                weakSelf.lastSendTs = Int64(Date().timeIntervalSince1970 * 1000)
            }
            // 发送视频 buffer
            AgoraUploader.sendVideoBuffer(sampleBuffer)
        @unknown default:
            break
        }
    }
   }
   ```

   通过 `pushExternalVideoFrame` 实现 `sendVideoBuffer`。

   ```
   // Swift
   static func sendVideoBuffer(_ sampleBuffer: CMSampleBuffer) {
       guard let videoFrame = CMSampleBufferGetImageBuffer(sampleBuffer)
               else {
           return
       }

       var rotation : Int32 = 0
       if let orientationAttachment = CMGetAttachment(sampleBuffer, key: RPVideoSampleOrientationKey as CFString, attachmentModeOut: nil) as? NSNumber {
           if let orientation = CGImagePropertyOrientation(rawValue: orientationAttachment.uint32Value) {
               switch orientation {
               case .up,    .upMirrored:    rotation = 0
               case .down,  .downMirrored:  rotation = 180
               case .left,  .leftMirrored:  rotation = 90
               case .right, .rightMirrored: rotation = 270
               default:   break
               }
           }
       }

       let time = CMTime(seconds: CACurrentMediaTime(), preferredTimescale: 1000)

       let frame = AgoraVideoFrame()
       frame.format = 12
       frame.time = time
       frame.textureBuf = videoFrame
       frame.rotation = rotation
       sharedAgoraEngine.pushExternalVideoFrame(frame)
   }
   ```

4. 在屏幕共享流对应的 `AgoraRtcEngineKit` 实例中调用 `joinChannelByToken` 加入频道，就可以开始屏幕共享。

   ```
   // Swift
   static func startBroadcast(to channel: String) {
       print("joining \(channel)")
       sharedAgoraEngine.joinChannel(byToken: nil, channelId: channel, info: nil, uid: SCREEN_SHARE_UID, joinSuccess: nil)
   }
   ```

### 开发注意事项

- Broadcast Upload Extension 的内存使用限制为 50 MB，请确保屏幕共享的 Extension 内存使用不超过 50 MB。
- 如果在屏幕共享时需要同时分享 app 的音频，可以通过自定义音频采集实现，具体代码可以参考 [AgoraAudioTube.mm](https://github.com/AgoraIO/API-Examples/blob/master/iOS/Agora-ScreenShare-Extension/AgoraAudioTube.mm)。
- 屏幕共享的进程中，需要调用 `muteAllRemoteVideoStreams` 和 `muteAllRemoteAudioStreams` 方法取消接收远端用户的流，避免重复订阅。
- 对于主进程来说，屏幕共享流在频道中相当于一个远端用户。为避免不必要的费用，在设置远端用户视图时可以将屏幕共享流除外。

```
// Swift
// 判断是否为屏幕共享流的 uid
func isScreenShareUid(uid: UInt) -> Bool {
   return uid >= SCREEN_SHARE_UID_MIN && uid <= SCREEN_SHARE_UID_MAX
}

// 远端用户加入频道回调
func rtcEngine(_ engine: AgoraRtcEngineKit, didJoinedOfUid uid: UInt, elapsed: Int) {
   LogUtils.log(message: "remote user join: \(uid) \(elapsed)ms", level: .info)

   // 如果是屏幕共享的 uid，忽略
   if(isScreenShareUid(uid: uid)) {
       LogUtils.log(message: "Ignore screen share uid", level: .info)
       return
   }

   // 设置远端用户视图
   ......
}
```
