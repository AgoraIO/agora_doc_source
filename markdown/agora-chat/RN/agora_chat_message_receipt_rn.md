用户在单聊中发送消息后，可以查看该消息的送达和已读状态，了解接收方是否及时收到并阅读了消息，也可以了解整个会话是否已读。

用户在群聊中发送信息后，可以查看该消息的已读状态。

本文介绍如何使用即时通讯 IM React Native SDK 的消息已读回执和送达回执在 app 中实现上述功能。

## 技术原理

使用即时通讯 IM React Native SDK 可以实现消息的送达回执与已读回执。核心方法如下：

- 消息送达回执
- 消息和会话的已读回执
- 群聊已读回执
- 获取群组已读回执信息
- 获取群组已读回执数目

实现送达回执和已读回执逻辑分别如下：

- 单聊消息送达回执

  1. 消息发送方在发送消息前通过 `ChatOptions.requireDeliveryAck` 开启送达回执功能
  2. 消息接收方收到消息后，SDK 自动向发送方触发送达回执
  3. 消息发送方通过监听 `onMessageDelivered` 回调接收消息送达回执

- 单聊会话及消息已读回执

  1. 消息发送方在发送消息前通话 `ChatOptions.requireAck` 开启已读回执功能
  2. 消息接收方收到消息后，调用 API `ChatManager.sendConversationReadAck` 或 `ChatManager.sendMessageReadAck` 发送会话或消息已读回执
  3. 消息发送方通过监听 `onConversationRead` 或 `onMessageRead` 回调接收会话或消息已读回执

- 群聊只支持消息已读回执：

  1. 你可以通过设置 `ChatOptions.NeedGroupAck` 为 `true` 开启群聊消息已读回执功能；
  2. 消息接收方收到消息后通过 `ChatManager.sendGroupMessageReadAck` 发送群组消息的已读回执。

## 前提条件

开始前，请确保满足以下条件：

- 完成 SDK 初始化，详见 [React Native 快速开始](./agora_chat_get_started_rn?platform=rn)。
- 了解 [使用限制](./agora_chat_limitation)。
- 在群组中实现消息已读回执功能默认不开启。如需使用请联系 [support@agora.io](mailto:support@agora.io)。

## 实现方法

### 消息送达回执

1. 发送方开启全局送达回执。当接收方收到消息后，SDK 底层会自动进行消息送达回执。

```typescript
// 设置 app key
const appKey = "appKey";
// 开启消息送达回执
const requireDeliveryAck = true;
ChatClient.getInstance()
  .init(
    new ChatOptions({
      appKey,
      requireDeliveryAck,
    })
  )
  .then(() => {
    console.log("init sdk success");
  })
  .catch((reason) => {
    console.log("init sdk fail.", reason);
  });
```

2. 发送方监听事件 `onMessagesDelivered` 回调，收到接收方的送达回执。

```typescript
class ChatMessageEvent implements ChatMessageEventListener {
  onMessagesDelivered(messages: ChatMessage[]): void {
    console.log(`onMessagesDelivered: `, messages);
  }
  // ...
}
// 添加监听器
const listener = new ChatMessageEvent();
ChatClient.getInstance().chatManager.addMessageListener(listener);
```

### 消息和会话的已读回执

消息已读回执用于告知单聊或群聊中的用户接收方已阅读其发送的消息。为降低消息已读回执方法的调用次数，SDK 还支持在单聊中使用会话已读回执功能，用于获知接收方是否阅读了会话中的未读消息。

#### 单聊

单聊既支持消息已读回执，也支持会话已读回执。我们建议你按照如下逻辑结合使用两种回执结合使用，减少发送消息已读回执数量。

- 聊天页面未打开时，若有未读消息，进入聊天页面，发送会话已读回执；
- 聊天页面打开时，若收到消息，发送消息已读回执。

##### 会话已读回执

参考如下步骤在单聊中实现会话已读回执。

1. 开启全局的消息已读回执开关。如果全局设置不开启，消息和会话的相应设置也无法生效。

```typescript
// 设置 app key
const appKey = "appKey";
// 开启消息已读回执
const requireAck = true;
ChatClient.getInstance()
  .init(
    new ChatOptions({
      appKey,
      requireAck,
      requireDeliveryAck,
    })
  )
  .then(() => {
    console.log("init sdk success");
  })
  .catch((reason) => {
    console.log("init sdk fail.", reason);
  });
```

2. 接收方执行会话已读回执操作。进入会话页面，查看会话中是否有未读消息。若有，发送会话已读回执，没有则不再发送。

```typescript
// 会话 ID
const convId = "convId";
// 执行操作
ChatClient.getInstance()
  .chatManager.sendConversationReadAck(convId)
  .then(() => {
    console.log("send conversation read success");
  })
  .catch((reason) => {
    console.log("send conversation read fail.", reason);
  });
```

3. 发送方监听 `onConversationRead` 回调，接收会话已读回执。

```typescript
class ChatMessageEvent implements ChatMessageEventListener {
  onConversationRead(from: string, to?: string): void {
    console.log(`onConversationRead: `, from, to);
  }
  // ...
}
// 添加监听器
const listener = new ChatMessageEvent();
ChatClient.getInstance().chatManager.addMessageListener(listener);
```

> 同一用户 ID 登录多设备的情况下，用户在一台设备上发送会话已读回执，服务器会将会话的未读消息数置为 `0`，同时其他设备会收到 `onConversationRead` 回调。

##### 消息已读回执

参考如下步骤在单聊中实现消息已读回执。

1. 开启全局的消息已读回执开关。如果全局设置不开启，消息和会话的相应设置也无法生效。

```typescript
// 设置 app key
const appKey = "appKey";
// 开启消息已读回执
const requireAck = true;
ChatClient.getInstance()
  .init(
    new ChatOptions({
      appKey,
      requireAck,
      requireDeliveryAck,
    })
  )
  .then(() => {
    console.log("init sdk success");
  })
  .catch((reason) => {
    console.log("init sdk fail.", reason);
  });
```

2. 消息发送方监听 `onMessagesRead` 事件。

```typescript
class ChatMessageEvent implements ChatMessageEventListener {
  onMessagesRead(messages: ChatMessage[]): void {
    // 收到消息已读
    console.log(`onMessagesRead: `, messages);
  }
  // ...
}
// 添加监听器
const listener = new ChatMessageEvent();
ChatClient.getInstance().chatManager.addMessageListener(listener);
```

3. 消息发送方发送消息，并等待接收方已读。

```typescript
// 发送消息
// 设置消息开启已读回执
msg.hasReadAck = true;
// 执行发送消息
ChatClient.getInstance()
  .chatManager.sendMessage(msg)
  .then(() => {
    // 消息发送动作完成，会在这里打印日志。
    console.log("send message success.");
  })
  .catch((reason) => {
    // 消息发送动作失败，会在这里打印日志。
    console.log("send message fail.", reason);
  });
```

4. 接收方查看消息，并调用 `sendMessageReadAck` 方法告知发送方消息已读。成功调用后，消息发送方会收到 `onMessageRead` 回调。

```typescript
// 接收的需要已读回执的消息
const msg;
// 执行发送已读回执操作
ChatClient.getInstance()
  .chatManager.sendMessageReadAck(msg)
  .then(() => {
    console.log("send message read success");
  })
  .catch((reason) => {
    console.log("send message read fail.", reason);
  });
```

### 群聊已读回执

对于群组消息，消息发送方（目前为群主和群管理员）可设置指定消息是否需要已读回执。

1. 消息发送方需要知道群组消息是否已读，需要监听 `onGroupMessageRead` 事件。

```typescript
class ChatMessageEvent implements ChatMessageEventListener {
  onGroupMessageRead(groupMessageAcks: ChatGroupMessageAck[]): void {
    // 收到消息已读
    console.log(`onGroupMessageRead: `, messages);
  }
  // ...
}
// 添加监听器
const listener = new ChatMessageEvent();
ChatClient.getInstance().chatManager.addMessageListener(listener);
```

2. 发送群组消息。并设置 `needGroupAck` 为 `true`，表示需要群组消息已读回执。

```typescript
// 发送群组消息
// 设置本条消息需要群消息回执
msg.needGroupAck = true;
// 执行发送消息
ChatClient.getInstance()
  .chatManager.sendMessage(msg)
  .then(() => {
    // 消息发送动作完成，会在这里打印日志。
    console.log("send message success.");
  })
  .catch((reason) => {
    // 消息发送动作失败，会在这里打印日志。
    console.log("send message fail.", reason);
  });
```

3. 群组里面的接收方收到消息，调用 `sendGroupMessageReadAck` 方法告知消息发送方消息已读。成功发送后，消息发送方会收到 `onMessageRead` 回调。

```typescript
// 发送已读回执
// 需要设置消息已读的 ID
const msgId;
// 指定群组
const groupId;
// 执行已读回执
ChatClient.getInstance()
  .chatManager.sendGroupMessageReadAck(msgId, groupId)
  .then(() => {
    // 消息发送动作完成，会在这里打印日志。
    console.log("send message read success.");
  })
  .catch((reason) => {
    // 消息发送动作失败，会在这里打印日志。
    console.log("send message read fail.", reason);
  });
```

### 获取群组已读回执信息

所有用户可以调用 `fetchGroupAcks` 方法获取指定范围的群组消息的已读回执。

```typescript
// msgId： 消息 ID
// groupId：群组 ID
// startAckId: 回执的起始位置
// pageSize：期望请求的最大数量，取值范围是 0-400
ChatClient.getInstance()
  .chatManager.fetchGroupAcks(msgId, groupId, startAckId, pageSize)
  .then((acks) => {
    console.log("get message ack success: ", acks);
  })
  .catch((reason) => {
    console.log("get message ack fail.", reason);
  });
```

### 获取群组已读回执数目

所有用户可以调用 `groupAckCount` 方法通过消息 ID 找到消息，在通过消息获取群组已读回执数量。

```typescript
// msgId： 消息id
ChatClient.getInstance()
  .chatManager.groupAckCount(msgId)
  .then((count) => {
    console.log("get message ack count success: ", count);
  })
  .catch((reason) => {
    console.log("get message ack count fail.", reason);
  });
```