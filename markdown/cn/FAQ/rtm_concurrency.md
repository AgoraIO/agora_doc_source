---
title: 云信令（原实时消息）SDK 对同时在线人数和频道消息发送频率有限制吗？
platform: ["Android","iOS","macOS","Web","Windows","Linux","RESTful"]
updatedAt: 2021-03-02 04:31:11
Products: ["Real-time-Messaging"]
---
云信令（RTM）SDK 对同时在线人数没有限制。但是 Agora 对于单个频道每秒发送的频道消息数量有以下建议：

|单个频道同时在线人数 | 每秒频道消息数量 |
| ------------------------------------|-----------------------------|
|     &lt; 1,000    |         &lt; 200                       |
|    &ge; 1,000  且 &lt; 10,000              |             &lt; 100                           |
|     &ge; 10,000                           |             &lt; 30                                 |

<div class="alert note"><ul><li>如果每秒消息数量超过建议值，延迟会大幅增加，甚至可能导致以下结果：<ul><li>用户无法收发消息。</li><li>用户长期处于 RECONNECTING 状态或在 RECONNECTING 与 CONNECTED 状态间不断切换。在其他用户看来，该用户可能显示为离线状态。</li></ul></li><li>Agora 可以提供定制化服务，在不影响延迟和稳定性的前提下大幅提高每秒消息数量。请<a href="https://agora-ticket.agora.io/?_ga=2.12874551.1450933045.1588731712-73063204.1585890674">提交工单</a>联系技术支持。</li></ul></div>