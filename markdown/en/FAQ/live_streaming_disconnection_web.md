---
title: When pushing streams to the CDN, what should I do when a disconnection happens?
platform: ["Web"]
updatedAt: 2020-12-23 08:12:33
Products: ["Interactive Broadcast"]
---
<div class="alert note">This article only applies to the Agora Web SDK 3.x and earlier versions.</div>

[Pushing streams to the CDN](https://docs.agora.io/en/Interactive%20Broadcast/cdn_streaming_web?platform=Web) refers to the process where a host publishes multiple media streams to the CDN (Content Delivery Network).

During pushing streams, the SDK connects to the dedicated Agora server for pushing streams. When the connection is interrupted, the SDK tries to reconnect to the server to continue pushing streams. If it fails to reconnect, the SDK triggers a callback to report a disconnection.

Based on [live transcoding setting](https://docs.agora.io/en/Interactive%20Broadcast/API%20Reference/web/interfaces/agorartc.client.html#startlivestreaming), the SDK connects to different servers for pushing streams and triggers different callbacks after disconnection.

| `enableTranscoding` | Callback triggered when a disconnection happens                        |
| -------- | ----------------------------------------- |
| `true`     | `Client.on("mix-streaming-disconnected")` |
| `false`   | `Client.on("raw-streaming-disconnected")` |

When either of the previously-mentioned events occurs, call [`stopLiveStreaming`](https://docs.agora.io/en/Interactive%20Broadcast/API%20Reference/web/interfaces/agorartc.client.html#stoplivestreaming) to stop pushing all streams, and then [`startLiveStreaming`](https://docs.agora.io/en/Interactive%20Broadcast/API%20Reference/web/interfaces/agorartc.client.html#startlivestreaming) to restart the process.
