---
title: Release Notes
platform: Android
updatedAt: 2020-12-17 04:08:37
---
## v3.2.0
v3.2.0 was released on November 1, 2020. This is the first release of Agora Interactive Live Streaming Standard.

The major difference between Agora Interactive Live Streaming Standard and Agora Live Interactive Streaming Premium is the latency level on the audience's client:

- Interactive Live Streaming Standard enables low latency (1500 ms - 2000 ms) from the host's client to the audience's client.
- Interactive Live Streaming Premium enables ultra-low latency (400 ms - 800 ms) from the host's client to the audience's client.

The charges for Standard and Premium are different. For details, see the product overview of Interactive Live Streaming Standard.

Call the `setClientRole` method in this release to set the user role as audience and the user level as low latency for live streaming scenarios featuring “light interaction”.