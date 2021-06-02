---
title: RTSA Pro SDK 概述
platform: Linux
updatedAt: 2021-02-08 07:43:16
---
## 功能描述 

RTSA Pro SDK 支持以下功能：

| 功能                                                         | 描述                                                         |
| :----------------------------------------------------------- | :----------------------------------------------------------- |
| RTSA SDK 间的互通                                            | RTSA SDK 支持以下音视频编码格式的双向互通：<li>音频：G722、AAC、Opus 和 PCM 编码格式。<li>视频：H.264、VP8 和 Generic 编码格式。 |
| RTSA SDK 与 [RTC Native SDK](https://docs.agora.io/cn/Agora%20Platform/term_agora_rtc_sdk) 互通 | RTSA SDK 与 RTC Native SDK 的互通：<li>音频：G722、AAC 和 Opus 编码格式的双向互通。<li>视频：H.264 数据的双向互通。 |
| RTSA SDK 与 [RTC Web SDK](https://docs.agora.io/cn/Agora%20Platform/term_agora_rtc_sdk) 互通 | RTSA SDK 与 RTC Web SDK 的互通：<li>音频：Opus 和 PCM 编码格式的双向互通。<li>视频：H.264 和 VP8 编码格式的双向互通。 |
| 信令控制与传输                                               | <li>支持 Data Stream。<li>支持通过 TCP 通道和 [RTM SDK](https://docs.agora.io/cn/Agora%20Platform/term_agora_rtm_sdk) 互通。 |
| String UID                                                   | 支持。                                                       |
| 云代理服务                                                   | 支持 UDP Proxy 和 TCP 443 Proxy。                            |
| 上行带宽预测                                                 | 支持根据带宽预测算法提出目标码率建议，反馈当前应该提高还是降低码率以及相应的建议值。 |
| 关键帧                                                       | 支持本地关键帧主动请求和远端关键帧请求响应回调。             |
| 音视频流传输状态管理和监听                                   | 支持灵活开始和暂停发送本地音视频流以及接收远端音视频流。支持监听远端音视频流的传输状态。 |

## 适用场景

RTSA Pro SDK 的适用场景详见下表：

 | 场景     | 描述                                                         |
 | :------- | :----------------------------------------------------------- |
 | 双师课堂 | 教育录播设备集成 RTSA Pro SDK 后，可实现：<li>主讲老师线上实时讲课。<li>若干个远端教室，各配一个辅导老师，通过教室大屏幕及音箱等设备听课。 |
 | 机器人   | 机器人、无人机、无人车等无人值守设备，集成 RTSA Pro SDK 后可实现：<li>用户可通过手机或 PC 监控端（使用 RTC SDK）远程监控、人工轮询。<li>一个设备能同时被多个监控端查看。<li>一个监控端能同时查看多个设备。<li>用户可通过语音传输实现双向对讲和远程指挥。 |
 | 云游戏   | 在云游戏平台服务器集成 RTSA Pro SDK 后，可实现：<li>玩家手机端将操作指令实时传输给云端虚拟手机。<li>云端虚拟手机实时发送当前游戏音视频码流并在玩家手机实时渲染。 |

## 平台兼容

RTSA Pro SDK 兼容性要求见下表：

| 平台    | 支持版本                                                     |
| :------ | :----------------------------------------------------------- |
| Linux   | <li>X86 / X86_64架构：gcc 内核 2.6.35 及以上</li><li>ARM 架构：<ul><li>arm-linux-gnueabi 4.4.x 及以上</li><li>arm-linux-gnueabihf 4.8.x 及以上</li><li>aarch64-linux-gnu 4.8.x 及以上</li><li>arm-linux-musleabihf 5.2.x 及以上</li><li>arm-linux-musleabi 5.5.x 及以上</li><li>aarch64-linux-musl 5.5.x 及以上</li><li>arm-linux-uclibceabi 4.4.x 及以上</li><li>arm-linux-uclibceabihf 4.8.x 及以上</li> |
| Android | Android 5.0 及以上 (C++)                                     |

## 产品性能

RTSA Pro SDK 产品具有以下性能：

| 特性         | Agora 指标                                                   |
| :----------- | :----------------------------------------------------------- |
| 包体积       | 7.5 MB 左右<p>在同时收发 1280*720 码流的场景中，内存占用 10 MB 左右 |
| 连通率       | 连通率 > 99%                                                 |
| 数据传输速率 | 单个频道单个用户最高 50 Mbps 的码率                          |
| 网络适应性   | 50% 内丢包无感知恢复                                         |