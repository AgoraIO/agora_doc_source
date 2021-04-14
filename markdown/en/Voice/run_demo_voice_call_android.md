---
title: Run the Sample Project
platform: Android
updatedAt: 2021-01-19 06:07:39
---
Agora provides an open-source [Agora-Android-Voice-Tutorial-1to1](https://github.com/AgoraIO/Basic-Audio-Call/tree/master/One-to-One-Voice/Agora-Android-Voice-Tutorial-1to1) sample project on GitHub. This document introduces how to run this project and experience a voice call implemented by the Agora SDK.

## Prerequisites

- Development environment requirements:
  - [Java Development Kit](https://www.oracle.com/java/technologies/javase-downloads.html)
  - Android Studio 3.0 or later
- If your network has a firewall, follow the instructions in [Firewall Requirements](https://docs.agora.io/en/Agora%20Platform/firewall?platform=All%20Platforms) to access Agora services.
- A real Android device. Agora recommends you run this sample project on a physical mobile device, as some simulators may not support the full features of this project.
- A valid [Agora account](https://docs.agora.io/en/Agora%20Platform/sign_in_and_sign_up).

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



### 3. Generate a temporary token

To ensure communication security, Agora uses tokens (dynamic keys) to authenticate users joining a channel.

Agora Console supports generating temporary tokens for testing purposes.

1. On the [Project Management](https://console.agora.io/projects) page, find your project, and click ![img](https://web-cdn.agora.io/docs-files/1594284775010) to open the **Token** page.

   ![img](https://web-cdn.agora.io/docs-files/1574927794840)

2. Enter a channel name, and click **Generate Temp Token** to get a temporary token.

   ![img](https://web-cdn.agora.io/docs-files/1574928048948)


<div class="alert note">Temporary tokens are for demonstration and testing purposes only and remain valid for 24 hours. In a production environment, you need to deploy your own server for generating tokens. See <a href="token_server">Generate a Token</a > for details.</div>


### **4. Configure the sample project**

1. Download the [Basic-Audio-Call](https://github.com/AgoraIO/Basic-Audio-Call) repository.
2. Find the Basic-Audio-Call/One-to-One-Voice/Agora-Android-Voice-Tutorial-1to1 sample project. Fill in the `app/src/main/res/values/strings.xml` file with the App ID and temporary token generated in Agora Console.
```java
// Replace <#YOUR APP ID#> with your App ID in the string format
<string name="agora_app_id"><#YOUR APP ID#></string>
// Replace #YOUR ACCESS TOKEN# with your temporary token in the string format
<string name="agora_access_token">#YOUR ACCESS TOKEN#</string>
```

### 5. Integrate the Agora SDK

Integrate the Agora Voice SDK into the sample project, as follows:

1. Download the latest version of the [Agora Voice SDK ](https://docs.agora.io/en/All/downloads?platform=All%20Platforms)and extract the files from the downloaded package.

2. Copy the following files or subfolders from the `libs` folder of the SDK package to the corresponding folder of the sample project:

   | File/Folder        | Path                   |
   | :----------------- | :--------------------- |
   | agora-rtc-sdk.jar  | /app/libs/             |
   | arm-v8a folder     | /app/src/main/jniLibs/ |
   | armeabi-v7a folder | /app/src/main/jniLibs/ |
   | x86 folder         | /app/src/main/jniLibs/ |
   | x86_64 folder      | /app/src/main/jniLibs/ |
	 
	 
### 6. Build and run the sample project

Connect the Android device to your computer, open the Agora-Android-Voice-Tutorial-1to1 sample project on Android Studio, and then build and run the project.

After the IDE successfully installs the app on your Android device, you can see the following user interface:

![](https://web-cdn.agora.io/docs-files/1606198898254)

You have joined the voiceDemoChannel1 channel by default. If you want to experience a one-to-one voice call, you can use the [Agora Web demo app](https://webdemo.agora.io/agora-web-showcase/examples/Agora-Web-Tutorial-1to1-Web/) to interact with your Android device. Ensure that you enter the same App ID, channel name, and temporary token in the Agora Web demo app.