---
title: 发版说明
platform: All Platforms
updatedAt: 2020-11-24 06:33:29
---
本页提供 RTSA Lite SDK 的发版说明。

## 1.2.2 版
该版本于 2019 年 12 月 17 日发布。新增特性和问题修复如下。

#### 新增特性
**可靠数据传输**
v1.2.2 起支持可靠数据传输，适用于数据量少但可靠性高的传输场景。SDK 触发 `rtcServiceDidRdtAvailabilityChangedInChannel` 回调报告可靠数据通道状态为可用后，可调用 `sendCmdToChannel` 或 `sendDataThroughRdtToChannel` 方法通过可靠数据通道发送指令或数据。

#### 问题修复
* App 离开频道、进入后台息屏后，无法再次加入频道。
* 调用 API 暂停接收远端音视频流后，依然能收到。
* 4K 高清场景下偶现的丢帧。
* 部分已知 crash。

## 1.2.1 版
该版本于 2019 年 8 月 15 日发布。改进如下。

#### 改进
- 增强 String UID 的注册刷新/失效/一致性检测。
- 完善异常数据包过滤。

## 1.2.0 版
该版本于 2019 年 8 月 9 日发布。新增功能和修复问题如下。

#### 新增功能
**支持 String 型用户 ID**
v1.2.0 新增 `initWithAppId` 方法，支持用户使用 String 型用户 ID作为用户标识进行初始化。

#### 修复问题
- P2P 链路可通但链路状态拥塞时，消除反复 P2P 连接尝试造成带来的数据传输损伤。