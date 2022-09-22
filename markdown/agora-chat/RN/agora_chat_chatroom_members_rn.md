聊天室是支持多人沟通的即时通讯系统。本文介绍如何使用即时通讯 IM SDK 在实时互动 app 中管理聊天室成员，并实现聊天室的相关功能。

## 技术原理

即时通讯 IM SDK 提供 `ChatRoomManager`、`ChatRoom` 和 `ChatRoomEventListener` 类，支持对聊天室成员的管理，包括获取、添加和移出聊天室成员等，主要方法如下：

- 将成员移出聊天室
- 获取聊天室成员列表
- 管理聊天室黑名单
- 管理聊天室白名单
- 管理聊天室禁言列表
- 开启和关闭聊天室全员禁言
- 管理聊天室所有者及管理员

## 前提条件

开始前，请确保满足以下条件：

- 完成 SDK 初始化，详见 [快速开始](./agora_chat_get_started_rn?platform=rn)。
- 了解即时通讯 IM 的 [使用限制](./agora_chat_limitation?platform=rn)。
- 了解不同版本的聊天室相关数量限制，详见 [套餐包详情](./agora_chat_plan?platform=rn)。

## 实现方法

本节介绍如何使用即时通讯 IM SDK 提供的 API 实现上述功能。

### 获取聊天室成员列表

所有聊天室成员均可调用 `fetchChatRoomMembers` 方法获取当前聊天室成员列表。

示例代码如下：

```typescript
ChatClient.getInstance()
  .roomManager.fetchChatRoomMembers(roomId, cursor, pageSize)
  .then((members) => {
    console.log("get members success.", members);
  })
  .catch((reason) => {
    console.log("get members fail.", reason);
  });
```

### 将成员移出聊天室

仅聊天室所有者和管理员可调用 `removeChatRoomMembers` 方法将指定成员移出聊天室。
被移出后，该成员收到 `ChatRoomEventListener#onRemoved` 回调，其他成员收到 `ChatRoomEventListener#onMemberExited` 回调。
被移出的成员可以重新进入聊天室。

示例代码如下：

```typescript
ChatClient.getInstance()
  .roomManager.removeChatRoomMembers(roomId, members)
  .then(() => {
    console.log("remove members success.");
  })
  .catch((reason) => {
    console.log("remove members fail.", reason);
  });
```

### 管理聊天室黑名单

#### 将成员加入聊天室黑名单

仅聊天室所有者和管理员可调用 `blockChatRoomMembers` 方法将指定成员添加至黑名单。

被加入黑名单后，该成员收到 `onRemoved` 回调，其他成员收到 `onMemberExited` 回调。

被加入黑名单后，该成员无法再收发聊天室消息并被移出聊天室，黑名单中的成员如想再次加入聊天室，聊天室所有者或管理员必须先将其移出黑名单列表。

示例代码如下：

```typescript
ChatClient.getInstance()
  .roomManager.blockChatRoomMembers(roomId, members)
  .then(() => {
    console.log("block members success.");
  })
  .catch((reason) => {
    console.log("block members fail.", reason);
  });
```

#### 将成员移出聊天室黑名单

仅聊天室所有者和管理员可以调用 `unblockChatRoomMembers` 方法将成员移出聊天室黑名单。

示例代码如下：

```typescript
ChatClient.getInstance()
  .roomManager.unblockChatRoomMembers(roomId, members)
  .then(() => {
    console.log("unblock members success.");
  })
  .catch((reason) => {
    console.log("unblock members fail.", reason);
  });
```

#### 获取聊天室黑名单列表

仅聊天室所有者和管理员可以调用 `fetchChatRoomBlockList` 方法获取当前聊天室黑名单。

示例代码如下：

```typescript
ChatClient.getInstance()
  .roomManager.fetchChatRoomBlockList(roomId, pageNum, pageSize)
  .then((members) => {
    console.log("block members success.", members);
  })
  .catch((reason) => {
    console.log("block members fail.", reason);
  });
```

### 管理聊天室白名单

#### 获取聊天室白名单列表

仅聊天室所有者和管理员可以调用 `fetchChatRoomAllowListFromServer` 获取当前聊天室白名单成员列表。

示例代码如下：

```typescript
ChatClient.getInstance()
  .roomManager.fetchChatRoomAllowListFromServer(roomId)
  .then((members) => {
    console.log("get members success.", members);
  })
  .catch((reason) => {
    console.log("get members fail.", reason);
  });
```

#### 将成员加入聊天室白名单

仅聊天室所有者和管理员可以调用 `addMembersToChatRoomAllowList` 将成员加入聊天室白名单，被添加后，该成员和其他未操作的聊天室管理员或聊天室所有者收到 `ChatRoomEventListener#onAllowListAdded` 回调。

示例代码如下：

```typescript
ChatClient.getInstance()
  .roomManager.addMembersToChatRoomAllowList(roomId, members)
  .then((members) => {
    console.log("success.", members);
  })
  .catch((reason) => {
    console.log("fail.", reason);
  });
```

#### 将成员移出聊天室白名单列表

仅聊天室所有者和管理员可以调用 `将成员从聊天室白名单移出，被移出后，该成员和其他未操作的聊天室管理员或聊天室所有者收到` 回调。

示例代码如下：

```typescript
ChatClient.getInstance()
  .roomManager.removeMembersFromChatRoomAllowList(roomId, members)
  .then((members) => {
    console.log("success.", members);
  })
  .catch((reason) => {
    console.log("fail.", reason);
  });
```

#### 检查自己是否在聊天室白名单中

所有聊天室成员可以调用 `isMemberInChatRoomAllowList` 方法检查自己是否在白名单中，示例代码如下：

```typescript
ChatClient.getInstance()
  .roomManager.isMemberInChatRoomAllowList(roomId)
  .then((members) => {
    console.log("success.", members);
  })
  .catch((reason) => {
    console.log("fail.", reason);
  });
```

### 管理聊天室禁言列表

#### 添加成员至聊天室禁言列表

仅聊天室所有者和管理员可以调用 `muteChatRoomMembers` 方法将指定成员添加至聊天室禁言列表。被禁言后，该成员和其他未操作的聊天室管理员或聊天室所有者收到 `onMuteListAdded` 回调。

聊天室所有者可禁言聊天室所有成员，聊天室管理员可禁言聊天室普通成员。

示例代码如下：

```typescript
ChatClient.getInstance()
  .roomManager.muteChatRoomMembers(roomId, muteMembers, duration)
  .then(() => {
    console.log("mute members success.");
  })
  .catch((reason) => {
    console.log("mute members fail.", reason);
  });
```

#### 将成员移出聊天室禁言列表

仅聊天室所有者和管理员可以调用 `unMuteChatRoomMembers` 方法将成员移出聊天室禁言列表。被解除禁言后，该成员和其他未操作的聊天室管理员或聊天室所有者收到 `onMuteListRemoved` 回调。

聊天室所有者可对聊天室所有成员解除禁言，聊天室管理员可对聊天室普通成员解除禁言。

示例代码如下：

```typescript
ChatClient.getInstance()
  .roomManager.unMuteChatRoomMembers(roomId, unMuteMembers)
  .then(() => {
    console.log("unMute members success.");
  })
  .catch((reason) => {
    console.log("unMute members fail.", reason);
  });
```

#### 获取聊天室禁言列表

仅聊天室所有者和管理员可调用 `fetchChatRoomMuteList` 方法获取当前聊天室的禁言列表。

示例代码如下：

```typescript
ChatClient.getInstance()
  .roomManager.fetchChatRoomMuteList(roomId, pageNum, pageSize)
  .then((members) => {
    console.log("get mute members success.", members);
  })
  .catch((reason) => {
    console.log("get mute members fail.", reason);
  });
```

### 开启和关闭聊天室全员禁言

为了快捷管理聊天室发言，聊天室所有者和管理员可以开启和关闭聊天室全员禁言。全员禁言和单独的成员禁言不冲突，设置或者解除全员禁言，原禁言列表并不会变化。

#### 开启聊天室全员禁言

仅聊天室所有者和管理员可以调用 `muteAllChatRoomMembers`方法开启全员禁言。全员禁言开启后，除了在白名单中的成员，其他成员不能发言。调用成功后，聊天室成员会收到 `onAllChatRoomMemberMuteStateChanged` 回调。

示例代码如下：

```typescript
ChatClient.getInstance()
  .roomManager.muteAllChatRoomMembers(roomId)
  .then((members) => {
    console.log("success.", members);
  })
  .catch((reason) => {
    console.log("fail.", reason);
  });
```

#### 关闭聊天室全员禁言

仅聊天室所有者和管理员可以调用 `unMuteAllChatRoomMembers` 方法取消全员禁言。调用成功后，聊天室成员会收到 `onAllChatRoomMemberMuteStateChanged` 回调。

示例代码如下：

```typescript
ChatClient.getInstance()
  .roomManager.unMuteAllChatRoomMembers(roomId)
  .then((members) => {
    console.log("success.", members);
  })
  .catch((reason) => {
    console.log("fail.", reason);
  });
```

### 管理聊天室所有者和管理员

#### 变更聊天室所有者

仅聊天室所有者可以调用 `changeOwner` 方法将权限移交给聊天室中指定成员。成功移交后，原聊天室所有者变为聊天室成员，新的聊天室所有者和聊天室管理员收到 `onOwnerChanged` 回调。

示例代码如下：

```typescript
ChatClient.getInstance()
  .roomManager.changeOwner(roomId, newOwner)
  .then(() => {
    console.log("change owner success.");
  })
  .catch((reason) => {
    console.log("change owner fail.", reason);
  });
```

#### 添加聊天室管理员

仅聊天室所有者可以调用 `addChatRoomAdmin` 方法添加聊天室管理员。成功添加后，新管理员及其他管理员收到 `onAdminAdded` 回调。

示例代码如下：

```typescript
ChatClient.getInstance()
  .roomManager.addChatRoomAdmin(roomId, admin)
  .then(() => {
    console.log("add admin success.");
  })
  .catch((reason) => {
    console.log("add admin fail.", reason);
  });
```

#### 移除聊天室管理员

仅聊天室所有者可以调用 `removeChatRoomAdmin` 方法移除聊天室管理员。成功移除后，被移除的管理员及其他管理员收到 `onAdminRemoved` 回调。

示例代码如下：

```typescript
ChatClient.getInstance()
  .roomManager.removeChatRoomAdmin(roomId, admin)
  .then(() => {
    console.log("remove admin success.");
  })
  .catch((reason) => {
    console.log("remove admin fail.", reason);
  });
```

### 监听聊天室事件

有关详细信息，请参阅 [监听聊天室事件](./agora_chat_chatroom_rn?platform=rn#监听聊天室事件)。