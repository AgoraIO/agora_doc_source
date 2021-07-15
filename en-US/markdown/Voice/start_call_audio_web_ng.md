The Agora Voice SDK for Web makes it easy to embed real-time Voice Call into web apps.

This page shows you the minimum code you need to add Voice Call into your Web app by using the Agora Voice SDK for Web.

# Understand the tech

The following figure shows the workflow of Voice Call implemented by the Agora SDK.

![](https://web-cdn.agora.io/docs-files/1623991425414)

To make a voice call, your app client has the following steps to take:

**1. Get a token**
The app client requests a token from your app server. This token authenticates the user when the app client joins a channel.

**2. Join an Agora RTC channel**
The client joins an RTC (Real-time Communication) channel by calling the APIs provided by Agora. When that happens, Agora automatically creates an RTC channel. App clients that pass the same channel name join the same channel.

**3. Publish and subscribe to audio in the channel**

After joining an RTC channel, you can use the `LocalTrack` and `RemoteTrack` objects to publish and subscirbe to audio tracks in the channel.

For an app client to join an RTC channel, you need the following information:

- The App ID: A randomly generated string provided by Agora for identifying your app. You can get the App ID from [Agora Console](https://console.agora.io/).
- The user ID: The unique identifier of a user. You need to specify the user ID yourself, and ensure that it is unique in the channel.
- A token: A credential for authenticating the identity of the user when your app client joins an RTC channel.
- The channel name: A string that identifies the RTC channel for the voice call.

## Prerequisites

In order to follow the procedure in this page, you must have:

- A valid Agora account
- An [Agora project](https://docs.agora.io/en/Agora Platform/get_appid_token?platform=Web) with an App ID and a temp token
- A Windows or macOS computer meets the following requirements:
  - Access to the Internet. If your network has a firewall, follow the instructions in [Firewall Requirements](https://docs.agora.io/en/Agora Platform/firewall?platform=Web) to access Agora services.
  - A browser that matches the [supported browser list](https://docs.agora.io/en/Voice/faq/browser_support?platform=Web). Agora highly recommends using the [latest version](https://www.google.com/chrome/) of Google Chrome.
  - Physical audio input devices
  - An Intel 2.2GHz Core i3/i5/i7 processor (2nd generation) or equivalent
- [Node.js and npm](https://docs.npmjs.com/downloading-and-installing-node-js-and-npm)

## Create a Web project

Create a new directory named `agora_web_quickstart`. For a minimal Web app client, create the following files in the directory :

- `index.html`: The visual interface with the user.
- `basicVoiceCall.js`: The programmable interface with `AgoraRTCClient` to implement the client logic.
- `package.json`: Install and manage the dependencies of your project. To create the `package.json` file, you can navigate to the `agora_web_quickstart` directory on the command line and run `npm init`.

## Implement a client for Voice Call

The following section shows how to use the Agora Voice SDK for Web to add Voice Call into your Web app step by step.

### 1. Integrate the SDK

Integrate the Agora Voice SDK for Web into your project through npm, as follows:

1. In `package.json`, add `agora-rtc-sdk-ng` and its version number to the `dependencies` field:

   ```json
   {
     "name": "agora_web_quickstart",
     "version": "1.0.0",
     "description": "",
     "main": "basicVoiceCall.js",
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

2. To import the `AgoraRTC` module in your project, copy the following code into `basicVoiceCall.js`.

   ```javascript
   import AgoraRTC from "agora-rtc-sdk-ng"
   ```

### 2. Implement the user interface

To implement the user interface, copy the following code into `index.html`:

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Agora Voice Web SDK Quickstart</title>
    <!-- 
      This line is used to refer to the bundle.js file packaged by webpack. A sample webpack configuration is shown in the later step of running your app.
    -->
    <script src="./dist/bundle.js"></script>
</head>
<body>
    <h2 class="left-align">Agora Voice Web SDK Quickstart</h2>
        <div class="row">
            <div>
                <button type="button" id="join">JOIN</button>
                <button type="button" id="leave">LEAVE</button>
            </div>
        </div>
</body>
</html>
```

### 3. Implement the client logic

To implement the client logic of Voice Call, we need to do the following things:

1. Call [`createClient`](./API%20Reference/web_ng/interfaces/iagorartc.html#createclient) to create an `AgoraRTCClient` object.
2. Call [`join`](./API%20Reference/web_ng/interfaces/iagorartcclient.html#join) to join an RTC channel with the App ID, user ID, token, and channel name. 
3. Call [`createMicrophoneAudioTrack`](./API%20Reference/web_ng/interfaces/iagorartc.html#createmicrophoneaudiotrack) to create a local audio track from the audio sampled by a microphone, and then call `publish` to publish the local audio tracks in the channel.
4. When a remote user joins the channel and publishes tracks:
   1. Listen for the [`client.on("user-published")`](./API%20Reference/web_ng/interfaces/iagorartcclient.html#event_user_published) event. When the SDK triggers this event, get an `AgoraRTCRemoteUser` object from this event.
   2. Call [`subscribe`](./API%20Reference/web_ng/interfaces/iagorartcclient.html#subscribe) to subscribe to the `AgoraRTCRemoteUser` object and get the `RemoteAudioTrack` objects of the remote user.
   3. Call [`play`](./API%20Reference/web_ng/interfaces/itrack.html#play) to play the remote audio tracks.

The following figure shows the API call sequence of a basic one-to-one Voice Call. 

![](https://web-cdn.agora.io/docs-files/1617876672414)



Copy the following code into `script.js` and then replace `yourAppId` and `yourToken` with [values from your Agora project](https://docs.agora.io/en/Agora Platform/get_appid_token?platform=Web).

```javascript
import AgoraRTC from "agora-rtc-sdk-ng"

let rtc = {
    localAudioTrack: null,
    client: null
};

let options = {
    // Pass your App ID here.
    appId: "Your App ID",
    // Set the channel name.
    channel: "test",
    // Pass your temp token here.
    token: "Your temp token",
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
            // Publish the local audio tracks to the RTC channel.
            await rtc.client.publish([rtc.localAudioTrack]);
            // Dynamically create a container in the form of a DIV element for playing the local audio track.
            const localPlayerContainer = document.createElement("div");
            // Specify the ID of the DIV container. You can use the uid of the local user.
            localPlayerContainer.id = options.uid;
            localPlayerContainer.textContent = "Local user " + options.uid;
            localPlayerContainer.style.width = "640px";
            localPlayerContainer.style.height = "480px";
            document.body.append(localPlayerContainer);

            // Play the local audio track.
            // Pass the DIV container and the SDK dynamically creates a player in the container for playing the local audio track.
            rtc.localAudioTrack.play(localPlayerContainer);
            console.log("publish success!");
        }

        document.getElementById("leave").onclick = async function () {
            // Destroy the local audio tracks.
            rtc.localAudioTrack.close();

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



## Test your app

This quickstart uses [webpack](https://webpack.js.org/) to package the project and `webpack-dev-server` to run your project.

1. In `package.json`, add `webpack`, `webpack-cli`, and `webpack-dev-server` to the `dependencies` field, and the `build` and `start:dev` commands to the `scripts` field.

   ```json
   {
     "name": "agora_web_quickstart",
     "version": "1.0.0",
     "description": "",
     "main": "basicVoiceCall.js",
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
    entry: './basicVoiceCall.js',
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

3. To install dependencies, run the following command:

   ```shell
   npm install
   ```

4. To build and run the project using webpack, run the following command:

   ```shell
   # Use webpack to package the project
   npm run build
   ```

5. Use webpack-dev-server to run the project:

   ```shell
   npm run start:dev
   ```

A local web server automatically opens in your browser. You see the following page:

![image-20210715100118636](/Users/admin/Desktop/image-20210715100118636.png)

Click **JOIN** to start a voice call. 

<div class="alert info"><li>Running the web app through a local server (localhost) is for testing purposes only. In production, ensure that you use the HTTPS protocol when deploying your project.</li><li>Due to security limits on HTTP addresses except 127.0.0.1, the Web SDK only supports HTTPS or http://localhost (http://127.0.0.1). If you deploy your project over HTTP, you can only visit your project at http://localhost (http://127.0.0.1).</li></div>

## Next steps

Generating a token by hand is not helpful in a production context. [Authenticate Your Users with Tokens](https://docs.agora.io/en/Voice/token_server?platform=All%20Platforms) shows you how to start a voice call with a token that you retrieve from your server.

## See also

- Agora also provides an open-source [sample project](https://github.com/AgoraIO/API-Examples-Web) on GitHub for your reference.

- In addition to integrating the Agora Voice SDK for Web into your project through npm, you can also choose either of the following methods to integrate the Agora Web SDK into your project:

  - Through the CDN: Add the following code to the line before `<style>` in the `index.html` file of your project.

    ```html
    <script src="https://download.agora.io/sdk/release/AgoraRTC_N-4.5.0.js"></script>
    ```

  - Manually download the latest [Agora Web SDK 4.x](https://docs.agora.io/en/Voice/downloads?platform=Web), copy the `.js` file to the directory of your project files, and add the following code to the line before the `<style>` tag in your project.

    ```html
    <script src="./AgoraRTC_N-4.5.0.js"></script>
    ```

 <div class="alert info">If you use the above methods, the SDK fully exports an <code>AgoraRTC</code> object. You can visit the <code>AgoraRTC</code> object to operate the Web SDK.</div>

- This page only applies to the Agora Web SDK 4.x. If you use the Web SDK 3.x or earlier version, see the following quickstart guides:
  - [Start a Voice Call](https://docs.agora.io/en/Voice/start_call_audio_web?platform=Web)

