---
title: Inject Online Media Stream
platform: Web
updatedAt: 2021-02-26 08:23:50
---
## Introduction

**Injecting an online media stream** refers to injecting an external audio or video stream to an ongoing live broadcast channel, so that the hosts and audience in the channel can hear and see the stream while interacting with each other. 

The Agora Web SDK v2.5.1 and later provides the `Client.addInjectStreamUrl` method for the following functions:

- The host can specify a media stream as the input source, inject it into the channel, and push it to the audience.
- The host can set the video profile of the injected video stream.
- If the host enables CDN streaming, the host can push an injected media stream to the CDN audience.

### Applicable Scenarios

Injecting an online media stream can be applied to the following scenarios:

- Live sporting events. The hosts and audience can watch events while commenting on them.
- Music shows, movies, and entertainment shows. The hosts and audience can interact in real time while watching the shows.
- Video streams captured by drones or network cameras can be injected into a live broadcast and broadcasted to the audience in a channel.

###  Working Principles

![](https://web-cdn.agora.io/docs-files/1569414380425)


- The host in a live broadcast channel pulls an online media stream and pushes it to the Agora SD-RTN and live broadcast channel through the Video Inject Server. The host and audience in the channel can hear/see the media stream.
- If the host enables CDN streaming, the injected media stream is also pushed to the CDN so that the CDN audience can hear/see the media stream.

> Supported media stream formats include RTMP, HLS, and FLV. Audio-only streams can also be injected.
> Only the host (broadcaster) can inject and remove an injected media stream. Neither the delegated host nor the audience can do that.



## Implementation

Before proceeding, ensure that you implement a basic live broadcast in your project. See [Start a Live Broadcast](start_live_web) for details.

Refer to the following steps to inject an online media stream:

1. The host in a channel calls the `addInjectStreamUrl` method to inject an online media stream to the live broadcast channel. You can modify the parameter values of `config` to set the resolution, bitrate, and frame rate of the injected stream. See [InjectStreanConfig](./API%20Reference/web/interfaces/agorartc.injectstreamconfig.html).
	> Only one online media stream can be injected into the same channel at the same time.

	If the method call is successful, the SDK triggers the `Client.on("stream-added"` and `Client.on("peer-online")` callbacks to all the users in the channel, and triggers the `Client.on("streamInjectedStatus")` callback to the local host.
	> The local host can troubleshoot with [API Reference](#api) when exceptions occur.
	
2. The host in a channel calls the `removeInjectStreamUrl` method to remove the injected media stream.
	If the method call is successful, the SDK triggers the `Client.on("peer-leave")` and `Client.on("stream-removed")`callbacks to all the users in the channel.
	> If the host has left the channel, calling the `removeInjectStreamUrl` method is not necessary.


### Sample code

```javascript
// Javascript
// Inject an online media stream.
var InjectStreamConfig = {
   width: 0,
   height: 0,
   videoGop: 30,
   videoFramerate: 15,
   videoBitrate: 400,
   audioSampleRate: 44100,
   audioChannels: 1,
  });

  Client.addInjectStreamUrl(url, config);

// Remove an online media stream.
Client.removeInjectStreamUrl(url);
```

We also provide an open-source [Live-Streaming-Injection](https://github.com/AgoraIO/Advanced-Interactive-Broadcasting/tree/master/Live-Streaming-Injection) demo project on Github.

<a name="api"></a>
### API Reference

- [`addInjectStreamUrl`](./API%20Reference/web/interfaces/agorartc.client.html#addinjectstreamurl)
- [`removeInjectStreamUrl`](./API%20Reference/web/interfaces/agorartc.client.html#removeinjectstreamurl)
- `streamInjectedStatus`

## Considerations
To inject a media stream, the host needs to be in the channel. To receive the injected media stream, the audience needs to subscribe to the host.

