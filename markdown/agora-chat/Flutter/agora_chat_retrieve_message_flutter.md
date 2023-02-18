本文介绍用户如何从消息服务器获取会话和消息，该功能也称为消息漫游，指即时通讯服务将用户的历史消息保存在消息服务器上，用户即使切换终端设备，也能从服务器获取到单聊、群聊的历史消息，保持一致的会话场景。

## 技术原理

即时通讯 IM Flutter SDK 用 `ChatManager` 从服务器获取历史消息。以下是核心方法：

- `fetchConversationListFromServer` 分页获取服务器保存的会话列表；
- `fetchHistoryMessages` 获取服务器保存的指定会话中的消息。
- `deleteRemoteMessagesWithTs` / `deleteRemoteMessagesWithIds`: 根据消息时间或消息 ID 单向删除服务端的历史消息；
- `deleteRemoteConversation` 删除服务端的会话及其历史消息。

## 前提条件

开始前，请确保满足以下条件：

- 完成 SDK 初始化，并连接到服务器，详见 [快速开始](https://docs.agora.io/en/agora-chat/agora_chat_get_started_flutter?platform=Flutter)。
- 了解 [使用限制](https://docs.agora.io/en/agora-chat/agora_chat_limitation?platform=Flutter)。

## 实现方法

## 从服务器分页获取会话列表

调用 `fetchConversationListFromServer` 方法从服务端分页获取会话列表，每个会话包含最新一条历史消息。我们建议在 app 安装时或本地没有会话时，调用该方法。否则调用 `loadAllConversations` 方法获取本地设备上的会话列表。示例代码如下：

```dart
try {
  List<ChatConversation> list =
      await ChatClient.getInstance.chatManager.fetchConversationListFromServer(
    pageNum: pageNum,
    pageSize: pageSize,
  );
} on ChatError catch (e) {
}
```

对于还不支持`fetchConversationListFromServer`接口的用户，可以调用 `getConversationsFromServer` 从服务端获取会话列表。默认情况下，用户可拉取 7 天内的 10 个会话（每个会话包含最新一条历史消息），如需调整会话数量或时间限制请联系 [support@agora.io](mailto:support@agora.io)。

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
### 单向删除服务端的历史消息

你可以调用 `deleteRemoteMessagesWithTs` 和 `deleteRemoteMessagesWithIds` 方法单向删除服务端的历史消息，每次最多可删除 50 条消息。消息删除后，该用户无法从服务端拉取到该消息。其他用户不受该操作影响。已删除的消息自动从设备本地移除。

```dart
try {
  await ChatClient.getInstance.chatManager.deleteRemoteMessagesWithTs(
    conversationId: conversationId,
    type: convType,
    timestamp: timestamp,
  );
} on ChatError catch (e) {}

try {
  await ChatClient.getInstance.chatManager.deleteRemoteMessagesWithIds(
    conversationId: conversationId,
    type: convType,
    msgIds: msgIds,
  );
} on ChatError catch (e) {}
```

### 删除服务端会话及其历史消息

你可以调用 `deleteRemoteConversation` 方法删除服务器端会话和历史消息。会话删除后，当前用户和其他用户均无法从服务器获取该会话。若该会话的历史消息也删除，所有用户均无法从服务器获取该会话的消息。

```dart
try {
  await ChatClient.getInstance.chatManager.deleteRemoteConversation(
    conversationId,
  );
} on ChatError catch (e) {}
```
