表情符号被广泛用于实时聊天，允许用户以直接和生动的方式表达自己的感受。在即时通讯 IM 中，消息表情回复（下文统称 “Reaction”）允许用户在单聊和群聊中使用表情符号对消息进行快速回复。在群聊中，Reaction 也可用于投票，例如，计算对消息回复的各种表情符号的数量确认投票。

<div class="alert note">目前 Reaction 仅适用于单聊和群组，暂不适用于聊天室。</div>

下图展示如何将 Reaction 添加到消息、添加了 Reaction 的会话以及获取 Reaction 列表（带有相关信息）。

- 添加 Reaction

![img](agora_doc_source\markdown\agora-chat\images\reaction\reaction_add_web.png)

- 查询 Reaction 列表

![img](agora_doc_source\markdown\agora-chat\images\reaction\reaction_query_web.png)

本页介绍如何使用即时通讯 IM SDK 在项目中实现 Reaction 功能。

## 技术原理

即时通讯 IM SDK 支持你通过调用 API 在项目中实现如下功能：

- `addReaction` 在消息上添加 Reaction；
- `deleteReaction` 删除消息的 Reaction；
- `getReactionList` 获取消息的 Reaction 列表；
- `getReactionDetail` 获取 Reaction 详情；
- `fetchHistoryMessages` 获取漫游消息中的 Reaction。

## 前提条件

开始前，请确保满足以下条件：

- 完成 SDK 初始化，详见 [Web 快速开始](./agora_chat_get_started_web)。
- 了解即时通讯 IM 的 [使用限制](./agora_chat_limitation)。

所有版本的 [套餐包](./agora_chat_plan) 都支持 Reaction 功能，因此在 [Agora 控制台](https://console.agora.io/) 中启用即时通讯 IM 会默认开启 Reaction 功能。

## 实现方法

### 在消息上添加 Reaction

调用 `addReaction` 方法在消息上添加 Reaction，在 `onReactionChange` 监听事件中会收到该消息的最新 Reaction 概览。

示例代码如下：

```javascript
// 添加 Reaction。
conn.addReaction({ messageId: "messageId", reaction: "reaction" });

// 监听 Reaction 更新。
conn.addEventHandler("REACTION", {
  onReactionChange: (reactionMsg) => {
    console.log(reactionMsg);
  },
});
```

### 删除消息的 Reaction

调用 `deleteReaction` 方法删除消息的 Reaction，在 `onReactionChange` 监听事件中会收到该消息的最新 Reaction 概览。

示例代码如下：

```javascript
// 删除 Reaction。
conn.deleteReaction({ messageId: "messageId", reaction: "reaction" });

// 监听 Reaction 更新。
conn.addEventHandler("REACTION", {
  onReactionChange: (reactionMsg) => {
    console.log(reactionMsg);
  },
});
```

### 获取消息的 Reaction 列表

调用 `getReactionList` 方法可以从服务器获取 Reaction 概览列表，列表内容包含 Reaction 内容，添加或移除 Reaction 的用户数量，以及添加或移除 Reaction 的前三个用户的用户 ID。示例代码如下：

```javascript
conn
  .getReactionList({ chatType: "singleChat", messageId: "messageId" })
  .then((res) => {
    console.log(res);
  });
```

### 获取 Reaction 详情

调用 `getReactionDetail` 方法可以从服务器获取 Reaction 详情，包括 Reaction 内容，添加或移除 Reaction 的用户数量以及添加或移除 Reaction 的全部用户列表。示例代码如下：

```javascript
conn
  .getReactionDetail({
    messageId: "messageId",
    reaction: "reaction",
    cursor: null,
    pageSize: 20,
  })
  .then((res) => {
    console.log(res);
  });
```

### 获取漫游消息中的 Reaction

调用 `fetchHistoryMessages` 可以获取漫游消息，如果一条消息已添加 Reaction，消息体中会包含 Reaction 概览。

示例代码如下：

```javascript
conn.fetchHistoryMessages({ queue: "user", count: 20 }).then((messages) => {
  console.log(messages);
});
```

## 后续步骤

[即时通讯 IM UIKit](./agora_chat_uikit_web) 也支持 Reaction 功能，其中包含更丰富的表情符号。你可以使用 UIKit 在项目中实现 Reaction 功能。