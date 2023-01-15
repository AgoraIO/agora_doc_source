群组是支持多人沟通的即时通讯系统。本文介绍如何使用即时通讯 IM SDK 在实时互动 app 中创建和管理群组，并实现群组相关功能。

## 技术原理

即时通讯 IM SDK 提供了 `Group`，`GroupManager` 和 `GroupChangeListener` 类用于群组管理，可以实现以下功能：

- 创建、解散群组
- 获取群组详情
- 获取群成员列表
- 获取群组列表
- 屏蔽和解除屏蔽群消息
- 监听群组事件

## 前提条件

开始前，请确保满足以下条件：

- 完成即时通讯 IM SDK 初始化，详见 [Android 快速开始](./agora_chat_get_started_android)。
- 了解 [使用限制](./agora_chat_limitation)。
- 了解群组和群成员的数量限制，详见 [套餐包详情](./agora_chat_plan)。

## 实现方法

本节介绍如何调用即时通讯 IM SDK 提供的 API 实现上述功能。

### 创建群组

用户可以创建群组，并设置群组的名称、描述、群组成员、创建群组的原因等属性。用户还可以设置 `GroupOptions` 参数指定群组的大小和类型。创建群组后，群组创建者自动成为群主。

创建群组前，你需要设置群组的类型（`GroupStyle`）和邀请进群是否需要对方同意（`inviteNeedConfirm`）。其中：

- 群组类型（`GroupStyle`）可以设置为如下值：

  - GroupStylePrivateOnlyOwnerInvite——私有群，只有群主和管理员可以邀请人进群；
  - GroupStylePrivateMemberCanInvite——私有群，所有群成员均可以邀请人进群；
  - GroupStylePublicJoinNeedApproval——公开群，申请人通过群主和群管理同意后才能进群；
  - GroupStylePublicOpenJoin ——公开群，任何人都可以进群，无需群主和群管理同意。

- 邀请进群是否需要受邀用户确认（`GroupOptions#inviteNeedConfirm`）

公开群只支持群主和管理员邀请用户入群。对于私有群，除了群主和群管理员，群成员是否也能邀请其他用户进群取决于群组类型 `GroupStyle` 的设置。

邀请入群是否需受邀用户确认取决于群组选项 `GroupOptions#inviteNeedConfirm` 和受邀用户的参数 `autoAcceptGroupInvitation` 的设置，前者的优先级高于后者，即若 `GroupOptions#inviteNeedConfirm` 设置为 `false`，不论 `autoAcceptGroupInvitation` 设置为何值，受邀用户无需确认直接进群。

1. 受邀用户无需确认，直接进群。

以下两种设置的情况下，用户直接进群：

- 若 `GroupOptions#inviteNeedConfirm` 设置为 `false`，不论 `autoAcceptGroupInvitation` 设置为 `false` 或 `true`，受邀用户均无需确认，直接进群。
- 若 `GroupOptions#inviteNeedConfirm` 和 `autoAcceptGroupInvitation` 均设置为 `true`，用户自动接受群组邀请，直接进群。

受邀用户直接进群，会收到如下回调：

- 新成员会收到 `GroupChangeListener#onAutoAcceptInvitationFromGroup` 回调；
- 邀请人收到 `GroupChangeListener#onInvitationAccepted` 回调和 `GroupChangeListener#onMemberJoined` 回调；
- 其他群成员收到 `GroupChangeListener#onMemberJoined` 回调。

2. 受邀用户需要确认才能进群。

只有 `GroupOptions#inviteNeedConfirm` 设置为 `true` 和 `autoAcceptGroupInvitation` 设置为 `false` 时，受邀用户需要确认才能进群。这种情况下，受邀用户收到 `GroupChangeListener#onInvitationReceived` 回调，并选择同意或拒绝进群邀请：

- 用户同意入群邀请后，邀请人收到 `GroupChangeListener#onInvitationAccepted` 回调和 `GroupChangeListener#onMemberJoined` 回调，其他群成员收到 `GroupChangeListener#onMemberJoined` 回调；
- 用户拒绝入群邀请后，邀请人收到 `GroupChangeListener#groupInvitationDidDecline` 回调。

用户可以调用 `createGroup` 方法创建群组，并通过 `GroupOptions` 参数设置群组名称、群组描述、群组成员和建群原因。

用户加入群组后，将可以收到群消息。

创建群组示例代码如下：

```java
GroupOptions option = new GroupOptions();
// 设置群组成员最大数量为 100.
option.maxUsers = 100;
// 设置群组类型为 `PrivateMemberCanInvite`，即普通成员可邀请用户入群的私有群组。
option.style = GroupStyle.GroupStylePrivateMemberCanInvite;

// 调用 `createGroup` 创建群组。
ChatClient.getInstance().groupManager().createGroup(groupName, desc, allMembers, reason, option);
```

### 解散群组

仅群主可以调用 `destroyGroup` 方法解散群组。群组解散时，其他群组成员收到 `GroupChangeListener#onGroupDestroyed` 回调并被踢出群组。

<div class="alert note">该操作是危险操作，解散群组后，将删除本地数据库及内存中的群相关信息及群会话。</div>

```java
ChatClient.getInstance().groupManager().destroyGroup(groupId);
```

### 获取群组详情

群成员可以调用 `getGroupFromServer` 方法从服务器获取群组详情。返回结果包括群组 ID、群组名称、群组描述、群组基本属性、群主、群组管理员列表、是否已屏蔽群组消息以及群组是否禁用。另外，若设置 `fetchMembers` 为 `true`，可获取群成员列表，默认最多包括 200 个成员。

```java
try {
    Group group = ChatClient.getInstance().groupManager().getGroupFromServer(groupId, true);
} catch (ChatException e) {
    e.printStackTrace();
}

// 获取群组管理员列表。
List<String> admins=group.getAdminList();
...
```

### 获取群成员列表

要获取群组的成员列表，请根据组大小选择方法：

- 如果群组的成员大于等于 200，可分页获取群成员。
- 如果群成员少于 200 人，除了分页获取群成员列表，也可以调用 `getGroupFromServer` 方法。

参考以下示例代码获取群组的成员列表：

```java
// 分页获取群组成员列表
List<String> memberList = new ArrayList<>;
CursorResult<String> result = null;
final int pageSize = 20;
do {
     result = ChatClient.getInstance().groupManager().fetchGroupMembers(groupId,
             result != null? result.getCursor(): "", pageSize);
     memberList.addAll(result.getData());
} while (!TextUtils.isnull(result.getCursor()) && result.getData().size() == pageSize);

// 调用 `getGroupFromServer` 获取群组成员列表。
Group group = ChatClient.getInstance().groupManager().getGroupFromServer(groupId, true);
List<String> memberList = group.getMembers();
```

### 获取群组列表

用户可以调用 `getJoinedGroupsFromServer` 方法从服务器获取自己创建和加入的群组列表。示例代码如下：

```java
try {
    List<Group> groups =ChatClient.getInstance().groupManager().getJoinedGroupsFromServer();
} catch (ChatException e) {
    e.printStackTrace();
}
```

- 用户可以调用 `getAllGroups` 方法从内存中获取当前用户的所有群组。在调用此方法之前，可先调用 `loadAllGroups` 方法将群组数据从数据库加载到内存。如果未调用 `loadAllGroups` 方法，首次调用 `getAllGroups` 方法会从数据库中加载群组数据，然后再从内存中加载。示例代码如下：

```java
List<Group> allGroups = ChatClient.getInstance().groupManager().getAllGroups();
```

- 用户还可以调用 `getPublicGroupsFromServer` 方法分页获取公开群列表：

```java
List<GroupInfo> groups = new ArrayList<>();
CursorResult<GroupInfo> result = null;
do {
    try {
        result = ChatClient.getInstance().groupManager().getPublicGroupsFromServer(20, result != null ? result.getCursor() : "");
    } catch (ChatException e) {
        e.printStackTrace();
    }
    if(result != null) {
        groups.addAll(result.getData());
    }
} while (result != null && !TextUtils.isEmpty(result.getCursor()));
```

### 屏蔽和解除屏蔽群消息

群组成员可以屏蔽和解除屏蔽群组消息。

### 屏蔽群消息

群成员可以调用 `blockGroupMessage` 方法屏蔽群消息。屏蔽群消息后，该成员不再收到来自该群组的消息，群主和群管理员不能进行此操作。

示例代码如下：

```java
ChatClient.getInstance().groupManager().blockGroupMessage(groupId);
```

### 解除屏蔽群消息

群成员可以调用 `unblockGroupMessage` 方法解除屏蔽群消息。示例代码如下：

```java
ChatClient.getInstance().groupManager().unblockGroupMessage(groupId);
```
#### 检查自己是否已经屏蔽群消息

群成员可以调用 `Group#isMsgBlocked` 方法检查是否屏蔽了该群的消息。为了保证检查结果的准确性，调用该方法前需先从服务器获取群详情，即调用 `GroupManager#getGroupFromServer`。

示例代码如下：

```java
// 1、获取群组详情
ChatClient.getInstance().groupManager().asyncGetGroupFromServer(groupId, new ValueCallBack<Group>() {
    @Override
    public void onSuccess(Group group) {
        // 2、检查用户是否屏蔽了该群的群消息
        if(group.isMsgBlocked()) {
        }
    }
    @Override
    public void onError(int error, String errorMsg) {
    }
});
```

### 监听群组事件

为了监听群组事件，用户可以监听 `GroupManager` 中的回调，并添加相应的应用逻辑。如果不再使用该监听，需要移除，防止出现内存泄漏。

参考以下示例代码监听群组事件：

```java
// 创建一个群组事件监听
GroupChangeListener groupListener = new GroupChangeListener() {
    // 用户收到入群邀请。
    @Override
    public void onInvitationReceived(String groupId, String groupName, String inviter, String reason) {

    }
    // 群主或群管理员收到进群申请。
    @Override
    public void onRequestToJoinReceived(String groupId, String groupName, String applyer, String reason) {

    }
    // 群主或群管理员同意用户的进群申请。申请人收到该事件。
    @Override
    public void onRequestToJoinAccepted(String groupId, String groupName, String accepter) {

    }
    // 群主或群管理员拒绝用户的进群申请。申请人收到该事件。
    @Override
    public void onRequestToJoinDeclined(String groupId, String groupName, String decliner, String reason) {

    }
    // 用户同意进群邀请。邀请人收到该事件。
    @Override
    public void onInvitationAccepted(String groupId, String inviter, String reason) {

    }
    // 用户拒绝进群邀请。邀请人收到该事件。
    @Override
    public void onInvitationDeclined(String groupId, String invitee, String reason) {

    }
    // 有成员被移出群组。被踢出群组的成员会收到该事件。
    @Override
    public void onUserRemoved(String groupId, String groupName) {

    }
    // 群组解散。群主解散群组时，所有群成员均会收到该事件。
    @Override
    public void onGroupDestroyed(String groupId, String groupName) {

    }
    // 有用户自动同意加入群组。邀请人收到该事件。
    @Override
    public void onAutoAcceptInvitationFromGroup(String groupId, String inviter, String inviteMessage) {

    }
    // 有成员被加入群组禁言列表。被禁言的成员及群主和群管理员（除操作者外）会收到该事件。
    @Override
    public void onMuteListAdded(String groupId, final List<String> mutes, final long muteExpire) {

    }
    // 有成员被移出禁言列表。被解除禁言的成员及群主和群管理员（除操作者外）会收到该事件。
    @Override
    public void onMuteListRemoved(String groupId, final List<String> mutes) {

    }
    // 有成员被加入群组白名单。被添加的成员及群主和群管理员（除操作者外）会收到该事件。
    @Override
    public void onWhiteListAdded(String groupId, List<String> whitelist) {

    }
    // 有成员被移出群组白名单。被移出的成员及群主和群管理员（除操作者外）会收到该事件。
    @Override
    public void onWhiteListRemoved(String groupId, List<String> whitelist) {

    }
    // 全员禁言状态变化。群组所有成员（除操作者外）会收到该事件。
    @Override
    public void onAllMemberMuteStateChanged(String groupId, boolean isMuted) {

    }
    // 群组新增管理员。群主、新管理员和其他管理员会收到该事件。
    @Override
    public void onAdminAdded(String groupId, String administrator) {

    }
    // 群组管理员被移除。被移出的成员及群主和群管理员（除操作者外）会收到该事件。
    @Override
    public void onAdminRemoved(String groupId, String administrator) {

    }
    // 群主转移权限。原群主和新群主会收到该事件。
    @Override
    public void onOwnerChanged(String groupId, String newOwner, String oldOwner) {

    }
    // 有新成员加入群组。除了新成员，其他群成员会收到该回调。
    @Override
    public void onMemberJoined(final String groupId, final String member){

    }
    // 有成员主动退出群。除了退群的成员，其他群成员会收到该事件。
    @Override
    public void onMemberExited(final String groupId, final String member) {

    }
    // 群组公告更新。群组所有成员会收到该事件。
    @Override
    public void onAnnouncementChanged(String groupId, String announcement) {

    }
    // 有成员新上传群组共享文件。群组所有成员会收到该事件。
    @Override
    public void onSharedFileAdded(String groupId, MucSharedFile sharedFile) {

    }
    // 群组共享文件被删除。群组所有成员会收到该事件。
    @Override
    public void onSharedFileDeleted(String groupId, String fileId) {

    }
    // 群组详情变更。群组所有成员会收到该事件。
    @Override
    public void onSpecificationChanged(Group group){

    }
};

// 注册群组监听
ChatClient.getInstance().groupManager().addGroupChangeListener(groupListener);

// 移除群组监听
ChatClient.getInstance().groupManager().removeGroupChangeListener(groupListener);
```