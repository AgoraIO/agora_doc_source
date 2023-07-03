子区消息属于群聊消息类，与普通群消息的区别是需要添加 `isChatThread` 标记。本文介绍即时通讯 IM iOS SDK 如何发送、接收、撤回以及获取子区消息。

## 技术原理

即时通讯 IM iOS SDK 提供 `AgoraChatManager`、`AgoraChatMessage` 和 `AgoraChatThread` 类，可以实现以下功能：

- 发送子区消息
- 接收子区消息
- 撤回子区消息
- 从服务端获取子区消息（消息漫游）

消息收发流程如下图所示：

![](https://web-cdn.agora.io/docs-files/1681365338435)

![img](./agora_doc_source/markdown/agora-chat/images/quickstart/quick_start_workflow.png)

1. 客户端从应用服务器获取 token。
2. 客户端 A 和 B 登录即时通讯。
3. 客户端 A 向客户端 B 发送消息。消息发送至即时通讯 IM 服务器，服务器将消息传递给客户端 B。客户端 B 收到消息后，SDK 触发事件。客户端 B 监听事件并获取消息。

## 前提条件

开始前，请确保满足以下条件：

- 完成 SDK 初始化，详见 [iOS 快速开始](./agora_chat_get_started_ios)。
- 了解即时通讯 IM 的[使用限制](./agora_chat_limitation)。

每个版本的[套餐包](./agora_chat_pricing#管理套餐包)都支持子区功能。在[声网控制台](https://console.agora.io/)中启用即时通讯服务后默认开启子区功能。

## 实现方法

本节介绍如何使用即时通讯 IM SDK 提供的 API 实现上述功能。

### 发送子区消息

发送子区消息和发送群组消息的方式基本一致，区别在于需传入子区 ID 且将 `isChatThread` 字段设置为 `YES`，如以下示例代码所示：

```objective-c
// 调用 `initWithConversationID` 创建一条文本消息
// 设置 `*message` 为消息文字内容
// 设置 `*chatThreadId` 为子区 ID
NSString *from = [[AgoraChatClient sharedClient] currentUsername];
NSString *chatThreadId = self.currentConversation.conversationId;
AgoraChatMessage *message = [[AgoraChatMessage alloc] initWithConversationID:chatThreadId from:from to:chatThreadId body:aBody ext:aExt];
    // 是否需要消息已读回执。
if([aExt objectForKey:MSG_EXT_READ_RECEIPT]) {
    message.isNeedGroupAck = YES;
}
// 设置 `chatType` 为 `AgoraChatTypeGroupChat`，即群聊。
message.chatType = (AgoraChatType)self.conversationType;
// 设置 `isChatThread` 为 `YES` 标记为子区消息。
message.isChatThreadMessage = self.isChatThread;
// 发送消息。
[[AgoraChatClient sharedClient].chatManager sendMessage:message progress:nil completion:^(AgoraChatMessage *message, AgoraChatError *error) {

}];
```

关于发送消息的逻辑，详见[发送消息](./agora_chat_send_receive_message_ios#发送文本消息)。

### 接收子区消息

单设备登录时，子区所属群组的所有成员会收到 `AgoraChatThreadManagerDelegate#onChatThreadUpdated` 回调。子区成员也可以通过监听 `AgoraChatManagerDelegate#messagesDidReceive` 回调接收子区消息，如下代码示例所示：

```objective-c
// 收到消息时，SDK 触发 `messagesDidReceive` 回调。收到该回调后，SDK 解析并显示消息。
- (void)messagesDidReceive:(NSArray *)aMessages
{
    // 做相关处理。
}
// 添加消息监听器。
[[AgoraChatClient sharedClient].chatManager addDelegate:self delegateQueue:nil];
// 移除消息监听器。
[[AgoraChatClient sharedClient].chatManager removeDelegate:self];
```

关于接收消息的具体逻辑，详见[接收消息](./agora_chat_send_receive_message_ios#接收文本消息)。

### 撤回子区消息

在子区中撤回消息后，所有群组成员都会收到 `AgoraChatThreadManagerDelegate#onChatThreadUpdated` 回调。子区成员也可以监听 `AgoraChatManagerDelegate#messagesInfoDidRecall` 回调，如下代码示例所示：

```objective-c
- (void)messagesInfoDidRecall:(NSArray<EMRecallMessageInfo *> *)aRecallMessagesInfo
{}
```

关于撤回消息的逻辑，详见[撤回消息](./agora_chat_send_receive_message_ios#撤回消息)。

### 获取子区消息

从服务器还是本地数据库获取子区消息取决于你的生产环境。

你可以通过 `AgoraChatConversation#isChatThread()` 判断当前会话是否为子区会话。

### 从服务器获取子区消息 (消息漫游)

调用 `AgoraChatManager#asyncFetchHistoryMessagesFromServer` 方法从服务器获取子区消息。从服务器获取子区消息与获取群组消息的唯一区别为前者需传入子区 ID，后者需传入群组 ID。

```objective-c
[AgoraChatClient.sharedClient.chatManager asyncFetchHistoryMessagesFromServer:@"threadId" conversationType:AgoraChatConversationTypeGroupChat startMessageId:@"" fetchDirection:AgoraChatMessageFetchHistoryDirectionUp pageSize:20 completion:^(AgoraChatCursorResult<AgoraChatMessage *> * _Nullable aResult, AgoraChatError * _Nullable aError) {
            
    }];
```

#### 从本地获取单个子区的消息

调用 `AgoraChatManager#getAllConversations` 方法只能获取单聊或群聊会话。你可以调用以下方法从本地获取单个子区的消息：

```objective-c
// 需设置会话类型为 `AgoraChatConversationTypeGroupChat` 和 `isThread` 为 `YES`
AgoraChatConversation* conversation = [AgoraChatClient.sharedClient.chatManager getConversation:conversationId type:AgoraChatConversationTypeGroupChat createIfNotExist:NO isThread:YES];
// 获取该子区会话的消息。
[conversation loadMessagesStartFromId:@"" count:20 searchDirection:AgoraChatMessageSearchDirectionUp completion:^(NSArray<AgoraChatMessage *> * _Nullable aMessages, AgoraChatError * _Nullable aError) {
           
}];
```