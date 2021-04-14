---
title: 限制条件
platform: Android
updatedAt: 2021-01-19 10:42:18
---

本页简要介绍 Agora RTM Objective-C SDK for iOS 或 Agora RTM Objective-C SDK for macOS 的使用限制条件，包括调用频率、字符串大小、编码格式等。


## 调用频率限制

所有的调用频率都针对单个 <code>AgoraRtmKit</code> 实例。如果一个操作对应多个方法，则此操作在单位时间内的调用次数等于所有方法单位时间内的调用次数之和。

<div class="alert note">你可以通过创建多个实例提高 API 的调用频率。</div>

<style> table th:first-of-type {     width: 300px; } th:third-of-type {     width: 100px; }</style>

| 操作                                                  | 方法                                                      | 调用频率限制                |
| ----------------------------------------------------------- | ------------------------------------------------------------ | ------------------------------ |
| 登录 Agora RTM 系统                              | [`loginByToken`](/cn/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmKit.html#//api/name/createChannelWithId:delegate:) | 每秒 2 次         |
| 查询单个或多个频道的成员人数 | [`getChannelMemberCount`](/cn/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmKit.html#//api/name/getChannelMemberCount:completion:) | 每秒 1 次 |
| 每次都加入不同频道 | [`joinWithCompletion`](/cn/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmChannel.html#//api/name/joinWithCompletion:) | 每 3 秒 50 次 |
| 每次都加入同一个频道 | [`joinWithCompletion`](/cn/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmChannel.html#//api/name/joinWithCompletion:) | 每 5 秒 2 次 |
| 发送消息  | <li>[`sendMessage`](/cn/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmKit.html#//api/name/sendMessage:toPeer:completion:)</li><li>[`sendMessage`](/cn/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmKit.html#//api/name/sendMessage:toPeer:sendMessageOptions:completion:)</li> <li> [`sendMessage`](/cn/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmChannel.html#//api/name/sendMessage:completion:)</li> <li>[`sendMessage`](/cn/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmChannel.html#//api/name/sendMessage:sendMessageOptions:completion:)</li>  | 每 3 秒 180 次        |
| 获取频道成员列表                    | [`getMembersWithCompletion:`](/cn/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmChannel.html#//api/name/getMembersWithCompletion:) | 每 2 秒 5 次 |
| 更新 token | [`renewToken`](/cn/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmKit.html#//api/name/renewToken:completion:) | 每秒 2 次 |
| 查询指定用户在线状态 | [`queryPeersOnlineStatus`](/cn/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmKit.html#//api/name/queryPeersOnlineStatus:completion:) | 每 5 秒 10 次 |
| 用户属性增删修改| <li>[`setLocalUserAttributes`](/cn/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmKit.html#//api/name/setLocalUserAttributes:completion:)</li><li>[`addOrUpdateLocalUserAttributes`](/cn/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmKit.html#//api/name/addOrUpdateLocalUserAttributes:completion:)</li><li>[`deleteLocalUserAttributesByKeys`](/cn/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmKit.html#//api/name/deleteLocalUserAttributesByKeys:completion:)</li><li>[`clearLocalUserAttributes`](/cn/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmKit.html#//api/name/clearLocalUserAttributesWithCompletion:)</li> | 每 5 秒 10 次          |
| 用户属性查询| <li>[`getUserAttributes`](/cn/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmKit.html#//api/name/getUserAllAttributes:completion:)</li><li>[`getUserAttributesByKeys`](/cn/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmKit.html#//api/name/getUserAttributes:ByKeys:completion:)</li> | 每 5 秒 40 次          |
| 频道属性增删修改| <li>[`setChannelAttributes`](/cn/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmKit.html#//api/name/setChannel:Attributes:Options:completion:)</li><li>[`addOrUpdateChannelAttributes`](/cn/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmKit.html#//api/name/addOrUpdateChannel:Attributes:Options:completion:)</li><li>[`deleteChannelAttributesByKeys`](/cn/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmKit.html#//api/name/deleteChannel:AttributesByKeys:Options:completion:)</li><li>[`clearChannelAttributes`](/cn/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmKit.html#//api/name/clearChannel:Options:AttributesWithCompletion:)</li> | 每 5 秒 10 次          |
| 频道属性查询| <li>[`getChannelAttributes`](/cn/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmKit.html#//api/name/getChannelAllAttributes:completion:) </li><li>[`getChannelAttributesByKeys`](/cn/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmKit.html#//api/name/getChannelAttributes:ByKeys:completion:)</li> | 每 5 秒 10 次          |
| 订阅指定单个或多个用户的在线状态   | [`subscribePeersOnlineStatus`](/cn/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmKit.html#//api/name/subscribePeersOnlineStatus:completion:) | 每 5 秒 10 次 |
| 取消订阅指定单个或多个用户的在线状态    | [`unSubscribePeersOnlineStatus`](/cn/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmKit.html#//api/name/unsubscribePeersOnlineStatus:completion:) | 每 5 秒 10 次 |
| 根据订阅内容获取用户列表   | [`queryPeersBySubscriptionOption`](/cn/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmKit.html#//api/name/queryPeersBySubscriptionOption:completion:) | 每 5 秒 10 次 |

	
	
## 字符串大小限制

- 点对点或频道消息的字符串最大为 32 KB。详见 [`AgoraRtmMessage`](/cn/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmMessage.html)。
- 呼叫邀请内容的字符串最大为 8 KB。详见 [`AgoraRtmLocalInvitation`](/cn/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmLocalInvitation.html)。
- 呼叫邀请响应的字符串最大为 8 KB。详见 [`AgoraRtmRemoteInvitation`](/cn/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmRemoteInvitation.html)。

## 编码格式限制

- 频道消息、点对点消息、呼叫邀请内容、呼叫邀请响应仅支持 UTF-8 编码格式。
- 以下方法的 `filePath` 参数都必须是 UTF-8 编码格式:
  - [`createFileMessageByUploading:withRequest:completion:`](/cn/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmKit.html#//api/name/createFileMessageByUploading:withRequest:completion:)
  - [`createImageMessageByUploading:withRequest:completion:`](/cn/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmKit.html#//api/name/createImageMessageByUploading:withRequest:completion:)
  - [`downloadMedia:toFile:withRequest:completion:`](/cn/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmKit.html#//api/name/downloadMedia:toFile:withRequest:completion:) 

## 其它限制

- 当频道人数超过 512 人时，用户进出频道的提示会被自动关闭。Agora 建议你在自己的业务服务器调用[获取用户加入或离开频道事件 RESTful API](/cn/Real-time-Messaging/rtm_get_event?platform=All%20Platforms) 获取进出频道通知。
- 对于单个实例，支持单次查询最多 256 个用户的在线状态。
- 对于单个实例，单次最多且总计只能订阅 512 人的在线状态。你无法通过多次订阅来突破人数限制。如果频道人数超过 512，SDK 会随机返回其中的 512 人。
- 对于单个实例，每个用户最多同时加入 20 个频道。
- 单次用户属性设置的最大值为 16 KB，单次频道属性设置的最大值为 32 KB，单条用户或频道属性（键值对）的最大值为 8 KB，单次属性操作设置的属性条目（键值对）不能超过 32 个。
- 每个上传文件或图片在 Agora 服务器上的保存时间最长为 7 天，上传文件或图片所对应的 media ID 有效期也为 7 天。
- 每个上传文件或图片不得超过 30 MB。
- 对于单个实例，同时最多支持 9 个上传和下载进程。