---
title: Start Interactive Live Audio Streaming
platform: iOS
updatedAt: 2021-01-20 05:46:29
---
Use this guide to quickly start the interactive live audio streaming demo with the Agora Voice SDK for iOS.

## Sample project

We provide an open-source [OpenLive-Voice-Only-iOS-Objective-C](https://github.com/AgoraIO/Basic-Audio-Broadcasting/tree/master/OpenLive-Voice-Only-iOS-Objective-C) or [OpenLive-Voice-Only-iOS](https://github.com/AgoraIO/Basic-Audio-Broadcasting/tree/master/OpenLive-Voice-Only-iOS) demo project that implements the basic interactive live audio streaming on GitHub. You can try the demo and view the source code.

## Prerequisites

- Xcode 9.0 or later (the interface description in this article is based on Xcode 11.0).
- An iOS device running iOS 8.0 or later.
- A valid [Agora account](https://docs.agora.io/en/Agora%20Platform/sign_in_and_sign_up?platform=iOS).

<div class="alert note">If your network has a firewall, follow the instructions in <a href="https://docs.agora.io/en/Agora%20Platform/firewall?platform=iOS">Firewall Requirements</a> to access Agora services.</div>

## Create an iOS project

1. Open Xcode, and click **Create a new Xcode project**.

2. Choose **iOS** as the target platform,  **Single View App** as the template, and click **Next**.

3. Input the project information, such as the product name, team, organization name, and language, and click **Next**.

   <div class="alert note">If you have not added any team information, you can see an <b>Add account...</b> button. Click it, input your Apple ID, and click <b>Next</b> to add your team.</div>

4. Choose the storage path of the project, and click **Create**.

## <a name="integrate_sdk"></a>Integrate the SDK

Choose one of the following methods to obtain the Agora iOS SDK:

<div class="alert info">If you need to integrate SDK with versions earlier than v3.3.0, see integration steps in <a href="#earlierversion">Integrate earlier versions of the SDK</a>.</div>

### Method 1: Through CocoaPods

1. Ensure that you have installed CocoaPods before the following steps. See the installation guide in [Getting Started with CocoaPods](https://guides.cocoapods.org/using/getting-started.html#getting-started).

2. In Terminal, navigate to the project path, and run the `pod init` command to create a `Podfile` in the project folder.

3. Open the `Podfile`, delete all contents, and input the following codes. Remember to replace `Your App` with the target name of your project.


```
# platform :ios, '9.0' use_frameworks!
target 'Your App' do
    pod 'AgoraAudio_iOS'
end
```


4. Return to Terminal, and run the `pod install` command to install the Agora SDK. Once you successfully install the SDK, it shows `Pod installation complete!` in Terminal, and you can see an `xcworkspace` file in the project folder.

5. Open the generated `xcworkspace` file.

### Method 2: Through the Agora website

1. Navigate to [SDK Downloads](./downloads?platform=iOS), download the latest version of the Agora iOS SDK, and extract the files from the downloaded SDK package.

2. According to your requirements, copy the libraries from the `libs` folder of the SDK to the `./project_name` folder in your project (`project_name` is an example of your project name).

 <div class="alert note">The libraries with the <code>Extension</code> suffix are optional. Add the corresponding libraries according to your needs. For the feature of each extension library, see <a href="./release_ios_video?platform=iOS">Release Notes</a >.</div>

3. Open Xcode, and navigate to **TARGETS > Project Name > General > Frameworks, Libraries, and Embedded Content**.

4. Click **+** > **Add Other…** > **Add Files** to add the cooresponding libraries. Ensure that the **Embed** attribute of these dynamic libraries is **Embed & Sign**.

   Once these dynamic libraries are added, the project automatically links to other system libraries.

   <div class="alert note"><ul><li>According to the official requirements of Apple, the Extension of an app cannot contain the dynamic library. If you need to integrate the SDK with the dynamic library in the Extension, change the file status to <b>Do Not Embed</b>.</li><li>The Agora SDK uses libc++ (LLVM) by default. Contact support@agora.io if you want to use libstdc++ (GNU). The SDK provides FAT image libraries with multi-architecture support for both 32/64-bit audio emulators and 32/64-bit audio/video real devices.</li></ul></div>

## Implement the basic interactive live streaming

This section introduces how to use the Agora Voice SDK to make the interactive live streaming. The following figure shows the API call sequence of the interactive live audio streaming.
![](https://web-cdn.agora.io/docs-files/1585490874581)

### 1. Create the UI

Create the user interface (UI) for the interactive live audio streaming in your project. Skip to [Import the class](#ImportClass) if you already have a UI in your project.

When you are implementing the interactive live audio streaming, we recommend adding the following elements into the UI:

- The window for interactive live audio streaming
- The exit button
	
When you use the UI setting of the demo project, you can see the following interface:

![](https://web-cdn.agora.io/docs-files/1585490926278)

### <a name="ImportClass"></a>2. Import the class

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

<div class="alert note"> The RTC Native SDK uses libc++ (LLVM) by default. Contact <a href="mailto:support@agora.io">support@agora.io</a > if you want to use libstdc++ (GNU). The SDK provides FAT image libraries with multi-architecture support for both 32/64-bit audio emulators and 32/64-bit audio real devices.</div>

### 3. Initialize AgoraRtcEngineKit

Create and initialize the `AgoraRtcEngineKit` object before calling any other Agora APIs.

Call the `sharedEngineWithAppId` method and pass in the App ID to initialize the `AgoraRtcEngineKit` object.

You can also listen for callback events, such as when the host joins the channel and leaves the channel. 

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

### 4. Set the channel profile

After initializing the `AgoraRtcEngineKit` object, call the `setChannelProfile` method to set the channel profile as `LiveBroadcasting`. 

One `AgoraRtcEngineKit` object uses one profile only. If you want to switch to another profile, destroy the current `AgoraRtcEngineKit` object with the `destroy` method and create a new one before calling the `setChannelProfile` method.

```objective-c
// Objective-C
// Set the channel profile.
[self.agoraKit setChannelProfile:AgoraChannelProfileLiveBroadcasting];
```

```swift
// Swift
// Set the channel profile.
agoraKit.setChannelProfile(.liveBroadcasting)
```

### 5. Set the client role

An interactive streaming channel has two client roles: `Broadcaster` and `Audience`, and the default role is `Audience`. After setting the channel profile to `LiveBroadcasting`, your app may use the following steps to set the client role:

1. Allow the user to set the role as `Broadcaster` or `Audience`. 
2. Call the `setClientRole` method and pass in the client role set by the user.

Note that in the interactive live streaming, only the host can be heard. If you want to switch the client role after joining the channel, call the `setClientRole` method.

```objective-c
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

```swift
// Swift
// Set the client role.
agoraKit.setClientRole(.audience)
agoraKit.setClientRole(.broadcaster)
```

### <a name="JoinChannel"></a>6. Join a channel

After setting the client role, you can call the `joinChannelByToken` method to join a channel. In this method, set the following parameters:

- `channelId`: Specify the channel name that you want to join. Input your `channelId` before running the sample code.
- `token`: Pass a token that identifies the role and privilege of the user.  You can set it as one of the following values:
	- `nil`.
	- A temporary token generated in Console. A temporary token is valid for 24 hours. For details, see [Get a Temporary Token](https://docs.agora.io/en/Agora%20Platform/token#get-a-temporary-token).
	- A token generated at the server. This applies to scenarios with high-security requirements. For details, see [Generate a token from Your Server](./token_server).
	<div class="alert note">If your project has enabled the app certificate, ensure that you provide a token.</div>
- `uid`: ID of the local user that is an integer and should be unique. If you set `uid` as `0`,  the SDK assigns a user ID for the local user and returns it in the `joinSuccessBlock` callback.

 <div class="alert note">Once the user joins the channel, the user subscribes to the audio streams of all the other users in the channel by default, giving rise to usage and billing calculation. If you do not want to subscribe to a specified stream or all remote streams, call the <tt>mute</tt> methods accordingly.</div>
 
- `joinSuccessBlock`: Returns that the user joins the specified channel. It is same as `didJoinChannel`. We recommend setting `joinSuccessBlock` as `nil`, so that the SDK can trigger the `didJoinChannel` callback.

For more details on the parameter settings, see [joinChannelByToken](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/joinChannelByToken:channelId:info:uid:joinSuccess:).

<div class="alert note">For RTC Native SDKs prior to v3.0.0, you need to call <code>enableWebSdkInteroperability</code> to enable the interoperability with the RTC Web SDK if there is a Web users in the channel. As of v3.0.0, the RTC Native SDK enables its interoperability with the RTC Web SDK by default.</div>

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
// Join a channel with a token.
agoraKit.joinChannel(byToken: KeyCenter.Token, channelId: channelId, info: nil, uid: 0, joinSuccess: nil)
```

### 7. Leave the channel

Call the `leaveChannel` method to leave the current channel according to your scenario, for example, when the interactive live streaming ends, when you need to close the app, or when your app runs in the background.

```objective-c
// Objective-C
    // Leave the channel.
    [self.rtcEngine leaveChannel:nil];
    if (self.isBroadcaster) {
        [self.rtcEngine stopPreview];
    }
```

```swift
// Swift
func leaveChannel() {       
    setIdleTimerActive(true)
    // Leave the channel.
    agoraKit.leaveChannel(nil)
    if settings.role == .broadcaster {
       agoraKit.stopPreview()
    }
    navigationController?.popViewController(animated: true)
    }
```

## Run the project

Run the project on your iOS device. When you set the role as the host and successfully start the interactive live audio streaming, you can hear the voice of the host in the app.

## Reference

- [How can I set the log file?](https://docs.agora.io/en/faq/logfile)
- [How can I listen for an audience joining or leaving an interactive live streaming channel?](https://docs.agora.io/en/faq/audience_event)
- [Why do I see a prompt to find local network devices when launching an iOS app?](https://docs.agora.io/en/faq/local_network_privacy)