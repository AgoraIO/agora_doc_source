---
title: 限制条件
platform: Android
updatedAt: 2021-01-19 10:28:37
---

本页简要介绍 Agora RTM C++ SDK for Windows 的使用限制条件，包括调用频率、字符串大小、编码格式等。



## 调用频率限制

所有的调用频率都针对单个 <code>IRtmService</code> 实例。如果一个操作对应多个方法，则此操作在单位时间内的调用次数等于所有方法单位时间内的调用次数之和。

<div class="alert note">你可以通过创建多个实例提高 API 的调用频率。</div>

<style> table th:first-of-type {     width: 300px; } th:third-of-type {     width: 100px; }</style>

| 操作                                                  | 方法                                                      | 调用频率限制                |
| ----------------------------------------------------------- | ------------------------------------------------------------ | ------------------------------ |
| 登录 Agora RTM 系统                              | [`login`](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#a2433a0babbed76ab87084d131227346b) |  每秒 2 次         |
| 查询单个或多个频道的成员人数 | [`getChannelMemberCount`](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#a41dee47c6201acb2f29371b6e30249a5) | 每秒 1 次 |
| 每次都加入不同频道 | [`join`](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_channel.html#a6a54cdd8e5db526514e0ca84aa9cba4c) | 每 3 秒 50 次 |
| 每次都加入同一个频道 | [`join`](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_channel.html#a6a54cdd8e5db526514e0ca84aa9cba4c) | 每 5 秒 2 次 |
| 发送消息| <li>[`sendMessageToPeer`](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#afec5391fa9c4ec2bfe9ac4e684705600) <li>[`sendMessageToPeer`](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#a08c1b3d444af5a2778ede48e4c677a52)<li>[`sendMessage`](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_channel.html#a4ae01f44d49f334f7c2950d95f327d30) |每 3 秒 180 次          |
| 获取频道成员列表                    | [`getMembers`](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_channel.html#a3f9c943059ac48a568c81798da38c3cb) | 每 2 秒 5 次 |
| 更新 token| [`renewToken`](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#a2c33be67bfec02d69041f1e8978f4559) | 每秒 2 次 |
| 查询指定用户在线状态 | [`queryPeersOnlineStatus`](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#a3add0055c4455dc8d04bfc37edfd8e94) | 每 5 秒 10 次 |
| 用户属性增删修改| <li>[`setLocalUserAttributes`](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#a86dcbfc38c665be8565f06c534338d33)<li>[`addOrUpdateLocalUserAttributes`](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#a0a63923bd1e81e60d6ca54213a329747)<li>[`deleteLocalUserAttributesByKeys`](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#acb669f6c4c28e08cdf889df11e1ddeb3)<li>[`clearLocalUserAttributes`](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#acc5eee875f4166fe455cde7aff1ad738) | 每 5 秒 10 次          |
| 用户属性查询| <li>[`getUserAttributes`](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#a14cac887f9adb390621dd0427092a65b)<li>[`getUserAttributesByKeys`](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#af011235917c291df5581f92afa35532f) | 每 5 秒 40 次          |
| 频道属性增删修改| <li>[`setChannelAttributes`](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#aa229a7207062b510799166c1239412fa)<li>[`addOrUpdateChannelAttributes`](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#ae4068ff21c8e20e8eeb45ba21959c368)<li>[`deleteChannelAttributesByKeys`](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#a1a448f33be57b31f9952822426e5c4bd)<li>[`clearChannelAttributes`](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#aff6cff676e3fc3150ef5f27845c9a3d3) | 每 5 秒 10 次          |
| 频道属性查询| <li>[`getChannelAttributes`](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#a3dc8409ed82d8f95a0839d5e9e7da564)<li>[`getChannelAttributesByKeys`](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#ac97f24f9d78e885e494a22be95db8d33) | 每 5 秒 10 次          |
| 订阅指定单个或多个用户的在线状态   | [`subscribePeersOnlineStatus`](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#a3a0e2d4d79ac85e23eae0dcb114ba9f0) | 每 5 秒 10 次 |
| 取消订阅指定单个或多个用户的在线状态    | [`unSubscribePeersOnlineStatus`](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#a027574f04151a9fded678fadba47441e) | 每 5 秒 10 次 |
| 根据订阅内容获取用户列表   | [`queryPeersBySubscriptionOption`](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#a063bd3db39660a7a3513378ce03f4456) | 每 5 秒 10 次 |


## 字符串大小限制

- 点对点或频道消息的字符串最大为 32 KB。详见 [`IMessage.setText`](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_message.html#a2e93098d5a3819e9d4cf8d42641474ae)。
- 呼叫邀请内容的字符串最大为 8 KB。详见 [`ILocalCallInvitation.setContent`](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_local_call_invitation.html#aaf4b356b7602cad2bdb998250617c920)。
- 呼叫邀请响应的字符串最大为 8 KB。详见 [`IRemoteCallInvitation.setResponse`](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_remote_call_invitation.html#a77c8a0902f9dce36525a66575a6ae8a5)。


## 编码格式限制

- 频道消息、点对点消息、呼叫邀请内容、呼叫邀请响应仅支持 UTF-8 编码格式。
- 以下方法的 `filePath` 参数都必须是 UTF-8 编码格式：
  - [`createFileMessageByUploading`](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#a99f2137ec43be135b369b7d6927b6138)
  - [`createImageMessageByUploading`](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#a7192d93f365c28e2d0b91547716fb5a9)
  - [`downloadMediaToFile`](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#a70584eb57e97476b1da072f737d88c95)

## 其它限制

- 当频道人数超过 512 人时，用户进出频道提示会被自动关闭。
- 对于单个实例，支持单次查询最多 256 个用户的在线状态。
- 对于单个实例，单次最多且总计只能订阅 512 人的在线状态。
- 对于单个实例，每个用户最多加入 20 个频道。
- 单次用户属性设置的最大值为 16 KB，单次频道属性设置的最大值为 32 KB，单条用户或频道属性（键值对）的最大值为 8 KB，单次属性操作设置的属性条目（键值对）不能超过 32 个。
- 每个上传文件或图片在 Agora 服务器上的保存时间最长为 7 天，上传文件或图片所对应的 media ID 有效期也为 7 天。
- 每个上传文件或图片不得超过 30 MB。
- 对于单个实例，同时最多支持 9 个上传和下载进程。