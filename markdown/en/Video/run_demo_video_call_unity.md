---
title: Run the Sample Project
platform: Unity
updatedAt: 2020-11-30 08:36:58
---
## Introduction

Agora provides an open-source [API-Example-Unity](https://github.com/AgoraIO/Agora-Unity-Quickstart/tree/master/API-Example-Unity) sample project on GitHub. This document introduces how to run this project and experience a video call implemented by the Agora SDK. You can also watch the following video tutorial to start.
<video src="https://web-cdn.agora.io/docs-files/1583295822824" poster="https://web-cdn.agora.io/docs-files/1583295874588" controls width = 100% height = auto>Your browser does not support the <code>video</code> tag.</video>

<div class="alert note">The UI shown in the video may be adjusted and updated. Please refer to the latest version.</div>

## Prerequisites

- Unity 2017 or later (the interface description in this article is based on Unity 2018.4.28f1).

- Unity Hub 1.0.0 or later (the interface description in this article is based on Unity Hub 2.4.3).

- Operating system and IDE requirements:

  | Target Platform | Operating system version | IDE version                           |
  | :-------------- | :----------------------- | :------------------------------------ |
  | Android         | Android 4.1 or later     | Android Studio 3.0 or later           |
  | iOS             | iOS 8.0 or later         | Xcode 9.0 or later                    |
  | macOS           | macOS 10.0 or later      | Xcode 9.0 or later                    |
  | Windows         | Windows 7 or later       | Microsoft Visual Studio 2017 or later |

- A valid [Agora account](https://docs.agora.io/en/Agora%20Platform/sign_in_and_sign_up?platform=Unity)

<div class="alert note"> If your network has a firewall, follow the instructions in <a href="https://docs.agora.io/en/Agora%20Platform/firewall?platform=Unity">Firewall Requirements</a> to access Agora's services.</div>

## Procedure

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



<div class="alert info">The App ID is needed during the <a href="#join">Join a video call</a> procedure.</div>


### 3. Generate a temporary token

To ensure communication security, Agora uses tokens (dynamic keys) to authenticate users joining a channel.

Agora Console supports generating temporary tokens for testing purposes.

1. On the [Project Management](https://dashboard.agora.io/projects) page, find your project, and click ![img](https://web-cdn.agora.io/docs-files/1594284775010) to open the **Token** page.

   ![img](https://web-cdn.agora.io/docs-files/1574927794840)

2. Enter a channel name, and click **Generate Temp Token** to get a temporary token.

   ![img](https://web-cdn.agora.io/docs-files/1574928048948)


<div class="alert note">Temporary tokens are for demonstration and testing purposes only and remain valid for 24 hours. In a production environment, you need to deploy your own server for generating tokens. See <a href="token_server">Generate a Token</a > for details.</div>


<div class="alert info">The temporary token is needed during the <a href="#join">Join a video call</a> procedure.</div>

### 4. Integrate the Agora SDK

Integrate the Agora SDK into the sample project, as follows:

1. Download the [Agora-Unity-Quickstart](https://github.com/AgoraIO/Agora-Unity-Quickstart) repository.
2. Open Unity Hub, and go to the **Installs** panel. Click **ADD** to select a version of Unity, add the needed modules, and click **DONE**.
3. After installation, go to the **Projects** panel. Click **ADD** to add the `Agora-Unity-Quickstart/API-Example-Unity` sample project.
4. On the project list, select a version of Unity, click **API-Example-Unity**, carefully read the message on the pop-up dialog, and click **CONFIRM**. The sample project opens in Unity.
5. In Unity, go to the **Asset Store** panel, find the Agora Video SDK for Unity, and click **Download** to download the SDK.
6. After downloading, click **Import** to open the **Import Unity Package** window.
7. Click **Import** on the **Import Unity Package** window to import the SDK. Once the import is finished, you can see the `AgoraEngine` folder on the **Project** panel.

### 5. Configure the sample project

1. On the **Project** panel of Unity, open the `Assets/API-Example/video-sample` folder.
2. Double-click **MainScene**, and then click **VideoCanvas** on the **Hierarchy** panel.
3. On the **Inspector** panel, find the **Hello Video Agora** script. Enter the App ID of your Agora project, the temporary token generated in Agora Console, and the channel name that you used to generate the temporary token.

![](https://web-cdn.agora.io/docs-files/1605765453520)

### 6. Start a video call

Connect your device, and run the sample project.

For example, when the sample project runs successfully on a macOS device, you can see the following interface.

![](https://web-cdn.agora.io/docs-files/1605765833787)

If you want to experience a one-to-one video call, you can also use the [Agora Web sample app](https://webdemo.agora.io/agora-web-showcase/examples/Agora-Web-Tutorial-1to1-Web/) to interact with your macOS device. Ensure that you enter the same App ID, channel name, and temporary token in the Agora Web sample app as in the API-Example-Unity sample app.

## Sample project structure

See the code of the main functions in the `HelloVideoAgora.cs` file of the sample project for your reference.

## Relevant links

Agora also provides articles for running the sample project on different platforms as follows:

- [Run video chat within your Unity application on Android](https://medium.com/agora-io/run-video-chat-within-your-unity-application-android-add6949f6078)
- [Run video chat within your Unity application on iOS](https://medium.com/agora-io/run-video-chat-within-your-unity-application-ios-425db335a325)
- [Run video chat within your Unity application on macOS](https://medium.com/@jake_agora.io/mac-run-video-chat-within-your-unity-application-e001091db62f)
- [Run video chat within your Unity application on Windows](https://medium.com/@jake_agora.io/windows-run-video-chat-within-your-unity-application-f400f9056749)