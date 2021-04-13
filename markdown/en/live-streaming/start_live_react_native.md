---
title: Start Interactive Live Video Streaming
platform: React Native
updatedAt: 2021-02-07 02:00:41
---
This article describes how to build a React Native project that implements basic live interactive video streaming using the Agora React Native SDK.

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

2. Run the following command to create and initialize a new React Native project.
```shell
npx react-native init ProjectName
```
   
   A successful execution of this command generates a simple sample project.

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


## Implementation

### 1. Create the UI

Create the user interface (UI) for live interactive video streaming in the layout file of your project. 

For live interactive video streaming, we recommend adding the following elements into the UI:

- The start-call button
- The end-call button
- The local video view
- The remote video view

The `components/Style.ts` file in the [Agora-RN-Quickstart](https://github.com/AgoraIO-Community/Agora-RN-Quickstart) sample project defines the styles of the UI elements. You can create a `components` folder for your project, add a `Style.ts` file under that folder, and then copy the following code to the file:

```typescript
import {Dimensions, StyleSheet} from 'react-native'
  
const dimensions = {
    width: Dimensions.get('window').width,
    height: Dimensions.get('window').height,
}
 
export default StyleSheet.create({
    max: {
        flex: 1,
    },
    buttonHolder: {
        height: 100,
        alignItems: 'center',
        flex: 1,
        flexDirection: 'row',
        justifyContent: 'space-evenly',
    },
    button: {
        paddingHorizontal: 20,
        paddingVertical: 10,
        backgroundColor: '#0093E9',
        borderRadius: 25,
    },
    buttonText: {
        color: '#fff',
    },
    fullView: {
        width: dimensions.width,
        height: dimensions.height - 100,
    },
    remoteContainer: {
        width: '100%',
        height: 150,
        position: 'absolute',
        top: 5
    },
    remote: {
        width: 150,
        height: 150,
        marginHorizontal: 2.5
    },
    noUserText: {
        paddingHorizontal: 10,
        paddingVertical: 5,
        color: '#0093E9',
    },
})
```

### 2. Import classes

Open the `App.tsx` file, and delete all code. Add the following code to the beginning of the `App.tsx` file:

```typescript
import React, {Component} from 'react'
import {Platform, ScrollView, Text, TouchableOpacity, View} from 'react-native'
// Import the RtcEngine class and view rendering components into your project.
import RtcEngine, {RtcLocalView, RtcRemoteView, VideoRenderMode, ChannelProfile,ClientRole,} from 'react-native-agora'
// Import the UI styles.
import styles from './components/Style'
```

### 3. Add project permissions (Android only)

<div class="alert note">The sample code in this section applies to Android platform only, and will not be executed on iOS platform.</div>

Add the following code to the `App.tsx` file to set a prompt box for getting permissions to use the microphone and camera on an Android device:

```typescript
const requestCameraAndAudioPermission = async () =>{
    try {
        const granted = await PermissionsAndroid.requestMultiple([
            PermissionsAndroid.PERMISSIONS.CAMERA,
            PermissionsAndroid.PERMISSIONS.RECORD_AUDIO,
        ])
        if (
            granted['android.permission.RECORD_AUDIO'] === PermissionsAndroid.RESULTS.GRANTED
            && granted['android.permission.CAMERA'] === PermissionsAndroid.RESULTS.GRANTED
        ) {
            console.log('You can use the cameras & mic')
        } else {
            console.log('Permission denied')
        }
    } catch (err) {
        console.warn(err)
    }
}
```

### 4. Create an App component

When creating an App component, you need to define your App ID, token, and channel name, which will be used for initializing the `RtcEngine` object and joining the channel. Ensure the App ID and channel name are the same as the App ID and channel name used for generating the token.

- `appId`：The App ID of your Agora project. See [Get an App ID](https://confluence.agoralab.co/display/TEKP/Run+the+Sample+Project#RuntheSampleProject-2.GetanAppID) for details.

- `channelName`：The unique channel name for the AgoraRTC session. Users with the same App ID and channel name can join the same channel.

- `token`：Pass a token that identifies the role and privilege of the user. The token must be generated using the preceding App ID and channel name.  You can set it to one of the following values:

  - A temporary token generated in Console. A temporary token is valid for 24 hours. For details, see [Get a Temporary Token](en/Agora%20Platform/token#get-a-temporary-token).

  - A token generated at the server. This applies to scenarios with high-security requirements. For details, see [Generate a token from Your Server](token_server).

 <div class="alert note">If your project has enabled the app certificate, ensure that you provide a token.</div>


```typescript
// Define a Props interface.
interface Props {
}
 
// Define a State interface.
interface State {
    appId: string,
    channelName: string,
    token: string,
    joinSucceed: boolean,
    peerIds: number[],
}
 
// Create an App component, which extends the properties of the Pros and State interfaces.
export default class App extends Component<Props, State> {
    _engine?: RtcEngine
    // Add a constructor，and initialize this.state. You need:
    // Replace yourAppId with the App ID of your Agora project.
    // Replace yourChannel with the channel name that you want to join.
    // Replace yourToken with the token that you generated using the App ID and channel name above.
    constructor(props) {
        super(props)
        this.state = {
            appId: 'yourAppId',
            channelName: 'yourChannel',
            token: 'yourToken',
            joinSucceed: false,
            peerIds: [],
        }
        if (Platform.OS === 'android') {
            requestCameraAndAudioPermission().then(() => {
                console.log('requested!')
            })
        }
    }
    // Other code. See step 5 to step 10.
    ...
}
```

### 5. Initialize RtcEngine

Create and initialize the `RtcEngine` object before calling any other Agora APIs.

You can also listen for callback events, such as when the local user joins the channel, when a remote user joins the channel, and when a remote user leaves the channel.

You need to call `setChannelProfile` to set the channel profile as live streaming.

A live-streaming channel has two user roles: `Broadcaster` and `Audience`, and the default role is`Audience`. The sample code in this section sets the role of all users as `Broadcaster`, but your app may use the following steps to set the client role:

1. Allow the user to set the role as `Broadcaster` or `Audience`.
2. Call `setClientRole` and pass in the client role set by the user.

Note that in the live interactive streaming, only the host can be heard and seen. If you want to switch the user role after joining the channel, call the `setClientRole` method.


Add the following code after `// Other code` in `App.tsx`：

```typescript
// Mount the App component into the DOM.
componentDidMount() {
    this.init()
}
// Pass in your App ID through this.state, create and initialize an RtcEngine object.
init = async () => {
    const {appId} = this.state
    this._engine = await RtcEngine.create(appId)
    // Enable the video module.
    await this._engine.enableVideo()
    // Enable the local video preview.
    await this._engine.startPreview()
    // Set the channel profile as live streaming.
    await this._engine.setChannelProfile(ChannelProfile.LiveBroadcasting)
    // Set the usr role as host.
    await this._engine.setClientRole(ClientRole.Broadcaster)
 
    // Listen for the UserJoined callback.
    // This callback occurs when the remote user successfully joins the channel.
    this._engine.addListener('UserJoined', (uid, elapsed) => {
        console.log('UserJoined', uid, elapsed)
        const {peerIds} = this.state
        if (peerIds.indexOf(uid) === -1) {
            this.setState({
                peerIds: [...peerIds, uid]
            })
        }
    })
  
    // Listen for the UserOffline callback.
    // This callback occurs when the remote user leaves the channel or drops offline.
    this._engine.addListener('UserOffline', (uid, reason) => {
        console.log('UserOffline', uid, reason)
        const {peerIds} = this.state
        this.setState({
            // Remove peer ID from state array
            peerIds: peerIds.filter(id => id !== uid)
        })
    })
     
    // Listen for the JoinChannelSuccess callback.
    // This callback occurs when the local user successfully joins the channel.
    this._engine.addListener('JoinChannelSuccess', (channel, uid, elapsed) => {
        console.log('JoinChannelSuccess', channel, uid, elapsed)
        this.setState({
            joinSucceed: true
        })
    })
}
```

### 6.  Join a channel

After initializing the `RtcEngine` object, you can call `joinChannel` to join a channel. 

```typescript
// Pass in your token and channel name through this.state.token and this.state.channelName.
// Set the ID of the local user, which is an integer and should be unique. If you set uid as 0,

// the SDK assigns a user ID for the local user and returns it in the JoinChannelSuccess callback.

startCall = async () => {
        await this._engine?.joinChannel(this.state.token, this.state.channelName, null, 0)
    }
```

### 7. Render UI elements

Call the `render()` method in the App component to render the UI elements and handle the button click event.

```typescript
render() {
        return (
            <View style={styles.max}>
                <View style={styles.max}>
                    <View style={styles.buttonHolder}>
                        <TouchableOpacity
                            onPress={this.startCall}
                            style={styles.button}>
                            <Text style={styles.buttonText}> Start Call </Text>
                        </TouchableOpacity>
                        <TouchableOpacity
                            onPress={this.endCall}
                            style={styles.button}>
                            <Text style={styles.buttonText}> End Call </Text>
                        </TouchableOpacity>
                    </View>
                    {this._renderVideos()}
                </View>
            </View>
        )
    }
```

### 8. Render the local video view

Configure the video view of the local user. After joining the channel, the user can see themselves. You can also call `startPreview` to start the local video preview before joining the channel.

```typescript
_renderVideos = () => {
        const {joinSucceed} = this.state
        return joinSucceed ? (
            <View style={styles.fullView}>
                // Set the rendering mode of the video view as Hidden, which uniformly scales the video until it fills the visible boundaries.
                <RtcLocalView.SurfaceView
                    style={styles.max}
                    channelId={this.state.channelName}
                    renderMode={VideoRenderMode.Hidden}/>
                {this._renderRemoteVideos()}
            </View>
        ) : null
    }
```

### 9. Render the remote video view

During live interactive video streaming, you should be able to see other users. After joining the channel, pass in the `uid` of the remote user sending the video, and set the video view of the remote user.

```typescript
_renderRemoteVideos = () => {
        const {peerIds} = this.state
        return (
            <ScrollView
                style={styles.remoteContainer}
                contentContainerStyle={{paddingHorizontal: 2.5}}
                horizontal={true}>
                {peerIds.map((value, index, array) => {
                    return (
                        // Set the rendering mode of the video view as Hidden, which uniformly scales the video until it fills the visible boundaries.
                        <RtcRemoteView.SurfaceView
                            style={styles.remote}
                            uid={value}
                            channelId={this.state.channelName}
                            renderMode={VideoRenderMode.Hidden}
                            zOrderMediaOverlay={true}/>
                    )
                })}
            </ScrollView>
        )
    }
```

### 10. Leave the channel

Call `leaveChannel` to leave the current channel according to your scenario. For example, when live interactive streaming ends, when you need to close the app, or when your app runs in the background.

```typescript
endCall = async () => {
        await this._engine?.leaveChannel()
        this.setState({peerIds: [], joinSucceed: false})
    }
```

## Run the project

Agora recommends you run this project on a physical mobile device, as some simulators may not support the full features of this project.

**To run the Android app on a physical device:**

1. Enable the **Developer options** on your Android device, and then connect it to your computer using a USB cable.
2. Run `npx react-native run-android` in the project root directory. 

**To run the iOS app on a physical device:**

1. Open the `ProjectName/ios/ProjectName.xcworkspace` folder with Xcode.
2. Connect your iOS device to your Mac using a USB cable.
3. Click the **Build and run** button in Xcode.

You should see the app installed on your device after a while. When you set the role as host and successfully start live interactive streaming, you can see the video view of yourself in the app. When you set the role as audience and successfully join live interactive streaming, you can see the video view of the host in the app.