---
title: Run the Sample Project
platform: macOS
updatedAt: 2021-01-25 09:31:35
---
## Introduction

Agora provides an open-source [OpenLive-macOS](https://github.com/AgoraIO/Basic-Video-Broadcasting/tree/master/OpenLive-macOS) sample project on GitHub. This document introduces how to run this project and experience a live video streaming implemented by the Agora SDK.

## Prerequisites

- Xcode 10.0 or later (the interface description in this article is based on Xcode 11.0).
- A macOS device running macOS 10.10 or later.
- A valid [Agora account](https://docs.agora.io/en/Agora%20Platform/sign_in_and_sign_up?platform=macOS).



<div class="alert note"> If your network has a firewall, follow the instructions in <a href="https://docs.agora.io/en/Agora%20Platform/firewall?platform=macOS">Firewall Requirements</a> to access Agora's services.</div>

## Procedure

### 1. Create an Agora project


Create a project in [Agora Console](https://console.agora.io/), as follows:

1. Log in to Console, and click ![img](https://web-cdn.agora.io/docs-files/1594283671161) in the left navigation menu to enter the [Project Management](https://console.agora.io/projects) page.

2. Click **Create**.

   [![create button](https://web-cdn.agora.io/docs-files/1594949127367)](https://dashboard.agora.io/projects)

3. Enter your project name, and select **Secure mode: APP ID + Token** for the authentication mechanism in the pop-up window.

4. Click **Submit**. You can see the created project on the **Project Management** page.





### 2. Get an App ID


Agora automatically assigns each project an App ID as a unique identifier.

To copy this App ID, find your project on the [Project Management](https://console.agora.io/projects) page in Agora Console, and click the eye icon to the right of the App ID.

![get app id](https://web-cdn.agora.io/docs-files/1602646621028)




<div class="alert info">The App ID is needed during the <a href="#join">Join a video call</a> procedure.</div>


### 3. Generate a temporary token


To ensure communication security, Agora uses tokens (dynamic keys) to authenticate users joining a channel.

Agora Console supports generating temporary tokens for testing purposes.

1. On the [Project Management](https://console.agora.io/projects) page, find your project, and click ![img](https://web-cdn.agora.io/docs-files/1594284775010) to open the **Token** page.

   ![img](https://web-cdn.agora.io/docs-files/1574927794840)

2. Enter a channel name, and click **Generate Temp Token** to get a temporary token. When joining the channel, ensure that the channel name is the same with the one that you use to generate the temporary token.

   ![img](https://web-cdn.agora.io/docs-files/1574928048948)


<div class="alert note">Temporary tokens are for demonstration and testing purposes only and remain valid for 24 hours. In a production environment, you need to deploy your own server for generating tokens. See <a href="token_server">Generate a Token</a > for details.</div>



<div class="alert info">The temporary token is needed during the <a href="#join">Join a video call</a> procedure.</div>



### 4. Configure the sample project

1. Download the [Basic-Video-Broadcasting](https://github.com/AgoraIO/Basic-Video-Broadcasting) repository, and find the `OpenLive-macOS` sample project.
2. Open the `OpenLive/``KeyCenter.swift` file, replace `<#Your App Id#>` with the App ID of your Agora project, and replace `<#Temp Access Token#>` with the temporary token generated in Agora Console.



```swift
struct KeyCenter {
    static let AppId: String = <#Your App Id#>    
    static var Token: String? = <#Temp Access Token#>
}
```

### 5. Integrate the Agora SDK

Integrate the Agora SDK into the sample project, as follows:

1. Go to [SDK Downloads](https://docs.agora.io/en/All/downloads?platform=macOS), download the latest version of the Agora SDK, and extract the files from the downloaded SDK package.
2. Copy `AgoraRtcKit.framework` from the `libs` folder to the `OpenLive` folder.

### 6. Start a live video streaming

Run the sample project to start a live video streaming, as follows:

1. Open and run the `OpenLive.xcodeproj` sample project on a macOS device. When the sample project runs successfully, you can see the following interface.
![](https://web-cdn.agora.io/docs-files/1605690476133)

2. Choose a user role, enter the channel name that you used to generate the temporary token, and then click **Start Live Streaming** to start the live video streaming. If you set your role as a host, you need to allow the sample app to access your camera and microphone in the pop-up window, and then you should see a video stream of yourself on the application.

If you want to experience an interactive live video streaming, you can also use the [Agora Web sample app](https://webdemo.agora.io/agora-web-showcase/examples/Agora-Web-Tutorial-1to1-Web/) to interact with your macOS device. Ensure that you enter the same App ID, channel name, and temporary token in the Agora Web sample app as in the OpenLive sample app.

## Sample project structure

The following table lists the code structure of the sample project for your reference:

| File/Folder                | Description                                                  |
| :------------------------- | :----------------------------------------------------------- |
| `RoomViewController.swift` | The code of the main functions and the front-end style after joining a channel. |
| `KeyCenter.swift`          | The code for authentication.                                 |
| `MainViewController.swift` | The code of the front-end style before joining a channel.    |

## Relevant links

Agora provides an additional video call sample project on GitHub: [OpenLive-macOS-Objective-C](https://github.com/AgoraIO/Basic-Video-Broadcasting/tree/master/OpenLive-macOS-Objective-C).