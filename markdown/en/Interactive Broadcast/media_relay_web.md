---
title: Co-host across Channels
platform: Android
updatedAt: 2021-03-08 02:41:52
---
## Introduction

Co-hosting across channels refers to the process where the Agora SDK relays the media stream of a host from an interactive live streaming channel (source channel) to a maximum of four interactive live streaming channels (destination channels). It has the following benefits:

- All hosts in the relay channels can see and hear each other.
- The audience members in the relay channels can see and hear all hosts.

Co-hosting across channels applies to scenarios such as an online singing contest, where hosts of different channels interact with each other.

## Implementation

<div class="alert note">To enable media stream relay, contact <a href="mailto:support@agora.io">support@agora.io</a>.</div>

Before relaying media streams across channels, ensure that you have implemented the basic real-time communication functions in your project. For details, see [Start Live Interactive Streaming](start_live_web).

As of v3.0.0, the Agora Web SDK supports co-hosting across channels, adding the following methods:

- `startChannelMediaRelay`
- `updateChannelMediaRelay`
- `stopChannelMediaRelay`

<div class="alert info">API call sequence requirements:<li>Call <code>startChannelMediaRelay</code> after <code>Client.publish</code> succeeds.</li><li>Call <code>updateChannelMediaRelay</code> after <code>startChannelMediaRelay</code> succeeds.</li></div>

During a channel media relay, the SDK reports the states (`state`) and error codes (`code`) of the relay with the  `Client.on("channel-media-relay-state")`  callback, and the events of the relay with the `Client.on("channel-media-relay-event")` callback.

Refer to the following table when implementing your code:

| State code | Error code                                                   | Event code | The media stream relay state                                 |
| ---------- | ------------------------------------------------------------ | ---------- | ------------------------------------------------------------ |
| 2          | 0                                                            | 4          | The channel media relay starts.                              |
| 3          | See [error code](./API%20Reference/web/classes/agorartc.channelmediaerror.html). | /          | An exception occurs during the media stream relay. Call `startChannelMediaRelay` to restart. |
| 0          | 0                                                            | /          | The channel media relay stops.                               |

**Note**:

- Any host in an interactive live streaming channel can call `startChannelMediaRelay` to enable the media stream relay. The SDK relays the media stream of the host who calls the method.
- After a relay starts, users in the destination channels receive the `Client.on("stream-added")` callback.
- If the host of a destination channel drops offline or leaves the channel during the media relay, the host of the source channel receives the `Client.on("peer-leave")` callback.

### Sample code

- Configure the media stream relay:

  ```javascript
  var channelMediaConfig = new AgoraRTC.ChannelMediaRelayConfiguration();
  // Set the source channel information
  channelMediaConfig.setSrcChannelInfo({
   channelName: "srcChannel",
   uid: 0,
   token: "yourSrcToken",
  })
  // Set the destination channel information. 
  // You can set a maximum of four detination channels.
  channelMediaConfig.setDestChannelInfo("destChannel1", {
   channelName: "destChannel1",
   uid: 123,
   token: "yourDestToken",
  })
  ```

- Start the media stream relay :

  ```javascript
  client.startChannelMediaRelay(channelMediaConfig, function(e) {
    if(e) {
      utils.notification(`startChannelMediaRelay failed: ${JSON.stringify(e)}`);
    } else {
      utils.notification(`startChannelMediaRelay success`);
    }
  });
  ```

- Update the relay channels:

  ```javascript
  // Remove a destination channel
  channelMediaConfig.removeDestChannelInfo("destCname1")
  // Update the configurations of the media relay
  client.updateChannelMediaRelay(channelMediaConfig, function(e) {
    if(e) {
      utils.notification(`updateChannelMediaRelay failed: ${JSON.stringify(e)}`);
    } else {
      utils.notification(`updateChannelMediaRelay success`);
    }
  });
  ```

- Stop the media stream relay:

  ```javascript
  stopChannelMediaRelay: function() {
    client.stopChannelMediaRelay(function(e) {
      if(e) {
        utils.notification(`stopChannelMediaRelay failed: ${JSON.stringify(e)}`);
      } else {
        utils.notification(`stopChannelMediaRelay success`);
      }
    });
  }
  ```

### API reference

- [`startChannelMediaRelay`](./API%20Reference/web/interfaces/agorartc.client.html#startchannelmediarelay)
- [`updateChannelMediaRelay`](./API%20Reference/web/interfaces/agorartc.client.html#updatechannelmediarelay)
- [`stopChannelMediaRelay`](./API%20Reference/web/interfaces/agorartc.client.html#stopchannelmediarelay)

## Considerations

- The Agora RTC SDK supports relaying media streams to a maximum of four destination channels. To add or delete a destination channel, call `updateChannelMediaRelay`.
- This feature supports integer user IDs only.


- When setting the source channel information (`setSrcChannelInfo`), ensure that the setting of `uid` is different from the UID of the current host and any other user in the source channel. We recommend setting this `uid` as `0`.



- To call `startChannelMediaRelay` again after it succeeds, you must call `stopChannelMediaRelay` to quit the current relay.