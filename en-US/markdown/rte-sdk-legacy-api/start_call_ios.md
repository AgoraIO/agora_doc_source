Real-time video chatting immerses people in the sights and sounds of human connections, keeping them engaged in your app longer.

This page shows the minimum code you need to integrate high-quality, low-latency Video Call function into your app using the Video SDK for iOS.

## Understand the tech

The following figure shows the workflow you need to integrate into your app in order to achieve Video Call functionality.

![](https://web-cdn.agora.io/docs-files/1629250175461)

To start video call, implement the following steps in your app:

1. **Set the role**

   Set both app clients as the host.

2. **Join a channel**

   Call `joinChannel` to create and join a channel. App clients that pass the same channel name join the same channel.

3. **Publish and subscribe to audio and video in the channel**

   After joining a channel,  both hosts can publish video and audio stream to the channel and subscribe to each other.

## Prerequisites

- Xcode 9.0 or later.
- Two iOS devices running iOS 8.0 or later
- A computer that can access the Internet. Ensure that no firewall is deployed in your network environment, otherwise the project will fail.
- A valid [Agora account](https://docs.agora.io/en/Agora%20Platform/sign_in_and_sign_up) and an Agora project, please refer to [Start using the Agora platform](https://docs.agora.io/en/Agora%20Platform/get_appid_token?platform=All%20Platforms) and get the following information from Agora Console:
  - The App ID: A randomly generated string provided by Agora for identifying your app. 
  - A temporary  token: A token is the credential that authenticates a user when your app client joins a channel. A  temporary token is valid for 24 hours.
  - The channel name: A string that identifies the channel. 
- Apple developer account.


## Project setup

In order to create the environment necessary to integrate Video Call into your app, do the following in Xcode:

1. [Create a new project](https://help.apple.com/xcode/mac/current/#/dev07db0e578) for an iOS app using the **Single View App** template. Make sure you select **Storyboard** as the user interface.

   <div class="alert note">If you have not added any team information, you can see an **Add account...** button. Click it, input your Apple ID, and click **Next** to add your team.</div>

2. [Enable automatic signing](https://help.apple.com/xcode/mac/current/#/dev23aab79b4) for your project.

3. [Set the target devices](https://help.apple.com/xcode/mac/current/#/deve69552ee5) to deploy your iOS app.

4. Add project permissions for microphone and camera usage.

   Open the `info.plist ` file in the project navigation panel, and [edit the property list](https://help.apple.com/xcode/mac/current/#/dev3f399a2a6) to add the following properties:

   | key                                  | type   | value                                                        |
   | :----------------------------------- | :----- | :----------------------------------------------------------- |
   | Privacy-Microphone Usage Description | String | The purpose for accessing the microphone, such as for a call or live interactive streaming. |
   | Privacy-Camera Usage Description     | String | To access the camera, such as for a call or live interactive streaming. |

5. Integrate the video SDK into your Xcode project through Cocoapods.

   Ensure that you have installed CocoaPods before the following steps. If it is not installed, you can refer to [Getting Started with CocoaPods](https://guides.cocoapods.org/using/getting-started.html#getting-started) to install Cocoapods to this machine.

   1. Enter the project root directory in **Terminal** and run the `pod init` command. after which you can find the **Podfile** under the project directory.

   2. Open the **Podfile** and modify it by referring to the code below. Remember to change`Your App` to the target name of your project.

      ```
      platform :ios, '9.0'
      target 'Your App' do
      pod'AgoraRtcEngine_Special_iOS'
      end
      ```

   3. Run the `pod install` command in the *Terminal* to install the Agora SDK. Once you successfully install the **SDK**, it shows `Pod installation complete!`

   4. A new file with a suffix of .xcworkspace will be generated under the project folder. Use Xcode to open it for subsequent operations.

## Implement a client for Video Call

This section shows how to use the Agora Video SDK to implement Video Call into your app step by step.

### Create the UI

When creating the user interface for basic Video Call, Agora recommends adding the video view of the host on both the local and remote clients. Refer to the following code samples to create a basic UI from scratch:

```swift
// ViewController.swift
import UIKit
class ViewController: UIViewController {
    ...
     // Defines localView
    var localView: UIView!
    // Defines remoteView
    var remoteView: UIView!
    // Defines agoraKit
    var agoraKit: AgoraRtcEngineKit!
  
    // Sets the video view layout
    override func viewDidLayoutSubviews(){
        super.viewDidLayoutSubviews()
        remoteView.frame = self.view.bounds
        localView.frame = CGRect(x: self.view.bounds.width - 90, y: 0, width: 90, height: 160)
        }
      
    func initView(){
        // Initializes the remote video view. This view displays video when a remote host joins the channel.
        remoteView = UIView()
        self.view.addSubview(remoteView)
        // Initializes the local video window. This view displays video when the local user is a host.
        localView = UIView()
        self.view.addSubview(localView)
    }
```

### Implement the Video Call logic

The following figure and steps show the API call sequence of implementing Video Call. 

![](https://web-cdn.agora.io/docs-files/1629361200930)

To implement this logic, take the following steps:

1. Import the Agora kit.

   In `ViewController.swift`, add the following line after `import UIKit`:

   ```swift
    import AgoraRtcKit
   ```

   And add the `agoraKit` variable in the `ViewController` class:

   ```swift
   class ViewController: UIViewController {
      // Defines localView
       var localView: UIView!
       // Defines remoteView
       var remoteView: UIView!
       // Defines agoraKit
       var agoraKit: AgoraRtcEngineKit!
   }
   ```

2. Initialize `AgoraEngine`.

   Each `AgoraRtcEngineKit` object supports one profile only. If you want to switch to another profile, call `destroy` to release the current `AgoraRtcEngineKit` object and then create a new one by calling `sharedEngineWithConfig` again.

   In `ViewController.swift`, add the following lines after the `initView` function:

   ```swift
       func initializeAgoraEngine(){
           let config = AgoraRtcEngineConfig()
           // Pass in your App ID here.
           config.appId = "Your app Id"
           agoraKit = AgoraRtcEngineKit.sharedEngine(with: config, delegate: self)
       }
   ```

3. Enable the video module.

   In `ViewController.swift`, add the following lines after the `initializeAgoraEngine` function:

   ```swift
       func setupLocalVideo(){
           // Enables video module
           agoraKit.enableVideo()
           // Starts the local video preview
           agoraKit.startPreview()
           let videoCanvas = AgoraRtcVideoCanvas()
           videoCanvas.uid = 0
           videoCanvas.renderMode = .hidden
           videoCanvas.view = localView
           // Sets the local video view
           agoraKit.setupLocalVideo(videoCanvas)
       }
   ```

4. Join the channel with a temp token, channel name, and uid of your project. Channel profile and client role type will also be configured.

   In `ViewController.swift`, add the following lines after the `setupLocalVideo` function:

   ```swift
       func joinChannel(){
           let option = AgoraRtcChannelMediaOptions()
           // For a video call scenario, set the channel profile as liveBroadcasting.
           option.channelProfile = .of((Int32)(AgoraChannelProfile.liveBroadcasting.rawValue))
           // Set the client role as broadcaster.
           option.clientRoleType = .of((Int32)(AgoraClientRole.broadcaster.rawValue))
           
           // Join the channel with a temp token. Pass in your token and channel name here   
           agoraKit.joinChannel(byToken: "Your token", channelId: "Your channel name", uid:0, mediaOptions: option)
       }
   ```

5. Add the remote interface when a remote host joins the channel.

   In `ViewController.swift`, add the following lines after the `ViewController` class:

    ```swift
   extension ViewController: AgoraRtcEngineDelegate{
       func rtcEngine(_ engine: AgoraRtcEngineKit, didJoinedOfUid uid: UInt, elapsed: Int){
           let videoCanvas = AgoraRtcVideoCanvas()
           videoCanvas.uid = uid
           videoCanvas.renderMode = .hidden
           videoCanvas.view = remoteView
           agoraKit.setupRemoteVideo(videoCanvas)
       }
   }
    ```

### Start and stop your app

Now you have created the Video Call functionality. In this implementation, a video call starts when the user opens your app. The video call ends when the user closes your app.

1. When the view is loaded, call `initializeAndJoinChannel` to join channel.

   In `ViewController.swift`, add the `viewDidLoad` function inside the `UIViewController` function:

    ```swift
        override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view.
            // Initializes the video view
            initView()
            // The following functions are used when calling Agora APIs
            initializeAgoraEngine()
            setupLocalVideo()
            joinChannel()
        }
    ```

2. Leave channel in order to clean up all the resources used by your app. 

   In `ViewController.swift`, add `viewDidDisappear` after the `joinChannel` function:

   ```swift
       override func viewDidDisappear(_ animated: Bool) {
           super.viewDidDisappear(true)
           agoraKit.stopPreview()
           agoraKit.leaveChannel(nil)
           AgoraRtcEngineKit.destroy()
       }
   ```

## Test your  app

Please follow the test procedure as shown in the example.

1. Connect the iOS devices to the computer.

2. Click the **Build** button to run your project, and wait a few seconds till the installation completes.

3. Grant microphone and camera access to your app.

4. When the app launches, you should be able to see yourself on the local view if you set the client role as `broadcaster`.

5. Ask a friend to use a second device to join the channel with the same App ID, token, and channel name.

   You should be able to see and hear each other.

## Next steps

In a test or production environment, use a token server to generate token is recommended to ensure communication security, see [Authenticate Your Users with Tokens](https://docs.agora.io/en/Interactive Broadcast/token_server?platform=All Platforms) for details.

## See also

This section provides additional information for your reference.

### Sample project

Agora provides an open source video call example project [JoinChannelVideo](https://github.com/AgoraIO/API-Examples/tree/dev/3.6.200/iOS/APIExample/Examples/Basic/JoinChannelVideo) on GitHub for your reference.

### Manually integrate the SDK

In addition to integrating the Agora Video SDK for through Cocoapods, you can also import the SDK into your project by manually copying the SDK files.

1. Go to [SDK Downloads](https://docs.agora.io/en/Video/downloads?platform=iOS), download the latest version of the Agora Video SDK, and extract the files from the downloaded SDK package.

2. From the `libs` folder of the downloaded SDK package, copy the files or subfolders you need to the root of your project folder.

3. In Xcode, [link your target to the frameworks or libraries](https://help.apple.com/xcode/mac/current/#/dev51a648b07) you have copied. Be sure to choose **Embed & Sign **from the pop-up menu in the Embed column.
