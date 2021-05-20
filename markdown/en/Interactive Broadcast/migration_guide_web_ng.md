---
title: Agora Web SDK 4.x
platform: Web
updatedAt: 2021-01-25 06:36:32
---
This page provides an introduction to the Web SDK 4.x and a set of guidelines that help you migrate from the Web SDK 3.x to the Web SDK 4.x.

## Introduction to the Web SDK 4.x

The Web SDK 4.x refactors the Web SDK 3.x. Based on the features of 3.x, 4.x fully optimizes the internal architecture of the SDK and provides more flexible and easy-to-use APIs.

Compared to the Web SDK 3.x, the Web SDK 4.x has the following advantages:

- Uses promises for asynchronous operations, which improves the robustness and readability of your code.
- Supports TypeScript.
- Replaces the `Stream` object with `Track` objects for separate and flexible control over audio and video.
- Improves the channel event notification mechanism, making it easier for you to deal with reconnection.
- Provides more accurate and comprehensive error codes for troubleshooting.

<div class="alert info"><li>Agora will maintain the Web SDK 3.x, but may not be able to add all the new features in the 3.x due to structural differences. Agora recommends that you refer to the following migration guide and migrate from the Web SDK 3.x to the Web SDK 4.x.</li><li>See the <a href="https://docs.agora.io/en/Voice/release_web_video?platform=Web">release notes</a> of the Web SDK 3.x and earlier versions.</li></div>

## Migration guide

This section introduces the major differences between the Web SDK 3.x and 4.x and provides migration examples on building a video conferencing app.

<div class="alert note">The Web SDK 4.x is <b>not backward compatible</b>. Refer to the API reference, guides, and code samples provided by Agora to facilitate the migration process.</div>

### What's changed

#### Use promises for asynchronous operations

For asynchronous methods such as joining and leaving a channel, publishing and subscribing, enumerating media input devices, and starting and stopping live transcoding, the Web SDK notifies users of the results of these asynchronous operations with callbacks or events, while the Web SDK 4.x uses promises.

#### Fine control over audio and video tracks

For the Web SDK 4.x, we replace the [Stream](https://docs.agora.io/en/Video/API%20Reference/web/interfaces/agorartc.stream.html) object with `Track` objects. You create, publish, or subscribe to one or multiple audio and video tracks. Tracks make up a stream. The advantage of dividing a stream up into tracks is that audio and video are controllable separately. And these new methods are easier to use than the `Stream.addTrack` and `Stream.removeTrack` methods in the Web SDK.

> For now, the Web SDK 4.x allows publishing multiple audio tracks but only one video track. The SDK automatically mixes multiple audio tracks into one when publishing.

In addition to replacing the `Stream` object with `Track` objects, the Web SDK 4.x provides different interfaces for the local and remote tracks. Some methods and objects are only available locally, and some are only available remotely. This change affects multiple API methods, including creating objects, publishing, and subscribing to tracks. For details, see [Creating an audio track and a video track](#create-an-audio-track-and-a-video-track) and [Publish the local audio and video tracks](#publish-the-local-audio-and-video-tracks).

#### Improve channel events

**Rename events**

The Web SDK 4.x ensures the consistency of all event names. For example, Agora renames `onTokenPrivilegeWillExpire` as `token-privilege-will-expire`. Agora also renames several events to ensure developers can better understand how they work. For example, Agora renames `peer-online` and `peer-offline` as `user-joined` and `user-left`, `stream-added` and `stream-removed` as `user-published` and `user-unpublished`.

**Change the format of parameters in events**

In the Web SDK 3.x, the parameters of events must be wrapped in an object, while in the Web SDK 4.x, you can directly pass multiple parameters in events.

Take the `"connection-state-change"` event as an example:

```js
// Use the Web SDK 3.x
client.on("connection-state-change", e => {
  console.log("current", e.curState, "prev", e.prevState);
});
```
```
// Use the Web SDK 4.x
client.on("connection-state-change", (curState, prevState) => {
  console.log("current", curState, "prev", prevState);
});
```

**Improve the event notification mechanism**

The Web SDK 4.x improves its event notification mechanism, and does not trigger channel events repeatedly.

For example, assume that a local user A and remote users B, C, and D joins a channel at the same time, and B, C, and D all publishes their streams. If A suddenly loses connection with the channel due to bad network conditions, the SDK automatically reconnects A to the channel. While A is reconnecting to the channel, B leaves the channel and C unpublishes the stream. My question is, what events that the SDK triggers during the whole process?

When A joins the channel, the Web SDK 3.x and Web SDK 4.x trigger the same events:

- Events indicating B, C, D joining the channel.
- Events indicating B, C, D publishing their streams.

When A loses connection with the channel due to poor network conditions and reconnects to the channel:

- If A uses the Web SDK 3.x: When A loses connection with the channel due to poor network conditions, the SDK assumes A has left the channel and clears all the states in the channel. When A successfully reconnects to the channel, it receives:
  - Events indicating C, D joining the channel.
  - Events indicating D publishing the stream.

> In the Web SDK 3.x, you can expect to receive the same events multiple times due to disconnection and reconnection, which may cause unexpected problems for dealing with these events on the app level. You need to listen for connection state changes and reset the states on the app level to avoid unexpected problems when receiving these events for the second time.

- If A uses the Web SDK 4.x: When A loses connection with the channel due to poor network conditions, the SDK assumes that A is still in the channel and does not clear all the states in the channel. When A successfully reconnects to the channel, the SDK only sends A events that are lost during the reconnection process, including:
  - The event indicating B leaving the channel.
  - The event indicating C unpublishing the stream.

> The Web SDK 4.x does not send you the same events repeatedly and ensures your app works properly during reconnection.

As these hypothetical examples demonstrate, the event notification mechanism in the Web SDK 4.x is more intuitive and does not need extra work.

### Migration examples

This section takes building a video conferencing app as an example and introduces the differences between implementing the Web SDK 4.x and the Web SDK 3.x in detail.

#### Join a channel

First, create a `Client` object and join a specified channel.

```js
// Use the Web SDK 3.x
const client = AgoraRTC.createClient({ mode: "live", codec: "vp8" });
client.init("APPID", () => {
  client.join("Token", "Channel", null, (uid) => {
    console.log("join success", uid);
  }, (e) => {
    console.log("join failed", e);
  });
});
```
```
// Use the Web SDK 4.x
const client = AgoraRTC.createClient({ mode: "live", codec: "vp8" });

try {
  const uid = await client.join("APPID", "Token", "Channel", null);
  console.log("join success");
} catch (e) {
  console.log("join failed", e);
}
```

> Here we assume that our code runs within in an `async` function and use `await` in the following code snippets.

Key points:

- In the Web SDK 4.x, we use the `Promise` object together with `async/await` for the asynchronous operation `join`.
- The Web SDK 4.x removes the `client.init` method and you pass `APPID` when calling `client.join`. If you want to join another channel that uses a different App ID, you do not need to create another client object.

#### Create an audio track and a video track

Second, create an audio track object from the audio sampled by a microphone and create a local video track from the video captured by a camera. In the sample code, by default, we play the local video track and do not play the local audio track.

```js
// Use the Web SDK 3.x
const localStream = AgoraRTC.createStream({ audio: true, video: true });
localStream.init(() => {
  console.log("init stream success");
  localStream.play("DOM_ELEMENT_ID", { muted: true });
}, (e) => {
  console.log("init local stream failed", e);
});
```
```
// Use the Web SDK 4.x
const localAudio = await AgoraRTC.createMicrophoneAudioTrack();
const localVideo = await AgoraRTC.createCameraVideoTrack();
console.log("create local audio/video track success");

localVideo.play("DOM_ELEMENT_ID");
```

Key points:

- The Web SDK 4.x removes the `Stream` object. Call `createMicrophoneAudioTrack` to create an audio track and call `createCameraVideoTrack` to create a video track.
- The audio and video track objects in the Web SDK 4.x do not provide the `init` method because the SDK initializes the microphone and camera when creating the tracks and notifies you of the result with promises.
- The Web SDK 4.x can control the playback of local audio and video tracks separately and removes the `muted` parameter in the `play` method. If you do not want to play the local audio track, do not call `play` in the local audio track object.

#### Publish the local audio and video tracks

After creating the local audio and video tracks, publish these tracks to the channel.

```js
// Use the Web SDK 3.x
client.publish(localStream, err => {
  console.log("publish failed", err);
});
client.on("stream-published",  () => {
  console.log("publish success");
});
```
```
// Use the Web SDK 4.x
try {
  // Remove this line if the channel profile is not live broadcast.
  await client.setClientRole("host");
  await client.publish([localAudio, localVideo]);
  console.log("publish success");
} catch (e) {
  console.log("publish failed", e);
}
```

Key points:

- If your channel profile is [live broadcast](./API%20Reference/web_ng/interfaces/clientconfig.html#mode), the Web SDK 3.x automatically sets the user role as `host` when publishing the stream. However, in the Web SDK 4.x, you need to call `setClientRole` to set the user role as `host`.
- In the Web SDK 4.x, `publish` returns a `Promise` object representing the eventual completion or failure of the asynchronous operation.
- In the Web SDK 4.x, when calling `publish`, you need to pass one or multiple `LocalTrack` objects instead of the `Stream` object. You can call `publish` repeatedly to publish multiple tracks and call `unpublish` repeatedly to unpublish multiple tracks.

#### Subscribe to remote media tracks and play

When a remote user in the channel publishes media tracks, we need to automatically subscribe to these tracks and play. To do this, you need to listen for the `user-published` event and call `subscribe` when the SDK triggers this event.

```js
// Use the Web SDK 3.x
client.on("stream-added", e => {
  client.subscribe(e.stream, { audio: true, video: true }, err => {
    console.log("subscribe failed", err);
  });
});

client.on("stream-subscribed", e => {
  console.log("subscribe success");
  e.stream.play("DOM_ELEMENT_ID");
});
```
```
// Use the Web SDK 4.x
client.on("user-published", async (remoteUser, mediaType) => {
  await client.subscribe(remoteUser, mediaType);
  if (mediaType === "video") {
    console.log("subscribe video success");
    remoteUser.videoTrack.play("DOM_ELEMENT_ID");
  }
  if (mediaType === "audio") {
    console.log("subscribe audio success");
    remoteUser.audioTrack.play();
  }
});
```

Key points:

- The Web SDK 4.x replaces the `stream-added`, `stream-removed`, and `stream-updated` events with the `user-published` and `user-unpublished` events.

> Pay attention to the `mediaType` parameter of the `user-published` event, which marks the type of the current track the remote user publishes. It can be `"video"` or `"audio"`. If the remote user publishes an audio track and a video track at the same time, the SDK triggers two `user-published` events, in which `mediaType` is `"audio"` and `"video"` respectively.

- In the Web SDK 4.x, `subscribe` returns a `Promise` object representing the eventual completion or failure of the asynchronous operation. When calling `subscribe`, pass a `remoteUser` object. For details, see [AgoraRTCRemoteUser](./API%20Reference/web_ng/interfaces/iagorartcremoteuser.html).
- When the subscription succeeds, the subscribed tracks are updated to `remoteUser` and you can go on to call `play`.

## Core API change list

### AgoraRTC

- Rename `getScreenSources` as [getElectronScreenSources](./API%20Reference/web_ng/interfaces/iagorartc.html#getelectronscreensources), remove callbacks, and return a promise

- [getDevices](./API%20Reference/web_ng/interfaces/iagorartc.html#getdevices) returns a promise. Add [getCameras](./API%20Reference/web_ng/interfaces/iagorartc.html#getcameras) and [getMicrophones](./API%20Reference/web_ng/interfaces/iagorartc.html#getmicrophones)

- Remove the `Logger` object, and add [disableLogUpload](./API%20Reference/web_ng/interfaces/iagorartc.html#disablelogupload), [enableLogUpload](./API%20Reference/web_ng/interfaces/iagorartc.html#enablelogupload), and [setLogLevel](./API%20Reference/web_ng/interfaces/iagorartc.html#setloglevel)

- Replace `createStream` with the following methods:
  - [createMicrophoneAudioTrack](./API%20Reference/web_ng/interfaces/iagorartc.html#createmicrophoneaudiotrack)
  - [createCameraVideoTrack](./API%20Reference/web_ng/interfaces/iagorartc.html#createcameravideotrack)
  - [createScreenVideoTrack](./API%20Reference/web_ng/interfaces/iagorartc.html#createscreenvideotrack)
  - [createBufferSourceAudioTrack](./API%20Reference/web_ng/interfaces/iagorartc.html#createbuffersourceaudiotrack)
  - [createCustomAudioTrack](./API%20Reference/web_ng/interfaces/iagorartc.html#createcustomaudiotrack)
  - [createCustomVideoTrack](./API%20Reference/web_ng/interfaces/iagorartc.html#createcustomvideotrack)

### Client

- Remove `Client.init`

- Remove `Client.getConnectionState` and add [Client.connectionState](./API%20Reference/web_ng/interfaces/iagorartcclient.html#connectionstate)

- Add `RECONNECTING` in [ConnectionState](./API%20Reference/web_ng/globals.html#connectionstate)

- Add [Client.uid](./API%20Reference/web_ng/interfaces/iagorartcclient.html#uid)

- Add [Client.remoteUsers](./API%20Reference/web_ng/interfaces/iagorartcclient.html#remoteusers)

- [Client.addInjectStreamUrl](./API%20Reference/web_ng/interfaces/iagorartcclient.html#addinjectstreamurl) returns a promise representing the success or failure of injecting the stream.Remove `Client.on("streamInjectStatus")`.

- Remove the `url` parameter in [Client.removeInjectStreamUrl](./API%20Reference/web_ng/interfaces/iagorartcclient.html#addinjectstreamurl)

- Remove the callbacks of [Client.enableDualStream](./API%20Reference/web_ng/interfaces/iagorartcclient.html#enabledualstream) / [Client.disableDualStream](./API%20Reference/web_ng/interfaces/iagorartcclient.html#disabledualstream) and return a promise

- Move `Client.getCameras`, `Client.getDevices`, `Client.getRecordingDevices` to the `AgoraRTC` interface

- Remove `Client.getPlayoutDevices`

- Replace `Client.getLocalAudioStats`, `Client.getLocalVideoStats`, `Client.getRemoteAudioStats`, and `Client.getRemoteVideoStats` with [LocalAudioTrack.getStats](./API%20Reference/web_ng/interfaces/ilocalaudiotrack.html#getstats), [LocalVideoTrack.getStats](./API%20Reference/web_ng/interfaces/ilocalvideotrack.html#getstats), [RemoteAudioTrack.getStats](./API%20Reference/web_ng/interfaces/iremoteaudiotrack.html#getstats), and [RemoteVideoTrack.getStats](./API%20Reference/web_ng/interfaces/iremotevideotrack.html#getstats).

- Remove `Client.getSystemStats`

- Replace `Client.getSessionStats` and `Client.getTransportStats` with [Client.getRTCStats](./API%20Reference/web_ng/interfaces/iagorartcclient.html#getrtcstats)

- Remove the callback in [Client.join](./API%20Reference/web_ng/interfaces/iagorartcclient.html#join) and return a promise. Also add the `appid` parameter in this method

- Remove the callback in [Client.leave](./API%20Reference/web_ng/interfaces/iagorartcclient.html#leave) and return a promise.

- Add [Client.once](./API%20Reference/web_ng/interfaces/iagorartcclient.html#once)

- Add [Client.removeAllListeners](./API%20Reference/web_ng/interfaces/iagorartcclient.html#removealllisteners)

- Add the `tracks` parameter in [Client.publish](./API%20Reference/web_ng/interfaces/iagorartcclient.html#publish) for passing [LocalTrack](./API%20Reference/web_ng/interfaces/ilocaltrack.html). This method returns a promise. Remove `Client.on("stream-published")`

- [Client.unpublish](./API%20Reference/web_ng/interfaces/iagorartcclient.html#publish) returns a promise.

- Add the `user` parameter in [Client.subscribe](./API%20Reference/web_ng/interfaces/iagorartcclient.html#subscribe) for passing [AgoraRTCRemoteUser](./API%20Reference/web_ng/interfaces/iagorartcremoteuser.html)，This method returns a promise. Remove `Client.on("stream-subscribed")`.

- Add the `user` parameter in [Client.unsubscribe](./API%20Reference/web_ng/interfaces/iagorartcclient.html#unsubscribe) for passing [AgoraRTCRemoteUser](./API%20Reference/web_ng/interfaces/iagorartcremoteuser.html). This method returns a promise.

- [Client.renewToken](./API%20Reference/web_ng/interfaces/iagorartcclient.html#renewtoken) returns a promise.

- Remove the callback in [Client.setClientRole](./API%20Reference/web_ng/interfaces/iagorartcclient.html#setclientrole) and return a promise. In the Web SDK 4.x, setting the user role as `audience` does not unpublish, and when calling `publish`, the SDK does not automatically setting the user role as `host`

- Replace `Client.setEncryptionMode` and `Client.setEncryptionSecret` with [Client.setEncryptionConfig](./API%20Reference/web_ng/interfaces/iagorartcclient.html#setencryptionconfig)

- [Client.setLiveTranscoding](./API%20Reference/web_ng/interfaces/iagorartcclient.html#setlivetranscoding), [Client.startLiveStreaming](./API%20Reference/web_ng/interfaces/iagorartcclient.html#startlivestreaming), and [Client.stopLiveStreaming](./API%20Reference/web_ng/interfaces/iagorartcclient.html#stoplivestreaming) all return a promise. Remove `Client.on("liveTranscodingUpdated")`, `Client.on("liveStreamingStarted")`, `Client.on("liveStreamingFailed")`, and `Client.on("liveStreamingStopped")` events.

- `Client.startChannelMediaRelay` return a promise
- Replace `setDestChannelInfo` in [ChannelMediaRelayConfiguration](./API%20Reference/web_ng/interfaces/ichannelmediarelayconfiguration.html) with [addDestChannelInfo](./API%20Reference/web_ng/interfaces/ichannelmediarelayconfiguration.html#adddestchannelinfo), remove several parameters
- Remove several parameters in [setSrcChannelInfo](./API%20Reference/web_ng/interfaces/ichannelmediarelayconfiguration.html#setsrcchannelinfo) of [ChannelMediaRelayConfiguration](./API%20Reference/web_ng/interfaces/ichannelmediarelayconfiguration.html)
- [Client.stopChannelMediaRelay](./API%20Reference/web_ng/interfaces/iagorartcclient.html#stopchannelmediarelay) return a promise.
- Remove the callback in [Client.updateChannelMediaRelay](./API%20Reference/web_ng/interfaces/iagorartcclient.html#updatechannelmediarelay) and this method returns a promise.
- Replace `Client.on("first-video-frame-decode")` and `Client.on("first-audio-frame-decode")` with [RemoteTrack.on("first-frame-decode")](./API%20Reference/web_ng/interfaces/iremotetrack.html#event_first_frame_decoded)
- Replace `Client.on("mute-audio")`, `Client.on("mute-video")`, `Client.on("unmute-audio")`, and `Client.on("unmute-video")` with [Client.on("user-mute-updated")](./API%20Reference/web_ng/interfaces/iagorartcclient.html#event_user_mute_updated)

- Replace `Client.on("active-speaker")` with [Client.on("volume-indicator")](./API%20Reference/web_ng/interfaces/iagorartcclient.html#event_volume_indicator)

- Rename `Client.on("onTokenPrivilegeWillExpire")` and `Client.on("onTokenPrivilegeDidExpire")` as [Client.on("token-privilege-will-expire")](./API%20Reference/web_ng/interfaces/iagorartcclient.html#event_token_privilege_will_expire) and [Client.on("token-privilege-did-expire")](./API%20Reference/web_ng/interfaces/iagorartcclient.html#event_token_privilege_did_expire)

- Remove `Client.on("network-type-changed")`

- Remove `Client.on("connected")` and `Client.on("reconnect")`. You can get events related to connection states from[Client.on("connection-state-change")](./API%20Reference/web_ng/interfaces/iagorartcclient.html#event_connection_state_change)

- Add the `isFallbackOrRecover` parameter in [Client.on("stream-fallback")](./API%20Reference/web_ng/interfaces/iagorartcclient.html#event_stream_fallback)

> Remove `Stream.setAudioOutput`. Agora does not recommends setting the audio output device on the web page. Instead, Agora recommends using the default audio output device.

## Stream
In the Web SDK 4.x, Agora replaces the [Stream](./API%20Reference/web/interfaces/agorartc.stream.html) object with `Track` objects. Tracks make up a stream. You create, publish, or subscribe to one or multiple audio and video tracks to control the media stream. The advantage of dividing a stream up into tracks is that audio and video are controllable separately. Additionally, the Web SDK 4.x provides different interfaces for the local and remote tracks. Some methods and objects are only available locally, and some are only available remotely.

Listed below are the major differences on media control between the Web SDK 4.x and Web SDK 3.x:

- Enable/disable a local track: The Web SDK 4.x replaces the `Stream.muteAudio` and `Stream.muteVideo` methods with [ILocalTrack.setEnabled](./API%20Reference/web_ng/interfaces/ilocaltrack.html#setenabled) for enabling or disabling a local audio or video track. This replacement changes the following SDK behaviors:
  - In the Web SDK 3.x, when the mute state changes, the SDK triggers the `Client.on("mute-audio")`, `Client.on("mute-video")`, `Client.on("unmute-audio")`, or `Client.on("unmute-video")` events. The Web SDK 4.x removes these events. When you call `setEnabled` to enable or disable a published local track, the SDK triggers the `Client.on("user-published")` or `Client.on("user-unpublished")` events on the remote client.
  - In the Web SDK 3.x, after you call `Stream.muteVideo(true)` to disable a local video stream, the camera light stays on, which might adversely impact the user experience. In contrast, if you call `setEnabled(false)` in the Web SDK 4.x to disable a local video track, the SDK immediately turns off the camera.
- Set the media device:
  - The Web SDK 4.x replaces `Stream.switchDevice` with [IMicrophoneAudioTrack.setDevice](./API%20Reference/web_ng/interfaces/imicrophoneaudiotrack.html#setdevice) and [ICameraVideoTrack.setDevice](./API%20Reference/web_ng/interfaces/icameravideotrack.html#setdevice) for setting the media input device.
  - The Web SDK 4.x replaces `Stream.setAudioOutput` with [IRemoteAudioTrack.setPlaybackDevice](./API%20Reference/web_ng/interfaces/iremoteaudiotrack.html#setplaybackdevice) for setting the audio output device.