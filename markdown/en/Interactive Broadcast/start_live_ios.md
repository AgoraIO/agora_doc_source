---
title: Start Interactive Live Video Streaming
platform: iOS
updatedAt: 2021-01-20 03:19:45
---
Use this guide to quickly start the interactive live video streaming demo with the Agora Video SDK for iOS.

## Sample project

We provide an open-source [OpenLive-iOS-Objective-C](https://github.com/AgoraIO/Basic-Video-Broadcasting/tree/master/OpenLive-iOS-Objective-C) or [OpenLive-iOS-Swift](https://github.com/AgoraIO/Basic-Video-Broadcasting/tree/master/OpenLive-iOS) demo project that implements the basic interactive live video streaming on GitHub. You can try the demo and view the source code.

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
    pod 'AgoraRtcEngine_iOS'
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

This section introduces how to use the Agora Video SDK to start the interactive live video streaming. The following figure shows the API call sequence of the interactive live video streaming.
![](https://web-cdn.agora.io/docs-files/1570604527013)

### 1. Create the UI

Create the user interface (UI) for the interactive video streaming in your project. Skip to [Import the class](#ImportClass) if you already have a UI in your project.

If you are implementing the interactive video streaming, we recommend adding the following elements into the UI:

- The view of the host
- The exit button
	
When you use the UI setting of the demo project, you can see the following interface:

![](https://web-cdn.agora.io/docs-files/1568801878840)

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

### 3. Initialize AgoraRtcEngineKit

Create and initialize the `AgoraRtcEngineKit` object before calling any other Agora APIs.

Call the `sharedEngineWithAppId` method and pass in the App ID to initialize the `AgoraRtcEngineKit` object.

You can also listen for callback events, such as when the local user joins the channel, and when the first video frame of a host is decoded. 

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

An interactive streaming channel has two client roles: `Broadcaster` and `Audience`, and the default role is `Audience`. After setting the channel profile to `Live Broadcast`, your app may use the following steps to set the client role:

1. Allow the user to set the role as `Broadcaster` or `Audience`. 
2. Call the `setClientRole` method and pass in the client role set by the user.

Note that in the interactive live streaming, only the host can be heard and seen. If you want to switch the client role after joining the channel, call the `setClientRole` method.

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
    [self.agoraKit setClientRole:self.clientRole];
```

```swift
// Swift
// Set the client role.
agoraKit.setClientRole(.audience)
agoraKit.setClientRole(.broadcaster)
```

### 6. Set the local video view

After setting the channel profile and client role, set the local video view before joining the channel so that the host can see the local video in the interactive streaming. Follow these steps to configure the local video view:

1. Call the `enableVideo` method to enable the video module.
2. Call the `setupLocalVideo` method to configure the local video display settings. 

```objective-c
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

```swift
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

### <a name="JoinChannel"></a>7. Join a channel

After initializing the `AgoraRtcEngineKit` object and setting the local video view (for the interactive video streaming), you can call the `joinChannelByToken` method to join a channel. In this method, set the following parameters:

- `channelId`: Specify the channel name that you want to join. Input your `channelId` before running the sample code.
- `token`: Pass a token that identifies the role and privilege of the user.  You can set it as one of the following values:
	- `nil`.
	- A temporary token generated in Console. A temporary token is valid for 24 hours. For details, see [Get a Temporary Token](https://docs.agora.io/en/Agora%20Platform/token#get-a-temporary-token).
	- A token generated at the server. This applies to scenarios with high-security requirements. For details, see [Generate a token from Your Server](./token_server).
	<div class="alert note">If your project has enabled the app certificate, ensure that you provide a token.</div>
- `uid`: ID of the local user that is an integer and should be unique. If you set `uid` as `0`,  the SDK assigns a user ID for the local user and returns it in the `joinSuccessBlock` callback.

 <div class="alert note">Once the user joins the channel, the user subscribes to the audio and video streams of all the other users in the channel by default, giving rise to usage and billing calculation. If you do not want to subscribe to a specified stream or all remote streams, call the <tt>mute</tt> methods accordingly.</div>
 
- joinSuccessBlock: Returns that the user joins the specified channel. It is same as `didJoinChannel`. We recommend setting `joinSuccessBlock` as `nil`, so that the SDK can trigger the `didJoinChannel` callback.

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

### 8. Set the remote video view

In the interactive live video streaming, you should be able to see other users too. This is achieved by calling the `setupRemoteVideo` method after joining the channel.

Shortly after a remote host joins the channel, the SDK gets the remote host's ID in the `firstRemoteVideoDecodedOfUid` callback. Call the `setupRemoteVideo` method in the callback, and pass in the `uid` to set the video view of the remote host.

```objective-c
// Objective-C
// Listen for the firstRemoteVideoDecodedOfUid callback.
// This callback occurs when the first video frame of a remote host is received and decoded after the remote host successfully joins the channel.
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
// This callback occurs when the first video frame of a remote host is received and decoded after the remote host successfully joins the channel.
// You can call the setupRemoteVideo method in this callback to set up the remote video view.
func rtcEngine(_ engine: AgoraRtcEngineKit, firstRemoteVideoDecodedOfUid uid: UInt, size: CGSize, elapsed: Int) {
    let userSession = videoSession(of: uid)
    userSession.updateMediaInfo(resolution: size)
    // Set the remote video view.
    agoraKit.setupRemoteVideo(userSession.canvas)
```

### 9. Leave the channel

Call the `leaveChannel` method to leave the current channel according to your scenario, for example, when the interactive live streaming ends, when you need to close the app, or when your app runs in the background.

```objective-c
// Objective-C
[self.agoraKit setupLocalVideo:nil];
    // Leave the channel.
    [self.agoraKit leaveChannel:nil];
    if (self.isBroadcaster) {
        [self.agoraKit stopPreview];
    }
```

```swift
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

## Run the project

Before running the project, you need to set your signing and team, and add device permissions.

### 1. Set your signing and team

1. In Xcode, navigate to **TARGETS > Project Name > General > Signing**, and choose **Automatically manage signing**.
2. Read the prompts carefully, and click **Enable Automatic**.
3. After you successfully set your signing, choose a developer in **Team**.

### 2. Add device permissions

In Xcode, open the `info.plist` file. Add the following contents to add permissions for your device:



| Key                                    | Type   | Value                                                        |
| :------------------------------------- | :----- | :----------------------------------------------------------- |
| Privacy - Microphone Usage Description | String | The purpose for accessing the microphone, such as for a call or interactive live streaming. |
| Privacy - Camera Usage Description     | String | The purpose for accessing the camera, such as for a call or interactive live streaming. |



<div class="alert note">iOS 14.0 adds the <b>Privacy - Local Network Usage Description</b> permission. If you use a version of the SDK earlier than v3.1.2, you need to add this permission. See <a href="https://docs.agora.io/en/faq/local_network_privacy">Solution</a > for details.</div>

### 3. Try the interactive live video streaming

In Xcode, connect to your iOS device, and click the **Build** button on the upper left corner. If your app is installed and running successfully, a host should see the local video view.

To test the remote video view, visit the [Web Demo](https://webdemo.agora.io/agora-web-showcase/examples/Agora-Web-Tutorial-1to1-Web/), then enter the same App ID, channel name, and token to join the same channel. When you successfully start the interactive live video streaming in the app, a host should see both the local video view and video views of other hosts; an audience member should see video views of hosts.

## <a name="earlierversion"></a>Integrate earlier versions of the SDK

Choose one of the following methods to integrate a version of the Agora iOS SDK earlier than v3.2.0.

### Method 1: Through CocoaPods

1. Ensure that you have installed CocoaPods before performing the following steps. See the installation guide in [Getting Started with CocoaPods](https://guides.cocoapods.org/using/getting-started.html#getting-started).

2. In Terminal, navigate to the project path, and run the `pod init` command to create a `Podfile` in the project folder.


 
3. Open the `Podfile`, delete all contents, and input the following codes. Remember to replace `Your App` with the target name of your project and replace `version` with the version of the SDK that you want to integrate. For information about the SDK version, see [Release Notes](./release_ios_video?platform=iOS).

 ```
# platform :ios, '9.0' use_frameworks!
target 'Your App' do
    pod 'AgoraRtcEngine_iOS', 'version'
end
```


4. Return to Terminal, and run the `pod install` command to install the Agora SDK. Once you successfully install the SDK, it shows `Pod installation complete!` in Terminal, and you can see an `xcworkspace` file in the project folder.

5. Open the generated `xcworkspace` file.

### Method 2: Through your local storage

You need to use different integration methods to integrate different versions of the SDK. Click the following version categories to expand the corresponding integration steps.

<details>
	<summary><font color="#3ab7f8">From v3.2.0 to v3.2.1</font></summary>


1. According to your requirements, choose one of the following methods to copy the `AgoraRtcKit.framework`, `Agorafdkaac.framework`, `Agoraffmpeg.framework`, and `AgoraSoundTouch.framework` dynamic libraries to the `./project_name` folder in your project (`project_name` is an example of your project name):

   a. If you do not need to use a simulator to run the project, copy the above dynamic libraries under the path of `./libs` in the SDK package.
   b. If you need to use a simulator to run the project, copy the above dynamic libraries under the path of `./libs/ALL_ARCHITECTURE` in the SDK package. The dynamic libraries under this path contains the x86-64 architecture, which affects the distribution of your app in the App Store. See solutions in [Distribution consideration](#distribution).


2. Open Xcode, and navigate to **TARGETS > Project Name > General > Frameworks, Libraries, and Embedded Content**.


3. Click **+** > **Add Other…** > **Add Files** to add the `AgoraRtcKit.framework`, `Agorafdkaac.framework`, `Agoraffmpeg.framework`, and `AgoraSoundTouch.framework` dynamic libraries. Ensure that the **Embed** attribute of these dynamic libraries is **Embed & Sign**.

   Once these dynamic libraries are added, the project automatically links to other system libraries.


   <div class="alert note"><ul><li>According to the official requirements of Apple, the Extension of an app cannot contain the dynamic library. If you need to integrate the SDK with the dynamic library in the Extension, change the file status to <b>Do Not Embed</b>.</li><li>The Agora SDK uses libc++ (LLVM) by default. Contact support@agora.io if you want to use libstdc++ (GNU). The SDK provides FAT image libraries with multi-architecture support for both 32/64-bit audio emulators and 32/64-bit audio/video real devices.</li></ul></div>

</details>

<details>
	<summary><font color="#3ab7f8">From v3.0.1 to v3.1.2</font></summary>

1. According to your requirements, choose one of the following methods to copy the `AgoraRtcKit.framework` dynamic library to the `./project_name` folder in your project (`project_name` is an example of your project name):
 a. If you do not need to use a simulator to run the project, copy the above dynamic library under the path of `./libs` in the SDK package.
 b. If you need to use a simulator to run the project, copy the above dynamic library under the path of `./libs/ALL_ARCHITECTURE` in the SDK package. The dynamic libraries under this path contains the x86-64 and i386 architectures, which affects the distribution of your app in the App Store. See solutions in [Distribution consideration](#distribution).
2. Open Xcode, and navigate to **TARGETS > Project Name > General > Frameworks, Libraries, and Embedded Content**.
3. Click **+ > Add Other… > Add Files** to add the `AgoraRtcKit.framework` dynamic library. Ensure that the **Embed** attribute of the dynamic library is **Embed & Sign**. Once the dynamic library is added, the project automatically links to other system libraries.
 
 <div class="alert note"><ul><li>According to the official requirements of Apple, the Extension of an app cannot contain the dynamic library. If you need to integrate the SDK with the dynamic library in the Extension, change the file status to <b>Do Not Embed</b>.</li><li>The Agora SDK uses libc++ (LLVM) by default. Contact support@agora.io if you want to use libstdc++ (GNU). The SDK provides FAT image libraries with multi-architecture support for both 32/64-bit audio emulators and 32/64-bit audio/video real devices.</li></ul></div>

</details>

<details>
	<summary><font color="#3ab7f8">v3.0.0</font></summary>

In v3.0.0, the SDK package contains an `AgoraRtcKit.framework` dynamic library and an `AgoraRtcKit.framework` static library. Choose which of these libraries to add according to your needs.
The paths of the two libraries in the SDK package are as follows:
- The path of the dynamic library: `./Agora_Native_SDK_for_iOS_..._Dynamic/libs`.
- The path of the static library: `./Agora_Native_SDK_for_iOS_.../libs`.

<div class="alert info">If you need to check the type of a library, run the following command: <tt>file /path/xxx.framework/xxx</tt> (<tt>xxx</tt> refers to the library name).<li>When Terminal returns <tt>dynamically linked shared library</tt>, the library is a dynamic library.</li><li>When Terminal returns <tt>current ar archive random library</tt>, the library is a static library.</div>

**Integrate the dynamic library:**
1. Copy the `AgoraRtcKit.framework` dynamic library from the `./libs` path of the SDK package to the `./project_name` folder in your project (`project_name` is an example of your project name).
2. Open Xcode, and navigate to **TARGETS > Project Name > General > Frameworks, Libraries, and Embedded Content**.
3. Click **+ > Add Other… > Add Files** to add the `AgoraRtcKit.framework` dynamic library. Ensure that the **Embed** attribute of the dynamic library is **Embed & Sign**. 
 Once the dynamic library is added, the project automatically links to other system libraries.
 
 <div class="alert note">According to the official requirements of Apple, the Extension of an app cannot contain the dynamic library. If you need to integrate the SDK with the dynamic library in the Extension, change the file status to <b>Do Not Embed</b>.</div>

**Integrate the static library:**
1. Copy the `AgoraRtcKit.framework` static library from the `./libs` path of the SDK package to the `./project_name` folder in your project (`project_name` is an example of your project name).
2. Open **Xcode**, navigate to **TARGETS > Project Name > Build Phases > Link Binary with Libraries**, and click **+** to add the following libraries. To add the `AgoraRtcKit.framework` static library, you need to click **+**, and then click **Add Other...**.

| SDK | Library |
| ---------------- | ---------------- |
| Voice SDK      |<li>`AgoraRtcKit.framework`</li><li>`Accelerate.framework`</li><li>`AudioToolbox.framework`</li><li>`AVFoundation.framework`</li><li>`CoreMedia.framework`</li><li>`libc++.tbd`</li><li>`libresolv.tbd`</li><li>`SystemConfiguration.framework`</li><li>`CoreTelephony.framework`</li>|
| Video SDK | <li>`AgoraRtcKit.framework`</li><li>`Accelerate.framework`</li><li>`AudioToolbox.framework`</li><li>`AVFoundation.framework`</li><li>`CoreMedia.framework`</li><li>`libc++.tbd`</li><li>`libresolv.tbd`</li><li>`SystemConfiguration.framework`</li><li>`CoreML.framework`</li><li>`VideoToolbox.framework`</li> |

<div class="alert note"> The Agora SDK uses libc++ (LLVM) by default. Contact Agora support if you want to use libstdc++ (GNU). The SDK provides FAT image libraries with multi-architecture support for both 32/64-bit audio emulators and 32/64-bit audio/video real devices.</div>
	
</details>

<details>
	<summary><font color="#3ab7f8">Earlier than v3.0.0</font></summary>

1. Copy the `AgoraRtcEngineKit.framework` static library from the `./libs` path of the SDK package to the `./project_name` folder in your project (`project_name` is an example of your project name).
2. Open **Xcode**, navigate to **TARGETS > Project Name > Build Phases > Link Binary with Libraries**, and click **+** to add the following libraries. To add the `AgoraRtcEngineKit.framework` static library, you need to click **+**, and then click **Add Other...**.

| SDK | Library |
| ---------------- | ---------------- |
| Voice SDK      |<li>`AgoraRtcEngineKit.framework`</li><li>`Accelerate.framework`</li><li>`AudioToolbox.framework`</li><li>`AVFoundation.framework`</li><li>`CoreMedia.framework`</li><li>`libc++.tbd`</li><li>`libresolv.tbd`</li><li>`SystemConfiguration.framework`</li><li>`CoreTelephony.framework`</li>|
| Video SDK | <li>`AgoraRtcEngineKit.framework`</li><li>`Accelerate.framework`</li><li>`AudioToolbox.framework`</li><li>`AVFoundation.framework`</li><li>`CoreMedia.framework`</li><li>`libc++.tbd`</li><li>`libresolv.tbd`</li><li>`SystemConfiguration.framework`</li><li>`CoreML.framework`</li><li>`VideoToolbox.framework`</li> |

<div class="alert note"> The Agora SDK uses libc++ (LLVM) by default. Contact Agora support if you want to use libstdc++ (GNU). The SDK provides FAT image libraries with multi-architecture support for both 32/64-bit audio emulators and 32/64-bit audio/video real devices.</div>

</details>
	
## <a name="distribution"></a>Distribution consideration

If you integrate dynamic libraries under the path of `./libs/ALL_ARCHITECTURE` in the SDK package, you need to remove the x86-64 architecture in the libraries before uploading the app to the App Store.

In Terminal, run the following command to remove the x86-64 architecture. Remember to replace `ALL_ARCHITECTURE/AgoraRtcKit.framework/AgoraRtcKit` with the path of the dynamic library in your project.

```shell
lipo -remove x86-64 ALL_ARCHITECTURE/AgoraRtcKit.framework/AgoraRtcKit -output ALL_ARCHITECTURE/AgoraRtcKit.framework/AgoraRtcKit
```

See more considerations in [Preparing Your App for Distribution](https://developer.apple.com/documentation/xcode/preparing_your_app_for_distribution).

## Reference

- [How can I listen for an audience joining or leaving the interactive live streaming channel?](https://docs.agora.io/en/faq/audience_event)
- [How can I set the log file?](https://docs.agora.io/en/faq/logfile)
- [How can I solve black screen issues?](https://docs.agora.io/en/faq/video_blank)
- [Why do I see a prompt to find local network devices when launching an iOS app?](https://docs.agora.io/en/faq/local_network_privacy)