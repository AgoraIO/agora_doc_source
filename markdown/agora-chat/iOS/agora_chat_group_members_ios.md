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

用户进群分为两种方式：主动申请入群和群成员邀请入群。

公开群和私有群在两种入群方式方面存在差别：

| 入群方式         | 公开群       | 私有群            |
| :------------- | :-------------- | :------------ |
| 是否支持用户申请入群       | 支持 <br/>任何用户均可申请入群，是否需要群主和群管理员审批，取决于群组类型 `AgoraChatGroupStyle` 的设置。 | 不支持     |
| 是否支持群成员邀请用户入群 | 支持 <br/>只能由群主和管理员邀请。    | 支持 <br/>除了群主和群管理员，群成员是否也能邀请其他用户进群取决于群组类型 `AgoraChatGroupStyle` 的设置。 |

#### 用户申请入群

只有公开群支持用户申请入群，私有群不支持。用户可获取公开群列表，选择相应的群组 ID，然后调用相应方法加入该群组。

任何用户均可申请入群，是否需要群主和群管理员审批，取决于群组类型（`AgoraChatGroupStyle`）的设置：

- `AgoraChatGroupStyle` 为 `AgoraChatGroupStylePublicJoinNeedApproval` 时，群主和群管理员审批后，用户才能加入群组；
- `AgoraChatGroupStyle` 为 `AgoraChatGroupStylePublicOpenJoin` 时，用户可直接加入群组，无需群主和群管理员审批。

若申请加入公开群，申请人需执行以下步骤：

1. 调用 `getPublicGroupsFromServerWithCursor` 方法从服务器获取公开群列表，查询到想要加入的群组 ID。示例代码如下：

```objective-c
NSMutableArray *memberList = [[NSMutableArray alloc]init];
NSInteger pageSize = 50;
NSString *cursor = nil;
AgoraChatCursorResult *result = [[AgoraChatCursorResult alloc]init];
do {
  result = [[AgoraChatClient sharedClient].groupManager
                         getPublicGroupsFromServerWithCursor:cursor
                                                                                pageSize:50
                                                                                     error:nil];
  [memberList addObjectsFromArray:result.list];
  cursor = result.cursor;
} while (result && result.list < pageSize);
```

2. 调用 `joinPublicGroup` 或 `requestToJoinPublicGroup` 方法传入群组 ID，申请加入对应群组。

   1. 调用 `joinPublicGroup` 方法加入无需群主或管理员审批的公开群，即 `AgoraChatGroupStyle` 为 `AgoraChatGroupStylePublicOpenJoin` 。申请人不会收到任何回调，其他群成员会收到 `AgoraChatGroupManagerDelegate#userDidJoinGroup` 回调。

   示例代码如下：

   ```objective-c
   [[AgoraChatClient sharedClient].groupManager joinPublicGroup:@"groupId" completion:^(AgoraChatGroup *aGroup, AgoraChatError *aError) {
    }];
   ```

   2. 调用 `requestToJoinPublicGroup` 方法加入需要群主或管理员审批的公共群组，即`AgoraChatGroupStyle` 为 `AgoraChatGroupStylePublicJoinNeedApproval`。示例代码如下：

    ```objective-c
    // 异步方法
    [[AgoraChatClient sharedClient].groupManager requestToJoinPublicGroup:@"groupId"  message:nil completion:^(AgoraChatGroup *aGroup1, AgoraChatError *aError) {
    }];
    ```
    
   群主或群管理员收到 `AgoraChatGroupManagerDelegate#joinGroupRequestDidReceive` 回调：

   - 若同意加入群组，需要调用 `approveJoinGroupRequest` 方法。

   申请人会收到 `AgoraChatGroupManagerDelegate#joinGroupRequestDidApprove` 回调，其他群成员会收到 `AgoraChatGroupManagerDelegate#userDidJoinGroup` 回调。

   示例代码如下：

  ```objective-c
   [[AgoraChatClient sharedClient].groupManager approveJoinGroupRequest:@"groupId" sender:@"userId" completion:^(AgoraChatGroup *aGroup, AgoraChatError *aError) {
        
  }];
   ```

   - 若群主或群管理员拒绝申请人入群，需要调用 `declineJoinApplication` 方法。申请人会收到 `AgoraChatGroupManagerDelegate#joinGroupRequestDidDecline` 回调。

   示例代码如下：

   ```objective-c
   // 异步方法
   [[AgoraChatClient sharedClient].groupManager declineJoinGroupRequest:@"groupId" sender:@"userId" reason:@"reason" completion:^(AgoraChatGroup *aGroup, AgoraChatError *aError) {
           
    }];
   ```

#### 邀请用户入群

邀请用户入群的方式详见 [邀请用户入群的配置](./agora_chat_group_ios#创建群组)。

邀请用户入群流程如下：

1. 群成员邀请用户入群。

   - 群主或群管理员可以邀请人入群，对于私有群 `AgoraChatGroupStyle` 设置为 `AgoraChatGroupStylePrivateMemberCanInvite` 时，普通群成员也可以邀请人进群。邀请人入群需要调用 `addMembers` 方法：

   ```objective-c
   // 异步方法
   [[AgoraChatClient sharedClient].groupManager addMembers:@{@"member1",@"member2"}
                         toGroup:@"groupID"
                         message:@"message"
                         completion:nil];
   ```AgoraChatError

2. 受邀用户自动进群或确认是否加入群组：

   - 受邀用户同意加入群组，需要调用 `acceptInvitationFromGroup` 方法。

   ```objective-c
   [[AgoraChatClient sharedClient].groupManager acceptInvitationFromGroup:@"groupId" inviter:@"userId" completion:^(AgoraChatGroup *aGroup, AgoraChatError *aError) {
   };
   ```

   - 受邀人拒绝入群组，需要调用 `declineInvitationFromGroup` 方法。

   ```objective-c
   [[AgoraChatClient sharedClient].groupManager declineGroupInvitation:@"groupId" inviter:@"inviter" reason:@"reason" completion:^(AgoraChatError *aError) {
         
   }];
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