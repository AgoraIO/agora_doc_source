群组是支持多人沟通的即时通讯系统。本页介绍如何使用即时通讯 IM SDK 管理应用中的群组成员。

## 技术原理

即时通讯 IM SDK 提供 `Group`、`GroupManager` 和 `GroupChangeListener` 类用于群组管理，可实现以下功能：

- 群组加人和踢人
- 管理群主和管理员
- 管理群组白名单
- 管理群组黑名单
- 管理群组禁言

## 前提条件

开始前，请确保满足以下条件：

- 完成 SDK 初始化，详见 [Android 快速开始](./agora_chat_get_started_android)。
- 了解不同定价方案支持的即时通讯 IM API 的 [使用限制](./agora_chat_limitation)。
- 了解不同套餐包支持的群组和群组成员的数量，详见 [套餐包详情](./agora_chat_plan)。

## 实现方法

本节介绍如何调用即时通讯 IM SDK 提供的 API 实现上述功能。

### 群组加人

群组加人的逻辑取决于创建群组时群组类型 (`GroupStyle`) 和入群邀请是否需要对方同意 (`inviteNeedConfirm`)的设置。详见[创建群组](./agora_chat_group_android#创建群组)。

```java
// 群主或群组管理员添加群组成员
ChatClient.getInstance().groupManager().addUsersToGroup(groupId, newmembers);

// 私有群成员邀请用户入群
ChatClient.getInstance().groupManager().inviteUser(groupId, newmembers, null);
```

### 群组踢人

仅群主和群管理员可以调用 `removeUserFromGroup` 方法将指定成员移出群组。被踢群成员将会收到群组事件回调 `GroupChangeListener#onUserRemoved`，其他成员将会收到回调 `GroupChangeListener#onMemberExited`。被移出群组后，该用户还可以再次加入群组。

```java
// 异步方法。
ChatClient.getInstance().groupManager().removeUserFromGroup(groupId, username);
```

### 管理群主和群管理员

#### 变更群主

仅群主可以调用 `changeOwner` 方法将群组所有权移交给群组中指定成员。成功移交后，原群主成为普通成员，其他群组成员收到 `GroupChangeListener#onOwnerChanged` 回调。

```java
ChatClient.getInstance().groupManager().changeOwner(groupId, newOwner);
```

#### 添加群组管理员

仅群主可以调用 `addGroupAdmin` 添加管理员。添加至群组管理员列表后，新管理员和其他群组管理员均会收到 `GroupChangeListener#onAdminAdded` 回调。

```java
ChatClient.getInstance().groupManager().addGroupAdmin(groupId, admin);
```

#### 移除群组管理员权限

仅群主可以调用 `removeGroupAdmin` 方法将群管理员移除群管理员列表。管理权限被移除后，群管理员成为普通群成员。成功移除后，被移除的管理员及其他管理员收到 `GroupChangeListener#onAdminRemoved` 回调。

```java
ChatClient.getInstance().groupManager().removeGroupAdmin(groupId, admin);
```

### 管理群组白名单

#### 将成员加入群组白名单

仅群主和群管理员可以调用 `addToGroupWhiteList` 方法将指定群成员加入群白名单。群成员被添加至群白名单后，该群成员及其他未操作的群管理员和群主将会收到群组事件回调 `GroupChangeListener#onWhiteListAdded`。

即使开启了群组全员禁言，群组白名单中的成员仍可以发送群组消息。不过，禁言列表上的用户即使加入了群白名单仍无法在群组中发送消息。

```java
public void addToGroupWhiteList(final String groupId, final List<String> members, final CallBack callBack);
```

#### 将成员移出群组白名单

仅群主和群管理员可以调用 `removeFromGroupWhiteList` 方法将指定群成员移出群白名单。被移出白名单的成员及其他未操作的群管理员和群主将会收到群组事件回调 `GroupChangeListener#onWhiteListRemoved`。

```java
public void removeFromGroupWhiteList(final String groupId, final List<String> members, final CallBack callBack);
```

#### 检查自己是否在白名单中

所有群成员均可调用 `checkIfInGroupWhiteList` 方法检查自己是否在群白名单中。

```java
public void checkIfInGroupWhiteList(final String groupId, ValueCallBack<Boolean> callBack);
```

#### 获取群组白名单

仅群主和群管理员可以调用 `fetchGroupWhiteList` 方法从服务器获取当前群组的白名单。

```java
public void fetchGroupWhiteList(final String groupId, final ValueCallBack<List<String>> callBack);
```

### 管理群组黑名单列表

#### 将成员加入群组黑名单

仅群主和群管理员可以调用 `blockUser` 方法将指定成员添加至群组黑名单。被加入黑名单后，该成员收到 `GroupChangeListener#OnUserRemovedFromGroup` 回调，其他群成员收到 `GroupChangeListener#OnMemberExitedFromGroup` 回调。黑名单中的成员会被移出群组，无法再收发群消息，只有先被移出黑名单才能重新加入群组。

```java
ChatClient.getInstance().groupManager().blockUser(groupId, username);
```

#### 将成员移出群组黑名单

仅群主和群管理员可以调用 `unblockUser` 方法将成员移出群组黑名单。指定用户被移出群黑名单后，可以重新加入群组。

```java
ChatClient.getInstance().groupManager().unblockUser(groupId, username);
```

#### 获取群组的黑名单用户列表

仅群主和群管理员可以调用 `getBlockedUsers` 方法获取当前群组的黑名单。默认最多可获取 200 个黑名单上的用户。

```java
ChatClient.getInstance().groupManager().getBlockedUsers(groupId);
```

### 管理群组禁言

群主和群管理员可以将指定群成员添加或移出禁言列表，也可开启关闭全员禁言。全员禁言和单独的成员禁言不冲突，开启和关闭全员禁言，并不影响禁言列表。

#### 将成员加入群组禁言列表

仅群主和群管理员可以调用 `muteGroupMembers` 方法将指定成员添加至群组禁言列表。群成员被群主或者群管理员加入禁言列表后，被禁言成员、群组管理员和群主（除操作者外）会收到群组事件回调 `GroupChangeListener#onMuteListAdded`。

群成员被加入群禁言列表后，将无法发言，即使加入群白名单也不能发言。

```java
ChatClient.getInstance().groupManager().muteGroupMembers(groupId, muteMembers, duration);
```

#### 将成员移出群组禁言列表

仅群主和群管理员可以调用 `UnMuteGroupMembers` 方法将指定成员移出群组禁言列表。群成员被移出禁言列表后，被移出的成员、群组管理员和群主（除操作者外）将会收到 `GroupChangeListener#onMuteListRemoved` 回调。

群成员被移出禁言列表后可以在群组中正常发送消息。

```java
ChatClient.getInstance().groupManager().unMuteGroupMembers(String groupId, List<String> members);
```

#### 获取群组禁言列表

仅群主和群管理员可以调用 `fetchGroupMuteList` 方法从服务器获取当前群组的禁言列表。

```java
ChatClient.getInstance().groupManager().fetchGroupMuteList(String groupId, int pageNum, int pageSize);
```

#### 开启群组全员禁言

仅群主和群管理员可以调用 `muteAllMembers` 方法开启全员禁言。开启群组全员禁言后，群成员将会收到群组事件回调 `GroupChangeListener#onAllMemberMuteStateChanged`。

群组全员禁言后，只有群白名单中的成员才能在群组中发送消息。

```java
public void muteAllMembers(final String groupId, final ValueCallBack<Group> callBack);
```

#### 关闭群组全员禁言

仅群主和群管理员可以调用 `unmuteAllMembers` 方法关闭全员禁言。关闭群组全员禁言后，群成员将会收到群组事件回调 `GroupChangeListener#onAllMemberMuteStateChanged`，可在群组中正常发送消息。

```java
public void unmuteAllMembers(final String groupId, final ValueCallBack<Group> callBack);
```

### 监听群组事件

详见 [监听群组事件](./agora_chat_group_android#监听群组事件)。