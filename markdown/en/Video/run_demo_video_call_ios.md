---
title: Run the Sample Project
platform: iOS
updatedAt: 2021-01-25 09:31:33
---
Agora provides an open-source [Agora-iOS-Tutorial-Swift-1to1](https://github.com/AgoraIO/Basic-Video-Call/tree/master/One-to-One-Video/Agora-iOS-Tutorial-Swift-1to1) sample project on GitHub. This document introduces how to run this project and experience a video call implemented by the Agora SDK.

## Prerequisites

- Xcode 9.0 or later (the interface described in this article is based on Xcode 13.0).
- An iOS device running iOS 8.0 or later.
- A valid [Agora account](https://docs.agora.io/en/Agora Platform/sign_in_and_sign_up).

<div class="alert note">If your network has a firewall, follow the instructions in <a href="https://docs.agora.io/en/Agora%20Platform/firewall?platform=All%20Platforms">Firewall Requirements</a> to access Agora services.</div>

## Procedures
### 1. Create an Agora project

Create a project in [Agora Console](https://console.agora.io/), as follows:

1. Log in to Console, and click ![img](https://web-cdn.agora.io/docs-files/1594283671161) in the left navigation menu to enter the [Project Management](https://dashboard.agora.io/projects) page.

2. Click **Create**.

   [![create button](https://web-cdn.agora.io/docs-files/1594949127367)](https://dashboard.agora.io/projects)

3. Enter your project name, and select **Secure mode: APP ID + Token** for the authentication mechanism in the pop-up window.

4. Click **Submit**. You can see the created project on the **Project Management** page.

### 2. Get an App ID

Agora automatically assigns each project an App ID as a unique identifier.

To copy this App ID, find your project on the [Project Management](https://dashboard.agora.io/projects) page in Agora Console, and click the eye icon to the right of the App ID.

![get app id](https://web-cdn.agora.io/docs-files/1602646621028)



### 3. Generate a temporary token

To ensure communication security, Agora uses tokens (dynamic keys) to authenticate users joining a channel.

Agora Console supports generating temporary tokens for testing purposes.

1. On the [Project Management](https://dashboard.agora.io/projects) page, find your project, and click ![img](https://web-cdn.agora.io/docs-files/1594284775010) to open the **Token** page.

   ![img](https://web-cdn.agora.io/docs-files/1574927794840)

2. Enter a channel name, and click **Generate Temp Token** to get a temporary token.

   ![img](https://web-cdn.agora.io/docs-files/1574928048948)


<div class="alert note">Temporary tokens are for demonstration and testing purposes only and remain valid for 24 hours. In a production environment, you need to deploy your own server for generating tokens. See <a href="token_server">Generate a Token</a > for details.</div>


### 4. Configure the sample project
1. Download the [Basic-Video-Call](https://github.com/AgoraIO/Basic-Video-Call) repository, and find the Agora-iOS-Voice-Tutorial-Swift-1to1 sample project.
2. Fill in the `Agora-iOS-Tutorial/AppID.swift` file with the Apple ID and temporary token generated in Agora Console.
```swift
 // Replace #Your App Id# with your App ID, and add quotation marks around it, such as "xxxxxx"
let AppID: String = <#Your App ID#>

 // Replace #Temp Access Token# with your temporary Token, and add quotation marks, such as "xxxxxx"
let Token: String? = <#Temp Token#>
```

3. `Open the VideoChatViewController.swift` file, and set `channelId` of the `joinChannelByToken` method with the channel name that you use to generate the temporary token.
```swift
 func joinChannel() {
        agoraKit.setDefaultAudioRouteToSpeakerphone(true)
        // Replace demoChannel1 with the channel name that you use to generate the temporary token
        agoraKit.joinChannel(byToken: Token, channelId: "demoChannel1", info: nil, uid: 0) { [unowned self] (channel, uid, elapsed) -> Void in
            self.isLocalVideoRender = true
            self.logVC?.log(type: .info, content: "did join channel")
        }
```

### 5. Integrate the Agora SDK

Integrate the Agora iOS SDK into the sample project, as follows:

1. Download the latest [Agora iOS SDK](./downloads?platform=iOS) and extract the files.
2. Copy `AgoraRtcKit.framework` from the `libs` folder to the `Agora-iOS-Tutorial` folder.

### 6. Compile and run the sample project
Connect your computer to an iOS device, open the sample project on Xcode, and then compile and run the project. If the project runs successfully, you can see the following screen on the iOS device:
![](https://web-cdn.agora.io/docs-files/1605677954238)
Now you can experience a video call. You can also use the [Agora Web sample app](https://webdemo.agora.io/agora-web-showcase/examples/Agora-Web-Tutorial-1to1-Web/) to interact with your iOS device. Ensure that you enter the same App ID, channel name, and temporary token in the Agora Web sample app.
## Sample project structure

The following table lists the structure of the sample project for your reference:

| File/Folder                   | Description                                                  |
| :---------------------------- | :----------------------------------------------------------- |
| VideoChatViewController.swift | The code of the main functions and the UI after joining a channel. |
| AppID.swift                   | The code for configuring the App ID and the token.           |

## Relevant links

Apart from Swift, Agora provides an additional [Agora-iOS-Tutorial-Objective-C-1to1](https://github.com/AgoraIO/Basic-Video-Call/tree/master/One-to-One-Video/Agora-iOS-Tutorial-Objective-C-1to1) sample project in Objective-C.