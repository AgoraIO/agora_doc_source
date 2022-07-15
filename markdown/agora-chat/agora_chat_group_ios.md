群组是支持多人沟通的即时通讯系统，本文指导你如何使用 Agora Chat SDK 在实时互动 app 中创建群组并管理群组和群组成员。

## 技术原理

Agora Chat SDK 提供 `IAgoraChatGroupManager`、`AgoraChatGroupManagerDelegate` 和 `AgoraChatGroup` 类用于群组管理，支持你通过调用 API 在项目中实现如下功能：
- 创建、解散群组
- 加入、退出群组
- 获取群成员列表、已加入群组列表
- 屏蔽及取消屏蔽群消息
- 管理群成员
- 管理群组属性、群公告及群共享文件

## 前提条件

开始前，请确保你的项目满足以下条件：

- 已完成 SDK 初始化。详见[实现发送和接收消息](agora_chat_get_started_ios)。
- 了解 Agora Chat API 的接口调用频率限制。详见[限制条件](agora_chat_limitation_ios)。
- 了解群组和群成员数量限制。详见[套餐包详情](agora_chat_plan)。

## 实现方法

本节介绍如何使用 Agora Chat SDK 提供的 API 实现上述功能。

### 创建与解散群组

创建群组包含如下步骤：

1. 群主调用 `createGroupWithSubject` 方法创建群组，你可以在该方法中设置群组名、群组描述、群组成员、建群原因，并通过 `AgoraChatGroupOptions` 参数设置群组的最大人数及群组类型。
2. 根据被邀请人是否需要确认才能加群的设置，后续的实现逻辑不同：
    - 如果被邀请人设置了需要确认才能加群，则被邀请人会收到 `groupInvitationDidReceive` 回调。如果同意入群，则邀请人会收到 `groupInvitationDidAccept` 回调。被邀请人进群后，所有群组成员会收到 `userDidJoinGroup` 回调；如果被邀请人不同意入群，则邀请人收到 `groupInvitationDidDecline` 回调。
    - 如果被邀请人设置了无需确认直接入群，则被邀请人会收到 `didJoinGroup` 回调。邀请人收到 `groupInvitationDidAccept` 回调。被邀请人进群后，所有群组成员会收到 `userDidJoinGroup` 回调。

创建和解散群组的示例代码如下：

```objective-c
AgoraChatGroupOptions *options = [[AgoraChatGroupOptions alloc] init];
options.maxUsersCount = self.maxMemNum;
// 设置进群需要群组或群管理员确认。如果设为 NO，则被邀请人直接进群，即便该被邀请人设置了非自动进群
options.IsInviteNeedConfirm = YES;
options.style = AgoraChatGroupStylePrivateMemberCanInvite;
NSArray *members = @{@"memeber1",@"member2"};
// 调用 createGroupWithSubject 方法创建群组。成功创建群组后，调用该方法的用户自动成为群组的群主。
[[AgoraChatClient sharedClient].groupManager createGroupWithSubject:@"subject"
 																												description:@"description"
 																													 invitees:members
 																														message:@"message"
 																														setting:options
 																															error:nil];


// 调用 destroyGroup 方法解散群组。解散群组后，本地数据库和内存中的群相关信息和群会话均会消息
// 该方法只有群主才能调用。成功解散群组后，群成员会收到 didLeaveGroup 回调
[[AgoraChatClient sharedClient].groupManager destroyGroup:@"groupID"];
```

### 用户申请入群与退出群组

当群组类型为 `AgoraChatGroupStylePublicOpenJoin` 或 `AgoraChatGroupStylePublicJoinNeedApproval` 时，用户可以申请加入该群。

申请入群的步骤如下：
1. 调用 `getPublicGroupsFromServerWithCursor` 方法获取公开群组列表，并获取想要加入的群组的 ID。
2. 调用 `joinPublicGroup` 方法加入群组：
    - 如果群组类型为 `AgoraChatGroupStylePublicOpenJoin`，则用户可以直接调用 `joinPublicGroup` 加入该群。成功入群后，群组成员会收到 `userDidJoinGroup` 回调
    - 如果群组类型为 `AgoraChatGroupStylePublicJoinNeedApproval`，则群主和群管理员会收到 `joinGroupRequestDidReceive` 回调。群主和群管理员可以同意或拒绝该入群申请。如果同意入群，则申请人收到 `joinGroupRequestDidApprove` 回调；如果拒绝入群，则申请人收到 `joinGroupRequestDidDecline` 回调。

用户申请入群与退出群组的示例代码如下：

```objective-c
// 从服务器获取自己加入或创建的群组列表
NSArray *groupList = [[AgoraChatClient sharedClient].groupManager
                      				 getJoinedGroupsFromServerWithPage:nil 
                      																  pageSize:-1 
                      																     error:nil];

// 获取本地群组列表。为保证数据正确性，需要先调用 getJoinedGroupsFromServerWithPage 获取自己已加入或创建的群组列表
NSArray *groupList = [[AgoraChatClient sharedClient].groupManager getJoinedGroups];

// 分页获取公开群列表
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

// 调用 joinPublicGroup 加入群组
[[AgoraChatClient sharedClient].groupManager joinPublicGroup:@"groupID" error:nil];

// 调用 leaveGroup 退出群组。退出后，该成员不再收到群消息，其他群组成员会收到 didLeaveGroup 回调
[[AgoraChatClient sharedClient].groupManager leaveGroup:@"groupID" error:nil];
```

### 获取群成员列表

你可以通过分页获取群成员。当群成员少于 200 人时，也可以直接调用 `getGroupSpecificationFromServerWithId` 获取群成员。示例代码如下：

```objective-c
// 通过分页获取群成员
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

// 群成员少于 200 人时，也可以使用如下示例代码
AgoraChatGroup *group = [[AgoraChatClient sharedClient].groupManager
                     			getGroupSpecificationFromServerWithId:@"groupID"
                     											         fetchMembers:YES 
                     																			error:nil];
NSArray *memeberList = [group.memberList];
```

### 屏蔽和解除屏蔽群消息

群成员可以屏蔽和解除屏蔽群消息。屏蔽群消息后，该成员将不再接收群消息。示例代码如下：

```objective-c
// 调用 blockGroup 屏蔽群消息
// 只有群成员才可以调用该方法。群主和群管理员不可以
[[AgoraChatClient sharedClient].groupManager blockGroup:@"groupID"error:nil];

// 调用 unblockGroup 解除屏蔽
[[AgoraChatClient sharedClient].groupManager unblockGroup:@"groupID" error:nil];
```

你还可以调用 `isBlocked` 检查用户是否屏蔽了群消息。为保证结果的准确性，你需要先调用 `getGroupSpecificationFromServerWithId` 从服务器获取群组详情。

### 群组加人或踢人

无论是私有群还有公开群，群主和群管理员均可以通过调用 `addMembers` 将用户添加到群组。如果群组类型为 `AgoraChatGroupStylePrivateMemberCanInvite`，则群成员也可以添加其他用户进群。用户成功加入群组后，就可以接收群消息。

群组加人的步骤如下：
1. 群主、群管理员或群成员调用 `addMembers` 方法邀请用户入群
2. 根据被邀请人是否需要确认才能加群的设置，双方逻辑不同：
    - 如果被邀请人设置了需要确认才能加群，则被邀请人会收到 `groupInvitationDidReceive` 回调。如果同意入群，则邀请人会收到 `groupInvitationDidAccept` 回调。被邀请人进群后，所有群组成员会收到 `userDidJoinGroup` 回调；如果被邀请人不同意入群，则邀请人收到 `groupInvitationDidDecline` 回调。
    - 如果被邀请人设置了无需确认直接入群，则被邀请人会收到 `didJoinGroup` 回调。邀请人收到 `groupInvitationDidAccept` 回调。被邀请人进群后，所有群组成员会收到 `userDidJoinGroup` 回调。

群组加人、踢人的示例代码如下：

```objective-c
// 群主、群管理员或群成员调用 addMembers 加人
[[AgoraChatClient sharedClient].groupManager addMembers:@{@"member1",@"member2"}
 																							  toGroup:@"groupID" 
 																								message:@"message" 
 																						 completion:nil];

// 只有群主和群管理员才可以将群成员踢出群组
// 群成员被踢出群组后，会收到 didLeaveGroup 回调，且不会再接收群消息；其他群成员会收到 userDidLeaveGroup 回调
[[AgoraChatClient sharedClient].groupManager removeMembers:@{@"member"}
 																								 fromGroup:@"groupsID" 
 																								completion:nil];
```

### 转让群主、添加和移除群管理员

群主可以将权限移交给群组中指定成员，移交后原群主变为成员，群成员会接收到 `groupOwnerDidUpdate` 回调。

群主还可以添加群管理员。成功添加后，被添加为群管理员的用户和其他管理员会收到 `groupAdminListDidUpdate` 回调。

转让群主、添加和移除群管理员的示例代码如下：

```objective-c
// 群主调用 updateGroupOwner 将群主权限移交给指定群成员
[[AgoraChatClient sharedClient].groupManager updateGroupOwner:@"groupID"
 																										newOwner:@"newOwner"
 																												error:nil];

// 群主调用 addAdmin 添加群管理员
[[AgoraChatClient sharedClient].groupManager addAdmin:@"member" 
 																						  toGroup:@"groupID" 
 																								error:nil];

// 群主调用 removeAdmin 移除管理员权限。被移除群管理的用户和其他管理员会收到 groupAdminListDidUpdate 回调
[[AgoraChatClient sharedClient].groupManager removeAdmin:@"admin" 
 																						   fromGroup:@"groupID" 
 																									 error:nil];
```

### 管理群组黑名单列表

群主及群管理员可以将群组中的指定群成员加入或者移出群黑名单。群成员被加入黑名单后将无法收发群消息，且无法申请再次入群。

添加、移除、获取群组黑名单的示例代码如下：

```objective-c
// 群主或群管理员调用 blockMembers 将指定用户移入黑名单
[[AgoraChatClient sharedClient].groupManager blockMembers:members 
 																								fromGroup:@"groupID" 
 																							 completion:nil];

// 群主或群管理员调用 unblockMembers 将指定用户移出黑名单。移出后，该用户可以再次申请加入群组
[[AgoraChatClient sharedClient].groupManager unblockMembers:members
                                                      fromGroup:@"groupId"
                                                     completion:nil];

// 群主或群管理员可以从服务器获取群组的黑名单列表
[[AgoraChatClient sharedClient].groupManager getGroupBlacklistFromServerWithId:@"groupId" 
 											 pageNumber:pageNumber 
 												 pageSize:pageSize 
 											 completion:nil];
```

### 管理群组禁言列表

为了精细化管理群成员发言，群主和群管理员可以根据情况将指定群成员加入或者移出群禁言列表。群成员被加入群禁言列表后，将不能够发言，即使其被加入群白名单也不能发言。

添加、移除、获取群禁言列表的示例代码如下：

```objective-c
// 群主或群管理员调用 muteMembers 将指定用户加入群禁言列表。被禁言成员和其他未操作的群主或群管理员会收到 groupMuteListDidUpdate 回调
[[AgoraChatClient sharedClient].groupManager muteMembers:members 
 																				muteMilliseconds:60 
 																							 fromGroup:@"groupID" 
 																									 error:nil];

// 群主或群管理员调用 unmuteMembers 将指定用户移出禁言列表。被移出的成员和其他未操作的群主或群管理员会收到 groupMuteListDidUpdate 回调
[[AgoraChatClient sharedClient].groupManager unmuteMembers:members 
 																								 fromGroup:@"groupID" 
 																										 error:nil];

// 群主或群管理员调用 getGroupMuteListFromServerWithId 获取群组禁言列表
[[AgoraChatClient sharedClient].groupManager getGroupMuteListFromServerWithId:@"groupID"
 		 																															pageNumber:pageNumber
 																																		pageSize:pageSize
 																																			 error:nil];
```

为方便快捷管理，Agora Chat 还支持群主和群管理员开启和关闭群组全员禁言。开启群组全员禁言后，除了在群白名单中的群成员，其他成员将不能发言。

开启、关闭全员禁言的示例代码如下：

```objective-c
// 群主或群管理员调用 muteAllMembersFromGroup 开启全员禁言。成功开启后，群成员会收到 groupAllMemberMuteChanged 回调
[[AgoraChatClient sharedClient].groupManager muteAllMembersFromGroup:@"groupID"
 																															 error:nil];

// 群主或群管理员调用 unmuteAllMembersFromGroup 取消全员禁言。成功开启后，群成员会收到 groupAllMemberMuteChanged 回调
[[AgoraChatClient sharedClient].groupManager unmuteAllMembersFromGroup:@"groupID"
 																																 error:nil];
```

### 管理群组白名单列表

白名单用户不受全员禁言限制。但是如果该白名单用户在群禁言列表中，则该用户不能发言。

添加、移除、获取白名单的示例代码如下：

```objective-c
// 群主或群管理员调用 addWhiteListMembers 添加指定成员到白名单。成功添加后，该群成员和其他位操作的群主或群管理员会收到 groupWhiteListDidUpdate 回调
[[AgoraChatClient sharedClient].groupManager addWhiteListMembers:members
 																										   fromGroup:@"groupID" 
 																													 error:nil];

// 群主或群管理员调用 removeWhiteListMembers 将指定成员移除出白名单。成功移除后，该群成员和其他位操作的群主或群管理员会收到 groupWhiteListDidUpdate 回调
[[AgoraChatClient sharedClient].groupManager removeWhiteListMembers:members
 																										      fromGroup:@"groupID" 
 																													    error:nil];

// 群成员可以调用 isMemberInWhiteListFromServerWithGroupId 检查自己是否在白名单中
[[AgoraChatClient sharedClient].groupManager
 																isMemberInWhiteListFromServerWithGroupId:@"groupID"
																																   error:nil];

// 群主或群管理员调用 getGroupWhiteListFromServerWithId 获取群组白名单列表
[[AgoraChatClient sharedClient].groupManager getGroupWhiteListFromServerWithId:@"groupID" 																																				 error:nil];
```

### 修改群组名称或描述

群主或群管理员可以修改群组的名称和描述。示例代码如下：

```objective-c
// 群主或群管理员调用 changeGroupSubject 修改群组名称。群名称长度限制为 128 个字符
[[AgoraChatClient sharedClient].groupManager changeGroupSubject:@"subject"
 																											 forGroup:@"groupID" 
 																												  error:nil];

// 群主或群管理员调用 changeDescription 修改群组描述。群组描述长度限制为 512 个字符
[[AgoraChatClient sharedClient].groupManager changeDescription:@"desc"
 																											forGroup:@"groupID" 
 																										 	   error:nil];
```

### 更新、获取群公告

群主和群管理员可以设置和更新群公告，群成员可以获取群公告。示例代码如下：

```objective-c
// 群主或群管理员调用 updateGroupAnnouncementWithId 设置或更新群公告。成功设置后，所有群组成员收到 groupAnnouncementDidUpdate 回调。群公告长度限制为 512 个字符
[[AgoraChatClient sharedClient].groupManager updateGroupAnnouncementWithId:@"groupID"
 																														 announcement:@"announcement" 
 																										 	   					  error:nil];

// 群成员均可以调用 getGroupAnnouncementWithId 获取群公告
[[AgoraChatClient sharedClient].groupManager getGroupAnnouncementWithId:@"groupID" 
 																																  error:nil];
```

### 上传、删除、获取群共享文件

所有群组成员都可以上传和获取群共享文件。只有群主和群管理员才能删除全部群共享文件，群成员只能删除自己上传的群文件。示例代码如下：

```objective-c
// 群成员均可以调用 uploadGroupSharedFileWithId 上传群共享文件。群共享文件大小限制为 10 M
// 成功上传群共享文件后，群成员会收到 groupFileListDidUpdate 回调
[[AgoraChatClient sharedClient].groupManager uploadGroupSharedFileWithId:@"groupID"
 																																filePath:@"filePath" 
 																															  progress:nil 
 																															completion:nil];

// 群成员均可以调用 removeGroupSharedFileWithId 删除群共享文件
// 成功删除群共享文件后，群成员会收到 groupFileListDidUpdate 回调
[[AgoraChatClient sharedClient].groupManager removeGroupSharedFileWithId:@"groupID"
 																													  sharedFileId:@"fileID" 
 																															     error:nil];

// 群成员均可以调用 getGroupFileListWithId 获取群共享文件列表
[[AgoraChatClient sharedClient].groupManager getGroupFileListWithId:@"groupID"
 																												 pageNumber:pageNumber 
 																												   pageSize:pageSize 
 																														  error:nil];
```

### 监听群组事件

`AgoraChatGroupManagerDelegate` 中提供了群组事件的监听接口。开发者可以通过设置此监听，获取到群组中的事件，并做出相应的处理。如果不再使用该监听，需要移除，防止出现内存泄漏。

监听群组事件的示例代码如下：

```objective-c
- (void)viewDidLoad
{
    [super viewDidLoad];
    [[AgoraChatClient sharedClient].groupManager addDelegate:self delegateQueue:nil];
}

- (void)dealloc
{
    [[AgoraChatClient sharedClient].groupManager removeDelegate:self];
}
```

具体可以添加的回调事件如下：

```objective-c
// Occurs when a user revices a group invitation
- (void)groupInvitationDidReceive:(NSString *)aGroupId inviter:(NSString *)aInviter message:(NSString *)aMessage

// Occurs when the group owner receives a group request
- (void)joinGroupRequestDidReceive:(AgoraChatGroup *)aGroup user:(NSString *)aUsername reason:(NSString *)aReason

// Occurs when the group owner approves a join request
- (void)joinGroupRequestDidApprove:(AgoraChatGroup *)aGroup

// Occurs when the group owner declines a join request
- (void)joinGroupRequestDidDecline:(NSString *)aGroupId reason:(NSString *)aReason

// Occurs when the group invitation is accepted
- (void)groupInvitationDidAccept:(AgoraChatGroup *)aGroup invitee:(NSString *)aInvitee

// Occurs when the group invitation is declined
- (void)groupInvitationDidDecline:(AgoraChatGroup *)aGroup invitee:(NSString *)aInvitee reason:(NSString *)aReason

// Occurs when the local user joins the chat group
- (void)didJoinGroup:(AgoraChatGroup *)aGroup inviter:(NSString *)aInviter message:(NSString *)aMessage

// Occurs when the users are added to the mute list
- (void)groupMuteListDidUpdate:(AgoraChatGroup *)aGroup addedMutedMembers:(NSArray *)aMutedMembers muteExpire:(NSInteger)aMuteExpire

// Occurs when the users are removed from the mute list
- (void)groupMuteListDidUpdate:(AgoraChatGroup *)aGroup removedMutedMembers:(NSArray *)aMutedMembers

// Occurs when the users are added to the white list
- (void)groupWhiteListDidUpdate:(AgoraChatGroup *)aGroup addedWhiteListMembers:(NSArray *)aMembers

// Occurs when the users are removed from the white list
- (void)groupWhiteListDidUpdate:(AgoraChatGroup *)aGroup removedWhiteListMembers:(NSArray *)aMembers

// Occurs when all the group members are muted
- (void)groupAllMemberMuteChanged:(AgoraChatGroup *)aGroup isAllMemberMuted:(BOOL)aMuted

// Occurs when a user is added to the admin list
- (void)groupAdminListDidUpdate:(AgoraChatGroup *)aGroup addedAdmin:(NSString *)aAdmin

// Occurs when a user is removed from the admin list
- (void)groupAdminListDidUpdate:(AgoraChatGroup *)aGroup removedAdmin:(NSString *)aAdmin

// Occurs when the group owner is updated
- (void)groupOwnerDidUpdate:(AgoraChatGroup *)aGroup newOwner:(NSString *)aNewOwner oldOwner:(NSString *)aOldOwner

// Occurs when a user joins a group.
- (void)userDidJoinGroup:(AgoraChatGroup *)aGroup user:(NSString *)aUsername

// Occurs when a user leaves a group.
- (void)userDidLeaveGroup:(AgoraChatGroup *)aGroup user:(NSString *)aUsername

// Occurs when a user update the announcement from a group.
- (void)groupAnnouncementDidUpdate:(AgoraChatGroup *)aGroup announcement:(NSString *)aAnnouncement

// Occurs when a user uploads a shared file to a group.
- (void)groupFileListDidUpdate:(AgoraChatGroup *)aGroup addedSharedFile:(AgoraChatGroupSharedFile *)aSharedFile

// Occurs when a user remove a shared file from the group.
- (void)groupFileListDidUpdate:(AgoraChatGroup *)aGroup removedSharedFile:(NSString *)aFileId
```