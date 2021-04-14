---
title: 限制条件
platform: Android
updatedAt: 2021-01-19 10:12:36
---

本页简要介绍 Agora RTM Java SDK for Linux 的使用限制条件，包括调用频率、字符串大小、编码格式等。

## 调用频率限制

所有的调用频率都针对单个 <code>RtmClient</code> 实例。如果一个操作对应多个方法，则此操作在单位时间内的调用次数等于所有方法单位时间内的调用次数之和。

<div class="alert note">你可以通过创建多个实例提高 API 的调用频率。</div>

<style> table th:first-of-type {     width: 300px; } th:third-of-type {     width: 100px; }</style>

| 功能                                    | 方法                                                         | 调用频率限制     |
| --------------------------------------- | ------------------------------------------------------------ | ------------ |
| 登录 Agora RTM 系统                   | [`RtmClient.login`](/cn/Real-time-Messaging/API%20Reference/RTM_java_linux/classio_1_1agora_1_1rtm_1_1_rtm_client.html#a995bb1b1bbfc169ee4248bd37e67b24a) | 每秒 2 次     |
| 查询单个或多个频道的成员人数 | [`getChannelMemberCount`](/cn/Real-time-Messaging/API%20Reference/RTM_java_linux/classio_1_1agora_1_1rtm_1_1_rtm_client.html#aff0384f2a004ed75498e20e1917352e4) | 每秒 1 次 |
| 每次都加入不同频道 | [`join`](/cn/Real-time-Messaging/API%20Reference/RTM_java_linux/classio_1_1agora_1_1rtm_1_1_rtm_channel.html#ad7b321869aac2822b3f88f8c01ce0d40) | 每 3 秒 50 次 |
| 每次都加入同一个频道 | [`join`](/cn/Real-time-Messaging/API%20Reference/RTM_java_linux/classio_1_1agora_1_1rtm_1_1_rtm_channel.html#ad7b321869aac2822b3f88f8c01ce0d40) | 每 5 秒 2 次 |
| 发送消息 | <li>[`RtmClient.sendMessageToPeer()`](/cn/Real-time-Messaging/API%20Reference/RTM_java_linux/classio_1_1agora_1_1rtm_1_1_rtm_client.html#a25ab5c0126e1dc51c78b2b705de68b7a) <li>[`sendMessageToPeer`](/cn/Real-time-Messaging/API%20Reference/RTM_java/classio_1_1agora_1_1rtm_1_1_rtm_client.html#a729079805644b3307297fb2e902ab4c9) <li> [`RtmChannel.SendMessage()`](/cn/Real-time-Messaging/API%20Reference/RTM_java_linux/classio_1_1agora_1_1rtm_1_1_rtm_channel.html#a57087adf4227a17c774ea292840148a0) | 每 3 秒 1500 次    |
| 获取频道成员列表                        | [`RtmChannel.getMembers`](/cn/Real-time-Messaging/API%20Reference/RTM_java_linux/classio_1_1agora_1_1rtm_1_1_rtm_channel.html#a567aca5f866cf71c3b679ae09b4bf626) | 每 2 秒 5 次 |
| 更新 token| [`RtmClient.renewToken`](/cn/Real-time-Messaging/API%20Reference/RTM_java_linux/classio_1_1agora_1_1rtm_1_1_rtm_client.html#a9a6d33282509384165709107d7a89353) | 每秒 2 次 |
| 查询指定用户在线状态 | [`RtmClient.queryPeersOnlineStatus`](/cn/Real-time-Messaging/API%20Reference/RTM_java_linux/classio_1_1agora_1_1rtm_1_1_rtm_client.html#ac711f981405648ed5ef1cb07436125f3) | 每 5 秒 100 次 |
| 用户属性增删修改| <li>[`setLocalUserAttributes`](/cn/Real-time-Messaging/API%20Reference/RTM_java_linux/classio_1_1agora_1_1rtm_1_1_rtm_client.html#a339b7b2371ff2b86137b6db6c1c66294)<li>[`addOrUpdateLocalUserAttributes`](/cn/Real-time-Messaging/API%20Reference/RTM_java_linux/classio_1_1agora_1_1rtm_1_1_rtm_client.html#a765b186d62ed3ef6d67a5e875b040875)<li>[`deleteLocalUserAttributesByKeys`](/cn/Real-time-Messaging/API%20Reference/RTM_java_linux/classio_1_1agora_1_1rtm_1_1_rtm_client.html#a2477533989c1bb9ced831af210f1dba4)<li>[`clearLocalUserAttributes`](/cn/Real-time-Messaging/API%20Reference/RTM_java_linux/classio_1_1agora_1_1rtm_1_1_rtm_client.html#ae0c6c5c5bae6020e69009441d8a41785) | 每 5 秒 100 次          |
| 用户属性查询| <li>[`getUserAttributes`](/cn/Real-time-Messaging/API%20Reference/RTM_java_linux/classio_1_1agora_1_1rtm_1_1_rtm_client.html#aee9a6c027f35b652781f654a89433755)<li>[`getUserAttributesByKeys`](/cn/Real-time-Messaging/API%20Reference/RTM_java_linux/classio_1_1agora_1_1rtm_1_1_rtm_client.html#a3b927c35cca5ebd31afb976d60e99193) | 每 5 秒 400 次          |
| 频道属性增删修改| <li>[`setChannelAttributes`](/cn/Real-time-Messaging/API%20Reference/RTM_java_linux/classio_1_1agora_1_1rtm_1_1_rtm_client.html#ad25f51a3671db50e348ec6c170044ec6)<li>[`addOrUpdateChannelAttributes`](/cn/Real-time-Messaging/API%20Reference/RTM_java_linux/classio_1_1agora_1_1rtm_1_1_rtm_client.html#a997a31e6bfe1edc9b6ef58a931ef3f23)<li>[`deleteChannelAttributesByKeys`](/cn/Real-time-Messaging/API%20Reference/RTM_java_linux/classio_1_1agora_1_1rtm_1_1_rtm_client.html#a4cbf3329abda4940b73a75455cd1dc06)<li>[`clearChannelAttributes`](/cn/Real-time-Messaging/API%20Reference/RTM_java_linux/classio_1_1agora_1_1rtm_1_1_rtm_client.html#a6ed0ef4baacda8fa00eda5373d17f59f) | 每 5 秒 100 次          |
| 频道属性查询| <li>[`getChannelAttributes`](/cn/Real-time-Messaging/API%20Reference/RTM_java_linux/classio_1_1agora_1_1rtm_1_1_rtm_client.html#a81f14a747a4012815ab4ba8d9e480fb6)<li>[`getChannelAttributesByKeys`](/cn/Real-time-Messaging/API%20Reference/RTM_java_linux/classio_1_1agora_1_1rtm_1_1_rtm_client.html#a358b47f4b42d678fafa76f3f30290e5e) | 每 5 秒 400 次          |
| 订阅指定单个或多个用户的在线状态   | [`subscribePeersOnlineStatus`](/cn/Real-time-Messaging/API%20Reference/RTM_java_linux/classio_1_1agora_1_1rtm_1_1_rtm_client.html#a7a9ec7398c013ed35e17bc5d93e71420) | 每 5 秒 10 次 |
| 取消订阅指定单个或多个用户的在线状态    | [`unSubscribePeersOnlineStatus`](/cn/Real-time-Messaging/API%20Reference/RTM_java_linux/classio_1_1agora_1_1rtm_1_1_rtm_client.html#acf3ab093be17a0752d8aff094e3aabc4) | 每 5 秒 10 次 |
| 根据订阅内容获取用户列表   | [`queryPeersBySubscriptionOption`](/cn/Real-time-Messaging/API%20Reference/RTM_java_linux/classio_1_1agora_1_1rtm_1_1_rtm_client.html#a971c357f7d0c27d122ff877389314ccc) | 每 5 秒 10 次 |


## 字符串长度限制

- 点对点或频道消息的字符串最大为 32 KB。详见 [`RtmMessage.setText()`](/cn/Real-time-Messaging/API%20Reference/RTM_java_linux/classio_1_1agora_1_1rtm_1_1_rtm_message.html#a114bf5f4d728e1a5e31792491bf4a1d2)。
- 呼叫邀请内容的字符串最大为 8 KB。 详见 [`LocalInvitation.setContent()`](/cn/Real-time-Messaging/API%20Reference/RTM_java_linux/interfaceio_1_1agora_1_1rtm_1_1_local_invitation.html#a4cec28ff6d356242329b1034c7531445)。
- 呼叫邀请响应的字符串最大为 8 KB。 详见 [`RemoteInvitation.setResponse()`](/cn/Real-time-Messaging/API%20Reference/RTM_java_linux/interfaceio_1_1agora_1_1rtm_1_1_remote_invitation.html#a229b8cf773eaa0e79b0d67815fd6b6f1)。

## 编码格式限制

- 频道消息和点对点消息、呼叫邀请内容、呼叫邀请响应仅支持 UTF-8 编码格式。
- 以下方法的 `filePath` 参数都必须是 UTF-8 编码格式：
  - [`createFileMessageByUploading`](/cn/Real-time-Messaging/API%20Reference/RTM_java_linux/v1.3.0/classio_1_1agora_1_1rtm_1_1_rtm_client.html#a1b08207278d611e5e4b87e6d9712e0c7)
  - [`createImageMessageByUploading`](/cn/Real-time-Messaging/API%20Reference/RTM_java_linux/v1.3.0/classio_1_1agora_1_1rtm_1_1_rtm_client.html#afc93fad7700593a803ddbc87482c0ac0)
  - [`downloadMediaToFile`](/cn/Real-time-Messaging/API%20Reference/RTM_java_linux/v1.3.0/classio_1_1agora_1_1rtm_1_1_rtm_client.html#a34e0bd19fb0bbd1d91dec0a1af100038)


## 其它限制

- 当频道人数超过 512 人时，用户进出频道的提示会被自动关闭。Agora 建议你在自己的业务服务器调用[获取用户加入或离开频道事件 RESTful API](/cn/Real-time-Messaging/rtm_get_event?platform=All%20Platforms) 获取进出频道通知。
- 对于单个实例，支持单次查询最多 256 个用户的在线状态。
- 对于单个实例，单次最多且总计只能订阅 512 人的在线状态。你无法通过多次订阅来突破人数限制。如果频道人数超过 512，SDK 会随机返回其中的 512 人。
- 对于单个实例，每个用户最多同时加入 20 个频道。
- 单次用户属性设置的最大值为 16 KB，单次频道属性设置的最大值为 32 KB，单条用户或频道属性（键值对）的最大值为 8 KB，单次属性操作设置的属性条目（键值对）不能超过 32 个。
- 每个上传文件或图片在 Agora 服务器上的保存时间最长为 7 天，上传文件或图片所对应的 media ID 有效期也为 7 天。
- 每个上传文件或图片不得超过 30 MB。
- 对于单个实例，同时最多支持 9 个上传和下载进程。