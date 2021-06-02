---
title: Inject Online Media Stream
platform: Windows
updatedAt: 2021-02-23 06:02:14
---
## Introduction

**Injecting an online media stream** is the action of adding an external audio or video stream to an ongoing interactive live streaming channel. It enables the hosts and audience in the channel to hear and see the additional stream while interacting with each other.

### Applicable scenarios

- Live sports: The host and audience can watch and simultaneously comment on events.
- Music concerts, movies, and other entertainments: The hosts and audience can participate in real‑time discussions while watching them.
- Additional perspectives: The host can inject video streams captured by drones or network cameras into a live streaming channel.

### Working principles

The host in an interactive live streaming channel pulls an online media stream and pushes it through the Video Inject Server to the Agora Software‑Defined Real‑time Network (SD‑RTN™) and the channel.

![](https://web-cdn.agora.io/docs-files/1576059890625)

- The host and audience in the channel can hear and see the media stream.
- If the host enables Content Delivery Network (CDN) live streaming, the injected media stream is also pushed to the CDN so that the CDN audience can hear and see the media stream.

>- Only one online media stream can be injected into the same channel at the same time.
>- Supported codec type: AAC for audio, H.264 for video.
>- Audio-only streams are also supported.
>- Only the host can inject and remove an injected media stream. Neither the delegated host nor the audience can do that.


## Implementation

Before proceeding, ensure that you implement a basic live broadcast in your project. See [Start a Live Broadcast](start_live_windows) for details.

> Ensure that you enable the RTMP Converter service before using this function. See [Prerequisites](./cdn_streaming_windows?platform=Windows#prerequisites).

Refer to the following steps to inject an online media stream:

1. The host in a channel calls the `addInjectStreamUrl` method to inject an online media stream to the live broadcast channel. You can modify the parameter values of `config` to set the resolution, bitrate and frame rate of the injected stream. See [InjectStreamConfig](./API%20Reference/cpp/structagora_1_1rtc_1_1_inject_stream_config.html).
	> Only one online media stream can be injected into the same channel at the same time.

	If the method call is successful, SDK triggers the `onUserJoined (uid:666)` callback to all the users in the channel, and triggers the `onStreamInjectedStatus` callback to the local host.
	> The local host can troubleshoot with [API Reference](#api) when exceptions occur.
	
2. The host in a channel calls the `removeInjectStreamUrl` method to remove the injected media stream.
	If the method call is successful, SDK triggers the `onUserOffline (uid:666)` callback to all the users in the channel.
	> Do not need to call the `removeInjectStreamUrl` method if the host has left the channel.


### Sample code

```C++
// C++
// Inject an online media stream.
const char* urlPath = "Some online RTMP/HLS url path";
  InjectStreamConfig config;
  rtcEngine->addInjectStreamUrl(urlPath, config);

// Remove an online media stream.
const char* urlPath = "The same online RTMP/HLS url path added before";
  rtcEngine->removeInjectStreamUrl(urlPath)
```

We also provide an open-source [Live-Streaming-Injection](https://github.com/AgoraIO/Advanced-Interactive-Broadcasting/tree/master/Live-Streaming-Injection) demo project on GitHub.

<a name="api"></a>
### API reference

- [`addInjectStreamUrl`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#a42247db589b55d3cfa98d8e1be06d8e6)
- [`removeInjectStreamUrl`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#aff904ee7a5f0a9741d9cead45249f3cf)
- [`onStreamInjectedStatus`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine_event_handler.html#aa34d75a2d01f4ad5297f79f1b1bf3c1d)
- [`onUserJoined`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a985a675469baf9d54feb8781732e0ca8)
- [`onUserOffline`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a9602593c05a16eafa7c094aa330c0719)

## Considerations
To receive the injected media stream, the audience need to subscribe to the host.
