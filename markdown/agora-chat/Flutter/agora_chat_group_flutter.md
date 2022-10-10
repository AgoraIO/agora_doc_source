群组是支持多人沟通的即时通讯系统，本文介绍如何使用即时通讯 IM SDK 在实时互动 app 中创建和管理群组，并实现群组相关功能。

## 技术原理

即时通讯 IM Flutter SDK 提供了 `ChatGroup`、`ChatGroupManager` 和 `ChatGroupEventHandler` 类用于群组管理，可以实现以下功能：

- 创建、解散群组
- 加入、退出群组
- 获取群组详情
- 获取群成员列表
- 获取群组列表
- 屏蔽、解除屏蔽群消息
- 监听群组事件

## 前提条件

开始前，请确保满足以下条件：

- 完成 SDK 初始化，详见 [快速开始](./agora_chat_get_started_flutter)。
- 了解 [使用限制](./agora_chat_limitation)。
- 了解群组和群成员的数量限制，详见 [套餐包详情](./agora_chat_plan)。

## 实现方法

本节介绍如何使用即时通讯 IM Flutter SDK 提供的 API 实现上述功能。

### 创建群组

在创建群组前，你需要设置群组类型 `ChatGroupStyle` 和进群邀请是否需要对方同意 `inviteNeedConfirm`。

1. 私有群不可被搜索到，公开群可以通过 ID 搜索到。目前支持四种群组类型 (`ChatGroupStyle`)：

- `PrivateOnlyOwnerInvite`: 私有群，只有群主和管理员可以邀请人进群；
- `PrivateMemberCanInvite`: 私有群，所有群成员均可以邀请人进群；
- `PublicJoinNeedApproval`: 公开群，加入此群除了群主和管理员邀请，只能通过申请加入此群；
- `PublicOpenJoin`: 公开群，任何人都可以进群，无需群主和群管理同意。

2. 进群邀请是否需要对方同意 (`inviteNeedConfirm`) 的具体设置如下：
    - 进群邀请需要用户确认 (`ChatGroupOptions#inviteNeedConfirm` 设置为 `true`）。创建群组并发送群组邀请后，根据受邀用户的（`autoAcceptGroupInvitation` 设置）而有所不同：
       - 用户设置自动接受群组邀请（`autoAcceptGroupInvitation` 设置为 `true`）。受邀用户自动进群并收到`ChatGroupEventHandler#onAutoAcceptInvitationFromGroup` 回调，邀请人收到 `ChatGroupEventHandler#onInvitationAcceptedFromGroup` 和 `ChatGroupEventHandler#onMemberJoinedFromGroup` 事件，其他群成员收到 `ChatGroupEventHandler#onMemberJoinedFromGroup` 事件。
       - 用户设置手动确认群组邀请（`autoAcceptGroupInvitation` 设置为 `false`）。受邀用户收到 `ChatGroupEventHandler#onInvitationReceivedFromGroup` 事件并选择是否加入群组：
          - 用户同意入群邀请后，邀请人收到 `ChatGroupEventHandler#onInvitationAcceptedFromGroup` 和 `ChatGroupEventHandler#onMemberJoinedFromGroup` 事件，其他群成员收到 `ChatGroupEventHandler#onMemberJoinedFromGroup` 事件；
          - 用户拒绝入群邀请后，邀请人收到 `ChatGroupEventHandler#onInvitationDeclinedFromGroup` 事件。

![img](https://web-cdn.agora.io/docs-files/1653385689954)

    - 进群邀请无需用户确认（`ChatGroupOptions#inviteNeedConfirm` 设置为 `false`）。创建群组并发送入组邀请后，无论 `autoAcceptGroupInvitation` 设置如何，都会将受邀者添加到群组中。受邀用户收到 `ChatGroupEventHandler#onAutoAcceptInvitationFromGroup` 事件，邀请人收到 `ChatGroupEventHandler#onInvitationAcceptedFromGroup` 和 `ChatGroupEventHandler#onMemberJoinedFromGroup` 事件，其他群成员收到 `ChatGroupEventHandler#onMemberJoinedFromGroup` 事件。

用户可以调用 `createGroup` 创建群组，并通过 `ChatGroupOptions` 指定设置群组名称、描述、最大成员数、建群原因等群组属性。

示例代码如下：

```dart
ChatGroupOptions groupOptions = ChatGroupOptions(
  // 设置群组类型
  style: ChatGroupStyle.PrivateMemberCanInvite,
  inviteNeedConfirm: true,
);
// 设置群组名称，不超过 128 字节
String groupName = "newGroup";
// 设置群组描述，不超过 512 字节
String groupDesc = "group desc";
try {
  await ChatClient.getInstance.groupManager.createGroup(
    groupName: groupName,
    desc: groupDesc,
    options: groupOptions,
  );
} on ChatError catch (e) {
}
```

### 解散群组

仅群主可以调用 `DestroyGroup` 方法解散群组。群组解散时，其他群组成员收到 `OnDestroyedFromGroup` 事件并被踢出群组。

解散群组后，将删除本地数据库及内存中的群相关信息及群会话，谨慎操作。

示例代码如下：

```dart
try {
  await ChatClient.getInstance.groupManager.destroyGroup(groupId);
} on ChatError catch (e) {
}
```

### 用户申请入群

根据 [创建群组](#创建群组) 时的群组类型 (`GroupStyle`) 设置，加入群组的处理逻辑差别如下：

- 当群组类型为 `PublicOpenJoin` 时，用户可以直接加入群组，无需群主或群管理员同意，加入群组后，其他群成员收到 `ChatGroupEventHandler#onMemberJoinedFromGroup` 事件；
- 当群组类型为 `PublicJoinNeedApproval` 时，用户可以申请进群，群主或群管理员收到 `ChatGroupEventHandler#onRequestToJoinReceivedFromGroup` 事件，并选择同意或拒绝入群申请：

    - 群主或群管理员同意入群申请，申请人收到 `ChatGroupEventHandler#onRequestToJoinAcceptedFromGroup` 事件，其他群组成员收到 `ChatGroupEventHandler#onMemberJoinedFromGroup` 事件。
    - 群主或群管理员拒绝入群申请，申请人收到 `ChatGroupEventHandler#onRequestToJoinDeclinedFromGroup` 事件。

用户只能申请加入公开群组，私有群组不支持用户申请入群。

用户申请加入群组的步骤如下：

1. 调用 `fetchPublicGroupsFromServer` 方法从服务器获取公开群列表，查询到想要加入的群组 ID。
2. 调用 `joinPublicGroup` 方法传入群组 ID，申请加入对应群组。

示例代码如下：

```dart
// 获取公开群组列表
try {
  ChatCursorResult<ChatGroupInfo> result =
      await ChatClient.getInstance.groupManager.fetchPublicGroupsFromServer();
} on ChatError catch (e) {
}

// 申请加入群组
try {
  await ChatClient.getInstance.groupManager.joinPublicGroup(groupId);
} on ChatError catch (e) {
}
```

### 退出群组

群成员可以调用 `LeaveGroup` 方法退出群组，其他成员收到 `ChatGroupEventHandler#onMemberExitedFromGroup` 事件。退出群组后，该用户将不再收到群消息。群主不能调用该接口退出群组，只能调用 [`DestroyGroup`](#解散群组) 解散群组。

示例代码如下：

```dart
try {
  await ChatClient.getInstance.groupManager.leaveGroup(groupId);
} on ChatError catch (e) {
}
```

### 获取群组详情

群成员可以调用 `ChatGroupManager#getGroupWithId` 方法从内存获取群组详情。返回结果包括：群组 ID、群组名称、群组描述、群组基本属性、群主、群组管理员列表，默认不包含群成员。

群成员也可以调用 `ChatGroupManager#fetchGroupInfoFromServer` 方法从服务器获取群组详情。返回结果包括：群组 ID、群组名称、群组描述、群主、群组管理员列表以及群成员列表。

示例代码如下：

```dart
// 从本地获取群组
try {
  ChatGroup? group = await ChatClient.getInstance.groupManager.getGroupWithId(groupId);
} on ChatError catch (e) {
}

// 从服务器获取群组详情
try {
  ChatGroup group = await ChatClient.getInstance.groupManager.fetchGroupInfoFromServer(groupId);
} on ChatError catch (e) {
}
```

### 获取群成员列表

群成员可以调用 `ChatGroupManager#fetchMemberListFromServer` 方法从服务器分页获取群成员列表。

示例代码如下：

```dart
// 群组 ID
try {
  ChatCursorResult<String> result =
      await ChatClient.getInstance.groupManager.fetchMemberListFromServer(
    groupId,
  );
} on ChatError catch (e) {
}
```

### 获取群组列表

用户可以调用 `ChatGroupManager#fetchJoinedGroupsFromServer` 方法从服务器获取自己加入和创建的群组列表。示例代码如下：

```dart
try {
  List<ChatGroup> list =
      await ChatClient.getInstance.groupManager.fetchJoinedGroupsFromServer();
} on ChatError catch (e) {
}
```

用户可以调用 `ChatGroupManager#getJoinedGroups` 方法加载本地群组列表。为了保证数据的正确性，需要先从服务器获取自己加入和创建的群组列表。示例代码如下：

```dart
try {
  List<ChatGroup> list =
      await ChatClient.getInstance.groupManager.getJoinedGroups();
} on ChatError catch (e) {
}
```

用户还可以调用 `ChatGroupManager#fetchPublicGroupsFromServer` 方法从服务器分页获取公开群组列表。示例代码如下：

```dart
try {
  ChatCursorResult<ChatGroupInfo> result =
      await ChatClient.getInstance.groupManager.fetchPublicGroupsFromServer(
    // The maximum number of chat groups to retrieve with pagination.
    pageSize: pageSize,
    // The page number from which to start getting data.
    cursor: cursor,
  );
} on ChatError catch (e) {
}
```

### 屏蔽和解除屏蔽群消息

#### 屏蔽群消息

群成员可以调用 `ChatGroupManager#blockGroup` 方法屏蔽群消息。屏蔽群消息后，该成员不再从指定群组接收群消息，群主和群管理员不能进行此操作。示例代码如下：

```dart
try {
  await ChatClient.getInstance.groupManager.blockGroup(groupId);
} on ChatError catch (e) {
}
```

#### 解除屏蔽群消息

群成员可以调用 `ChatGroupManager#unblockGroup` 方法解除屏蔽群消息。示例代码如下：

```dart
try {
  await ChatClient.getInstance.groupManager.unblockGroup(groupId);
} on ChatError catch (e) {
}
```

#### 检查自己是否已经屏蔽群消息

群成员可以调用 `ChatGroupManager#fetchGroupInfoFromServer` 方法并通过 `ChatGroup#messageBlocked` 字段检查自己是否屏蔽了群消息。

示例代码如下：

```dart
// 获取群组详情
try {
  ChatGroup group = await ChatClient.getInstance.groupManager
      .fetchGroupInfoFromServer(groupId);
  // 检查用户是否屏蔽了该群的群消息
  if (group.messageBlocked == true) {
  }
} on ChatError catch (e) {
}
```

### 监听群组事件

`ChatGroupEventHandler` 类中提供群组事件的监听接口。开发者可以通过设置此监听，获取群组中的事件，并做出相应处理。如果不再使用该监听，需要移除，防止出现内存泄漏。

示例代码如下：

```dart
    // 注册群组监听
    ChatClient.getInstance.groupManager.addEventHandler(
      "UNIQUE_HANDLER_ID",
      ChatGroupEventHandler(),
    );

    // 移除群组监听
    ChatClient.getInstance.groupManager.removeEventHandler("UNIQUE_HANDLER_ID");
```