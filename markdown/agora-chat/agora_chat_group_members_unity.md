# 管理群组成员

群组是支持多人沟通的即时通讯系统，本文指导你如何使用 Agora Chat SDK 在实时互动 app 中实现群组成员管理相关功能。

## 技术原理

Agora Chat SDK 提供 `Group`、`IGroupManager` 和 `IGroupManagerDelegate` 类用于群组管理，支持你通过调用 API 在项目中实现如下功能：

- 群组加人、踢人
- 管理群组及群管理员
- 管理群组黑名单
- 管理群组禁言列表
- 开启、关闭群组全员禁言
- 管理群组白名单

## 前提条件

开始前，请确保满足以下条件：

- 完成 SDK 初始化，详见 [快速入门](https://docs-preprod.agora.io/cn/agora-chat/agora_chat_get_started_unity)；
- 了解 Agora Chat API 的接口调用频率限制，详见 [使用限制](https://docs-preprod.agora.io/cn/agora-chat/agora_chat_limitation_unity)；
- 了解群组和群成员的数量限制，详见 [套餐包详情](https://docs-preprod.agora.io/cn/agora-chat/agora_chat_plan)。

## 实现方法

本节介绍如何使用 Agora Chat SDK 提供的 API 实现上述功能。

### 群组加人

根据 [创建群组](https://docs-preprod.agora.io/cn/agora-chat/agora_chat_group_unity?platform=Unity#%E5%88%9B%E5%BB%BA%E7%BE%A4%E7%BB%84) 时的群组类型 (`GroupStyle`) 和进群邀请是否需要对方同意 (`inviteNeedConfirm`) 设置，群组加人的处理逻辑有差别。

1. 群组类型 (`GroupStyle`) 设置的差别如下：
- 无论是私有群还是公开群，群主和管理员均可以调用 `IGroupManager#AddGroupMembers` 方法邀请人进群
- 如果私有群类型为 `PrivateMemberCanInvite`，群成员也可以邀请人进群

2. 进群邀请是否需要对方同意 (`inviteNeedConfirm`) 设置的差别如下：
- 进群邀请需要用户确认 (`option.InviteNeedConfirm` 设置为 `true`)。邀请人发出邀请后，根据受邀用户的 `AutoAcceptGroupInvitation` 设置，处理逻辑如下：
  - 用户设置自动接受群组邀请 (`AutoAcceptGroupInvitation` 设置为 `true`)。受邀用户自动进群并收到`IGroupManagerDelegate#OnAutoAcceptInvitationFromGroup` 回调，邀请人收到`IGroupManagerDelegate#OnInvitationAcceptedFromGroup` 回调和 `IGroupManagerDelegate#OnMemberJoinedFromGroup` 回调，其他群成员收到 `IGroupManagerDelegate#OnMemberJoinedFromGroup` 回调。
  - 用户设置手动确认群组邀请 (`AutoAcceptGroupInvitation` 设置为 `false`)。受邀用户收到 `IGroupManagerDelegate#OnInvitationReceivedFromGroup` 回调，选择同意或拒绝入群邀请：
    - 用户同意入群邀请后，邀请人收到 `IGroupManagerDelegate#OnInvitationAcceptedFromGroup` 回调和 `IGroupManagerDelegate#OnMemberJoinedFromGroup` 回调，其他群成员收到 `IGroupManagerDelegate#OnMemberJoinedFromGroup` 回调；
    - 用户拒绝入群邀请后，邀请人收到 `IGroupManagerDelegate#OnInvitationDeclinedFromGroup` 回调。

![](https://web-cdn.agora.io/docs-files/1652856319322)

- 进群邀请无需用户确认 (`option.InviteNeedConfirm` 设置为 `false`)。邀请人发出邀请后，无视用户的 `IsAutoAcceptGroupInvitation` 设置，受邀用户直接进群。用户收到 `IGroupManagerDelegate#OnAutoAcceptInvitationFromGroup` 回调，邀请人收到 `IGroupManagerDelegate#OnInvitationAcceptedFromGroup` 回调和 `IGroupManagerDelegate#OnMemberJoinedFromGroup` 回调，其他群成员收到 `IGroupManagerDelegate#OnMemberJoinedFromGroup` 回调。

示例代码如下：

```c#
SDKClient.Instance.GroupManager.AddGroupMembers(groupId, members, new CallBack(
  onSuccess: () =>
  {
  },
  onError: (code, desc) =>
  {
  }
));
```

### 群组踢人

仅群主和群管理员可以调用 `DeleteGroupMembers` 方法将指定成员移出群组。被移出后，该成员收到 `IGroupManagerDelegate#OnUserRemovedFromGroup` 回调，其他群成员收到 `IGroupManagerDelegate#OnMemberExitedFromGroup` 回调。被移出群组后，该用户还可以再次加入群组。

示例代码如下：

```c#
SDKClient.Instance.GroupManager.DeleteGroupMembers(groupId, list, new CallBack (
  onSuccess: () =>
  {
  },
  onError: (code, desc) =>
  {
  }
));
```

### 管理群主和群管理员

#### 变更群主

仅群主可以调用 `ChangeGroupOwner` 方法将权限移交给群组中指定成员。成功移交后，原群主变为普通成员，其他群成员收到 `IGroupManagerDelegate#OnOwnerChangedFromGroup` 回调。

示例代码如下：

```c#
SDKClient.Instance.GroupManager.ChangeGroupOwner(groupId, newOwner, new CallBack(
  onSuccess: () =>
  {
  },
  onError: (code, desc) =>
  {
  }
));
```

#### 添加群组管理员

仅群主可以调用 `AddGroupAdmin` 方法添加群管理员。成功添加后，新管理员及其他管理员收到 `IGroupManagerDelegate#OnAdminAddedFromGroup` 回调。

示例代码如下：

```c#
SDKClient.Instance.GroupManager.AddGroupAdmin(groupId, adminId, new CallBack(
  onSuccess: () =>
  {
  },
  onError: (code, desc) =>
  {
  }
));     
```

#### 移除群组管理员

仅群主可以调用 `RemoveGroupAdmin` 方法移除群管理员。成功移除后，被移除的管理员及其他管理员收到 `IGroupManagerDelegate#OnAdminRemovedFromGroup` 回调。

示例代码如下：

```c#
SDKClient.Instance.GroupManager.RemoveGroupAdmin(groupId, adminId, new CallBack(
  onSuccess: () =>
  {
  },
  onError: (code, desc) =>
  {
  }
));
```

### 管理群组黑名单

#### 将成员加入群组黑名单

仅群主和群管理员可以调用 `BlockGroupMembers` 方法将指定成员添加至黑名单。被加入黑名单后，该成员收到 `IGroupManagerDelegate#OnUserRemovedFromGroup` 回调，其他群成员收到 `IGroupManagerDelegate#OnMemberExitedFromGroup` 回调。被加入黑名单后，该成员无法再收发群组消息并被移出群组，黑名单中的成员如想再次加入群组，群主或群管理员必须先将其移除黑名单。

示例代码如下：

```c# 
SDKClient.Instance.GroupManager.BlockGroupMembers(groupId, members, new CallBack(
  onSuccess: () =>
  {
  },
  onError: (code, desc) =>
  {
  }
));
```

#### 将成员移出群组黑名单

仅群主和群管理员可以调用 `UnBlockGroupMembers` 方法将成员移出群组黑名单。指定用户被群主或者群管理员移出群黑名单后，可以再次申请加入群组。

示例代码如下：

```c#
SDKClient.Instance.GroupManager.UnBlockGroupMembers(groupId, members, new CallBack(
  onSuccess: () =>
  {
  },
  onError: (code, desc) =>
  {
  }
));
```

#### 获取群组黑名单

仅群主和群管理员可以调用 `GetGroupBlockListFromServer` 方法获取当前群组的黑名单。

示例代码如下：

```c#
SDKClient.Instance.GroupManager.GetGroupBlockListFromServer(groupId, pageNum, pageSize, handle: new ValueCallBack<List<string>>(
  onSuccess: (list) =>
  {
  },
  onError: (code, desc) =>
  {
  }
));
```

### 管理群组禁言列表

#### 将成员加入群组禁言列表

仅群主和群管理员可以调用 `MuteGroupMembers` 方法将指定成员添加至群组禁言列表。被禁言后，该成员和其他未操作的管理员或者群主收到 `IGroupManagerDelegate#OnMuteListAddedFromGroup` 回调。群成员被加入群禁言列表后，不能在该群组中发言，即使被加入群白名单也不能发言。

示例代码如下：

```c#
SDKClient.Instance.GroupManager.MuteGroupMembers(groupId, members, new CallBack(
  onSuccess: () =>
  {
  },
  onError: (code, desc) =>
  {
  }
));
```

#### 将成员移出群组禁言列表

仅群主和群管理员可以调用 `UnMuteGroupMembers` 方法将指定成员移出群组禁言列表。被解除禁言后，该成员和其他未做操作的群管理员或者群主收到 `IGroupManagerDelegate#OnMuteListRemovedFromGroup` 回调。

示例代码如下：

```c#
SDKClient.Instance.GroupManager.UnMuteGroupMembers(groupId, members, new CallBack(
  onSuccess: () =>
  {
  },
  onError: (code, desc) =>
  {
  }
));    
```

#### 获取群组禁言列表

仅群主和群管理员可以调用 `GetGroupMuteListFromServer` 方法从服务器获取当前群组的禁言列表。

示例代码如下：

```c#
SDKClient.Instance.GroupManager.GetGroupMuteListFromServer(groupId, handle: new ValueCallBack<List<string>>(
  onSuccess: (list) => {
  },
  onError: (code, desc) =>
  {
  }
));
```

### 开启和关闭全员禁言

#### 开启全员禁言

仅群主和群管理员可以调用 `MuteGroupAllMembers` 方法开启全员禁言。群组全员禁言开启后，除了在白名单中的群成员，其他成员不能发言。

示例代码如下：

```c#
SDKClient.Instance.GroupManager.MuteGroupAllMembers(groupId, new CallBack(
  onSuccess: () => {
  },
  onError: (code, desc) =>
  {
  }
));
```

#### 关闭全员禁言

仅群主和群管理员可以调用 `UnMuteGroupAllMembers` 方法取消全员禁言，示例代码如下：

```c#
SDKClient.Instance.GroupManager.UnMuteGroupAllMembers(groupId, new CallBack(
  onSuccess: () => {
  },
  onError: (code, desc) =>
  {
  }
));   
```

### 管理群组白名单

#### 将成员加入群组白名单

仅群主和群管理员可以调用 `AddGroupWhiteList` 方法将指定群成员加入群白名单。白名单用户不受全员禁言的限制，但是如果白名单用户在群禁言列表中，则该用户不能发言。

示例代码如下：

```c#
SDKClient.Instance.GroupManager.AddGroupWhiteList(groupId, members, new CallBack(
  onSuccess: () => {
  },
  onError: (code, desc) =>
  {
  }
)); 
```

#### 将成员移出群组白名单

仅群主和群管理员可以调用 `RemoveGroupWhiteList` 方法将指定群成员移出群白名单。

示例代码如下：

```c#
SDKClient.Instance.GroupManager.RemoveGroupWhiteList(groupId, members, new CallBack(
  onSuccess: () => {
  },
  onError: (code, desc) =>
  {
  }
)); 
```

#### 检查自己是否在白名单中

所有群成员可以调用 `checkIfInGroupWhiteList` 方法检查自己是否在群白名单中，示例代码如下：

```c#
public void checkIfInGroupWhiteList(final String groupId, EMValueCallBack<Boolean> callBack)
SDKClient.Instance.GroupManager.CheckIfInGroupWhiteList(groupId, new ValueCallBack<bool>(
  onSuccess: (ret) => {
  },
  onError: (code, desc)=> {
  }
));
```

#### 获取群组白名单

仅群主和群管理员可以调用 `GetGroupWhiteListFromServer` 方法从服务器获取当前群组的白名单。

示例代码如下：

```c#
SDKClient.Instance.GroupManager.GetGroupWhiteListFromServer(currentGroupId, handle: new ValueCallBack<List<string>>(
  onSuccess: (list) => {
  },
  onError: (code, desc) =>
  {
  }
));
```

### 监听群组事件

详见 [监听群组事件](https://docs-preprod.agora.io/cn/agora-chat/agora_chat_group_unity?platform=Unity#%E7%9B%91%E5%90%AC%E7%BE%A4%E7%BB%84%E4%BA%8B%E4%BB%B6)。