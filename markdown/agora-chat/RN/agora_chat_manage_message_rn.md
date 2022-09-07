本文介绍即时通讯 IM React Native SDK 如何管理本地消息数据。

除了发送和接收消息外，即时通讯 IM SDK 还支持以会话为单位对本地的消息数据进行管理，如获取与管理未读消息、删除聊天记录、搜索历史消息等。其中，会话是一个单聊、群聊或者聊天室所有消息的集合。用户需在会话中发送消息或查看历史消息，还可进行清空聊天记录等操作。

## 技术原理

SDK 使用 `ChatManager` 和 `ChatConversation` 类支持管理用户设备上存储的消息会话数据，SDK 内部使用 SQLCipher 保存本地消息，方便消息处理。

以下是核心方法：

- `ChatManager.getAllConversations`：加载本地存储的会话列表；
- `ChatManage.deleteConversation`：删除指定的本地会话。
- `ChatConversation.getConversationUnreadCount`：获取指定会话的未读消息数；
- `ChatManager.getUnreadCount`：获取所有未读消息计数。
- `ChatManager.removeConversationFromServer`：从服务器中删除会话和历史消息。
- `ChatManager.searchMsgFromDB`：从本地数据库中搜索消息。

## 前提条件

开始前，请确保满足以下条件：

- 完成 SDK 初始化，并连接到服务器，详见 [RN 快速开始](./agora_chat_get_started_rn)。
- 了解即时通讯 IM 的 [使用限制](./agora_chat_limitation)。

## 实现方法

### 获取本地所有会话

调用 `getAllConversations` 以获取本地设备上的所有会话：

```typescript
ChatClient.getInstance()
  .chatManager.getAllConversations()
  .then(() => {
    console.log("Loading conversations succeeds");
  })
  .catch((reason) => {
    console.log("Loading conversations fails", reason);
  });
```

### 从数据库中读取指定会话的消息

可以通过指定会话 ID 和会话类型从本地数据库中搜素指定会话中的消息：

```typescript
// 会话 ID
const convId = "convId";
// 会话不存在时是否创建会话。设置为 `true` 则创建会话。
const createIfNeed = true;
// 会话类型。详见 `ChatConversationType` 枚举类型。
const convType = ChatConversationType.PeerChat;
// 调用 `getConversation` 方法
ChatClient.getInstance()
  .chatManager.getConversation(convId, convType, createIfNeed)
  .then((message) => {
    console.log("Getting conversations succeeds", message);
  })
  .catch((reason) => {
    console.log("Getting conversations fails.", reason);
  });
```

### 获取指定会话的未读消息数

你可以调用接口获取特定会话的未读消息数，示例代码如下：

```typescript
// 指定会话 ID 的会话。
const convId = "convId";
// 指定会话类型。具体见 `ChatConversationType`。
const convType = ChatConversationType.PeerChat;
// 调用 `getConversationUnreadCount` 获取未读消息数。
ChatClient.getInstance()
  .chatManager.getConversationUnreadCount(convId, convType)
  .then((count) => {
    console.log("Getting conversations succeeds: ", count);
  })
  .catch((reason) => {
    console.log("Getting conversations fails.", reason);
  });
```

### 获取所有会话的未读消息数

示例代码如下：

```typescript
ChatClient.getInstance()
  .chatManager.getUnreadCount()
  .then((count) => {
    console.log("Getting all conversations succeeds: ", count);
  })
  .catch((reason) => {
    console.log("Getting all conversations fails.", reason);
  });
```

### 将指定会话的未读消息标记为已读

请参考以下代码示例，将指定的消息标记为已读：

```typescript
// 指定会话 ID。
const convId = "convId";
// 指定需要标为已读的消息 ID。
const msgId = "100";
// 指定会话类型，具体见 `ChatConversationType`。
const convType = ChatConversationType.PeerChat;
// 调用 `markMessageAsRead` 将消息置为已读。
ChatClient.getInstance()
  .chatManager.markMessageAsRead(convId, convType, msgId)
  .then(() => {
    console.log("Marking message read succeeds: ");
  })
  .catch((reason) => {
    console.log("Marking message read fails.", reason);
  });
```

你还可以将指定会话的所有未读消息标记为已读：

```typescript
// 调用 `markAllMessagesAsRead` 标记会话所有消息已读。
ChatClient.getInstance()
  .chatManager.markAllMessagesAsRead("convId", ChatConversationType.PeerChat)
  .then((count) => {
    console.log("Marking conversations read succeeds: ", count);
  })
  .catch((reason) => {
    console.log("Marking conversations read fails.", reason);
  });
```

### 删除会话和历史消息

SDK 提供两个接口，分别可以删除本地会话和聊天记录或者删除当前用户在服务器端的会话和聊天记录。

- 删除本地会话和聊天记录，请调用 `deleteConversation`：

```typescript
// 指定会话 ID。
const convId = "convId";
// 是否删除会话对应的历史消息。
const withMessage = true;
// 调用 `deleteConversation` 删除会话。
ChatClient.getInstance()
  .chatManager.deleteConversation(convId, withMessage)
  .then(() => {
    console.log("Removing conversations succeeds: ");
  })
  .catch((reason) => {
    console.log("Removing conversations fails.", reason);
  });
```

- 删除服务器端会话和聊天记录，请调用 `removeConversationFromServer`：

```typescript
// convId：会话 ID
const convId = "convId";
// 是否删除会话对应的历史消息。
const isDeleteMessage = true;
// convType: 会话类型，详见 `ChatConversationType`。
const convType = ChatConversationType.PeerChat;
// 调用 `removeConversationFromServer` 删除服务器会话
ChatClient.getInstance()
  .chatManager.removeConversationFromServer(convId, convType, isDeleteMessage)
  .then(() => {
    console.log("Removing conversations succeeds: ");
  })
  .catch((reason) => {
    console.log("Removing conversations fails.", reason);
  });
```

### 根据关键字搜索会话消息

调用 `SearchMsgFromDB` 按关键字、时间戳和消息发送者搜索消息：

```typescript
// keywords: 搜索消息的关键字
// timestamp：起始时间戳
// maxCount: 期望获取的最大消息数
// from: 消息的发送者
// direction：消息的搜索方向，具体见 `ChatSearchDirection`
const keywords = 'key';
const timestamp = 10000000;
const maxCount = 10;
const from = 'tom';
const direction = ChatSearchDirection.UP;
// 调用 `searchMsgFromDB` 搜索
ChatClient.getInstance().chatManager.searchMsgFromDB(
              keywords,
              timestamp,
              maxCount,
              from,
              direction
            )
  .then((messages[]) => {
    console.log("Searching conversations succeeds: ", messages);
  })
  .catch((reason) => {
    console.log("Searching conversations fails.", reason);
  });
```

### 导入消息

调用 `importMessages` 以将多条消息导入指定会话。这适用于聊天用户想要从另一个对话中形成消息的场景。

```typescript
// 将消息插入到指定会话中。
const msgs = [];
ChatClient.getInstance()
  // 调用 `importMessages` 导入消息
  .chatManager.importMessages(msgs)
  .then(() => {
    console.log("Importing conversations succeeds: ");
  })
  .catch((reason) => {
    console.log("Importing conversations fails.", reason);
  });
```

## 下一步

实现消息管理后，你可以参考以下文档为应用添加更多消息功能：

- [从服务器获取会话和消息](./agora_chat_retrieve_message_rn)
- [消息回执](./agora_chat_message_receipt_rn)