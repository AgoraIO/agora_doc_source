---
title: 连麦 (co-hosting)
platform: All Platforms
updatedAt: 2020-11-12 08:13:13
---

连麦指在直播场景中，两个及以上主播进行互动的过程。频道内的观众可以看到这些主播并听到他们的声音。

有以下两种情况：

- 一个频道内，两个及以上主播进行连麦互动。既可以是多个主播加入同一频道；也可以是频道内的观众申请上麦，切换用户角色成为连麦主播，与原有的主播进行互动。
- 两个及以上频道内的主播进行连麦互动。Agora RTC SDK 支持将某一频道中主播的媒体流转发至多个其他频道中，实现跨频道连麦。具体实现方式参见跨直播间连麦。

一个频道同一时间连麦主播的数量限制，详见 [Agora RTC SDK 最多支持多少人同时在线](https://docs.agora.io/cn/faqs/capacity)。如果连麦主播数量过多时，可能会出现音画不同步和信息丢失的问题，建议参考[七人以上视频场景](https://docs.agora.io/cn/Interactive%20Broadcast/multi_user_video)来保证通信质量。

<div class="alert info">相关链接：
<li><a href="#become-host">上麦</a></li>
<li><a href="#become-audience">下麦</a></li>
<li><a href="#channel_prpofile">频道场景</a></li>
<li><a href="#host">主播</a></li>
<li><a href="#audience">观众</a></li>
</div>

<a href="./terms"><button>返回术语库</button></a>
