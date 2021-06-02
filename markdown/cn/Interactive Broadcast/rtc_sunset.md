---
title: 部分服务下架计划
platform: Android
updatedAt: 2021-01-18 08:55:41
---
本文提供 Agora 产品的下架计划，请及时更替或升级你的解决方案。

## 输入在线媒体流

### 停服计划

<div class="alert info">客户端输入在线媒体流服务指使用 Agora RTC SDK 并调用 <code>addInjectStreamUrl</code> 等相关方法将一路在线媒体流作为直播音视频源输入到 Agora 频道内。</div>

自 2021 年 1 月 15 日起，Agora 启动对[客户端输入在线媒体流服务](https://docs.agora.io/cn/Interactive%20Broadcast/inject_stream_android?platform=Android)的停服流程。具体计划如下：

- 2021 年 1 月 15 日及之后，Agora 不再接受对客户端输入在线媒体流服务的功能新增申请和问题修复申请。
- 2021 年 7 月 15 日及之后，Agora 正式停止提供客户端输入在线媒体流服务。

请在 2021 年 7 月 15 日之前更替使用到客户端输入在线媒体流服务的解决方案。

### 更替方案

Agora 提供服务端输入在线媒体流服务，支持你通过 RESTful API 将一路在线媒体流作为直播音视频源输入到 Agora 频道内。如果你希望从客户端输入在线媒体流服务更替到服务端输入在线媒体流服务，请[联系我们](https://agora-ticket.agora.io)获取文档和技术支持。

## CDN 推流

### 退休计划

#### CDN 推流（1.0）

<div class="alert info">CDN 推流服务（1.0）指通过如下方式开启的推流服务：主播加入 Agora 频道时，通过 <code>optionalInfo</code>/<code>info</code> 参数发送推流转码信息，使得 Agora 推流服务器将主播在频道内的流转码为 RTMP 协议的流并推送至 CDN。CDN 推流服务（1.0）与你使用的 SDK 版本无关。</div>

自 2021 年 1 月 15 日起，Agora 启动对 CDN 推流服务（1.0）的退休流程。2021 年 4 月 15 日及之后，Agora 正式停止提供 CDN 推流服务（1.0）。

请在 2021 年 4 月 15 日之前升级使用 CDN 推流（1.0）的解决方案。

#### CDN 推流（2.0）

<div class="alert info">CDN 推流服务（2.0）指通过如下任意一种方式开启的推流服务：
<li>使用 v2.4.0 及之前的 Agora RTC SDK（Native、第三方框架），并调用 <code>addPublishStreamUrl</code> 等相关方法。</li>
<li>使用 v2.8.0 及之前的 Agora RTC SDK（Web），并调用 <code>startLiveStreaming</code> 等相关方法。</li></div>

自 2021 年 1 月 15 日起，Agora 启动对 CDN 推流服务（2.0）的退休流程。具体计划如下：

- 2021 年 1 月 15 日及之后，Agora 不再接受对 CDN 推流服务（2.0）的功能新增申请。
- 2021 年 7 月 15 日及之后，Agora 不再接受对 CDN 推流服务（2.0）的问题修复申请。
- 2022 年 1 月 15 日及之后，Agora 正式停止提供 CDN 推流服务（2.0）。

请在 2022 年 1 月 15 日之前升级使用 CDN 推流（2.0）的解决方案。

### 升级方案

<div class="alert info">CDN 推流服务（3.0）指通过如下任意一种方式开启的推流服务：
<li>使用 v2.4.1 或之后的 Agora RTC SDK（Native、第三方框架），并调用 <code>addPublishStreamUrl</code> 等相关方法。</li>
<li>使用 v2.9.0 或之后的 Agora RTC SDK（Web），并调用 <code>startLiveStreaming</code> 等相关方法。</li></div>

请在 2021 年 4 月 15 日之前，将 CDN 推流（1.0）升级到 CDN 推流（3.0）；请在 2022 年 1 月 15 日之前，将 CDN 推流（2.0）升级到 CDN 推流（3.0）。升级方式如下：

- 如果你使用 Agora RTC SDK（Native、第三方框架），请将 SDK 升级至 v2.4.1 或之后。
- 如果你使用 Agora RTC SDK（Web），请将 SDK 升级至 v2.9.0 或之后。

请在升级前阅读[推流到 CDN](https://docs.agora.io/cn/Interactive%20Broadcast/cdn_streaming_android?platform=Android) 文档，并在升级后进行相关测试验证。

如果你遇到问题，请及时[联系我们](https://agora-ticket.agora.io)。