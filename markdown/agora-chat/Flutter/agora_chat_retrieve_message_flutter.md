本文介绍用户如何从消息服务器获取会话和消息，该功能也称为消息漫游，指即时通讯服务将用户的历史消息保存在消息服务器上，用户即使切换终端设备，也能从服务器获取到单聊、群聊的历史消息，保持一致的会话场景。

## 技术原理

即时通讯 IM Flutter SDK 用 `ChatManager` 从服务器获取历史消息。以下是核心方法：

- `getConversationsFromServer` 获取服务器保存的会话列表；
- `fetchHistoryMessages` 获取服务器保存的指定会话中的消息。

## 前提条件

开始前，请确保满足以下条件：

- 完成 SDK 初始化，并连接到服务器，详见 [快速开始](https://docs.agora.io/en/agora-chat/agora_chat_get_started_flutter?platform=Flutter)。
- 了解 [使用限制](https://docs.agora.io/en/agora-chat/agora_chat_limitation?platform=Flutter)。

## 实现方法

### 从服务器获取会话

调用 `getConversationsFromServer` 从服务端获取会话。我们建议在 app 安装时或本地没有会话时，调用该 API。否则调用 `loadAllConversations` 即可。示例代码如下：

```dart
try {
  List<ChatConversation> list =
      await ChatClient.getInstance.chatManager.getConversationsFromServer();
} on ChatError catch (e) {
}
```

默认情况下，SDK 会获取过去 7 天内的最后 10 个会话，每个会话包含最后一条历史消息。如需调整时间限制或获取到的会话数量，请联系 [support@agora.io](mailto:support@agora.io)。

### 分页获取指定会话的历史消息

你还可以从服务器分页获取指定会话的历史消息，实现消息漫游功能。为确保数据可靠，我们建议你多次调用该方法，且每次获取的消息数小于 50 条。获取到数据后，SDK 会自动将消息更新到本地数据库。

```dart
try {
  // 会话 ID
  String convId = "convId";
  // 会话类型
  ChatConversationType convType = ChatConversationType.Chat;
  // 获取的最大消息数
  int pageSize = 10;
  // 搜索的起始消息 ID
  String startMsgId = "";
  ChatCursorResult<ChatMessage?> cursor =
      await ChatClient.getInstance.chatManager.fetchHistoryMessages(
    conversationId: convId,
    type: convType,
    pageSize: pageSize,
    startMsgId: startMsgId,
  );
} on ChatError catch (e) {
}
```