表情符号被广泛用于实时聊天，因为它们允许用户以直接和生动的方式表达自己的感受。在即时通讯 IM 中，消息表情回复（下文统称 “Reaction”）允许用户在单聊和群聊中使用表情符号快速对消息做出反应。在群聊中，Reaction 也可用于投票，例如，通过计算附加到消息的不同表情符号的数量来确认投票。

下图展示了将 Reaction 添加到消息、带有 Reaction 的对话的外观以及获取 Reaction 列表（带有相关信息）的外观。

![img](https://web-cdn.agora.io/docs-files/1655257598155)

注意：目前 Reaction 仅适用于单聊和群组。聊天室暂不支持 Reaction 功能。

## 技术原理

SDK 提供 API 来实现如下功能：

- 在消息上添加 Reaction
- 删除消息的 Reaction
- 获取消息的 Reaction 列表
- 获取 Reaction 详情

## 前提条件

开始前，请确保满足以下条件：

- 集成 v1.0.5 或以上即时通讯 IM SDK 版本，并实现了 [基本的实时聊天功能](./agora_chat_get_started_rn?platform=rn)。
- 了解 [使用限制](./agora_chat_limitation?platform=rn)。

在 [Agora 控制台](https://console.agora.io/) 中启用聊天功能，会默认启用 Reaction 功能。

## 实现方法

### 在消息上添加 Reaction

调用 `addReaction` 在消息上添加 Reaction，在 `onMessageReactionDidChange` 监听事件中会收到这条消息的最新 Reaction 概览。

示例代码如下：

```typescript
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

```typescript
// reaction: Reaction ID
// msgId: 消息 ID
ChatClient.getInstance()
  .chatManager.removeReaction(reaction, msgId)
  .then((result) => {
    console.log("success: ", result);
  })
  .catch((error) => {
    console.log("fail: ", error);
  });
```

### 获取消息的 Reaction 列表

调用 `getReactionList` 可以从服务器获取指定消息的 Reaction 概览列表，列表内容包含 Reaction 内容，用户数量，用户列表（概要数据，即前三个用户信息）。
对应消息 `ChatMessage` 有便捷的访问方式 `reactionList`。
示例代码如下：

```typescript
// msgId: 消息 ID
ChatClient.getInstance()
  .chatManager.getReactionList(msgId)
  .then((result) => {
    console.log("success: ", result);
  })
  .catch((error) => {
    console.log("fail: ", error);
  });
```

消息的快捷访问方式。示例如下：

```typescript
// 通过消息快捷访问 Reaction 列表
const msg = ChatMessage.createTextMessage(targetId, content);
msg.reactionList
  .then((result) => {
    console.log("success: ", result);
  })
  .catch((error) => {
    console.log("fail: ", error);
  });
```

### 获取 Reaction 详情

调用 `fetchReactionDetail` 可以从服务器获取指定 Reaction 的详情，包括 Reaction 内容，用户数量和全部用户列表。示例代码如下：

```typescript
// reaction: Reaction ID
// msgId: 消息 ID
// pageSize: 单次请求返回的成员数，取值范围为 [1, 50]
// cursor: 开始获取数据的游标位置，首次调用方法时传 `null` 或空字符串
ChatClient.getInstance()
  .chatManager.fetchReactionDetail(msgId, reaction, cursor, pageSize)
  .then((result) => {
    console.log("success: ", result);
  })
  .catch((error) => {
    console.log("fail: ", error);
  });
```

### 管理 Reaction 监听

```typescript
// 监听 Reaction 更新
class ChatMessageEvent implements ChatMessageEventListener {
  onMessageReactionDidChange(_list: ChatMessageReactionEvent[]): void {
    throw new Error("Method not implemented.");
  }
  // 其他回调接收省略，实际开发中需要添加
}

// 注册监听器
const listener = new ChatMessageEvent();
ChatClient.getInstance().chatManager.addMessageListener(listener);

// 移除监听器
ChatClient.getInstance().chatManager.removeMessageListener(listener);

// 移除所有监听器
ChatClient.getInstance().chatManager.removeAllMessageListener();
```