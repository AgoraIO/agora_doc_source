---
title: Start a Voice Call
platform: iOS
updatedAt: 2021-01-28 10:31:21
---
Use this guide to quickly start a basic voice call with the Agora Voice SDK for iOS.


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

## Implementation

Once you have integrated the Agora iOS SDK into your project, you need to call the core APIs provided by the Agora iOS SDK in the `ViewController` file to implement a basic voice call. The API call sequence is shown in the following figure:

![](https://web-cdn.agora.io/docs-files/1611111815559)

### 1. Import AgoraRtcKit

Before calling any Agora API in your project, import the `AgoraRtcKit` class, and define `agoraKit`.

```objective-c
// Objective-C
// ViewController.h
// If you use a SDK earlier than 3.0.0, use #import <AgoraRtcEngineKit/AgoraRtcEngineKit.h> instead
#import <AgoraRtcKit/AgoraRtcEngineKit.h>
// Specifies AgoraRtcEngineDelegate for monitoring a callback
@interface ViewController : UIViewController <AgoraRtcEngineDelegate>
// Defines agoraKit
@property (strong, nonatomic) AgoraRtcEngineKit *agoraKit;
```

```swift
// Swift
// ViewController.swift
// If you use a SDK earlier than 3.0.0, use import AgoraRtcEngineKit instead
import AgoraRtcKit
class ViewController: UIViewController {
    ...
    // Defines agoraKit
    var agoraKit: AgoraRtcEngineKit?
}
```

### 2. Initialize AgoraRtcEngineKit

Call the `sharedEngineWithAppId` method to create and initialize the `AgoraRtcEngineKit` object. When adding the following code in your project, replace `YourAppID` with the App ID of your project. See [Get an App ID](./run_demo_voice_call_ios?platform=iOS#appid).

If you want to monitor a callback for your app scenario, register it when initializing `AgoraRtcEngineKit`.

```objective-c
// Objective-C
// ViewController.m
@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // The following functions are used when calling Agora APIs
    [self initializeAgoraEngine];
    [self joinChannel];
}
- (void)initializeAgoraEngine {
    // Initializes AgoraRtcEngineKit
    self.agoraKit = [AgoraRtcEngineKit sharedEngineWithAppId:@"YourAppID" delegate:self];
}
```

```swift
// Swift
// ViewController.swift
class ViewController: UIViewController {
    ...
     override func viewDidLoad() {
        super.viewDidLoad()
        // The following functions are used when calling Agora APIs
        initializeAgoraEngine()
        joinChannel()
     }
func initializeAgoraEngine() {
       // Initializes AgoraRtcEngineKit
			 agoraKit = AgoraRtcEngineKit.sharedEngine(withAppId: "YourAPPID", delegate: self)
    }
}
```

### 3. Join a channel

Call the `joinChannelByToken` method to join a channel.
When adding the following code in your project, replace `YourToken` with the token of your project, and replace `YourChannelName` with the channel name used to generate the token of your project.

- For testing, you can [generate a temporary token](./run_demo_voice_call_ios?platform=iOS#temptoken) in Agora Console. When joining a channel, ensure that the channel name is the same with the one you use to generate the temporary token.
- For production, Agora recommends using a token generated at your server. See [Generate a Token](./token_server?platform=iOS). When joining a channel, ensure that the channel name and uid is the same with those you use to generate the token.

<div class="alert note">By default, a user who has joined a channel subscribes to the audio streams of all the other users in the channel. This will generate usage and affect billing. If you do not want to subscribe to a specific stream or all remote streams, call the <code>mute</code> methods accordingly.</div>

```objective-c
// Objective-C
// ViewController.m
- (void)joinChannel {
    [self.agoraKit joinChannelByToken:@"YourToken" channelId:@"YourChannelName" info:nil uid:0 joinSuccess:^(NSString * _Nonnull channel, NSUInteger uid, NSInteger elapsed) {
}];
}
```

```swift
// Swift
// ViewController.swift
func joinChannel(){
        agoraKit?.joinChannel(byToken: "YourToken", channelId: "YourChannelName", info: nil, uid: 0, joinSuccess: { (channel, uid, elapsed) in
    })
}
```

### 4. Leave the channel

Call the `leaveChannel` method when you need to leave the channel, for example, to end the call, close the app, or run the app in the background.


```objective-c
// Objective-C
// ViewController.m
// Add the following code in a defined function
[self.agoraKit leaveChannel:nil];
```

```swift
// Swift
// ViewController.swift
// Add the following code in a defined function
agoraKit?.leaveChannel(nil)
```

### 5. Destroy AgoraRtcEngineKit

After leaving the channel, if you want to release the resources used by the Agora SDK, call the `destroy` method to destroy the `AgoraRtcEngineKit` object.

```objective-c
// Objective-C
// ViewController.m
// Add the following code in a defined function
[AgoraRtcEngineKit destroy];
```

```swift
// Swift
// ViewController.swift
// Add the following code in a defined function
AgoraRtcEngineKit.destroy()
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



<div class="alert note">iOS 14.0 adds the <b>Privacy - Local Network Usage Description</b> permission. If you use a version of the SDK earlier than v3.1.2, you need to add this permission. See <a href="https://docs.agora.io/en/faq/local_network_privacy">Solution</a > for details.</div>

### 3. Try a voice call

Agora recommends running the project on a real device instead of a simulator.

To test the remote audio, visit the [Web Demo](https://webdemo.agora.io/agora-web-showcase/examples/Agora-Web-Tutorial-1to1-Web/), and enter the same App ID, channel name, and token to join the same channel. You should hear the remote user when you successfully start a one-to-one voice call in the app.

## <a name="earlierversion"></a>Integrate earlier versions of the SDK

Choose one of the following methods to integrate a version of the Agora iOS SDK earlier than v3.2.0.

### Method 1: Through CocoaPods

1. Ensure that you have installed CocoaPods before performing the following steps. See the installation guide in [Getting Started with CocoaPods](https://guides.cocoapods.org/using/getting-started.html#getting-started).

2. In Terminal, navigate to the project path, and run the `pod init` command to create a `Podfile` in the project folder.


 
3. Open the `Podfile`, delete all contents, and input the following codes. Remember to replace `Your App` with the target name of your project and replace `version` with the version of the SDK that you want to integrate. For information about the SDK version, see [Release Notes](./release_ios_audio?platform=iOS).

 ```
# platform :ios, '9.0' use_frameworks!
target 'Your App' do
    pod 'AgoraAudio_iOS'
end
```


4. Return to Terminal, and run the `pod install` command to install the Agora SDK. Once you successfully install the SDK, it shows `Pod installation complete!` in Terminal, and you can see an `xcworkspace` file in the project folder.

5. Open the generated `xcworkspace` file.

### Method 2: Through your local storage

You need to use different integration methods to integrate different versions of the SDK. Click the following version categories to expand the corresponding integration steps.

<details>
	<summary><font color="#3ab7f8">From v3.2.0 to v3.2.1</font></summary>


1. According to your requirements, choose one of the following methods to copy the `AgoraRtcKit.framework`, `Agorafdkaac.framework`, and `AgoraSoundTouch.framework` dynamic libraries to the `./project_name` folder in your project (`project_name` is an example of your project name):

   a. If you do not need to use a simulator to run the project, copy the above dynamic libraries under the path of `./libs` in the SDK package.
   b. If you need to use a simulator to run the project, copy the above dynamic libraries under the path of `./libs/ALL_ARCHITECTURE` in the SDK package. The dynamic libraries under this path contains the x86-64 architecture, which affects the distribution of your app in the App Store. See solutions in [Distribution consideration](#distribution).


2. Open Xcode, and navigate to **TARGETS > Project Name > General > Frameworks, Libraries, and Embedded Content**.


3. Click **+** > **Add Other…** > **Add Files** to add the `AgoraRtcKit.framework`, `Agorafdkaac.framework`, and `AgoraSoundTouch.framework` dynamic libraries. Ensure that the **Embed** attribute of these dynamic libraries is **Embed & Sign**.

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
We provide open-source Group-Voice-Call sample projects that implements the group voice call on GitHub. For scenarios involving group voice calls, you can download the demo project as a code source reference.

- Swift: See [RoomViewController.swift](https://github.com/AgoraIO/Basic-Audio-Call/blob/master/Group-Voice-Call/OpenVoiceCall-iOS/OpenVoiceCall/RoomViewController.swift) file in the [OpenVoiceCall-iOS](https://github.com/AgoraIO/Basic-Audio-Call/tree/master/Group-Voice-Call/OpenVoiceCall-iOS) sample project.
- Objective-C project: See [RoomViewController.m](https://github.com/AgoraIO/Basic-Audio-Call/blob/master/Group-Voice-Call/OpenVoiceCall-iOS-Objective-C/OpenVoiceCall-iOS-Objective-C/RoomViewController.m) file in the [OpenVoiceCall-iOS-Objective-C](https://github.com/AgoraIO/Basic-Audio-Call/tree/master/Group-Voice-Call/OpenVoiceCall-iOS-Objective-C) sample project.

When integrating the Agora Voice SDK, you can also refer to the following articles: 

- [How can I set the log file?](https://docs.agora.io/en/faq/logfile)
- [Why do I see a prompt to find local network devices when launching an iOS app?](https://docs.agora.io/en/faq/local_network_privacy)
- [How can I implement call notification in a call application?](./faq/call_invite_notification)