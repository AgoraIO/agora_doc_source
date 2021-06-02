---
title: Start Interactive Live Audio Streaming
platform: Web
updatedAt: 2021-01-27 07:22:58
---
<div class="alert info">Agora has released the Agora Web SDK NG, the next generation of the Agora Web SDK, which fully optimizes the internal architecture of the SDK and improves its usability. Based on TypeScript, the Agora Web SDK NG uses Promises for asynchronous operations and provides more flexible and easy-to-use APIs. The Agora Web SDK NG is in the beta stage. Click <a href="https://agoraio-community.github.io/AgoraWebSDK-NG/en/">here</a> to learn more and you can submit an <a href="https://github.com/AgoraIO-Community/AgoraWebSDK-NG">issue</a> if you have any problem.</div>

Use this guide to quickly set up the Agora Web SDK and enable interactive audio streaming  functions in your app. 

<div class="alert warning">Due to security limits on HTTP addresses except 127.0.0.1, Agora Web SDK only supports HTTPS or http://localhost (http://127.0.0.1). Do not deploy your project over HTTP.</div>

## Sample project

We provide an open-source [sample project](https://github.com/AgoraIO/Basic-Video-Broadcasting/tree/master/OpenLive-Web) that implements the basic interactive video streaming on GitHub. 

You can also use this [online demo](https://webdemo.agora.io/agora-web-showcase/examples/OpenLive-Web/#/) and try the video streaming implemented by the Agora SDK.

## Prerequisites

1. Install a browser supported by the Agora Web SDK, as shown in the following table:     <div class="alert info">Agora recommends using the latest Chrome browser.</div>

   | Platform             | Chrome 58 or later | Firefox 56 or later | Safari 11 or later | Opera 45 or later | QQ Browser 10.5 or later | 360 Secure Browser | Edge Browser 80 or later|
   | :------------------- | :----------------- | :------------------ | :----------------- | :---------------- | :--------- | :----------------- | :---------------------- |
   | Android 4.1 or later | ✔                  | ✘                   | N/A                | ✘                 | ✘          | ✘                  | ✘                       |
   | iOS 11 or later      | ✘                  | ✘                   | ✔                  | ✘                 | ✘          | ✘                  | ✘                       |
   | macOS 10 or later    | ✔                  | ✔                   | ✔                  | ✔                 | ✔          | ✘                  | ✘                       |
   | Windows 7 or later   | ✔                  | ✔                   | N/A                | ✔                 | ✔          | ✔                  | ✔                       |

2. Get a valid [Agora account](https://docs.agora.io/en/Agora%20Platform/sign_in_and_sign_up) and an [App ID](https://docs.agora.io/en/Agora%20Platform/token?platform=All%20Platforms#get-an-app-id).

<div class="alert note">Open the specified ports in <a href="https://docs.agora.io/cn/Agora%20Platform/firewall?platform=All%20Platforms">Firewall Requirements</a> if your network has a firewall.</div>

## Set up the development environment

To set up the development environment, you need to prepare a project and integrate the Agora Web SDK.

### Create a new project

If you already have a project, skip this section and go to **Integrate the SDK**.

<div class="alert note">Our sample code uses some third-party libraries to implement the style and layout. You can get the library files from the following links, or user other methods to implement your layout.<li><a href="https://github.com/AgoraIO/Basic-Video-Call/blob/master/One-to-One-Video/Agora-Web-Tutorial-1to1/assets/common.css">common.css</a></li>
	<li><a href="https://github.com/AgoraIO/Basic-Video-Call/blob/master/One-to-One-Video/Agora-Web-Tutorial-1to1/vendor/jquery.min.js">jquery.min.js</a></li>
	<li><a href="https://github.com/AgoraIO/Basic-Video-Call/blob/master/One-to-One-Video/Agora-Web-Tutorial-1to1/vendor/materialize.min.js">materialize.min.js</a></li>
	</div>

<details>
	<summary><font color="#3ab7f8">Expand this section to use our sample code.</font></summary>

You need to create an HTML file for this project.

1. Create an HTML file. Here, we name it as `index.html`.
2. Open the project file with a code editor (such as Visual Studio Code).
3. Copy the following code and add it to the `index.html` file in the code editor.

   This step creates the front-end user interface for this web app. You can also define your UI.

	```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <title>Basic Live Streaming</title>
  <link rel="stylesheet" href="./assets/common.css" />
</head>
<body class="agora-theme">
  <div class="navbar-fixed">
    <nav class="agora-navbar">
      <div class="nav-wrapper agora-primary-bg valign-wrapper">
        <h5 class="left-align">Basic Live Streaming</h5>
      </div>
    </nav>
  </div>
  <form id="form" class="row col l12 s12">
    <div class="row container col l12 s12">
      <div class="col" style="min-width: 433px; max-width: 443px">
        <div class="card" style="margin-top: 0px; margin-bottom: 0px;">
          <div class="row card-content" style="margin-bottom: 0px;">
              <div class="input-field">
                <label for="appID" class="active">App ID</label>
                <input type="text" placeholder="App ID" name="appID">
              </div>
              <div class="input-field">
                <label for="channel" class="active">Channel</label>
                <input type="text" placeholder="channel" name="channel">
              </div>
              <div class="input-field">
                <label for="token" class="active">Token</label>
                <input type="text" placeholder="token" name="token">
              </div>
             Host: <input id="role" type="checkbox" checked></input>
              <div class="row" style="margin: 0">
                <div class="col s12">
                <button class="btn btn-raised btn-primary waves-effect waves-light" id="join">JOIN</button>
                <button class="btn btn-raised btn-primary waves-effect waves-light" id="leave">LEAVE</button>
                <button class="btn btn-raised btn-primary waves-effect waves-light" id="publish">PUBLISH</button>
                <button class="btn btn-raised btn-primary waves-effect waves-light" id="unpublish">UNPUBLISH</button>
                </div>
              </div>
          </div>
        </div>
      </div>
      <div class="col s7">
        <div class="video-grid" id="video">
          <div class="video-view">
            <div id="local_stream" class="video-placeholder"></div>
            <div id="local_video_info" class="video-profile hide"></div>
            <div id="video_autoplay_local" class="autoplay-fallback hide"></div>
          </div>
        </div>
      </div>
    </div>
  </form>
<script src="vendor/jquery.min.js"></script>
<script src="vendor/materialize.min.js"></script>
</body>
</html>
```
</details>

### Integrate the SDK

Choose one of the following methods to obtain the Agora Web SDK:

#### Method 1: Through npm

This method requires npm, see [Install npm](https://www.npmjs.com/get-npm) for details.

1. Run the following command to install the SDK.
   ```
	 npm install agora-rtc-sdk
	 ```

2. Add the following code to the Javascript code in your project.

   ```javascript
   import AgoraRTC from 'agora-rtc-sdk'
   ```

#### Method 2: Through the CDN

Add the following code to the line after `<head>` in your project.

```javascript
<script src="https://cdn.agora.io/sdk/release/AgoraRTCSDK-3.1.2.js"></script>
```

#### Method 3: Through the Agora website

1. Download the latest [Agora Web SDK](https://docs.agora.io/en/Agora%20Platform/downloads).

2. Copy the `AgoraRTCSDK-3.1.2.js` file to the same directory as your project file.

3. Add the following code to the line above `</body>` in your project.

   ```javascript
   <script src="./AgoraRTCSDK-3.1.2.js"></script>
   ```

For simplicity, let's include the Agora Web SDK from a CDN source and copy `<script src="https://cdn.agora.io/sdk/release/AgoraRTCSDK-3.1.2.js"></script>` to the project file.

Now, the project is set up. Next, we'll add the JavaScript code to implement the basic interactive streaming functions.

## Implement the basic interactive streaming

This section introduces how to use the Agora Web SDK to start the interactive streaming.

You need to work with two types of objects when using the Agora Web SDK:

- Client object that represents the local client. The Client methods provide major functions for a voice/video call, such as joining a channel and publishing a stream.
- Stream objects that represent the local and remote streams. The Stream methods define the behaviors of a stream object, such as the playback control and video encoder configurations.  When you call a Stream method, you need to distinguish between the local and the remote streams. 

The following figure shows the API call sequence of the basic interactive streaming. Note that these methods apply to different objects. 

![](https://web-cdn.agora.io/docs-files/1592907363809)

> We only focus on the basic API methods and callbacks in this guide. For a full list of the methods and callbacks, see [Web API Reference](./API%20Reference/web/index.html).

For convenience, we define two variables for the following code snippets. This is not mandatory and you can have your implementation.

```javascript
// rtc object
var rtc = {
  client: null,
  joined: false,
  published: false,
  localStream: null,
  remoteStreams: [],
  params: {}
};
 
// Options for joining a channel
var option = {
  appID: "Your App ID",
  channel: "Channel name",
  uid: null,
  token: "Your token"
}
```

### Initialize a client

To join a channel, we need to first create and initialize a client:

```javascript
// Create a client
rtc.client = AgoraRTC.createClient({mode: "live", codec: "h264"});

// Initialize the client
rtc.client.init(option.appID, function () {
  console.log("init success");
  }, (err) => {
  console.error(err);
});
```

Pay attention to the settings of `mode` and `codec` when creating the client:

- `mode` determines the [channel profile](https://docs.agora.io/en/Agora%20Platform/terms?platform=All%20Platforms#channel-profile). We use the `rtc` mode for one-to-one or group calls and the `live` mode for live interactive streaming.
- `codec` sets the codec that the web browser uses for encoding and decoding. Set it as `h264` as long as Safari 12.1 or earlier is involved in the call. If you need to use the web app on mobile phones, see [Use Web SDK on Mobile Devices](https://docs.agora.io/en/faq/web_on_mobile) for details.

### Set the client role

A live streaming channel has two client roles: host and audience, and the default role is audience. After setting the channel profile to `"live"`, your app may use the following steps to set the client role:

1. Ask the user to choose a role. 
2. Call the `Client.setClientRole` method and pass in the client role set by the user.

```javascript
// The value of role can be "host" or "audience".
rtc.client.setClientRole(role); 
```

Note that in a live streaming channel, only the host can be heard and seen. You can also call `setClientRole` to change the user role after joining a channel.

### Join a channel

Call `Client.join` in the `onSuccess` callback of `Client.init`.

```javascript
// Join a channel
rtc.client.join(option.token ? option.token : null, option.channel, option.uid ? +option.uid : null, function (uid) {
    console.log("join channel: " + option.channel + " success, uid: " + uid);
    rtc.params.uid = uid;
  }, function(err) {
    console.error("client join failed", err)
})
```

Pay attention to the following settings when joining the channel.

- `token`: This is optional. Pass a token that identifies the role and privilege of the user if your project enables an app certificate. See [Use a token for authentication](https://docs.agora.io/en/Agora%20Platform/token#Token) for details.
  - For testing, we recommend using a Temp Token generated in Console. See [Get a Temp Token](https://docs.agora.io/en/Agora%20Platform/token#get-a-temporary-token).
  - For production, we recommend using a Token generated at your server. For how to generate a token, see [Token Security](https://docs.agora.io/en/Video/token_server_cpp).
- `channel`: Channel name. A string within 64 bytes.
- `uid`: The user ID should be unique in a channel. If you set the user ID as `null` or `0`, the Agora server assigns a user ID and returns it in the `onSuccess` callback.

For more details on the parameter settings, see [`Client.join`](./API%20Reference/web/interfaces/agorartc.client.html#join).

### Publish a local stream

If the client role is set as `"host"`, we need to create and publish the local stream.
1. Call `AgoraRTC.createStream` to create a stream in the `onSuccess` callback of `Client.join`.

   When creating the stream, set the `audio` and `video` parameters to control whether the stream contains audio/video.

   ```javascript
   // Create a local stream
   rtc.localStream = AgoraRTC.createStream({
     streamID: rtc.params.uid,
     audio: true,
     video: false,
     screen: false,
   })
   ```

2. Call `Stream.init` to initialize the stream after creating the stream.

   ```javascript
   // Initialize the local stream
   rtc.localStream.init(function () {
     console.log("init local stream success");
   }, function (err) {
     console.error("init local stream failed ", err);
   });
   ```

   When initializing the stream, the web browser asks for permissions to access the camera and the microphone. Ensure that you grant the permissions.

3. Call `Client.publish` in the `onSuccess` callback of `Stream.init` to publish the local stream.

   ```javascript
   // Publish the local stream
   rtc.client.publish(rtc.localStream, function (err) {
     console.log("publish failed");
     console.error(err);
   })
   ```

### Subscribe to a remote stream

To subscribe to a remote stream, we need to listen for the `"stream-added"` event and call `Client.subscribe` in the callback.

<div class="alert note">We recommend listening for these events immediately after creating the client. </div>

1. Subscribe to a remote stream when the stream is added.

   ```javascript
   rtc.client.on("stream-added", function (evt) {  
     var remoteStream = evt.stream;
     var id = remoteStream.getId();
     if (id !== rtc.params.uid) {
       rtc.client.subscribe(remoteStream, function (err) {
         console.log("stream subscribe failed", err);
       })
     }
     console.log('stream-added remote-uid: ', id);
   });
   ```

2. Play the remote stream after subscribing to it.

   ```javascript
   rtc.client.on("stream-subscribed", function (evt) {
     var remoteStream = evt.stream;
     var id = remoteStream.getId();
     // Add a view for the remote stream.
     addView(id);
     // Play the remote stream.
     remoteStream.play("remote_video_" + id);
     console.log('stream-subscribed remote-uid: ', id);
   })
   ```

<div class="alert note">Due to web browser <a href="https://developers.google.com/web/updates/2017/09/autoplay-policy-changes">autoplay policy changes</a>, the <code>Stream.play</code> method needs to be triggered by the user's gesture on Chrome 70 or later and on Safari. </div>

3. When the remote stream is removed (for example, when a remote user calls `Stream.unpublish`), stop the stream playback and remove its view.

   ```javascript
   rtc.client.on("stream-removed", function (evt) {
     var remoteStream = evt.stream;
     var id = remoteStream.getId();
     // Stop playing the remote stream.
     remoteStream.stop("remote_video_" + id);
     // Remove the view of the remote stream. 
     removeView(id);
     console.log('stream-removed remote-uid: ', id);
   })
   ```

You need to define the `addView` and `removeView` functions. Refer to the following code for an example.
<details>
	<summary><font color="#3ab7f8">Expand this section to view the sample code.</font></summary>

``` javascript
function addView (id, show) {
  if (!$("#" + id)[0]) {
    $("<div/>", {
      id: "remote_video_panel_" + id,
      class: "video-view",
    }).appendTo("#video");
    $("<div/>", {
      id: "remote_video_" + id,
      class: "video-placeholder",
    }).appendTo("#remote_video_panel_" + id);
    $("<div/>", {
      id: "remote_video_info_" + id,
      class: "video-profile " + (show ? "" :  "hide"),
    }).appendTo("#remote_video_panel_" + id);
    $("<div/>", {
      id: "video_autoplay_"+ id,
      class: "autoplay-fallback hide",
    }).appendTo("#remote_video_panel_" + id);
  }
}
function removeView (id) {
  if ($("#remote_video_panel_" + id)[0]) {
    $("#remote_video_panel_"+id).remove();
  }
}
```
</details>

### Leave the channel

Call `Client.leave` to leave the channel.

```javascript
// Leave the channel
rtc.client.leave(function () {
  // Stop playing the local stream
  rtc.localStream.stop();
  // Close the local stream
  rtc.localStream.close();
  // Stop playing the remote streams and remove the views
  while (rtc.remoteStreams.length > 0) {
    var stream = rtc.remoteStreams.shift();
    var id = stream.getId();
    stream.stop();
    removeView(id);
  }
  console.log("client leaves channel success");
}, function (err) {
  console.log("channel leave failed");
  console.error(err);
})
```

## Run your app

We recommend running your web app through a local web server. Here, we use the npm live-server package to set up a local web server. 
<div class="alert note">We run the web app through a local server (localhost) for testing. In production, ensure that you use the HTTPS protocol when deploying your project.</div>

1. Install live-server.
   ```bash
npm i live-server -g
	```

2. Change the directory to your project by the cd command. 
3. Run the app.
   ```bash
live-server .
	```
   This should automatically load the web app in your browser.

4. Enter a channel name, choose the user role, and click **JOIN** to start a call.
   You might need to allow the browser to access your  microphone. 

5. Open another tab in the browser and load the same URL. Click the **JOIN** button. If you set the client role as host, you should hear echoes when you speak

If the web app is not working properly, open the console in your browser and check for errors. The following are the most likely errors:
- `INVALID_VENDOR_KEY`: Wrong App ID. Check if you fill in the correct App ID.
- `ERR_DYNAMIC_USE_STATIC_KE`: Your Agora project enables App Certificate, so you need to use Token when joining the channel.
- `Media access:NotFoundError`: Check if your  microphone are working properly.
- `MEDIA_NOT_SUPPORT`: Please use HTTPS or localhost.

<div class="alert warning">Do not debug the web app on emulated mobile devices.</div>

## Reference

- [How can I listen for an audience joining or leaving a live streaming channel?](https://docs.agora.io/en/faq/audience_event)
- [How can I set the log file?](https://docs.agora.io/en/faq/logfile)
- [What are the common errors in Web browsers' console log?](https://docs.agora.io/en/faq/console_error_web)
- [Why do errors occur when calling the Stream.init method?](https://docs.agora.io/en/faq/streaminit_error)