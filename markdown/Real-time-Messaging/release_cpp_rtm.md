---
title: 发版说明
platform: All Platforms
updatedAt: 2021-03-02 03:11:56
---

## 简介

Agora RTM SDK 提供了稳定可靠、低延时、高并发的全球消息云服务，帮助你快速构建实时通信场景, 可实现消息通道、呼叫、聊天、状态同步等功能。点击 [实时消息产品概述](/cn/Real-time-Messaging/RTM_product?platform=All%20Platforms) 了解更多详情。

## 0.9.3 版

该版本于 2019 年 6 月 7 日发布。

### 新增功能

#### 发送（离线）点对点消息

本版本支持发送离线消息。在开通离线消息后如果对端离线，消息服务器会为每个接收端存储 200 条离线消息长达七天。消息以队列形式存储。当离线消息超限时，新存储的消息会导致最老的消息丢失。当发送端设置了离线消息，而此时消息接收者不在线，发送端会收到错误码：[PEER_MESSAGE_ERR_CACHED_BY_SERVER](/cn/Video/API%20Reference/RTM_cpp/v0.9.3/namespaceagora_1_1rtm.html?transId=0.9.3#ac7c591aac4ca6867e239c8bcccc1fc5caeccb9896a862a86fa1965705e2d394fd)

> 该方法的调用频率限制为每秒 60 条。

#### 设置本地用户属性、查询指定用户属性

本版本支持设置和查询用户属性。每个用户属性为 key 和 value 的键值对。每个属性的 key 为 32 字节可见字符，每个属性的 value 的字符串长度不得超过 8 KB。单个用户的全部属性长度不得超过 16 KB。以下为本版本支持内容：

- 全量替换本地用户属性
- 增加或更新本地用户属性
- 删除本地用户指定属性
- 清空本地用户属性
- 全量获取指定用户属性
- 获取指定用户指定属性。

> - 用户属性的相关操作必须在登录 Agora RTM 系统成功后才能进行，否则 SDK 会返回错误码：`ATTRIBUTE_OPERATION_ERR_NOT_READY`
> - 设置的用户属性会在用户登出 Agora RTM 系统后自动失效。
> - 单次用户属性设置操作不得超过 16 KB，否则 SDK 会返回错误码：`ATTRIBUTE_OPERATION_ERR_SIZE_OVERFLOW` 。
> - 用户属性设置相关操作的调用频率限制为每 5 秒 10 条，超限则 SDK 会返回错误码：`ATTRIBUTE_OPERATION_ERR_TOO_OFTEN`。
> - 获取用户属性相关操作的调用频率为每 5 秒 40 条，超限则 SDK 会返回错误码：`ATTRIBUTE_OPERATION_ERR_TOO_OFTEN` 。

### API 变更

#### 新增：

- [sendMessageToPeer()](/cn/Video/API%20Reference/RTM_cpp/v0.9.3/classagora_1_1rtm_1_1_i_rtm_service.html?transId=0.9.3#a08c1b3d444af5a2778ede48e4c677a52): 发送（离线）点对点消息给指定用户。
- [getServerReceivedTs()](/cn/Video/API%20Reference/RTM_cpp/v0.9.3/classagora_1_1rtm_1_1_i_message.html?transId=0.9.3#ac7427e3a49bd44e53b2809e0b39511b6)： 消息接收者查询服务器的接收消息时间。
- [isOfflineMessage()](/cn/Video/API%20Reference/RTM_cpp/v0.9.3/classagora_1_1rtm_1_1_i_message.html?transId=0.9.3#a191d3073625f002018359ee3e7cba33a)：消息接收者查询消息是否为离线消息。
- [PEER_MESSAGE_ERR_CACHED_BY_SERVER](/cn/Video/API%20Reference/RTM_cpp/v0.9.3/namespaceagora_1_1rtm.html?transId=0.9.3#ac7c591aac4ca6867e239c8bcccc1fc5caeccb9896a862a86fa1965705e2d394fd)：对端用户不在线，离线消息会被消息服务器存储。
- [setLocalUserAttributes()](/cn/Video/API%20Reference/RTM_cpp/v0.9.3/classagora_1_1rtm_1_1_i_rtm_service.html?transId=0.9.3#a86dcbfc38c665be8565f06c534338d33)：全量设置本地用户属性
- [addOrUpdateLocalUserAttributes()](/cn/Video/API%20Reference/RTM_cpp/v0.9.3/classagora_1_1rtm_1_1_i_rtm_service.html?transId=0.9.3#a0a63923bd1e81e60d6ca54213a329747)：增加本地用户属性或更新本地用户属性
- [deleteLocalUserAttributesByKeys()](/cn/Video/API%20Reference/RTM_cpp/v0.9.3/classagora_1_1rtm_1_1_i_rtm_service.html?transId=0.9.3#acb669f6c4c28e08cdf889df11e1ddeb3)：删除本地用户指定属性
- [clearLocalUserAttributes()](/cn/Video/API%20Reference/RTM_cpp/v0.9.3/classagora_1_1rtm_1_1_i_rtm_service.html?transId=0.9.3#acb669f6c4c28e08cdf889df11e1ddeb3)：清空本地用户全部属性
- [getUserAttributes()](/cn/Video/API%20Reference/RTM_cpp/v0.9.3/classagora_1_1rtm_1_1_i_rtm_service.html?transId=0.9.3#a14cac887f9adb390621dd0427092a65b)：获取指定用户的全部属性
- [getUserAttributesByKeys()](/cn/Video/API%20Reference/RTM_cpp/v0.9.3/classagora_1_1rtm_1_1_i_rtm_service.html?transId=0.9.3#af011235917c291df5581f92afa35532f): 获取指定用户的指定属性
- [onSetLocalUserAttributesResult()](/cn/Video/API%20Reference/RTM_cpp/v0.9.3/classagora_1_1rtm_1_1_i_rtm_service_event_handler.html?transId=0.9.3#ac01ea1ff17082bbf3c8cfbaccef4dfe8)：全量设置本地用户属性的执行回调
- [onAddOrUpdateLocalUserAttributesResult()](/cn/Video/API%20Reference/RTM_cpp/v0.9.3/classagora_1_1rtm_1_1_i_rtm_service_event_handler.html?transId=0.9.3#ab21ea7e02361debe4ebbf558cc80f268)：增加本地用户属性或更新本地用户属性的执行回调
- [onDeleteLocalUserAttributesResult()](/cn/Video/API%20Reference/RTM_cpp/v0.9.3/classagora_1_1rtm_1_1_i_rtm_service_event_handler.html?transId=0.9.3#a2b98a102d2bb9664552e30d257679887)：删除本地用户指定属性的执行回调
- [onClearLocalUserAttributesResult()](/cn/Video/API%20Reference/RTM_cpp/v0.9.3/classagora_1_1rtm_1_1_i_rtm_service_event_handler.html?transId=0.9.3#a94bbff8cdfee2ee306d66f73c1a29aa3)：清空本地用户全部属性的执行回调
- [onGetUserAttributesResult()](/cn/Video/API%20Reference/RTM_cpp/v0.9.3/classagora_1_1rtm_1_1_i_rtm_service_event_handler.html?transId=0.9.3#a76058e05b9a623645ba05ea1d1796007)：获取指定用户属性的执行回调
- [ATTRIBUTE_OPERATION_ERR](/cn/Video/API%20Reference/RTM_cpp/v0.9.3/namespaceagora_1_1rtm.html?transId=0.9.3#a9413a8cce9bbd88d8d4baade13c2ccce)：属性操作相关错误码

### 性能优化

- 支持在登录 Agora RTM 系统之前创建频道实例。
- 取消创建 RTM 频道最多 20 个的限制，但是同一用户只能同时加入 20 个频道，超限后会收到错误码 `JOIN_CHANNEL_ERR_FAILURE ` 。
- 调用 `setParameters` 方法时：
  - 如果输入的参数不符合 JSON 格式时，返回值 < 0 表示 `ERR_INVALID_ARGUMENT` 。
  - 如果输入参数合法，返回值 = 0。

### 问题修复

- 压测时偶现的系统崩溃。
- 用户登出后，其它用户查询该用户仍然显示在线，30 秒后查询不在线。

## 0.9.2 版

该版本于 2019 年 5 月 8 日发布。

### 新增功能

- 查询用户在线状态
- 更新 Token

### 性能改进

支持以空格开头的 `userId` 参数。

## 0.9.1 版

该版本于 2019 年 4 月 4 日发布。

### 新增功能

本版本增加了呼叫邀请功能。结合音视频一对一或一对多通话场景，你可以创建、发送、取消、接受或拒绝一个呼叫邀请。

## 0.9.0 版

该版本于 2019 年 2 月 4 日发布。

首次发布。

### 关键功能

- 发送或接收点对点消息。
- 加入或离开频道。
- 发送或接收频道消息。
