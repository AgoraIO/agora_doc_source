用户登录后，可进行添加联系人、获取好友列表等操作。

SDK 提供用户关系管理功能，包括好友列表管理和黑名单管理：

- 好友列表管理：查询好友列表、申请添加好友、同意好友申请、拒绝好友申请和删除好友等操作。
- 黑名单管理：查询黑名单列表、添加用户至黑名单以及从黑名单中移出用户等操作。

本文介绍如何通过环信即时通讯 IM React Native SDK 实现上述功能。

## 技术原理

即时通讯 IM React Native SDK 提供 `ChatContactManager` 类实现好友的添加移除，黑名单的添加移除等功能。主要方法如下：

- `addContact` 申请添加好友。
- `deleteContact` 删除好友。
- `acceptInvitation` 同意好友申请。
- `declineInvitation` 拒绝好友申请。
- `getAllContactsFromServer` 从服务器获取好友列表。
- `getAllContactsFromDB` 从缓存获取好友列表。
- `addUserToBlockList` 添加用户到黑名单。
- `removeUserFromBlockList` 将用户从黑名单移除。
- `getBlockListFromServer` 从服务器获取黑名单列表。

## 前提条件

开始前，请确保满足以下条件：

- 完成 SDK 初始化，详见 [iOS 快速开始](./agora_chat_get_started_ios?platform=iOS)。
- 了解即时通讯 IM 的 [使用限制](./agora_chat_limitation?platform=iOS)。

## 实现方法

### 添加好友

1. 用户添加指定用户为好友

```typescript
// 用户 ID
const userId = "foo";
// 申请加为好友的理由
const reason = "Request to add a friend.";
ChatClient.getInstance()
  .contactManager.addContact(userId, reason)
  .then(() => {
    console.log("request send success.");
  })
  .catch((reason) => {
    console.log("request send fail.", reason);
  });
```

2. 对方收到申请，同意成为好友，或者拒绝成为好友

同意成为好友：

```typescript
// 用户 ID
const userId = "bar";
ChatClient.getInstance()
  .contactManager.acceptInvitation(userId)
  .then(() => {
    console.log("accept request success.");
  })
  .catch((reason) => {
    console.log("accept request fail.", reason);
  });
```

拒绝成为好友：

```typescript
// 用户 ID
const userId = "bar";
ChatClient.getInstance()
  .contactManager.declineInvitation(userId)
  .then(() => {
    console.log("decline request success.");
  })
  .catch((reason) => {
    console.log("decline request fail.", reason);
  });
```

3. 接收方对于同意，申请方收到监听事件 `onContactInvited`

```typescript
const contactEventListener = new (class implements ChatContactEventListener {
  that: any;
  constructor(parent: any) {
    this.that = parent;
  }
  onContactInvited(userId: string, reason?: string): void {
    console.log(`onContactInvited: ${userId}, ${reason}: `);
  }
})(this);
ChatClient.getInstance().contactManager.addContactListener(
  contactEventListener
);
```

4. 对方拒绝，收到监听事件 `onFriendRequestDeclined`

```typescript
const contactEventListener = new (class implements ChatContactEventListener {
  that: any;
  constructor(parent: any) {
    this.that = parent;
  }
  onFriendRequestDeclined(userId: string): void {
    console.log(`onFriendRequestDeclined: ${userId}: `);
  }
})(this);
ChatClient.getInstance().contactManager.addContactListener(
  contactEventListener
);
```

### 获取好友列表

你可以从服务器获取好友列表，也可以从本地数据库获取已保存的好友列表。

**注意**

需要从服务器获取好友列表之后，才能从本地数据库获取到好友列表。

1. 从服务器获取好友列表

```typescript
 ChatClient.getInstance()
   .contactManager.getAllContactsFromServer()
   .then((value) => {
     console.log("get contact success.", value);
   })
   .catch((reason) => {
     console.log("get contact fail.", reason);
   });
 ```

 2. 从本地数据库中获取好友列表

 ```typescript
 ChatClient.getInstance()
   .contactManager.getAllContactsFromDB()
   .then((value) => {
     console.log("get contact success.", value);
   })
   .catch((reason) => {
     console.log("get contact fail.", reason);
   });
 ```

### 删除好友

删除好友时会同时删除对方联系人列表中的该用户，建议执行双重确认，以免发生误删操作。删除操作不需要对方同意或者拒绝。

```typescript
// 用户 ID
const userId = "tom";
// 是否保留聊天会话
const keepConversation = true;
ChatClient.getInstance()
  .contactManager.deleteContact(userId, keepConversation)
  .then(() => {
    console.log("remove success.");
  })
  .catch((reason) => {
    console.log("remove fail.", reason);
  });
```

### 将用户加入黑名单

加入黑名单后，对方将无法发送消息给自己。

```typescript
// 用户 ID
const userId = "tom";
// 将用户添加到黑名单
ChatClient.getInstance()
  .contactManager.addUserToBlockList(userId)
  .then(() => {
    console.log("add block list success.");
  })
  .catch((reason) => {
    console.log("add block list fail.", reason);
  });
```

### 查看当前用户黑名单列表

1. 使用本地缓存获取黑名单列表

```typescript
ChatClient.getInstance()
  .contactManager.getBlockListFromDB()
  .then((list) => {
    console.log("get block list success: ", list);
  })
  .catch((reason) => {
    console.log("get block list fail.", reason);
  });
```

2. 通过服务器获取黑名单列表

从服务器获取黑名单列表之后，才能从本地数据库获取到黑名单列表。

```typescript
ChatClient.getInstance()
  .contactManager.getBlockListFromServer()
  .then((list) => {
    console.log("get block list success: ", list);
  })
  .catch((reason) => {
    console.log("get block list fail.", reason);
  });
```

### 从黑名单中移除用户

被移除黑名单后，用户发送消息等行为将恢复。

```typescript
// 用户 ID
const userId = "tom";
// 将用户从黑名单移除
ChatClient.getInstance()
  .contactManager.removeUserFromBlockList(userId)
  .then((list) => {
    console.log("remove user to block list success: ", list);
  })
  .catch((reason) => {
    console.log("remove user to block list fail.", reason);
  });
```