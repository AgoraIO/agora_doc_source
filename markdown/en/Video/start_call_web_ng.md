---
title: Start a Video Call
platform: Web
updatedAt: 2021-02-05 04:36:36
---
<div class="alert note">This page only applies to the Agora Web SDK 4.x. If you want to see the quickstart guides of 3.x and earlier versions, click the following links: <li><a href="https://docs.agora.io/en/Video/run_demo_video_call_web?platform=Web">Run the Sample Project</a></li><li><a href="https://docs.agora.io/en/Video/start_call_web?platform=Web">Start a Video Call</a></li></div>

This page introduces how to use the Agora Web SDK to implement a basic video call.

> Due to security limits on HTTP addresses except 127.0.0.1, the Web SDK only supports HTTPS or http://localhost (http://127.0.0.1). If you deploy your project over HTTP, you can only visit your project at http://localhost（http://127.0.0.1).

## Sample project

We provide an open-source [sample project](https://github.com/AgoraIO-Community/AgoraWebSDK-NG/tree/master/Demo) on GitHub for your reference.

You can also use this online [demo app](https://agoraio-community.github.io/AgoraWebSDK-NG/demo/) and try the audio and video functions implemented by the Agora SDK.

## Prerequisites

- A Windows or macOS computer with access to the Internet. If your network has a firewall, follow the instructions in [Firewall Requirements](https://docs.agora.io/en/Agora%20Platform/firewall?platform=Web) to access Agora services. 
- Your computer is equipped with an Intel 2.2GHz Core i3/i5/i7 processor (2nd generation) or equivalent.
- Physical media input devices, such as a built-in camera and a built-in microphone.
- The latest stable version of [Chrome](https://www.google.com/chrome/).
- A valid Agora [account](https://docs.agora.io/en/Agora%20Platform/sign_in_and_sign_up?platform=Web).

## Commonly-used objects
When using the Web SDK, you need to work with the following two types of objects:

- The [AgoraRTCClient](./API%20Reference/web/v4.2.0/interfaces/iagorartcclient.html) object, which represents a local user in the call. The `AgoraRTCClient` interface provides methods for implementing the major functions required for a video call, such as joining a channel and publishing local audio and video tracks.
- The [LocalTrack](./API%20Reference/web/v4.2.0/interfaces/ilocalaudiotrack.html) and [RemoteTrack](./API%20Reference/web/v4.2.0/interfaces/iremotetrack.html) objects, which represents the local and remote tracks. The `LocalTrack` and `RemoteTrack` interfaces provide methods for controlling audio and video, such as playback control.

> A media stream consists of an audio track and/or a video track. The Web SDK controls the stream by operating the tracks.

## Basic process

The process of implementing a basic video call is as follows:
1. Call `createClient` to create an `AgoraRTCClient` object with your App ID.
2. Call `AgoraRTCClient.join` to join a specified channel.
3. Call `createMicrophoneAudioTrack` to create a `MicrophoneAudioTrack` object and call `createCameraVideoTrack` to create a `CameraVideoTrack` object.
4. Call `AgoraRTCClient.publish` to publish the local audio and video tracks that you have created to the channel.

Perform the following steps when a remote user joins the channel and publishes tracks:
1. Get an `AgoraRTCRemoteUser` object when the SDK triggers the `AgoraRTCClient.on("user-published")` event.
2. Call `AgoraRTCClient.subscribe` to subscribe to the `AgoraRTCRemoteUser` object that you get in the previous step.
3. Visit `AgoraRTCRemoteUser.audioTrack` and `AgoraRTCRemoteUser.videoTrack` to get the `RemoteAudioTrack` and `RemoteVideoTrack` objects of the remote user.

For convenience, we define two variables and a function for the following code snippets. You can wrap all the following code snippets in the function. This is not mandatory and you can follow your own implementation preferences.

```js
var rtc = {
  // For the local client.
  client: null,
  // For the local audio and video tracks.
  localAudioTrack: null,
  localVideoTrack: null,
};

var options = {
  // Pass your app ID here.
  appId: "<YOUR APP ID>",
  // Set the channel name.
  channel: "demo_channel_name",
  // Pass a token if your project enables the App Certificate.
  token: null,
};

async function startBasicCall() {
  /**
   * Put the following code snippets here.
   */
}

startBasicCall();
```

### 1. Create a local client

```js
rtc.client = AgoraRTC.createClient({ mode: "rtc", codec: "vp8" });
```

Call `createClient` to create a local client object.
Pay attention to the settings of the `mode` and `codec` parameters when creating the client:
- `mode` determines the [channel profile](https://docs.agora.io/en/Agora%20Platform/terms?platform=All%20Platforms#channel-profile). Agora recommends using the `"rtc"` mode for one-to-one or group calls and the `"live"` mode for live broadcasts. The SDK applies different optimization methods according to the channel profile.
- `codec` specifies the codec that the web browser uses for encoding and decoding. If Safari 12.1 or earlier is involved in the call, set `codec` as `"h264"`. In all other cases, Agora recommends setting `codec` as `"vp8"`.

### 2. Join a channel

```js
const uid = await rtc.client.join(options.appId, options.channel, options.token, null);
```

Call `join` to join a specified channel. This method returns a `Promise` object. Returning a `Promise.resolve` object means the client joins the channel successfully; returning a `Promise.reject` object means an error occurs when the client joins the channel. You can also use `async/await` to simplify your code.

Pay attention to the following parameters when joining the channel:
- `appid`: The App ID you get when creating a project in Agora Console. See [Create an Agora project](./run_demo_video_call_web?platform=Web#1-create-an-agora-project) and [Get an App ID](./run_demo_video_call_web?platform=Web#a-nameappida2-get-an-app-id).
- `channel`: The channel name, a string within 64 bytes. In our sample project, we set `channel` as `demo_channel_name`.
- `token`: (Optional) A token that identifies the role and privilege of the user if your project enables the App Certificate. See [Use a token for authentication](hhttps://docs.agora.io/en/Agora%20Platform/token?platform=All%20Platforms) for details.
  - For testing, Agora recommends using a Temp Token generated in Agora Console. See [Get a Temp Token](https://docs.agora.io/en/Agora%20Platform/token?platform=All%20Platforms#get-a-temporary-token).
  - For production, Agora recommends using a token generated at your server. For details on how to generate a token, see [Generate a token from your server](https://docs.agora.io/en/Interactive%20Broadcast/token_server).
> For simplicity, we do not enable the App Certificate and set `token` as `null` in our sample project. If your project enables the App Certificate, ensure the value of `channel` you set here is the same as the value you use when generating a token at your server.
- `uid`: The user ID, which should be unique in a channel. If you set `uid` as `null`, Agora automatically assigns a user ID and returns it in the result of `join`.

For more details on the parameter settings, see [AgoraRTCClient.join](./API%20Reference/web/v4.2.0/interfaces/iagorartcclient.html#join).

### 3. Create and publish the local tracks

```js
// Create an audio track from the audio sampled by a microphone.
rtc.localAudioTrack = await AgoraRTC.createMicrophoneAudioTrack();
// Create a video track from the video captured by a camera.
rtc.localVideoTrack = await AgoraRTC.createCameraVideoTrack();
// Publish the local audio and video tracks to the channel.
await rtc.client.publish([rtc.localAudioTrack, rtc.localVideoTrack]);

console.log("publish success!");
```

The above code snippet shows the whole process of creating and publishing the local audio and video tracks:
1. Call `createMicrophoneAudioTrack` to create a local audio object from the audio sampled by a microphone and call `createCameraVideoTrack` to create a local video track from the video captured by a camera.
2. Call `publish` and pass the local audio and video tracks that you created in the previous step as parameters to publish these tracks to the channel that you joined.

> - The above three methods all return a `Promise` object. Returning a `Promise.resolve` object means the method call succeeds; returning a `Promise.reject` object means the method call fails. You can also use `async/await` to simplify your code.
> - You can use the `Promise.all` method for multiple asynchronous tasks such as joining a channel and creating audio and video tracks because these asynchronous tasks have no dependency.

For more details on how to set the parameters, see:
- [createMicrophoneAudioTrack](./API%20Reference/web/v4.2.0/interfaces/iagorartc.html#createmicrophoneaudiotrack)
- [createCameraVideoTrack](./API%20Reference/web/v4.2.0/interfaces/iagorartc.html#createcameravideotrack)
- [publish](./API%20Reference/web/v4.2.0/interfaces/iagorartcclient.html#publish)

### 4. Subscribe to a remote user
When a remote user publishes media tracks, the SDK triggers the `client.on("user-published")` event, from which you can get an `AgoraRTCRemoteUser` object. Listen for this event with `client.on` and call `AgoraRTCClient.subscribe` in the callback to subscribe to this remote user.

> Agora recommends listening for events **immediately after creating the client** to ensure we do not miss any event.

Add the following code snippet after calling`createClient` to listen for the `client.on("user-published")` event, subscribe to the remote user who publishes media tracks, and automatically play the media tracks.

```js
rtc.client.on("user-published", async (user, mediaType) => {
  // Subscribe to a remote user.
  await rtc.client.subscribe(user, mediaType);
  console.log("subscribe success");

  // If the subscribed track is video.
  if (mediaType === "video") {
    // Get `RemoteVideoTrack` in the `user` object.
    const remoteVideoTrack = user.videoTrack;
    // Dynamically create a container in the form of a DIV element for playing the remote video track.
    const playerContainer = document.createElement("div");
    // Specify the ID of the DIV container. You can use the `uid` of the remote user.
    playerContainer.id = user.uid.toString();
    playerContainer.style.width = "640px";
    playerContainer.style.height = "480px";
    document.body.append(playerContainer);

    // Play the remote video track.
    // Pass the DIV container and the SDK dynamically creates a player in the container for playing the remote video track.
    remoteVideoTrack.play(playerContainer);

    // Or just pass the ID of the DIV container.
    // remoteVideoTrack.play(playerContainer.id);
  }

  // If the subscribed track is audio.
  if (mediaType === "audio") {
    // Get `RemoteAudioTrack` in the `user` object.
    const remoteAudioTrack = user.audioTrack;
    // Play the audio track. No need to pass any DOM element.
    remoteAudioTrack.play();
  }
});
```

Pay attention to the `mediaType` parameter of the `client.on("user-published")` event, which marks the type of the current track the remote user publishes:
- `"audio"`: The remote user publishes an audio track.
- `"video"`: The remote user publishes a video track.

When the remote user unpublishes a media track or leaves the channel, the SDK triggers the `client.on("user-unpublished")` event. You need to destroy the dynamically created DIV container.

Add the following code snippet after listening for the `client.on("user-published")` event to listen for the `client.on("user-unpublished")` event.

```js
rtc.client.on("user-unpublished", user => {
  // Get the dynamically created DIV container.
  const playerContainer = document.getElementById(user.uid);
  // Destroy the container.
  playerContainer.remove();
});
```

### 5. Leave the channel
Follow these steps to leave the channel:
1. Destroy the local audio and video tracks that you have created and disable access to the camera and microphone.
2. Destroy the dynamically created DIV container.
3. Call `leave` to leave the channel.

```js
async function leaveCall() {
  // Destroy the local audio and video tracks.
  rtc.localAudioTrack.close();
  rtc.localVideoTrack.close();

  // Traverse all remote users.
  rtc.client.remoteUsers.forEach(user => {
    // Destroy the dynamically created DIV container.
    const playerContainer = document.getElementById(user.uid);
    playerContainer && playerContainer.remove();
  });

  // Leave the channel.
  await rtc.client.leave();
}
```

> Neither destroying the local media tracks nor destroying the dynamically created DIV container is mandatory. You can follow your own implementation preferences.