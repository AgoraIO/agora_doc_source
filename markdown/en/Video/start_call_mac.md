---
title: Start a Video Call
platform: macOS
updatedAt: 2021-01-28 10:32:57
---
Use this guide to quickly start a basic video call demo with the Agora Video SDK for macOS.

## Sample project

We provide an open-source [Agora-macOS-Tutorial-Objective-C-1to1](https://github.com/AgoraIO/Basic-Video-Call/tree/master/One-to-One-Video/Agora-macOS-Tutorial-Objective-C-1to1) or [Agora-macOS-Tutorial-Swift-1to1](https://github.com/AgoraIO/Basic-Video-Call/tree/master/One-to-One-Video/Agora-macOS-Tutorial-Swift-1to1) demo project that implements the basic one-to-one video call on GitHub. You can try the demo and view the source code.

## Prerequisites

- Xcode 9.0 or later (the interface description in this article is based on Xcode 11.0).
- A macOS device running macOS 10.10 or later.
- A valid [Agora account](https://docs.agora.io/en/Agora%20Platform/sign_in_and_sign_up?platform=macOS).

<div class="alert note">If your network has a firewall, follow the instructions in <a href="https://docs.agora.io/en/Agora%20Platform/firewall?platform=macOS">Firewall Requirements</a> to access Agora services.</div>

## Create a macOS project

1. Open Xcode, and click **Create a new Xcode project**.

2. Choose **macOS** as the target platform,  **App** as the template, and click **Next**.

3. Input the project information, such as the product name, team, organization name, and language, and click **Next**.

   <div class="alert note">If you have not added any team information, you can see an <b>Add account...</b> button. Click it, input your Apple ID, and click <b>Next</b> to add your team.</div>

4. Choose the storage path of the project, and click **Create**.

## <a name="integrate_sdk"></a>Integrate the SDK

Choose one of the following methods to obtain the Agora macOS SDK:

<div class="alert info">If you need to integrate SDK with versions earlier than v3.2.0, see integration steps in <a href="#earlierversion">Integrate earlier versions of the SDK</a>.</div>

### Method 1: Through CocoaPods

1. Ensure that you have installed CocoaPods before the following steps. See the installation guide in [Getting Started with CocoaPods](https://guides.cocoapods.org/using/getting-started.html#getting-started).

2. In Terminal, navigate to the project path, and run the `pod init` command to create a `Podfile` in the project folder.

3. Open the `Podfile`, delete all contents, and input the following codes. Remember to replace `Your App` with the target name of your project.

```
# platform :macOS, '10.11' use_frameworks!
target 'Your App' do
  pod 'AgoraRtcEngine_macOS'
end
```

4. Return to Terminal, and run the `pod install` command to install the Agora SDK. Once you successfully install the SDK, it shows `Pod installation complete!` in Terminal, and you can see an `xcworkspace` file in the project folder.

5. Open the generated `xcworkspace` file.

### Method 2: Through the Agora website

1. Navigate to [SDK Downloads](./downloads?platform=macOS), download the latest version of the Agora macOS SDK, and extract the files from the downloaded SDK package.

2. According to your requirements, copy the libraries from the `libs` folder of the SDK to the `./project_name` folder in your project (`project_name` is an example of your project name).

 <div class="alert note">The libraries with the <code>Extension</code> suffix are optional. Add the corresponding libraries according to your needs. For the feature of each extension library, see <a href="./release_mac_video?platform=macOS">Release Notes</a >.</div>

3. Open Xcode, and navigate to **TARGETS > Project Name > General > Frameworks, Libraries, and Embedded Content**.

4. Click **+** > **Add Other…** > **Add Files** to add the cooresponding libraries. Ensure that the **Embed** attribute of these dynamic libraries is **Embed & Sign**.

  <div class="alert note"><ul><li>According to the official requirements of Apple, the Extension of an app cannot contain the dynamic library. If you need to integrate the SDK with the dynamic library in the Extension, change the file status to <b>Do Not Embed</b>.</li><li>The Agora SDK uses libc++ (LLVM) by default. Contact support@agora.io if you want to use libstdc++ (GNU). The SDK provides FAT image libraries with multi-architecture support for both 32/64-bit audio emulators and 32/64-bit audio/video real devices.</li></ul></div>

## Implement the basic video call

This section introduces how to use the Agora Video SDK to make a video call. The following figure shows the API call sequence of a basic one-to-one video call.
![](https://web-cdn.agora.io/docs-files/1568261526750)

### 1. Create the UI

Create the user interface (UI) for the one-to-one call in your project. Skip to [Import the class](#ImportClass) if you already have a UI in your project.

When you are implementing a video call, we recommend adding the following elements into the UI:	
- The local video view
- The remote video view
- The end-call button

When you use the UI setting of the demo project, you can see the following interface:

![](https://web-cdn.agora.io/docs-files/1568801689092)

### <a name="ImportClass"></a> 2. Import the class

Import the `AgoraRtcKit` class in your project.

```objective-c
// Objective-C
// As of v3.0.0, the SDK uses the AgoraRtcKit object.
#import <AgoraRtcKit/AgoraRtcEngineKit.h>
// The SDK of a version earlier than v3.0.0 uses the AgoraRtcEngineKit object.
#import <AgoraRtcEngineKit/AgoraRtcEngineKit.h>
```

```swift
// Swift
// As of v3.0.0, the SDK uses the AgoraRtcKit object.
import AgoraRtcKit
// The SDK of a version earlier than v3.0.0 uses the AgoraRtcEngineKit object.
import AgoraRtcEngineKit
```

<div class="alert note">The Agora Video SDK uses libc++ (LLVM) by default. Contact Agora support If you want to use libstdc++ (GNU). The SDK provides FAT image libraries with multi-architecture support for both 32/64-bit audio emulators and 32/64-bit audio/video real devices.</div>

### 3. Initialize AgoraRtcEngineKit

Create and initialize the `AgoraRtcEngineKit` object before calling any other Agora APIs.

Call the `sharedEngineWithAppId` method and pass in the App ID to initialize the `AgoraRtcEngineKit` object.

You can also listen for callback events, such as when the local user joins the channel, and when the first video frame of a remote user is decoded. 

```objective-c
// Objective-C
- (void)initializeAgoraEngine {
    // Input your App ID to initialize the AgoraRtcEngineKit object.
    self.agoraKit = [AgoraRtcEngineKit sharedEngineWithAppId:appID delegate:self];
}
```

```swift
// Swift
func initializeAgoraEngine() {
   // Initialize the AgoraRtcEngineKit object.
   agoraKit = AgoraRtcEngineKit.sharedEngine(withAppId: AppID, delegate: self)
}
```

### 4. Set the local video view

After initializing the `AgoraRtcEngineKit` object, set the local video view before joining the channel so that you can see yourself in the call. Follow these steps to configure the local video view: 

- Call the `enableVideo` method to enable the video module. 
- Call the `setupLocalVideo` method to configure the local video display settings. 

```objective-c
// Objective-C
- (void)setupVideo {
  // Enable the video
  [self.agoraKit enableVideo];
}
- (void)setupLocalVideo {
    AgoraRtcVideoCanvas *videoCanvas = [[AgoraRtcVideoCanvas alloc] init];
    videoCanvas.uid = 0;
    videoCanvas.view = self.localVideo;
    videoCanvas.renderMode = AgoraVideoRenderModeHidden;
    // Set the local video view.
    [self.agoraKit setupLocalVideo:videoCanvas];
}
```

```swift
// Swift
func setupVideo() {
    // Enable the video
    agoraKit.enableVideo()
}
func setupLocalVideo() {
  let videoCanvas = AgoraRtcVideoCanvas()
  videoCanvas.uid = 0
  videoCanvas.view = localVideo
  videoCanvas.renderMode = .hidden
  // Set the local video view.
  agoraKit.setupLocalVideo(videoCanvas)
}
```

### <a name="JoinChannel"></a>5. Join a channel

After initializing the `AgoraRtcEngineKit` object and setting the local video view, you can call the `joinChannelByToken` method to join a channel. In this method, set the following parameters:

- `channelId`: Specify the channel name that you want to join. Input your `channelId` before running the sample code.

- `token`: Pass a token that identifies the role and privilege of the user. You can set it as one of the following values:
  - `nil`.
  - A temporary token generated in Console. A temporary token is valid for 24 hours. For details, see [Get a Temporary Token](https://docs.agora.io/en/Agora%20Platform/token#get-a-temporary-token).
  - A token generated at the server. This applies to scenarios with high-security requirements. For details, see [Generate a token from Your Server](./token_server).

  <div class="alert note">If your project has enabled the app certificate, ensure that you provide a token.</div>

- `uid`: ID of the local user that is an integer and should be unique. If you set `uid` as 0,  the SDK assigns a user ID for the local user and returns it in the `joinSuccessBlock` callback.

- `joinSuccessBlock`: Returns that the user joins the specified channel. It is same as `didJoinChannel`. We recommend setting `joinSuccessBlock` as `nil`, so that the SDK can trigger the `didJoinChannel` callback.

For more details on the parameter settings, see [joinChannelByToken](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/joinChannelByToken:channelId:info:uid:joinSuccess:).

```objective-c
// Objective-C
- (void)joinChannel {
    // Join a channel with a token.
    [self.agoraKit joinChannelByToken:token channelId:@"demoChannel1" info:nil uid:0 joinSuccess:^(NSString *channel, NSUInteger uid, NSInteger elapsed) {
    }];
}
```

```swift
// Swift
func joinChannel() {
    // Join a channel with a token.
    agoraKit.joinChannel(byToken: Token, channelId: "demoChannel1", info:nil, uid:0) { [unowned self] (channel, uid, elapsed) -> Void in}
    self.isLocalVideoRender = true
            self.logVC?.log(type: .info, content: "did join channel")
        }
        isStartCalling = true
}
```

### 6. Set the remote video view

In a video call, you should be able to see other users too. This is achieved by calling the `setupRemoteVideo` method after joining the channel.

Shortly after a remote user joins the channel, the SDK gets the remote user's ID in the `firstRemoteVideoDecodedOfUid` callback. Call the `setupRemoteVideo` method in the callback, and pass in the uid to set the video view of the remote user.

```objective-c
// Objective-C
// Listen for the firstRemoteVideoDecodedOfUid callback.
// This callback occurs when the first video frame of a remote user is received and decoded after the remote user successfully joins the channel.
// You can call the setupRemoteVideo method in this callback to set up the remote video view.
- (void)rtcEngine:(AgoraRtcEngineKit *)engine firstRemoteVideoDecodedOfUid:(NSUInteger)uid size: (CGSize)size elapsed:(NSInteger)elapsed {
    if (self.remoteVideo.hidden) {
        self.remoteVideo.hidden = NO;
    }
    AgoraRtcVideoCanvas *videoCanvas = [[AgoraRtcVideoCanvas alloc] init];
    videoCanvas.uid = uid;
    videoCanvas.view = self.remoteVideo;
    videoCanvas.renderMode = AgoraVideoRenderModeHidden;
    // Set the remote video view.
    [self.agoraKit setupRemoteVideo:videoCanvas];
}
```

```swift
// Swift
// Listen for the firstRemoteVideoDecodedOfUid callback.
// This callback occurs when the first video frame of a remote user is received and decoded after the remote user successfully joins the channel.
// You can call the setupRemoteVideo method in this callback to set up the remote video view.
func rtcEngine(_ engine: AgoraRtcEngineKit, firstRemoteVideoDecodedOfUid uid:UInt, size:CGSize, elapsed:Int) {
        isRemoteVideoRender = true
        let videoCanvas = AgoraRtcVideoCanvas()
        videoCanvas.uid = uid
        videoCanvas.view = remoteVideo
        videoCanvas.renderMode = .hidden
        // Set the remote video view.
        agoraKit.setupRemoteVideo(videoCanvas)
    }
```

### 7. Leave the channel

Call the `leaveChannel` method to leave the current call according to your scenario, for example, when the call ends, when you need to close the app, or when your app runs in the background.

```objective-c
// Objective-C
- (void)leaveChannel {
    // Leave the channel.
    [self.agoraKit leaveChannel:^(AgoraChannelStats *stat)
}
```

```
// Swift
func leaveChannel() {
// Leave the channel.
 AgoraKit.leaveChannel(nil)
 AgoraKit.setupLocalVideo(nil)
 remoteVideo.removeFromSuperview()
 localVideo.removeFromSuperview()
 delegate?.VideoChatNeedClose(self)
 AgoraKit = nil
 view.window!.close()
 }
```

## Run the project
Run the project on your macOS device. You can see both the local and remote video views when you successfully start a one-to-one video call in the app.

## Reference
- We provide an open-source [OpenVideoCall-macOS](https://github.com/AgoraIO/Basic-Video-Call/tree/master/Group-Video/OpenVideoCall-macOS) sample project that implements the group video call on GitHub. For scenarios involving group video calls, you can download the demo project as a code source reference.
- [How can I set the log file?](https://docs.agora.io/en/faq/logfile)
- [How can I solve black screen issues?](https://docs.agora.io/en/faq/video_blank)