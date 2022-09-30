群组是支持多人沟通的即时通讯系统，本文介绍如何使用即时通讯 IM Flutter SDK 在实时互动 app 中实现群组成员管理相关功能。
## 技术原理

即时通讯 IM Flutter SDK 提供了 `ChatGroup`, `ChatGroupManager` 和 `ChatGroupEventHandler` 类用于群组管理，可以实现以下功能：

- 群组加人、踢人
- 管理群主及群管理员
- 管理群组黑名单
- 管理群组禁言列表
- 开启、关闭群组全员禁言
- 管理群组白名单

## 前提条件

开始前，请确保满足以下条件：

- 完成 SDK 初始化，详见 [快速开始](./agora_chat_get_started_flutter)。
- 了解 [使用限制](./agora_chat_limitation)。
- 了解群组和群成员的数量限制，详见 [套餐包详情](./agora_chat_plan)。

## 实现方法

本节介绍如何使用即时通讯 IM Flutter SDK 提供的 API 实现上述功能。

### 群组加人

根据创建群组时的群组类型 (`GroupStyle`) 和进群邀请是否需要对方同意 (`ChatGroupOptions#inviteNeedConfirm`) 设置，群组加人的处理逻辑有差别。具体规则可以参考 [创建群组](./agora_chat_group_flutter#创建群组)。

示例代码如下：

```dart
try {
  await ChatClient.getInstance.groupManager.addMembers(groupId, members);
} on ChatError catch (e) {
}
```

### 群组踢人

1. 仅群主和群管理员可以调用 `ChatGroupManager#removeMembers` 方法将指定成员移出群组。
2. 被移出群组后，该成员收到 `ChatGroupEventHandler#onUserRemovedFromGroup` 事件，其他群成员收到 `ChatGroupEventHandler#onMemberExitedFromGroup` 事件。
3. 被移出群组后，该用户还可以再次加入群组。

以下代码示例显示了如何从聊天组中删除成员：

```dart
try {
  await ChatClient.getInstance.groupManager.removeMembers(groupId, members);
} on ChatError catch (e) {
}
```

### 管理群主和群管理员

#### 变更群主

仅群主可以调用 `ChatGroupManager#changeOwner` 方法将权限移交给群组中指定成员。成功移交后，原群主变为普通成员，其他群成员收到 `ChatGroupEventHandler#onOwnerChangedFromGroup` 事件。

示例代码如下：

```dart
try {
  await ChatClient.getInstance.groupManager.changeOwner(groupId, newOwner);
} on ChatError catch (e) {
}
```

#### 添加群组管理员

仅群主可以调用 `ChatGroupManager#addAdmin` 方法添加群管理员。成功添加后，新管理员及其他管理员收到 `ChatGroupEventHandler#onAdminAddedFromGroup` 事件。

示例代码如下：

```dart
try {
  ChatClient.getInstance.groupManager.addAdmin(groupId, memberId);
} on ChatError catch (e) {
}
```

#### 移除群组管理员权限

仅群主可以调用 `ChatGroupManager#removeAdmin` 方法移除群管理员的管理权限。成功移除后，被移除的管理员及其他管理员收到 `ChatGroupEventHandler#onAdminRemovedFromGroup` 事件。群组管理员的管理权限被移除后，将只拥有群成员的权限。

示例代码如下：

```dart
try {
  await ChatClient.getInstance.groupManager.removeAdmin(groupId, adminId);
} on ChatError catch (e) {
}
```

### 管理群组黑名单

#### 将成员加入群组黑名单

仅群主和群管理员可以调用 `ChatGroupManager#blockMembers` 方法将指定成员添加至黑名单。被加入黑名单后，该成员收到 `ChatGroupEventHandler#onUserRemovedFromGroup` 事件，其他群成员收到 `ChatGroupEventHandler#onMemberExitedFromGroup` 事件。被加入黑名单后，该成员无法再收发群组消息并被移出群组，黑名单中的成员如想再次加入群组，群主或群管理员必须先将其移除黑名单。

示例代码如下：

```dart
try {
  await ChatClient.getInstance.groupManager.blockMembers(groupId, members);
} on ChatError catch (e) {
}
```

#### 将成员移出群组黑名单

仅群主和群管理员可以调用 `ChatGroupManager#unblockMembers` 方法将成员移出群组黑名单。指定用户被群主或者群管理员移出群黑名单后，可以再次申请加入群组。

示例代码如下：

```dart
try {
  await ChatClient.getInstance.groupManager.unblockMembers(groupId, blockIds);
} on ChatError catch (e) {
}
```

#### 获取群组的黑名单用户列表

仅群主和群管理员可以调用 `ChatGroupManager#fetchBlockListFromServer` 方法获取当前群组的黑名单。

示例代码如下：

```dart
try {
  await ChatClient.getInstance.groupManager.fetchBlockListFromServer(
    groupId,
    pageNum: pageNum,
    pageSize: pageSize,
  );
} on ChatError catch (e) {
}
```

### 管理群组禁言列表

#### 将成员加入群组禁言列表

仅群主和群管理员可以调用 `ChatGroupManager#muteMembers` 方法将指定成员添加至群组禁言列表。被禁言后，该成员和其他未操作的管理员或者群主收到 `ChatGroupEventHandler#onMuteListAddedFromGroup` 事件。群成员被加入群禁言列表后，不能在该群组中发言，即使被加入群白名单也不能发言。

示例代码如下：

```dart
try {
  await ChatClient.getInstance.groupManager.muteMembers(
    groupId,
    members,
  );
} on ChatError catch (e) {
}
```

#### 将成员移出群组禁言列表

仅群主和群管理员可以调用 `ChatGroupManager#unMuteMembers` 方法将指定成员移出群组禁言列表。被解除禁言后，该成员和其他未做操作的群管理员或者群主收到 `ChatGroupEventHandler#onMuteListRemovedFromGroup` 事件。

示例代码如下：

```dart
try {
  await ChatClient.getInstance.groupManager.unMuteMembers(
    groupId,
    members,
  );
} on ChatError catch (e) {
}
```

#### 获取群组禁言列表

仅群主和群管理员可以调用 `ChatGroupManager#fetchMuteListFromServer` 方法从服务器获取当前群组的禁言列表。

示例代码如下：

```dart
try {
  await ChatClient.getInstance.groupManager.fetchMuteListFromServer(
    groupId,
    pageNum: pageNum,
    pageSize: pageSize,
  );
} on ChatError catch (e) {
}
```

### 开启和关闭全员禁言

#### 开启全员禁言

仅群主和群管理员可以调用 `ChatGroupManager#muteAllMembers` 方法开启全员禁言。群组全员禁言开启后，除了在白名单中的群成员，其他成员不能发言。

示例代码如下：

```dart
try {
  await ChatClient.getInstance.groupManager.muteAllMembers(
    groupId,
  );
} on ChatError catch (e) {
}
```

#### 关闭全员禁言

仅群主和群管理员可以调用 `ChatGroupManager#unMuteAllMembers` 方法取消全员禁言，示例代码如下：

```dart
try {
  await ChatClient.getInstance.groupManager.unMuteAllMembers(
    groupId,
  );
} on ChatError catch (e) {
}
```

### 管理群组白名单

#### 将成员加入群组白名单

仅群主和群管理员可以调用 `ChatGroupManager#addAllowList` 方法将指定群成员加入群白名单。白名单用户不受全员禁言的限制，但是如果白名单用户在群禁言列表中，则该用户不能发言。

示例代码如下：

```dart
try {
  await ChatClient.getInstance.groupManager.addAllowList(
    groupId,
    members,
  );
} on ChatError catch (e) {
}
```

#### 将成员移出群组白名单

仅群主和群管理员可以调用 `ChatGroupManager#removeAllowList` 方法将指定群成员移出群白名单。

示例代码如下：

```dart
try {
  await ChatClient.getInstance.groupManager.removeAllowList(
    groupId,
    members,
  );
} on ChatError catch (e) {
}
```

#### 检查自己是否在白名单中

所有群成员可以调用 `ChatGroupManager#isMemberInAllowListFromServer` 方法检查自己是否在群白名单中，示例代码如下：

```dart
try {
  bool check = await ChatClient.getInstance.groupManager.isMemberInAllowListFromServer(
    groupId,
  );
} on ChatError catch (e) {
}
```

#### 获取群组白名单

仅群主和群管理员可以调用 `ChatGroupManager#fetchAllowListFromServer` 方法从服务器获取当前群组的白名单。

示例代码如下：

```dart
try {
  List<String>? list =
      await ChatClient.getInstance.groupManager.fetchAllowListFromServer(
    groupId,
  );
} on ChatError catch (e) {
}
```

### 监听群组事件

有关详细信息，请参阅 [监听群组事件](./agora_chat_group_flutter#监听群组事件)。