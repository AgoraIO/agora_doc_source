This page introduces how to quickly launch a flexible classroom.

## Understand the tech

~b89350c0-c9c3-11eb-9521-2d3265d0c546~

<a name="prerequisites"></a>

## Prerequisites

- An Agora project with an<a href="/cn/Agora%20Platform/get_appid_token#%E8%8E%B7%E5%8F%96-app-id" target="_blank">Agora App ID</a>, <a href="/cn/Agora%20Platform/get_appid_token#%E8%8E%B7%E5%8F%96-app-%E8%AF%81%E4%B9%A6" target="_blank">App Certificate</a>, and <a href="/cn/agora-class/agora_class_enable?platform=iOS" target="_blank">enable the Flexible Classroom service</a>.
- Xcode 10.0 or later.
- CocoaPods 1.10 or later. To install CocoaPods, see [Getting Started with CocoaPods](https://guides.cocoapods.org/using/getting-started.html#getting-started).
- iOS 10 or later.
- If you use Swift, use Swift 5.0 or later.
- A valid Apple developer account.
- A physical iOS device (iPhone or iPad). You may encounter unexpected issues on simulators, so Agora recommends using a physical device.

## Launch a flexible classroom

Follow these steps to launch a flexible classroom:

1. Run the following command to clone the [CloudClass-iOS](https://github.com/AgoraIO-Community/CloudClass-iOS) project and check out the latest release branch.

   ```
   git clone https://github.com/AgoraIO-Community/CloudClass-iOS.git
   ```

   ```
   git checkout release/apaas/x.y.z
   ```

<div class="alert info">Replace x.y.z with the version number. To get the latest version number, see the <a href="/cn/agora-class/release_agora_class_ios?platform=iOS">release notes</a>.</div>

2. Run the following command to clone the [apaas-extapp-ios](https://github.com/AgoraIO-Community/apaas-extapp-ios) project and check out the latest release branch. Place the apaas-extapp-ios project under the same directory with CloudClass-iOS.

   ```
   git clone https://github.com/AgoraIO-Community/apaas-extapp-ios.git
   ```

   ```
   git checkout release/apaas/x.y.z
   ```

3. In CloudClass-iOS, run `pod install`.

4. Open the CloudClass-iOS project in Xcode. Build and run the project.

<div class="alert info">To facilitate your testing, the CloudClass-iOS project contains an RTM Token generator, which can generate a temporary RTM Token with a default App ID and App Certificate. If you want to use your own App ID and App Certificate, comment out the <code>requestToken</code> method in the <code>AgoraEducation/Main/Controllers/LoginViewController.swift</code> file and use the <code>buildToken</code> method instead. When your project goes live, to ensure security, you must deploy the RTM Token generator on your server.</div>

5. To join a classroom, pass in a room name and user name, select a room type, and click **Enter**.

## Next steps

Satisfied with the features of Flexible Classroom and want to explore more? Next, you can integrate [Flexible Classroom into your own project](/en/agora-class/agora_class_integrate_ios?platform=iOS).
