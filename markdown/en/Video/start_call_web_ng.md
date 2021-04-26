---
title: Start a Video Call
platform: Web
updatedAt: 2021-02-05 04:36:36
---

# Get Started with the Agora Video SDK for Web

This article shows you the minimum code you need to add a video call into your Web app by using the Agora Video SDK for Web.

## Understand the tech

![](https://web-cdn.agora.io/docs-files/1619335084232)

To make a video call, your app client uses an [AgoraRTCClient](https://docs.agora.io/en/Video/API%20Reference/web_ng/interfaces/iagorartcclient.html) object to join an Agora RTC channel with the following parameters:
- The App ID: A randomly generated string provided by Agora for identifying your app. You can get the App ID in Agora Console.
- The user ID: The unique identifier of a user. An integer or a string specified by your app user.
- A token: A credential for verifying the identity of the user when your app user joins an RTC channel. In a test or production environment, your app client retrieves tokens from your app server in your security infrastructure. For rapid testing, you can get a temporary token with a validity period of 24 hours in Agora Console.
- The channel name: The string specified by your app user for identifying an RTC channel. Agora automatically creates an RTC channel with the channel name. To allow multiple clients to chat with one another, you can simply have them use the same channel name and join the same channel.

After your app clients join an RTC channel, you can use [LocalTrack](https://docs.agora.io/en/Video/API%20Reference/web_ng/interfaces/ilocalaudiotrack.html) and [RemoteTrack](https://docs.agora.io/en/Video/API%20Reference/web_ng/interfaces/iremotetrack.html) objects to publish and subscribe audio and video streams in the channel.

The next section shows the procedure of implementing a client for video call.

## Prerequisites

- A Windows or macOS computer with access to the Internet. If your network has a firewall, follow the instructions in [Firewall Requirements](https://docs.agora.io/en/Agora%20Platform/firewall?platform=Web) to access Agora services.
- Your computer is equipped with an Intel 2.2GHz Core i3/i5/i7 processor (2nd generation) or equivalent.
- Physical media input devices, such as a built-in camera and a built-in microphone.
- The latest stable version of [Chrome](https://www.google.com/chrome/).
- A valid Agora [account](https://docs.agora.io/en/Agora%20Platform/sign_in_and_sign_up?platform=Web).
  - [Create an Agora project in Agora Console]()
  - [Get an Agora App ID and a temporary token](https://docs.agora.io/en/Agora%20Platform/get_appid_token?platform=All%20Platforms) in Agora Console

## Implement a client for video call

### 1. Create a Web project

Create a new directory named `agora_web_quickstart`. For a minimal Web app, create the following files in the directory :

- `index.html`: The visual interface with the user.

- `basicVideoCall.js`: The programmable interface with AgoraRTCClient to implement the app logic.

You also need a `package.json` file for installing and managing the dependencies of your project. Create the `package.json` file, as follows:

On the command line, navigate to the `agora_web_quickstart` directory, and run `npm init` to create a `package.json` file.

### 2. Integrate the SDK

Integrate the Agora Video SDK for Web into your project through npm, as follows:

1. In the `package.json` file, add `agora-rtc-sdk-ng` and its version number to the `dependencies` field:

   ```json
   {
     "name": "agora_web_quickstart",
     "version": "1.0.0",
     "description": "",
     "main": "basicVideoCall.js",
     "scripts": {
       "test": "echo \"Error: no test specified\" && exit 1"
     },
     "dependencies": {
       "agora-rtc-sdk-ng": "latest",
     },
     "author": "",
     "license": "ISC"
   }
   ```

2. Add the following code at the beginning of the `basicVideoCall.js` file to import the `AgoraRTC` module in your project.

   ```javascript
   import AgoraRTC from "agora-rtc-sdk-ng"
   ```

### 3. Implement the user interface

Copy the following code to your `index.html` file to implement the user interface:

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Agora Video Web SDK Quickstart</title>
    <!-- 
      This line is used to refer to the bundle.js file packaged by webpack. A sample webpack configuration is shown in the later step of running your app.
    -->
    <script src="./dist/bundle.js"></script>
</head>
<body>
    <h2 class="left-align">Agora Video Web SDK Quickstart</h5>
        <div class="row">
            <div>
                <button type="button" id="join">JOIN</button>
                <button type="button" id="leave">LEAVE</button>
            </div>
        </div>
</body>
</html>
```

### 4. Implement the app logic

Copy the following code to your `basicVideoCall.js` file to implement the app logic:

> You need to replace the placeholders in the sample code with your own App ID and temporary token.

```js
import AgoraRTC from "agora-rtc-sdk-ng"

let rtc = {
    localAudioTrack: null,
    localVideoTrack: null,
    client: null
};

let options = {
    // Pass your App ID here.
    appId: "9cb1e3b9c53e412e98866fbe3919420b",
    // Set the channel name.
    channel: "test",
    // Pass your temp token here.
    token: "0069cb1e3b9c53e412e98866fbe3919420bIACR1mujdi0gTUeXOuSDO4UUfiUlM3Rp7aeJvLEl8+7XUQx+f9gAAAAAEAALtir+mteHYAEAAQCa14dg",
    // Set the user ID.
    uid: 123456
};

async function startBasicCall() {
    // Create an AgoraRTCClient object.
    rtc.client = AgoraRTC.createClient({ mode: "rtc", codec: "vp8" });
    
    // Listen for the "user-published" event, from which you can get an AgoraRTCRemoteUser object.
    rtc.client.on("user-published", async (user, mediaType) => {
        // Subscribe to the remote user when the SDK triggers the "user-published" event
        await rtc.client.subscribe(user, mediaType);
        console.log("subscribe success");

        // If the remote user publishes a video track.
        if (mediaType === "video") {
            // Get the RemoteVideoTrack object in the AgoraRTCRemoteUser object.
            const remoteVideoTrack = user.videoTrack;
            // Dynamically create a container in the form of a DIV element for playing the remote video track.
            const remotePlayerContainer = document.createElement("div");
            // Specify the ID of the DIV container. You can use the uid of the remote user.
            remotePlayerContainer.id = user.uid.toString();
            remotePlayerContainer.textContent = "Remote user " + user.uid.toString();
            remotePlayerContainer.style.width = "640px";
            remotePlayerContainer.style.height = "480px";
            document.body.append(remotePlayerContainer);

            // Play the remote video track.
            // Pass the DIV container and the SDK dynamically creates a player in the container for playing the remote video track.
            remoteVideoTrack.play(remotePlayerContainer);

            // Or just pass the ID of the DIV container.
            // remoteVideoTrack.play(playerContainer.id);
        }

        // If the remote user publishes an audio track.
        if (mediaType === "audio") {
            // Get the RemoteAudioTrack object in the AgoraRTCRemoteUser object.
            const remoteAudioTrack = user.audioTrack;
            // Play the remote audio track. No need to pass any DOM element.
            remoteAudioTrack.play();
        }

        // Listen for the "user-unpublished" event
        rtc.client.on("user-unpublished", user => {
            // Get the dynamically created DIV container.
            const remotePlayerContainer = document.getElementById(user.uid);
            // Destroy the container.
            remotePlayerContainer.remove();
        });

    });

    window.onload = function () {

        document.getElementById("join").onclick = async function () {
            // Join an RTC channel.
            await rtc.client.join(options.appId, options.channel, options.token, options.uid);
            // Create a local audio track from the audio sampled by a microphone.
            rtc.localAudioTrack = await AgoraRTC.createMicrophoneAudioTrack();
            // Create a local video track from the video captured by a camera.
            rtc.localVideoTrack = await AgoraRTC.createCameraVideoTrack();
            // Publish the local audio and video tracks to the RTC channel.
            await rtc.client.publish([rtc.localAudioTrack, rtc.localVideoTrack]);
            // Dynamically create a container in the form of a DIV element for playing the local video track.
            const localPlayerContainer = document.createElement("div");
            // Specify the ID of the DIV container. You can use the uid of the local user.
            localPlayerContainer.id = options.uid;
            localPlayerContainer.textContent = "Local user " + options.uid;
            localPlayerContainer.style.width = "640px";
            localPlayerContainer.style.height = "480px";
            document.body.append(localPlayerContainer);

            // Play the local video track.
            // Pass the DIV container and the SDK dynamically creates a player in the container for playing the local video track.
            rtc.localVideoTrack.play(localPlayerContainer);
            console.log("publish success!");
        }

        document.getElementById("leave").onclick = async function () {
            // Destroy the local audio and video tracks.
            rtc.localAudioTrack.close();
            rtc.localVideoTrack.close();

            // Traverse all remote users.
            rtc.client.remoteUsers.forEach(user => {
                // Destroy the dynamically created DIV containers.
                const playerContainer = document.getElementById(user.uid);
                playerContainer && playerContainer.remove();
            });

            // Leave the channel.
            await rtc.client.leave();
        }
    }
}

startBasicCall()
```

In the above code, we do the following things:

1. Call [`createClient`](https://docs.agora.io/en/Video/API%20Reference/web_ng/interfaces/iagorartc.html#createclient) to create an `AgoraRTCClient` object.
2. Call [`join`](https://docs.agora.io/en/Video/API%20Reference/web_ng/interfaces/iagorartcclient.html#join) to join an RTC channel with the App ID, user ID, token, and channel name.
3. Call [`createMicrophoneAudioTrack`](https://docs.agora.io/en/Video/API%20Reference/web_ng/interfaces/iagorartc.html#createmicrophoneaudiotrack) to create a local audio track from the audio sampled by a microphone, call [`createCameraVideoTrack`](https://docs.agora.io/en/Video/API%20Reference/web_ng/interfaces/iagorartc.html#createcameravideotrack) to create a local video track from the video captured by a camera, and then call `publish` to publish the local audio and video tracks to the channel.
4. When a remote user joins the channel and publishes tracks:
   1. Listen for the [`client.on("user-published")`](https://docs.agora.io/en/Video/API%20Reference/web_ng/interfaces/iagorartcclient.html#event_user_published) event. And when the SDK triggers this event, get an `AgoraRTCRemoteUser` object from this event.
   2. Call [`subscribe`](https://docs.agora.io/en/Video/API%20Reference/web_ng/interfaces/iagorartcclient.html#subscribe) to subscribe to the `AgoraRTCRemoteUser` object and get the `RemoteAudioTrack` and `RemoteVideoTrack` objects of the remote user.
   3. Call [`play`](https://docs.agora.io/en/Video/API%20Reference/web_ng/interfaces/itrack.html#play) to play the remote tracks.

## Test your app

This quickstart uses [webpack](https://webpack.js.org/) to package the project and `webpack-dev-server` to run your project.

> - Running the web app through a local server (localhost) is for testing purposes only. In production, ensure that you use the HTTPS protocol when deploying your project.
> - Due to security limits on HTTP addresses except 127.0.0.1, the Web SDK only supports HTTPS or http://localhost (http://127.0.0.1). If you deploy your project over HTTP, you can only visit your project at http://localhost（http://127.0.0.1).

1. In the `package.json` file, add `webpack`, `webpack-cli`, and `webpack-dev-server` to the `dependencies` field, and the `build` and `start:dev` commands to the `scripts` field.

   ```json
   {
     "name": "agora_web_quickstart",
     "version": "1.0.0",
     "description": "",
     "main": "basicVideoCall.js",
     "scripts": {
       "test": "echo \"Error: no test specified\" && exit 1",
       "build": "webpack --config webpack.config.js",
       "start:dev": "webpack serve --open --config webpack.config.js"
     },
     "dependencies": {
       "agora-rtc-sdk-ng": "latest",
       "webpack": "5.28.0",
       "webpack-dev-server": "3.11.2",
       "webpack-cli": "4.5.0"
     },
     "author": "",
     "license": "ISC"
   }
   ```

2. Create a file named `webpack.config.js` in the project directory to configure webpack, with the following code: 

   ```javascript
   const path = require('path');
   
    module.exports = {
    entry: './basicVideoCall.js',
    output: {
    filename: 'bundle.js',
    path: path.resolve(__dirname, './dist'),
    },
    devServer: {
    compress: true,
    port: 9000
    }
    };
   ```

3. Run the following command in the project directory to install dependencies:

   ```shell
   $ npm install
   ```

4. Run the following command to build and run the project using webpack:

   ```shell
   # Use webpack to package the project
   $ npm run build
   ```

5. Use webpack-dev-server to run the project:

   ```shell
   $ npm run start:dev
   ```

 If the project runs successfully, you can see the following page:

![](https://web-cdn.agora.io/docs-files/1619428543085)

Click **JOIN** to start a video call. However, being in a call on your own is no fun. Ask a friend to join the same video call with you on the [demo app](https://webdemo.agora.io/agora-websdk-api-example-4.x/basicVideoCall/index.html).

## Next steps

Generating a token by hand is not helpful in a production context. [Authenticate your user with AccessTokens]() shows you how to start a video call with a token that you retrieve from your server.

## See also

### Sample projects on GitHub

Agora also provides an open-source [sample project](https://github.com/AgoraIO/API-Examples-Web) on GitHub for your reference.

### The other methods to integrate the SDK

In addition to integrating the Agora Video SDK for Web into your project through npm, Agora also supports the following two methods to integrate the SDK:

#### Through the CDN

Add the following code to the line before `<style>` in the `index.html` file of your project.

```html
<script src="https://download.agora.io/sdk/release/AgoraRTC_N-4.4.0.js"></script>
```

#### Through the Agora website

1. Download the latest [Agora Web SDK 4.x](https://docs.agora.io/en/Interactive Broadcast/downloads?platform=Web).

2. Copy the `AgoraRTCSDK_N.js` file to the directory where your project files reside.

3. Add the following code to the line before the `<style>` tag in your project.

   ```html
   <script src="./AgoraRTC_N-4.4.0.js"></script>
   ```

> If you use the above methods, the SDK fully exports an `AgoraRTC` object. You can visit the `AgoraRTC` object to operate the Web SDK.


### API call sequence

The following figure shows the API call sequence of a basic one-to-one video call.

![](https://web-cdn.agora.io/docs-files/1617877252660)