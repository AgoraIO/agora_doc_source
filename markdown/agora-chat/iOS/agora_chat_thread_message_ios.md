# 管理子区消息 iOS

子区消息消息类型属于群聊消息类型。本文介绍即时通讯 IM iOS SDK 如何发送、接收以及撤回子区消息。

## 技术原理

即时通讯 IM iOS SDK 提供 `AgoraChatManager`、`AgoraChatMessage` 和 `AgoraChatThread` 类，可以实现以下功能：

- 发送子区消息
- 接收子区消息
- 撤回子区消息
- 从服务端获取子区消息（消息漫游）

消息收发流程如下：

![img](https://web-cdn.agora.io/docs-files/1636443945728)

如图所示，点对点消息的工作流程如下：

1. 用户 A 发送一条消息到环信的消息服务器;
2. 单聊时消息时，服务器投递消息给用户 B；对于群聊时消息，服务器投递给群内其他每一个成员;
3. 用户收到消息。

## 前提条件

开始前，请确保满足以下条件：

- 完成 SDK 初始化，详见 [iOS 入门](https://docs.agora.io/en/agora-chat/agora_chat_get_started_ios?platform=iOS)。
- 了解即时通讯 IM 的 [使用限制](https://docs.agora.io/en/agora-chat/agora_chat_limitation?platform=iOS)。

所有类型的 [定价计划](https://docs.agora.io/en/agora-chat/agora_chat_plan) 都支持子区功能，并且在 [Agora 控制台](https://console.agora.io/) 中启用即时通讯服务后默认启用子区功能。

## 实现方法

本节介绍如何使用即时通讯 IM SDK 提供的 API 实现上述功能。

### 发送子区消息

发送子区消息和发送群组消息的方法基本一致，区别在于 `isChatThread` 字段，如以下代码示例所示：

```objective-c
// 调用 `initWithConversationID` 创建一条文本消息
// 设置 `*message` 为消息文字内容
// 设置 `*to` 为子区 ID
NSString *from = [[AgoraChatClient sharedClient] currentUsername];
NSString *to = self.currentConversation.conversationId;
AgoraChatMessage *message = [[AgoraChatMessage alloc] initWithConversationID:to from:from to:to body:aBody ext:aExt];
    // 是否需要消息已读回执。
if([aExt objectForKey:MSG_EXT_READ_RECEIPT]) {
    message.isNeedGroupAck = YES;
}
// 设置 `chatType` 为 `AgoraChatTypeGroupChat` 标示为群组消息
message.chatType = (AgoraChatType)self.conversationType;
// 设置 `isChatThread` 为 `YES` 标记为子区消息
message.isChatThreadMessage = self.isChatThread;
// 发送消息。
[[AgoraChatClient sharedClient].chatManager sendMessage:message progress:nil completion:^(AgoraChatMessage *message, AgoraChatError *error) {

}];
```

有关发送消息的更多信息，请参阅 [发送消息](https://docs.agora.io/en/agora-chat/agora_chat_message_ios?platform=iOS#send-and-receive-messages)。

### 接收子区消息

单设备登录时，子区所属群组的所有成员会收到 `AgoraChatThreadManagerDelegate#onChatThreadUpdated` 回调。子区成员也可以通过监听 `AgoraChatManagerDelegate#messagesDidReceive` 回调来接收子区消息，如下代码示例所示：

```objective-c
// The SDK triggers the `messagesDidReceive` callback when it receives a message.
// After receiving this callback, the SDK parses the message and displays it.
- (void)messagesDidReceive:(NSArray *)aMessages
{
    // 做相关处理。
}
// 添加消息监听器。
[[AgoraChatClient sharedClient].chatManager addDelegate:self delegateQueue:nil];
// 移除消息监听器。
[[AgoraChatClient sharedClient].chatManager removeDelegate:self];
```

有关接收消息的更多信息，请参阅 [接收消息](https://docs.agora.io/en/agora-chat/agora_chat_message_ios?platform=iOS#send-and-receive-messages)。

### 撤回子区消息

有关如何撤回消息的详细信息，请参阅 [撤回消息](https://docs.agora.io/en/agora-chat/agora_chat_message_ios?platform=iOS#recall-messages)，此处只介绍子区消息和其他消息的区别。

在子区中撤回消息后，所有群组成员都会收到 `AgoraChatThreadManagerDelegate#onChatThreadUpdated` 回调。子区成员也可以监听 `AgoraChatManagerDelegate#messagesInfoDidRecall` 回调，如下代码示例所示：

```objective-c
- (void)messagesInfoDidRecall:(NSArray<EMRecallMessageInfo *> *)aRecallMessagesInfo
{}
```

### 从服务器获取子区消息 (消息漫游)

进入单个子区会话后默认展示最早消息，iOS 端默认直接从服务器按时间顺序获取子区历史消息。

关于如何从服务器获取消息的详细信息，请参见 [从服务器获取消息](https://docs.agora.io/en/agora-chat/agora_chat_message_ios?platform=iOS#retrieve-historical-messages-from-the-server)。