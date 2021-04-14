---
title: Run the Sample Project
platform: iOS
updatedAt: 2020-11-16 04:34:47
---
## Introduction

Agora provides an open-source [Agora Live](https://github.com/AgoraIO-Usecase/AgoraLive) sample project on GitHub. This sample project demonstrates how to use the Agora RTC SDK, Agora RTM SDK, and third-party image enhancement SDK to implement the following live interactive streaming scenarios:

- Single Host
- Multiple Hosts
- Virtual Host
- PK Host
- Live-stream Shopping

This document introduces how to run this project and experience live interactive video streaming in each scenario.

## Prerequisites

- Xcode 10.0 or later.
- CocoaPods. You can refer to the installation guide in [Getting Started with CocoaPods](https://guides.cocoapods.org/using/getting-started.html#getting-started).
- A mobile device running iOS 8.0 or later. Agora recommends you run this sample project on a physical mobile device, as some simulators may not support the full features of this project.

## Procedure 

### Download the sample project

Go to GitHub, and download or clone the [AgoraLive](https://github.com/AgoraIO-Usecase/AgoraLive) repository.

### Import FaceUnity bundle files

Download the [FaceUnity bundle files](https://download.agora.io/components/release/Faceunity.zip) from Agora, extract the files from the downloaded package, and then copy the `Faceunity` folder to `AgoraLive-iOS/Resource`.

### Import the FaceUnity certificate file

Contact [FaceUnity](http://faceunity.com/docs_develop_en/#/nama_api_docs/iOS/docs/iOS_Nama_Demo_Guide) for a certificate file named `authpack.java`, and then move this file to `AgoraLive/iOS/Resource/Faceunity`.

### Install dependencies

Go to `AgoraLive-iOS/AgoraLive`, and then run the following command to link dependencies.

```
pod install
```

If you get stuck in linking the dependencies, you can replace the source url in `AgoraLive-iOS/AgoraLive/Podfile` as follows, save the change, and then run `pod install` again.

```
// Before replacing
source 'https://github.com/CocoaPods/Specs.git'
// After replacing
source 'https://cdn.cocoapods.org/'
```

### Run the project

1. Open the `AgoraLive-iOS/AgoraLive/AgoraLive.xcworkspace` folder with Xcode. 
2. Connect your iOS device to your computer using a USB cable.
3. Click **Build and run** in Xcode. You should see the Agora Live app installed on your iOS device after a while.
4. Launch the app, and select whichever scenario you prefer to start live interactive streaming.
  ![](https://web-cdn.agora.io/docs-files/1604669399244)



## Common issues

If Xcode reports "`Error: Multiple commands produce`", you can troubleshoot as follows:

1. Click **File > Workspace Settings** in Xcode.
2. In the pop-up panel, click **Build System** in **Shared Workspace Settings**, and then replace **New Build System (Default)** with **Legacy Build System**.
3. Click **Build and run**. The app should run on your device.