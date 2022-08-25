# 群组-创建和管理群组及监听器介绍

群组是支持多人沟通的即时通讯系统，本文介绍如何使用即时通讯 IM SDK 在实时互动 app 中创建和管理群组，并实现群组相关功能。

如需查看消息相关内容，参见 [消息管理](https://docs.agora.io/en/agora-chat/agora_chat_message_overview?platform=iOS)。

## 技术原理

即时通讯 IM SDK 提供了 `IAgoraChatGroupManager`, `AgoraChatGroupManagerDelegate`, 和 `AgoraChatGroup` 类，可以实现以下功能：

- 创建、解散群组
- 加入、退出群组
- 获取群组详情
- 获取群成员列表
- 获取群组列表
- 屏蔽、解除屏蔽群消息
- 监听群组事件

## 前提条件

开始前，请确保满足以下条件：

- 完成 SDK 初始化，详见 [iOS 入门](https://docs.agora.io/en/agora-chat/agora_chat_get_started_ios?platform=iOS)。
- 了解即时通讯 IM 的 [使用限制](https://docs.agora.io/en/agora-chat/agora_chat_limitation?platform=iOS)。
- 了解群组和群成员的数量限制，详见 [套餐包详情](https://docs.agora.io/en/agora-chat/agora_chat_plan?platform=iOS)。

## 实现方法

本节介绍如何使用即时通讯 IM SDK 提供的 API 实现上述功能。

### 创建群组

在创建群组前，你需要设置群组类型（`AgoraChatGroupStyle`）和进群邀请是否需要对方同意 (`IsInviteNeedConfirm`)。

1、私有群不可被搜索到，公开群可以通过 ID 搜索到。目前支持四种群组类型（`AgoraChatGroupStyle`），具体设置如下：

- AgoraChatGroupStylePrivateOnlyOwnerInvite——私有群，只有群主和管理员可以邀请人进群；
- AgoraChatGroupStylePrivateMemberCanInvite——私有群，所有群成员均可以邀请人进群；
- AgoraChatGroupStylePublicJoinNeedApproval——公开群，加入此群除了群主和管理员邀请，只能通过申请加入此群；
- AgoraChatGroupStylePublicOpenJoin ——公开群，任何人都可以进群，无需群主和群管理同意。

2、进群邀请是否需要对方同意 (`IsInviteNeedConfirm`) 的具体设置如下：

- 进群邀请需要用户确认(`IsInviteNeedConfirm` 设置为 `true`)。创建群组并发出邀请后，根据受邀用户的 `isAutoAcceptGroupInvitation` 设置，处理逻辑如下：
  - 用户设置自动接受群组邀请 (`isAutoAcceptGroupInvitation` 设置为 `true`)。受邀用户自动进群并收到 `AgoraChatGroupManagerDelegate#didJoinGroup` 回调，群主收到 `AgoraChatGroupManagerDelegate#onInvitationAccepted` 回调和 `AgoraChatGroupManagerDelegate#userDidJoinGroup` 回调，其他群成员收到 `AgoraChatGroupChangeListener#userDidJoinGroup` 回调。
  - 用户设置手动确认群组邀请 (`isAutoAcceptGroupInvitation` 设置为 `true`)，受邀用户收到 `AgoraChatGroupManagerDelegate#onInvitationReceived` 回调，并选择同意或拒绝入群邀请：
     - 用户同意入群邀请后，群主收到 `AgoraChatGroupManagerDelegate#onInvitationAccepted` 回调和 `AgoraChatGroupManagerDelegate#onMemberJoined` 回调；其他群成员收到 `AgoraChatGroupManagerDelegate#userDidJoinGroup` 回调；
     - 用户拒绝入群邀请后，群主收到 `AgoraChatGroupManagerDelegate#onInvitationDeclined` 回调。
- 进群邀请无需用户确认 (`IsInviteNeedConfirm` 设置为 `false`)。创建群组并发出邀请后，无视用户的 `isAutoAcceptGroupInvitation` 设置，受邀用户直接进群。用户收到 `AgoraChatGroupManagerDelegate#didJoinGroup` 回调；群主收到每个已加入成员对应的群组事件回调 `AgoraChatGroupManagerDelegate#groupInvitationDidAccept` 和 `AgoraChatGroupManagerDelegate#userDidJoinGroup`；先加入的群成员会收到群组事件回调 `AgoraChatGroupManagerDelegate#userDidJoinGroup`。

用户可以调用 `createGroup` 方法创建群组，并通过 `AgoraChatGroupOptions` 参数设置群组名称、群组描述、群组成员和建群原因。

用户加入群组后，将可以收到群消息。

示例代码如下：

```objective-c
AgoraChatGroupOptions *options = [[AgoraChatGroupOptions alloc] init];
// 设置群组最大成员数量。
options.maxUsersCount = self.maxMemNum;
// 设置 `IsInviteNeedConfirm` 为 `YES`，则邀请用户入群需要用户确认。
options.IsInviteNeedConfirm = YES;
// 设置群组类型。此处示例为成员可以邀请用户入群的私有群组。
options.style = AgoraChatGroupStylePrivateMemberCanInvite;
NSArray *members = @{@"memeber1",@"member2"};
// 调用 `createGroupWithSubject` 创建群组。
[[AgoraChatClient sharedClient].groupManager createGroupWithSubject:@"subject"
                                                                                                             description:@"description"
                                                                                                                      invitees:members
                                                                                                                         message:@"message"
                                                                                                                         setting:options
                                                                                                                             error:nil];
```

注：如果 `options.IsInviteNeedConfirm` 设置为 `false`，即直接加被邀请人进群。在此情况下，被邀请人设置非自动进群是不起作用的。

### 用户申请入群

根据 [创建群组](agora_chat_group_ios.md#创建群组) 时的群组类型 (`AgoraChatGroupStyle`) 设置，加入群组的处理逻辑差别如下：

- 当群组类型为 `AgoraChatGroupStylePublicOpenJoin` 时，用户直接加入群组，无需群主和群管理员同意；加入群组后，其他群成员收到 `AgoraChatGroupManagerDelegate#userDidJoinGroup` 回调。
- 当群组类型为 `AgoraChatGroupStylePublicJoinNeedApprova`，群主和群管理员收到 `AgoraChatGroupManagerDelegate#joinGroupRequestDidReceive` 回调，并选择同意或拒绝入群申请：
    - 群主和群管理员同意入群申请，申请人收到群组事件回调 `AgoraChatGroupManagerDelegate#joinGroupRequestDidApprove`；
    - 其他群成员会收到群组事件回调 `AgoraChatGroupManagerDelegate#userDidJoinGroup`。 第二种情况：群主和群管理员拒绝入群申请，申请人会收到群组事件回调 `AgoraChatGroupManagerDelegate#joinGroupRequestDidDecline`。

**注意**

用户只能申请加入公开群组，私有群组不支持用户申请入群。

用户申请加入群组步骤如下：

1. 调用 `getPublicGroupsFromServer` 方法从服务器获取公开群列表，查询到想要加入的群组 ID。

2. 调用 `joinPublicGroup` 方法传入群组 ID，申请加入对应群组。

示例代码如下：


```objective-c
// 从服务器获取公开群组列表
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

// 申请加入群组
[[AgoraChatClient sharedClient].groupManager joinPublicGroup:@"groupID" error:nil];
```

### 解散群组

**注意**

该操作只能群主才能进行。该操作是危险操作，解散群组后，将删除本地数据库及内存中的群相关信息及群会话。

示例代码如下：

```objective-c
// 群组解散后，群成员将会收到 `AgoraChatGroupManagerDelegate#didLeaveGroup` 回调。
// 调用 `destroyGroup` 解散群组，解散后所有群组成员将收到 `didLeaveGroup` 回调。
[[AgoraChatClient sharedClient].groupManager destroyGroup:@"groupID"];
```

### 退出群组

群成员可以调用 `leaveGroup` 方法退出群组，其他成员将会收到群组事件回调 `AgoraChatGroupManagerDelegate#didLeaveGroup`。

退出群组后，该用户将不再收到群消息。群主不能调用该接口退出群组，只能调用 `destroyGroup` 解散群组。

示例代码如下：

```objective-c
[[AgoraChatClient sharedClient].groupManager leaveGroup:@"groupID" error:nil];
```

### 获取群组详情

群成员可以调用 `aGroup.adminList` 方法从内存获取群组详情。返回结果包括：群组 ID、群组名称、群组描述、群组基本属性、群主、群组管理员列表，默认不包含群成员。

群成员也可以调用 `getGroupSpecificationFromServerWithId` 方法从服务器获取群组详情。返回结果包括：群组 ID、群组名称、群组描述、群组基本属性、群主、群组管理员列表。另外，若设置 `fetchMembers` 为 `true`，获取群组详情时同时获取群成员，默认获取最大数量为 200。

```objective-c
// 原型
- (void)getGroupSpecificationFromServerWithId:(NSString *)aGroupId
                                   fetchMembers:(BOOL)fetchMembers
                                   completion:(void (^)(AgoraChatGroup *aGroup, AgoraChatError *aError))aCompletionBlock;

// 根据群组 ID 从服务器获取群组详情。
[[AgoraChatClient sharedClient].groupManager getGroupSpecificationFromServerWithId:self.group.groupId fetchMembers:YES completion:^(EMGroup *aGroup, AgoraChatError *aError) {
    if (!aError) {
        // AgoraChatGroup 中包含了很多群组属性，比如群组 ID，群组成员，是否屏蔽群组消息(isBlocked 属性)等，具体到 SDK 中 AgoraChatGroup.h 头文件查看。
        NSLog(@"获取群组详情成功");
    } else {
        NSLog(@"获取群组详情失败的原因 --- %@", aError.errorDescription);
    }
}];


// 根据群组 ID 从本地获取群组详情。
NSArray *admins = aGroup.adminList;
```

### 获取群成员列表

群成员可以调用 `getGroupMemberListFromServerWithId` 方法从服务器分页获取群成员列表。

- 可通过分页获取群成员：

```objective-c
NSMutableArray *memberList = [[NSMutableArray alloc]init];
NSInteger pageSize = 50;
NSString *cursor = nil;
AgoraChatCursorResult *result = [[AgoraChatCursorResult alloc]init];
do {
  result = [[AgoraChatClient sharedClient].groupManager
                            getGroupMemberListFromServerWithId:@"groupID"
                                                                                    cursor:cursor
                                                                                pageSize:pageSize
                                                                                     error:nil];
  [memberList addObjectsFromArray:result.list];
  cursor = result.cursor;
} while (result && result.list < pageSize);
```

- 群成员少于 200 人时，也可以调用 `getGroupSpecificationFromServerWithId` 获取聊天群成员列表。

```objective-c
// 第二个参数传入 TRUE，默认取 200 人的群成员列表。
AgoraChatGroup *group = [[AgoraChatClient sharedClient].groupManager
                                 getGroupSpecificationFromServerWithId:@"groupID"
                                                                          fetchMembers:YES
                                                                                                 error:nil];
NSArray *memeberList = [group.memberList];
```

### 获取群组列表

用户可以调用 `getJoinedGroupsFromServer` 方法从服务器获取自己加入和创建的群组列表。示例代码如下：

```objective-c
NSArray *groupList = [[AgoraChatClient sharedClient].groupManager
                                     getJoinedGroupsFromServerWithPage:nil
                                                                                      pageSize:-1
                                                                                         error:nil];
```

- 用户可以调用 `getJoinedGroups` 方法加载本地群组列表。为了保证数据的正确性，需要先从服务器获取自己加入和创建的群组列表。示例代码如下：

```objective-c
NSArray *groupList = [[AgoraChatClient sharedClient].groupManager getJoinedGroups];
```

- 用户还可以调用 `getPublicGroupsFromServerWithCursor` 方法分页获取公开群列表：

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

### 屏蔽和解除屏蔽群消息

#### 屏蔽群消息

群成员可以调用 `blockGroup` 方法屏蔽群消息。屏蔽群消息后，该成员不再从指定群组接收群消息，群主和群管理员不能进行此操作。示例代码如下：

```objective-c
[[AgoraChatClient sharedClient].groupManager blockGroup:@"groupID"error:nil];

```

#### 解除屏蔽群

群成员可以调用 `unblockGroup` 方法解除屏蔽群消息。示例代码如下：

```objective-c
[[AgoraChatClient sharedClient].groupManager unblockGroup:@"groupID" error:nil];
```

#### 检查是否已经屏蔽群消息

群成员可以通过 `AgoraChatGroup#isBlocked` 检查用户是否屏蔽了该群的群消息。使用此方法检查时，为了保证结果的准确性，需要先从服务器获取群详情，即调用 `AgoraChatGroup#getGroupSpecificationFromServerWithId`。

### 监听群组事件

可通过 `AgoraChatGroupManagerDelegate` 类中的提供的监听接口，获取群组中的事件。如果不再使用该监听，需要移除，防止出现内存泄漏。

示例代码如下：

```objective-c
// 添加代理。
- (void)viewDidLoad
{
    [super viewDidLoad];
    [[AgoraChatClient sharedClient].groupManager addDelegate:self delegateQueue:nil];
}
// 移除代理。
- (void)dealloc
{
    [[AgoraChatClient sharedClient].groupManager removeDelegate:self];
}
```

群组事件如下：

```objective-c
// 用户收到进群邀请
- (void)groupInvitationDidReceive:(NSString *)aGroupId inviter:(NSString *)aInviter message:(NSString *)aMessage

// 群主或群管理员收到进群申请
- (void)joinGroupRequestDidReceive:(AgoraChatGroup *)aGroup user:(NSString *)aUsername reason:(NSString *)aReason

// 群主或群管理员同意用户的进群申请
- (void)joinGroupRequestDidApprove:(AgoraChatGroup *)aGroup

// 群主或群管理员拒绝用户的进群申请
- (void)joinGroupRequestDidDecline:(NSString *)aGroupId reason:(NSString *)aReason

// 用户同意进群邀请
- (void)groupInvitationDidAccept:(AgoraChatGroup *)aGroup invitee:(NSString *)aInvitee

// 用户拒绝进群邀请
- (void)groupInvitationDidDecline:(AgoraChatGroup *)aGroup invitee:(NSString *)aInvitee reason:(NSString *)aReason

// 有用户自动同意加入群组
- (void)didJoinGroup:(AgoraChatGroup *)aGroup inviter:(NSString *)aInviter message:(NSString *)aMessage

// 有成员被加入群组禁言列表
- (void)groupMuteListDidUpdate:(AgoraChatGroup *)aGroup addedMutedMembers:(NSArray *)aMutedMembers muteExpire:(NSInteger)aMuteExpire

// 有成员被移出禁言列表
- (void)groupMuteListDidUpdate:(AgoraChatGroup *)aGroup removedMutedMembers:(NSArray *)aMutedMembers

// 有成员被加入群组白名单
- (void)groupWhiteListDidUpdate:(AgoraChatGroup *)aGroup addedWhiteListMembers:(NSArray *)aMembers

// 有成员被移出群组白名单
- (void)groupWhiteListDidUpdate:(AgoraChatGroup *)aGroup removedWhiteListMembers:(NSArray *)aMembers

// 全员禁言状态变化
- (void)groupAllMemberMuteChanged:(AgoraChatGroup *)aGroup isAllMemberMuted:(BOOL)aMuted

// 群组新增管理员
- (void)groupAdminListDidUpdate:(AgoraChatGroup *)aGroup addedAdmin:(NSString *)aAdmin

// 有群组管理员被移除权限
- (void)groupAdminListDidUpdate:(AgoraChatGroup *)aGroup removedAdmin:(NSString *)aAdmin

// 群主转移权限
- (void)groupOwnerDidUpdate:(AgoraChatGroup *)aGroup newOwner:(NSString *)aNewOwner oldOwner:(NSString *)aOldOwner

// 有新成员加入群组
- (void)userDidJoinGroup:(AgoraChatGroup *)aGroup user:(NSString *)aUsername

// 有成员主动退出群
- (void)userDidLeaveGroup:(AgoraChatGroup *)aGroup user:(NSString *)aUsername

// 群组公告更新
- (void)groupAnnouncementDidUpdate:(AgoraChatGroup *)aGroup announcement:(NSString *)aAnnouncement

// 有成员新上传群组共享文件
- (void)groupFileListDidUpdate:(AgoraChatGroup *)aGroup addedSharedFile:(AgoraChatGroupSharedFile *)aSharedFile

// 群组共享文件被删除
- (void)groupFileListDidUpdate:(AgoraChatGroup *)aGroup removedSharedFile:(NSString *)aFileId

// 群组详情变更
- (void)groupSpecificationDidUpdate:(NSString *)aGroupId
```