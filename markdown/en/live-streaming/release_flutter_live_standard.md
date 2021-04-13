---
title: Release Notes
platform: Flutter
updatedAt: 2020-12-23 03:48:22
---
## v3.2.1

v3.2.1 was released on December 23, 2020. This is the first release of Agora Interactive Live Streaming Standard.

The major difference between Agora Interactive Live Streaming Standard and Agora Live Interactive Streaming Premium is the latency level on the audience's client:

- Interactive Live Streaming Standard: Low latency (1500 ms - 2000 ms) from the host's client to the audience's client.
- Interactive Live Streaming Premium: Ultra-low latency (400 ms - 800 ms) from the host's client to the audience's client.

The charges for Standard and Premium are different. For details, see the [product overview](/en/live-streaming/product_live_standard) of Interactive Live Streaming Standard.

Call the [`setClientRole`](./API%20Reference/flutter/rtc_channel/RtcChannel/setClientRole.html) method in this release to set the user role as audience and the latency level as low latency to use Interactive Live Streaming Standard.