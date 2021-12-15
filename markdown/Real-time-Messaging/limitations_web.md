---
title: 限制条件
platform: Android
updatedAt: 2020-09-03 11:46:12
---

本页面提供 Agora RTM Java SDK for Android 的使用限制条件。

> Agora RTM SDK 目前与 Agora Signaling SDK 暂未实现互通，互通功能将于近期实现。

## 多实例限制

最多支持同时加入 20 个 `RtmChannel` 频道。如果你同时加入的 `RtmChannel` 频道达到 20 个上限时建议在调用 [RtmChannel.leave()](/cn/Real-time-Messaging/RTM_web/API%20Reference/RTM_web/classes/rtmchannel.html#leave) 方法离开频道后再调用 `RtmChannel.removeAllListeners()` 方法彻底释放该频道占用资源。

## 调用频率限制

<style> table th:first-of-type {     width: 170px; } th:third-of-type {     width: 100px; }</style>

| 功能                                    | 函数                                                                                                                                                                                                                                         | 调用频率     |
| --------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------ |
| 登录到 Agora RTM 系统                   | [RtmClient.login](/cn/Real-time-Messaging/API%20Reference/RTM_web/classes/rtmclient.html#login)                                                                                                                                              | 2 次／秒     |
| 发送消息 (点对点和频道消息一并计算在内) | [RtmClient.sendMessageToPeer()](/cn/Real-time-Messaging/API%20Reference/RTM_web/classes/rtmclient.html#sendmessagetopeer) 和 [RtmChannel.SendMessage()](/cn/Real-time-Messaging/API%20Reference/RTM_web/classes/rtmchannel.html#sendmessage) | 60 次／秒    |
| 获取频道成员列表                        | [RtmChannel.getMembers](/cn/Real-time-Messaging/API%20Reference/RTM_web/classes/rtmchannel.html#getmembers)                                                                                                                                  | 每 2 秒 5 次 |

## 字符串长度限制

- 点对点或频道消息的字符串最大长度为 32 KB。详见： [RtmMessage.text](/cn/Real-time-Messaging/API%20Reference/RTM_web/interfaces/rtmmessage.html#text) 。
- 呼叫邀请内容的字符串最大长度为 8 KB。
- 呼叫邀请响应的字符串最大长度为 8 KB。

## 编码格式

仅支持发送 UTF-8 编码格式的频道消息和点对点消息。

## 其他

当频道人数超过 512 人时，用户上下线提示会被自动关闭。如有特殊要求，请请拨打 400 632 6626 或邮件 sales@agora.io。
