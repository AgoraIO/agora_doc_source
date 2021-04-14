---
title: Integrate the SDK
platform: iOS
updatedAt: 2020-10-20 14:42:29
---
# Setting up Your Development Environment

This page contains information on how to prepare the development environment before enabling a video call with the Agora Video SDK.

## Prerequisites

-   Xcode 9.0+.

-   Physical iOS device 8.0+ \(iPhone or iPad\).

-   Ensure that your project has a validated provisioning profile certificate.

-   Before accessing Agora’s services, ensure that you have opened the ports and whitelisted the domains as specified in [Firewall Requirements](/en/Agora%20Platform/firewall).


**Note:** 

Use a physical device to run the sample. Simulators may lack the functionality or the performance needed to run the sample.

## Creating an Agora Account and Getting an App ID

1.  Sign up for a developer account at [https://dashboard.agora.io/](https://dashboard.agora.io/).

2.  Click **Add New Project** on the **Projects** page of the dashboard.


<img alt="../_images/appid_1.jpg" src="https://web-cdn.agora.io/docs-files/en/appid_1.jpg" style="width: 1142.0px; height: 360.0px;"/>


1.  Fill in the **Project Name** and click **Submit**. You have created your first project at Agora.

2.  Find the **App ID** under the created project.


<img alt="../_images/appid_2.jpg" src="https://web-cdn.agora.io/docs-files/en/appid_2.jpg" style="width: 1138.0px; height: 344.0px;"/>


## Adding the Agora SDK to Your Project

Choose one of the following methods to add the Agora SDK libraries to your project:

-   [Adding the Libraries Automatically](#): Add the libraries automatically using *CocoaPods*. You do not need to download the SDK.

-   [Adding the Libraries Manually](#): Download the SDK and add the libraries manually.


### Adding the Libraries Automatically

1.  Install *CocoaPods* by running the following command in Terminal:


```
brew install cocoapods
```

**Note:** 

-   Skip this step if you have preconfigured **CocoaPods** and **Homebrew** on your system.

-   If Terminal says *-bash: brew: command not found*, install Homebrew before running the command. See [Homebrew Installation Method](http://brew.sh/index.html)


1.  Create a Podfile in your project. In the root directory of your project, run the following command in Terminal. This creates a Podfile in the same directory.


```
pod init
```

1.  Add the Agora SDK reference in the Podfile. Open the Podfile, and fill it with the following content. Fill “Your App” with the name of your Target.


```
platform :ios, '9.0'
use_frameworks!

target 'Your App' do
  pod 'AgoraRtcEngine_iOS'
end
```

1.  Update the local Cocoapods library. Run the following command in Terminal:


```
pod update
```

1.  Install the related libraries.


```
pod install
```

If Terminal says *Pod installation complete!*, you have successfully added the libraries. Click open the **YourApp.xcworkspace** file, or run the following command to open it. Fill “YourApp” with the name of your Target.

```
open YourApp.xcworkspace
```

### Adding the Libraries Manually

1.  Download the [Agora Video SDK for iOS](https://docs.agora.io/en/2.2.3/download)

2.  Open your project with Xcode and select the current Target.


<img alt="../_images/ios_video_1.jpg" src="https://web-cdn.agora.io/docs-files/en/ios_video_1.jpg" style="width: 991.0px; height: 345.0px;"/>


1.  Navigate to the **Build Phases** tab.


<img alt="../_images/ios_video_2.jpg" src="https://web-cdn.agora.io/docs-files/en/ios_video_2.jpg" style="width: 1030.0px; height: 276.0px;"/>


1.  Expand the **Link Binary with Libraries** section to add the following libraries. To begin adding new libraries, click the **+** button.

    -   *AgoraRtcEngineKit.framework*

    -   *Accelerate.framework*

    -   *SystemConfiguration.framework*

    -   *libc++.tbd*

    -   *libresolv.tbd*

    -   *CoreMedia.framework*

    -   *VideoToolbox.framework*

    -   *AudioToolbox.framework*

    -   *CoreTelephony.framework*

    -   *AVFoundation.framework*


**Before:**

<img alt="../_images/ios_video_3.jpg" src="https://web-cdn.agora.io/docs-files/en/ios_video_3.jpg" style="width: 1029.0px; height: 386.0px;"/>


**After:**

<img alt="../_images/ios_video_4.jpg" src="https://web-cdn.agora.io/docs-files/en/ios_video_4.jpg" style="width: 993.0px; height: 509.0px;"/>


**AgoraRtcEngineKit.framework** is in the **libs** folder of the downloaded SDK. Click **+** \> **Add Other…**, go to the downloaded SDK and add **AgoraRtcEngineKit.framework**.

<img alt="../_images/ios_video_5.jpg" src="https://web-cdn.agora.io/docs-files/en/ios_video_5.jpg" style="width: 991.0px; height: 488.0px;"/>


## Authorizing the Use of the Agora SDK

Before enabling a video call, you need to enable camera and microphone access to the SDK on your device. Open *info.plist* and click **+** to add:

-   **Privacy - Microphone Usage Description**, and add a note in the **Value** colume.

-   **Privacy - Camera Usage Description**, and add a note in the **Value** colume.


**Before:**

<img alt="../_images/ios_video_6.jpg" src="https://web-cdn.agora.io/docs-files/en/ios_video_6.jpg" style="width: 995.0px; height: 355.0px;"/>


**After:**

<img alt="../_images/ios_video_7.jpg" src="https://web-cdn.agora.io/docs-files/en/ios_video_7.jpg" style="width: 993.0px; height: 384.0px;"/>


## Accessing the Library

You can access the added library using [Objective-C](#) or [Swift](#).

### Objective-C

In the main file that uses Agora APIs, add **\#import <AgoraRtcEngineKit/AgoraRtcEngineKit.h\>**.

**Note:** 

The SDK provides FAT image libraries with multi-architecture support for both 32/64-bit audio emulators and 32/64-bit audio/video real devices.

### Swift

In the main file that uses Agora APIs, add **import AgoraRtcEngineKit**.

<img alt="../_images/ios_video_8.jpg" src="https://web-cdn.agora.io/docs-files/en/ios_video_8.jpg" style="width: 992.0px; height: 401.0px;"/>


## Additional Settings and Permissions

The Agora SDK provides the following additional settings and permissions for you to optimize your project:

-   Set the Background Modes. When the background mode is enabled, your application can still run the video call when it is switched to the background. Select the current Target, click the **Capabilities** tab, enable **Background Modes**, and check **Audio, AirPlay, and Picture in Picture**.

    <img alt="../_images/ios_video_9.jpg" src="https://web-cdn.agora.io/docs-files/en/ios_video_9.jpg" style="width: 992.0px; height: 462.0px;"/>


-   Enable or disable Bitcode. Applications developed with Bitcode can be optimized once it is uploaded to the App Store. Select the current Target, click the **Build Settings** tab, and enable or disable Bitcode according to your actual needs.

    <img alt="../_images/ios_video_10.jpg" src="https://web-cdn.agora.io/docs-files/en/ios_video_10.jpg" style="width: 992.0px; height: 343.0px;"/>



