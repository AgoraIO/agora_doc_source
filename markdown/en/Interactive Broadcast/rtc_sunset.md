---
title: Service Sunset Plans
platform: Android
updatedAt: 2021-02-20 06:22:26
---
This article provides sunset plans for some Agora services. You should prepare to replace or upgrade affected solutions in a timely fashion to avoid service disruptions.


## CDN live streaming

### Retirement plans

#### CDN live streaming (1.0)

<div class="alert info">The service for CDN live streaming (1.0) refers to the streaming service enabled by the following method: When a host joins an Agora channel, you use the <code>optionalInfo</code>/<code>info</code> parameter to send the transcoding information, enabling the Agora streaming server to transcode the hosts' streams in the channel into a stream in the RTMP protocol and push the stream to the CDN. The CDN live streaming (1.0) is independent of the SDK version used.</div>

As of January 15, 2021, Agora initiates the retirement process for the service for CDN live streaming (1.0). As of April 15, 2021, Agora officially discontinues the service for CDN live streaming (1.0).

Please upgrade your solution that uses the service for CDN live streaming (1.0) before April 15, 2021.

#### CDN live streaming (2.0)

<div class="alert info">The service for CDN live streaming (2.0) refers to the streaming service enabled by any of the following methods:<li>Using the Agora RTC SDK (Native, third-party framework) v2.4.0 or earlier and calling the <code>addPublishStreamUrl</code> or other related methods.</li><li>Using the Agora RTC SDK (Web) v2.8.0 or earlier and calling the <code>startLiveStreaming</code> or other related methods.</li></div>

As of January 15, 2021, Agora initiates the retirement process for the service for CDN live streaming (2.0). The specific plan is as follows:

- As of January 15, 2021, Agora no longer accepts requests for new features to the service for CDN live streaming (2.0).
- As of July 15, 2021, Agora no longer accepts requests for bug fixes to the service for CDN live streaming (2.0).
- As of January 15, 2022, Agora officially discontinues the service for CDN live streaming (2.0).

Please upgrade your solution that uses the service for CDN live streaming (2.0) before January 15, 2022.

### Upgrade solutions

<div class="alert info">The service for CDN live streaming (3.0) refers to the streaming service enabled by any of the following methods:<li>Using the Agora RTC SDK (Native, third-party framework) v2.4.1 or later and calling the <code>addPublishStreamUrl</code> or other related methods.</li><li>Using the Agora RTC SDK (Web) v2.9.0 or later and calling the <code>startLiveStreaming</code> or other related methods.</li></div>

Please upgrade CDN live streaming (1.0) to CDN live streaming (3.0) before April 15, 2021; please upgrade CDN live streaming (2.0) to CDN live streaming (3.0) before January 15, 2022. The upgrade methods for either CDN live streaming (1.0) or CDN live streaming (2.0) are as follows:

- If you use the Agora RTC SDK (Native, third-party framework), please upgrade the SDK to v2.4.1 or later.
- If you use the Agora RTC SDK (Web), please upgrade the SDK to v2.9.0 or later.

Please read [Push Streams to CDN](https://docs.agora.io/en/Interactive%20Broadcast/cdn_streaming_android?platform=Android) before upgrading, and perform relevant tests to verify after upgrading.

If you encounter any problems, please do not hesitate to [contact us](mailto:support@agora.io).