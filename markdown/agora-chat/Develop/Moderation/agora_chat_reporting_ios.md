即时通讯 IM SDK 提供消息举报接口支持用户举报违规消息。当服务器端审核服务收到举报消息后，会将举报消息存储到数据库，并在声网控制台展示。审核员可在声网控制台查看举报记录，并进行相应处理。

## 技术原理

即时通讯 IM iOS SDK 提供 `reportMessage` 方法实现举报违规消息功能。

## 前提条件

开始前，请确保满足以下条件：

- 完成 SDK 初始化，并连接到服务器，详见 [iOS 快速开始](./agora_chat_get_started_ios)。
- 了解即时通讯 IM 的[使用限制](./agora_chat_limitation)。
- 已在声网控制台开启举报功能，详见[内容审核概述](./agora_chat_moderation_overview)。

## 实现方法

举报违规消息的示例代码如下：

```objective-c
// msgId：要举报的消息 ID。
// tag：非法消息的标签。你需要自行填写标签，例如`涉政`或`广告`。该字段对应声网控制台的消息举报记录页面的`词条标记`字段。
// reason：举报原因。你需要自行填写举报原因。该字段对应声网控制台的消息举报记录页面的`举报原因`字段。
[AgoraChatClient.sharedClient.chatManager reportMessageWithId:msgId
                                                       tag:tag
                                                    reason:reason
                                                completion:nil];
```