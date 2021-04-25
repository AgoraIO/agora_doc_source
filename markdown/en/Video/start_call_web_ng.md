---
title: Start a Video Call
platform: Web
updatedAt: 2021-02-05 04:36:36
---

# Get Started with the Agora Video SDK for Web

This article shows you the minimum code you need to add a video call into your Web app by using the Agora Video SDK for Web.

## Understand the tech

![](https://web-cdn.agora.io/docs-files/1619335084232)

To make a video call, your app client uses an [AgoraRTCClient]() object to join an Agora RTC channel with the following parameters:
- The App ID: A randomly generated string provided by Agora for identifying your app. You can get the App ID in Agora Console.
- The user ID: The unique identifier of a user. An integer or a string specified by your app user.
- An AccessToken: A credential for verifying the identity of the user when your app user joins an RTC channel. In a test or production environment, your app client retrieves AccessTokens from your app server in your security infrastructure. For rapid testing, you can get a temporary token with a validity period of 24 hours in Agora Console.
- The channel name: The string specified by your app user for identifying an RTC channel. Agora automatically creates an RTC channel with the channel name. To allow multiple clients to chat with one another, you can simply have them use the same channel name and join the same channel.

Once your app clients join an RTC channel, you can use [LocalTrack]() and [RemoteTrack]() objects to publish and subscribe audio and video streams in the channel.

The next section shows the procedure of 

## Prerequisites

- A Windows or macOS computer with access to the Internet. If your network has a firewall, follow the instructions in [Firewall Requirements](https://docs.agora.io/en/Agora%20Platform/firewall?platform=Web) to access Agora services.
- Your computer is equipped with an Intel 2.2GHz Core i3/i5/i7 processor (2nd generation) or equivalent.
- Physical media input devices, such as a built-in camera and a built-in microphone.
- The latest stable version of [Chrome](https://www.google.com/chrome/).
- A valid Agora [account](https://docs.agora.io/en/Agora%20Platform/sign_in_and_sign_up?platform=Web).
  - Create an Agora project in Agora Console.
  - Get an Agora App ID in Agora Console.
  - Get a temporary token in Agora Console.

## Implement a video call

### 1. Create a Web project

To create a minimal Web client, in a directory, such as <app_dir>, create the following files:
- `index.html`, which includes visual interfaces with the app user. You can copy the following code:
  ```
  ```
- `basicVideoCall.js`, which includes programmable interfaces with AgoraRTCClient to implement the app logic. You can copy the following code:
  ```
  ```

### 2. Integrate the SDK

Integrate the Agora Video SDK for Web into your project through npm, as follows:
1. 
2. 
3. 

### 3. Create an AgoraRTCClient object

Copy the following code snippet to XXX

```js
rtc.client = AgoraRTC.createClient({ mode: "rtc", codec: "vp8" });
```

The above code snippet shows how to call `createClient` to create an AgoraRTCClient object.

### 4. Join an RTC channel

Copy the following code snippet to XXX

```js
const uid = await rtc.client.join(options.appId, options.channel, options.token, null);
```

The above code snippet shows how to call [`join`]() to join an RTC channel with your App ID, a user ID, your temporary token, and a channel name.

### 5. Create and publish the local tracks

Copy the following code snippet to XXX

```js
// Create a local audio track from the audio sampled by a microphone.
rtc.localAudioTrack = await AgoraRTC.createMicrophoneAudioTrack();
// Create a local video track from the video captured by a camera.
rtc.localVideoTrack = await AgoraRTC.createCameraVideoTrack();
// Publish the local audio and video tracks to the channel.
await rtc.client.publish([rtc.localAudioTrack, rtc.localVideoTrack]);

console.log("publish success!");
```

The above code snippet shows the whole process of creating and publishing the local audio and video tracks in the RTC Channel.

### 4. Subscribe to a remote user

Copy the following code snippet after calling`createClient`.

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

The above code snippet shows how to subscribe to a remote user.

When a remote user publishes media tracks, the SDK triggers the `client.on("user-published")` event, from which you can get an `AgoraRTCRemoteUser` object. Listen for this event with `client.on` and call `AgoraRTCClient.subscribe` in the callback to subscribe to this remote user.

> Agora recommends listening for events **immediately after creating the client** to ensure we do not miss any event.

Pay attention to the `mediaType` parameter of the `client.on("user-published")` event, which marks the type of the current track the remote user publishes:
- `"audio"`: The remote user publishes an audio track.
- `"video"`: The remote user publishes a video track.

When the remote user unpublishes a media track or leaves the channel, the SDK triggers the `client.on("user-unpublished")` event. You need to destroy the dynamically created DIV container.

### 5. Leave the channel

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

## Test your app

Due to security limits on HTTP addresses except 127.0.0.1, the Web SDK only supports HTTPS or http://localhost (http://127.0.0.1). If you deploy your project over HTTP, you can only visit your project at http://localhost（http://127.0.0.1).

## See also

### The other ways to integrate the SDK


### API call sequence

The following figure shows the API call sequence of a basic one-to-one video call.

### Sample projects on GitHub

Agora provides the following additional sample projects on GitHub:
