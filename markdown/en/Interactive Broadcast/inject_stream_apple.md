---
title: Inject Online Media Stream
platform: iOS
updatedAt: 2021-02-23 06:02:07
---
## Introduction

**Injecting an online media stream** refers to injecting an external audio or video stream to an ongoing live broadcast channel, so that the hosts and audience in the channel can hear and see the stream while interacting with each other. 

The Agora SDK v2.1.0+ provides the `addInjectStreamUrl` method for:

- The host to specify a media stream as the input source, inject it into the channel, and push it to the audience.
- The host to set the video profile of the injected video stream.
- Pushing the injected media stream to the CDN audience if the host enables CDN streaming.

### Applicable scenarios

Injecting an online media stream can be applied to the following scenarios:

- During sporting events, by injecting the video stream of an ongoing game. The hosts and audience can watch the game while commenting on it.
- During music shows, movies, and entertainment shows. The hosts and audience can have real-time discussions and exchange ideas while watching the show.
- Video streams captured by drones or network cameras can be injected into a live broadcast and broadcasted to the audience in the channel.

###  Working principles

The host in a live broadcast channel pulls an online media stream and pushes it to the Agora SD-RTN and live broadcast channel through the Video Inject Server. 

![](https://web-cdn.agora.io/docs-files/1569414380425)


- The host and audience in the channel can hear/see the media stream.
- If the host enabled CDN streaming, the injected media stream is also pushed to the CDN so that the CDN audience can hear/see the media stream.

> - Supported media stream formats include: RTMP, HLS and FLV. Audio-only streams can also be injected.
> - Only the host (broadcaster) can inject and remove an injected media stream. Neither the delegated host nor the audience can do that.



## Implementation

Before proceeding, ensure that you implement a basic live broadcast in your project. See [Start a Live Broadcast](start_live_ios) for details.

Refer to the following steps to inject an online media stream:

1. The host in a channel calls the `addInjectStreamUrl` method to inject an online media stream to the live broadcast channel. You can modify the parameter values of `config` to set the resolution, bitrate and frame rate of the injected stream. See [`AgoraInjectStreamConfig`](./API%20Reference/oc/Classes/AgoraLiveInjectStreamConfig.html).
	> Only one online media stream can be injected into the same channel at the same time.

	If the method call is successful, SDK triggers the `didJoinedOfUid (uid:666)` callback to all the users in the channel, and triggers the `streamInjectedStatusOfUrl` callback to the local host.
	> The local host can troubleshoot with [API Reference](#api) when exceptions occur.
	
2. The host in a channel calls the `removeInjectStreamUrl` method to remove the injected media stream.
	If the method call is successful, SDK triggers the `didOfflineOfUid (uid:666)` callback to all the users in the channel.
	> Do not need to call the `removeInjectStreamUrl` method if the host has left the channel.


### Sample code


```swift
// Swift
// Inject an online media stream.
let config = AgoraLiveInjectStreamConfig()
  config.size = CGSize(width: 640, height: 360)
  config.videoGop = 30
  config.videoBitrate = 400
  config.videoFramerate = 15
  config.audioSampleRate = 48000
  config.audioBitrate = 48
  config.audioChannels = 1

  agoraKit.addInjectStreamUrl("media stream url", config: config)

// Remove an online media stream.
let urlPath = "Some online RTMP/HLS url path"
  agoraKit.removeInjectStreamUrl(urlPath)
```

```objective-c
// Objective-C
// Inject an online media stream.
AgoraLiveInjectStreamConfig *config = [[AgoraLiveInjectStreamConfig alloc] init];
  config.size = CGSizeMake(640, 360);
  config.videoGop = 30
  config.videoBitrate = 400
  config.videoFramerate = 15
  config.audioSampleRate = 48000
  config.audioBitrate = 48
  config.audioChannels = 1

  [agoraKit addInjectStreamUrl: @"media stream url" config: config];

// Remove an online media stream.
NSString *urlPath = @"Some online  RTMP/HLS url path";
  [agoraKit removeInjectStreamUrl: urlPath];
```

We also provide an open-source [Live-Streaming-Injection](https://github.com/AgoraIO/Advanced-Interactive-Broadcasting/tree/master/Live-Streaming-Injection) demo project on Github.

<a name="api"></a>
### API reference

- [`addInjectStreamUrl`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/addInjectStreamUrl:config:)
- [`removeInjectStreamUrl`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/removeInjectStreamUrl:)
- [`streamInjectedStatusOfUrl`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:streamInjectedStatusOfUrl:uid:status:)
- [`didJoinedOfUid`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:didJoinedOfUid:elapsed:)
- [`didOfflineOfUid`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:didOfflineOfUid:reason:)

## Considerations
To inject a media stream, the host needs to be in the channel. To receive the injected media stream, the audience needs to subscribe to the host.