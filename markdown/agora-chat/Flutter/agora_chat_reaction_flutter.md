表情符号被广泛用于实时聊天，因为它们允许用户以直接和生动的方式表达自己的感受。在即时通讯 IM 中，消息表情回复（下文统称 “Reaction”）功能允许用户在单聊和群聊中使用表情符号快速对消息做出反应。同时在群组中，利用 Reaction 可以发起投票，根据不同表情的追加数量来确认投票。

目前 Reaction 仅适用于单聊和群组。聊天室暂不支持 Reaction 功能。

下图显示了将 Reaction 添加到消息、带有 Reation 的会话的外观以及获取 Reaction 列表（带有相关信息）的外观。

![img](https://web-cdn.agora.io/docs-files/1655257598155)

本页展示了如何使用 Agora Chat SDK 在你的项目中实现 Reaction。

## 技术原理

即时通讯 IM SDK 支持你通过调用 API 在项目中实现如下功能：

- `addReaction` 在消息上添加 Reaction；
- `removeReaction` 删除消息的 Reaction；
- `fetchReactionList` 获取消息的 Reaction 列表；
- `fetchReactionDetail` 获取 Reaction 详情；

## 前提条件

开始前，请确保满足以下条件：

- 完成 `1.0.5 以上版本` SDK 初始化，详见 [快速开始](./agora_chat_get_started_flutter)。
- 了解 [使用限制](./agora_chat_limitation)。

## 实现方法

### 在消息上添加 Reaction

调用 `addReaction` 在消息上添加 Reaction，在 `onMessageReactionDidChange` 监听事件中会收到这条消息的最新 Reaction 概览。

示例代码如下：

```dart
// reaction: Reaction ID
// msgId: 消息 ID
// 在指定消息上添加 Reaction
ChatClient.getInstance()
  .chatManager.addReaction(reaction, msgId)
  .then((result) => {
    console.log("success: ", result);
  })
  .catch((error) => {
    console.log("fail: ", error);
  });
```

### 删除消息的 Reaction

调用 `removeReaction` 删除消息的 Reaction，在 `onMessageReactionDidChange` 监听事件中会收到这条消息的最新 Reaction 概览。

示例代码如下：

```dart
try {
  await ChatClient.getInstance.chatManager.addReaction(
    messageId: messageId,
    reaction: reaction,
  );
} on ChatError catch (e) {
}
```

### 获取消息的 Reaction 列表

调用 `getReactionList` 可以从服务器获取指定消息的 Reaction 概览列表，列表内容包含 Reaction 内容，用户数量，用户列表（概要数据，即前三个用户信息）。
对应消息 `ChatMessage` 有便捷的访问方式 `reactionList`。
示例代码如下：

```dart
try {
  Map<String, List<ChatMessageReaction>> map =
      await ChatClient.getInstance.chatManager.fetchReactionList(
    messageIds: messageIds,
    chatType: ChatType.GroupChat,
    groupId: groupId,
  );
} on ChatError catch (e) {
}
```

消息的快捷访问方式。示例如下：

```dart
try {
    List<ChatMessageReaction> reactions = await msg.reactionList();
}on ChatError catch (e) {
}
```

### 获取 Reaction 详情

调用 `fetchReactionDetail` 可以从服务器获取指定 Reaction 的详情，包括 Reaction 内容，用户数量和全部用户列表。示例代码如下：

```dart
try {
  ChatCursorResult<ChatMessageReaction> result =
      await ChatClient.getInstance.chatManager.fetchReactionDetail(
    messageId: messageId,
    reaction: reaction,
  );
} on ChatError catch (e) {
}
```

### 管理 Reaction 监听

用 `onMessageReactionDidChange` 监听 Reaction 的变化。

```dart
    // 添加监听
    ChatClient.getInstance.chatManager.addEventHandler(
      "UNIQUE_HANDLER_ID",
      ChatEventHandler(
        onMessageReactionDidChange: (events) {},
      ),
    );

    ...

    // 移除监听
    ChatClient.getInstance.chatManager.removeEventHandler("UNIQUE_HANDLER_ID");
}
```