---
title: Run the Sample Project
platform: Android
updatedAt: 2020-11-16 04:34:59
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

- Android Studio 3.0 or later. 
- A mobile device running Android 4.1 or later. Agora recommends you run this sample project on a physical mobile device, as some simulators may not support the full features of this project.

## Procedure 

### Download the sample project

Go to GitHub, and download or clone the [AgoraLive](https://github.com/AgoraIO-Usecase/AgoraLive) repository.

### Integrate the FaceUnity SDK

Follow the steps to integrate the FaceUnity SDK into the sample project:

1. Download [FaceUnity SDK v6.4](https://github.com/Faceunity/FULiveDemoDroid/releases/download/v6.4/Faceunity-Android-v6.4.zip) from the GitHub release. If you cannot download the SDK due to network connectivity issues, try downloading it from Agora [here](https://download.agora.io/components/release/Faceunity-Android-v6.4.zip).
2. Extract the files from the downloaded SDK package, and copy the following files to the folders of your project:

 | Files in the FaceUnity SDK package | File path of your project                      |
| :--------------------------------- | :--------------------------------------------- |
| `/FaceUnity/Android/assets`        | `AgoraLive-Android/faceunity/src/main/assets`  |
| `/FaceUnity/Android/jniLibs`       | `AgoraLive-Android/faceunity/src/main/jniLibs` |
| `/FaceUnity/Android/libs/nama.jar` | `AgoraLive-Android/faceunity/libs`             |

### Replace FaceUnity certificate file

Contact [FaceUnity](http://faceunity.com/docs_develop_en/#/nama_api_docs/Android/docs/Android_Nama_Demo_Guide) for a certificate file named `authpack.java`, and then replace `faceunity/src/main/java/com/faceunity/authpack.java` with your `authpack.java`.

### Get avatar resources

To experience or implement a virtual host scenario, download the avatar resources from Agora [here](https://download.agora.io/demo/release/AgoraLiveVirtualImage.zip).

Extract the files from the downloaded package, and copy the following files to `Agora-Live/faceunity/app/src/main/assets`:

- `bg.bundle`
- `girl.bundle`
- `hashiqi.bundle`

### Run the project

1. Enable the **Developer options** on your Android device, and then connect it to your computer using a USB cable.
2. Open the `AndroidLive-Android` folder with Android Studio.
3. Click **Sync Project with Gradle Files** in Android Studio.
4. Click **Run app** in Android Studio. You should see the Agora Live app installed on your device after a while.
5. Launch the app, and select whichever scenario you prefer to start live interactive streaming.
  ![](https://web-cdn.agora.io/docs-files/1604668854631)