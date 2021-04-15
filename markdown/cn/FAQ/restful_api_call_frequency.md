---
title: 如何处理服务端 RESTful API 调用超出频率限制?
platform: ["RESTful"]
updatedAt: 2020-11-06 10:33:19
Products: ["Voice","Video","Interactive Broadcast","live-streaming"]
---
当一个服务端 RESTful API 调用超出频率限制时，会返回状态码 429，表示请求过于频繁。你可以结合业务实际并发需求，参考以下建议，优化 API 调用频率。

## 调用频率优化建议
- 将 API 请求均匀地分布到各时间窗口。
例如，要调用 [`https://api.agora.io/dev/v1/channel/user/{appid}/{channelName}`](https://docs.agora.io/cn/rtc/restfulapi/#/%E6%9F%A5%E8%AF%A2%E5%9C%A8%E7%BA%BF%E9%A2%91%E9%81%93%E4%BF%A1%E6%81%AF/userList) 查询 100 个在线频道的用户列表，该 API 默认的调用频率上限为每秒 20 次。为避免超出调用上限，你可以将单个频道的查询间隔设置为 5 秒，每秒查询 20 个频道的用户列表。
- 不要在你的客户端直接调用 Agora 的服务端 RESTful API，而要在你的应用服务器上调用 Agora 的服务端 RESTful API。
例如，使用查询在线频道信息 API 时，可以由你的应用服务器定期向 Agora 发送请求并缓存返回结果，当有客户端需要查询频道信息时，由你的服务器向客户端下发本地缓存的最新数据。

在参考上述建议后，如果默认的 API 调用频率上限仍然无法满足你的实际业务需求，你可以提交工单申请调整调用频率限制。详见<a href="#raiselimit">申请提高 RESTful API 调用频率</a>。

<div class="alert note">Agora 的服务端 RESTful API 调用频率有上限，且无法保障高度实时性。在业务并发量很大的情况下，你可以申请开通 <a href="https://docs-preview.agoralab.co/cn/Agora%20Platform/ncs">Agora 消息服务通知</a >并配置业务服务器接收<a href="https://docs-preview.agoralab.co/cn/Agora%20Platform/rtc_eventtype?platform=All%20Platforms#实时通信">实时通信事件</a >。</div>

## 申请提高 RESTful API 调用频率<a name="raiselimit"></a>
你需要[提交工单](https://agora-ticket.agora.io/)申请提高服务端 RESTful API 的调用频率，并提供以下信息：
- 所属行业，如教育、泛娱乐、医疗或其他。
- 应用场景，如语聊房、小班课、PK 连麦或其他。
- 平均频道数量和最大并发频道数量。
- 频道内平均同时在线人数和峰值在线人数。
- 哪个 RESTful API 不满足你的业务需求，以及该 API 的使用方法和应用场景。