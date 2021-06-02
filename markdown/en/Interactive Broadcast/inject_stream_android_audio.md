---
title: Inject an Online Media Stream
platform: Android
updatedAt: 2019-06-26 18:21:33
---
## Introduction

**Injecting an online media stream** refers to injecting an external audio to an ongoing live broadcast channel, so that the hosts and audience in the channel can hear the stream while interacting with each other. 

The Agora SDK v2.1.0+ provides the `addInjectStreamUrl` method for:

- The host to specify a media stream as the input source, inject it into the channel, and push it to the audience.
- Pushing the injected media stream to the CDN audience if the host enables CDN streaming.

## Applicable Scenarios

Injecting an online media stream can be applied to the following scenarios:

- During music shows, the hosts and audience can have real-time discussions and exchange ideas while enjoying the show.

## Considerations

- In audio broadcasting, you can only inject a pure audio stream. You cannot inject the audio of a video stream.
- Only one online media stream can be injected into the same channel at the same time.
- Only the host (broadcaster) can inject and remove an injected media stream. Neither the delegated host nor the audience can do that.
- To inject a media stream, the host needs to be in the channel. To receive the injected media stream, the audience needs to subscribe to the host.
- Supported media stream formats include: RTMP, HLS, and FLV. 
- If the media stream is injected successfully, the media stream will appear in the channel, and the `onUserJoined` and `onFirstRemoteVideoDecoded` callbacks will be triggered, in which the `uid` is 666.
- If the media stream is not injected successfully, the SDK may return the following error codes:

  - `ERR_INVALID_ARGUMENT(2)`: The injected URL does not exist. Call this method again to inject the stream and ensure that the URL is valid.
  - `ERR_NOT_INITIALIZED(7)`: The SDK is not initialized. Ensure that the `RtcEngine` object is initialized before using this method.
  - `ERR_NOT_SUPPORTED(4)`: The channel profile is not live broadcast. Call `setChannelProfile` and set the channel to the live broadcast profile before calling this method.
  - `ERR_NOT_READY(3)`: The app is not in the channel. Ensure that the app has joined the channel.


## Implementation

To inject an online media stream, the user first joins a live broadcast channel in the "broadcaster" role. For how to initialize the engine and join a live broadcast channel, see [Quickstart Guide](android_audio).

- To inject an online media stream:

	The broadcaster (host) in the live broadcast channel can call the `addInjectStreamUrl` method to specify an online media stream and inject it into the channel.

	```java
	// java
	String urlPath = "Some online RTMP/HLS url path"

	LiveInjectStreamConfig config = new LiveInjectStreamConfig();
	config.width = 0;
	config.height = 0;
	config.videoGop = 0;
	config.videoFramerate = 0;
	config.videoBitrate = 0;
	config.audioSampleRate = LiveInjectStreamConfig.AudioSampleRateType.TYPE_44100;        config.audioBitrate = 48;
	config.audioChannels = 1;

	rtcEngine.addInjectStreamUrl(urlPath, config);
	```

	You can modify the parameter values of `config` to set the audio sampling rate, audio bitrate and audio channel numbers of the injected stream. For more information, see [Agora Live Inject Stream Config](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1live_1_1_live_inject_stream_config.html).
	
- To remove an injected media stream:

	The broadcaster (host) in the live broadcast channel can call the `removeInjectStreamUrl` method to remove a previously injected media stream.

	```java
	// java
	String urlPath = "The same online RTMP/HLS url path added before"
	rtcEngine.removeInjectStreamUrl(urlPath)
	```

	> If the host has left the channel, you do not need to call the `removeInjectStreamUrl` method.

## Working Principles

- The host in a live broadcast channel pulls an online media stream, pushes it to the Agora SD-RTN and live broadcast channel through the Video Inject Server. The host and the audience in the channel can hear the media stream.
- If the host enabled CDN streaming, the injected media stream is also pushed to the CDN so that the CDN audience can hear/see the media stream.