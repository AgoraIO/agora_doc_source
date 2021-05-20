---
title: 抖动 (jitter)
platform: All Platforms
updatedAt: 2020-07-03 18:13:53
---
实时音视频通信中，连续传输的数据包之间的延时不一致称为抖动。

抖动可能由网络上的许多因素引起，其中最主要是由于分组交换网络无法确保所有的数据包都经由相同的传输路径。

抖动会导致丢包和网络拥塞，对终端用户来说，可能造成视频画面像素化，影响用户体验。

[Agora RTC SDK](https://docs.agora.io/cn/Agora%20Platform/terms?platform=All%20Platforms#agora-rtc-sdk) 提供 API 帮助开发者在通话前进行网络质量探测，反馈上下行网络的抖动情况。

<div class="alert info">相关链接：<li><a href="https://docs.agora.io/cn/Agora%20Platform/terms?platform=All%20Platforms#packet-loss">丢包</a></li><li><a href="https://docs.agora.io/cn/Agora%20Platform/terms?platform=All%20Platforms#delay">延时</a></li>
</div>

<a href="./terms"><button>返回术语库</button></a>