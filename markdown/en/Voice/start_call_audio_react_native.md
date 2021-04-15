---
title: Start a Voice Call
platform: React Native
updatedAt: 2021-02-07 01:53:18
---
Learn how to quickly start a basic voice call with the Agora React Native SDK.

## Sample project

Agora provides an open-source video call sample project that implements [Agora-RN-Quickstart](https://github.com/AgoraIO-Community/Agora-RN-Quickstart) on GitHub. You can download it and view the source code.

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
- macOS, Windows, or Linux
- Node 10 or later
- Java Development Kit (JDK) 8 or later
- Android Studio (latest version recommended)
- A physical or virtual mobile device running Android 5.0 or later


<div class="alert info">For more information, see <a href="https://reactnative.dev/docs/environment-setup">Setting up the development environment</a >.</div>

### Other prerequisites

A valid Agora [account](/en/Agora%20Platform/sign_in_and_sign_up?platform=All%20Platforms).

<div class="alert note">If your network has a firewall, follow the instructions in <a href="/en/Agora%20Platform/firewall?platform=All%20Platforms">Firewall Requirements</a > to access Agora's services</a >.</div>


## Create a React Native project

1. Make sure you have set up the development environment based on your operating system and target platform.

2. Run the following command and fill in your project name in `ProjectName` to create and initialize a new React Native project.
```shell
npx react-native init ProjectName
```
   
   A successful execution of this command generates a simple sample project in the directory that you run the command.

3. Launch your Android or iOS simulator and run your project by executing the following command:

   a. Run `npx react-native start` in the root of your project to start Metro.
   b. Open another terminal in the root of your project and run `npx react-native run-android` to start the Android app, or run `npx react-native run-ios` to start the iOS app.

If everything is set up correctly, you should see your new app running in your Android or iOS simulator shortly.

<div class="alert info">You can also run your project on a physical Android or iOS device. For detailed instructions, see <a href="https://reactnative.dev/docs/running-on-device">Running on device</a >.</div>

Now that you have your project running successfully, you can start trying to integrate the Agora React Native SDK and modify your project.

## Integrate the SDK

This section describes how to integrate the SDK on React Native 0.60.0 or later.

<div class="alert note">If you use React Native 0.59.x, see <a href="https://github.com/AgoraIO-Community/react-native-agora/blob/master/README.md#installing-react-native--059x">Installing (React Native == 0.59.x</a > to integrate the Agora SDK.</div>


1. Install the latest version of the Agora React Native SDK:

   **Method one**: Install the SDK using npm
	 
 ```shell
  npm i --save react-native-agora  
```

   **Method two**: Install the SDK using yarn
	 
 ```shell
  // Install yarn.
  npm install -g yarn
	
  // Download the Agora React Native SDK using yarn.
  yarn add react-native-agora
 ```

   <div class="alert note">Do not link native modules manually, as React Native 0.60.0 and later support automatically linking native modules. For details, see <a href="https://github.com/react-native-community/cli/blob/master/docs/autolinking.md">Autolinking</a >.</div>


2. If your target platform is iOS, you also need to run the following command to install the SDK:

 ```shell
npx pod-install
```
 
   <div class="alert note">Ensure that you have already installed CocoaPods before performing this step. See <a href="https://guides.cocoapods.org/using/getting-started.html#getting-started">Getting Started with CocoaPods</a >.</div>

3. The Agora React Native SDK uses Swift in native modules, and therefore your project must support compiling Swift. Otherwise, you will get errors when building the iOS app.
   a. Open `ios/ProjectName.xcworkspace` with Xcode.
   b. Click **File > New > File**, select **iOS > Swift File**, and then click **Next > Create** to create a new `File.swift` file.

## Add TypeScript

The sample code in this article is written in TypeScript. If you want to use this sample code directly, you need to add support for TypeScript to your project. 

1. Run one of the following commands in the root of your project to add TypeScript dependencies:

   **Method one**: Using npm
```shell
npm install --save-dev typescript @types/jest @types/react @types/react-native @types/react-test-renderer
```

   **Method two**: Using yarn
```shell
yarn add --dev typescript @types/jest @types/react @types/react-native @types/react-test-renderer
```

2. Create a `tsconfig.json` file in the root of your project, and copy the following code to the file:

 ```json
{
  "compilerOptions": {
    "allowJs": true,
    "allowSyntheticDefaultImports": true,
    "esModuleInterop": true,
    "isolatedModules": true,
    "jsx": "react",
    "lib": ["es6"],
    "moduleResolution": "node",
    "noEmit": true,
    "strict": true,
    "target": "esnext"
  },
  "exclude": [
    "node_modules",
    "babel.config.js",
    "metro.config.js",
    "jest.config.js"
  ]
}
```  

3. Create a `jest.config.js` file in the root of your project, and copy the following code to the file:

 ```javascript
module.exports = {
     preset: 'react-native',
     moduleFileExtensions: ['ts', 'tsx', 'js', 'jsx', 'json', 'node']
};
```

4. Rename `App.js` to `App.tsx`.

<div class="alert info">For more information, see <a href="https://reactnative.dev/docs/typescript">Using TypeScript</a >.</div>


## Implement the basic voice call

This section describes how to use the Agora React Native SDK to start a basic voice call.

### 1. Import the class

Import the `RtcEngine` class and view rendering components in your project.

```
import RtcEngine, {RtcLocalView, RtcRemoteView, VideoRenderMode} from 'react-native-agora'
```

### 2. Initialize RtcEngine

Create and initialize the `RtcEngine` object before calling any other Agora APIs.

You can also listen for callback events, such as when the local user joins the channel, when the remote user joins the channel, and when the remote user leaves the channel. 

```
async function init() {
    // Pass in the App ID to initialize the RtcEngine object.
    const engine = await RtcEngine.create(appId)
    // Listen for the JoinChannelSuccess callback.
    // This callback occurs when the local user successfully joins the channel.
    engine.addListener('JoinChannelSuccess', (channel, uid, elapsed) => {})
    // Listen for the UserJoined callback.
    // This callback occurs when the remote user successfully joins the channel.
    engine.addListener('UserJoined', (uid, elapsed) => {})
    // Listen for the UserOffline callback.
    // This callback occurs when the remote user leaves the channel or drops offline.
    engine.addListener('UserOffline', (uid, reason) => {})
}
```

### 3. Join a channel

After initializing the `RtcEngine` object, you can call `joinChannel` to join a channel. In this method, set the following parameters:

- `token`: Pass a token that identifies the role and privilege of the user. You can set it to one of the following values:

  - `null` or an empty string "".
  - A temporary token generated in Console. A temporary token is valid for 24 hours. For details, see [Get a Temporary Token](https://docs.agora.io/en/Agora%20Platform/token#get-a-temporary-token).
  - A token generated at the server. This applies to scenarios with high-security requirements. For details, see [Generate a token from Your Server](https://docs.agora.io/en/Interactive%20Broadcast/token_server_cpp).
  
 <div class="alert note">If your project has enabled the app certificate, ensure that you provide a token.</div>

- `channelName`: Specify the channel name that you want to join.

- `uid`: The ID of the local user that is an integer and should be unique. If you set `uid` as 0, the SDK assigns a user ID for the local user and returns it in the `JoinChannelSuccess` callback.

```
engine.joinChannel(token, channelName, null, 0)
```

### 4. Leave the channel

Call `leaveChannel` to leave the current channel according to your scenario. For example, when the call ends, when you need to close the app, or when your app runs in the background.

```
engine.leaveChannel()
```

## Run the project

Run the project on your Android or iOS device. You can hear the remote user when you successfully start a one-to-one voice call in the app.