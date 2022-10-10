群组是支持多人沟通的即时通讯系统，本文介绍如何使用即时通讯 IM SDK 在实时互动 app 中创建和管理群组，并实现群组相关功能。

## 技术原理

即时通讯 IM SDK 提供 `Group`、`IGroupManager` 和 `IGroupManagerDelegate` 类用于群组管理，支持你通过调用 API 在项目中实现如下功能：

- 创建、解散群组
- 加入、退出群组
- 获取群组详情
- 获取群成员列表
- 获取群组列表
- 屏蔽、解除屏蔽群消息
- 监听群组事件

## 前提条件

开始前，请确保满足以下条件：

- 完成 SDK 初始化，详见 [快速开始](./agora_chat_get_started_unity)。
- 了解 [使用限制](./agora_chat_limitation)。
- 了解群组和群成员的数量限制，详见 [套餐包详情](./agora_chat_plan)。

## 实现方法

本节介绍如何使用即时通讯 IM SDK 提供的 API 实现上述功能。

### 创建群组

在创建群组前，你需要设置群组类型 (`GroupStyle`) 和进群邀请是否需要对方同意 (`inviteNeedConfirm`)。

1. 私有群不可被搜索到，公开群可以通过 ID 搜索到。目前支持四种群组类型 (`GroupStyle`) ，具体设置如下：

    - `PrivateOnlyOwnerInvite` —— 私有群，只有群主和管理员可以邀请人进群；
    - `PrivateMemberCanInvite` —— 私有群，所有群成员均可以邀请人进群；
    - `PublicJoinNeedApproval` —— 公开群，加入此群除了群主和管理员邀请，只能通过申请加入此群；
    - `PublicOpenJoin` —— 公开群，任何人都可以进群，无需群主和群管理同意。

2. 进群邀请是否需要对方同意 (`inviteNeedConfirm`) 的具体设置如下：
    - 进群邀请需要用户确认 (`option.InviteNeedConfirm` 设置为 `true`)。创建群组并发出邀请后，根据受邀用户的 `AutoAcceptGroupInvitation` 设置，处理逻辑如下：
        - 用户设置自动接受群组邀请 (`AutoAcceptGroupInvitation` 设置为 `true`)。受邀用户自动进群并收到 `IGroupManagerDelegate#OnAutoAcceptInvitationFromGroup` 回调，邀请人收到 `IGroupManagerDelegate#OnInvitationAcceptedFromGroup` 回调和 `IGroupManagerDelegate#OnMemberJoinedFromGroup` 回调，其他群成员收到 `IGroupManagerDelegate#OnMemberJoinedFromGroup` 回调。
        - 用户设置手动确认群组邀请 (`AutoAcceptGroupInvitation` 设置为 `false`)。受邀用户收到 `IGroupManagerDelegate#OnInvitationReceivedFromGroup` 回调，并选择同意或拒绝入群邀请：
            - 用户同意入群邀请后，邀请人收到 `IGroupManagerDelegate#OnInvitationAcceptedFromGroup` 回调和 `IGroupManagerDelegate#OnMemberJoinedFromGroup` 回调，其他群成员收到 `IGroupManagerDelegate#OnMemberJoinedFromGroup` 回调；
            - 用户拒绝入群邀请后，邀请人收到 `IGroupManagerDelegate#OnInvitationDeclinedFromGroup` 回调。
    - 进群邀请无需用户确认 (`option.InviteNeedConfirm` 设置为 `false`)。创建群组并发出邀请后，无视用户的 `IsAutoAcceptGroupInvitation` 设置，受邀用户直接进群。用户收到 `IGroupManagerDelegate#OnAutoAcceptInvitationFromGroup` 回调，邀请人收到 `IGroupManagerDelegate#OnInvitationAcceptedFromGroup` 回调和 `IGroupManagerDelegate#OnMemberJoinedFromGroup` 回调，其他群成员收到 `IGroupManagerDelegate#OnMemberJoinedFromGroup` 回调。

用户可以调用 `CreateGroup` 方法创建群组，并通过 `GroupOptions` 参数设置群组名称、群组描述、群组成员和建群原因。

示例代码如下：

```c#
GroupOptions option = new GroupOptions(GroupStyle.PrivateMemberCanInvite);
option.MaxCount = 100;
SDKClient.Instance.GroupManager.CreateGroup(groupname, option, desc, members, handle:new ValueCallBack<Group>(
  onSuccess: (group) => {
  },
  onError:(code, error) => {
  }
));
```

### 用户申请入群

根据 [创建群组](#创建群组) 时的群组类型 (`GroupStyle`) 设置，加入群组的处理逻辑差别如下：

- 当群组类型为 `PublicOpenJoin` 时，用户可以直接加入群组，无需群主和群管理员同意；加入群组后，其他群成员收到 `IGroupManagerDelegate#OnMemberJoinedFromGroup` 回调；
- 当群组类型为 `PublicJoinNeedApproval` 时，用户可以申请进群，群主和群管理员收到 `IGroupManagerDelegate#OnRequestToJoinReceivedFromGroup` 回调，并选择同意或拒绝入群申请：
    - 群主和群管理员同意入群申请，申请人收到 `IGroupManagerDelegate#OnRequestToJoinAcceptedFromGroup` 回调，其他群成员收到 `IGroupManagerDelegate#OnMemberJoinedFromGroup` 回调；
    - 群主和群管理员拒绝入群申请，申请人收到 `IGroupManagerDelegate#OnRequestToJoinDeclinedFromGroup` 回调。

用户只能申请加入公开群组，私有群组不支持用户申请入群。

用户申请加入群组的步骤如下：

1. 调用 `FetchPublicGroupsFromServer` 方法从服务器获取公开群列表，查询到想要加入的群组 ID。
2. 调用 `JoinPublicGroup` 方法传入群组 ID，申请加入对应群组。

示例代码如下：

```c#
// 获取公开群组列表
SDKClient.Instance.GroupManager.FetchPublicGroupsFromServer(handle: new ValueCallBack<CursorResult<GroupInfo>>(
            //result 为 CursorResult<GroupInfo>
            onSuccess: (result) => {
            },
            onError: (code, desc) =>
            {
            }
        ));

// 申请加入群组
SDKClient.Instance.GroupManager.JoinPublicGroup(groupId, new CallBack(
  onSuccess: () =>
  {
  },
  onError:(code, desc) =>
  {
  }
));
```

### 解散群组

仅群主可以调用 `DestroyGroup` 方法解散群组。群组解散时，其他群组成员收到 `OnDestroyedFromGroup` 回调并被踢出群组。

该操作只有群主才能进行，是危险操作，解散群组后，将删除本地数据库及内存中的群相关信息及群会话。

示例代码如下：

```c#
SDKClient.Instance.GroupManager.DestroyGroup(groupId, new CallBack(
    onSuccess: () =>
    {
    },
    onError: (code, desc) =>
    {
    }
));
```

### 退出群组

群成员可以调用 `LeaveGroup` 方法退出群组，其他成员收到 `IGroupManagerDelegate#OnMemberExitedFromGroup` 回调。退出群组后，该用户将不再收到群消息。群主不能调用该接口退出群组，只能调用 [DestroyGroup](https://docs-im.easemob.com/ccim/unity/group2#解散群组) 方法解散群组。

示例代码如下：

```c#
SDKClient.Instance.GroupManager.LeaveGroup(groupId, new CallBack(
  onSuccess: () =>
  {
  },
  onError:(code, desc) =>
  {
  }
));
```

### 获取群组详情

群成员可以调用 `GetGroupWithId` 方法从内存获取群组详情。返回结果包括：群组 ID、群组名称、群组描述、群组基本属性、群主、群组管理员列表，默认不包含群成员。

群成员也可以调用 `GetGroupSpecificationFromServer` 方法从服务器获取群组详情。返回结果包括：群组 ID、群组名称、群组描述、群主、群组管理员列表以及群成员列表。

示例代码如下：

```c#
// 根据群组 ID 从本地获取群组详情。
Group group = SDKClient.Instance.GroupManager.GetGroupWithId(groupId);

// 根据群组 ID 从服务器获取群组详情。
SDKClient.Instance.GroupManager.GetGroupSpecificationFromServer(groupId, new ValueCallBack<Group>(
            onSuccess: (group) => {
            },
            onError: (code, desc) =>
            {
            }
        ));
```

### 获取群成员列表

群成员可以调用 `GetGroupMemberListFromServer` 方法从服务器分页获取群成员列表。

示例代码如下：

```c#
SDKClient.Instance.GroupManager.GetGroupMemberListFromServer(groupId, pageSize, cursor, handle: new ValueCallBack<CursorResult<string>>(
  onSuccess: (result) =>
  {
  },
  onError: (code, desc) =>
  {
  }
));
```

### 获取群组列表

用户可以调用 `FetchJoinedGroupsFromServer` 方法从服务器获取自己加入和创建的群组列表。示例代码如下：

```c#
SDKClient.Instance.GroupManager.FetchJoinedGroupsFromServer(handle: new ValueCallBack<List<Group>>(
  onSuccess: (groupList) => {
  },
  onError: (code, desc) =>
  {
  }
));
```

用户可以调用 `GetJoinedGroups` 方法加载本地群组列表。为了保证数据的正确性，需要先从服务器获取自己加入和创建的群组列表。示例代码如下：

```c#
List<Group> groupList = SDKClient.Instance.GroupManager.GetJoinedGroups();
```

用户还可以调用 `FetchPublicGroupsFromServer` 方法从服务器分页获取公开群组列表。示例代码如下：

```c#
SDKClient.Instance.GroupManager.FetchPublicGroupsFromServer(pageSize, cursor, handle: new ValueCallBack<CursorResult<GroupInfo>>(
  onSuccess: (result) =>
  {
  },
  onError: (code, desc) =>
  {
  }
));
```

### 屏蔽和解除屏蔽群消息

#### 屏蔽群消息

所有群成员均可以调用 `BlockGroup` 方法屏蔽群消息。屏蔽群消息后，该成员不再从指定群组接收群消息。示例代码如下：

```c#
SDKClient.Instance.GroupManager.BlockGroup(groupId, new CallBack(
  onSuccess: () =>
  {
  },
  onError: (code, desc) =>
  {
  }
));
```

#### 解除屏蔽群消息

群成员可以调用 `UnBlockGroup` 方法解除屏蔽群消息。示例代码如下：

```c#
SDKClient.Instance.GroupManager.UnBlockGroup(groupId, new CallBack(
  onSuccess: () =>
  {
  },
  onError: (code, desc) =>
  {
  }
));
```

#### 检查当前用户是否已经屏蔽群消息

群成员可以调用 `IGroupManager#GetGroupSpecificationFromServer` 方法并通过 `Group#MessageBlocked` 字段检查自己是否屏蔽了群消息。

示例代码如下：

```c#
SDKClient.Instance.GroupManager.GetGroupSpecificationFromServer(currentGroupId, new ValueCallBack<Group>(
            onSuccess: (group) => {
        // 检查用户是否屏蔽了该群的群消息
                if(group.MessageBlocked == true) {

                }
            },
            onError: (code, desc) =>
            {

            }
        ));
```

### 监听群组事件

`IGroupManagerDelegate` 类中提供群组事件的监听接口。开发者可以通过设置此监听，获取群组中的事件，并做出相应处理。如果不再使用该监听，需要移除，防止出现内存泄漏。

示例代码如下：

```c#
// 实现监听器以及定义监听器对象
// 在本例中，用户 A 为当前用户。
public class GroupManagerDelegate : IGroupManagerDelegate {
    // 当前用户收到了入群邀请。受邀用户会收到该回调。例如，用户 B 邀请用户 A 入群，则用户 A 会收到该回调。
    public void OnInvitationReceivedFromGroup(string groupId, string groupName, string inviter, string reason)
    {
    }
    // 当前用户发送入群申请。群主和群管理员会收到该回调。
    public void OnRequestToJoinReceivedFromGroup(string groupId, string groupName, string applicant, string reason)
    {
    }
    // 当前用户的入群申请被接受。申请人会收到该回调。例如，用户 B 接受用户 A 的入群申请后，用户 A 会收到该回调。
    public void OnRequestToJoinAcceptedFromGroup(string groupId, string groupName, string accepter)
    {
    }
    // 当前用户的入群申请被拒绝。申请人会收到该回调。例如，用户 B 拒绝用户 A 的入群申请后，用户 A 会收到该回调。
    public void OnRequestToJoinDeclinedFromGroup(string groupId, string groupName, string decliner, string reason)
    {
    }
    // 当前用户的入群邀请被接受。邀请人会收到该回调。例如，用户 B 接受了用户 A 的入群邀请，则用户 A 会收到该回调。
    public void OnInvitationAcceptedFromGroup(string groupId, string invitee, string reason)
    {
    }
    // 当前用户的入群申请被拒绝。申请人会收到该回调。例如，用户 B 拒绝用户 A 的入群申请后，用户 A 会收到该回调。
    public void OnInvitationDeclinedFromGroup(string groupId, string invitee, string reason)
    {
    }
    // 用户被移出群组。被踢出群组的成员会收到该回调。
    public void OnUserRemovedFromGroup(string groupId, string groupName)
    {
    }
    // 群组被解散。群主解散群组时，所有群成员均会收到该回调。
    public void OnDestroyedFromGroup(string groupId, string groupName)
    {
    }
    // 用户自动同意入群邀请。受邀用户会收到该邀请。
    public void OnAutoAcceptInvitationFromGroup(string groupId, string inviter, string inviteMessage)
    {
    }
    // 群成员被加入禁言列表。被禁言的成员及群主和群管理员（除操作者外）会收到该回调。
    public void OnMuteListAddedFromGroup(string groupId, List<string> mutes, int muteExpire)
    {
    }
    // 群成员被移出禁言列表。被解除禁言的成员及群主和群管理员（除操作者外）会收到该回调。
    public void OnMuteListRemovedFromGroup(string groupId, List<string> mutes)
    {
    }
    // 群组新增管理员。群主、新管理员和其他管理员会收到该回调。
    public void OnAdminAddedFromGroup(string groupId, string administrator)
    {
    }
    // 有管理员被移出群管理员列表。群主、被移出的管理员和其他管理员会收到该回调。
    public void OnAdminRemovedFromGroup(string groupId, string administrator)
    {
    }
    // 群主变更。原群主和新群主会收到该回调。
    public void OnOwnerChangedFromGroup(string groupId, string newOwner, string oldOwner)
    {
    }
    // 有新成员加入群组。除了新成员，其他群成员会收到该回调。
    public void OnMemberJoinedFromGroup(string groupId, string member)
    {
    }
    // 群成员主动退出群组。除了退群的成员，其他群成员会收到该回调。
    public void OnMemberExitedFromGroup(string groupId, string member)
    {
    }
    // 更新群公告。群组所有成员会收到该回调。
    public void OnAnnouncementChangedFromGroup(string groupId, string announcement)
    {
    }
    // 上传群共享文件。群组所有成员会收到该回调。
    public void OnSharedFileAddedFromGroup(string groupId, GroupSharedFile sharedFile)
    {
    }
    // 删除群共享文件。群组所有成员会收到该回调。
    public void OnSharedFileDeletedFromGroup(string groupId, string fileId)
    {
    }
    // 有成员添加至群白名单。被添加的成员及群主和群管理员（除操作者外）会收到该回调。
    public void OnAddWhiteListMembersFromGroup(string groupId, List<string> whiteList)
    {
    }

    // 有成员从群白名单中移出。被移出的成员及群主和群管理员（除操作者外）会收到该回调。
    public void OnRemoveWhiteListMembersFromGroup(string groupId, List<string> whiteList)
    {
    }
    // 群成员一键禁言状态变更。群组所有成员（除操作者外）会收到该回调。
    public void OnAllMemberMuteChangedFromGroup(string groupId, bool isAllMuted)
    {
    }
}

// 注册群组回调。
GroupManagerDelegate adelegate = new GroupManagerDelegate();
SDKClient.Instance.GroupManager.AddGroupManagerDelegate(adelegate);

// 移除群组回调。
SDKClient.Instance.GroupManager.RemoveGroupManagerDelegate(adelegate);
```