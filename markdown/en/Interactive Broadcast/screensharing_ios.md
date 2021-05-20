---
title: Share the Screen
platform: iOS
updatedAt: 2021-01-06 05:10:54
---
## Introduction

Screen sharing enables the host of an interactive live streaming broadcast or video call to display what is on their screen to other users in the channel. This technology has many obvious advantages for communicating information, particularly in the following scenarios:

- During video conferencing, the speaker can share a local image, web page, or full presentation with other participants.
- For online instruction, the teacher can share slides or notes with students.

## Sample Project

Agora provides an open-source [sample project ](https://github.com/AgoraIO/API-Examples/tree/master/iOS/APIExample/Examples/Advanced/ScreenShare)on GitHub that implements iOS screen sharing. You can try the sample project and view the source code.

The following table lists the main code files for the sample project:

| File/Folder                                                  | Description                                                  |
| :----------------------------------------------------------- | :----------------------------------------------------------- |
| [Agora-ScreenShare-Extension](https://github.com/AgoraIO/API-Examples/tree/master/iOS/Agora-ScreenShare-Extension) | The Extension for the screen-sharing process. The main code files are as follows: <ul><li> [SampleHandler.swift](https://github.com/AgoraIO/API-Examples/blob/master/iOS/Agora-ScreenShare-Extension/SampleHandler.swift)：Records the screen with Apple ReplayKit. </li><li> [AgoraUploader.swift](https://github.com/AgoraIO/API-Examples/blob/master/iOS/Agora-ScreenShare-Extension/AgoraUploader.swift)：Uses the custom source function of the SDK to capture the screen recording data and send it to other users in the channel. </li></ul>|
| [ScreenShare.swift](https://github.com/AgoraIO/API-Examples/blob/master/iOS/APIExample/Examples/Advanced/ScreenShare/ScreenShare.swift) | The main code of the screen-sharing app, which allows the local user to join a channel and enable screen sharing. |



## Implementation

Before you begin, ensure that you understand how to start a video call or start interactive video streaming. For details, see [Start a Video Call](https://docs-preprod.agora.io/en/Interactive%20Broadcast/start_call_ios) or [Start Interactive Video Streaming](https://docs-preprod.agora.io/en/Interactive%20Broadcast/start_live_ios).

Screen sharing on iOS is implemented by using the native iOS ReplayKit framework in an Extension to record the screen and treating the screen-sharing stream as a user joining the channel. As Apple does not support the communication between an Extension process and the main app process, you need to create a separate process for the screen-sharing stream.

![](https://web-cdn.agora.io/docs-files/1606371600705)

Refer to the following steps to implement screen sharing:

- Create a process for screen sharing with a Broadcast Upload Extension.
- Record the screen with Apple ReplayKit.
- Send screen-recording data as a custom video source to the Agora SDK, and use the Agora SDK to publish the video stream.

<div class="alert note">The implementation method introduced in this article applies to iOS 12.0 or later.</div>

### 1. Create an Extension for screen sharing

Create a Broadcast Upload Extension with the following steps:

1. Open the project file with Xcode, and select **Editor > Add Target...** in the menu bar.

2. In the pop-up window, choose **Broadcast Upload Extension** on the iOS page, and click **Next**.
   ![](https://web-cdn.agora.io/docs-files/1606371630501)

3. In the **Product Name** field, enter a name for the Extension, for example, Agora-ScreenShare, and click **Finish**.
   You should now see a folder for the Extension in your project; this folder holds the code for implementing screen sharing.
   ![](https://web-cdn.agora.io/docs-files/1606371653521)

4. Open the Podfile in the project, and add dependencies to the Extension.

   ```
   target 'Agora-ScreenShare-Extension' do
   
     use_frameworks!
   
     pod 'AgoraRtcEngine_iOS', '~> 3.1.1'
   
     # Use the following code to achieve media stream encryption
     # pod 'AgoraRtcEngine_iOS_Crypto', '~> 3.1.1'
   
   end
   ```

   

5. Run the `pod install` command in the project root directory to install the dependencies.

### 2. Use the Extension for screen sharing in the project

Add `RPSystemBroadcastPickerView` to the view of the app as a button to start screen recording.

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

### 3. Set up custom video source

Use the custom video source function of the Agora SDK to send the system-recorded screen data to remote users for screen sharing.

Create an instance of `AgoraRtcEngineKit` for the screen-sharing stream, and set up the custom video source function.

```
// Swift
private static let sharedAgoraEngine: AgoraRtcEngineKit = {
    let kit = AgoraRtcEngineKit.sharedEngine(withAppId: KeyCenter.AppId, delegate: nil)

    kit.enableVideo()
    // Use custom video sources
    kit.setExternalVideoSource(true, useTexture: true, pushMode: true)

    // Do not receive video and audio streams from all remote users
    kit.muteAllRemoteVideoStreams(true)
    kit.muteAllRemoteAudioStreams(true)

    return kit
}()
```



### 4. Get screen data

Use Apple's native ReplayKit framework for screen recording.

1. In the `Info.plist` file in the Extension for screen sharing, set the `RPBroadcastProcessMode` as `RPBroadcastProcessModeSampleBuffer.`

2. Start screen recording in the `broadcastStarted` callback.

    <div class="alert note"> The channel name in the code example is set as <code>ScreenShare</code>. If you want the user to enter the channel name, you must use App Group to pass the parameter value of the main process to the Extension.</div>

   ```
   // Swift
   override func broadcastStarted(withSetupInfo setupInfo: [String : NSObject]?) {
       AgoraUploader.startBroadcast(to: "ScreenShare")
   
       DispatchQueue.main.async {
           Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) {[weak self] (timer:Timer) in
               guard let weakSelf = self else {return}
               let elapse = Int64(Date().timeIntervalSince1970 * 1000) - weakSelf.lastSendTs
               print("elapse: \(elapse)")
               // If the inter-frame interval of the video is too long, resend the previous frame.
               if(elapse > 300) {
                   if let buffer = weakSelf.bufferCopy {
                       weakSelf.processSampleBuffer(buffer, with: .video)
                   }
               }
           }
       }
   }
   ```

   

   

3. Send the system-collected data to the Agora SDK.
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
               // Send video buffer
               AgoraUploader.sendVideoBuffer(sampleBuffer)
           @unknown default:
               break
           }
       }
   }
   ```
	 
     Use `pushExternalVideoFrame` to enable `sendVideoBuffer`.

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

   

4. Call `joinChannelByToken` in the `AgoraRtcEngineKit` instance corresponding to the screen-sharing stream to join the channel, and then start screen sharing.

   ```
   // Swift
   static func startBroadcast(to channel: String) {
       print("joining \(channel)")
       sharedAgoraEngine.joinChannel(byToken: nil, channelId: channel, info: nil, uid: SCREEN_SHARE_UID, joinSuccess: nil)
   }
   ```

## Considerations

- The memory limit of a Broadcast Upload Extension is 50 MB. Ensure that your memory usage does not exceed this limit.

- If you need to share both the screen and audio of the app at the same time, you can use the custom audio source function. See [AgoraAudioTube.mm](http://agoraaudiotube.mm/) for the code.

- In the screen-sharing process, you need to call `muteAllRemoteVideoStreams` and `muteAllRemoteAudioStreams` to cancel receiving streams from remote users and avoid double subscriptions.

- For the main process, the screen-sharing stream is equivalent to a remote user in the channel. To avoid unnecessary costs, you can exclude the screen-sharing stream when setting up the remote user view.

  ```
  // Swift
  // Determine if the uid is used for a screen-sharing stream
  func isScreenShareUid(uid: UInt) -> Bool {
      return uid >= SCREEN_SHARE_UID_MIN && uid <= SCREEN_SHARE_UID_MAX
  }
  
  // The callback of adding remote users to the channel
  func rtcEngine(_ engine: AgoraRtcEngineKit, didJoinedOfUid uid: UInt, elapsed: Int) {
      LogUtils.log(message: "remote user join: \(uid) \(elapsed)ms", level: .info)
      
      // In the case of a uid for screen sharing, ignore
      if(isScreenShareUid(uid: uid)) {
          LogUtils.log(message: "Ignore screen share uid", level: .info)
          return
      }
      
      // Set up the remote user view
      ......
  }
  ```

