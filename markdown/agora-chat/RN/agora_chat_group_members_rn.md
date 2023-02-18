群组是支持多人沟通的即时通讯系统，本文介绍如何使用即时通讯 IM SDK 在实时互动 app 中实现群组成员管理相关功能。

## 技术原理

即时通讯 IM React Native SDK 提供 `ChatGroupManager` 类和 `ChatGroup` 类用于群组管理，支持你通过调用 API 在项目中实现如下功能：

- 群组加人
- 群组踢人
- 管理群主及群管理员
- 管理群组黑名单
- 管理群组禁言列表
- 开启、关闭群组全员禁言
- 管理群组白名单
- 获取群组成员

## 前提条件

开始前，请确保满足以下条件：

- 完成 SDK 初始化，并连接到服务器，详见 [RN 快速开始](./agora_chat_get_started_rn)。
- 了解即时通讯 IM 的 [使用限制](./agora_chat_limitation)。
- 了解群组和群成员的数量限制，详见 [套餐包详情](./agora_chat_plan)。

## 实现方法

本节介绍如何使用即时通讯 IM SDK 提供的 API 实现上述功能。

### 群组加人

用户进群分为两种方式：主动申请入群和群成员邀请入群。

公开群和私有群在两种入群方式方面存在差别：

| 入群方式<div style="width: 240px;"></div>       | 公开群 | 私有群   |
| :--------- | :----- | :------- |
| 是否支持用户申请入群 | 支持 <br/>任何用户均可申请入群，是否需要群主和群管理员审批，取决于群样式 `EMGroupStyle` 的设置。 | 不支持 <br/>  |
| 是否支持群成员邀请用户入群 | 支持 <br/>只能由群主和管理员邀请。 | 支持 <br/>除了群主和群管理员，群成员是否也能邀请其他用户进群取决于群样式 `EMGroupStyle` 的设置。 |

#### 用户申请入群

只有公开群组支持用户以申请方式入群，私有群不支持。用户可获取公开群列表，选择相应的群组 ID，然后调用相应方法加入该群组。

任何用户均可申请入群，是否需要群主和群管理员审批，取决于群样式（`EMGroupStyle`）的设置：

- `EMGroupStyle`  为  `EMGroupStylePublicJoinNeedApproval` 时，群主和群管理员审批后，用户才能加入群组；
- `EMGroupStyle`  为  `EMGroupStylePublicOpenJoin` 时，用户可直接加入群组，无需群主和群管理员审批。

若申请加入公开群，申请人需执行以下步骤：

1. 调用 `fetchPublicGroupsFromServer` 方法从服务器获取公开群列表，查询到想要加入的群组 ID。示例代码如下：

```typescript
// 通过分页的方式获取公开群组的列表。
// 每页期望返回的群组数。
const pageSize = 10;
// 获取数据的起始位置。首次调用可为空，后续由服务器返回。
const cursor = "";
ChatClient.getInstance()
  .groupManager.fetchPublicGroupsFromServer(pageSize, cursor)
  .then(() => {
    console.log("get group list success.");
  })
  .catch((reason) => {
    console.log("get group list fail.", reason);
  });
```

2. 调用 `joinPublicGroup` 或 `requestToJoinPublicGroup` 方法传入群组 ID，申请加入对应群组。
    1. 调用 `joinPublicGroup` 方法加入无需群主或管理员审批的公共群组，即 `ChatGroupStyle` 设置为 `PublicOpenJoin`。
    申请人不会收到任何回调，其他群成员会收到 `ChatGroupEventListener#onMemberJoined` 回调。

    示例代码如下：

    ```typescript
    // groupId: 群组 ID
    ChatClient.getInstance()
    .groupManager.joinPublicGroup(groupId)
    .then(() => {
        console.log("join group operation success.");
    })
    .catch((reason) => {
        console.log("join group operation fail.", reason);
    });
    ```

    2. 调用 `requestToJoinPublicGroup` 方法加入需要群主或管理员审批的公共群组，即 `ChatGroupStyle` 设置为 `PublicJoinNeedApproval`。示例代码如下：

    ```typescript
    // 申请加入指定群组。
    const groupId = "100";
    const reason = "study typescript";
    ChatClient.getInstance()
    .groupManager.requestToJoinPublicGroup(groupId, reason)
    .then(() => {
        console.log("request send success.");
    })
    .catch((reason) => {
        console.log("request send fail.", reason);
    });
    ```

    群主或群管理员收到 `ChatGroupEventListener#onRequestToJoinReceived` 回调：

    - 若同意加入群组，需要调用 `acceptJoinApplication` 方法。

    申请人会收到 `ChatGroupEventListener#onRequestToJoinAccepted` 回调，其他群成员会收到 `ChatGroupEventListener#onMemberJoined` 回调。

    示例代码如下：

    ```typescript
    // groupId: 群组 ID
    // username：用户 ID
    ChatClient.getInstance()
    .groupManager.acceptJoinApplication(groupId, username)
    .then(() => {
        console.log("accept join request operation success.");
    })
    .catch((reason) => {
        console.log("accept join request operation fail.", reason);
    });
    ```

    - 若群主或群管理员拒绝申请人入群，需要调用 `declineJoinApplication` 方法。申请人会收到 `ChatGroupEventListener#onRequestToJoinDeclined` 回调。

    示例代码如下：

    ```typescript
    // groupId: 群组 ID
    // username：用户 ID
    // reason：拒绝的理由
    ChatClient.getInstance()
    .groupManager.declineJoinApplication(groupId, username, reason)
    .then(() => {
        console.log("decline join request operation success.");
    })
    .catch((reason) => {
        console.log("decline join request operation fail.", reason);
    });
    ```

#### 邀请用户入群

邀请方式见 [邀请用户入群的配置](group_manage.html#创建群组)。

邀请用户加群流程如下：

1. 群成员邀请用户入群。

    - 群主或群管理员加人，需要调用 `addMembers` 方法：

    ```typescript
    // 群主或者管理员添加群成员
    const groupId = "100";
    // 群成员列表
    const members = ["Tom", "Json"];
    // 欢迎消息
    const welcome = "Welcome to you";
    ChatClient.getInstance()
    .groupManager.addMembers(groupId, members, welcome)
    .then(() => {
        console.log("add members success.");
    })
    .catch((reason) => {
        console.log("add members fail.", reason);
    });
    ```

    - 普通成员邀请人入群，需要调用 `inviteUser` 方法：

    `EMGroupStyle` 设置为 `PrivateMemberCanInvite` 时，所有群成员均可以邀请人进群。

    ```typescript
    // groupId: 群组 ID
    // members：受邀用户列表
    // reason：邀请的原因
    ChatClient.getInstance()
    .groupManager.inviteUser(groupId, members, reason)
    .then(() => {
        console.log("invite members operation success.");
    })
    .catch((reason) => {
        console.log("invite members operation fail.", reason);
    });
    ```

2. 受邀用户自动进群或确认是否加入群组：

    - 受邀用户同意加入群组，需要调用 `acceptInvitation` 方法。

    ```typescript
    // groupId: 群组 ID
    // inviter：邀请人的 ID
    ChatClient.getInstance()
    .groupManager.acceptInvitation(groupId, inviter)
    .then(() => {
        console.log("accept invitation operation success.");
    })
    .catch((reason) => {
        console.log("accept invitation operation fail.", reason);
    });
    ```

    - 受邀人拒绝入群组，需要调用 `declineInvitation` 方法。

    ```typescript
    // groupId: 群组 ID
    // inviter：邀请人的 ID
    // reason：拒绝的理由
    ChatClient.getInstance()
    .groupManager.declineInvitation(groupId, inviter, reason)
    .then(() => {
        console.log("decline invitation operation success.");
    })
    .catch((reason) => {
        console.log("decline invitation operation fail.", reason);
    });
    ```

### 群组踢人

仅群主和群管理员可以调用 `removeMembers` 方法将指定成员移出群组。被移出群组后，该成员收到 `ChatGroupEventListener#onUserRemoved` 回调，其他群成员收到 `ChatGroupEventListener#onMemberExited` 回调。被移出群组后，该用户还可以再次加入群组。

示例代码如下：

```typescript
ChatClient.getInstance()
  .groupManager.removeMembers(groupId, members)
  .then(() => {
    console.log("remove members success.");
  })
  .catch((reason) => {
    console.log("remove members fail.", reason);
  });
```

### 管理群主和群管理员

#### 变更群主

仅群主可以调用 `changeOwner` 方法将权限移交给群组中指定成员。成功移交后，原群主变为普通成员，其他群成员收到 `ChatGroupEventListener#onOwnerChanged` 回调。

示例代码如下：

```typescript
ChatClient.getInstance()
  .groupManager.changeOwner(groupId, newOwner)
  .then(() => {
    console.log("change owner success.");
  })
  .catch((reason) => {
    console.log("change owner fail.", reason);
  });
```

#### 添加群组管理员

仅群主可以调用 `addAdmin` 方法添加群管理员。成功添加后，新管理员及其他管理员收到 `ChatGroupEventListener#onAdminAdded` 回调。管理员除了不能解散群组等少数权限外，拥有对群组的绝大部分权限。

示例代码如下：

```typescript
ChatClient.getInstance()
  .groupManager.addAdmin(groupId, memberId)
  .then(() => {
    console.log("add admin success.");
  })
  .catch((reason) => {
    console.log("add admin fail.", reason);
  });
```

#### 移除群组管理员权限

仅群主可以调用 `removeAdmin` 方法移除群管理员的管理权限。成功移除后，被移除的管理员及其他管理员收到 `ChatGroupEventListener#onAdminRemoved` 回调。群组管理员的管理权限被移除后，将只拥有群成员的权限。

示例代码如下：

```typescript
ChatClient.getInstance()
  .groupManager.removeAdmin(groupId, memberId)
  .then(() => {
    console.log("remove admin success.");
  })
  .catch((reason) => {
    console.log("remove admin fail.", reason);
  });
```

### 管理群组黑名单

群主及群管理员可以将群组中的指定群成员加入或者移出群黑名单。群成员被加入黑名单后将无法收发群消息。

#### 将群成员拉入群组黑名单

仅群主和群管理员可以调用 `blockMembers` 方法将指定成员添加至黑名单。被加入黑名单后，该成员收到 `ChatGroupEventListener#onUserRemoved` 回调，其他群成员收到 `ChatGroupEventListener#onMemberExited` 回调。被加入黑名单后，该成员无法再收发群组消息并被移出群组，黑名单中的成员如想再次加入群组，群主或群管理员必须先将其移除黑名单。

示例代码如下：

```typescript
ChatClient.getInstance()
  .groupManager.blockMembers(groupId, members)
  .then(() => {
    console.log("block members success.");
  })
  .catch((reason) => {
    console.log("block members fail.", reason);
  });
```

#### 将成员移出群组黑名单

仅群主和群管理员可以调用 `unblockMembers` 方法将成员移出群组黑名单。指定用户被群主或者群管理员移出群黑名单后，可以再次申请加入群组。

示例代码如下：

```typescript
ChatClient.getInstance()
  .groupManager.unblockMembers(groupId, members)
  .then(() => {
    console.log("unblock members success.");
  })
  .catch((reason) => {
    console.log("unblock members fail.", reason);
  });
```

#### 获取群组的黑名单用户列表

仅群主和群管理员可以调用 `fetchBlockListFromServer` 方法获取当前群组的黑名单。默认最多取 200 个。
示例代码如下：

```typescript
ChatClient.getInstance()
  .groupManager.fetchBlockListFromServer(groupId, pageSize, pageNum)
  .then((list) => {
    console.log("get block members success: ", list);
  })
  .catch((reason) => {
    console.log("get block members fail.", reason);
  });
```

### 管理群组禁言列表

为了方便管理群组，即时通讯 IM SDK 提供了针对成员和群组的禁言操作。

#### 将成员加入群组禁言列表

仅群主和群管理员可以调用 `muteMembers` 方法将指定成员添加至群组禁言列表。被禁言后，该成员和其他未操作的管理员或者群主收到 `ChatGroupEventListener#onMuteListAdded` 回调。群成员被加入群禁言列表后，不能在该群组中发言，即使被加入群白名单也不能发言。

示例代码如下：

```typescript
// groupId：群组 ID
// members：将要被禁言的成员列表
// duration：禁言时间
ChatClient.getInstance()
  .groupManager.muteMembers(groupId, members, duration)
  .then(() => {
    console.log("mute members operation success.");
  })
  .catch((reason) => {
    console.log("mute members operation fail.", reason);
  });
```

#### 将成员移出群组禁言列表

仅群主和群管理员可以调用 `unMuteMembers` 方法将指定成员移出群组禁言列表。被解除禁言后，该成员和其他未做操作的群管理员或者群主收到 `ChatGroupEventListener#onMuteListRemoved` 回调。

示例代码如下：

```typescript
ChatClient.getInstance()
  .groupManager.unMuteMembers(groupId, members)
  .then(() => {
    console.log("unMute members success.");
  })
  .catch((reason) => {
    console.log("unMute members fail.", reason);
  });
```

#### 获取群组禁言列表

仅群主和群管理员可以调用 `fetchMuteListFromServer` 方法从服务器分页获取当前群组的禁言列表。

示例代码如下：

```typescript
// groupId：群组 ID
// pageSize：期望获取的最大数量
// pageNum：请求第几页，从 1 开始
ChatClient.getInstance()
  .groupManager.fetchMuteListFromServer(groupId, pageSize, pageNum)
  .then((list) => {
    console.log("get mute list success: ", list);
  })
  .catch((reason) => {
    console.log("get mute list fail.", reason);
  });
```

### 开启和关闭全员禁言

为了快捷管理群成员发言，群主和群成员可以开启和关闭群组全员禁言。

#### 开启全员禁言

仅群主和群管理员可以调用 `muteAllMembers` 方法开启全员禁言。群组全员禁言开启后，所有成员收到 `ChatGroupEventListener#onAllGroupMemberMuteStateChanged` 回调，除了在白名单中的群成员，其他成员不能发言。

示例代码如下：

```typescript
ChatClient.getInstance()
  .groupManager.muteAllMembers(groupId)
  .then(() => {
    console.log("mute all members success.");
  })
  .catch((reason) => {
    console.log("mute all members fail.", reason);
  });
```

#### 关闭全员禁言

仅群主和群管理员可以调用 `unMuteAllMembers` 方法取消全员禁言。所有成员收到 `ChatGroupEventListener#onAllGroupMemberMuteStateChanged` 回调。

示例代码如下：

```typescript
ChatClient.getInstance()
  .groupManager.unMuteAllMembers(groupId)
  .then(() => {
    console.log("unMute all members success.");
  })
  .catch((reason) => {
    console.log("unMute all members fail.", reason);
  });
```

### 管理群组白名单

#### 将成员加入群组白名单

仅群主和群管理员可以调用 `addAllowList` 方法将指定群成员加入群白名单。白名单用户不受全员禁言的限制，但是如果白名单用户在群禁言列表中，则该用户不能发言。被加入白名单的成员及管理员和群主收到 `ChatGroupEventListener#onAllowListAdded` 回调。

示例代码如下：

```typescript
ChatClient.getInstance()
  .groupManager.addAllowList(groupId, members)
  .then(() => {
    console.log("add allowlist success.");
  })
  .catch((reason) => {
    console.log("add allowlist fail.", reason);
  });
```

#### 将成员移出白名单

仅群主和群管理员可以调用 `removeWhiteList` 方法将指定群成员移出群白名单。

当发生该事件时，被移出白名单的成员及管理员和群主收到 `ChatGroupEventListener#onAllowListRemoved` 回调。

示例代码如下：

```typescript
ChatClient.getInstance()
  .groupManager.removeAllowList(groupId, members)
  .then(() => {
    console.log("remove allowlist success.");
  })
  .catch((reason) => {
    console.log("remove allowlist fail.", reason);
  });
```

#### 检查当前用户是否在白名单中

所有群成员可以调用 `isMemberInAllowListFromServer` 方法检查自己是否在群白名单中，示例代码如下：

```typescript
ChatClient.getInstance()
  .groupManager.isMemberInAllowListFromServer(groupId)
  .then((isMember) => {
    console.log("is member success: ", isMember);
  })
  .catch((reason) => {
    console.log("is member fail.", reason);
  });
```

#### 获取群组白名单

仅群主和群管理员可以调用 `fetchAllowListFromServer` 方法从服务器获取当前群组的白名单。

示例代码如下：

```typescript
ChatClient.getInstance()
  .groupManager.fetchAllowListFromServer(groupId)
  .then(() => {
    console.log("get allowlist success.");
  })
  .catch((reason) => {
    console.log("get allowlist fail.", reason);
  });
```

### 获取群组成员

#### 通过服务器分页获取群组成员

```typescript
// groupId：群组 ID
// pageSize：期望获取的最大数量
// cursor：开始分页的位置，第一页为空，后续页面请使用第一页返回的结果
ChatClient.getInstance()
  .groupManager.fetchMemberListFromServer(groupId, pageSize, cursor)
  .then(() => {
    console.log("get group members success.");
  })
  .catch((reason) => {
    console.log("get group members fail.", reason);
  });
```

### 监听群组事件

有关详细信息，请参阅 [监听群组事件](./agora_chat_group_rn?platform=rn#监听群组事件)。