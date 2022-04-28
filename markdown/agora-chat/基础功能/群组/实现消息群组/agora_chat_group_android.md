群组是支持多人沟通的即时通讯系统，本文指导你如何使用 Agora Chat SDK 在实时互动 app 中创建群组并管理群组和群组成员。

## 技术原理

Agora Chat Android SDK 提供 `GroupManager` 和 `Group` 类用于群组管理，支持你通过调用 API 在项目中实现如下功能：
- 创建、解散群组
- 加入、退出群组
- 获取群成员列表、已加入群组列表
- 屏蔽及取消屏蔽群消息
- 管理群成员
- 管理群组属性、群公告及群共享文件

## 前提条件

开始前，请确保你的项目满足以下条件：

- 已完成 SDK 初始化。详见[实现发送和接收消息](agora_chat_get_started_android)。
- 了解 Agora Chat API 的接口调用频率限制。详见[限制条件](agora_chat_limitation_android)。
- 了解群组和群成员数量限制。详见[套餐包详情](agora_chat_plan)。

## 实现方法

本节介绍如何使用 Agora Chat SDK 提供的 API 实现上述功能。

### 创建与解散群组

创建群组包含如下步骤：

1. 群主调用 `createGroup` 方法创建群组，你可以在该方法中设置群组名、群组描述、群组成员、建群原因，并通过 `GroupOptions` 参数设置群组的最大人数及群组类型。
2. 根据被邀请人是否需要确认才能加群的设置，后续的实现逻辑不同：
    - 如果被邀请人设置了需要确认才能加群，则被邀请人会收到 `onInvitationReceived` 回调。如果同意入群，则邀请人会收到 `onInvitationAccepted` 回调。被邀请人进群后，所有群组成员会收到 `onMemberJoined` 回调；如果被邀请人不同意入群，则邀请人收到 `onInvitationDeclined` 回调。
    - 如果被邀请人设置了无需确认直接入群，则被邀请人会收到 `onAutoAcceptInvitationFromGroup` 回调。邀请人收到 `onInvitationAccepted` 回调。被邀请人进群后，所有群组成员会收到 `onMemberJoined` 回调。

创建和解散群组的示例代码如下：

```java
GroupOptions option = new GroupOptions();
// 设置群组最大成员为 100
option.maxUsers = 100;
// 设置群组属性为私有群，且群成员可以邀请其他会员入群
option.style = GroupStyle.GroupStylePrivateMemberCanInvite;

// 调用 createGroup 方法创建群组。成功创建群组后，调用该方法的用户自动成为群组的群主。
ChatClient.getInstance().groupManager().createGroup(groupName, desc, allMembers, reason, option);


// 调用 destroyGroup 方法解散群组。解散群组后，本地数据库和内存中的群相关信息和群会话均会消息
// 该方法只有群主才能调用。成功解散群组后，群成员会收到 onGroupDestroyed 回调
ChatClient.getInstance().groupManager().destroyGroup(groupId);
```

### 用户申请入群与退出群组

当群组类型为 `GroupStylePublicJoinNeedApproval` 或 `GroupStylePublicOpenJoin` 时，用户可以申请加入该群。

申请入群的步骤如下：
1. 调用 `getAllGroups` 方法获取群组列表，并获取想要加入的群组的 ID。
2. 调用 `joinGroup` 方法加入群组：
    - 如果群组类型为 `GroupStylePublicJoin`，则用户可以直接调用 `joinGroup` 加入该群。成功入群后，群组成员会收到 `onMemberJoined` 回调
    - 如果群组类型为 `GroupStylePublicNeedApproval`，则群主和群管理员会收到 `onRequestToJoinReceived` 回调。群主和群管理员可以同意或拒绝该入群申请。


用户申请入群与退出群组的示例代码如下：

```java
// 从服务器获取自己加入或创建的群组列表
List<Group> grouplist = ChatClient.getInstance().groupManager().getJoinedGroupsFromServer();

// 获取本地群组列表。为保证数据正确性，需要先调用 getJoinedGroupsFromServer 获取自己已加入或创建的群组列表
List<Group> grouplist = ChatClient.getInstance().groupManager().getAllGroups();

// 分页获取公开群列表
CursorResult<GroupInfo> result = ChatClient.getInstance().groupManager().getPublicGroupsFromServer(pageSize, cursor);
List<GroupInfo> groupsList = List<GroupInfo> returnGroups = result.getData();
String cursor = result.getCursor();

// 调用 joinGroup 加入群组
ChatClient.getInstance().groupManager().joinGroup(groupId);

// 调用 leaveGroup 退出群组。退出后，其他群组成员会收到 onMemberExited 回调
ChatClient.getInstance().groupManager().leaveGroup(groupId);
```

### 获取群成员列表

你可以通过分页获取群成员。当群成员少于 200 人时，也可以直接调用 `getGroupFromServer` 获取群成员。示例代码如下：

```java
// 通过分页获取群成员
List<String> memberList = new ArrayList<>;
CursorResult<String> result = null;
final int pageSize = 20;
do {
     result = ChatClient.getInstance().groupManager().fetchGroupMembers(groupId,
             result != null? result.getCursor(): "", pageSize);
     memberList.addAll(result.getData());
} while (!TextUtils.isnull(result.getCursor()) && result.getData().size() == pageSize);

// 群成员少于 200 人时，也可以使用如下示例代码
Group group = ChatClient.getInstance().groupManager().getGroupFromServer(groupId, true);
List<String> memberList = group.getMembers();
```

### 屏蔽和解除屏蔽群消息

群成员可以屏蔽和解除屏蔽群消息。屏蔽群消息后，该成员将不再接收群消息。示例代码如下：

```java
// 调用 blockGroupMessage 屏蔽群消息
// 只有群成员才可以调用该方法。群主和群管理员不可以
ChatClient.getInstance().groupManager().blockGroupMessage(groupId);

// 调用 unblockGroupMessage 解除屏蔽
ChatClient.getInstance().groupManager().unblockGroupMessage(groupId);
```

### 群组加人或踢人

无论是私有群还有公开群，群主和群管理员均可以通过调用 `addUsersToGroup` 将用户添加到群组。如果群组类型为 `GroupStylePrivateMemberCanInvite`，则群成员也可以添加其他用户进群。用户成功加入群组后，就可以接收群消息。

群组加人的步骤如下：
1. 群主、群管理员或群成员调用 `addUsersToGroup` 方法邀请用户入群
2. 根据被邀请人是否需要确认才能加群的设置，双方逻辑不同：
    - 如果被邀请人设置了需要确认才能加群，则被邀请人会收到 `onInvitationReceived` 回调。如果同意入群，则邀请人会收到 `onInvitationAccepted` 回调。被邀请人进群后，所有群组成员会收到 `onMemberJoined` 回调；如果被邀请人不同意入群，则邀请人收到 `oninvitationDeclined` 回调。
    - 如果被邀请人设置了无需确认直接入群，则被邀请人会收到 `onAutoAcceptInvitationFromGroup` 回调。邀请人收到 `onInvitationAccepted` 回调。被邀请人进群后，所有群组成员会收到 `onMemberJoined` 回调。

群组加人、踢人的示例代码如下：

```java
// 群主或群管理员调用 addUsersToGroup 加人
ChatClient.getInstance().groupManager().addUsersToGroup(groupId, newmembers);

// 群成员调用 inviteUser 加人
ChatClient.getInstance().groupManager().inviteUser(groupId, newmembers, null);

// 只有群主和群管理员才可以将群成员踢出群组
// 群成员被踢出群组后，会收到 onUserRemoved 回调，且不会再接收群消息；其他群成员会收到 onMemberExited 回调
ChatClient.getInstance().groupManager().removeUserFromGroup(groupId, username);
```

### 转让群主、添加和移除群管理员

群主可以将权限移交给群组中指定成员，移交后原群主变为成员，群成员会接收到 `onOwnerChanged` 回调。

群主还可以添加群管理员。成功添加后，被添加为群管理员的用户和其他管理员会收到 `onAdminAdded` 回调。

转让群主、添加和移除群管理员的示例代码如下：

```java
// 群主调用 chageOwner 将群主权限移交给指定群成员
ChatClient.getInstance().groupManager().changeOwner(groupId, newOwner);

// 群主调用 addGroupAdmin 添加群管理员
ChatClient.getInstance().groupManager().addGroupAdmin(groupId, admin);

// 群主调用 removeGroupAdmin 移除管理员权限。被移除群管理的用户和其他管理员会收到 onAdminRemoved 回调
ChatClient.getInstance().groupManager().removeGroupAdmin(groupId, admin);
```

### 管理群组黑名单列表

群主及群管理员可以将群组中的指定群成员加入或者移出群黑名单。群成员被加入黑名单后将无法收发群消息，且无法申请再次入群。

添加、移除、获取群组黑名单的示例代码如下：

```java
// 群主或群管理员调用 blockUser 将指定用户移入黑名单
ChatClient.getInstance().groupManager().blockUser(groupId, username);

// 群主或群管理员调用 unblockUser 将指定用户移出黑名单。移出后，该用户可以再次申请加入群组
ChatClient.getInstance().groupManager().unblockUser(groupId, username);

// 群主或群管理员可以从服务器获取群组的黑名单列表
ChatClient.getInstance().groupManager().getBlockedUsers(groupId);
```

### 管理群组禁言列表

为了精细化管理群成员发言，群主和群管理员可以根据情况将指定群成员加入或者移出群禁言列表。群成员被加入群禁言列表后，将不能够发言，即使其被加入群白名单也不能发言。

添加、移除、获取群禁言列表的示例代码如下：

```java
// 群主或群管理员调用 muteGroupMember 将指定用户加入群禁言列表。被禁言成员和其他未操作的群主或群管理员会收到 onMuteListAdded 回调
ChatClient.getInstance().groupManager().muteGroupMembers(groupId, muteMembers, duration);

// 群主或群管理员调用 unmuteGroupMember 将指定用户移出禁言列表。被移出的成员和其他未操作的群主或群管理员会收到 onMuteListRemoved 回调
ChatClient.getInstance().groupManager().unMuteGroupMembers(String groupId, List<String> members);

// 群主或群管理员调用 fetchGroupMuteList 获取群组禁言列表
ChatClient.getInstance().groupManager().fetchGroupMuteList(String groupId, int pageNum, int pageSize);
```

为方便快捷管理，Agora Chat 还支持群主和群管理员开启和关闭群组全员禁言。开启群组全员禁言后，除了在群白名单中的群成员，其他成员将不能发言。

开启、关闭全员禁言的示例代码如下：

```java
// 群主或群管理员调用 muteAllMembers 开启全员禁言。成功开启后，群成员会收到 onAllMemberMuteStateChanged 回调
public void muteAllMembers(final String groupId, final ValueCallBack<Group> callBack);

// 群主或群管理员调用 unmuteAllMembers 取消全员禁言。成功取消后，群成员会收到 onAllMemberMuteStateChanged 回调
public void unmuteAllMembers(final String groupId, final ValueCallBack<Group> callBack);
```

### 管理群组白名单列表

白名单用户不受全员禁言限制。但是如果该白名单用户在群禁言列表中，则该用户不能发言。

添加、移除、获取白名单的示例代码如下：

```java
// 群主或群管理员调用 addToGroupWhiteList 添加指定成员到白名单。成功添加后，该群成员和其他位操作的群主或群管理员会收到 onWhiteListAdded 回调
public void addToGroupWhiteList(final String groupId, final List<String> members, final CallBack callBack);

// 群主或群管理员调用 removeFromGroupWhiteList 将指定成员移除出白名单。成功移除后，该群成员和其他位操作的群主或群管理员会收到 onWhiteListRemoved 回调
public void removeFromGroupWhiteList(final String groupId, final List<String> members, final CallBack callBack);

// 群成员可以调用 checkIfInGroupWhiteList 检查自己是否在白名单中
public void checkIfInGroupWhiteList(final String groupId, ValueCallBack<Boolean> callBack);

// 群主或群管理员调用 fetchGroupWhiteList 获取群组白名单列表
public void fetchGroupWhiteList(final String groupId, final ValueCallBack<List<String>> callBack);
```

### 修改群组名称或描述

群主或群管理员可以修改群组的名称和描述。示例代码如下：

```java
// 群主或群管理员调用 changeGroupName 修改群组名称。群名称长度限制为 128 个字符
ChatClient.getInstance().groupManager().changeGroupName(groupId,changedGroupName);

// 群主或群管理员调用 changeGroupDescription 修改群组描述。群组描述长度限制为 512 个字符
ChatClient.getInstance().groupManager().changeGroupDescription(groupId,description);
```

### 更新、获取群公告

群主和群管理员可以设置和更新群公告，群成员可以获取群公告。示例代码如下：

```java
// 群主或群管理员调用 updateGroupAnnouncement 设置或更新群公告。成功设置后，所有群组成员收到 onAnnoucementChanged 回调。群公告长度限制为 512 个字符
ChatClient.getInstance().groupManager().updateGroupAnnouncement(groupId, announcement);

// 群成员均可以调用 fetchGroupAnnouncement 获取群公告
ChatClient.getInstance().groupManager().fetchGroupAnnouncement(groupId);
```

### 上传、删除、获取群共享文件

所有群组成员都可以上传和获取群共享文件。只有群主和群管理员才能删除全部群共享文件，群成员只能删除自己上传的群文件。示例代码如下：

```java
// 群成员均可以调用 uploadGroupSharedFile 上传群共享文件。群共享文件大小限制为 10 M
// 成功上传群共享文件后，群成员会收到 onSharedFileAdded 回调
ChatClient.getInstance().groupManager().uploadGroupSharedFile(groupId, filePath, callBack);

// 群成员均可以调用 deleteGroupSharedFile 删除群共享文件
// 成功删除群共享文件后，群成员会收到 onSharedFileDeleted 回调
ChatClient.getInstance().groupManager().deleteGroupSharedFile(groupId, fileId);

// 群成员均可以调用 fetchGroupSharedFileList 获取群共享文件列表
ChatClient.getInstance().groupManager().fetchGroupSharedFileList(groupId, pageNum, pageSize);
```

### 监听群组事件

`GroupManager` 中提供了群组事件的监听接口。你可以通过设置此监听，获取到群组中的事件，并做出相应的处理。如果不再使用该监听，需要移除，防止出现内存泄漏。

监听群组事件的示例代码如下：

```java
GroupChangeListener groupListener = new GroupChangeListener() { 
    @Override
    public void onInvitationReceived(String groupId, String groupName, String inviter, String reason) {
        
    }

    @Override
    public void onRequestToJoinReceived(String groupId, String groupName, String applyer, String reason) {
        
    }

    @Override
    public void onRequestToJoinAccepted(String groupId, String groupName, String accepter) {
        
    }

    @Override
    public void onRequestToJoinDeclined(String groupId, String groupName, String decliner, String reason) {
        
    }

    @Override
    public void onInvitationAccepted(String groupId, String inviter, String reason) {
        
    }

    @Override
    public void onInvitationDeclined(String groupId, String invitee, String reason) {
        
    }

    @Override
    public void onUserRemoved(String groupId, String groupName) {
        
    }

    @Override
    public void onGroupDestroyed(String groupId, String groupName) {

    }
    
    @Override
    public void onAutoAcceptInvitationFromGroup(String groupId, String inviter, String inviteMessage) {
        
    }

    @Override
    public void onMuteListAdded(String groupId, final List<String> mutes, final long muteExpire) {
        
    }

    @Override
    public void onMuteListRemoved(String groupId, final List<String> mutes) {
        
    }
    
    @Override
    public void onWhiteListAdded(String groupId, List<String> whitelist) {
          
    }

    @Override
    public void onWhiteListRemoved(String groupId, List<String> whitelist) {
         
    }

    @Override
    public void onAllMemberMuteStateChanged(String groupId, boolean isMuted) {
          
    }

    @Override
    public void onAdminAdded(String groupId, String administrator) {
        
    }

    @Override
    public void onAdminRemoved(String groupId, String administrator) {
        
    }

    @Override
    public void onOwnerChanged(String groupId, String newOwner, String oldOwner) {
        
    }

    @Override
    public void onMemberJoined(final String groupId, final String member){
        
    }

    @Override
    public void onMemberExited(final String groupId, final String member) {
        
    }

    @Override
    public void onAnnouncementChanged(String groupId, String announcement) {
        
    }

    @Override
    public void onSharedFileAdded(String groupId, MucSharedFile sharedFile) {
        
    }

    @Override
    public void onSharedFileDeleted(String groupId, String fileId) {
        
    }
};

// Set group listener
ChatClient.getInstance().groupManager().addGroupChangeListener(groupListener);

// Remove group listener if not use
ChatClient.getInstance().groupManager().removeGroupChangeListener(groupListener);
```