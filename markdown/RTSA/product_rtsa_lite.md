---
title: RTSA Lite SDK 概述
platform: All Platforms
updatedAt: 2021-02-08 07:46:40
---
## 功能描述

RTSA Lite SDK 支持以下功能：

| 功能                                                         | 描述                                                         |
| :----------------------------------------------------------- | :----------------------------------------------------------- |
| RTSA SDK 间的互通                                            | 支持以下音视频编码格式的双向互通：<li>音频：G722、AAC 和 Opus 编码格式。<li>视频：H.264 和 Generic 编码格式。 |
| RTSA SDK 与 [RTC Native SDK](https://docs.agora.io/cn/Agora%20Platform/term_agora_rtc_sdk) 互通 | RTSA SDK 与 RTC Native SDK 的互通：<li>音频：G722、AAC 和 Opus 编码格式的双向互通。<li>视频：H.264 数据的双向互通。 |
| RTSA SDK 与 [RTC Web SDK](https://docs.agora.io/cn/Agora%20Platform/term_agora_rtc_sdk) 互通 | RTSA SDK 与 RTC Web SDK 的互通：<li>音频：Opus 编码格式的双向互通。<li>视频：H.264 编码格式的单向互通，即仅支持 RTSA 向 Web SDK 发流，不支持 Web SDK 向 RTSA 发流。 |
| 上行带宽预测                                                 | 支持根据带宽预测算法提出目标码率建议，反馈当前应该提高还是降低码率以及相应的建议值。 |
| 关键帧                                                       | 支持本地关键帧主动请求和远端关键帧请求响应回调。             |
| 音视频流传输状态管理和监听                                   | 支持灵活开始和暂停发送本地音视频流以及接收远端音视频流。支持监听远端音视频流的传输状态。 |

> 仅 1.3.0 及以上版本支持与 [RTC Native SDK](https://docs.agora.io/cn/Agora%20Platform/term_agora_rtc_sdk) 和 [RTC Web SDK](https://docs.agora.io/cn/Agora%20Platform/term_agora_rtc_sdk) 的互通。

## 适用场景

RTSA Lite SDK 的极小包体积、低内存占用以及低功耗特性特别适合嵌入式 IoT 领域的各类场景，详见下表：

| 场景     | 描述                                                         |
| :------- | :----------------------------------------------------------- |
| 实时监控 | 如智能家用摄像头、车载监控、可视门铃等，集成 RTSA Lite 后，可实现：<li>用户通过手机 App 查看摄像头的视频画面。<li>一个摄像头场景能同时被多个手机查看。<li>一个手机能同时查看多个摄像头场景。<li>手机和摄像头语音双向对讲。 |
| 电话手表 | 低功耗电话手表端集成 RTSA Lite 后可实现：<li>用户通过手机 App（使用 RTC SDK） 同手表进行实时音视频通话。 |

## 产品性能

RTSA Lite SDK 具有以下性能：

| 特性                      | Agora 指标                                                   |
| :------------------------ | :----------------------------------------------------------- |
| 包体积 | 集成 SDK 包体积增量 \< 400 KB<br>在同时收发 320*240、H.264 码流的场景中，内存占用 \< 2MB |
| 连通率                    | 连通率 > 99%                                                 |
| 数据传输速率              | 单个频道单个用户最高 50 Mbps 的码率                          |
| 网络适应性                | 50% 内丢包无感知恢复                                         |

## 平台兼容

RTSA Lite SDK 支持 Linux、iOS、Android、macOS、Windows 平台，具体的兼容性要求见下表。

| 平台      | 支持版本                                                     |
| :-------- | :----------------------------------------------------------- |
| Linux     | <ul><li>X86 / X86_64架构：gcc 内核 2.6.35 及以上</li><li>ARM 架构：<ul><li>arm-linux-gnueabi 4.4.x 及以上</li><li>arm-linux-gnueabihf 4.8.x 及以上</li><li>aarch64-linux-gnu 4.8.x 及以上</li><li>arm-linux-musleabihf 5.2.x 及以上</li><li>arm-linux-musleabi 5.5.x 及以上</li><li>aarch64-linux-musl 5.5.x 及以上</li><li>arm-linux-uclibceabi 4.4.x 及以上</li><li>arm-linux-uclibceabihf 4.8.x 及以上</li></ul></li><li>MIPS 架构：mips-linux-uclibceabihf 4.7.x 及以上</li></ul> |
| HarmonyOS | ARM 架构：arm-liteos-eabi 内核 liteOS 2.0                    |
| iOS       | iOS 7 及以上                                                 |
| Android   | Android 5.0 及以上                                           |
| macOS     | macOS 10.5 及以上                                            |
| Windows   | Windows XP 及以上                                            |