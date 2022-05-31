This document introduces how to get the source code of Agora Flexible Classroom (iOS) from GitHub and run the project, so as to quickly launch a flexible classroom and experience the features.

## Understand the tech

~b89350c0-c9c3-11eb-9521-2d3265d0c546~

<a name="prerequisites"></a>

## Prerequisites

- Enable the Flexible Classroom [service](/en/agora-class/agora_class_enable?platform=Web) in Agora Console.
- Get the [Agora App ID](/en/Agora%20Platform/get_appid_token#Get-app-id) and [App Certificate](/en/Agora%20Platform/get_appid_token#Get-app-certificate) in Agora Console.
- A valid Apple developer account.
- A physical iOS device (iPhone or iPad). You may encounter unexpected issues on simulators, so Agora recommends using a physical device. In addition, the iOS client of Flexible Classroom must be run on iOS 10.0 or later.

## Set up the development environment

Running Flexible Classroom on your device depends on Xcode and CocoaPods.

To prepare your development environment, refer to the following steps:

1. Download and install Xcode in App Store. Xcode 12.5 or later.
2. To download CocoaPods, click the [link](https://guides.cocoapods.org/using/getting-started.html#getting-started). You must download CocoaPods 1.10 or later.

<div class="alert info">If you use Swift, use Swift 5.0 or later.</div>

## Get the source code

The source code of Flexible Classroom (iOS) is in the [CloudClass-iOS](https://github.com/AgoraIO-Community/CloudClass-iOS) and [apaas-extapp-ios](https://github.com/AgoraIO-Community/apaas-extapp-ios) repositories. To download the source code to your local device, refer to the following steps:

1. To clone the CloudClass-iOS repository to your local computer, run the following command:

   ```bash
   git clone https://github.com/AgoraIO-Community/CloudClass-iOS.git
   ```

2. To navigate into the CloudClass-iOS directory and switch to a specified version, run the following commands. Replace {VERSION} with the version number that you want:

   ```bash
   cd CloudClass-iOS
   ```

   ```bash
   git checkout release/apaas/{VERSION}
   ```

   For example, if you want to switch to the branch of v2.1.0, just run the following command:

   ```bash
   git checkout release/apaas/2.1.0
   ```

   Agora recommends switching the branch of the latest release.

3. To clone the apaas-extapp-ios repository to your local device, run the following command:

   ```bash
   git clone https://github.com/AgoraIO-Community/apaas-extapp-ios.git
   ```

   Place the apaas-extapp-ios project under the same directory with CloudClass-iOS, just as shown in the following image:

   ![](https://web-cdn.agora.io/docs-files/1648725190226)

4. To navigate into the apaas-extapp-ios directory and switch to a specified version, run the following commands. Replace {VERSION} with the version number that you want:

   ```bash
   cd apaas-extapp-ios
   ```

   ```bash
   git checkout release/apaas/{VERSION}
   ```

   For example, if you want to switch to the branch of v2.1.0, just run the following command:

   ```bash
   git checkout release/apaas/2.1.0
   ```

## Launch a flexible classroom

Follow these steps to launch a flexible classroom:

1. Navigate into the CloudClass-iOS/App directory:

   ```bash
   cd CloudClass-iOS/App
   ```

2. Install dependencies.

   ```bash
   pod install
   ```

   The following image shows the process of installing dependencies.

   <img src="https://web-cdn.agora.io/docs-files/1648725475723" style="zoom:50%;" />

3. After all the dependencies are installed successfully, open the CloudClass-iOS folder in the Finder window, and double-click `AgoraEducation.xcworkspace` to open the project in Xcode.

   <img src="https://web-cdn.agora.io/docs-files/1648725644218" style="zoom: 50%;" />

   <img src="https://web-cdn.agora.io/docs-files/1648725725804" style="zoom:50%;" />

4. In Signing & Capabilities under the project TARGETS, check Automatically manage signing, and configure your Apple developer account and Bundle Identifier.

   <img src="https://web-cdn.agora.io/docs-files/1648725848162" style="zoom: 33%;" />

5. After connecting an iOS device to your computer, to run the project, click the Run button in Xcode.

   <img src="https://web-cdn.agora.io/docs-files/1648725959472" style="zoom:50%;" />

6. You can see the following page: To join a classroom, pass in a room name and user name, select a room type, and click **Enter**.

   <img src="https://web-cdn.agora.io/docs-files/1648726024179" style="zoom:50%;" />

## Next steps

Satisfied with the features of Flexible Classroom and want to explore more? Next, you can integrate [Flexible Classroom into your own project](/en/agora-class/agora_class_integrate_ios?platform=iOS).
