# 管理本地消息

除了发送和接收消息外，即时通讯 IM Flutter SDK 还支持以会话为单位对本地的消息数据进行管理，如获取与管理未读消息、搜索和删除历史消息等。其中，会话是一个单聊、群聊或者聊天室所有消息的集合。用户需在会话中发送消息以及查看或清空历史消息。

本文介绍如何使用即时通讯 IM Flutter SDK 在 app 中实现这些功能。

## 技术原理

即时通讯 IM 使用 SQLCipher 加密存储本地消息的数据库。通过 `ChatManager` 和 `ChatConversation` 类管理本地消息。以下是核心方法：

- `ChatManager.loadAllConversations`：加载本地存储会话列表；
- `ChatManage.deleteConversation`：删除本地存储的会话；
- `ChatConversation.getUnreadMessageCount`：获取指定会话的未读消息数；
- `ChatManager.getUnreadMessageCount`：获取所有未读消息数；
- `ChatManager.deleteRemoteConversation`：删除服务端的会话及其历史消息；
- `ChatManager.searchMsgFromDB`：在本地存储的消息中搜索；
- `ChatConversation.insertMessage`：在指定会话中写入消息。

## 前提条件

开始前，请确保满足以下条件：

- 完成 SDK 初始化，并连接到服务器，详见 [快速开始](./agora_chat_get_started_flutter)。
- 了解 [使用限制](./agora_chat_limitation)。

## 实现方法

### 获取本地所有会话

你可以调用 `loadAllConversations` 获取本地所有的会话：

```dart
try {
  List<ChatConversation> lists =
      await ChatClient.getInstance.chatManager.loadAllConversations();
  // Loading conversations succeeds
} on ChatError catch (e) {
  // recall failed, code: e.code, reason: e.description
}
```

### 读取指定会话的消息

你可以根据会话 ID 和会话类型调用 API 获取本地会话：

```dart
// 会话 ID
String convId = "convId";
// 如果会话不存在是否创建。设置为 `true`，则会返回会话对象。
bool createIfNeed = true;
// 会话类型。详见 `EMConversationType` 枚举类型。
ChatConversationType conversationType = ChatConversationType.Chat;
// 执行操作
ChatConversation? conversation =
    await ChatClient.getInstance.chatManager.getConversation(
  convId,
  conversationType,
  true,
);
```

### 获取指定会话的未读消息数

你可以调用接口获取指定会话的未读消息数，示例代码如下：

```dart
int unreadCount = await conversation.unreadCount();
```

### 获取所有会话的未读消息数

你可以通过接口获取所有会话的未读消息数量，示例代码如下：

```dart
// 获取所有未读消息数
int unreadCount =
        await ChatClient.getInstance.chatManager.getUnreadMessageCount();
```

### 指定会话的未读消息数清零

你可以调用接口对会话中的特定消息设置为已读，示例代码如下：

```dart
await conversation.markMessageAsRead(message.msgId);
```

标记指定会话的所有消息已读：

```dart
await conversation.markAllMessagesAsRead();
```

将所有消息设为已读：

```dart
await ChatClient.getInstance.chatManager.markAllConversationsAsRead();
```

### 删除会话及其历史消息

SDK 提供两个接口，分别可以删除本地会话和历史消息或者删除当前用户在服务器端的会话和历史消息。

删除本地会话和历史消息，请调用 `deleteConversation`：

```dart
// 会话 ID
String conversationId = "conversationId";
// 删除会话时是否同时删除本地的历史消息
bool deleteMessage = true;
await ChatClient.getInstance.chatManager
    .deleteConversation(conversationId, deleteMessage);
```

```dart
// 删除本地指定会话中的指定消息
ChatConversation? conversation = await ChatClient.getInstance.chatManager
        .getConversation(conversationId);
    conversation?.deleteMessage(messageId);
```

删除服务器端会话和历史消息，请调用 `deleteRemoteConversation`：

```dart
// 会话 ID
String conversationId = "conversationId";
// 删除会话时是否同时删除服务端的历史消息
bool deleteMessage = true;
ChatConversationType conversationType = ChatConversationType.Chat;
await ChatClient.getInstance.chatManager.deleteRemoteConversation(
  conversationId,
  conversationType: conversationType,
  isDeleteMessage: deleteMessage,
);
```

### 根据关键字搜索会话消息

调用 `SearchMsgFromDB` 按关键字、时间戳和消息发送方搜索会话消息：

```dart
// 搜索关键字
String keywords = 'key';
// 搜索开始的 Unix 时间戳，单位为毫秒
int timestamp = 1653971593000;
// 搜索的最大消息数
int maxCount = 10;
// 消息发送者
String from = 'tom';
// 消息的搜索方向
EMSearchDirection direction = EMSearchDirection.Up;
List<ChatMessage> list =
    await ChatClient.getInstance.chatManager.searchMsgFromDB(
  keywords,
  timeStamp: timestamp,
  maxCount: maxCount,
  from: from,
  direction: direction,
);
```

### 批量导入消息到数据库

如果你需要使用批量导入方式在本地会话中插入消息，可以使用下面的接口，构造 `ChatMessage` 对象并调用 `importMessages`，将消息导入本地数据库。

```dart
// messages: 需要导入的消息。
await ChatClient.getInstance.chatManager.importMessages(messages);
```