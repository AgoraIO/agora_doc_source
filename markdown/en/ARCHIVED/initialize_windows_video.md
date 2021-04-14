---
title: Create and Initialize an AgoraRtcEngine Instance
platform: Windows
updatedAt: 2019-10-22 14:19:10
---
Before creating and initializing the client, ensure that you prepared the development environment. See [Integrate the SDK](/en/Video/windows_video).

## Implementation

Create an AgoraRtcEngine instance by invoking <code>create</code>, and initialize the instance by invoking <code>initialize</code>.

Pass the Agora App ID. Only applications with the same App ID can join the same channel.

```
m_lpAgoraObject = new CAgoraObject();
m_lpAgoraEngine = createAgoraRtcEngine();
RtcEngineContext ctx;

ctx.eventHandler = &m_EngineEventHandler;
ctx.appId = lpVendorKey;

m_lpAgoraEngine->initialize(ctx);
```

> Ensure that you call the `create` and `initialize` methods to intiialize the AgoraRtcEngine before calling any other API. 

## Next Steps
You have created the client and can start a video call with the following steps:

- [Join a Channel](/en/Video/join_video_windows)
- [Publish and Subscribe to Streams](/en/Video/publish_windows)

To check the network connection or audio quality before joining a channel, you can refer to the following sections.

- [Conduct a Last Mile Test](/en/Video/lastmile_windows)
- [Set the Stereo/High-fidelity Audio Profile](/en/Video/audio_profile_windows)