---
title: 丢包
platform: All Platforms
updatedAt: 2020-07-03 18:13:48
---
丢包是指数据传输过程中发生的数据包丢失现象。

丢包通常由网络拥塞、传输设备性能限制、硬件故障、网络设备上的软件出错等原因造成。

在实时音视频通信中，轻微的丢包通常不会影响终端用户的体验，但是丢包率过高可能会对音视频质量产生影响。丢包对音频的影响包括音频失真、断断续续、间歇性噪音等，对视频的影响包括视频卡顿、图像模糊等。

声网致力于通过 FEC、重传恢复等抗丢包技术，提升终端用户的实时音视频体验。[Agora RTC SDK](https://docs.agora.io/cn/Agora%20Platform/terms?platform=All%20Platforms#agora-rtc-sdk) 会通过回调报告实时通信过程中音频数据和视频数据的丢包率，方便开发者了解当前的传输质量，进行问题排查。开发者也可以通过声网开发者工具[水晶球](https://docs.agora.io/cn/Agora%20Platform/terms?platform=All%20Platforms#agora-analytics)了解丢包率。

<div class="alert info">相关链接：<li><a href="https://docs.agora.io/cn/Agora%20Platform/terms?platform=All%20Platforms#jitter">抖动</a></li><li><a href="https://docs.agora.io/cn/Agora%20Platform/terms?platform=All%20Platforms#delay">延时</a></li>
</div>

<a href="./terms"><button>返回术语库</button></a>