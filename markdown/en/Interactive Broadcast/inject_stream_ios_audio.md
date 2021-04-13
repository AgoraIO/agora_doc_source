---
title: Inject an Online Media Stream
platform: iOS
updatedAt: 2019-06-26 18:21:59
---
## Introduction

**Injecting an online media stream** refers to injecting an external audio stream to an ongoing live broadcast channel, so that the hosts and audience in the channel can hear the stream while interacting with each other. 

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
- If the media stream is injected successfully, the media stream will appear in the channel, and the `didJoinChannel` and `firstRemoteVideoDecodedOfUid` callbacks will be triggered, in which the `uid` is 666.
- If the media stream is not injected successfully, the SDK may return the following error codes:

  - `AgoraErrorCodeInvalidArgument(2)`: The injected URL does not exist. Call this method again to inject the stream and make sure that the URL is valid.
  - `AgoraErrorCodeNotInitialized(7)`: The SDK is not initialized. Ensure that the `RtcEngine` object is initialized before using this method.
  - `AgoraErrorCodeNotSupported(4)`: The channel profile is not live broadcast. Call the `setChannelProfile` method and set the channel to the live broadcast profile before calling this method.
  - `AgoraErrorCodeNotReady(3)`: The app is not in the channel. Ensure that the app has joined the channel.
## Implementation

To inject an online media stream, the user first joins a live broadcast channel in the "broadcaster" role. For how to initialize the engine and join a live broadcast channel, see [Quickstart Guide](iOS_audio).

- To inject an online media stream:

  The broadcaster (host) in the live broadcast channel can call the `addInjectStreamUrl` method to specify an online media stream and inject it into the channel.

	```swift
	// swift
	// Adds a voice or video stream into an ongoing broadcast.

	let config = AgoraLiveInjectStreamConfig()
	config.size = CGSize(width: 0, height: 0)
	config.videoGop = 0
	config.videoBitrate = 0
	config.videoFramerate = 0
	config.audioSampleRate = 48000
	config.audioBitrate = 48
	config.audioChannels = 1

	agoraKit.addInjectStreamUrl("media stream url", config: config)
	```

	```objective-c
	// objective-c
	AgoraLiveInjectStreamConfig *config = [[AgoraLiveInjectStreamConfig alloc] init];
	config.size = CGSizeMake(0, 0);
	config.videoGop = 0
	config.videoBitrate = 0
	config.videoFramerate = 0
	config.audioSampleRate = 48000
	config.audioBitrate = 48
	config.audioChannels = 1

	[agoraKit addInjectStreamUrl: @"media stream url" config: config];
	```

	You can modify the parameter values of `config` to set the audio sampling rate, audio bitrate and audio channel numbers of the injected stream. For more information, see [Agora Live Inject Stream Config](./API%20Reference/oc/Classes/AgoraLiveInjectStreamConfig.html).
	
- To remove an injected media stream:

	The broadcaster (host) in the live broadcast channel can call the `removeInjectStreamUrl` method to remove a previously injected media stream.

	```swift
	// swift
	let urlPath = "Some online RTMP/HLS url path"
	agoraKit.removeInjectStreamUrl(urlPath)
	```
	
	```
	// objective-c
	NSString *urlPath = @"Some online RTMP/HLS url path";
	[agoraKit removeInjectStreamUrl: urlPath];
	```

	> If the host has left the channel, you do not need to call the `removeInjectStreamUrl` method.

## Working Principles

- The host in a live broadcast channel pulls an online media stream and pushes it to the Agora SD-RTN and live broadcast channel through the Video Inject Server. The host and the audience in the channel can hear the media stream.
- If the host enabled CDN streaming, the injected media stream is also pushed to the CDN so that the CDN audience can hear the media stream.