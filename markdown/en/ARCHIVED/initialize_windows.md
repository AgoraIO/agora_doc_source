---
title: Create and Initialize an AgoraRtcEngine Instance
platform: Windows
updatedAt: 2018-12-14 07:27:33
---
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