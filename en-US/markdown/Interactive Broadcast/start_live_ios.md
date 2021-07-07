The Agora Video SDK for iOS makes it easy to embed interactive live streaming into iOS apps. It enables you to develop rapidly and easily to enhance your social, work, education and IoT apps with real-time engagement.

This page shows you the minimum code you need to add interactive live video streaming into your iOS app by using the Agora Video SDK for iOS.

## Understand the tech

The following figure shows the workflow of interactive live streaming implemented by the Agora SDK.

![video streaming](https://web-cdn.agora.io/docs-files/1623989605801)

To start interactive live video streaming, your app client has the following steps to take: 

1. **Set the client role**
   An interactive live streaming session differs from a voice or video call in that users in a live streaming channel have different roles: host (`BROADCASTER)` and audience (`AUDIENCE)`. Only app clients with the role of `BROADCASTER` can publish streams in the channel. Those with the role of `AUDIENCE` can only susbcribe to streams.
2. **Get a token**
   The app client requests a token from your app server. This token authenticates the user when the app client joins a channel.
3. **Join an Agora RTC channel**
   The client joins an RTC (Real-time Communication) channel by calling the APIs provided by Agora. When that happens, Agora automatically creates an RTC channel. App clients that pass the same channel name join the same channel.
4. **Publish and subscribe to audio and video in the channel**
   After joining a channel, only app clients with the role of `BROADCASTER` can publish audio and video. For an auidence memeber to send audio and video, you can call the API to switch the client role. 

For an app client to join an RTC channel, you need the following information:

- The App ID: A randomly generated string provided by Agora for identifying your app. You can get the App ID from [Agora Console](https://console.agora.io/).
- The user ID: The unique identifier of a user. You need to specify the user ID yourself, and ensure that it is unique in the channel.
- A token: A credential for authenticating the identity of the user when your app client joins an RTC channel.
- The channel name: A string that identifies the RTC channel for the live stream. 

## Prerequisites

In order to follow the procedure in this page, you must have:

- A valid Agora account
- An [Agora project](https://docs.agora.io/en/Agora%20Platform/get_appid_token?platform=Web) with an App ID and a temp token
- Xcode 9.0 or later (the interface description in this article is based on Xcode 11.0)
- An iOS device running iOS 9.0 or later

<div class="alert note">If your network has a firewall, follow the instructions in [Firewall Requirements](https://docs.agora.io/en/Agora Platform/firewall?platform=iOS) to access Agora services.</div>

## Create an iOS project

To create an iOS project, perform the following steps:

1. Open Xcode, and click **Create a new Xcode project**.

2. Choose **iOS** as the target platform, **Single View App** as the template, and click **Next**.

3. Input the product name, team, organization name, and organization identifier, select a language and user interface, and click **Next**.

   <div class="alert note">If you have not added any team information, you can see an **Add account...** button. Click it, input your Apple ID, and click **Next** to add your team.</div>

4. Choose the storage path of the project, and click **Create**.

## Implement a client for interactive live video streaming

This section shows how to use the Agora Video SDK for iOS to add interactive live video streaming into your iOS app step by step.

### 1. Integrate the SDK

Integrate the Agora Video SDK for iOS into your project through CocoaPod, as follows:

1. Install CocoaPods if you have not. See the installation guide in [Getting Started with CocoaPods](https://guides.cocoapods.org/using/getting-started.html#getting-started).
2. In Terminal, navigate to the directory of the iOS project and run the `pod init` command. You should find a `Podfile` created under the directory.
3. Open the `Podfile`, delete all contents, and paste the following code. Remember to replace `Your App` with the target name of your project.

```
# platform :ios, '9.0'
target 'Your App' do
    pod 'AgoraRtcEngine_iOS'
end
```

4. Return to Terminal, and run the `pod install` command. Once you successfully install the SDK, it shows `Pod installation complete!` in Terminal, and you can find an `xcworkspace` file created under the project directory.
5. Close any existing Xcode projects and open the `xcworkspace` file. All of the following steps are performed in the `xcworkspace` file.

### 2. Implement the user interface

To implement a basic user interface, refer to the code sample for your language:

```objective-c
// Objective-C
// Open ViewController.m, delete everything under "#import "ViewController.h", and paste the following code
#import <UIKit/UIKit.h>

@interface ViewController ()
@property (nonatomic, strong) UIView *localView;
@property (nonatomic, strong) UIView *remoteView;
@end
  
@implementation ViewController
  
- (void)viewDidLoad {
    [super viewDidLoad];
    // This function initializes the local and remote video views
    [self initViews];
    // The following functions are used when calling Agora APIs
    [self initializeAgoraEngine];
    [self setChannelProfile];
    [self setClientRole];
    [self setupLocalVideo];
    [self joinChannel];
}

// Sets the video view layout
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.remoteView.frame = self.view.bounds;
    self.localView.frame = CGRectMake(self.view.bounds.size.width - 90, 0, 90, 160);
}

- (void)initViews {
    // Initializes the remote video view. This view displays video when a remote host joins the channel
    self.remoteView = [[UIView alloc] init];
    [self.view addSubview:self.remoteView];
    // Initializes the local video view. This view displays video when the local user is a host
    self.localView = [[UIView alloc] init];
    [self.view addSubview:self.localView];
}
```

```swift
// Swift
// Open ViewController.swift, delete everything under ?, and paste the following code
import UIKit
class ViewController: UIViewController {
    var localView: UIView!
    var remoteView: UIView!
     override func viewDidLoad() {
        super.viewDidLoad()
        // This function initializes the local and remote video views
        initView()
        // The following functions are used when calling Agora APIs
        initializeAgoraEngine()
        setChannelProfile()
        setClientRole()
        setupLocalVideo()
        joinChannel()  
     }
    // Sets the video view layout
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        remoteView.frame = self.view.bounds
        localView.frame = CGRect(x: self.view.bounds.width - 90, y: 0, width: 90, height: 160)
    }
    func initView() {
        // Initializes the remote video view. This view displays video when a remote host joins the channel
        remoteView = UIView()
        self.view.addSubview(remoteView)
        // Initializes the local video view. This view displays video when the local user is a host
        localView = UIView()
        self.view.addSubview(localView)
    }
}
```

### 3. Import AgoraRtcKit

Before calling any Agora API in your project, import the `AgoraRtcKit` class and define `agoraKit`, as follows:

```objective-c
// Objective-C
// Open ViewController.h, and add the following code under "#import <UIKit/UIKit.h>"
// If you use a SDK earlier than 3.0.0, use "#import <AgoraRtcEngineKit/AgoraRtcEngineKit.h>" instead.
#import <AgoraRtcKit/AgoraRtcEngineKit.h>
// Specifies AgoraRtcEngineDelegate for monitoring a callback
@interface ViewController : UIViewController <AgoraRtcEngineDelegate>
// Defines agoraKit
@property (strong, nonatomic) AgoraRtcEngineKit *agoraKit;
```

```swift
// Swift
// In ViewController.swift, add the following code
// If you use a SDK earlier than 3.0.0, use "import AgoraRtcEngineKit" instead
import AgoraRtcKit
class ViewController: UIViewController {
    ...
    // Defines agoraKit
    var agoraKit: AgoraRtcEngineKit?
}
```

### 4. Initialize AgoraRtcEngineKit

Call the `sharedEngineWithAppId` method to create and initialize the `AgoraRtcEngineKit` object.

```objective-c
// Objective-C
// Add the following code to ViewController.m
- (void)initializeAgoraEngine {
    // Pass in your App ID here
    self.agoraKit = [AgoraRtcEngineKit sharedEngineWithAppId:@"YourAppID" delegate:self];
}
```

```swift
// Swift
// In ViewController.swift, add the following code
func initializeAgoraEngine() {
     // Pass in your App ID here
       agoraKit = AgoraRtcEngineKit.sharedEngine(withAppId: "YourAPPID", delegate: self)
    }
```

### 5. Set the channel profile and client role

Call the `setChannelProfile` method and set the channel profile as `LIVE_BROADCASTING`. Then call `setClientRole` to set the user role as a host (`BROADCASTER`) or an audience member (`AUDIENCE`).

In an interactive live streaming channel, only the host can be seen and heard. You can call `setClientRole` to switch the user role after joining a channel.

```objective-c
// Objective-C
// Add the following code to ViewController.m.
- (void)setChannelProfile {
[self.agoraKit setChannelProfile:AgoraChannelProfileLiveBroadcasting];
}

- (void)setClientRole {
// Do not use the following two lines of code together. Choose the one you want.
// Set the client role as Broadcaster if you want to try out as a host.
[self.agoraKit setClientRole:AgoraClientRoleBroadcaster];
// Set the client role as Audience if you want to try out as an audience member.
[self.agoraKit setClientRole:AgoraClientRoleAudience];
}
```

```swift
// Swift
// In ViewController.swift, add the following code
func setChannelProfile(){
agoraKit?.setChannelProfile(.liveBroadcasting)
}
func setClientRole(){
// Do not use the following two lines of code together. Choose the one you want.
// Set the client role as broadcaster if you want to try out as a host.
agoraKit?.setClientRole(.broadcaster)
// Set the client role as audience if you want to try out as an audience member.
agoraKit?.setClientRole(.audience)
}
```

### 6. Set the local video

Set the local video view before joining a channel so that hosts can see themselves during live streaming.

```objective-c
// Objective-C
// Add the following code to ViewController.m.
- (void)setupLocalVideo {
// Enables the video module
[self.agoraKit enableVideo];
AgoraRtcVideoCanvas *videoCanvas = [[AgoraRtcVideoCanvas alloc] init];
videoCanvas.uid = 0;
videoCanvas.renderMode = AgoraVideoRenderModeHidden;
videoCanvas.view = self.localView;
// Sets the local video view
[self.agoraKit setupLocalVideo:videoCanvas];
}
```

```swift
// Swift
// In ViewController.swift, add the following code
func setupLocalVideo() {
    // Enables the video module
    agoraKit?.enableVideo()
    let videoCanvas = AgoraRtcVideoCanvas()
    videoCanvas.uid = 0
    videoCanvas.renderMode = .hidden
    videoCanvas.view = localView
    // Sets the local video view
    agoraKit?.setupLocalVideo(videoCanvas)
    }
```

### 7. Join a Channel

Call  `joinChannelByToken` to join a channel. In this method you need to pass the following parameters:

- A token, for user authentication.
- A channel name. App clients that fill the same channel name join the same channel.
- User ID. You need to specify the user ID yourself, and make sure that this user ID is unique in the channel. If you do not specify a user ID, the Agora SDK automatically generates one for you.

```objective-c
// Objective-C
// Add the following code to ViewController.m.
- (void)joinChannel {
    [self.agoraKit joinChannelByToken:@"YourToken" channelId:@"YourChannelName" info:nil uid:0 joinSuccess:^(NSString * _Nonnull channel, NSUInteger uid, NSInteger elapsed) {
}];
}
```

```swift
// Swift
// In ViewController.swift, add the following code
func joinChannel(){
        // The uid of each user in the channel must be unique.
        agoraKit?.joinChannel(byToken: "YourToken", channelId: "YourChannelName", info: nil, uid: 0, joinSuccess: { (channel, uid, elapsed) in
    })
}
```

### 8. Set the remote video

In live video streaming, you should be able to see all hosts.

To set the video view of a remote host, monitor the `didJoinedOfUid` callback, which returns the remote host's ID shortly after the remote host joins the channel; then, call the `setupRemoteVideo` method in the callback, and pass in the retrieved `uid`.

```objective-c
// Objective-C
// Add the following code to ViewController.m.
// The SDK triggers the callback when a remote host joins the channel
- (void)rtcEngine:(AgoraRtcEngineKit *)engine didJoinedOfUid:(NSUInteger)uid elapsed:(NSInteger)elapsed {
    AgoraRtcVideoCanvas *videoCanvas = [[AgoraRtcVideoCanvas alloc] init];
    videoCanvas.uid = uid;
    videoCanvas.renderMode = AgoraVideoRenderModeHidden;
    videoCanvas.view = self.remoteView;
    // Sets the remote video view
    [self.agoraKit setupRemoteVideo:videoCanvas];
}
```

```swift
// Swift
// In ViewController.swift, ensure that you add the following code outside class ViewController: UIViewController
extension ViewController: AgoraRtcEngineDelegate {
    // The SDK triggers the callback when a remote host joins the channel
    func rtcEngine(_ engine: AgoraRtcEngineKit, didJoinedOfUid uid: UInt, elapsed: Int) {
        let videoCanvas = AgoraRtcVideoCanvas()
        videoCanvas.uid = uid
        videoCanvas.renderMode = .hidden
        videoCanvas.view = remoteView
        // Sets the remote video view
        agoraKit?.setupRemoteVideo(videoCanvas)
    }
}
```

### 9. Leave the channel

Call the `leaveChannel` method when you need to leave the channel, for example, to end live video streaming, close the app, or run the app in the background.

```objective-c
// Objective-C
// Add the following code to ViewController.m.
- (void)leaveChannel {
    [self.agoraKit leaveChannel:nil];
}
```

```swift
// Swift
// Add the following code to ViewController.swift.
func leaveChannel() {
        agoraKit?.leaveChannel(nil)
    }
```

## Test your app

Take the following steps to test your live streaming app:

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

<div class="alert note">iOS 14.0 adds the **Privacy - Local Network Usage Description** permission. If you use a version of the SDK earlier than v3.1.2, you need to add this permission. See [Solution](https://docs.agora.io/en/faq/local_network_privacy) for details.</div>

### 3. Build and run

1. Connect an iOS device to your computer, and click the **Build and Run** button in Xcode. A moment later you will see the app installed on your device.
2. When the app launches, grant microphone and camera access to your app. Then you should be able to see yourself on the local view if you set the client role as `BROADCASTER`.
3. Ask a friend to join the live stream with you on the [demo app](https://webdemo.agora.io/agora-websdk-api-example-4.x/basicLive/index.html). Enter the same App ID and channel name.
4. If your friend joins as host, you should be able to see and hear each other; If as audience, you should only be able to see yourself while your friend can see and hear you.


## Next steps

Generating a token by hand is not helpful in a production context. [Authenticate Your Users with Tokens](./token_server) shows you how to start a video call with a token that you retrieve from your server.

## See also

- Agora also provides an open-source [sample project](https://github.com/AgoraIO/Basic-Video-Broadcasting/tree/master/OpenLive-iOS) on GitHub for your reference.

- In addition to integrating the Agora Video SDK for iOS into your project through CocoaPods, you can also manually integrate the SDK through the following steps:

  - Download the latest version of [Agora iOS SDK](https://docs.agora.io/en/Interactive%20Broadcast/downloads?platform=iOS) and extract the files.

  - According to your requirements, copy the libraries from the `libs` folder of the SDK to the `./project_name` folder in your project (`project_name` is an example of your project name).

    <div class="alert note">The libraries with the `Extension` suffix are optional. Add the corresponding libraries according to your needs. For the feature of each extension library, see [Release Notes](https://docs.agora.io/en/Interactive Broadcast/release_ios_video?platform=iOS).</div>
    
  - Open Xcode, and navigate to **TARGETS > Project Name > General > Frameworks, Libraries, and Embedded Content**.

  - Click **+** > **Add Other…** > **Add Files** to add the cooresponding libraries. Ensure that the **Embed** attribute of these dynamic libraries is **Embed & Sign**.

    Once these dynamic libraries are added, the project automatically links to other system libraries.

    <div class="alert note"></div><li>According to the official requirements of Apple, the Extension of an app cannot contain the dynamic library. If you need to integrate the SDK with the dynamic library in the Extension, change the file status to Do Not Embed.</li><li>The Agora SDK uses libc++ (LLVM) by default. Contact support@agora.io if you want to use libstdc++ (GNU). The SDK provides FAT image libraries with multi-architecture support for both 32/64-bit audio emulators and 32/64-bit audio/video real devices.</li></div>

- If you integrate dynamic libraries under the path of `./libs/ALL_ARCHITECTURE` in the SDK package, you need to remove the x86-64 architecture in the libraries before uploading the app to the App Store, as follows:

  - In Terminal, run the following command. Remember to replace `ALL_ARCHITECTURE/AgoraRtcKit.framework/AgoraRtcKit` with the path of the dynamic library in your project.

    ```
    lipo -remove x86-64 ALL_ARCHITECTURE/AgoraRtcKit.framework/AgoraRtcKit -output ALL_ARCHITECTURE/AgoraRtcKit.framework/AgoraRtcKit
    ```

  - See more considerations in [Preparing Your App for Distribution](https://developer.apple.com/documentation/xcode/preparing_your_app_for_distribution).