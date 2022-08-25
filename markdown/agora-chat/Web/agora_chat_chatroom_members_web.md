# 聊天室-管理聊天室成员

聊天室是支持多人沟通的即时通讯系统。本文介绍如何使用即时通讯 IM Web SDK 在实时互动 app 中管理聊天室成员，并实现聊天室的相关功能。

## 技术原理

即时通讯 IM SDK 支持对聊天室成员的管理，包括获取、添加和移出聊天室成员等：

- 获取聊天室成员列表；
- 将成员移出聊天室；
- 管理聊天室黑名单；
- 管理聊天室白名单；
- 管理聊天室禁言；
- 管理聊天室所有者及管理员。

## 前提条件

开始前，请确保满足以下条件：

- 完成 SDK 初始化，详见 [Web 入门](https://docs.agora.io/en/agora-chat/agora_chat_get_started_web?platform=Web)。
- 了解 [使用限制](https://docs.agora.io/en/agora-chat/agora_chat_limitation?platform=Web)。
- 了解即时通讯 IM 聊天室不同版本的数量限制，详见 [套餐包](https://docs.agora.io/en/agora-chat/agora_chat_plan?platform=Web)。


## 实现方法

### 获取聊天室成员列表

聊天室所有成员均可调用 `listChatRoomMembers` 获取当前聊天室成员列表。

示例代码如下：

```javascript
let option = {
    pageNum: 1,
    pageSize: 10,
    chatRoomId: 'chatRoomId'
}
conn.listChatRoomMembers(option).then(res => console.log(res))
```

### 退出聊天室

#### 成员主动退出聊天室

聊天室所有成员均可以调用 `leaveChatRoom` 退出当前聊天室。成员退出聊天室时，其他成员收到 `memberAbsence` 事件。与群主无法退出群组不同，聊天室所有者可以离开聊天室，如果所有者从服务器下线则 5 分钟后自动离开聊天室。如果所有者重新进入聊天室仍是该聊天室的所有者。

示例代码如下：

```javascript
let option = {
    roomId: 'roomId'
}
conn.leaveChatRoom(option).then(res => console.log(res))
```

#### 成员被移出聊天室

仅聊天室所有者和聊天室管理员可以调用 `removeChatRoomMember` 方法将指定成员移出聊天室。被踢出聊天室后，被踢成员会收到 `removeMember` 事件，其他成员会收到 `memberAbsence` 事件。被移出聊天室后，该用户还可以再次加入聊天室。

示例代码如下：

```javascript
let option = {
    chatRoomId: "chatRoomId",
    username: "userId"
};
conn.removeChatRoomMember(option).then(res => console.log(res))
```

### 管理聊天室黑名单

#### 获取聊天室黑名单列表

仅聊天室所有者和管理员可调用 `getChatRoomBlocklist` 获取当前聊天室黑名单成员列表。

示例代码如下：

```javascript
let option = {
    chatRoomId: "chatRoomId",
};
conn.getChatRoomBlocklist(option);
```

#### 将成员添加至聊天室黑名单

仅聊天室所有者和管理员可调用 `blockChatRoomMembers` 方法将成员加入聊天室黑名单。

被加入黑名单的成员会收到 `removeMember` 事件，其他成员收到 `memberAbsence` 事件。

被加入黑名单后，该成员无法再收发聊天室消息并被移出聊天室。黑名单中的成员如想再次加入聊天室，聊天室所有者或管理员必须先将其移出黑名单列表。

示例代码如下：

```javascript
let option = {
    chatRoomId: 'chatRoomId',
    usernames: ['user1', 'user2'] // 用户 ID 数组。
};
conn.blockChatRoomMembers(option).then(res => console.log(res));
```

#### 将成员移出聊天室黑名单

仅聊天室所有者和管理员可调用 `unblockChatRoomMembers` 方法将成员移出聊天室黑名单。

示例代码如下：

```javascript
let option = {
    chatRoomId: "chatRoomId",
    usernames: ["user1", "user2"] // 用户 ID 数组。
}
conn.unblockChatRoomMembers(option).then(res => console.log(res));
```

### 管理聊天室白名单

#### 获取聊天室白名单列表

仅聊天室所有者和管理员可调用 `getChatRoomAllowlist` 方法获取当前聊天室白名单成员列表。

示例代码如下：

```javascript
let option = {
    chatRoomId: "chatRoomId"
}
conn.getChatRoomAllowlist(option).then(res => console.log(res));
```

#### 检查自己是否在聊天室白名单中

所有聊天室成员可以调用 `isInChatRoomAllowlist` 方法检查自己是否在聊天室白名单中。

**注意**

聊天室的管理员可查询所有用户，普通成员只能查询自己。

示例代码如下：

```javascript
let option = {
    chatRoomId: "chatRoomId",
    userName: "user"
}
conn.isInChatRoomAllowlist(option);
```

#### 将成员加入聊天室白名单

仅聊天室所有者和管理员可调用 `addUsersToChatRoomAllowlist` 方法将成员添加至聊天室白名单。

示例代码如下：

```javascript
let option = {
    chatRoomId: "chatRoomId",
    users: ["user1", "user2"] // 成员 ID 列表。
};
conn.addUsersToChatRoomAllowlist(option);
```

#### 将成员移出聊天室白名单

仅聊天室所有者和管理员可调用 `removeChatRoomAllowlistMember` 方法将成员移出聊天室白名单。

示例代码如下：

```javascript
let option = {
    chatRoomId: "chatRoomId",
    userName: "userId"
}
conn.removeChatRoomAllowlistMember(option);
```

### 管理禁言

聊天室所有者和管理员可以将指定聊天室成员添加或移出禁言列表，也可开启关闭全员禁言。全员禁言和单独的成员禁言不冲突，开启和关闭全员禁言，并不影响禁言列表。

#### 获取聊天室禁言列表

仅聊天室所有者和管理员可调用 `getChatRoomMuteList` 方法获取聊天室禁言列表。

示例代码如下：

```javascript
let option = {
    chatRoomId: "chatRoomId"
};
conn.getChatRoomMuteList(option).then(res => console.log(res))
```

#### 将成员添加至聊天室禁言列表

仅聊天室所有者和管理员可调用 `muteChatRoomMember` 方法将指定成员添加至聊天室禁言列表。除操作者外，聊天室其他成员会收到 `muteMember` 事件。

**注意**

聊天室所有者可禁言聊天室所有成员，聊天室管理员可禁言聊天室普通成员。

示例代码如下：

```javascript
let option = {
    chatRoomId: "chatRoomId", // 聊天室 ID。
    username: 'userId',     // 被禁言的聊天室成员的 ID。
    muteDuration: -1000       // 禁言时长，单位为毫秒。若传 “-1,000” 表示永久禁言。
};
conn.muteChatRoomMember(option).then(res => console.log(res))
```

#### 将成员移出聊天室禁言列表

仅聊天室所有者和管理员可调用 `unmuteChatRoomMember` 方法将一组成员解除禁言。

**注意**

聊天室所有者可对聊天室所有成员解除禁言，聊天室管理员可对聊天室普通成员解除禁言。除操作者外，聊天室其他成员会收到 `removeMute` 事件。

示例代码如下：

```javascript
let option = {
    chatRoomId: "chatRoomId",
    username: 'username'
};
conn.unmuteChatRoomMember(option).then(res => console.log(res))
```


#### 开启全员禁言

仅聊天室所有者和管理员可调用 `disableSendChatRoomMsg` 方法设置全员禁言。全员禁言开启后，除了在白名单中的群成员，其他成员不能发言。调用成功后，聊天室成员会收到 `muteAllMembers` 事件。

示例代码如下：

```javascript
let option = {
    chatRoomId: "chatRoomId"
};
conn.disableSendChatRoomMsg(option).then(res => console.log(res))
```

#### 关闭全员禁言

仅聊天室所有者和管理员可调用 `enableSendChatRoomMsg` 方法设置解除全员禁言。解除全员禁言后，仅在黑名单中的成员不可以发言，聊天室成员会收到 `unmuteAllMembers` 事件。

示例代码如下：

```javascript
let option = {
    chatRoomId: "chatRoomId"
};
conn.enableSendChatRoomMsg(option).then((res) => {
    console.log(res)
})
```

### 管理聊天室管理员

#### 添加聊天室管理员

仅聊天室所有者可调用 `setChatRoomAdmin` 添加聊天室管理员。成功添加后，新管理员及其他管理员会收到 `setAdmin` 事件。

示例代码如下：

```javascript
let option = {
    chatRoomId: 'chatRoomId',
    username: 'userId'
}
conn.setChatRoomAdmin(option).then(res => console.log(res))
```

#### 移除聊天室管理员

仅聊天室的所有者可调用 `removeChatRoomAdmin` 方法移除聊天室管理员。成功移除后，被移除的聊天室管理员和其他管理员会收到 `removeAdmin` 事件。

示例代码如下：

```javascript
let option = {
    chatRoomId: 'chatRoomId',
    username: 'userId'
}
conn.removeChatRoomAdmin(option).then(res => console.log(res))
```

### 监听聊天室事件

有关详细信息，请参阅 [聊天室事件](https://docs.agora.io/en/agora-chat/agora_chat_chatroom_web?platform=Web#监听聊天室事件)。