---
title: Release Notes
platform: iOS
updatedAt: 2020-12-17 04:09:27
---
## v3.2.0
v3.2.0 was released on November 9, 2020. This is the first release of Agora Interactive Live Streaming Standard.

The major difference between Agora Interactive Live Streaming Standard and Agora Live Interactive Streaming Premium is the latency level on the audience's client:

- Interactive Live Streaming Standard: Low latency (1500 ms - 2000 ms) from the host's client to the audience's client.
- Interactive Live Streaming Premium: Ultra-low latency (400 ms - 800 ms) from the host's client to the audience's client.

The charges for Standard and Premium are different. For details, see the [product overview](/en/live-streaming/product_live_standard) of Interactive Live Streaming Standard.

Call the [`setClientRole`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setClientRole:options:) method in this release to set the user role as audience and the latency level as low latency to use Interactive Live Streaming Standard.