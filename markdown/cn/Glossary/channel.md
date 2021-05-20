---
title: 频道 (channel)
platform: All Platforms
updatedAt: 2020-07-03 18:27:35
---
频道是由开发者调用 Agora 提供的 API 创建的用于传输实时数据的通道。

根据实时传输数据的类型，Agora 的频道又分为 RTC 频道和 RTM 频道。其中，RTC 频道传输音视频数据，RTM 频道传输消息及信令数据。RTC 频道与 RTM 频道互相独立。

声网组件（本地录制、云端录制等）也可以加入 RTC 频道，实现录制、传输加速、媒体播放、内容安全等功能。

App ID 一致的前提下，Agora 使用频道名来标识频道。使用相同频道名的用户，可以进入同一个频道进行互动。最后一个用户离开频道时，频道自动消失。

为保证通信安全，用户在加入频道时，通常还需要提供一个动态密钥进行鉴权。动态密钥如果失效，用户会无法使用 Agora 的服务，可能的表现为：正在进行的通话被强制终止，或者被踢出频道。

<div class="alert info">相关链接：
<li><a href="https://docs.agora.io/cn/Agora%20Platform/token">校验用户权限</a></li>
<li><a href="#agora-rtc-sdk">Agora RTC SDK</a></li>
<li><a href="#agora-rtm-sdk">Agora RTM SDK</a></li>	
</div>

<a href="./terms"><button>返回术语库</button></a>