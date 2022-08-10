# 管理群组

群组是支持多人沟通的即时通讯系统。

本页介绍如何使用 Agora Chat SDK 在你的应用中创建和管理群组。

如需查看消息相关内容，参见 [消息管理](https://docs-preprod.agora.io/en/agora-chat/agora_chat_message_overview?platform=Android)。

## 技术原理

Agora Chat SDK 提供了 `Group`，`GroupManager` 和 `GroupChangeListener` 类用于群组管理，可以实现以下功能：

- 创建、解散群组
- 加入、退出群组
- 获取群组详情
- 获取群成员列表
- 获取群组列表
- 屏蔽、解除屏蔽群消息
- 监听群组事件

## 前提条件

开始前，请确保满足以下条件：

- 完成 Agora Chat SDK 初始化，详见 [Android 入门](https://docs.agora.io/en/agora-chat/agora_chat_get_started_android?platform=Android)。
- 了解 [使用限制](https://docs.agora.io/en/agora-chat/agora_chat_limitation?platform=Android)中所述。
- 了解群组和群成员的数量限制，详见 [套餐包详情](https://docs.agora.io/en/agora-chat/agora_chat_plan?platform=Android) 了解不同定价计划支持的群组和群组成员的数量。

## 实现方法

本节介绍如何调用 Agora Chat SDK 提供的 API 实现上述功能。

### 创建和解散群组

用户可以创建群组，并设置群组的名称、描述、群组成员、创建群组的原因等属性。用户还可以设置 `GroupOptions` 参数来指定群组的大小和类型。创建群组后，群组的创建者自动成为群组的所有者。

只有群主才能解散群。群组解散后，该群组的所有成员都会收到 `onGroupDestroyed` 回调并立即从群组中删除。群组的所有本地数据也会从数据库和内存中删除。

在创建群组前，你需要设置群组类型（`GroupStyle`）和进群邀请是否需要对方同意 (`inviteNeedConfirm`)。

1、私有群不可被搜索到，公开群可以通过 ID 搜索到。目前支持四种群组类型（`GroupStyle`），具体设置如下：

- GroupStylePrivateOnlyOwnerInvite——私有群，只有群主和管理员可以邀请人进群；
- GroupStylePrivateMemberCanInvite——私有群，所有群成员均可以邀请人进群；
- GroupStylePublicJoinNeedApproval——公开群，加入此群除了群主和管理员邀请，只能通过申请加入此群；
- GroupStylePublicOpenJoin ——公开群，任何人都可以进群，无需群主和群管理同意。

2、进群邀请是否需要对方同意 (`inviteNeedConfirm`) 的具体设置如下：

- 进群邀请需要用户确认(`inviteNeedConfirm` 设置为 `true`)。创建群组并发出邀请后，根据受邀用户的 `autoAcceptGroupInvitation` 设置，处理逻辑如下：
  - 用户设置自动接受群组邀请 (`autoAcceptGroupInvitation` 设置为 `true`)。受邀用户自动进群并收到 `GroupChangeListener#onAutoAcceptInvitationFromGroup` 回调，群主收到 `GroupChangeListener#onInvitationAccepted` 回调和 `GroupChangeListener#onMemberJoined` 回调，其他群成员收到 `GroupChangeListener#onMemberJoined` 回调。
  - 用户设置手动确认群组邀请 (`autoAcceptGroupInvitation` 设置为 `false`)，受邀用户收到 `GroupChangeListener#onInvitationReceived` 回调，并选择同意或拒绝入群邀请：
     - 用户同意入群邀请后，群主收到 `GroupChangeListener#onInvitationAccepted` 回调和 `GroupChangeListener#onMemberJoined` 回调；其他群成员收到 `GroupChangeListener#onMemberJoined` 回调；
     - 用户拒绝入群邀请后，群主收到 `GroupChangeListener#groupInvitationDidDecline` 回调。

流程如下：

[![img](https://docs-im.easemob.com/_media/ccim/android/8.png?w=1500&tok=db0f36)](https://docs-im.easemob.com/_detail/ccim/android/8.png?id=ccim%3Aandroid%3Agroup2)

- 进群邀请无需用户确认 (`inviteNeedConfirm` 设置为 `false`)。创建群组并发出邀请后，无视用户的 `autoAcceptGroupInvitation` 设置，受邀用户直接进群。用户收到 `GroupChangeListener#onAutoAcceptInvitationFromGroup` 回调；群主收到每个已加入成员对应的群组事件回调 `GroupChangeListener#onInvitationAccepted` 和 `GroupChangeListener#onMemberJoined`；先加入的群成员会收到群组事件回调 `GroupChangeListener#onMemberJoined`。

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


// 调用 `destroyGroup` 解散群组。
ChatClient.getInstance().groupManager().destroyGroup(groupId);
```

### 加入和离开群组

用户申请加入群组的步骤如下：

1. 调用 `getPublicGroupsFromServer` 方法从服务器获取公开群列表，查询到想要加入的群组 ID。

2. 调用 `joinGroup` 方法传入群组 ID，申请加入对应群组：

   - 如果群组的类型设置为 `GroupStylePublicJoin`，则自动接受用户的请求，其他群组成员收到 `onMemberJoined` 回调。
   - 如果群组的类型设置为 `GroupStylePublicNeedApproval`，则群组所有者和群组管理员会收到 `onRequestToJoinReceived` 回调，并决定是否接受用户的请求。

用户可以调用 `leaveGroup` 离开群组。一旦用户离开群组，所有其他群组成员都会收到 `onMemberExited` 回调。

请参考以下示例代码加入和退出群组：

```java
// 从服务器获取公开群组列表。
CursorResult<GroupInfo> result = ChatClient.getInstance().groupManager().getPublicGroupsFromServer(pageSize, cursor);
List<GroupInfo> groupsList = List<GroupInfo> returnGroups = result.getData();
String cursor = result.getCursor();

// 调用 `joinGroup` 方法发送加入群组申请。
ChatClient.getInstance().groupManager().joinGroup(groupId);

// 调用 `leaveGroup` 方法主动退出群。
ChatClient.getInstance().groupManager().leaveGroup(groupId);
```

### 获取群成员列表

要检索群组的成员列表，请根据组大小选择方法：

- 如果群组的成员大于等于 200，则按页面列出群组的成员。
- 如果一个聊天群的成员少于 200 人，也可以调用 `getGroupFromServer` 获取该群组的成员列表。

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

### 屏蔽和解除屏蔽群消息

所有群组成员都可以屏蔽和解除屏蔽群组消息。成员屏蔽群组消息后，他们将不再收到来自该群组的消息。

```java
// 群成员可以调用 `blockGroupMessage` 方法屏蔽群消息。屏蔽群消息后，该成员不再从指定群组接收群消息，群主和群管理员不能进行此操作。
ChatClient.getInstance().groupManager().blockGroupMessage(groupId);

// 群成员可以调用 `unblockGroupMessage` 方法解除屏蔽群消息。
ChatClient.getInstance().groupManager().unblockGroupMessage(groupId);
```

#### 检查自己是否已经屏蔽群消息

群成员可以调用 `Group#isMsgBlocked` 方法检查用户是否屏蔽了该群的群消息。使用此方法检查时，为了保证结果的准确性，需要先从服务器获取群详情，即调用 `GroupManager#getGroupFromServer`。

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

`GroupManager` 中提供群组事件的监听接口。开发者可以通过设置此监听，获取群组中的事件，并做出相应处理。如果不再使用该监听，需要移除，防止出现内存泄漏。

参考以下示例代码监听群组事件：

```java
// 创建一个群组事件监听
GroupChangeListener groupListener = new GroupChangeListener() {
    // 用户收到进群邀请
    @Override
    public void onInvitationReceived(String groupId, String groupName, String inviter, String reason) {

    }
    // 群主或群管理员收到进群申请
    @Override
    public void onRequestToJoinReceived(String groupId, String groupName, String applyer, String reason) {

    }
    // 群主或群管理员同意用户的进群申请
    @Override
    public void onRequestToJoinAccepted(String groupId, String groupName, String accepter) {

    }
    // 群主或群管理员拒绝用户的进群申请
    @Override
    public void onRequestToJoinDeclined(String groupId, String groupName, String decliner, String reason) {

    }
    // 用户同意进群邀请
    @Override
    public void onInvitationAccepted(String groupId, String inviter, String reason) {

    }
    // 用户拒绝进群邀请
    @Override
    public void onInvitationDeclined(String groupId, String invitee, String reason) {

    }
    // 有成员被移出群组
    @Override
    public void onUserRemoved(String groupId, String groupName) {

    }
    // 群组解散
    @Override
    public void onGroupDestroyed(String groupId, String groupName) {

    }
    // 有用户自动同意加入群组
    @Override
    public void onAutoAcceptInvitationFromGroup(String groupId, String inviter, String inviteMessage) {

    }
    // 有成员被加入群组禁言列表
    @Override
    public void onMuteListAdded(String groupId, final List<String> mutes, final long muteExpire) {

    }
    // 有成员被移出禁言列表
    @Override
    public void onMuteListRemoved(String groupId, final List<String> mutes) {

    }
    // 有成员被加入群组白名单
    @Override
    public void onWhiteListAdded(String groupId, List<String> whitelist) {

    }
    // 有成员被移出群组白名单
    @Override
    public void onWhiteListRemoved(String groupId, List<String> whitelist) {

    }
    // 全员禁言状态变化
    @Override
    public void onAllMemberMuteStateChanged(String groupId, boolean isMuted) {

    }
    // 群组新增管理员
    @Override
    public void onAdminAdded(String groupId, String administrator) {

    }
    // 群组管理员被移除
    @Override
    public void onAdminRemoved(String groupId, String administrator) {

    }
    // 群主转移权限
    @Override
    public void onOwnerChanged(String groupId, String newOwner, String oldOwner) {

    }
    // 有新成员加入群组
    @Override
    public void onMemberJoined(final String groupId, final String member){

    }
    // 有成员主动退出群
    @Override
    public void onMemberExited(final String groupId, final String member) {

    }
    // 群组公告更新
    @Override
    public void onAnnouncementChanged(String groupId, String announcement) {

    }
    // 有成员新上传群组共享文件
    @Override
    public void onSharedFileAdded(String groupId, MucSharedFile sharedFile) {

    }
    // 群组共享文件被删除
    @Override
    public void onSharedFileDeleted(String groupId, String fileId) {

    }
    // 群组详情变更
    @Override
    public void onSpecificationChanged(Group group){

    }
};

// 注册群组监听
ChatClient.getInstance().groupManager().addGroupChangeListener(groupListener);

// 移除群组监听
ChatClient.getInstance().groupManager().removeGroupChangeListener(groupListener);
```