---
title: 产品概述
platform: All Platforms
updatedAt: 2021-02-08 08:30:32
---
声网实时码流加速产品（Real-Time Streaming Acceleration, RTSA）帮助拥有第三方音视频编解码模块或自研编解码的开发者实现实时音视频码流传输互通。RTSA 依托声网底层实时传输网络 [Agora SD-RTN™](/cn/null/sd_rtn) (Software Defined Real-time Network) ，运用全球全网节点 、智能动态路由以及端侧弱网对抗算法，提供高联通性、低延时、高稳定性的音视频码流传输云服务，减少延时、丢包等网络问题对音视频传输质量和体验的影响。此外，RTSA 适配多种 IoT 平台以及 x86 架构，助力开发者在任意设备与场景中开启实时互动能力。

## RTSA 产品家族

根据场景不同，声网提供以下两种 RTSA SDK：

|          | RTSA Lite                                                    | RTSA Pro                                                     |    Linux SDK      |
| :------- | :----------------------------------------------------------- | :----------------------------------------------------------- |  :----------------------------------------------------------- |
| SDK 介绍 | 专为低功耗嵌入式 IoT 场景设计的小包体积、低内存占用、低功耗版本 SDK。 | 提供更全面的功能和更优质的体验，适用于体制内双师课堂、云游戏等体验优先场景。 | 提供完整的 RTC 层编解码和传输的能力，可用于有采集设备的 ARM 准系统，或在服务器端部署，作为 RTC 媒体网关。 |
| 相关资源 | [SDK 下载地址](https://docs.agora.io/cn/RTSA/downloads?platform=Linux) | 该 SDK 当前处于内测阶段，你可以填写[问卷](https://www.wjx.cn/jq/97665151.aspx)申请试用。 | <li>[SDK 下载地址](https://download.agora.io/sdk/release/Agora_Native_SDK_for_Linux_x64_rel.v3.3.200_3776_FULL_20201225_1925_ubuntu14_04_5_server_external.zip) <li>[SDK 文档](https://docs-preprod.agora.io/cn/RTSA/linux_sdk_product_overview?platform=Linux)|

## 功能描述

RTSA 产品支持以下功能：

| 功能                                                         | 描述                                                         |
| :----------------------------------------------------------- | :----------------------------------------------------------- |
| RTSA SDK 间的互通                                            | RTSA SDK 支持以下音视频编码格式的双向互通：<li>音频：G722、AAC 和 Opus 编码格式。<li>视频：H.264 和 Generic 编码格式。 |
| RTSA SDK 与 [RTC Native SDK](https://docs.agora.io/cn/Agora%20Platform/term_agora_rtc_sdk) 互通 | RTSA SDK 与 RTC Native SDK 的互通：<li>音频：G722、AAC 和 Opus 编码格式的双向互通。<li>视频：H.264 数据的双向互通。 |
| RTSA SDK 与 [RTC Web SDK](https://docs.agora.io/cn/Agora%20Platform/term_agora_rtc_sdk) 互通 | RTSA SDK 与 RTC Web SDK 的互通：<li>音频：Opus 编码格式的双向互通。<li>视频：H.264 编码格式的单向互通，即仅支持 RTSA 向 Web SDK 发流，不支持 Web SDK 向 RTSA 发流。 |
| 上行带宽预测                                                 | 支持根据带宽预测算法提出目标码率建议，反馈当前应该提高还是降低码率以及相应的建议值。 |
| 关键帧                                                       | 支持本地关键帧主动请求和远端关键帧请求响应回调。             |
| 音视频流传输状态管理和监听                                   | 支持灵活开始和暂停发送本地音视频流以及接收远端音视频流。支持监听远端音视频流的传输状态。 |

> 仅 1.3.0 及以上版本支持与 [RTC Native SDK](https://docs.agora.io/cn/Agora%20Platform/term_agora_rtc_sdk) 和 [RTC Web SDK](https://docs.agora.io/cn/Agora%20Platform/term_agora_rtc_sdk) 的互通。

## 适用场景

RTSA 产品适用于 IoT、社交、教育、客服等多个行业中自有或自研音视频采集和编解码能力的场景。

其中 RTSA Lite 的极小包体积、低内存占用以及低功耗特性特别适合嵌入式 IoT 领域的各类场景。

RTSA 的适用场景详见下表：

| RTSA 产品家族 | 场景     | 描述                                                         |
| :------------ | :------- | :----------------------------------------------------------- |
| RTSA Lite     | 实时监控 | 如智能家用摄像头、车载监控、可视门铃等，集成 RTSA Lite 后，可实现：<li>用户通过手机 App 查看摄像头的视频画面。<li>一个摄像头场景能同时被多个手机查看。<li>一个手机能同时查看多个摄像头场景。<li>手机和摄像头语音双向对讲。 |
| RTSA Lite     | 电话手表 | 低功耗电话手表端集成 RTSA Lite 后可实现：<li>用户通过手机 App（使用 RTC SDK） 同手表进行实时音视频通话。 |
| RTSA Pro      | 双师课堂 | 教育录播设备集成 RTSA Pro 后，可实现：<li>主讲老师线上实时讲课。<li>若干个远端教室，各配一个辅导老师，通过教室大屏幕及音箱等设备听课。 |
| RTSA Pro      | 机器人   | 机器人、无人机、无人车等无人值守设备，集成 RTSA Pro 后可实现：<li>用户可通过手机或 PC 监控端（使用 RTC SDK）远程监控、人工轮询。<li>一个设备能同时被多个监控端查看。<li>一个监控端能同时查看多个设备。<li>用户可通过语音传输实现双向对讲和远程指挥。 |
| RTSA Pro      | 云游戏   | 在云游戏平台服务器集成 RTSA Pro 后，可实现：<li>玩家手机端将操作指令实时传输给云端虚拟手机。<li>云端虚拟手机实时发送当前游戏音视频码流并在玩家手机实时渲染。 |

## 产品性能

RTSA 产品具有以下性能：

| 特性                      | Agora 指标                                                   |
| :------------------------ | :----------------------------------------------------------- |
| 包体积（仅针对 RTSA Lite SDK） | 集成 SDK 包体积增量 \< 400 KB<br>在同时收发 320*240、H.264 码流的场景中，内存占用 \< 2MB |
| 连通率                    | 连通率 > 99%                                                 |
| 数据传输速率              | 单个频道单个用户最高 50 Mbps 的码率                          |
| 网络适应性                | 50% 内丢包无感知恢复                                         |

## 平台兼容

RTSA Lite 支持 Linux、iOS、Android、macOS、Windows 平台，具体的兼容性要求见下表。

| 平台      | 支持版本                                                     |
| :-------- | :----------------------------------------------------------- |
| Linux     | <ul><li>X86 / X86_64架构：gcc 内核 2.6.35 及以上</li><li>ARM 架构：<ul><li>arm-linux-gnueabi 4.4.x 及以上</li><li>arm-linux-gnueabihf 4.8.x 及以上</li><li>aarch64-linux-gnu 4.8.x 及以上</li><li>arm-linux-musleabihf 5.2.x 及以上</li><li>arm-linux-musleabi 5.5.x 及以上</li><li>aarch64-linux-musl 5.5.x 及以上</li><li>arm-linux-uclibceabi 4.4.x 及以上</li><li>arm-linux-uclibceabihf 4.8.x 及以上</li></ul></li><li>MIPS 架构：mips-linux-uclibceabihf 4.7.x 及以上</li></ul> |
| HarmonyOS | ARM 架构：arm-liteos-eabi 内核 liteOS 2.0                    |
| iOS       | iOS 7 及以上                                                 |
| Android   | Android 5.0 及以上                                           |
| macOS     | macOS 10.5 及以上                                            |
| Windows   | Windows XP 及以上                                            |
	
## 相关文档
* [快速跑通示例项目](./demo_guide_linux)指导你在正式将 RTSA Lite SDK 集成到项目中之前，编译并运行示例项目进行初步了解。
* [实现码流传输](./transmit_streams_linux)介绍实现码流传输的基本 API 调用。
* [ API 参考](./API%20Reference/rtsa_c/index.html)介绍所有 API 及参数。