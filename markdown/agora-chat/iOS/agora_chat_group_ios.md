群组是支持多人沟通的即时通讯系统。本文介绍如何使用即时通讯 IM SDK 在实时互动 app 中创建和管理群组，并实现群组相关功能。

## 技术原理

即时通讯 IM SDK 提供 `IAgoraChatGroupManager`、`AgoraChatGroupManagerDelegate` 和 `AgoraChatGroup` 类，可以实现以下功能：

- 创建、解散群组
- 加入、退出群组
- 获取群组详情
- 获取群成员列表
- 获取群组列表
- 屏蔽和解除屏蔽群消息
- 监听群组事件

## 前提条件

开始前，请确保满足以下条件：

- 完成 SDK 初始化，详见 [iOS 快速开始](./agora_chat_get_started_ios)。
- 了解即时通讯 IM 的 [使用限制](./agora_chat_limitation)。
- 了解群组和群成员的数量限制，详见 [套餐包详情](./agora_chat_plan)。

## 实现方法

本节介绍如何使用即时通讯 IM SDK 提供的 API 实现上述功能。

### 创建群组

用户可以创建群组，并设置群组的名称、描述、群组成员、创建群组的原因等属性。用户还可以设置 `AgoraChatGroupOptions` 参数指定群组的大小和类型。创建群组后，群组创建者自动成为群主。

创建群组前，你需要设置群组的类型（`AgoraChatGroupStyle`）和邀请进群是否需要对方同意（`IsInviteNeedConfirm`）。其中：

- 群组类型（`AgoraChatGroupStyle`）可以设置为如下值：

  - `GroupStylePrivateOnlyOwnerInvite`——私有群，只有群主和管理员可以邀请人进群；
  - `GroupStylePrivateMemberCanInvite`——私有群，所有群成员均可以邀请人进群；
  - `GroupStylePublicJoinNeedApproval`——公开群，申请人通过群主和群管理同意后才能进群；
  - `GroupStylePublicOpenJoin`——公开群，任何人都可以进群，无需群主和群管理同意。

- 邀请进群是否需要对方同意（`AgoraChatGroupOptions#IsInviteNeedConfirm`）

公开群只支持群主和管理员邀请用户入群。对于私有群，除了群主和群管理员，群成员是否也能邀请其他用户进群取决于群组类型 `AgoraChatGroupStyle` 的设置。

邀请入群是否需受邀用户确认取决于群组选项 `AgoraChatGroupOptions#IsInviteNeedConfirm` 和受邀用户的参数 `isAutoAcceptGroupInvitation` 的设置，前者的优先级高于后者，即若 `AgoraChatGroupOptions#IsInviteNeedConfirm` 设置为 `false`，不论 `isAutoAcceptGroupInvitation` 设置为何值，受邀用户无需确认直接进群。

1. 受邀用户无需确认，直接进群。

以下两种设置的情况下，用户直接进群：

- 若 `AgoraChatGroupOptions#IsInviteNeedConfirm` 设置为 `false`，不论 `isAutoAcceptGroupInvitation` 设置为 `false` 或 `true`，受邀用户均无需确认，直接进群。
- 若 `AgoraChatGroupOptions#IsInviteNeedConfirm` 和 `isAutoAcceptGroupInvitation` 均设置为 `true`，用户自动接受群组邀请，直接进群。

受邀用户直接进群，会收到如下回调：

- 新成员会收到 `AgoraChatGroupManagerDelegate#didJoinGroup` 回调；
- 邀请人收到 `AgoraChatGroupManagerDelegate#onInvitationAccepted` 回调和 `AgoraChatGroupManagerDelegate#userDidJoinGroup` 回调；
- 其他群成员收到 `AgoraChatGroupChangeListener#userDidJoinGroup` 回调。

2. 受邀用户需要确认才能进群。

只有 `AgoraChatGroupOptions#IsInviteNeedConfirm` 设置为 `true` 和 `isAutoAcceptGroupInvitation` 设置为 `false` 时，受邀用户需要确认才能进群。这种情况下，受邀用户收到 `AgoraChatGroupManagerDelegate#onInvitationReceived` 回调，并选择同意或拒绝进群邀请：

- 用户同意入群邀请后，邀请人收到 `AgoraChatGroupManagerDelegate#onInvitationAccepted` 回调和 `AgoraChatGroupManagerDelegate#onMemberJoined` 回调；其他群成员收到 `AgoraChatGroupManagerDelegate#userDidJoinGroup` 回调；
- 用户拒绝入群邀请后，邀请人收到 `AgoraChatGroupManagerDelegate#onInvitationDeclined` 回调。

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
NSArray *members = @{@"member1",@"member2"};
// 调用 `createGroupWithSubject` 创建群组。
[[AgoraChatClient sharedClient].groupManager createGroupWithSubject:@"subject"
                                                                                                             description:@"description"
                                                                                                                      invitees:members
                                                                                                                         message:@"message"
                                                                                                                         setting:options
                                                                                                                             error:nil];
```

### 用户申请入群

根据 [创建群组](agora_chat_group_ios.md#创建群组) 时的群组类型 (`AgoraChatGroupStyle`) 设置，加入群组的处理逻辑差别如下：

- 当群组类型为 `AgoraChatGroupStylePublicOpenJoin` 时，用户直接加入群组，无需群主和群管理员同意；加入群组后，其他群成员收到 `AgoraChatGroupManagerDelegate#userDidJoinGroup` 回调。
- 当群组类型为 `AgoraChatGroupStylePublicJoinNeedApproval`，群主和群管理员收到 `AgoraChatGroupManagerDelegate#joinGroupRequestDidReceive` 回调，并选择同意或拒绝入群申请：
    - 群主和群管理员同意入群申请，申请人收到群组事件回调 `AgoraChatGroupManagerDelegate#joinGroupRequestDidApprove`；其他群成员会收到群组事件回调 `AgoraChatGroupManagerDelegate#userDidJoinGroup`。
    - 群主和群管理员拒绝入群申请，申请人会收到群组事件回调 `AgoraChatGroupManagerDelegate#joinGroupRequestDidDecline`。

<div class="alert note">用户只能申请加入公开群组，私有群组不支持用户申请入群。</div>

用户申请加入群组步骤如下：

1. 调用 `getPublicGroupsFromServerWithCursor` 方法从服务器获取公开群列表，查询到想要加入的群组 ID。

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

只有群主可调用 `destroyGroup` 方法解散群组。群组解散后，群成员会收到 `AgoraChatGroupManagerDelegate#didLeaveGroup` 回调。

<div class="alert note">该操作只能群主才能进行。该操作是危险操作，解散群组后，将删除本地数据库及内存中的群相关信息及群会话。</div>

示例代码如下：

```objective-c
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

群成员可以调用 `getGroupSpecificationFromServerWithId` 方法从服务器获取群组详情。返回结果包括群组 ID、群组名称、群组描述、群组基本属性、群主、群组管理员列表、是否已屏蔽群组消息以及群组是否禁用。另外，若设置 `fetchMembers` 为 `true`，可获取群成员列表，默认最多包括 200 个成员。

```objective-c
// 原型
- (void)getGroupSpecificationFromServerWithId:(NSString *)aGroupId
                                   fetchMembers:(BOOL)fetchMembers
                                   completion:(void (^)(AgoraChatGroup *aGroup, AgoraChatError *aError))aCompletionBlock;

// 根据群组 ID 从服务器获取群组详情。
[[AgoraChatClient sharedClient].groupManager getGroupSpecificationFromServerWithId:self.group.groupId fetchMembers:YES completion:^(EMGroup *aGroup, AgoraChatError *aError) {
    if (!aError) {
        // AgoraChatGroup 类中包含很多群组属性，例如群组 ID、群组名称和是否屏蔽了群组消息(isBlocked 属性)等，详见 SDK 中的 AgoraChatGroup.h 头文件查看。
        NSLog(@"获取群组详情成功");
    } else {
        NSLog(@"获取群组详情失败的原因 --- %@", aError.errorDescription);
    }
}];


// 获取群组管理员列表。
NSArray *admins = aGroup.adminList;
...
```

### 获取群成员列表

群成员可以调用 `getGroupMemberListFromServerWithId` 方法从服务器分页获取群成员列表。

- 当群成员数量大于等于 200 时，可分页获取群成员列表：

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

- 当群成员少于 200 人时，也可以调用 `getGroupSpecificationFromServerWithId` 获取聊天群成员列表。

```objective-c
// 第二个参数传入 TRUE，默认取 200 人的群成员列表。
AgoraChatGroup *group = [[AgoraChatClient sharedClient].groupManager
                                 getGroupSpecificationFromServerWithId:@"groupID"
                                                                          fetchMembers:YES
                                                                                                 error:nil];
NSArray *memberList = [group.memberList];
```

### 获取群组列表

用户可以调用 `getJoinedGroupsFromServer` 方法从服务器获取自己创建和加入的群组列表。示例代码如下：

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

群成员可以调用 `blockGroup` 方法屏蔽群消息。屏蔽群消息后，该成员不再从指定群组接收群消息，群主和群管理员不能进行此操作。

示例代码如下：

```objective-c
[[AgoraChatClient sharedClient].groupManager blockGroup:@"groupID"error:nil];
```

#### 解除屏蔽群消息

群成员可以调用 `unblockGroup` 方法解除屏蔽群消息。示例代码如下：

```objective-c
[[AgoraChatClient sharedClient].groupManager unblockGroup:@"groupID" error:nil];
```

#### 检查是否已经屏蔽群消息

群成员可以通过 `AgoraChatGroup#isBlocked` 检查用户是否屏蔽了该群的消息。使用此方法检查时，为了保证检查结果的准确性，调用该方法前需先从服务器获取群详情，即调用 `AgoraChatGroup#getGroupSpecificationFromServerWithId`。

### 监听群组事件

为了监听群组事件，用户可以监听 `AgoraChatGroupManager` 中的回调，并添加相应的应用逻辑。如果不再使用该监听，需要移除，防止出现内存泄漏。

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
// 用户收到入群邀请。
- (void)groupInvitationDidReceive:(NSString *)aGroupId inviter:(NSString *)aInviter message:(NSString *)aMessage;

// 群主或群管理员收到进群申请。
- (void)joinGroupRequestDidReceive:(AgoraChatGroup *)aGroup user:(NSString *)aUsername reason:(NSString *)aReason;

// 群主或群管理员同意用户的进群申请。申请人收到该事件。
- (void)joinGroupRequestDidApprove:(AgoraChatGroup *)aGroup;

// 群主或群管理员拒绝用户的进群申请。申请人收到该事件。
- (void)joinGroupRequestDidDecline:(NSString *)aGroupId reason:(NSString *)aReason;

// 用户同意进群邀请。邀请人收到该事件。
- (void)groupInvitationDidAccept:(AgoraChatGroup *)aGroup invitee:(NSString *)aInvitee;

// 用户拒绝进群邀请。邀请人收到该事件。
- (void)groupInvitationDidDecline:(AgoraChatGroup *)aGroup invitee:(NSString *)aInvitee reason:(NSString *)aReason;

// 有用户自动同意加入群组。邀请人收到该事件。
- (void)didJoinGroup:(AgoraChatGroup *)aGroup inviter:(NSString *)aInviter message:(NSString *)aMessage;

// 有成员被加入群组禁言列表。被禁言的成员及群主和群管理员（除操作者外）会收到该事件。
- (void)groupMuteListDidUpdate:(AgoraChatGroup *)aGroup addedMutedMembers:(NSArray *)aMutedMembers muteExpire:(NSInteger)aMuteExpire;

// 有成员被移出禁言列表。被解除禁言的成员及群主和群管理员（除操作者外）会收到该事件。
- (void)groupMuteListDidUpdate:(AgoraChatGroup *)aGroup removedMutedMembers:(NSArray *)aMutedMembers;

// 有成员被加入群组白名单。被添加的成员及群主和群管理员（除操作者外）会收到该事件。
- (void)groupWhiteListDidUpdate:(AgoraChatGroup *)aGroup addedWhiteListMembers:(NSArray *)aMembers;

// 有成员被移出群组白名单。被移出的成员及群主和群管理员（除操作者外）会收到该事件。
- (void)groupWhiteListDidUpdate:(AgoraChatGroup *)aGroup removedWhiteListMembers:(NSArray *)aMembers;

// 全员禁言状态变化。群组所有成员（除操作者外）会收到该事件。
- (void)groupAllMemberMuteChanged:(AgoraChatGroup *)aGroup isAllMemberMuted:(BOOL)aMuted;

// 群组新增管理员。群主、新管理员和其他管理员会收到该事件。
- (void)groupAdminListDidUpdate:(AgoraChatGroup *)aGroup addedAdmin:(NSString *)aAdmin;

// 群组管理员被移除。被移出的成员及群主和群管理员（除操作者外）会收到该事件。
- (void)groupAdminListDidUpdate:(AgoraChatGroup *)aGroup removedAdmin:(NSString *)aAdmin;

// 群主转移权限。原群主和新群主会收到该事件。
- (void)groupOwnerDidUpdate:(AgoraChatGroup *)aGroup newOwner:(NSString *)aNewOwner oldOwner:(NSString *)aOldOwner;

// 有新成员加入群组。除了新成员，其他群成员会收到该事件。
- (void)userDidJoinGroup:(AgoraChatGroup *)aGroup user:(NSString *)aUsername;

// 有成员主动退出群。除了退群的成员，其他群成员会收到该事件。
- (void)userDidLeaveGroup:(AgoraChatGroup *)aGroup user:(NSString *)aUsername;

// 有成员被移出群组。被移出的成员收到该事件。
- (void)didLeaveGroup:(AgoraChatGroup *_Nonnull)aGroup reason:(AgoraChatGroupLeaveReason)aReason;

// 群组公告更新。群组所有成员会收到该事件。
- (void)groupAnnouncementDidUpdate:(AgoraChatGroup *)aGroup announcement:(NSString *)aAnnouncement;

// 有成员新上传群组共享文件。群组所有成员会收到该事件。
- (void)groupFileListDidUpdate:(AgoraChatGroup *)aGroup addedSharedFile:(AgoraChatGroupSharedFile *)aSharedFile;

// 群组共享文件被删除。群组所有成员会收到该事件。
- (void)groupFileListDidUpdate:(AgoraChatGroup *)aGroup removedSharedFile:(NSString *)aFileId;

// 群组详情变更。群组所有成员会收到该事件。
- (void)groupSpecificationDidUpdate:(NSString *)aGroupId;
```