---
title: Agora 与一般的 CDN + RTMP 直播技术有何不同？
platform: ["All Platforms"]
updatedAt: 2020-07-09 21:39:09
Products: ["Interactive Broadcast"]
---
CDN + RTMP 的直播技术使得观众在网页端就能观看直播，极大降低了观众的门槛。

有别于市面上最常见的 CDN + RTMP 直播技术，声网提供的直播方案使用了以下技术，使 [Agora SD-RTN™](https://docs-preview.agoralab.co/cn/Agora%20Platform/terms?platform=All%20Platforms#sd-rtn™)、主播端以及高级观众（嘉宾）端之间的实时通讯质量达到专线级别：
- 私有音视频编码
- 私有传输协议
- 私有节点部署
- 私有传输算法

具体比较可参考下表：

| 技术       | 常见的 CDN + RTMP 直播 | Agora 直播                          |
| :--------- | :------------------- | :---------------------------------- |
| 视频编解码 | H.264                | 私有                                |
| 语音编解码 | AAC                  | 私有                                |
| 传输协议   | 基于 RTMP 的 TCP     | 基于 UDP 的私有协议 |
| 传输算法   | TCP                  | Agora 私有丢包对抗、带宽自适应      |
| 合图布局   | 固定                 | 可动态调整                          |

此外，为了满足各类厂商多样的直播需求，声网也与多家 CDN 进行对接，支持[推流到 CDN](https://docs.agora.io/cn/Interactive%20Broadcast/cdn_streaming_android?platform=Android)，在社交平台上分享直播内容。