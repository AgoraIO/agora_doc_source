---
title: 发版说明
platform: All Platforms
updatedAt: 2021-04-01 08:16:32
---

本页提供 RTSA Lite SDK 的发版说明。

## 1.3.0 版

该版本于 2020 年 11 月 24 日发布。

#### 升级必看

**改进发送音视频方法**

该版本新增 `audio_frame_info_t` 和 `video_frame_info_t` 结构体，改进了 `agora_rtc_send_audio_data` 和 `agora_rtc_send_video_data` 方法中的参数。

- 对于 `agora_rtc_send_audio_data` 方法，该版本将 `codec` 参数归并至 `audio_frame_info_t` 结构体中。
- 对于 `agora_rtc_send_video_data` 方法，该版本将 `codec` 和 `is_key_frame` 参数归并到 `video_frame_info_t` 结构体中。

**动态码率推荐**

该版本移除了 `on_inc_bitrate` 和 `on_dec_bitrate` 回调，并新增 `on_target_bitrate_changed` 回调进行取代。

网络带宽状况变化时，SDK 会触发 `on_target_bitrate_changed` 回调提示应用程序实时调整发送码率。

**API 更名**

该版本进行以下 API 的更名，以确保 API 命名的准确和规范。

- `agora_rtc_credential` 方法更名为 `agora_rtc_license_gen_credential`。
- `agora_rtc_cert` 更名为 `agora_rtc_license_verify`。
- `agora_get_version` 更名为 `agora_rtc_get_version`。
- `agora_err_2_str` 更名为 agora_rtc_err_2_str`。

**错误码和警告码清理**

该版本移除了无用的警告码，并清理了冗杂的错误码，以确保开发者能够得到清晰且准确的报错信息。

#### 新增特性

**互通增强**

该版本增强了 RTSA SDK 间互通的能力，并实现了 RTSA SDK 与 [Agora RTC SDK](https://docs.agora.io/cn/Agora%20Platform/term_agora_rtc_sdk) 的互通，详见[产品概述的功能描述](./product_rtsa)章节。

**配置 BWE**

该版本新增 `agora_rtc_set_bwe_param` 方法用于配置 BWE (Bandwidth Estimation) 参数。你可根据自己的实际带宽和码率需要调用此方法配置发送码率的最小值、最大值和起始值，详见[动态码率推荐](./recommend_bitrate_linux)。

#### API 变更

**新增**

- `agora_rtc_set_bwe_param` 方法
- `on_target_bitrate_changed` 回调
- `audio_frame_info_t` 结构体
- `video_frame_info_t` 结构体

**变更**

- `agora_rtc_credential` 更名为 `agora_rtc_license_gen_credential`
- `agora_rtc_cert` 更名为 `agora_rtc_license_verify`
- `agora_get_version` 更名为 `agora_rtc_get_version`
- `agora_err_2_str` 更名为 agora_rtc_err_2_str`

**删除**

- `on_inc_bitrate`
- `on_dec_bitrate`

## 1.2.2 版

该版本于 2019 年 12 月 17 日发布。新增特性和问题修复如下。

#### 新增特性

**可靠数据传输**
v1.2.2 起支持可靠数据传输，适用于数据量少但可靠性高的传输场景。SDK 触发 `on_rdt_availability_changed` 回调报告可靠数据通道状态为可用后，可调用 `agora_rtc_send_cmd` 或 `agora_rtc_send_through_rdt` 方法通过可靠数据通道发送指令或数据。

#### 问题修复

- App 离开频道、进入后台息屏后，无法再次加入频道。
- 调用 API 暂停接收远端音视频流后，依然能收到。
- 4K 高清场景下偶现的丢帧。
- 部分已知 crash。

## 1.2.1 版

该版本于 2019 年 8 月 15 日发布。改进如下。

#### 改进

- 增强 String UID 的注册刷新/失效/一致性检测。
- 完善异常数据包过滤。

## 1.2.0 版

该版本于 2019 年 8 月 9 日发布。新增功能和修复问题如下。

#### 新增功能

**支持 String 型用户 ID**
v1.2.0 新增 `agora_rtc_init_with_name` 方法，支持用户使用 String 型用户 ID 作为用户标识进行初始化。

#### 修复问题

- P2P 链路可通但链路状态拥塞时，消除反复 P2P 连接尝试造成带来的数据传输损伤。
