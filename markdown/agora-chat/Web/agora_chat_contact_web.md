# 管理用户关系

SDK 提供用户关系管理功能，包括好友列表管理和黑名单管理：

- 好友列表管理：查询好友列表、申请添加好友、同意好友申请、拒绝好友申请和删除好友等操作。
- 黑名单管理：查询黑名单列表、添加用户至黑名单以及将用户移出黑名单等操作。

## 技术原理

即时通讯 IM Web SDK 提供以下用户关系管理功能：

- 请求添加好友；
- 接受和拒绝好友请求；
- 删除好友；
- 查询好友列表；
- 监听好友状态事件；
- 添加用户到黑名单；
- 获取黑名单；
- 将用户移出黑名单。

## 前提条件

开始前，请确保满足以下条件：

- 完成 SDK 初始化，详见 [Agora Chat 入门](https://docs.agora.io/en/agora-chat/agora_chat_get_started_web?platform=Web)。
- 了解 [使用限制](https://docs.agora.io/en/agora-chat/agora_chat_limitation?platform=Web)。

## 实现方法

### 管理联系人列表

#### 添加好友

本节主要介绍发送好友请求、接收好友请求、处理好友请求和好友请求处理结果回调等。

1. 调用 `conn.addEventHandler()` 注册监听好友状态，示例代码如下：

```javascript
/**
 * `msg` 为触发回调后的结果。
 * `contactEvent` 可自定义。
 * 下面的举例中，用户 A 为当前用户。
 */
conn.addEventHandler("contactEvent", {
  // 当前用户收到好友请求。用户 B 向用户 A 发送好友请求，用户 A 收到该事件。
  onContactInvited: function (msg) {},
  // 当前用户被其他用户从联系人列表上移除。用户 B 将用户 A 从联系人列表上删除，用户 A 收到该事件。
  onContactDeleted: function (msg) {},
  // 当前用户新增了联系人。 用户 B 向用户 A 发送好友请求，用户 A 同意该请求，用户 A 收到该事件，而用户 B 收到 `onContactAgreed` 事件。
  onContactAdded: function (msg) {},
  // 当前用户发送的好友请求被拒绝。 用户 A 向用户 B 发送好友请求，用户 B 收到好友请求后，拒绝加好友，则用户 A 收到该事件。
  onContactRefuse: function (msg) {},
  // 当前用户发送的好友请求经过了对方同意。 用户 A 向用户 B 发送好友请求，用户 B 收到好友请求后，同意加好友，则用户 A 收到该事件。
  onContactAgreed: function (msg) {},
});
```

2. 调用 `addContact` 请求添加好友，示例代码如下：

```javascript
conn.addContact("userId", "加个好友呗!");
```

3. 对端用户通过 `onContactInvited` 监听事件收到好友请求，确认是否成为好友。

   - 若接受好友请求，需调用 `acceptContactInvite` 方法。请求方收到 `onContactAgreed` 事件。

示例代码如下：

```javascript
conn.acceptContactInvite("userId");
```

   - 若拒绝好友请求，需调用 `declineContactInvite` 方法。请求方收到 `onContactRefuse` 事件。

   示例代码如下：

```javascript
conn.declineContactInvite("userId");
```

#### 删除好友

删除联系人时会同时删除对方联系人列表中的该用户，建议执行双重确认，以免发生误删操作。删除操作不需要对方同意或者拒绝。

你可以调用 `deleteContact` 方法删除好友，示例代码如下：

```javascript
conn.deleteContact("userId");
```

删除好友后，对方会收到 `onContactDeleted` 事件。

### 获取好友列表

你可以调用 `getContacts` 方法查询好友列表，示例代码如下：

```javascript
conn.getContacts().then( (res) => {
    console.log(res) // res.data > ['user1', 'user2']
}
```

### 管理黑名单

#### 添加用户至黑名单

将好友加入黑名单后，对方好友列表依然可以看到己方，但无法向己方发送消息.

你可以调用 `addUsersToBlocklist` 方法将用户加入黑名单，示例代码如下：

```javascript
conn.addUsersToBlocklist({
  //可以添加单个用户 ID 或批量添加多个用户 ID 组成的数组。
  name: ["user1", "user2"],
});
```

#### 将用户移出黑名单

你可以调用 `removeUserFromBlockList` 方法将用户移出黑名单，示例代码如下：

```javascript
conn.removeUserFromBlockList({
  //可以添加单个用户 ID 或批量添加多个用户 ID 组成的数组。
  name: ["user1", "user2"],
});
```

#### 获取黑名单列表

你可以调用 `getBlocklist` 方法获取用户黑名单列表，示例代码如下：

```javascript
conn.getBlocklist().then((res) => {
  console.log(res);
});
```
