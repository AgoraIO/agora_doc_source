---
title: UDP
platform: All Platforms
updatedAt: 2020-09-30 16:53:03
---

UDP（User Datagram Protocol），即用户数据报协议，是一种面向无连接的、不可靠的传输层通信协议。

面向无连接是指在传输数据之前发送端和接收端无需建立连接。UDP 不需要握手，想发送数据就可以发送，只会给数据增加一个 UDP 头进行标识。

与 TCP 不同，UDP 并不关心数据是否成功送达。因此在网络质量不好时，可能会出现数据的丢失或乱序。

UDP 既支持一对一的传输，也支持一对多和多对多的传输。

UDP 具有较好的实时性，适用于实时音视频场景。Agora SD-RTN™ 使用的就是基于 UDP 的私有协议。

<div class="alert info">相关链接：
	<li><a href="./sd_rtn">SD-RTN™</a></li>
	<li><a href="./tcp">TCP</a></li>
	<li><a href="https://www.bilibili.com/video/BV1ET4y1u7Pq">你知道吗？每次上网，都是一场大型协议互签会</a></li>
</div>

<a href="./terms"><button>返回术语库</button></a>
