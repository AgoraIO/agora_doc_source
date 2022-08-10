# 管理群组成员

群组是支持多人沟通的即时通讯系统。

本页介绍如何使用 Agora Chat SDK 管理应用中的群组成员。

## 技术原理

SDK 提供了 `Group`，`GroupManager` 和 `GroupChangeListener` 类用于群组管理，可以实现以下功能：

- 在群组中添加和删除用户
- 管理群主和管理员
- 管理群组的黑名单
- 管理群组的禁言列表
- 开启、关闭群组全员禁言
- 管理群组白名单

## 前提条件

开始前，请确保满足以下条件：

- 完成 SDK 初始化，详见 [Android 入门](https://docs.agora.io/en/agora-chat/agora_chat_get_started_android?platform=Android)。
- 了解不同定价方案支持的 Agora Chat API 的 [使用限制](https://docs.agora.io/en/agora-chat/agora_chat_limitation?platform=Android) 中所述。
- 如 [套餐包详情](https://docs.agora.io/en/agora-chat/agora_chat_plan?platform=Android) 中所述，了解不同套餐包支持的群组和群组成员的数量。

## 实现方法

本节介绍如何调用 Agora Chat SDK 提供的 API 实现上述功能。

### 管理群组成员

1. 将用户添加到群组。
   无论群组是公共的还是私人的，群组所有者和群组管理员都可以将用户添加到群组。对于私人群组，如果聊天群组的类型设置为 `GroupStylePrivateMemberCanInvite`，群组成员可以邀请用户加入聊天群组。
2. 邀请用户加入群组。
   邀请用户加入群组后，根据用户的设置，实现逻辑会有所不同：

   - 如果用户需要群组邀请确认，邀请者会收到 `onInvitationReceived` 回调。一旦用户接受请求并加入群组，邀请者会收到`onInvitationAccepted`回调，所有群组成员都会收到 `onMemberJoined` 回调。否则，邀请者会收到 `onInvitationDeclined` 回调。
   - 如果用户不需要组邀请确认，邀请者会收到 `onAutoAcceptInvitationFromGroup` 回调。在这种情况下，用户会自动接受群组邀请并收到`onInvitationAccepted`回调。所有组成员都会收到 `onMemberJoined` 回调。
3. 从群组中删除群组成员。
   群组所有者和群组管理员可以从群组中删除群组成员，而群组成员没有此权限。删除组成员后，所有其他组成员都会收到`onMemberExited`回调。

请参考以下示例代码来添加和删除用户：

```java
// 群主或群组管理员添加群组成员
ChatClient.getInstance().groupManager().addUsersToGroup(groupId, newmembers);

// 私有群成员邀请用户入群
ChatClient.getInstance().groupManager().inviteUser(groupId, newmembers, null);
```

### 群组踢人

仅群主和群管理员可以调用 `removeUserFromGroup` 方法将指定成员移出群组。被踢出群组后，被踢群成员将会收到群组事件回调 `GroupChangeListener#onUserRemoved`，其他成员将会收到回调 `GroupChangeListener#onMemberExited`。被移出群组后，该用户还可以再次加入群组。

示例代码如下：

```java
// 异步方法。
ChatClient.getInstance().groupManager().removeUserFromGroup(groupId, username);
```

### 管理群主和群管理员

#### 变更群主

仅群主可以调用 `changeOwner` 方法将权限移交给群组中指定成员。成功移交后，原群主变为普通成员，其他群组成员收到 `onOwnerChanged` 回调。

```java
ChatClient.getInstance().groupManager().changeOwner(groupId, newOwner);
```

#### 添加群组管理员

仅群主可以调用 `addGroupAdmin` 添加管理员。添加到群组管理员列表后，新添加的管理员和其他群组管理员都会收到 `onAdminAdded` 回调。

```java
ChatClient.getInstance().groupManager().addGroupAdmin(groupId, admin);
```

#### 移除群组管理员权限

仅群主可以调用 `addGroupAdmin` 方法添加群管理员。成功添加后，新管理员及其他管理员收到 `onAdminRemoved` 回调。

参考以下示例代码管理群组所有权和管理员：

```java
// 仅群主可以调用 `removeGroupAdmin` 方法移除群管理员。成功移除后，被移除的管理员及其他管理员收到 `GroupChangeListener#onAdminRemoved` 回调。
ChatClient.getInstance().groupManager().removeGroupAdmin(groupId, admin);
```

### 管理群组黑名单列表

群组所有者和群组管理员可以将指定成员添加或删除到群组阻止列表。将群组成员添加到阻止列表后，该成员将无法发送或接收群组消息，也无法再次加入该群组。

参考以下示例代码管理群组黑名单列表：

```java
// 仅群主和群管理员可以调用 `BlockGroupMembers` 方法将指定成员添加至黑名单。被加入黑名单后，该成员收到 `GroupChangeListener#OnUserRemovedFromGroup` 回调，其他群成员收到 `GroupChangeListener#OnMemberExitedFromGroup` 回调。被加入黑名单后，该成员无法再收发群组消息并被移出群组，黑名单中的成员如想再次加入群组，群主或群管理员必须先将其移除黑名单。
ChatClient.getInstance().groupManager().blockUser(groupId, username);

// 仅群主和群管理员可以调用 `unblockUser` 方法将成员移出群组黑名单。指定用户被群主或者群管理员移出群黑名单后，可以再次申请加入群组。
ChatClient.getInstance().groupManager().unblockUser(groupId, username);

// 仅群主和群管理员可以调用 `getBlockedUsers` 方法获取当前群组的黑名单。默认最多取 200 个。
ChatClient.getInstance().groupManager().getBlockedUsers(groupId);
```

### 管理群组禁言列表

群组所有者和群组管理员可以将指定成员添加或删除到群组静音列表。将群组成员添加到静音列表后，该成员将无法再发送群组消息，即使添加到群组允许列表后也是如此。

参考以下示例代码管理群组静音列表：

```java
// 仅群主和群管理员可以调用 `muteGroupMembers` 方法将指定成员添加至群组禁言列表。群成员被群主或者群管理员加入禁言列表中后，被禁言成员和其他未操作的管理员或者群主将会收到群组事件回调 `GroupChangeListener#onMuteListAdded`。群成员被加入群禁言列表后，将不能够发言，即使其被加入群白名单也不能发言。
ChatClient.getInstance().groupManager().muteGroupMembers(groupId, muteMembers, duration);

// 仅群主和群管理员可以调用 `UnMuteGroupMembers` 方法将指定成员移出群组禁言列表。群成员被群主或者群管理员移出禁言列表后，被移出的群成员及其他未操作的管理员或者群主将会收到群组事件回调 `GroupChangeListener#onMuteListRemoved`。
ChatClient.getInstance().groupManager().unMuteGroupMembers(String groupId, List<String> members);

// 仅群主和群管理员可以调用 `fetchGroupMuteList` 方法从服务器获取当前群组的禁言列表。
ChatClient.getInstance().groupManager().fetchGroupMuteList(String groupId, int pageNum, int pageSize);
```

### 开启和关闭全员禁言

只有群主和群组管理员可以将所有群组成员全员禁言或关闭全员禁言。将所有成员禁言后，只有群组允许列表中的成员才能在群组中发送消息。

参考以下示例代码对所有群组成员进行禁言和取消禁言：

```java
// 仅群主和群管理员可以调用 `muteAllMembers` 方法开启全员禁言。开启群组全员禁言后，群成员将会收到群组事件回调 `GroupChangeListener#onAllMemberMuteStateChanged`。
public void muteAllMembers(final String groupId, final ValueCallBack<Group> callBack);

// 仅群主和群管理员可以调用 `unmuteAllMembers` 方法取消全员禁言。关闭群组全员禁言后，群成员将会收到群组事件回调 `GroupChangeListener#onAllMemberMuteStateChanged`。
public void unmuteAllMembers(final String groupId, final ValueCallBack<Group> callBack);
```

### 管理群组白名单

即使群组所有者或管理员已将所有群组成员静音，群组允许列表中的成员也可以发送群组消息。但是，如果某个成员已经在群组静音列表中，则将该成员添加到允许列表中不会生效。

参考以下示例代码管理群组白名单列表：

```java
// 仅群主和群管理员可以调用 `addToGroupWhiteList` 方法将指定群成员加入群白名单。白名单用户不受全员禁言的限制，但是如果白名单用户在群禁言列表中，则该用户不能发言。群成员被群主或者群管理员添加到群白名单后，该群成员及其他未操作的群管理员和群主将会收到群组事件回调 `GroupChangeListener#onWhiteListAdded`。
public void addToGroupWhiteList(final String groupId, final List<String> members, final CallBack callBack);

// 仅群主和群管理员可以调用 `removeFromGroupWhiteList` 方法将指定群成员移出群白名单。群成员被群主或者群管理员移除群白名单后，该群成员及其他未操作的群管理员和群主将会收到群组事件回调 `GroupChangeListener#onWhiteListRemoved`。
public void removeFromGroupWhiteList(final String groupId, final List<String> members, final CallBack callBack);

// 所有群成员可以调用 `checkIfInGroupWhiteList` 方法检查自己是否在群白名单中
public void checkIfInGroupWhiteList(final String groupId, ValueCallBack<Boolean> callBack);

// 仅群主和群管理员可以调用 `fetchGroupWhiteList` 方法从服务器获取当前群组的白名单。
public void fetchGroupWhiteList(final String groupId, final ValueCallBack<List<String>> callBack);
```

### 监听群组事件

有关详细信息，请参阅 [监听群组事件](https://docs.agora.io/en/agora-chat/agora_chat_group_android?platform=Android#listen-for-chat-group-events)。