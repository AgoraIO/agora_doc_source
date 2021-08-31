## Join Multiple Channels

The Agora Video SDK enables users to join an unlimited number of channels at the same time and  receive the audio and video streams of all the channels.

## Understand the tech

The SDK uses the `AgoraRtcConnection` and  `AgoraRtcEngineKitEx` classes to support the multi-channel functionality. `AgoraRtcEngineKitEx`  provides methods that apply to a specific `AgoraRtcConnection` object.

An `AgoraRtcConnection` object contains the following information to identify a connection:

- The channel name
- The ID of the local user

You can create multiple `AgoraRtcConnection` objects, each with a different channel name and user ID.

To join multiple channels, call `joinChannelExByToken` in the `AgoraRtcEngineKitEx` class multiple times with different `AgoraRtcConnection` objects.

- Ensure that each `AgoraRtcConnection` object has a unique user ID that is not `0`.
- You can configure the publishing and subscribing options for the `AgoraRtcConnection` object in `joinChannelExByToken`.
- Each `AgoraRtcConnection` can publish mutiple audio streams and a unique video stream independently.


## Prerequisites

Before proceeding, ensure that you have implemented the basic real-time communication functions in your project. For details, see [Start a Call](start_call_ios) or [Start Interactive Live Streaming](start_live_ios).

## Implementation

To implement the multi-channel functionality, do the following for each channel:

1. In your Agora project, define an `AgoraRtcConnection` object in the main file.

   ```swift
   let connection1 = AgoraRtcConnection()
   ```

2. Join a channel with a random user ID.

   ```swift
   var mediaOptions = AgoraRtcChannelMediaOptions()
   mediaOptions.autoSubscribeVideo = .of(true)
   mediaOptions.autoSubscribeAudio = .of(true)
   connection1.channelId = channelName1
   connection1.localUid = UInt.random(in: 1001...2000)
   var result = agoraKit.joinChannelEx(byToken: "your token", connection: connection1, delegate: channel1, mediaOptions: mediaOptions, joinSuccess: nil)
   channel1.channelId = channelName1
   channel1.connecitonDelegate = self
   if result != 0 {
       self.showAlert(title: "Error", message: "joinChannel1 call failed: \(result), please check your params")
   }
   ```

3. Set up the remote video in the `didJoinedOfUid` callback.

   ```swift
   func rtcEngine(_ engine: AgoraRtcEngineKit, channelId: String, didJoinedOfUid uid: UInt, elapsed: Int) {
       LogUtils.log(message: "remote user join: \(uid) \(elapsed)ms", level: .info)
   
       // Only one remote video view is available for this
       // tutorial. Here we check if there exists a surface
       // view tagged as this uid.
       let videoCanvas = AgoraRtcVideoCanvas()
       videoCanvas.uid = uid
       // the view to be binded
       videoCanvas.view = channelId == channelName1 ? channel1RemoteVideo.videoView : channel2RemoteVideo.videoView
       videoCanvas.renderMode = .hidden
       let connection = AgoraRtcConnection()
       agoraKit.setupRemoteVideoEx(videoCanvas, connection: connection)
   }
   ```

## Reference

This section provides the reference information you might need when implementing the multi-channel functionality.


### API reference

- [AgoraRtcEngineKitEx](./API%20Reference/ios_ng/API/class_irtcengineex.html)
- [joinChannelExByToken](./API%20Reference/ios_ng/API/class_irtcengineex.html#api_joinchannelex)
- [setupRemoteVideoEx](./API%20Reference/ios_ng/API/class_irtcengineex.html#api_setupremotevideoex)

### Sample project

Agora provides an open-source sample project [JoinMultipleChannel](https://github.com/AgoraIO/API-Examples/tree/4.0.0-preview/iOS/APIExample/Examples/Advanced/JoinMultiChannel) on GitHub. You can download it and refer to the source code.
