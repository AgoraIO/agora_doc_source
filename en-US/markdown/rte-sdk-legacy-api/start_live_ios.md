The Agora SDK enables you to develop rapidly to enhance your social, work, education, and IoT apps with real-time engagements.

This page shows the minimum code you need to add interactive live streaming into your app by using the Agora Video SDK for iOS.

## Understand the tech



The following figure shows the basic workflow of integrating Agora interactive live broadcast in the app:

![](https://web-cdn.agora.io/docs-files/1628500237769)

To start Interactive Live Streaming Premium, you implement the following steps in your app:

**1. Set the role**
Users in an Interactive Live Streaming Premium channel are either a host or an audience member. The host publishes streams to the channel, and the audience subscribes to the streams. 

**2.  Request a token**
The app client requests a token from your app server. This token authenticates the user when the app client joins a channel.

**3.  Return token**
The app server returns a token to the app client. 

**4. Join a channel**
Call `joinChannel` to create and join a channel. App clients that pass the same channel name join the same channel.

**5. Publish and subscribe to audio and video in the channel**
After joining a channel, a host can publish audio and video and subscribe other hosts in the channel.

**6.  Subscribe to audio and video in the channel**
 The role of audience can only subscribe to all hosts in the channel, you can call `setClientRole` to switch the client role to host. 

For an app client to join a channel, you need the following information:

- The App ID: A randomly generated string provided by Agora for identifying your app. You can get the App ID from [Agora Console](https://console.agora.io).
- The user ID: The unique identifier of a user. You need to specify the user ID yourself, and ensure that it is unique in the channel.
- A token: In a test or production environment, your app client retrieves tokens from your server. For rapid testing, you can use a temporary token with a validity period of 24 hours.
- The channel name: A string that identifies the channel for live streaming. 

## Prerequisites

- Xcode 9.0 or later.
- An iOS device running iOS 8.0 or later
- A valid [Agora account](https://docs.agora.io/en/Agora%20Platform/sign_in_and_sign_up) and an Agora project, obtain the App ID of the project, and generate a temporary token. For details, please refer to [Start using the Agora platform](https://docs.agora.io/en/Agora%20Platform/get_appid_token?platform=All%20Platforms). 
- Apple developer account.
- A computer that can access the Internet. If a firewall is deployed in your network environment, please refer to [Application Enterprise Firewall Restrictions](https://docs.agora.io/en/Agora Platform/firewall?platform=All Platforms) to use Agora services normally.

## Project setup

In Xcode, follow the steps to create the environment necessary to add live streaming into your app.

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

## Implement a client for Interactive Live Streaming Premium

### Create the UI

<div>In the interface, you should have one frame for local video and another for remote video, refer to <a href="#referencecode">Reference code</a> for details.</div>

### Implement the Interactive Live Streaming Premium logic

The following figure and steps show the API call sequence of implementing Interactive Live Streaming Premium. 

![](https://web-cdn.agora.io/docs-files/1628585647397)

1. Initialize `AgoraEngine`: Call the `sharedEngineWithConfig` method to create an instance of `AgoraRtcEngineKit`, and set channel profile as `LiveBroadcasting`.

   Each `AgoraRtcEngineKit` object supports one profile only. If you want to switch to another profile, call `destroy` to release the current `AgoraRtcEngineKit` object and then create a new one by calling `sharedEngineWithConfig` again.

2. You can the client role as a host or audience. The default role is audience. 

   1. Ask the user to choose a client role.
   2. Call `setClientRole` and pass in the client role set by the user.

3. Enable the video module: Call `setupLocalVideo` to initialize the local view.
   1. Call the `enableVideo` method to enable the video module.
   2. Call the `startPreview` method to enable the local video preview before joining the channel.

4. Join the channel: Call `joinChannelByToken` to join the channel.

5. Set the remote view: To set the video view of a remote host, monitor the `didJoinedOfUid` callback, which returns the remote host's ID shortly after the remote host joins the channel; then, call the `setupRemoteVideo` method in the callback, and pass in the retrieved `uid`.

6. Leave channel: Call the `leaveChannel` method to leave the channel, for example, to end live video streaming, close the app, or run the app in the background.

   1. Call `stopPreview` to stop the local video preview.
   2. Call `leaveChannel` to leave the channel.

7. Destroy `AgoraRtcEngineKit` : Call `destroy` to destroy the `AgoraRtcEngineKit` to release all resources used by the Agora SDK.

### <a name="referencecode">Reference  code</a>

The complete code example for this scenario is listed below.

```swift
// ViewController.swift
// Imports the AgoraRtcKit class in your project.
import AgoraRtcKit
// Creates a basic user interface
class ViewController: UIViewController {
    // Defines localView 
    var localView: UIView!
    // Defines remoteView 
    var remoteView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Initializes the video view
        initView()
       // The following functions are used when calling Agora APIs
        initializeAgoraEngine()
        setClientRole
        setupLocalVideo()
        joinChannel
    }
    // Sets the video view layout
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        remoteView.frame = self.view.bounds
        localView.frame = CGRect(x: self.view.bounds.width-90, y: 0, width: 90, height: 160)
    }
    func initView() {
        // Initializes the remote video view. This view displays video when a remote host joins the channel.
        remoteView = UIView()
        self.view.addSubview(remoteView)
        // Initializes the local video window. This view displays video when the local user is a host.
        localView = UIView()
        self.view.addSubview(localView)
    }
    // Defines the agoraKit 
    var agoraKit: AgoraRtcEngineKit!
    // Initializes AgoraEngine
    func initializeAgoraEngine(){
        let config = AgoraRtcEngineConfig()
    // Pass in your App ID here.
        config.appId = "YourAPPID"
    //Sets the channel profile as live broadcast.
        config.channelProfile = .liveBroadcasting
        agoraKit = AgoraRtcEngineKit.sharedEngine(with: config, delegate: self)
    }

    func setClientRole(){
    // Sets client role as host (.broadcaster) or audience (.audience)
    agoraKit?.setClientRole(.broadcaster)
    agoraKit?.setClientRole(.audience)
    }

    func setupLocalVideo() {
        // Enables video module
        agoraKit?.enableVideo()
        // Starts the local video preview
        agoraKit?.startPreview()
        let videoCanvas = AgoraRtcVideoCanvas()
        videoCanvas.uid = 0
        videoCanvas.renderMode = .hidden
        videoCanvas.view = localView
        // Sets  the local video view
        agoraKit?.setupLocalVideo(videoCanvas)
        }
    //Join the channel, the uid of each user in the channel must be unique.
   func joinChannel(){
        // Pass in your token and ChannelID in the code below.
        let option = AgoraRtcChannelMediaOptions()
            agoraKit?.joinChannel(byToken: "YourToken", channelId: "YourChannelID", uid: 0, mediaOptions: option, joinSuccess: {(channel, uid, elapsed) in})
    }

    func leaveChannel() {
        // Stop local video preview
        agoraKit?.stopPreview()
        // Leave the channel
        agoraKit?.leaveChannel(nil)
        }
    // Destroy the AgoraRtcEngineKit object.
    func destroy(){
    AgoraRtcEngineKit.destroy()
    }
}
// Set the remote view
extension ViewController: AgoraRtcEngineDelegate {
    // Monitor the didJoinedOfUid callback
    // The SDK triggers the callback when a remote host joins the channel
    func rtcEngine(_ engine: AgoraRtcEngineKit, didJoinedOfUid uid: UInt, elapsed: Int) {
        let videoCanvas = AgoraRtcVideoCanvas()
        videoCanvas.uid = uid
        videoCanvas.renderMode = .hidden
        videoCanvas.view = remoteView
        // Set the remote video view
        agoraKit?.setupRemoteVideo(videoCanvas)
    }
}
```

## Test your  app

1. Connect the iPhone or iPad to the computer.

2. Click the **Build** button to run your project, and wait a few seconds till the installation completes.

3. Grant microphone and camera access to your app.

4. When the app launches, you should be able to see yourself on the local view if you set the client role as `broadcaster`.

5. Ask a friend to join the live streaming with you on the [demo app](https://webdemo.agora.io/agora-websdk-api-example-4.x/basicLive/index.html). Enter the same App ID, token, and channel name.

   If your friend joins as a host, you should be able to see and hear each other; if as an audience member, you should only be able to see yourself while your friend can see and hear you.

## Next steps

Generating a token by hand is not helpful in a production context. [Authenticate Your Users with Tokens](https://docs.agora.io/en/Interactive Broadcast/token_server?platform=All Platforms) shows you how to start live streaming with a token that you retrieve from your server.

## See also

This section provides additional information for your reference.

### Sample project

Agora provides an open source interactive live broadcast example project [JoinChannelVideo](https://github.com/AgoraIO/API-Examples/tree/dev/3.6.200/iOS/APIExample/Examples/Basic/JoinChannelVideo) on GitHub for your reference.

### Manually integrate the SDK

In addition to integrating the Agora Video SDK for through Cocoapods, you can also import the SDK into your project by manually copying the SDK files.

1. Go to [SDK Downloads](https://docs.agora.io/en/Video/downloads?platform=iOS), download the latest version of the Agora Video SDK, and extract the files from the downloaded SDK package.

2. From the `libs` folder of the downloaded SDK package, copy the files or subfolders you need to the root of your project folder.

   <div class="alert note">Certain files and subfolders under the <code>libs</code> folder are optional. See <a href="https://docs.agora.io/en/Video/faq/reduce_app_size_rtc?platform=iOS#extension_libraries">extension libraries</a> for details.</div>

3. In Xcode, [link your target to the frameworks or libraries](https://help.apple.com/xcode/mac/current/#/dev51a648b07) you have copied. Be sure to choose **Embed & Sign **from the pop-up menu in the Embed column.

   <div class="alert note"><ul><li>Apple does not allow an app extension to contain any dynamic library. If you are integrating the Agora SDK to an app extension, choose <b>Do Not Embed</b> in the Embed column.</li><li>The Agora SDK uses libc++ (LLVM) by default. Contact support@agora.io if you want to use libstdc++ (GNU). The SDK provides FAT image libraries with multi-architecture support for both 32/64-bit audio emulators and 32/64-bit audio/video real devices.</li></ul></div>

### Listening for audience events

The Agora Video SDK does not report events of an audience member in a live streaming channel. Refer to [How can I listen for an audience joining or leaving an interactive live streaming channel](https://docs.agora.io/en/Interactive%20Broadcast/faq/audience_event) if your scenario requires so.

