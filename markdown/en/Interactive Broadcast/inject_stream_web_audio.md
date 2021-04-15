---
title: Inject an Online Media Stream
platform: Web
updatedAt: 2020-12-30 09:01:00
---
## Introduction

**Injecting an online media stream** refers to injecting an external audio or video stream to an ongoing live broadcast channel, so that the hosts and audience in the channel can hear and see the stream while interacting with each other. 

The Agora Web SDK v2.5.1+ provides the `Client.addInjectStreamUrl` method for:

- The host to specify a media stream as the input source, inject it into the channel, and push it to the audience.
- Pushing the injected media stream to the CDN audience if the host enables CDN streaming.

## Applicable Scenarios

Injecting an online media stream can be applied to the following scenarios:

- During music shows, movies, and entertainment shows. The hosts and audience can have real-time discussions and exchange ideas while watching the show.


## Considerations

- Only one online media stream can be injected into the same channel at the same time.
- Only the host (broadcaster) can inject and remove an injected media stream. Neither the delegated host nor the audience can do that.
- To inject a media stream, the host needs to be in the channel. To receive the injected media stream, the audience needs to subscribe to the host.
- Supported media stream formats include: RTMP, HLS, and FLV. Audio-only streams can also be injected.
- If the media stream is injected successfully, the media stream will appear in the channel, and the `peer-online` and `first-audio-frame-decode` callbacks will be triggered, in which the `uid` is 666.
- If the media stream is not injected successfully, the SDK may return the following error codes:

  - 2: The injected URL does not exist. Call this method again to inject the stream and ensure that the URL is valid.
  - 7: The SDK is not initialized. Ensure that the Client object is initialized before using this method.
  - 3: The app is not in the channel. Ensure that the app has joined the channel.


## Implementation

To inject an online media stream, the user first joins a live broadcast channel in the "broadcaster" role. For how to initialize the engine and join a live broadcast channel, see [Quickstart Guide](./web_prepare).

- To inject an online media stream:

	The broadcaster (host) in the live broadcast channel can call the `addInjectStreamUrl` method to specify an online media stream and inject it into the channel.

	```javascript
	var InjectStreamConfig = {
	 width: 0,
	 height: 0,
	 videoGop: 0,
	 videoFramerate: 0,
	 videoBitrate: 0,
	 audioSampleRate: 44100,
	 audioChannels: 1,
	});
	
	Client.addInjectStreamUrl(url, config);
	```

	You can modify the parameter values of `config` to set the resolution, bitrate, frame rate, and audio sampling rate of the injected stream. For more information, see [InjectStreamConfig](./API%20Reference/web/interfaces/agorartc.injectstreamconfig.html).
	
- To remove an injected media stream:

	The broadcaster (host) in the live broadcast channel can call the `removeInjectStreamUrl` method to remove a previously injected media stream.

	```javascript
	Client.removeInjectStreamUrl(url);
	```

	> If the host has left the channel, you do not need to call the `removeInjectStreamUrl` method.

## Working Principles

- The host in a live broadcast channel pulls an online media stream, pushes it to the Agora SD-RTN and live broadcast channel through the Video Inject Server. The host and the audience in the channel can hear/see the media stream.
- If the host enabled CDN streaming, the injected media stream is also pushed to the CDN so that the CDN audience can hear/see the media stream.