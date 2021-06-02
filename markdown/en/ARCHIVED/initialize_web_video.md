---
title: Create and Initialize a Client
platform: Web
updatedAt: 2019-12-11 11:03:55
---
Before creating and initizing the Client, ensure that you have finished preparing the development environment. See [Integrate the SDK](/en/Video/web_prepare) for more information.

## Implementation

### Create a Client
Use the `AgoraRTC.createClient` method to create a client object. Set the mode and codec parameters. 

```javascript
var client = AgoraRTC.createClient({mode: 'live', codec: "h264"});
```

### Initialize the Client
After creating the client, pass the project App ID to the `client.init` method to initialize the client.

```javascript
client.init(<APPID>, function () {
  console.log("AgoraRTC client initialized");

}, function (err) {
  console.log("AgoraRTC client init failed", err);
});
```

> Ensure that you call the `create` and `client.init` methods to intiialize the AgoraRtcEngine before calling any other API. 

## Next Steps
You hava now finished creating the Client and can start a voice call with the following steps:
- [Join a Channel](/en/Video/join_video_web)
- [Publish and Subscribe to Streams](/en/Video/publish_web)

For added requirements on network connection or audio quality, you can also take the following steps before joining a channel.
- [Conduct a Last Mile Test](/en/Video/lastmile_web)
- [Set the Stereo/High-fidelity Audio Profile](/en/Video/audio_profile_web)