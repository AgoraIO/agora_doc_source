# 消息管理–从服务器获取消息

本文介绍用户如何从消息服务器获取会话和消息，该功能也称为消息漫游，指即时通讯服务将用户的历史消息保存在消息服务器上，用户即使切换终端设备，也能从服务器获取到单聊、群聊的历史消息，保持一致的会话场景。

## 技术原理

使用即时通讯 IM iOS SDK 可以从服务器获取会话和历史消息。

- `getConversationsFromServer` 获取在服务器保存的会话列表；
- `asyncFetchHistoryMessagesFromServer` 获取服务器保存的指定会话中的消息。

## 前提条件

开始前，请确保满足以下条件：

- 完成 SDK 初始化，并连接到服务器，详见 [即时通讯 IM 入门](https://docs.agora.io/en/agora-chat/agora_chat_get_started_ios?platform=iOS)。
- 了解即时通讯 IM [使用限制](https://docs.agora.io/en/agora-chat/agora_chat_limitation?platform=iOS)。

## 实现方法

### 从服务器获取会话

默认情况下用户可拉取 7 天内的 10 个最新会话（每个会话包含最新一条历史消息），如需调整会话数量或时间限制请联系 [support@agora.io](mailto:support@agora.io)。

调用 `getConversationsFromServer` 从服务端获取会话。我们建议在 app 安装时，或本地没有会话时调用该 API。否则调用 `LoadAllConversations` 即可。示例代码如下：

```objectivec
[[AgoraChatClient sharedClient].chatManager getConversationsFromServer:^(NSArray *aCoversations, AgoraChatError *aError) {
   if (!aError) {
      for (AgoraConversation *conversation in aCoversations) {
        // conversation 会话解析。
      }
   }
}];
```

### 分页获取指定会话的历史消息

从服务器分页获取指定会话的历史消息（消息漫游）。

你可以指定消息查询方向，即明确按时间顺序或逆序获取。

建议每次获取少于 50 条消息，可多次获取。拉取后默认 SDK 会自动将消息更新到本地数据库。

```objectivec
[[AgoraChatClient sharedClient].chatManager asyncFetchHistoryMessagesFromServer:conversation.conversationId conversationType:conversation.type startMessageId:@"startMsgId" pageSize:10 completion:^(AgoraChatCursorResult<AgoraChatMessage *> * _Nullable aResult, AgoraChatError * _Nullable aError) {
        [conversation loadMessagesStartFromId:@"startMsgId" count:10 searchDirection:AgoraChatMessageSearchDirectionUp completion:nil];
    }];
```

## 下一步

实现从服务器获取消息后，您可以参考以下文档为您的应用添加更多消息功能：

- [消息回执](https://docs.agora.io/en/agora-chat/agora_chat_message_receipt_ios?platform=iOS)