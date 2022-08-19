# 群组-群成员管理

群组是支持多人沟通的即时通讯系统。本文介绍如何使用即时通讯 IM SDK 在实时互动 app 中实现群组成员管理相关功能。

## 技术原理

即时通讯 IM Web SDK 提供以下群成员管理功能：

- 群组加人、踢人；
- 管理群主及群管理员；
- 管理群组白名单；
- 管理群组黑名单；
- 管理禁言。

## 前提条件

开始前，请确保满足以下条件：

- 完成 SDK 初始化，详见 [Web 入门](https://docs.agora.io/en/agora-chat/agora_chat_get_started_web?platform=Web)。
- 了解 [使用限制](https://docs.agora.io/en/agora-chat/agora_chat_limitation?platform=Web)。

## 实现方法

### 加入群组

用户进群分为两种方式：主动申请和群成员邀请。

邀请用户入群，详见 [创建群组](https://docs.agora.io/en/agora-chat/agora_chat_group_web?platform=Web#创建群组)。

本节对用户申请加入群组进行详细介绍。

只有公开群组支持用户以申请方式入群，私有群不支持。

若申请加入公开群，用户需执行以下步骤：

1. 用户可获取 [获取群组列表](https://docs.agora.io/en/agora-chat/agora_chat_group_web?platform=Web#获取群组列表)。

2、调用 `joinGroup` 方法传入群组 ID，申请加入对应群组。示例代码如下：

```javascript
let option = {
    groupId: "groupId",
    message: "I am Tom"
};
conn.joinGroup(option).then(res => console.log(res))
```

任何用户均可申请入群，是否需要群主和群管理员审批，取决于 `approval` 选项的设置：

  a. `approval` 为 `false` 时，用户可直接加入群组，无需群主和群管理员审批。其他群成员会收到 `memberPresence` 事件。
  b. `approval` 为 `true` 时，群主和群管理员审批后，用户才能加入群组。群主和群管理员会收到 `requestToJoin` 事件。

    - 若同意用户加入群组，群主或管理员需要调用 `acceptGroupJoinRequest` 方法。

    申请人会收到 `acceptRequest` 事件且加入群组，其他成员会收到 `memberPresence` 事件。

    示例代码如下：

    ```javascript
    conn.acceptGroupJoinRequest({
        applicant: "userId",
        groupId: "groupId",
    });
    ```

    - 若拒绝用户加入群组，群主或管理员需要调用 `rejectGroupJoinRequest` 方法。

     申请人会收到 `joinPublicGroupDeclined` 事件。

    示例代码如下：

    ```javascript
    conn.rejectGroupJoinRequest({
      applicant: "userId",
      groupId: "groupId",
      reason: "sorry, who are you?",
    });
    ```

### 退出群组

#### 群成员主动退出群组

所有群成员可调用 `leaveGroup` 方法退出群组。退出群组的成员不会再收到群消息。其他成员会收到 `memberAbsence` 事件。

示例代码如下：

```javascript
let option = {
    groupId: "groupId"
};
conn.leaveGroup(option).then(res => console.log(res))
```

#### 群成员被移出群组

仅群主和群管理员可以调用 `removeGroupMember` 方法将指定成员移出群组。被踢出群组后，被踢群成员将会收到 `removeMember` 事件，其他成员会收到 `memberAbsence` 监听事件。被移出群组后，该用户还可以再次加入群组。

示例代码如下：

```javascript
let option = {
    groupId: "groupId",
    username: "username"
};
conn.removeGroupMember(option).then(res => console.log(res))
```

### 管理群主及群管理员

#### 变更群组所有者

仅群主可以调用 `changeGroupOwner` 方法将权限移交给群组中指定成员。成功移交后，原群主变为普通成员，其他群组成员会收到 `changeOwner` 事件。

```javascript
let option = {
    groupId: "groupId",
    newOwner: "userId"
};
conn.changeGroupOwner(option).then(res => console.log(res))
```

#### 添加群组管理员

仅群主可以调用 `setGroupAdmin` 方法添加群管理员。成功添加后，新管理员及其他管理员会收到 `setAdmin` 监听事件。

群管理员除了不能散群组等少数权限外，拥有对群组的绝大部分权限。

示例代码如下：

```javascript
let option = {
    groupId: "groupId",
    username: "userId"
};
conn.setGroupAdmin(option).then(res => console.log(res))
```

#### 将管理员移出管理员列表

仅群主可以调用 `removeGroupAdmin` 方法移除群管理员。成功移除后，被移除的管理员及其他管理员会收到 `removeAdmin` 事件。

群主移除指定群管理员的权限后，将只拥有普通群成员的权限。

示例代码如下：

```javascript
let option = {
    groupId: "groupId",
    username: "userId"
};
conn.removeGroupAdmin(option).then(res => console.log(res))
```

#### 获取群组管理员列表

所有群成员均可调用 `getGroupAdmin` 获取群组下所有管理员，示例代码如下：

```javascript
let option = {
    groupId: "groupId"
};
conn.getGroupAdmin(option).then((res) => {
    console.log(res)
})
```

也可以通过 [获取群组详情信息](https://docs.agora.io/en/agora-chat/agora_chat_group_web?platform=Web#获取群组详情信息) 获取管理员列表。

### 管理群组白名单

群主和群管理员可以将指定群成员加入或者移出群白名单，开启群组全员禁言后，白名单用户不受全员禁言限制。如果白名单用户在群禁言列表中，该用户也不能发言。

#### 将成员加入群组白名单

仅群主或者群管理员可调用 `addUsersToGroupAllowlist` 方法将群成员添加到群白名单。添加后，该群成员及群管理员和群主（除操作者外）会收到 `addUserToAllowlist` 事件。

示例代码如下：

```javascript
let option = {
    groupId: "groupId",
    users: ["user1", "user2"]
};
conn.addUsersToGroupAllowlist(option).then(res => console.log(res));
```

#### 将成员移出群组白名单

仅群主或者群管理员可将调用 `removeGroupAllowlistMember` 方法群成员移出群白名单。移出后，该群成员及群管理员和群主（除操作者外）会收到 `removeAllowlistMember` 事件。

示例代码如下：

```javascript
let option = {
    groupId: "groupId",
    userName: "userId"
}
conn.removeGroupAllowlistMember(option).then(res => console.log(res));
```

#### 检查当前用户是否在群组白名单中

所有群成员可以调用 `isInGroupAllowlist` 方法检查自己是否在群白名单中。

示例代码如下：

```javascript
let option = {
    groupId: "groupId",
    userName: "userId"
}
conn.isInGroupAllowlist(option).then(res => console.log(res));
```

#### 获取群组白名单

仅群主和群管理员可以调用 `getGroupBlocklist` 方法获取群组白名单列表。

示例代码如下：

```javascript
let option = {
    groupId: "groupId"
}
conn.getGroupBlocklist(option).then(res => console.log(res));
```

### 管理群组黑名单

#### 将成员加入群组黑名单

仅群主和群管理员可以调用 `blockGroupMembers` 方法将指定成员添加至群组黑名单。

被加入黑名单后，该成员会收到 `removeMember` 事件。

群成员被加入黑名单后无法再收发群组消息并被移出群组，如想再次加入群组，群主或群管理员必须先将其移出黑名单。

示例代码如下：

```javascript
let option = {
    groupId: "groupId",
    usernames: ["user1", "user2"]
};
conn.blockGroupMembers(option).then(res => console.log(res))
```

### 将成员移出群组黑名单

仅群主和群管理员可以调用 `unblockGroupMembers` 方法将成员移出群组黑名单。指定用户被群主或者群管理员移出群黑名单后，可以再次申请加入群组。

示例代码如下：

```javascript
let option = {
    groupId: "groupId",
    username: ["user1", "user2"]
}
conn.unblockGroupMembers(option).then(res => console.log(res))
```

#### 获取群组黑名单列表

仅群主和群管理员可以调用 `getGroupBlocklist` 方法获取当前群组的黑名单。默认最多取 200 个。

示例代码如下：

```javascript
let option = {
    groupId: "groupId",
};
conn.getGroupBlocklist(option).then(res => console.log(res))
```

### 管理群组禁言

群主和群管理员可以将指定群成员添加或移出禁言列表，也可开启关闭全员禁言。全员禁言和单独的成员禁言不冲突，开启和关闭全员禁言，并不影响禁言列表。

#### 将成员加入群组禁言列表

仅群主和群管理员可以调用 `muteGroupMember` 方法将指定成员添加至群组禁言列表。群成员被加入禁言列表中后，被禁言成员、群组管理员和者群主（除操作者外）会收到 `muteMember` 事件。群成员被加入群禁言列表后，将不能够发言，即使其被加入群白名单也不能发言。

示例代码如下：

```javascript
let option = {
    groupId: "groupId"，
    username: "userId",
    muteDuration: 886400000 // 禁言时长，单位为毫秒。
};
conn.muteGroupMember(option).then(res => console.log(res))
```

#### 将成员移出群组禁言列表

仅群主和群管理员可以调用 `unmuteGroupMember` 方法将指定成员移出群组禁言列表。被移出的成员、群组管理员和者群主（除操作者外）会收到 `unmuteMember` 事件。

示例代码如下：

```javascript
let option = {
    groupId: "groupId",
    username: "userId"
};
conn.unmuteGroupMember(option).then(res => console.log(res))
```

#### 获取群组禁言列表

仅群主和群管理员可以调用 `getGroupMutelist` 方法获取群组的禁言列表。

示例代码如下：

```javascript
let option = {
    groupId: "groupId"
};
conn.getGroupMutelist(option).then(res => console.log(res))
```

#### 开启群组全员禁言

仅群主和群管理员可以调用 `disableSendGroupMsg` 方法开启群组全员禁言。群组全员开启禁言后，群成员将会收到 `muteAllMembers` 事件，除群组白名单中的成员，其他成员将不能发言。

示例代码如下：

```javascript
let option = {
    groupId: "groupId",
};
conn.disableSendGroupMsg(option).then(res => console.log(res))
```

#### 关闭群组全员禁言

仅群主和群管理员可以调用 `enableSendGroupMsg` 方法关闭群组全员禁言。关闭群组全员禁言后，群成员将会收到 `unmuteAllMembers` 事件。

示例代码如下：

```javascript
let option = {
    groupId: "groupId",
};
conn.enableSendGroupMsg(option).then(res => console.log(res))
```

### 监听群组事件

有关详细信息，请参阅 [监听事件](https://docs.agora.io/en/agora-chat/agora_chat_group_web?platform=Web#listen-for-chat-group-events)。