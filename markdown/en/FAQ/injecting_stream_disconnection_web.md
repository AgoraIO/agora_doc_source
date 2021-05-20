---
title: When injecting online streams to the CDN, what should I do when a disconnection happens?
platform: ["Web"]
updatedAt: 2021-02-26 08:26:51
Products: ["Interactive Broadcast"]
---
<div class="alert note">Agora will soon stop the service for injecting online media streams on the client. If you have not implemented this service, Agora recommends that you do not use it.</div>

[Injecting an online media stream](https://docs.agora.io/en/Interactive%20Broadcast/inject_stream_web?platform=Web) refers to the process where a host injects an external audio or video stream to an ongoing live-broadcast channel.

During the process of injecting online media streams, the SDK connects to the Agora server for pulling external audio or video streams. When the connection is interrupted, the SDK tries to reconnect to the server. If it fails to reconnect, the SDK triggers the `Client.on("inject-streaming-disconnected")` callback to report a disconnection.  

When this event occurs, call [`removeInjectStreamUrl`](https://docs.agora.io/en/Interactive%20Broadcast/API%20Reference/web/interfaces/agorartc.client.html#removeinjectstreamurl) to stop pulling the stream, and then [`addInjectStreamUrl`](https://docs.agora.io/en/Interactive%20Broadcast/API%20Reference/web/interfaces/agorartc.client.html#addinjectstreamurl) to restart the process.
