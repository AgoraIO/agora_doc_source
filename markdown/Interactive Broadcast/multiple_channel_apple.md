---
title: 加入多频道
platform: iOS
updatedAt: 2020-11-18 07:21:15
---
## 功能描述

为方便用户同时加入多个频道，接收多个频道的音视频流，AAgora RTC Native SDK 3.0 及以上版本支持多频道管理，且频道数量无限制。

该功能可应用于类似超级小班课的场景：将一个互动大班里的学生分到不同的小班，学生可以在小班内进行实时音视频互动。根据场景需要，你还可以给每个小班可以配备一名助教老师。

<div class="alert note">多频道功能适用于直播场景，通信场景下不建议使用此功能。</div>

## 示例项目

我们在 GitHub 提供以下实现了多频道功能的开源示例项目，你可以前往下载体验，参考源代码。

- 在 `AgoraRtcChannel` 类的频道中发布流:
  - iOS: [JoinMultiChannel](https://github.com/AgoraIO/API-Examples/blob/master/iOS/APIExample/Examples/Advanced/JoinMultiChannel/JoinMultiChannel.swift)
  - macOS: [JoinMultiChannel](https://github.com/AgoraIO/API-Examples/blob/master/macOS/APIExample/Examples/Advanced/JoinMultiChannel/JoinMultiChannel.swift)
- 在 `AgoraRtcEngineKit` 类的频道中发布流: [Breakout Class](https://github.com/AgoraIO-Usecase/Breakout-Class/tree/master/breakout-ios) (iOS)

## 实现方法

SDK 提供 `AgoraRtcChannel` 类和 `AgoraRtcChannelDelegate` 类实现多频道控制。

你可以多次调用 `createRtcChannel` ，通过不同的 `channelId` 创建多个 `AgoraRtcChannel` 对象（对应多个频道），然后分别调用 `AgoraRtcChannel` 中的 `joinChannelByToken` 方法加入对应的频道。

实现多频道功能的主要步骤如下：

1. 调用 `sharedEngineWithAppId` 方法，创建并初始化 `AgoraRtcEngineKit`。
2. 调用 `setChannelProfile `方法，将频道场景设置为直播。
3. 调用 `createRtcChannel` 方法，通过 `channelId` 创建一个 `AgoraRtcChannel` 对象。
4. 调用 `AgoraRtcChannel` 类的 `setRtcChannelDelegate` 方法，接收该频道的回调通知。
5. 调用 `AgoraRtcChannel` 类的 `joinChannelByToken` 方法加入频道。
6. 根据需要，选择以下一种方式发布本地流：
   - 在 `AgoraRtcEngineKit` 类的频道中发布本地流：调用 `AgoraRtcEngineKit` 类的 `setClientRole` 方法将用户角色设置为主播，然后调用 `joinChannelByToken` 方法加入频道，SDK 会自动发布流。这种方式适用于只需要将本地流固定发布到 `AgoraRtcEngineKit` 类的频道的场景。
   - 在 `AgoraRtcChannel` 类的频道中发布本地流：调用 `AgoraRtcChannel` 类的 `setClientRole` 方法将用户角色设置为主播，然后调用 `publish` 方法在该频道内发布流。这种方式适用于需要切换发流的频道的场景。
7. 如果需要加入更多的频道，重复步骤 3、4、5。

<div class="alert note">
	<li>在 <code>AgoraRtcChannel</code> 类中调用 <code>publish</code> 方法之前，必须先调用 <code>setClientRole</code> 将用户角色设置为主播。</li>
	<li>加入多个频道时，请确保每个频道的频道名不同。</li>
	<li>同一时间，本地的音视频流只能发布到一个频道。如果你的场景需要切换发布本地流的频道，我们建议在 <code>AgoraRtcChannel</code> 类的频道中发布本地流，在切换发流频道前必须先调用 <code>unpublish</code> 取消当前的发布。</li>
</div>

### API 调用时序

加入多个频道，且在 `AgoraRtcEngineKit` 类的频道中发布本地流的 API 时序如下：

![多频道 API 时序图1](https://web-cdn.agora.io/docs-files/1604647259741)

加入多个频道，且在 `AgoraRtcChannel` 类的频道中发布本地流的 API 时序如下：

![多频道 API 时序图2](https://web-cdn.agora.io/docs-files/1604647289810)

### **示例代码**

下面的示例代码演示了如何创建两个 `AgoraRtcChannel` 对象加入两个频道，并且在其中一个频道发布本地流。

1. 初始化 AgoraRtcEngineKit。

  ```swift
  // Swift
  let config = AgoraRtcEngineConfig()
  config.appId = KeyCenter.AppId
  agoraKit = AgoraRtcEngineKit.sharedEngine(with: config, delegate: self)
  ```

2. 设置频道场景为直播。

   ```swift
   // Swift
   agoraKit.setChannelProfile(.liveBroadcasting)
   ```

3. 创建频道 `channel1`，并监听该频道的回调通知。

   ```swift
   // Swift
   channel1 = agoraKit.createRtcChannel(channelName1)
   label1.text = channelName1
   channel1?.setRtcChannelDelegate(self)
   ```

4. 加入频道 `channel1`，并发布本地流。

   ```swift
   // Swift
   // 将用户角色设为主播
   channel1?.setClientRole(.broadcaster)
   // 加入频道 channel1
   var result = channel1?.join(byToken: token1, info: nil, uid: 0, options: mediaOptions) ?? -1
   // 加入频道失败时报错，通常是因为参数设置错误。
   if result != 0 {
     self.showAlert(title: "Error", message: "joinChannel1 call failed: \(result), please check your params")
   }
   // 在 channel1 调用 publish 发布流；同一时间最多只能在一个频道发布流
   channel1?.publish()
   ```

5. 创建并加入频道 `channel2`。

   ```swift
   // Swift
   // 创建频道 channel2
   channel2 = agoraKit.createRtcChannel(channelName2)
   label2.text = channelName2
   channel2?.setRtcChannelDelegate(self)
   // 加入频道 channel2
   result = channel2?.join(byToken: token2, info: nil, uid: 0, options: mediaOptions) ?? -1
   // 加入频道失败时报错，通常是因为参数设置错误
   if result != 0 {
     self.showAlert(title: "Error", message: "joinChannel2 call failed: \(result), please check your params")
   }
   ```

6. 离开并销毁频道 `channel1` 和 `channel2`。

   ```swift
   // Swift
   channel1?.leave()
   channel1?.destroy()
   channel2?.leave()
   channel2?.destroy()
   ```

### API 参考

- [`createRtcChannel`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/createRtcChannel::)
- [`AgoraRtcChannel`](./API%20Reference/oc/Classes/AgoraRtcChannel.html) 类
- [`AgoraRtcChannelDelegate`](./API%20Reference/oc/Protocols/AgoraRtcChannelDelegate.html) 类

## 开发注意事项

### 精细订阅限制

如果在加入 `AgoraRtcChannel` 类的频道时，将媒体订阅选项设置为不自动订阅音频流或视频流，加入频道后，`muteRemoteAudioStream `或 `muteRemoteVideoStream` 方法会失效。

<div class="alert info"><code>AgoraRtcChannel</code> 中的 <code>joinChannelByToken</code> 方法中提供媒体订阅选项设置（<code>autoSubscribeAudio</code> 和 <code>autoSubscribeVideo</code>），可以控制在加入频道后是否自动订阅音频流和视频流，默认为自动订阅。</div>

如果你需要在加入 `AgoraRtcChannel` 的频道时仅接收指定用户的音频流或视频流，Agora 建议使用以下方法：

1. 在加入该频道前调用 `AgoraRtcChannel` 中的 `setDefaultMuteAllRemoteAudioStreams(YES)`或 `setDefaultMuteAllRemoteVideoStreams(YES)` 设置默认不接收该频道的所有音频流或所有视频流。
2. 调用 `AgoraRtcChannel` 中的 `joinChannelByToken` 加入频道（媒体订阅选项使用默认设置）。
3. 调用 `AgoraRtcChannel` 中的 `muteRemoteAudioStream(NO)` 或 `muteRemoteVideoStream(NO)` 接收指定用户的音频流或视频流。

### 设置远端视图

在视频场景中，如果远端用户是通过 `AgoraRtcChannel` 加入频道的，那么在设置远端视图时，还需要在 [`AgoraRtcVideoCanvas`](./API%20Reference/oc/v3.0.0/Classes/AgoraRtcVideoCanvas.html)  中指定该远端用户所在频道的 channel ID，否则会无法渲染出远端视频画面。

```swift
// Swift
// 在远端用户加入频道的回调中设置用户视图
func rtcChannel(_ rtcChannel: AgoraRtcChannel, didJoinedOfUid uid: UInt, elapsed: Int) {
  LogUtils.log(message: "remote user join: \(uid) \(elapsed)ms", level: .info)
 
  let videoCanvas = AgoraRtcVideoCanvas()
  videoCanvas.uid = uid
  // 待绑定的视图
  videoCanvas.view = channel1 == rtcChannel ? channel1RemoteVideo.videoView : channel2RemoteVideo.videoView
  videoCanvas.renderMode = .hidden
  // 指定远端用户所在频道的 channelId
  videoCanvas.channelId = rtcChannel.getId()
  // 设置远端用户视图
  agoraKit.setupRemoteVideo(videoCanvas)
}
```

### 多频道发流限制

由于 SDK 仅支持用户同一时间在一个频道内发布媒体流，且通过 `AgoraRtcEngineKit` 类和 `AgoraRtcChannel` 类下的 `joinChannelByToken` 方法加入频道后，SDK 的默认行为有以下差异：

- `AgoraRtcEngineKit` 类下，SDK 默认发布本地音视频流到本频道。
- `AgoraRtcChannel` 类下，SDK 默认不发布本地音视频流到本频道。

因此，以下操作会导致 SDK 返回 `AgoraErrorCodeRefused(5)` 错误码：

- 通过 `AgoraRtcChannel` 类加入多频道：
  - 调用频道一的 `publish` 方法后，未调用频道一的 `unpublish` 方法结束发布，就调用频道二的 `publish` 方法；
- 通过混用 `AgoraRtcEngineKit` 类和 `AgoraRtcChannel` 类加入多频道：
  - 通过 `AgoraRtcEngineKit` 类加入频道一，然后通过 `AgoraRtcChannel` 类加入频道二后，调用 `AgoraRtcChannel` 类的 `publish` 方法；
  - 加入多个频道后，以观众身份调用 `AgoraRtcChannel` 类的 `publish` 方法；
  - 调用 `AgoraRtcChannel` 类的 `publish` 方法后，未调用对应 `AgoraRtcChannel` 类的 `unpublish` 方法，就试图通过 `AgoraRtcEngineKit` 类的 `joinChannelByToken` 方法加入频道。