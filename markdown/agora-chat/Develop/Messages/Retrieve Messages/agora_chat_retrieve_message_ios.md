即时通讯 IM 提供消息漫游功能，即将用户的所有会话的历史消息保存在消息服务器，用户在任何一个终端设备上都能获取到历史信息，使用户在多个设备切换使用的情况下也能保持一致的会话场景。

本文介绍如何实现用户从消息服务器获取会话和消息。

## 技术原理

即时通讯 IM SDK 通过 `IAgoraChatManager` 类从服务器获取历史消息。以下是核心方法：

- `getConversationsFromServer` 获取会话列表以及会话中的最新一条消息；
- `asyncFetchHistoryMessagesFromServer` 获取服务器保存的指定会话中的消息。

## 前提条件

开始前，请确保满足以下条件：

- 完成 SDK 初始化，并连接到服务器，详见 [iOS 快速开始](./agora_chat_get_started_ios)。
- 了解即时通讯 IM API 的调用频率限制，详见 [限制条件](./agora_chat_limitation)。

## 实现方法

### 从服务器获取会话列表

你可以调用 `getConversationsFromServer` 从服务端获取会话。我们建议在 app 安装时，或本地没有会话时调用该 API。否则调用 `LoadAllConversations` 即可。示例代码如下：

```objectivec
[[AgoraChatClient sharedClient].chatManager getConversationsFromServer:^(NSArray *aConversations, AgoraChatError *aError) {
   if (!aError) {
      for (AgoraConversation *conversation in aConversations) {
        // conversation 会话解析。
      }
   }
}];
```

默认情况下，SDK 会获取 7 天内的 10 个最新会话，每个会话包含一条最新历史消息。如需调整时间限制或会话数量，请联系 [support@agora.io](mailto:support@agora.io)。

### 从服务器获取指定会话的历史消息

你可以调用 `asyncFetchHistoryMessagesFromServer` 方法从服务器获取指定会话的消息（消息漫游）。你可以指定消息查询方向，即明确按服务器接收消息的时间顺序或时间倒序获取消息。为确保数据可靠，我们建议你每次获取少于 50 条消息，可多次获取。拉取后默认 SDK 会自动将消息更新到本地数据库。

```objectivec
[[AgoraChatClient sharedClient].chatManager asyncFetchHistoryMessagesFromServer:conversation.conversationId conversationType:conversation.type startMessageId:@"startMsgId" pageSize:10 completion:^(AgoraChatCursorResult<AgoraChatMessage *> * _Nullable aResult, AgoraChatError * _Nullable aError) {
        [conversation loadMessagesStartFromId:@"startMsgId" count:10 searchDirection:AgoraChatMessageSearchDirectionUp completion:nil];
    }];
```

## 后续步骤

实现从服务器获取消息后，您可以参考以下文档为您的应用添加更多消息功能：

- [消息回执](./agora_chat_message_receipt_ios)