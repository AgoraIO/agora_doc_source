---
title: 学生端实现
platform: Windows
updatedAt: 2021-03-02 03:17:21
---
本文展示如何实现学生端相关功能。

## 设备参考

对于听课教室，建议配备以下设备：

- 一个主机：用于集成 Agora SDK。Agora 使用英特尔酷睿 i7 8700，8 G 内存，配备 SSD 128 G 固态硬盘和独立显卡 2G-128。
- 两个显示设备：一个用于显示老师摄像头采集画面，一个用于显示老师屏幕共享内容。65 寸、86 寸或 100 寸均可，Agora 推荐希沃 86 寸。

## 集成指引

根据下表链接，下载对应的 SDK，参考集成文档的步骤将 SDK 集成到你的项目中。

| 产品                                                         | SDK 下载                                                     | 集成文档                                                     |
| :----------------------------------------------------------- | :----------------------------------------------------------- | :----------------------------------------------------------- |
| [Agora RTC (Real-time Communication) SDK](https://docs.agora.io/cn/Interactive%20Broadcast/product_live?platform=All%20Platforms) | [视频互动直播 SDK](https://download.agora.io/sdk/release/Agora_Native_SDK_for_Windows_v3.2.0.122_FULL_20210108_2109_38509.zip) | [实现互动直播](https://docs.agora.io/cn/Interactive%20Broadcast/start_live_ios?platform=iOS) |
| [Agora RTM (Real-time Messaging) SDK](https://docs.agora.io/cn/Real-time-Messaging/product_rtm?platform=All%20Platforms) | [实时消息 SDK](https://docs.agora.io/cn/Real-time-Messaging/downloads?platform=Windows) | [收发点对点消息和频道消息](https://docs.agora.io/cn/Real-time-Messaging/messaging_ios?platform=iOS) |
| Agora 教育云服务                                             | N/A                                                          | [教育云服务 API 文档](https://agoradoc.github.io/cn/edu-cloud-service/restfulapi) |

## 核心 API 时序图

参考下图了解教师端实现的基础流程和 API 调用。

<div class="alert info">教育 SDK 是基于 Agora RTC SDK、Agora RTM SDK 和 Agora 教育云服务封装的场景化 SDK，API 设计与实际业务场景更贴近、更易用。教育 SDK 当前处于内部测试体验阶段，如有疑问，请至 GitHub 提交 <a href="https://github.com/AgoraIO-Usecase/AgoraDualTeacher">issue</a>。</div>

![](https://web-cdn.agora.io/docs-files/1610694233817)