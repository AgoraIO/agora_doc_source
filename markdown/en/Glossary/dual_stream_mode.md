---
title: dual-stream mode
platform: All Platforms
updatedAt: 2020-11-05 16:01:58
---
In the dual-stream mode, the SDK transmits a high-quality and a low-quality video stream from the sender. The high-quality video stream has a higher resolution and bitrate, and the low-quality video stream has a lower resolution and bitrate.

Subscribing to low-quality streams improves communication continuity because this reduces bandwidth consumption. Developers can choose to receive low-quality video streams when network condition are unreliable, or when multiple users publish streams.

The SDK sets the default video profile of the low-quality video stream based on that of the high-quality video stream.

<div class="alert info">Reference:<li><a href="https://docs.agora.io/en/Interactive%20Broadcast/multi_user_video_android?platform=Android">Video for 7+ Users</a></li>
<li><a href="./terms#fallback">Stream fallback</a></li>
<li><a href="./terms#high-stream">High-quality video stream</a></li>
<li><a href="./terms#low-stream">Low-quality video stream</a></li>
</div>

<a href="./terms"><button>Back to glossary</button></a>