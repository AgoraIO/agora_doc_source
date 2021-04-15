---
title: Co-host Across Channels
platform: Web
updatedAt: 2020-12-30 09:08:53
---
<div class="alert note">This article only applies to the Agora Web SDK 4.x. If you use the Web SDK 3.x or earlier versions, see <a href="./media_relay_web?platform=Web">Co-host Across Channels</a>.</li></div>

## Introduction

Co-hosting across channels is the process where the Agora Web SDK relays the media tracks of a host from a live-broadcast channel (source channel) to a maximum of four live-broadcast channels (destination channels). It has the following benefits:

- All hosts in the channels can see and hear each other.
- The audiences in the channels can see and hear all hosts.

Co-hosting across channels applies to scenarios such as an online singing contest, where hosts of different channels interact with each other.

## Implementation

<div class="alert note">To enable media stream relay, contact support@agora.io.</div>

Before proceeding, ensure that you have read the quickstart guides and implemented basic real-time audio and video functions in your project.

The Agora Web SDK provides the following methods for co-hosting across channels:

- `startChannelMediaRelay`
- `updateChannelMediaRelay`
- `stopChannelMediaRelay`

> API call sequence requirements:
> - Call `startChannelMediaRelay` after `AgoraRTCClient.publish` succeeds.
> - Call `updateChannelMediaRelay` after `startChannelMediaRelay` succeeds.

During a channel media relay, the SDK reports the states and error codes of the relay with the `AgoraRTCClient.on("channel-media-relay-state")` callback, and the events of the relay with the `AgoraRTCClient.on("channel-media-relay-event")` callback.

> Notes:
> - Any host in a live-broadcast channel can call `startChannelMediaRelay` to enable the media stream relay. The SDK relays the media stream of the host who calls the method.
> - After a relay starts, users in the destination channels receive the `AgoraRTCClient.on("user-published")` callback.
> - If the host of a destination channel drops offline or leaves the channel during the media relay, the host of the source channel receives the `AgoraRTCClient.on("user-left")` callback.

### Sample code
The `client` object in the following sample code is created by calling `AgoraRTC.createClient`.

**Configure the media stream relay**

```js
const channelMediaConfig = new AgoraRTC.ChannelMediaRelayConfiguration();
// Set the source channel information.
channelMediaConfig.setSrcChannelInfo({
 channelName: "srcChannel",
 uid: 0,
 token: "yourSrcToken",
})
// Set the destination channel information. You can set a maximum of four destination channels.
channelMediaConfig.addDestChannelInfo({
 channelName: "destChannel1",
 uid: 123,
 token: "yourDestToken",
})
```

**Start the media stream relay**

```js
client.startChannelMediaRelay(channelMediaConfig).then(() => {
  console.log(`startChannelMediaRelay success`);
}).catch(e => {
  console.log(`startChannelMediaRelay failed`, e);
})
```

**Update the media stream relay configurations**

```js
// Remove a destination channel.
channelMediaConfig.removeDestChannelInfo("destChannel1")
// Update the configurations of the media stream relay.
client.updateChannelMediaRelay(channelMediaConfig).then(() => {
  console.log("updateChannelMediaRelay success");
}).catch(e => {
  console.log("updateChannelMediaRelay failed", e);
})
```

**Stop the media stream relay**
```js
client.stopChannelMediaRelay().then(() => {
  console.log("stop media relay success");
}).catch(e => {
  console.log("stop media relay failed", e);
})
```

### API reference
- [`startChannelMediaRelay`](./API%20Reference/web/v4.2.1/interfaces/iagorartcclient.html#startchannelmediarelay)
- [`updateChannelMediaRelay`](./API%20Reference/web/v4.2.1/interfaces/iagorartcclient.html#updatechannelmediarelay)
- [`stopChannelMediaRelay`](./API%20Reference/web/v4.2.1/interfaces/iagorartcclient.html#stopchannelmediarelay)
- [`AgoraRTCClient.on("channel-media-relay-state")`](/api/en/interfaces/iagorartcclient.html#event_channel_media_relay_state)
- [`AgoraRTCClient.on("channel-media-relay-event")`](/api/cn/interfaces/iagorartcclient.html#event_channel_media_relay_event)

## Considerations

- The Agora Web SDK supports relaying media streams to a maximum of four destination channels. To add or delete a destination channel, call `updateChannelMediaRelay`.
- This feature supports integer user IDs only.
- When setting the source channel information (`setSrcChannelInfo`), ensure that the setting of `uid` is different from the UID of the current host and any other user in the source channel. Agora recommends setting this `uid` as `0`.
- To call `startChannelMediaRelay` again after it succeeds, you must call `stopChannelMediaRelay` to quit the current relay.