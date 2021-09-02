The Agora Video SDK for iOS makes it easy to embed real-time Video Call into iOS apps. It enables you to develop rapidly and easily to enhance your social, work, education and IoT apps with face-to-face interaction.

This page shows the minimum code you need to add video call into your app by using the Agora Video SDK for iOS.

## Understand the tech

The following figure shows the workflow of a video call implemented using the Video SDK.

![](https://web-cdn.agora.io/docs-files/1627550978702)

To start a video call, you implement the following steps in your app:

1. Retrieve a token

   The token is a credential for authenticating the identity of the user when your app client joins a channel. The app client requests a token from your app server. This token authenticates the user when the app client joins a channel.

2. Join a channel

   Call `joinChannel` to create and join a channel. App clients that pass the same channel name join the same channel.

3. Publish and subscribe to audio and video in the channel
	
	After joining a channel, app clients with the role of the host can publish audio and video. For an audience member to send audio and video, you can call `setClientRole` to switch the client role. 

For an app client to join a channel, you need the following information:
- The App ID: A randomly generated string provided by Agora for identifying your app. You can get the App ID from [Agora Console](https://console.agora.io).
- The user ID: The unique identifier of a user. You need to specify the user ID yourself, and ensure that it is unique in the channel.
- A token: In a test or production environment, your app client retrieves tokens from your server. For the procedure on this page, you use a temporary token that you get from Agora Console, which has a validity period of 24 hours.
- The channel name: A string that identifies the channel for the video call. 

## Prerequisites

Before proceeding, ensure that your development environment meets the following requirements:

- Xcode 9.0 or later.
- An iOS device running iOS 8.0 or later.
- A valid [Agora account](https://console.agora.io/).
- A valid Agora project with an App ID and a temporary token. For details, see [Get Started with Agora](https://docs.agora.io/en/Agora%20Platform/get_appid_token?platform=All%20Platforms).
- A computer with access to the internet. If your network has a firewall, follow the instructions in [Firewall Requirements](https://docs.agora.io/en/Agora%20Platform/firewall?platform=All%20Platforms).

## Project setup

In Xcode, follow the steps to create the environment necessary to add live Video Call into your app.

1. Create a new iOS app and configure the following settings:
   
   - **Product Name**: Any name you like.
   - **Team**: If you have added a team, choose it from the pop-up menu. If not, you can see the **Add account** button. Click it, input your Apple ID, and click **Next** to add your team.
   - **Organization Identifier**: The identifier of your organization. If you do not belong to an organization, use any identifier you like.
   - **Interface**: Choose **Storyboard**.
   - **Language**: Choose **Swift**.
   
2. Integrate the Video SDK into your project.

   Go to **File** > **Swift Packages** > **Add Package Dependencies...**, and paste the following URL:

   `https://github.com/AgoraIO/AgoraRtcEngine_iOS`

   In **Choose Package Options**, specify the Video Call SDK version you want to use.

<div class="alert note"><li>For the Video SDK, Agora provides Swift Packages for 3.4.3 and later versions.</li><li>If you have issues installing this Swift Package, try going to <b>File</b> > <b>Swift Packages</b> > <b>Reset Package Caches</b>.</li><li>For more integration methods, see <a href="#othermethods">Other approaches to integrating the SDK</a></li></div>

3. [Enable automatic signing](https://help.apple.com/xcode/mac/current/#/dev23aab79b4) for your project.
4. Set the deployment target for your app:
   1. In the [project editor](https://help.apple.com/xcode/mac/current/#/devdab46c612), choose your target and click **General**.
   2. In the **Deployment Info** settings, choose the operating system version for your iOS app from the pop-up menu.
5. Add permissions for microphone and camera usage.
   In the [Project navigator](https://help.apple.com/xcode/mac/current/#/dev7d7220fbb), open the `info.plist` file of your project and [add the following properties](https://help.apple.com/xcode/mac/current/#/dev3f399a2a6):
   - Privacy - Microphone Usage Description
   - Privacy - Camera Usage Description

## Implement a client for Video Call

This section shows how to use the Agora Video SDK to implement Video Call in your app step by step.

### Create the UI

In the interface, you should have one frame for local video and another for remote video. In `ViewController.swift`, replace any existing content with the following:

```swift
import UIKit
class ViewController: UIViewController {
    var localView: UIView!
    var remoteView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
     }
  
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        remoteView.frame = self.view.bounds
        localView.frame = CGRect(x: self.view.bounds.width - 90, y: 0, width: 90, height: 160)
    }
  
    func initView() {
        remoteView = UIView()
        self.view.addSubview(remoteView)
        localView = UIView()
        self.view.addSubview(localView)
    }
}
```

### Implement the Video Call logic

When your app opens, you create an `RtcEngine` instance, enable the video, join a channel, and publish the local video to the lower frame layout in the UI. When another user joins the channel, your app catches the join event and adds the remote video to the top frame layout in the UI.

The following figure shows the API call sequence of implementing Video Call. 

![](https://web-cdn.agora.io/docs-files/1627887317273)

To implement this logic, take the following steps:

1. Import the Agora kit and add the `agoraKit` variable.

   Modify your  `ViewController.swift` as follows:

   ```swift
   import UIKit
   // Add this line to import the Agora kit
   import AgoraRtcKit
   class ViewController: UIViewController {
       var localView: UIView!
       var remoteView: UIView!
       // Add this linke to add the agoraKit variable
       var agoraKit: AgoraRtcEngineKit?
     
       override func viewDidLoad() {
           super.viewDidLoad()
           initView()
        }
   ```

2. Initialize the app and join the channel.

   Call the core methods to initialize the app and join a channel. In this example app, this functionality is encapsulated in the `initializeAndJoinChannel` function.

   In `ViewController.swift`, add the following lines after the `initView` function, and fill in your App ID, temporary token, and channel name:

   ```swift
    func initializeAndJoinChannel() {
      // Pass in your App ID here
      agoraKit = AgoraRtcEngineKit.sharedEngine(withAppId: "Your App ID", delegate: self)
      // Video is disabled by default. You need to call enableVideo to start a video stream.
      agoraKit?.enableVideo()
           // Create a videoCanvas to render the local video
           let videoCanvas = AgoraRtcVideoCanvas()
           videoCanvas.uid = 0
           videoCanvas.renderMode = .hidden
           videoCanvas.view = localView
           agoraKit?.setupLocalVideo(videoCanvas)
      
      // Join the channel with a token. Pass in your token and channel name here
      agoraKit?.joinChannel(byToken: "Your token", channelId: "Channel name", info: nil, uid: 0, joinSuccess: { (channel, uid, elapsed) in
           })
       }
   ```

3. Add the remote interface when a remote user joins the channel.

   In `ViewController.swift`, add the following lines after the `ViewController` class:

    ```swift
    extension ViewController: AgoraRtcEngineDelegate {
        // This callback is triggered when a remote user joins the channel
        func rtcEngine(_ engine: AgoraRtcEngineKit, didJoinedOfUid uid: UInt, elapsed: Int) {
            let videoCanvas = AgoraRtcVideoCanvas()
            videoCanvas.uid = uid
            videoCanvas.renderMode = .hidden
            videoCanvas.view = remoteView
            agoraKit?.setupRemoteVideo(videoCanvas)
        }
    }
    ```

### Start and stop your app

Now you have created the Video Call functionality, add the functionality of starting and stopping the app. In this implementation, a video call starts when the user opens your app. The call ends when the user closes your app.

To implement the functionality of starting and stopping the app:

1. When the view is loaded, call `initializeAndJoinChannel` to join a video call channel.

   In `ViewController.swift`, add the `initializeAndJoinChannel` function inside the `viewDidLoad` function:

    ```swift
   override func viewDidLoad() {
           super.viewDidLoad()
           initView()
           // Add this line
           initializeAndJoinChannel()
        }
    ```
   
2. When the user closes this app, clean up all the resources used by your app.

   In `ViewController.swift`, add `applicationWillTerminate` after the `initializeAndJoinChannel` function.

    ```swift
   func applicationWillTerminate(notification: NSNotification) {
           agoraKit?.leaveChannel(nil)
           AgoraRtcEngineKit.destroy()
       }
    ```

## Test your app

To test your app on a physical device, do the following:

1. Connect an iOS device to your computer.

2. In Xcode, choose the device from the scheme menu in the [toolbar](https://help.apple.com/xcode/mac/current/#/devf0d1df47a), and click the Run button.

3. On your device, launch the app and grant microphone and camera access.

   You can see yourself on the local view.

4. Ask a friend to join the video call with you on the [demo app](https://webdemo.agora.io/agora-websdk-api-example-4.x/basicLive/index.html). Your friend needs to enter the same App ID and channel name.

   When your friend joins the channel, you can see and hear each other.

## Next steps

Generating a token by hand is not helpful in a production context. [Authenticate Your Users with Tokens](https://docs.agora.io/en/Interactive%20Broadcast/token_server?platform=All%20Platforms) shows you how to start Video Call with a token that you retrieve from your server.

## See also

This section provides additional information for your reference: 

### Sample project

Agora provides an open source sample project [Basic Video Call](https://github.com/AgoraIO/Basic-Video-Call) on GitHub that implements one-to-one video call and group video call for your reference.

<a name="othermethods"></a>

### Other approaches to integrate the SDK

In addition to integrating the Agora Video SDK for iOS through Swift Package, you can also import the SDK into your project through CocoaPods or by manually copying the SDK files.

**Automatically integrate the SDK with CocoaPods**

1. Install CocoaPods if you have not. See [Getting Started with CocoaPods](https://guides.cocoapods.org/using/getting-started.html#getting-started).
2. In Terminal, navigate to the root of your project folder, and run the `pod init` command to create a `Podfile` in the project folder.
3. Open the `Podfile`, and replace all contents with the following code. Remember to replace `Your App` with the target name of your project.
4. In Terminal, run the `pod install` command to install the Agora Video SDK for iOS. When the SDK is installed successfully, you can see  `Pod installation complete!` in Terminal and an `xcworkspace` file in the project folder.
5. Open the `xcworkspace` file for any further steps.

**Manually copy the SDK files**

1. Go to [SDK Downloads](https://docs.agora.io/en/Video/downloads?platform=iOS), download the latest version of the Agora Video SDK, and extract the files from the downloaded SDK package.

2. From the `libs` folder of the downloaded SDK package, copy the files or subfolders you need to the root of your project folder.
   
   <div class="alert note">Certain files and subfolders under the <code>libs</code> folder are optional. See <a href="https://docs.agora.io/en/Video/faq/reduce_app_size_rtc?platform=iOS#extension_libraries">extension libraries</a> for details.</div>
   
3. In Xcode, [link your target to the frameworks or libraries](https://help.apple.com/xcode/mac/current/#/dev51a648b07) you have copied. Be sure to choose **Embed & Sign** from the pop-up menu in the Embed column.

   <div class="alert note"><ul><li>Apple does not allow an app extension to contain any dynamic library. If you are integrating the Agora SDK to an app extension, choose <b>Do Not Embed</b> in the Embed column.</li><li>The Agora SDK uses libc++ (LLVM) by default. Contact support@agora.io if you want to use libstdc++ (GNU). The SDK provides FAT image libraries with multi-architecture support for both 32/64-bit audio emulators and 32/64-bit audio/video real devices.</li></ul></div>

<a name="oc"></a>

### Objective-C code sample

To implement Video Call in your app using Objective-C:

1. Replace the contents in the  `ViewController.h` file with the following:

   ```objective-c
   #import <UIKit/UIKit.h>
   
   #import <AgoraRtcKit/AgoraRtcEngineKit.h>
   
   @interface ViewController : UIViewController <AgoraRtcEngineDelegate>
   @property (strong, nonatomic) AgoraRtcEngineKit *agoraKit;
   
   @end
   ```

2. Replace the contents in the `ViewController.m` file with the following:

   ```objective-c
   #import "ViewController.h"
   #import <UIKit/UIKit.h>
   
   @interface ViewController ()
   @property (nonatomic, strong) UIView *localView;
   @property (nonatomic, strong) UIView *remoteView;
   @end
   
   @implementation ViewController
   - (void)viewDidLoad {
       [super viewDidLoad];
       [self initViews];
       [self initializeAndJoinChannel];
   }
   
   - (void)viewDidLayoutSubviews {
       [super viewDidLayoutSubviews];
       self.remoteView.frame = self.view.bounds;
       self.localView.frame = CGRectMake(self.view.bounds.size.width - 90, 0, 90, 160);
   }
   
   - (void)initViews {
       self.remoteView = [[UIView alloc] init];
       [self.view addSubview:self.remoteView];
       self.localView = [[UIView alloc] init];
       [self.view addSubview:self.localView];
   }
   
   - (void)initializeAndJoinChannel {
       // Pass in your App ID here
       self.agoraKit = [AgoraRtcEngineKit sharedEngineWithAppId:@"Your App ID" delegate:self];
       [self.agoraKit enableVideo];
       AgoraRtcVideoCanvas *videoCanvas = [[AgoraRtcVideoCanvas alloc] init];
       videoCanvas.uid = 0;
       videoCanvas.renderMode = AgoraVideoRenderModeHidden;
       videoCanvas.view = self.localView;
       [self.agoraKit setupLocalVideo:videoCanvas];
       // Pass in your token and channel name here
       [self.agoraKit joinChannelByToken:@"Your App ID" channelId:@"Channel name" info:nil uid:0 joinSuccess:^(NSString * _Nonnull channel, NSUInteger uid, NSInteger elapsed) {
       }];
   }
   
   - (void)rtcEngine:(AgoraRtcEngineKit *)engine didJoinedOfUid:(NSUInteger)uid elapsed:(NSInteger)elapsed {
       AgoraRtcVideoCanvas *videoCanvas = [[AgoraRtcVideoCanvas alloc] init];
       videoCanvas.uid = uid;
       videoCanvas.renderMode = AgoraVideoRenderModeHidden;
       videoCanvas.view = self.remoteView;
       [self.agoraKit setupRemoteVideo:videoCanvas];
   }
   
   - (void)applicationWillTerminate:(NSNotification *)notification{
       [self.agoraKit leaveChannel:nil];
       [AgoraRtcEngineKit destroy];
   }
   @end
   ```

