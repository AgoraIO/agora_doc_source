---
title: Run the Sample Project
platform: Cocos2d-x
updatedAt: 2020-12-14 02:42:43
---
Agora provides an open-source sample project [Cocos2d-x](https://github.com/AgoraIO-Community/Agora-Cocos-Quickstart/tree/master/Cocos2d-x) on GitHub. This sample project demonstrates how to implement audio and video calls in a Cocos2d-x project with the Agora Voice or Video SDK.

This article introduces how to run the sample project to experience a video call implemented by the Agora Video SDK.

## Prerequisites

### Development environment

If your target platform is Android, your development environment must meet the following requirements:

- Android Studio 3.0 or later.
- A mobile device running Android 4.1 or later. Agora recommends you run this sample project on a physical mobile device, as some simulators may not support the full features of this project.
- NDK r18b or later.
- cmake.

If your target platform is iOS, your development environment must meet the following requirements:

- Xcode 9.0 or later.
- A mobile device running iOS 8.0 or later. Agora recommends you run this sample project on a physical mobile device, as some simulators may not support the full features of this project.

### Other Prerequisites

- Cocos2d-x 3.0 or later.
  <div class="alert info">This sample project is developed based on Cocos2d-x 3.17.2. If you use Cocos2d-x 4.0 or later, please refer to <a href="https://docs.cocos.com/cocos2d-x/v4/manual/en/upgradeGuide/migration.html">Cocos documentation</a > to upgrade from v3 to v4.</div>
  
- A valid Agora [account](/en/Agora%20Platform/sign_in_and_sign_up?platform=All%20Platforms).

  <div class="alert note">If your network has a firewall, follow the instructions in <a href="/en/Agora%20Platform/firewall?platform=All%20Platforms">Firewall Requirements</a > to access Agora services</a >.</div>
  
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

2. Enter a channel name, and click **Generate Temp Token** to get a temporary token. When joining the channel, ensure that the channel name is the same with the one that you use to generate the temporary token.

   ![img](https://web-cdn.agora.io/docs-files/1574928048948)


<div class="alert note">Temporary tokens are for demonstration and testing purposes only and remain valid for 24 hours. In a production environment, you need to deploy your own server for generating tokens. See <a href="token_server">Generate a Token</a > for details.</div>


### 4. Fill in your App ID and Token

Download the [Agora-Cocos-Quickstart](https://github.com/AgoraIO-Community/Agora-Cocos-Quickstart) repository and extract the files from the package. Find the sample project folder `Cocos2d-x`, open the `Classes/HelloWorldScene.h` file, and fill in your App ID and temporary token.

<div class="alert note">Agora recommends moving the <code>Cocos2d-x</code> folder to the root directory of your working disk to shorten the project path; otherwise, the build of Android project may fail because the project path is too long.</div>

```c++
// Replace <#YOUR APP ID#> with your App ID and add quotation marks, such as "xxxxxx".
#define AGORA_APP_ID <#YOUR APP ID#>
// Replace <#YOUR TOKEN#> with your temporary token and add quotation marks, such as "xxxxxxx".
#define AGORA_TOKEN <#YOUR TOKEN#>
```

### 5. Integrate Agora Video SDK

Follow these steps to integrate the Agora Video SDK into the sample project:

**For Android**:

1. Go to [SDK Downloads](./downloads?platform=Cocos2d-x), download the latest version of the Agora Video SDK for Android, and extract the files from the downloaded SDK package.

2. Copy the following files or subfolders from the `libs` folder of the downloaded SDK package to the path of your project.

   | File or subfolder        | Path of your project          |
   | :----------------------- | :---------------------------- |
   | `agora-rtc-sdk.jar` file | `Cocos2d-x/sdk/android/lib`   |
   | `arm-v8a` folder         | `Cocos2d-x/sdk/android/agora` |
   | `armeabi-v7a` folder     | `Cocos2d-x/sdk/android/agora` |
   | `include` folder         | `Cocos2d-x/sdk/android/agora` |
   | `x86` folder             | `Cocos2d-x/sdk/android/agora` |
   | `x86_64` folder          | `Cocos2d-x/sdk/android/agora` |

**For iOS**:

1. Go to [SDK Downloads](./downloads?platform=Cocos2d-x), download the latest version of the Agora Video SDK for iOS, and extract the files from the downloaded SDK package.

2. Copy the `AgoraRtcKit.framework` and `AgoraRtcCryptoLoader.framework` folders from the `libs` folder of the downloaded SDK package to `Cocos2d-x/sdk/ios/agora` of your project.

   <div class="alert note">If you need to support a simulator, then copy the <code>AgoraRtcKit.framework</code>  and <code>AgoraRtcCryptoLoader.framework</code> folders from the <code>ALL_ARCHITECTURE</code> folder to <code>Cocos2d-x/sdk/ios/agora</code> of your project instead. The dynamic libraries under this path contains the x86_64 architecture, which affects the distribution of your app in the App Store. Therefore, you need to remove the x86_64 architecture in the libraries before uploading the app to the App Store.</div>

### 6. Integrate Cocos2d-x engine

1. Go to the [Cocos2d-x download](https://www.cocos.com/en/cocos2dx/download) page, select a version of Cocos2d-x, and then download it. (Cocos2d-x 3.17.2 recomended)
2. Extract the files from the downloaded package, and then copy all files and folders to the `cocos2d` folder of your project.

### 7. Run the project

**To run the Android app**:

1. Enable **Developer options** and **USB Debugging** on your Android device, and then connect it to your computer using a USB cable.
2. Open the `Cocos2d-x/proj.android` folder with Android Studio.
3. Select **File > Project Structure > SDK Location**, fill in the local path of your NDK under **Android NDK Location**, and then click **Apply > OK**.
4. Click **Sync Project with Gradle Files**.
5. After the Gradle synchronization finishes, click **Build and run**.

**To run the iOS app**:

1. Open `Cocos2d-x/proj.ios_mac/Hello-Cocos2d-Agora.xcodeproj` with Xcode.
2. Connect your iOS device to your computer using a USB cable.
3. Click the **Build and run** button in Xcode.

You should see the following screen when the app runs on your device. You can enter a channel name in the **Channel ID** edit box and click **Join Channel** to start a video call.

<div class="alert note">The channel name must be the same as the the channel name that you used to generate the token.</div>

![](https://web-cdn.agora.io/docs-files/1606019292621)


## Common issues

If you use Cocos2d-x 3.17.2 and encounter `error: argument value 10880 is outside the valid range [0, 255] [-Wargument-outside-range]` when compiling the iOS project, you can search for the `btVector3.h` file in your project and make the following modifications:

```c++
// Before change
#define BT_SHUFFLE(x,y,z,w) ((w)<<6 | (z)<<4 | (y)<<2 | (x))
// After change
#define BT_SHUFFLE(x,y,z,w) (((w)<< 6 | (z)<< 4 | (y)<< 2 | (x)) & 0xff)
```