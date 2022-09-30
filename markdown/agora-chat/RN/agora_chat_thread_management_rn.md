子区是群组成员的子集，是支持多人沟通的即时通讯系统，本文介绍如何使用 SDK 在实时互动 app 中创建和管理子区，并实现子区相关功能。

下图展示了如何创建子区、管理子区中的会话以及可以在子区中执行的操作。

![img](https://web-cdn.agora.io/docs-files/1655176216910)

本文介绍如何使用即时通讯 IM SDK 在应用中创建和管理子区。

## 技术原理

即时通讯 IM React Native SDK 提供 `ChatManager`、`ChatMessageThread`、`ChatMessageEventListener` 和 `ChatMessageThreadEvent` 类，用于管理子区，支持你通过调用 API 在项目中实现如下功能：

- 创建、解散子区
- 加入、退出子区
- 子区踢人
- 修改子区名称
- 获取子区详情
- 获取子区成员列表
- 获取子区列表
- 批量获取子区中的最新消息
- 监听子区事件

## 前提条件

开始前，请确保满足以下条件：

- 完成 SDK 初始化，详见 [快速开始](./agora_chat_get_started_rn?platform=rn)。
- 了解 [使用限制](./agora_chat_limitation?platform=rn)中所述。

在 [Agora 控制台](https://console.agora.io/) 中启用聊天后默认启用该功能。

## 实现方法

本节介绍如何调用即时通讯 IM SDK 提供的 API 实现上述功能。

### 创建子区

所有群成员均可以调用 `createChatThread` 方法，基于一条群组消息新建子区。

单设备登录时，子区所属群组的所有成员均会收到 `ChatMessageEventListener#onChatMessageThreadCreated`回调；多设备登录时，其他设备会同时收到 `ChatMultiDeviceEventListener#onThreadEvent` 回调，回调事件为 `THREAD_CREATE`。

示例代码如下：

```typescript
// name: 即将创建的子区的名字
// msgId: 子区的父消息 ID
// parentId: 子区的父节点，通常是群组 ID
ChatClient.getInstance()
  .chatManager.createChatThread(name, msgId, parentId)
  .then((result) => {
    console.log("success: ", result);
  })
  .catch((error) => {
    console.log("fail: ", error);
  });
```

### 解散子区

仅子区所在群组的群主和群管理员可以调用 `destroyChatThread` 方法解散子区。

单设备登录时，子区所属群组的所有成员均会收到 `ChatMessageEventListener#onChatMessageThreadDestroyed` 回调；多设备登录时，其他设备会同时收到 `ChatMultiDeviceEventListener#onThreadEvent` 回调，回调事件为 `THREAD_DESTROY`。

**注意**
解散子区或解散子区所在的群组后，将删除本地数据库及内存中关于该子区的全部数据，需谨慎操作。

示例代码如下：

```typescript
// chatThreadID: 子区 ID
// 执行子区销毁，请谨慎使用。
ChatClient.getInstance()
  .chatManager.destroyChatThread(chatThreadID)
  .then((result) => {
    console.log("success: ", result);
  })
  .catch((error) => {
    console.log("fail: ", error);
  });
```

### 加入子区

子区所在群组的所有成员均可以调用 `joinChatThread` 方法加入群组，

加入子区的具体步骤如下：

1. 收到 `ChatMessageEventListener#onChatMessageThreadCreated` 回调或 `ChatMessageEventListener#onChatMessageThreadUpdated` 回调，或调用 `fetchChatThreadWithParentFromServer` 方法从服务器获取指定群组的子区列表，从中获取到想要加入的子区 ID。
2. 调用 `joinChatThread` 传入子区 ID 加入对应子区。

多设备登录时，其他设备会同时收到 `ChatMultiDeviceEventListener#onThreadEvent` 回调，回调事件为 `THREAD_JOIN`。

示例代码如下：

```typescript
// chatThreadID: 子区 ID
ChatClient.getInstance()
  .chatManager.joinChatThread(chatThreadID)
  .then((result) => {
    console.log("success: ", result);
  })
  .catch((error) => {
    console.log("fail: ", error);
  });
```

### 退出子区

子区成员均可以主动调用 `leaveChatThread` 方法退出子区，退出子区后，该成员将不会再收到子区消息。

多设备登录时，其他设备会同时收到 `ChatMultiDeviceEventListener#onThreadEvent` 回调，回调事件为 `THREAD_LEAVE`。

示例代码如下：

```typescript
// chatThreadID: 子区 ID
ChatClient.getInstance()
  .chatManager.leaveChatThread(chatThreadID)
  .then((result) => {
    console.log("success: ", result);
  })
  .catch((error) => {
    console.log("fail: ", error);
  });
```

### 从子区移出成员

仅群主和群管理员可以调用 `removeMemberWithChatThread` 方法将指定成员 (群管理员或普通成员) 踢出子区，被踢出子区的成员将不再接收到子区消息。

被踢出子区的成员会收到 `ChatMessageEventListener#onUserRemoved` 回调。多设备登录时，执行踢人操作的成员的其他设备会同时收到 `ChatMultiDeviceEventListener#onThreadEvent` 回调，回调事件为 `THREAD_KICK`。

示例代码如下：

```typescript
// chatThreadID: 子区 ID
// member: 子区成员的用户 ID
ChatClient.getInstance()
  .chatManager.removeMemberWithChatThread(chatThreadID, memberId)
  .then((result) => {
    console.log("success: ", result);
  })
  .catch((error) => {
    console.log("fail: ", error);
  });
```

### 修改子区名称

仅群主和群管理员以及子区的创建者可以调用 `updateChatThreadName` 方法修改子区名称。

单设备登录时，子区所属群组的所有成员会收到 `ChatMessageEventListener#onChatMessageThreadUpdated` 回调；多设备登录时，其他设备会同时收到 `ChatMultiDeviceEventListener#onThreadEvent` 回调，回调事件为 `THREAD_UPDATE`。

示例代码如下：

```typescript
// chatThreadID: 子区 ID
// newChatThreadName: 修改的子区名称，长度不超过 64 个字符
ChatClient.getInstance()
  .chatManager.updateChatThreadName(chatThreadID, newName)
  .then((result) => {
    console.log("success: ", result);
  })
  .catch((error) => {
    console.log("fail: ", error);
  });
```

### 获取子区详情

子区所属群组的所有成员均可以调用 `fetchChatThreadFromServer` 从服务器获取子区详情。

示例代码如下：

```typescript
// chatThreadID: 子区 ID
ChatClient.getInstance()
  .chatManager.fetchChatThreadFromServer(chatThreadID)
  .then((result) => {
    console.log("success: ", result);
  })
  .catch((error) => {
    console.log("fail: ", error);
  });
```

### 获取子区成员列表

子区所属群组的所有成员均可以调用 `fetchMembersWithChatThreadFromServer` 方法从服务器分页获取子区成员列表。

```typescript
// chatThreadId: 子区 ID
// pageSize: 单次请求返回的成员数，取值范围为 [1, 50]
// cursor: 开始获取数据的游标位置，首次调用方法时传 `null` 或空字符串
ChatClient.getInstance()
  .chatManager.fetchMembersWithChatThreadFromServer(
    chatThreadID,
    cursor,
    pageSize
  )
  .then((result) => {
    console.log("success: ", result);
  })
  .catch((error) => {
    console.log("fail: ", error);
  });
```

### 获取子区列表

1. 用户可以调用 `fetchJoinedChatThreadFromServer` 方法从服务器分页获取自己加入和创建的子区列表：

```typescript
// pageSize: 单次请求返回的子区数，取值范围为 [1, 50]
// cursor: 开始获取数据的游标位置，首次调用方法时传 `null` 或空字符串
ChatClient.getInstance()
  .chatManager.fetchJoinedChatThreadFromServer(cursor, pageSize)
  .then((result) => {
    console.log("success: ", result);
  })
  .catch((error) => {
    console.log("fail: ", error);
  });
```

2. 用户可以调用 `fetchJoinedChatThreadWithParentFromServer` 方法从服务器分页获取指定群组中自己加入和创建的子区列表：

```typescript
// parentId: 群组 ID
// pageSize: 单次请求返回的子区数，取值范围为 [1, 50]
// cursor: 开始获取数据的游标位置，首次调用方法时传 `null` 或空字符串
ChatClient.getInstance()
  .chatManager.fetchJoinedChatThreadWithParentFromServer(
    parentId,
    cursor,
    pageSize
  )
  .then((result) => {
    console.log("success: ", result);
  })
  .catch((error) => {
    console.log("fail: ", error);
  });
```

3. 用户还可以调用 `fetchChatThreadWithParentFromServer` 方法从服务器分页获取指定群组的子区列表：

```typescript
// parentId: 群组 ID
// pageSize: 单次请求返回的子区数，取值范围为 [1, 50]
// cursor: 开始获取数据的游标位置，首次调用方法时传 `null` 或空字符串
ChatClient.getInstance()
  .chatManager.fetchChatThreadWithParentFromServer(parentId, cursor, pageSize)
  .then((result) => {
    console.log("success: ", result);
  })
  .catch((error) => {
    console.log("fail: ", error);
  });
```

### 批量获取子区中的最新一条消息

用户可以调用 `fetchLastMessageWithChatThread` 方法从服务器批量获取子区中的最新一条消息。

示例代码如下：

```typescript
// chatThreadIDs: 要查询的子区 ID 列表，每次最多可传入 20 个子区 ID
ChatClient.getInstance()
  .chatManager.fetchLastMessageWithChatThread(chatThreadIDs)
  .then((result) => {
    console.log("success: ", result);
  })
  .catch((error) => {
    console.log("fail: ", error);
  });
```

### 监听子区事件

`ChatManager` 类中提供子区事件的监听接口。开发者可以通过设置此监听，获取子区中的事件，并做出相应处理。如果不再使用该监听，需要移除，防止出现内存泄漏。

示例代码如下：

```typescript
class ChatMessageEvent implements ChatMessageEventListener {
  onChatMessageThreadCreated(msgThread: ChatMessageThreadEvent): void {
    console.log(`onChatMessageThreadCreated: `, msgThread);
  }
  onChatMessageThreadUpdated(msgThread: ChatMessageThreadEvent): void {
    console.log(`onChatMessageThreadUpdated: `, msgThread);
  }
  onChatMessageThreadDestroyed(msgThread: ChatMessageThreadEvent): void {
    console.log(`onChatMessageThreadDestroyed: `, msgThread);
  }
  onChatMessageThreadUserRemoved(msgThread: ChatMessageThreadEvent): void {
    console.log(`onChatMessageThreadUserRemoved: `, msgThread);
  }
  // 其他回调接收省略，实际开发中需添加
}

const listener = new ChatMessageEvent();
// 添加子区相关的监听器
ChatClient.getInstance().chatManager.addMessageListener(listener);

// 移除监听器
ChatClient.getInstance().chatManager.removeMessageListener(listener);

// 移除所有消息监听器
ChatClient.getInstance().chatManager.removeAllMessageListener();
```