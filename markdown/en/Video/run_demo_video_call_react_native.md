---
title: Run the Sample Project
platform: React Native
updatedAt: 2020-11-17 10:26:07
---
Agora provides an open-source video call sample project [Agora-RN-Quickstart](https://github.com/AgoraIO-Community/Agora-RN-Quickstart) on GitHub. This document introduces how to run this project and experience a video call implemented by the Agora React Native SDK.

## Prerequisites

### Development environment

If your target platform is iOS, your development environment must meet the following requirements:

- React Native 0.59.10 or later
- macOS 
- Node 10 or later
- Xcode 9.4 or later
- CocoaPods
- A physical or virtual mobile device running iOS 8.0 or later

If your target platform is Android, your development environment must meet the following requirements:

- React Native 0.59.10 or later
- macOS, Windows or Linux
- Node 10 or later
- Java Development Kit (JDK) 8 or later
- Android Studio (latest version recommended)
- A physical or virtual mobile device running Android 5.0 or later


<div class="alert info">For more information, see <a href="https://reactnative.dev/docs/environment-setup">Setting up the development environment</a >.</div>

### Other Prerequisites

A valid Agora [account](/en/Agora%20Platform/sign_in_and_sign_up?platform=All%20Platforms).

<div class="alert note">If your network has a firewall, follow the instructions in <a href="/en/Agora%20Platform/firewall?platform=All%20Platforms">Firewall Requirements</a > to access Agora's services.</a >.</div>


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




###  3. Generate a temporary token

To ensure communication security, Agora uses tokens (dynamic keys) to authenticate users joining a channel.

Agora Console supports generating temporary tokens for testing purposes.

1. On the [Project Management](https://console.agora.io/projects) page, find your project, and click ![img](https://web-cdn.agora.io/docs-files/1594284775010) to open the **Token** page.

   ![img](https://web-cdn.agora.io/docs-files/1574927794840)

2. Enter a channel name, and click **Generate Temp Token** to get a temporary token. When joining the channel, ensure that the channel name is the same with the one that you use to generate the temporary token.

   ![img](https://web-cdn.agora.io/docs-files/1574928048948)


<div class="alert note">Temporary tokens are for demonstration and testing purposes only and remain valid for 24 hours. In a production environment, you need to deploy your own server for generating tokens. See <a href="token_server">Generate a Token</a > for details.</div>



### 4. Run the project

1. Download the [Agora-RN-Quickstart](https://github.com/AgoraIO-Community/Agora-RN-Quickstart) repository. Open the `Agora-RN-Quickstart-master/App.tsx` file, and fill in your App ID, temporary token, and channel name.

 ```typescript
constructor(props) {
        super(props)
        this.state = {
            // Replace YourAppId with your App ID and add quotation marks, such as 'xxxxxx'.
            // Replace YourToken with your temporary token and add quotation marks, such as 'xxxxxxx'.
            // Replace channel-x with the channel name you used to generate the temporary token.
            appId: YourAppId,
            token: YourToken,
            channelName: 'channel-x',
            joinSucceed: false,
            peerIds: [],
        }
```

2. Run `npm install` or `yarn` in the project root directory to install the dependencies.

3. If your target platform is iOS, run `pod install` in the `Agora-RN-Quickstart-master/ios` directory.

4. Run the project.

 - To run the Android app:

    Launch your Android emulator, or connect to a physical Android device. Then run `npx react-native run-android` in the project root directory.

 - To run the iOS app:

    - Method one: 

      Launch your iOS emulator, and run `npx react-native run-ios` in the project root directory. （This method supports running the app on an iOS emulator only.）

    - Method two：

      Open `Agora-RN-Quickstart-master\ios\AgoraRNQuickstart.xcworkspace` with Xcode, launch your iOS emulator or connect to a physical iOS device, and then click the **Build and run** button in Xcode.

## Sample project structure

The following table lists the code structure of the sample project for your reference:

```
.
├── android
├── components
│ └── Permission.ts
│ └── Style.ts
├── ios
├── App.tsx
├── index.js
.
```



| File/Folder                           | Description                                                  |
| :------------------------------------ | :----------------------------------------------------------- |
| File/Folder                           | Description                                                  |
| `android`                             | Native Android project folder.                               |
| `components/Permission.ts` | The code for getting device permissions (for Android only).|
| `components/Style.ts` | The code for the user interface styles. |
| `ios`                                 | Native iOS project folder.                                   |
| `App.tsx`                             | The code of the App component and the main functions.        |
| `index.js`                            | The entry file of the React Native project.                  |

## Common issues

If you get `Error: listen EADDRINUSE: address already in use :::8081` when running the project, it means port 8081 is occupied. You can try to change the port number and run the project again.

To specify the port and run the Android app, use the following command:

```
npx react-native run-android --port xxxx
```

To specify the port and run the iOS app, do the following:

1. Search for `8081` globally in the project root directory and replace it with an unoccupied port number, such as 9999. Save the changes.
2. Open `Agora-RN-Quickstart-master\ios\AgoraRNQuickstart.xcworkspace` with Xcode,  launch an iOS emulator or connect a physical iOS device, and then click the **Build and run** button in Xcode.