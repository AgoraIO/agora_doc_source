---
title: Start Interactive Live Video Streaming
platform: macOS
updatedAt: 2021-01-08 08:48:11
---
Use this guide to quickly start an interactive broadcast demo with the Agora Video SDK for macOS.

The difference between a broadcast and a call is that users have roles in a broadcast. You can set your role as either Broadcaster or Audience. The broadcaster sends and receives streams while the audience receives streams only.

## Try the demo

We provide an open-source [OpenLive-macOS-Objective-C](https://github.com/AgoraIO/Basic-Video-Broadcasting/tree/master/OpenLive-macOS-Objective-C)/[OpenLive-macOS-Swift](https://github.com/AgoraIO/Basic-Video-Broadcasting/tree/master/OpenLive-macOS) demo project that implements the basic video broadcast on GitHub. You can try the demo and view the source code.

## Prerequisites

- Xcode 9.0 or later
- A macOS device running macOS 10.10 or later
- A valid Agora account. ([Sign up](https://sso.agora.io/en/signup) for free)
- Ensure that you whitelist the specific domains and ports on your firewall before using Agora's services. See details in [Firewall Requirements](https://docs.agora.io/en/Agora%20Platform/firewall?platform=All%20Platforms).

## Set up the development environment

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

## Implement the basic broadcast

This section introduces how to use the Agora SDK to make an interactive broadcast. The following figure shows the API call sequence of a basic video broadcast.

![](https://web-cdn.agora.io/docs-files/1568191306820)

### 1. Create the UI

Create the user interface (UI) for the interactive broadcast your project. Skip to [Import the class](#ImportClass) if you already have a UI in your project.
<details>
	<summary><font color="#3ab7f8">Create the UI</font></summary>
	
For a video broadcast, we recommend adding the following elements into the UI:

- The view of the broadcaster
- The exit button
</details>
	
### <a name=“ImportClass”></a>2. Import the class

Import the [AgoraRtcEngineKit](https://docs.agora.io/en/Voice/API%20Reference/oc/Classes/AgoraRtcEngineKit.html) class in your project.
```
// Objective-C
#import <AgoraRtcEngineKit/AgoraRtcEngineKit.h>
```
**Note**: The SDK provides FAT image libraries with multi-architecture support for both 32/64-bit audio emulators and 32/64-bit audio/video real devices.

```
// Swift
import AgoraRtcEngineKit
```

### 3. Initialize AgoraRtcEngineKit

Create and initialize the [AgoraRtcEngineKit](https://docs.agora.io/en/Voice/API%20Reference/oc/Classes/AgoraRtcEngineKit.html) object before calling any other Agora APIs.

In this step, you need to use the App ID of your project. Follow these steps to [create an Agora project](https://docs.agora.io/en/Agora%20Platform/manage_projects?platform=All%20Platforms) in Console and get an [App ID](https://docs.agora.io/en/Agora%20Platform/terms?platform=All%20Platforms#a-nameappidaapp-id ).

1. Go to [Console](https://dashboard.agora.io/) and click the **[Project Management](https://dashboard.agora.io/projects)** icon ![](https://web-cdn.agora.io/docs-files/1551254998344) on the left navigation panel. 
2. Click **Create** and follow the on-screen instructions to set the project name, choose an authentication mechanism, and Click **Submit**. 
3. On the **Project Management** page, find the **App ID** of your project. 

Call the [sharedEngineWithAppId](https://docs.agora.io/en/Voice/API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/sharedEngineWithAppId:delegate:) method and pass in the App ID to initialize the `AgoraRtcEngineKit` object.

You can also listen for callback events, such as when the local user joins the channel, and when the first video frame of a remote user is decoded. 

```
// Objective-C
- (void)initializeAgoraEngine {
    // Input your App ID to initialize the AgoraRtcEngineKit object.
    self.agoraKit = [AgoraRtcEngineKit sharedEngineWithAppId:appID delegate:self];
}
```

```
// Swift
func initializeAgoraEngine() {
   // Initialize the AgoraRtcEngineKit object.
   agoraKit = AgoraRtcEngineKit.sharedEngine(withAppId: AppID, delegate: self)
}
```

### 4. Set the channel profile

After initializing the [AgoraRtcEngineKit](https://docs.agora.io/en/Voice/API%20Reference/oc/Classes/AgoraRtcEngineKit.html) object, call the [setChannelProfile](https://docs.agora.io/en/Video/API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setChannelProfile:) method to set the channel profile as Live Broadcast. 

One `AgoraRtcEngineKit` object uses one profile only. If you want to switch to another profile, destroy the current `AgoraRtcEngineKit` object with the [destroy](https://docs.agora.io/en/Video/API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/destroy) method and create a new one before calling the `setChannelProfile` method.
```
// Objective-C
// Set the channel profile.
[self.agoraKit setChannelProfile:AgoraChannelProfileLiveBroadcasting];
```

```
// Swift
// Set the channel profile.
agoraKit.setChannelProfile(.liveBroadcasting)
```

### 5. Set the client role

A Live Broadcast channel has two client roles: `Broadcaster` and `Audience`, and the default role is `Audience`. After setting the channel profile to `Live Broadcast`, your app may use the following steps to set the client role:

1. Allow the user to set the role as `Broadcaster` or `Audience`. 
2. Call the [setClientRole](https://docs.agora.io/en/Video/API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setClientRole:) method and pass in the client role set by the user.

Note that in a live broadcast, only the broadcaster can be heard and seen. If you want to switch the client role after joining the channel, call the `setClientRole` method.

```
// Objective-C
 if (self.isBroadcaster) {
        self.clientRole = AgoraClientRoleAudience;
        if (self.fullSession.uid == 0) {
            self.fullSession = nil;
        }
    } else {
        self.clientRole = AgoraClientRoleBroadcaster;
    }
    // Set the client role.
    [self.rtcEngine setClientRole:self.clientRole];
```

```
// Swift
// Set the client role.
agoraKit.setClientRole(.audience)
agoraKit.setClientRole(.broadcaster)
```

### 6. Set the local video view

If you are implementing an audio broadcast, skip to [Join a channel](#JoinChannel).

After setting the channel profile and client role, set the local video view before joining the channel so that the broadcaster can see the local video in the broadcast. Follow these steps to configure the local video view:

1. Call the enableVideo method to enable the video module.
2. Call the setupLocalVideo method to configure the local video display settings. 
```
// Objective-C
// Enable the video module.
[self.agoraKit enableVideo];
- (void)setupLocalVideo {
    AgoraRtcVideoCanvas *videoCanvas = [[AgoraRtcVideoCanvas alloc] init];
    videoCanvas.uid = 0;
    videoCanvas.view = self.localVideo;
    videoCanvas.renderMode = AgoraVideoRenderModeHidden;
    // Setup the local video view.
    [self.agoraKit setupLocalVideo:videoCanvas];
}
```

```
// Swift
// Enable the video module.
agoraKit.enableVideo()
func addLocalSession() {
    let localSession = VideoSession.localSession()
    videoSessions.append(localSession)
    // Setup the local video view.
    agoraKit.setupLocalVideo(localSession.canvas) 
    let mediaInfo = MediaInfo(dimension: settings.dimension,
                                  fps: settings.frameRate.rawValue)
    localSession.mediaInfo = mediaInfo
    }
```

### <a name=“JoinChannel”></a>7. Join a channel

After initializing the [AgoraRtcEngineKit](https://docs.agora.io/en/Voice/API%20Reference/oc/Classes/AgoraRtcEngineKit.html) object and setting the local video view (for a video call), you can call the [joinChannelByToken](https://docs.agora.io/en/Voice/API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/joinChannelByToken:channelId:info:uid:joinSuccess:) method to join a channel. In this method, set the following parameters:

- `channelId`: Specify the channel name that you want to join. Input your `channelId` before running the sample code.
- * `token`: Pass a token that identifies the role and privilege of the user.  You can set it as one of the following values:
  * A temporary token generated in Console. A temporary token is valid for 24 hours. For details, see [Get a Temporary Token](token#get-a-temporary-token). When joining a channel, ensure that the channel name is the same with the one you use to generate the temporary token.
  * A token generated at the server. This applies to scenarios with high-security requirements. For details, see [Generate a token from Your Server](./token_server). When joining a channel, ensure that the channel name and `uid` is the same with those you use to generate the token.
  
 <div class="alert note"><ul><li>If your project has enabled the app certificate, ensure that you provide a token.</li><li>Ensure that you do not set <code>token</code> as "".</li></div>
- `uid`: ID of the local user that is an integer and should be unique. If you set `uid` as 0,  the SDK assigns a user ID for the local user and returns it in the `joinSuccessBlock` callback.
- `joinSuccessBlock`: Returns that the user joins the specified channel. It is same as [didJoinChannel](https://docs.agora.io/en/Video/API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:didJoinChannel:withUid:elapsed:). We recommend setting `joinSuccessBlock` as `nil`, so that the SDK can trigger the [didJoinChannel](https://docs.agora.io/en/Video/API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:didJoinChannel:withUid:elapsed:) callback.
```
// Objective-C
- (void)joinChannel {
    // Join a channel with a token.
    [self.agoraKit joinChannelByToken:token channelId:@"demoChannel1" info:nil uid:0 joinSuccess:^(NSString *channel, NSUInteger uid, NSInteger elapsed) {
    }];
}
```

```
// Swift
// Join a channel with a token.
agoraKit.joinChannel(byToken: KeyCenter.Token, channelId: channelId, info: nil, uid: 0, joinSuccess: nil)
```

### 8. Set the remote video view

In a video call, you should be able to see other users too. This is achieved by calling the [setupRemoteVideo](https://docs.agora.io/en/Video/API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setupRemoteVideo:) method after joining the channel.

Shortly after a remote user joins the channel, the SDK gets the remote user's ID in the [firstRemoteVideoDecodedOfUid](https://docs.agora.io/en/Video/API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:firstRemoteVideoDecodedOfUid:size:elapsed:) callback. Call the `setupRemoteVideo` method in the callback, and pass in the `uid` to set the video view of the remote user.

```
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

```
// Swift
// Listen for the firstRemoteVideoDecodedOfUid callback.
// This callback occurs when the first video frame of a remote user is received and decoded after the remote user successfully joins the channel.
// You can call the setupRemoteVideo method in this callback to set up the remote video view.
func rtcEngine(_ engine: AgoraRtcEngineKit, firstRemoteVideoDecodedOfUid uid: UInt, size: CGSize, elapsed: Int) {
    let userSession = videoSession(of: uid)
    userSession.updateMediaInfo(resolution: size)
    // Set the remote video view.
    agoraKit.setupRemoteVideo(userSession.canvas)
```

### 9. Leave the channel

Call the [leaveChannel](https://docs.agora.io/en/Video/API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/leaveChannel:) method to leave the current call according to your scenario, for example, when the call ends, when you need to close the app, or when your app runs in the background.

```
// Objective-C
- (void)leaveChannel {
    // Leave the channel.
    [self.agoraKit leaveChannel:^(AgoraChannelStats *stat) {
        [self.agoraKit leaveChannel:^(AgoraChannelStats *stat) {
        [self hideControlButtons];
        [self.remoteVideo removeFromSuperview];
        [self.localVideo removeFromSuperview];
    }];
}
```

```
// Swift
func leaveChannel() {       
    setIdleTimerActive(true)
    agoraKit.setupLocalVideo(nil)
    // Leave the channel.
    agoraKit.leaveChannel(nil)
    if settings.role == .broadcaster {
       agoraKit.stopPreview()
    }
    navigationController?.popViewController(animated: true)
    }
```

### Sample code

You can find the sample code logic in the [OpenLive-macOS-Objective-C](https://github.com/AgoraIO/Basic-Video-Broadcasting/tree/master/OpenLive-macOS-Objective-C)/[OpenLive-macOS-Swift](https://github.com/AgoraIO/Basic-Video-Broadcasting/tree/master/OpenLive-macOS) demo project.

## Run the project

Run the project on your macOS device. When you set the role as the broadcaster and successfully join a video broadcast, you can see the video view of yourself in the app. When you set the role as the audience and successfully join a video broadcast, you can see the video view of the broadcaster in the app.