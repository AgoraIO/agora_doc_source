---
title: Join Multiple Channels
platform: iOS
updatedAt: 2020-11-18 07:22:26
---
## Introduction

As of v3.0.0, the Agora RTC SDK enables users to join an unlimited number of channels and to receive the audio and video streams of all those channels.

<div class="alert note">This feature applies to the live streaming channel profile. Do not use it for the communication profile.</div>

## Sample project

Agora provides the following open-source sample projects on GitHub. You can download them and refer to the source code.

- Publish the local stream in an `AgoraRtcChannel` channel:
  - iOS: [JoinMultiChannel](https://github.com/AgoraIO/API-Examples/blob/master/iOS/APIExample/Examples/Advanced/JoinMultiChannel/JoinMultiChannel.swift)
  - macOS: [JoinMultiChannel](https://github.com/AgoraIO/API-Examples/blob/master/macOS/APIExample/Examples/Advanced/JoinMultiChannel/JoinMultiChannel.swift)
- Publish the local stream in an `AgoraRtcEngineKit` channel: [Breakout Class](https://github.com/AgoraIO-Usecase/Breakout-Class/tree/master/breakout-ios) (iOS)

## Implementation

The SDK uses the `AgoraRtcChannel` and `AgoraRtcChannelDelegate` classes to support the multi-channel function. 

You can call `createRtcChannel` multiple times, to create multiple `AgoraRtcChannel` objects with different channel names, and then call `joinChannelByToken` in `AgoraRtcChannel` to join the channel.

The following are the major steps of implementing the multi-channel function:

1. Call `sharedEngineWithAppId` to create and initialize `AgoraRtcEngineKit`.
2. Call `setChannelProfile` to set the channel profile as live streaming.
3. Call `createRtcChannel` to create an `AgoraRtcChannel` object with `channelId`.
4. Call `setRtcChannelDelegate` of the `AgoraRtcChannel` class to receive the callbacks in this channel.
5. Call `joinChannelByToken` of the `AgoraRtcChannel` class to join the channel.
6. Choose either of the following ways to publish the local stream:
   - Publish the stream in an `AgoraRtcEngineKit` channel: Call `setClientRole` of the `AgoraRtcEngineKit` class to set the user role as host, and then call `joinChannelByToken` to join the channel. The SDK automatically publishes the local stream after joining the channel. This method applies to scenarios where the local stream is published in a fixed channel.
   - Publish the stream in an `AgoraRtcChannel` channel: Call `setClientRole` of the `AgoraRtcChannel` class to set the user role as host, and then call `publish` to publish the local stream. This method applies to scenarios where the local stream needs to be published to different channels.
7. Repeat steps 3, 4, and 5 to join more channels.

<div class="alert note">
	<li>Before you call <code>publish</code> of the <code>AgoraRtcChannel</code> class, ensure that the user role is set as host by calling <code>setClientRole</code>.</li>
	<li>Ensure that each channel you join has a unique channel name.</li>
	<li>You can publish the local stream in only one channel at a time. If you need to switch the channel for publishing the stream, Agora recommends publishing the stream in an <code>AgoraRtcChannel</code> channel, and you must call <code>unpublish</code> before publishing the local stream to another channel.</li>
</div>

### API call sequence

Refer to the following API sequence to join multiple channels and publish the local stream in an `AgoraRtcEngineKit` channel:

![img](https://web-cdn.agora.io/docs-files/1604654442975)

Refer to the following API sequence to join multiple channels and publish the local stream in an `AgoraRtcChannel` channel:

![img](https://web-cdn.agora.io/docs-files/1604654790410)

### Sample code

The following code demonstrates how to create two `AgoraRtcChannel` objects to join two channels and publish the local stream in one channel.

1. Initialize `AgoraRtcEngineKit`.

   ```swift
   // Swift
   let config = AgoraRtcEngineConfig()
   config.appId = KeyCenter.AppId
   agoraKit = AgoraRtcEngineKit.sharedEngine(with: config, delegate: self)
   ```

2. Set the channel profile as live streaming.

   ```swift
   // Swift
   agoraKit.setChannelProfile(.liveBroadcasting)
   ```

3. Create `channel1`, and listen for events in this channel.

   ```swift
   // Swift
   channel1 = agoraKit.createRtcChannel(channelName1)
   label1.text = channelName1
   channel1?.setRtcChannelDelegate(self)
   ```

4. Join `channel1`, and publish the local stream.

   ```swift
   // Swift
   // Set the usr role as host.
   channel1?.setClientRole(.broadcaster)
   // Join channel1.
   var result = channel1?.join(byToken: token1, info: nil, uid: 0, options: mediaOptions) ?? -1
   // Report errors if failed to join the channel.
   if result != 0 {
     self.showAlert(title: "Error", message: "joinChannel1 call failed: \(result), please check your params")
   }
   // Call publish for channel1. You can only publish in one channel.
   channel1?.publish()
   ```

5. Create and join `channel2`.

   ```swift
   // Swift
   // Create channel2.
   channel2 = agoraKit.createRtcChannel(channelName2)
   label2.text = channelName2
   channel2?.setRtcChannelDelegate(self)
   // Join channel2.
   result = channel2?.join(byToken: token2, info: nil, uid: 0, options: mediaOptions) ?? -1
   // Report errors if failed to join the channel.
   if result != 0 {
     self.showAlert(title: "Error", message: "joinChannel2 call failed: \(result), please check your params")
   }
   ```

6. Leave and destroy `channel1` and `channel2`.

   ```swift
   // Swift
   channel1?.leave()
   channel1?.destroy()
   channel2?.leave()
   channel2?.destroy()
   ```

### API reference

- [`createRtcChannel`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/createRtcChannel::)
- [`AgoraRtcChannel`](./API%20Reference/oc/Classes/AgoraRtcChannel.html)
- [`AgoraRtcChannelDelegate`](./API%20Reference/oc/Protocols/AgoraRtcChannelDelegate.html)

## Considerations

### Subscription limits

If you set `autoSubscribeAudio` or `autoSubscribeVideo` as false, the method call of `muteRemoteAudioStream` or `muteRemoteVideoStream` does not take effect after joining an `AgoraRtcChannel` channel.

<div class="alert info"><code>joinChannelByToken</code> in the <code>AgoraRtcChannel</code> class provides the media subscription options (<code>autoSubscribeAudio</code> and <code>autoSubscribeVideo</code>) to determine whether to subscribe to the remote streams after joining the channel. The default setting is to subscribe to all streams automatically.</div>

If you need to subscribe to the streams of specified users after joining an `AgoraRtcChannel` channel, refer to the following steps:

1. Call `setDefaultMuteAllRemoteAudioStreams` or `setDefaultMuteAllRemoteVideoStreams` in the `AgoraRtcChannel` class and set the `mute` parameter as true to not receive any audio or video streams.
2. Call `joinChannelByToken` with default media subscription options to join the channel.
3. Call `muteRemoteAudioStream` or `muteRemoteVideoStream` and set the `mute` parameter as false to subscribe to the streams of the specified users.

### Set the remote video view

In video scenarios, if a remote user joins the channel using `AgoraRtcChannel`, ensure that you specify the channel ID of the remote user in [`AgoraRtcVideoCanvas`](./API%20Reference/oc/Classes/AgoraRtcVideoCanvas.html) when setting the remote video view. 

```swift
// Swift
// Set the remote user's view in the didJoinedOfUid callback
func rtcChannel(_ rtcChannel: AgoraRtcChannel, didJoinedOfUid uid: UInt, elapsed: Int) {
  LogUtils.log(message: "remote user join: \(uid) \(elapsed)ms", level: .info)

  let videoCanvas = AgoraRtcVideoCanvas()
  videoCanvas.uid = uid
  // The view to bind to
  videoCanvas.view = channel1 == rtcChannel ? channel1RemoteVideo.videoView : channel2RemoteVideo.videoView
  videoCanvas.renderMode = .hidden
  // Specify the channelId of the remote user
  videoCanvas.channelId = rtcChannel.getId()
  // Set the view for the remote user
  agoraKit.setupRemoteVideo(videoCanvas)
}
```

### Limits on publishing the stream

The SDK supports publishing one stream to only one channel at a time, and the default behavior differs after the method call of`joinChannelByToken` in the `AgoraRtcEngineKit` and `AgoraRtcChannel` classes:

- In the `AgoraRtcEngineKit` class, the SDK publishes the local stream by default.
- In the `AgoraRtcChannel` class, the SDK does not publish the local stream.

You must meet the following requirements to implement the multi-channel function. Otherwise, the SDK returns `AgoraErrorCodeRefused(-5)`:

- When joining multiple channels using the `joinChannelByToken` method in the `AgoraRtcChannel`class: After calling `publish` for Channel 1, you need to call `unpublish` for Channel 1 before calling `publish` for Channel 2.

- When joining multiple channels using both the  `AgoraRtcEngineKit` and `AgoraRtcChannel` classes:
  - In the communication profile, if you join Channel 1 using the `AgoraRtcEngineKit` class and Channel 2 using the `AgoraRtcChannel` class, you cannot call `publish` in the `AgoraRtcChannel` class.
  - In the live streaming profile, if you join Channel 1 using the `AgoraRtcEgineKit` class and Channel 2 through the `AgoraRtcChannel` class, you cannot call `publish` in the `AgoraRtcChannel` class.
  - In the live streaming profile, after joining multiple channels, you cannot call the `publish` method in the `AgoraRtcChannel` class as an audience.
  - After calling `publish` in the `AgoraRtcChannel` class, you need to call `unpublish` in the `AgoraRtcChannel` class; otherwise, you cannot call `joinChannelByToken` in the `AgoraRtcEngineKit` class.