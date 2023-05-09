在聊天应用程序中，会话是单聊、群聊或者聊天室所有消息的集合。除了发送和接收消息外，即时通讯 IM SDK 还支持以会话为单位对本地的消息数据进行管理，如获取与管理未读消息、删除历史消息和搜索历史消息等。

本页介绍如何使用即时通讯 IM SDK 实现这些功能。

## 技术原理

即时通讯 IM iOS SDK 支持管理用户设备上存储的消息会话数据，SDK 内部使用 SQLCipher 保存本地消息，方便消息处理。主要功能如下：

- 加载本地存储的会话列表；
- 删除本地存储的会话；
- 获取指定会话的未读消息数；
- 删除指定会话；
- 从本地数据库中搜索消息；
- 在指定会话中插入消息。

## 前提条件

开始前，请确保满足以下条件：

- 完成 SDK 初始化，并连接到服务器，详见 [iOS 快速开始](./agora_chat_get_started_ios)。
- 了解即时通讯 IM 的 [使用限制](./agora_chat_limitation)。

## 实现方法

### 获取本地所有会话

你可以调用 API 获取本地所有会话：

```objective-c
NSArray *conversations = [[AgoraChatClient sharedClient].chatManager getAllConversations];
```

### 从数据库中读取指定会话的消息

可以从数据库中读取指定会话的消息：

```objective-c
// 获取指定会话 ID 的会话。
AgoraChatConversation *conversation = [[AgoraChatClient sharedClient].chatManager getConversation:conversationId type:type createIfNotExist:YES];
//SDK 初始化时，为每个会话加载 1 条历史消息。如需更多消息，请到数据库中获取。该方法获取 `startMsgId` 之前的 `count` 条消息，SDK 会将这些消息自动存入此会话，app 无需添加到会话中。
NSArray<AgoraChatMessage *> *messages = [conversation loadMessagesStartFromId:startMsgId count:count searchDirection:MessageSearchDirectionUp];
```

### 获取指定会话的未读消息数

你可以调用接口获取特定会话的未读消息数，示例代码如下：

```objective-c
// 获取指定会话 ID 的会话。
AgoraChatConversation *conversation = [[AgoraChatClient sharedClient].chatManager getConversation:conversationId type:type createIfNotExist:YES];
// 获取未读消息数。
NSInteger unreadCount = conversation.unreadMessagesCount;
```

### 获取所有会话的未读消息数

示例代码如下：

```objectivec
NSArray *conversations = [[AgoraChatClient sharedClient].chatManager getAllConversations];
NSInteger unreadCount = 0;
for (AgoraChatConversation *conversation in conversations) {
  unreadCount += conversation.unreadMessagesCount;
}
```

### 将指定会话的未读消息标记为已读

请参考以下代码示例，将指定的消息标记为已读：

```objectivec
AgoraChatConversation *conversation = [[AgoraChatClient sharedClient].chatManager getConversation:conversationId type:type createIfNotExist:YES];
// 将指定会话的消息未读数清零。
[conversation markAllMessagesAsRead:nil];
// 将一条消息置为已读。
[conversation markMessageAsReadWithId:messageId error:nil];
```

### 删除会话话和历史消息

SDK 提供两个接口，分别可以删除本地会话和历史消息或者删除当前用户在服务器端的会话和历史消息。

- 删除本地会话和历史消息示例代码如下：

```objective-c
// 删除指定会话，如果需要保留历史消息，`isDeleteMessages` 参数传 `NO`。
[[AgoraChatClient sharedClient].chatManager deleteConversation:conversationId isDeleteMessages:YES completion:nil];
// 删除一组会话。
NSArray *conversations = @{@"conversationID1",@"conversationID2"};
[[AgoraChatClient sharedClient].chatManager deleteConversations:conversations isDeleteMessages:YES completion:nil];
```

```objective-c
// 删除当前会话中指定的一条历史消息。
AgoraChatConversation *conversation = [[AgoraChatClient sharedClient].chatManager getConversation:conversationId type:type createIfNotExist:YES];
[conversation deleteMessageWithId:.messageId error:nil];
```

- 删除服务器端会话和历史消息，示例代码如下：

```objective-c
// 删除指定会话，如果需要保留历史消息，`isDeleteServerMessages` 参数传 `NO`。
[[AgoraChatClient sharedClient].chatManager deleteServerConversation:@"conversationId1" conversationType:AgoraChatConversationTypeChat isDeleteServerMessages:YES completion:^(NSString *aConversationId, AgoraChatError *aError) {
                // 删除回调
}];
```

### 根据关键字搜索会话消息

调用 `loadMessagesWithKeyword` 按关键字、时间戳和消息发送者搜索消息：

```objective-c
NSArray<AgoraChatMessage *> *messages = [conversation loadMessagesWithKeyword:keyword timestamp:0 count:50 fromUser:nil searchDirection:MessageSearchDirectionDown];
```

### 批量导入消息到数据库

调用 `importMessages` 以将多条消息导入指定对话。如果需要使用批量导入方式在本地会话中插入消息可以使用该接口。

```objective-c
[[AgoraChatClient sharedClient].chatManager importMessages:messages completion:nil];
```

### 插入消息

如果你需要在本地会话中加入一条消息，比如收到某些通知消息时，可以构造一条消息写入会话。
例如插入一条无需发送但有需要显示给用户看的内容，类似 “XXX 撤回一条消息”、“XXX 入群”、“对方正在输入” 等。

```objective-c
// 将消息插入到指定会话中。
AgoraChatConversation *conversation = [[AgoraChatClient sharedClient].chatManager getConversation:conversationId type:type createIfNotExist:YES];
[conversation insertMessage:message error:nil];
```

### 更新消息到 SDK 本地数据库

如果需要更新消息用以下方法：

```objective-c
[AgoraChatClient.sharedClient.chatManager updateMessage:message completion:^(AgoraChatChatMessage *aMessage, AgoraChatError *aError) {
     if (!aError) {
         // 更新本地消息完成。
     }
}];
```