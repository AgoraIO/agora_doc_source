群组是支持多人沟通的即时通讯系统。本文介绍如何使用即时通讯 IM SDK 在实时互动 app 中实现群组成员管理相关功能。

## 技术原理

即时通讯 IM iOS SDK 提供 `IAgoraChatGroupManager`、`AgoraChatGroupManagerDelegate` 和 `AgoraChatGroup` 类用于群组成员管理，可以实现以下功能：

- 群组加人、踢人
- 管理群主及群管理员
- 管理群组白名单
- 管理群组黑名单
- 管理群组禁言

## 前提条件

开始前，请确保满足以下条件：

- 完成 SDK 初始化，详见 [iOS 快速开始](./agora_chat_get_started_ios)。
- 了解即时通讯 IM 的 [使用限制](./agora_chat_limitation)。
- 了解群组和群成员的数量限制，详见 [套餐包详情](./agora_chat_plan)。

## 实现方法

本节介绍如何使用即时通讯 IM SDK 提供的 API 实现上述功能。

### 群组加人

根据创建群组时的群组类型（`AgoraChatGroupStyle`）和进群邀请是否需要对方同意 (`IsInviteNeedConfirm`)设置，群组加人的处理逻辑有差别。具体规则可以参考详见[创建群组](./agora_chat_group_ios#创建群组)。

邀请加群的示例代码如下：

```objective-c
[[AgoraChatClient sharedClient].groupManager addMembers:@{@"member1",@"member2"}
                                                                                               toGroup:@"groupID"
                                                                                                 message:@"message"
                                                                                          completion:nil];
```

### 群组踢人

仅群主和群管理员可以调用 `removeMembers` 方法将指定成员移出群组。被踢出群组后，被踢群成员将会收到群组事件回调 `AgoraChatGroupManagerDelegate#didLeaveGroup`，其他成员将会收到回调 `AgoraChatGroupManagerDelegate#userDidLeaveGroup`。被移出群组后，该用户还可以再次加入群组。

示例代码如下：

```objective-c
[[AgoraChatClient sharedClient].groupManager removeMembers:@{@"member"}
                                                                                                  fromGroup:@"groupsID"
                                                                                                 completion:nil];
```

### 管理群主和群管理员

#### 变更群主

仅群主可以调用 `updateGroupOwner` 方法将群组所有权移交给群组中指定成员。成功移交后，原群主变为普通成员，其他群组成员收到 `AgoraChatGroupManagerDelegate#groupOwnerDidUpdate` 回调。

```objective-c
[[AgoraChatClient sharedClient].groupManager updateGroupOwner:@"groupID"
                                                                                                         newOwner:@"newOwner"
                                                                                                                 error:nil];
```

#### 添加群组管理员

仅群主可以调用 `addAdmin` 方法添加群管理员。成功添加后，新管理员和其他管理员会接收到群组事件回调 `AgoraChatGroupManagerDelegate#groupAdminListDidUpdate`。

管理员除了不能解散群组等少数权限外，拥有对群组的绝大部分权限。

示例代码如下：

```objective-c
[[AgoraChatClient sharedClient].groupManager addAdmin:@"member"
                                                                                           toGroup:@"groupID"
                                                                                                 error:nil];
```

#### 移除群组管理员权限

仅群主可以调用 `removeAdmin` 方法移除群管理员。

群管理员被移除管理权限后只具备普通群成员的权限。被移除管理员权限的成员和其他管理员会接收到群组事件回调 `AgoraChatGroupManagerDelegate#groupAdminListDidUpdate`。

示例代码如下：

```objective-c
[[AgoraChatClient sharedClient].groupManager removeAdmin:@"admin"
                                                                                            fromGroup:@"groupID"
                                                                                                      error:nil];
```

### 管理群组白名单

#### 将成员加入群组白名单

仅群主和群管理员可以调用 `addWhiteListMembers` 方法将指定群成员加入群白名单。添加后，该群成员及群管理员和群主（除操作者外）会收到群组事件回调 `AgoraChatGroupManagerDelegate#groupWhiteListDidUpdate`。

即使开启了群组全员禁言，群组白名单中的成员仍可以发送群组消息。不过，禁言列表上的用户即使加入了群白名单仍无法在群组中发送消息。

```objective-c
[[AgoraChatClient sharedClient].groupManager addWhiteListMembers:members
                                                                                                            fromGroup:@"groupID"
                                                                                                                      error:nil];
```

#### 将成员移出群组白名单

仅群主和群管理员可以调用 `removeWhiteListMembers` 方法将指定群成员移出群白名单。移出后，该群成员及群管理员和群主（除操作者外）会收到群组事件回调 `AgoraChatGroupManagerDelegate#groupWhiteListDidUpdate`。

```objective-c
[[AgoraChatClient sharedClient].groupManager removeWhiteListMembers:members
                                                                                                               fromGroup:@"groupID"
                                                                                                                         error:nil];
```

#### 检查自己是否在白名单中

所有群成员可以调用 `isMemberInWhiteListFromServerWithGroupId` 方法检查自己是否在群白名单中，示例代码如下：

```objective-c
[[AgoraChatClient sharedClient].groupManager
                                                                 isMemberInWhiteListFromServerWithGroupId:@"groupID"
                                                                                                                                   error:nil];
```

#### 获取群组白名单

仅群主和群管理员可以调用 `getGroupWhiteListFromServerWithId` 方法从服务器获取当前群组的白名单。

```objective-c
[[AgoraChatClient sharedClient].groupManager getGroupWhiteListFromServerWithId:@"groupID"                                                                                                                                                  error:nil];
```

### 管理群组黑名单

#### 将群成员加入群组黑名单

仅群主和群管理员可以调用 `blockMembers` 方法将指定成员添加至黑名单。加入黑名单的成员收到 `AgoraChatGroupManagerDelegate#didLeaveGroup` 回调，其他群成员收到 `AgoraChatGroupManagerDelegate#userDidLeaveGroup` 回调。黑名单中的成员会被移出群组，无法再收发群消息，只有先被移出黑名单才能重新加入群组。

示例代码如下：

```objective-c
[[AgoraChatClient sharedClient].groupManager blockMembers:members
                                                                                                 fromGroup:@"groupID"
                                                                                              completion:nil];
```

#### 将成员移出群组黑名单

仅群主和群管理员可以调用 `unblockUser` 方法将成员移出群组黑名单。指定用户被移出群黑名单后，可以重新加入群组。

示例代码如下：

```objective-c
[[AgoraChatClient sharedClient].groupManager unblockMembers:members
                                                      fromGroup:@"groupId"
                                                     completion:nil];
```

#### 获取群组的黑名单用户列表

仅群主和群管理员可以调用 `getGroupBlacklistFromServerWithId` 方法获取当前群组的黑名单。默认最多可获取 200 个用户。

示例代码如下：

```objective-c
[[AgoraChatClient sharedClient].groupManager getGroupBlacklistFromServerWithId:@"groupId"
                                              pageNumber:pageNumber
                                                  pageSize:pageSize
                                              completion:nil];
```

### 管理群组禁言

群主和群管理员可以将指定群成员添加或移出禁言列表，也可开启关闭全员禁言。全员禁言和单独的成员禁言不冲突，开启和关闭全员禁言，并不影响禁言列表。

#### 将成员加入群组禁言列表

仅群主和群管理员可以调用 `muteMembers` 方法将指定成员添加至群组禁言列表。被禁言成员和其他未操作的管理员或者群主将会收到群组事件回调 `AgoraChatGroupManagerDelegate#groupMuteListDidUpdate`。

群成员被加入群禁言列表后，将无法发言，即使其被加入群白名单也不能发言。

```objective-c
[[AgoraChatClient sharedClient].groupManager muteMembers:members
                                                                                 muteMilliseconds:60
                                                                                              fromGroup:@"groupID"
                                                                                                      error:nil];
```

#### 将成员移出群组禁言列表

仅群主和群管理员可以调用 `unmuteMembers` 方法将指定成员移出群组禁言列表。被移出的群成员及其他未操作的管理员或者群主将会收到群组事件回调 `AgoraChatGroupManagerDelegate#groupMuteListDidUpdate`。

群成员被移出禁言列表后可以在群组中正常发送消息。

```objective-c
[[AgoraChatClient sharedClient].groupManager unmuteMembers:members
                                                                                                  fromGroup:@"groupID"
                                                                                                          error:nil];
```

#### 获取群组禁言列表

仅群主和群管理员可以调用 `getGroupMuteListFromServerWithId` 方法从服务器获取当前群组的禁言列表。

示例代码如下：

```objective-c
[[AgoraChatClient sharedClient].groupManager getGroupMuteListFromServerWithId:@"groupID"
                                                                                                                                      pageNumber:pageNumber
                                                                                                                                         pageSize:pageSize
                                                                                                                                              error:nil];
```

#### 开启群组全员禁言

仅群主和群管理员可以调用 `muteAllMembersFromGroup` 方法开启群组全员禁言。开启全员禁言后，群成员会收到群组事件回调 `AgoraChatGroupManagerDelegate#groupAllMemberMuteChanged`。

开启群组全员禁言后，只有群组白名单中的成员才能在群组中发送消息。

示例代码如下：

```objective-c
[[AgoraChatClient sharedClient].groupManager muteAllMembersFromGroup:@"groupID"
                                                                                                                              error:nil];
```

#### 关闭群组全员禁言

仅群主和群管理员可以调用 `unmuteAllMembersFromGroup` 方法关闭群组全员禁言。关闭全员禁言后，群成员将会收到群组事件回调 `AgoraChatGroupManagerDelegate#groupAllMemberMuteChanged`，可在群组中正常发送消息。

示例代码如下：

```objective-c
[[AgoraChatClient sharedClient].groupManager unmuteAllMembersFromGroup:@"groupID"
                                                                                                                                  error:nil];
```

### 监听群组事件

详见 [监听群组事件](./agora_chat_group_ios#监听群组事件)。