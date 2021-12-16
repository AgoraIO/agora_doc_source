---
title: 学生端实现
platform: Electron
updatedAt: 2020-12-23 11:15:24
---
本文展示如何基于 Electron 框架实现学生端相关功能。

## 集成指引

根据下表链接，下载对应的 SDK，参考集成文档的步骤将 SDK 集成到你的项目中。


| 产品 | SDK 下载 | 集成文档 |
| ---------------- | ---------------- | ---------------- | 
| [Agora RTC (Real-time Communication) SDK](https://docs.agora.io/cn/Interactive%20Broadcast/product_live?platform=Electron)      | [Electron 视频互动直播 SDK](https://docs.agora.io/cn/Interactive%20Broadcast/downloads?platform=Electron)      | [实现互动直播](https://docs.agora.io/cn/Interactive%20Broadcast/start_live_electron?platform=Electron) |
| Agora 房间管理服务 | N/A | [房间管理服务 API 文档](https://agoradoc.github.io/cn/edu-cloud-service/restfulapi) |


## 核心 API 时序图

参考下图了解学生端实现的基础流程和 API 调用。

<div class="alert info">教育 SDK 是基于 Agora RTC SDK、Agora RTM SDK 和 Agora 房间管理服务封装的场景化 SDK，API 设计与实际业务场景更贴近、更易用。教育 SDK 当前处于内部测试体验阶段，如有疑问，请至 GitHub 提交 <a href="https://github.com/AgoraIO-Usecase/eEducation">issue</a>。</div>

![](https://web-cdn.agora.io/docs-files/1608556902335)