---
title: 学生端实现
platform: iOS
updatedAt: 2020-11-02 11:55:56
---
本文展示如何在 Web 平台实现学生端相关功能。

## 集成指引

根据下表链接，下载对应的 SDK，参考集成文档的步骤将 SDK 集成到你的项目中。


| 产品 | SDK 下载 | 集成文档 |
| ---------------- | ---------------- | ---------------- | 
| [Agora RTC (Real-time Communication) SDK](https://docs.agora.io/cn/Interactive%20Broadcast/product_live?platform=All%20Platforms)      | [ Web 视频互动直播 SDK](https://docs.agora.io/cn/Interactive%20Broadcast/downloads)      | [实现互动直播](https://docs.agora.io/cn/Interactive%20Broadcast/start_live_web?platform=Web) |
| [RTM (Real-time Messaging) SDK](https://docs.agora.io/cn/Real-time-Messaging/product_rtm?platform=All%20Platforms) | [Web 实时消息 SDK](https://docs.agora.io/cn/Real-time-Messaging/downloads) | [收发点对点消息和频道消息](https://docs.agora.io/cn/Real-time-Messaging/messaging_web?platform=Web) |
| Agora 教育云服务 | N/A | [教育云服务 API 文档](https://agoradoc.github.io/cn/edu-cloud-service/restfulapi) |
| [白板](https://developer.netless.link/docs/javascript/overview/js-outline/) | [SDK 集成](https://developer.netless.link/docs/javascript/guide/js-sdk/) | [白板快速开始](https://developer.netless.link/javascript-zh/home/install) |


## 核心 API 时序图

参考下图了解学生端实现的基础流程和 API 调用。

<div class="alert info">教育 SDK 是基于 Agora RTC SDK、Agora RTM SDK 和 Agora 教育云服务封装的场景化 SDK，API 设计与实际业务场景更贴近、更易用。教育 SDK 当前处于内部测试体验阶段。</div>

![](https://web-cdn.agora.io/docs-files/1604055199106)

## 附加功能

除基础的实时音视频和实时消息功能外，你还可以参考下文，在项目中实现更多教育场景的附加功能。

$$ 26b89eb0-383f-11ea-98ea-dff00f97811c
{
 "platform": "web"
}
$$