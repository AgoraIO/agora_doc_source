子区消息消息类型属于群聊消息类型，与普通群组消息的区别是需要添加 `isChatThread` 标记。本文介绍即时通讯 IM Flutter SDK 如何发送、接收以及撤回子区消息。

## 技术原理

即时通讯 IM Flutter SDK 提供 `ChatThreadManager`、`ChatMessage` 和 `ChatThread` 类，用于管理子区消息，支持你通过调用 API 在项目中实现如下功能：

- 发送子区消息
- 接收子区消息
- 撤回子区消息
- 获取子区消息

下图展示在客户端发送和接收消息的工作流程：

![img](https://web-cdn.agora.io/docs-files/1636443945728)

如上图所示，消息收发流程如下：

1. 用户 A 发送一条消息到消息服务器；
2. 对于子区消息，服务器投递给子区内其他每一个成员；
3. 用户收到消息。

## 前提条件

开始前，请确保满足以下条件：

- 完成 SDK 初始化，详见 [快速开始](./agora_chat_get_started_flutter)。
- 了解 [使用限制](./agora_chat_limitation)中所述。

在 [Agora 控制台](https://console.agora.io/) 中启用聊天后默认启用该功能。

## 实现方法

本节介绍如何使用即时通讯 IM Flutter SDK 提供的 API 实现上述功能。

### 发送子区消息

发送子区消息和发送群组消息的方法基本一致。区别在于 `isChatThreadMessage` 字段，如以下代码示例所示：

```dart
// targetGroup 为群组 ID
ChatMessage msg = ChatMessage.createTxtSendMessage(
  targetId: targetGroup,
  content: content,
);
// 设置为群组消息
msg.chatType = ChatType.GroupChat;
// isChatThreadMessage: 是否是子区消息，这里设置为 `true`，即是子区消息
msg.isChatThreadMessage = true;
ChatClient.getInstance.chatManager.sendMessage(msg);
```

有关发送消息的更多信息，请参阅 [发送消息](./agora_chat_send_receive_message_flutter#发送消息)。

### 接收子区消息

接收消息的具体逻辑，请参考 [接收消息](./agora_chat_send_receive_message_flutter#接收消息)，此处只介绍子区消息和其他消息的区别。

子区有新增消息时，子区所属群组的所有成员收到 `ChatThreadEventHandler#onChatThreadUpdated` 事件，子区成员收到 `ChatEventHandler#onMessagesReceived` 事件。

示例代码如下：

```dart
// 注册子区监听
  ChatClient.getInstance.chatManager.addEventHandler(
    "UNIQUE_HANDLER_ID",
    ChatEventHandler(
      onMessagesReceived: (messages) {},
    ),
  );

// 添加消息监听
  ChatClient.getInstance.chatThreadManager.addEventHandler(
    "UNIQUE_HANDLER_ID",
    ChatThreadEventHandler(
      onChatThreadUpdate: (event) {},
    ),
  );
  ...
 // 移除子区监听
  ChatClient.getInstance.chatManager.removeEventHandler("UNIQUE_HANDLER_ID");
    // 移除消息监听
  ChatClient.getInstance.chatThreadManager.removeEventHandler("UNIQUE_HANDLER_ID");
```

有关接收消息的更多信息，请参阅[接收消息](./agora_chat_send_receive_message_flutter#接收消息)。

### 撤回子区消息

接收消息的具体逻辑，请参考 [撤回消息](./agora_chat_send_receive_message_flutter#撤回消息)，此处只介绍子区消息和其他消息的区别。

子区有消息撤回时，子区所属群组的所有成员收到 `ChatThreadEventHandler#onChatThreadUpdated` 事件，子区成员收到 `ChatEventHandler#onMessagesRecalled` 事件。

示例代码如下：

```dart
// 注册子区监听
  ChatClient.getInstance.chatManager.addEventHandler(
    "UNIQUE_HANDLER_ID",
    ChatEventHandler(
      onMessagesRecalled: (messages) {},
    ),
  );

// 添加消息监听
  ChatClient.getInstance.chatThreadManager.addEventHandler(
    "UNIQUE_HANDLER_ID",
    ChatThreadEventHandler(
      onChatThreadUpdate: (event) {},
    ),
  );
  ...
// 移除子区监听
  ChatClient.getInstance.chatManager.removeEventHandler("UNIQUE_HANDLER_ID");
// 移除消息监听
  ChatClient.getInstance.chatThreadManager.removeEventHandler("UNIQUE_HANDLER_ID");
```

### 从服务器获取子区消息 (消息漫游)

有关如何从服务器获取消息的详细信息，请参阅从服务器[从服务器获取会话和消息](./agora_chat_retrieve_message_flutter)。