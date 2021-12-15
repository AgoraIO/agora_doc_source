---
title: 推流到 CDN (Push streams to CDN)
platform: All Platforms
updatedAt: 2020-07-03 19:15:12
---

推流到 CDN（Content Delivery Network）指 Agora 服务器将 RTC 频道内的流由 Agora 私有协议转换为标准协议，然后推到第三方 CDN。推流到 CDN 也称“旁路推流”或“CDN 直播推流”。将主播的流推到第三方 CDN 后，除了频道内观众，CDN 观众也可以观看直播。推流到 CDN 可以丰富直播视频的分发渠道，利于推广直播视频。

多人连麦直播时，推流到 CDN 需要开启转码功能，将多路流合并为一路流。CDN 观众通过该路流的 CDN 地址（URL）即可观看连麦直播。

<div class="alert note">Agora 建议单人直播时不开启转码功能。</div>

<div class="alert info">相关链接：
    <li><a href="https://docs.agora.io/cn/Interactive%20Broadcast/cdn_streaming_android?platform=Android">推流到 CDN</a></li>
    <li><a href="./transcoding">转码</a></li>
    <li><a href="./channel">频道</a></li>
</div>

<a href="./terms"><button>返回术语库</button></a>
