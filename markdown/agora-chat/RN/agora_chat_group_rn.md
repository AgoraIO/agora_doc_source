群组是支持多人沟通的即时通讯系统，本文介绍如何使用即时通讯 IM SDK 在实时互动 app 中创建和管理群组，并实现群组相关功能。

## 技术原理

即时通讯 IM React Native SDK 提供 `ChatGroupManager` 类和 `ChatGroup` 类，用于管理群组，以及事件监听回调 `ChatGroupEventListener`。其中包含如下主要方法：

- 创建群组
- 解散群组
- 获取群组详情
- 获取群组列表
- 屏蔽和解除屏蔽群消息
- 监听群组事件

## 前提条件

开始前，请确保满足以下条件：

- 完成 SDK 初始化，并连接到服务器，详见 [RN 快速开始](./agora_chat_get_started_rn)。
- 了解即时通讯 IM 的 [使用限制](./agora_chat_limitation)。
- 了解群组和群成员的数量限制，详见 [套餐包详情](./agora_chat_plan)。

## 实现方法

本节介绍如何使用即时通讯 IM SDK 提供的 API 实现上述功能。

### 创建群组

在创建群组前，你需要设置群组的类型（`ChatGroupStyle`）和邀请进群是否需要对方同意（`ChatGroupOptions#inviteNeedConfirm`）。其中：

- 群组类型（`ChatGroupStyle`）可以设置为如下值：
    - `PrivateOnlyOwnerInvite` —— 私有群，只有群主和管理员可以邀请人进群；
    - `PrivateMemberCanInvite` —— 私有群，所有群成员均可以邀请人进群；
    - `PublicJoinNeedApproval` —— 公开群，加入此群除了群主和管理员邀请，只能通过申请加入此群；
    - `PublicOpenJoin` —— 公开群，任何人都可以进群，无需群主和群管理同意。
- 邀请用户进群（`ChatGroupOptions#inviteNeedConfirm`）

    公开群只支持群主和管理员邀请用户入群。对于私有群，除了群主和群管理员，群成员是否也能邀请其他用户进群取决于群样式（EMGroupStyle）的设置：
    - `EMGroupStyle` 为 `EMGroupStylePrivateOnlyOwnerInvite`：只有群主和管理员可以邀请人入群；
    - `EMGroupStyle` 为 `EMGroupStylePrivateMemberCanInvite`，普通群成员也能邀请人进群。

    邀请入群是否需受邀用户确认取决于群组选项 `ChatGroupOptions#inviteNeedConfirm` 和受邀用户的参数 `inviteNeedConfirm` 的设置，前者参数的优先级高于后者，即 `ChatGroupOptions#inviteNeedConfirm` 若设置为 `false`，不论 `inviteNeedConfirm` 设置为何值，受邀用户无需确认直接进群。
    1. 受邀用户无需确认，直接进群。

    以下两种设置的情况下，用户直接进群：

    - 若 `ChatGroupOptions#inviteNeedConfirm` 设置为 `false`，不论 `autoAcceptGroupInvitation` 设置为 `false` 或 `true`，受邀用户均无需确认，直接进群。
    - 若 `ChatGroupOptions#inviteNeedConfirm` 和 `autoAcceptGroupInvitation` 均设置为 `true`，用户自动接受群组邀请，直接进群。

    受邀用户直接进群，会收到如下回调：

    - 新成员会收到 `ChatGroupEventListener#onAutoAcceptInvitation` 回调；
    - 邀请人会收到 `ChatGroupEventListener#onInvitationAccepted` 和 `ChatGroupEventListener#onMemberJoined` 回调;
    - 其他群成员会收到 `ChatGroupEventListener#onMemberJoined` 回调。

    2. 受邀用户需要确认才能进群。

    只有 `ChatGroupOptions#inviteNeedConfirm` 设置为 `true` 和 `autoAcceptGroupInvitation` 设置为 `false` 时，受邀用户需要确认才能进群。这种情况下，受邀用户收到 `ChatGroupEventListener#onInvitationReceived` 回调，并选择同意或拒绝进群邀请：

    - 用户同意入群邀请后，邀请人收到 `ChatGroupEventListener#onInvitationAccepted` 回调和 `ChatGroupEventListener#onMemberJoined` 回调，其他群成员收到 `ChatGroupEventListener#onMemberJoined` 回调；
    - 用户拒绝入群邀请后，邀请人收到 `ChatGroupEventListener#onInvitationDeclined` 回调。

你可以调用 `createGroup` 方法创建群组，并通过 `ChatGroupOptions` 参数设置群组名称、群组描述、群组成员和建群原因。

示例代码如下：

```typescript
// 群组选项。核心选项为 `style`，用于设置群组类型。详见 `ChatGroupStyle`。
option.style = PrivateOnlyOwnerInvite;
// 群组的名称，不能超过 128 个字符
const groupName = "study";
// 群组描述，不能超过 512 个字符
const desc = "this is study group";
// 成员列表
const allMembers = ["Tom", "Jason"];
// 执行操作
ChatClient.getInstance()
  .groupManager.createGroup(option, groupName, desc, allMembers, reason)
  .then(() => {
    console.log("create group success.");
  })
  .catch((reason) => {
    console.log("create group fail.", reason);
  });
```

### 解散群组

仅群主可以调用 `destroyGroup` 方法解散群组。群组解散时，其他群组成员收到 `ChatGroupEventListener#onGroupDestroyed` 回调并被踢出群组。

:::notice
解散群组后，将删除本地数据库及内存中的群相关信息及群会话，谨慎操作。
:::

示例代码如下：

```typescript
// 将要解散的群组 ID
const groupId = "100";
ChatClient.getInstance()
  .groupManager.destroyGroup(groupId)
  .then(() => {
    console.log("destroy group success.");
  })
  .catch((reason) => {
    console.log("destroy group fail.", reason);
  });
```

### 退出群组

群成员可调用 `leaveGroup` 方法退出群组，其他成员收到 `ChatGroupEventListener#onMemberExited` 回调。退出群组后，该成员将不再收到群消息。
群主不能调用该接口退出群组，只能调用 `destroyGroup` 方法解散群组。

示例代码如下：

```typescript
ChatClient.getInstance()
  .groupManager.leaveGroup(groupId)
  .then(() => {
    console.log("leave group success.");
  })
  .catch((reason) => {
    console.log("leave group fail.", reason);
  });
```

### 获取群组详情

获取单个群组详情有以下两种方法：

- `getGroupWithId`：从内存获取群组详情。返回结果包括：群组 ID、群组名称、群组描述、群主、公告信息、群成员列表数量、消息屏蔽、是否全体禁言、权限类型等，默认不包含群成员。
- `fetchGroupInfoFromServer`：从服务器获取群组详情。返回结果包括：群组 ID、群组名称、群组描述、群组基本属性、群主、群组管理员列表，不包括群成员列表。

```typescript
// 从本地获取群组详情。
ChatClient.getInstance()
  .groupManager.getGroupWithId(groupId)
  .then((groupInfo) => {
    console.log("get group info success: ", groupInfo);
  })
  .catch((reason) => {
    console.log("get group info fail.", reason);
  });
```

```typescript
// 从服务器获取群组详情。
ChatClient.getInstance()
  .groupManager.fetchGroupInfoFromServer(groupId)
  .then((groupInfo) => {
    console.log("get group info success: ", groupInfo);
  })
  .catch((reason) => {
    console.log("get group info fail.", reason);
  });
```

### 获取群组列表

用户可以调用 `fetchJoinedGroupsFromServer` 方法从服务器获取自己加入和创建的群组列表。示例代码如下：

```typescript
// 分页获取群组列表
// 每页期望返回的群组数量
const pageSize = 10;
// 当前页码
const pageNum = 1;
ChatClient.getInstance()
  .groupManager.fetchJoinedGroupsFromServer(pageSize, pageNum)
  .then((groups) => {
    console.log("get group list success: ", groups);
  })
  .catch((reason) => {
    console.log("get group list fail.", groups);
  });
```

- 用户可以调用 `getJoinedGroups` 方法加载本地群组列表。为了保证数据的正确性，需要先从服务器获取自己加入和创建的群组列表。示例代码如下：

```typescript
ChatClient.getInstance()
  .groupManager.getJoinedGroups()
  .then((groups) => {
    console.log("get group list success: ", groups);
  })
  .catch((reason) => {
    console.log("get group list fail.", groups);
  });
```

- 用户还可以分页获取公开群列表：

```typescript
// 获取的群组列表来自服务器，但是不包括成员列表
ChatClient.getInstance()
  .groupManager.fetchPublicGroupsFromServer(pageSize, cursor)
  .then((groups) => {
    console.log("get group list success: ", groups);
  })
  .catch((reason) => {
    console.log("get group list fail.", groups);
  });
```

### 屏蔽和解除屏蔽群消息

群成员可以屏蔽群消息和解除屏蔽群消息。

#### 屏蔽群消息

群成员可以调用 `blockGroup` 方法屏蔽群消息。屏蔽群消息后，该成员不再从指定群组接收消息，群主和群管理员不能进行此操作。示例代码如下：

```typescript
ChatClient.getInstance()
  .groupManager.blockGroup(groupId)
  .then(() => {
    console.log("block group success. ");
  })
  .catch((reason) => {
    console.log("block group fail.", groups);
  });
```

#### 解除屏蔽群消息

群成员可以调用 `unblockGroup` 方法解除屏蔽群消息。示例代码如下：

```typescript
ChatClient.getInstance()
  .groupManager.unblockGroup(groupId)
  .then(() => {
    console.log("unblock group success. ");
  })
  .catch((reason) => {
    console.log("unblock group fail.", groups);
  });
```

#### 解除屏蔽或者屏蔽的通知

当发生了屏蔽或者解除屏蔽全体成员的时候会收到通知 `ChatGroupEventListener#onAllGroupMemberMuteStateChanged`。

### 监听群组事件

`ChatGroupEventListener` 中提供群组事件的监听接口。开发者可以通过设置此监听，获取群组中的事件，并做出相应处理。如果不再使用该监听，需要移除，防止出现内存泄漏。

示例代码如下：

```typescript
// 创建一个群组事件监听
const groupListener: ChatGroupEventListener = new (class
  implements ChatGroupEventListener
{
  that: any;
  constructor(parent: any) {
    this.that = parent;
  }
  // 用户收到进群邀请，受邀人收到该事件回调
  onInvitationReceived(params: {
    groupId: string;
    inviter: string;
    groupName?: string | undefined;
    reason?: string | undefined;
  }): void {
    console.log(
      `onInvitationReceived:`,
      params.groupId,
      params.inviter,
      params.groupName,
      params.reason
    );
  }
  // 群主或群管理员收到入群申请的事件回调
  onRequestToJoinReceived(params: {
    groupId: string;
    applicant: string;
    groupName?: string | undefined;
    reason?: string | undefined;
  }): void {
    console.log(
      `onRequestToJoinReceived:`,
      params.groupId,
      params.applicant,
      params.groupName,
      params.reason
    );
  }
  // 群主或群管理员同意用户的进群申请，申请人收到该事件回调
  onRequestToJoinAccepted(params: {
    groupId: string;
    accepter: string;
    groupName?: string | undefined;
  }): void {
    console.log(
      `onRequestToJoinAccepted:`,
      params.groupId,
      params.accepter,
      params.groupName
    );
  }
  // 群主或群管理员拒绝用户的进群申请，申请人收到该事件回调
  onRequestToJoinDeclined(params: {
    groupId: string;
    decliner: string;
    groupName?: string | undefined;
    reason?: string | undefined;
  }): void {
    console.log(
      `onRequestToJoinDeclined:`,
      params.groupId,
      params.decliner,
      params.groupName,
      params.reason
    );
  }
  // 用户同意进群邀请，邀请人收到回调
  onInvitationAccepted(params: {
    groupId: string;
    invitee: string;
    reason?: string | undefined;
  }): void {
    console.log(
      `onInvitationAccepted:`,
      params.groupId,
      params.invitee,
      params.reason
    );
  }
  // 用户拒绝进群邀请，邀请人收到回调
  onInvitationDeclined(params: {
    groupId: string;
    invitee: string;
    reason?: string | undefined;
  }): void {
    console.log(
      `onInvitationDeclined:`,
      params.groupId,
      params.invitee,
      params.reason
    );
  }
  // 用户被移出群组，所有群组成员收到回调
  onUserRemoved(params: {
    groupId: string;
    groupName?: string | undefined;
  }): void {
    console.log(`onUserRemoved:`, params.groupId, params.groupName);
  }
  // 群组解散，被解散群组所有成员收到该回调
  onGroupDestroyed(params: {
    groupId: string;
    groupName?: string | undefined;
  }): void {
    console.log(`onGroupDestroyed:`, params.groupId, params.groupName);
  }
  // 用户自动同意进群邀请，邀请人收到该事件回调
  onAutoAcceptInvitation(params: {
    groupId: string;
    inviter: string;
    inviteMessage?: string | undefined;
  }): void {
    console.log(
      `onAutoAcceptInvitation:`,
      params.groupId,
      params.inviter,
      params.inviteMessage
    );
  }
  // 群成员被加入禁言列表，被加入禁言列表的成员及管理员和群主收到该事件回调
  onMuteListAdded(params: {
    groupId: string;
    mutes: string[];
    muteExpire?: number | undefined;
  }): void {
    console.log(
      `onMuteListAdded:`,
      params.groupId,
      params.mutes,
      params.muteExpire?.toString
    );
  }
  // 群成员被移出禁言列表，被移出禁言列表的成员及管理员和群主收到该事件回调
  onMuteListRemoved(params: { groupId: string; mutes: string[] }): void {
    console.log(`onMuteListRemoved:`, params.groupId, params.mutes);
  }
  // 群组新增管理员，被添加权限的管理员及其他管理员和群主收到该事件回调
  onAdminAdded(params: { groupId: string; admin: string }): void {
    console.log(`onAdminAdded:`, params.groupId, params.admin);
  }
  // 群组管理员被移除，被移除权限的管理员及其他管理员和群主收到该事件回调
  onAdminRemoved(params: { groupId: string; admin: string }): void {
    console.log(`onAdminRemoved:`, params.groupId, params.admin);
    this.that.setState({
      group_listener: `onAdminRemoved: ` + params.groupId + params.admin,
    });
  }
  // 群主转移权限，所有群成员收到该回调
  onOwnerChanged(params: {
    groupId: string;
    newOwner: string;
    oldOwner: string;
  }): void {
    console.log(
      `onOwnerChanged:`,
      params.groupId,
      params.newOwner,
      params.oldOwner
    );
  }
  // 有新成员加入群组，所有群成员收到该回调
  onMemberJoined(params: { groupId: string; member: string }): void {
    console.log(`onMemberJoined:`, params.groupId, params.member);
  }
  // 有群成员主动退出群，所有群成员收到该回调
  onMemberExited(params: { groupId: string; member: string }): void {
    console.log(`onMemberExited:`, params.groupId, params.member);
  }
  // 群组公告更新，所有群成员收到该回调
  onAnnouncementChanged(params: {
    groupId: string;
    announcement: string;
  }): void {
    console.log(`onAnnouncementChanged:`, params.groupId, params.announcement);
  }
  // 有成员新上传群组共享文件，所有群成员收到该回调
  onSharedFileAdded(params: { groupId: string; sharedFile: string }): void {
    console.log(`onSharedFileAdded:`, params.groupId, params.sharedFile);
  }
  // 群组共享文件被删除，所有群成员收到该回调
  onSharedFileDeleted(params: { groupId: string; fileId: string }): void {
    console.log(`onSharedFileDeleted:`, params.groupId, params.fileId);
  }
  // 有成员被加入群组白名单，被加入白名单的成员及管理员和群主收到该事件回调
  onAllowListAdded(params: { groupId: string; members: string[] }): void {
    console.log(`onAllowListAdded:`, params.groupId, params.members);
  }
  // 有成员被移出群组白名单，被移出白名单的成员及管理员和群主收到该事件回调
  onAllowListRemoved(params: { groupId: string; members: string[] }): void {
    console.log(`onAllowListRemoved:`, params.groupId, params.members);
  }
  // 群成员全员禁言状态变更，所有群成员收到该事件回调
  onAllGroupMemberMuteStateChanged(params: {
    groupId: string;
    isAllMuted: boolean;
  }): void {
    console.log(
      `onAllGroupMemberMuteStateChanged:`,
      params.groupId,
      params.isAllMuted
    );
  }
})(this);

// 清空监听器对象
ChatClient.getInstance().groupManager.removeAllGroupListener();

// 添加监听器对象
ChatClient.getInstance().groupManager.addGroupListener(groupListener);
```