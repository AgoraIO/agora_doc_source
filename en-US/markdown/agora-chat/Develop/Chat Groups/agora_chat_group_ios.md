# Manage Chat Groups

Chat groups enable real-time messaging among multiple users.

This page shows how to use the Agora Chat SDK to create and manage a chat group in your app.


## Understand the tech

The Agora Chat SDK provides the `IAgoraChatGroupManager`, `AgoraChatGroupManagerDelegate`, and `AgoraChatGroup` classes for chat group management, which allows you to implement the following features:

- Create and destroy a chat group
- Join and leave a chat group
- Retrieve the member list of a chat group
- Block and unblock a chat group
- Listen for the chat group events


## Prerequisites

Before proceeding, ensure that you meet the following requirements:

- You have initialized the Agora Chat SDK. For details, see [Get Started with iOS](./agora_chat_get_started_ios?platform=iOS).
- You understand the call frequency limits of the Agora Chat APIs supported by different pricing plans as described in [Limitations](./agora_chat_limitation?platform=iOS).
- You understand the number of chat groups and chat group members supported by different pricing plans as described in [Pricing Plan Details](./agora_chat_plan?platform=iOS).


## Implementation

This section describes how to call the APIs provided by the Agora Chat SDK to implement chat group features.

### Create and destroy a chat group

Users can create a chat group and set the chat group attributes such as the name, description, group members, and reasons for creating the group. Users can also specify the size and type of a chat group. Once a chat group is created, the creator of the chat group automatically becomes the chat group owner.

Only chat group owners can disband chat groups. Once a chat group is disbanded, all members of that chat group are immediately removed from the chat group. All local data for the chat group is also removed from the database and memory.

Refer to the following sample code to create and destroy a chat group:

```objective-c
AgoraChatGroupOptions *options = [[AgoraChatGroupOptions alloc] init];
// Set the size of a chat group.
options.maxUsersCount = self.maxMemNum;
// Set IsInviteNeedConfirm to YES to send a group invitation to invitees. If IsInviteNeedConfrim is set to NO, invitees are added to the chat group automatically without their confirmations.
options.IsInviteNeedConfirm = YES;
// Set the type of a chat group to private. Allow chat group members to invite other users to join the group.
options.style = AgoraChatGroupStylePrivateMemberCanInvite;
NSArray *members = @{@"memeber1",@"member2"};
// Call createGroupWithSubject to create a chat group.
[[AgoraChatClient sharedClient].groupManager createGroupWithSubject:@"subject"
                                                                                                                 description:@"description"
                                                                                                                      invitees:members
                                                                                                                         message:@"message"
                                                                                                                         setting:options
                                                                                                                             error:nil];


// Call destroyGroup to disband a chat group. Once a chat group is disbanded, all chat group members receive the didLeaveGroup callback.
[[AgoraChatClient sharedClient].groupManager destroyGroup:@"groupID"];
```

### Join and leave a chat group

Users can request to join a public chat group as follows:

1. Call `getJoinedGroupsFromServerWithPage` to retrieve the list of the groups that the user is already in from the server. This prevents repetitive join requests.
2. Call `getJoinedGroups` to retrieve the list of the groups that the user is already in from the local database.
3. Call `getPublicGroupsFromServerWithCursor` to retrieve the list of public groups by page. Users can obtain the ID of the group that they want to join.
4. Call `joinPublicGroup` to send a join request to the chat group:
    - If the type of the chat group is set to `AgoraChatGroupStylePublicOpenJoin`, the request from the user is accepted automatically and the chat group members receive the `userDidJoinGroup` callback.
    - If the type of the chat group is set to `AgoraChatGroupStylePublicJoinNeedApproval`, the chat group owner and chat group admins receive the `joinGroupRequestDidReceive` callback and determine whether to accept the request from the user. Once the join request is approved, the user receives the `joinGroupRequestDidApprove` callback. Otherwise, the user receives the `joinGroupRequestDidDecline` callback.

Users can call `leaveGroup` to leave a chat group. Once a user leaves the chat group, all the other group members receive the `didLeaveGroup` callback.

Refer to the following sample code to join and leave a chat group:

```objective-c
// Call getJoinedGroupsFromServerWithPage to retrieve the list of joined groups from the server by page.
NSArray *groupList = [[AgoraChatClient sharedClient].groupManager
                      				 getJoinedGroupsFromServerWithPage:nil 
                      																  pageSize:-1 
                      																     error:nil];

// Call getJoinedGroups to retrieve the list of joined groups from the local database.
NSArray *groupList = [[AgoraChatClient sharedClient].groupManager getJoinedGroups];

// Call getPublicGroupsFromServerWithCursor to retrieve the list of public groups by page.
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

// Call joinPublicGroup to send a join request to a chat group.
[[AgoraChatClient sharedClient].groupManager joinPublicGroup:@"groupID" error:nil];

// Call leaveGroup to leave a chat group.
[[AgoraChatClient sharedClient].groupManager leaveGroup:@"groupID" error:nil];
```

### Retrieve the member list of a chat group

To retrieve the member list of a chat group, choose the method based on the size of the chat group:

- If the number of chat group members is greater than or equal to 200, list members of the chat group by page.
- If the number of chat group members is less than 200, call `getGroupSpecificationFromServerWithId` to retrieve the member list of the chat group.

Refer to the following sample code to retrieve the member list of a chat group:

```objective-c
// List members of a chat group by page.
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

// Call getGroupSpecificationFromServerWithId to retrieve the member list of a chat group.
AgoraChatGroup *group = [[AgoraChatClient sharedClient].groupManager
                     			getGroupSpecificationFromServerWithId:@"groupID"
                     											         fetchMembers:YES 
                     																			error:nil];
NSArray *memeberList = [group.memberList];
```

### Block and unblock a chat group

All chat group members can block and unblock a chat group. Once a member block a chat group, they no longer receive messages from this chat group.

Refer to the following sample code to block and unblock a chat group:

```objective-c
// Call blockGroup to block a chat group.
[[AgoraChatClient sharedClient].groupManager blockGroup:@"groupID"error:nil];

// Call unblockGroup to unblock a chat group.
[[AgoraChatClient sharedClient].groupManager unblockGroup:@"groupID" error:nil];
```

The chat group owner and chat group admins can call `getGroupSpecificationFromServerWithId` to retrieve the member list of a chat group and call `isBlocked` to further retrieve the list of members who block the chat group.  
Chat group members can call `isBlocked` to check whether they block the chat group.

### Listen for chat group events

To monitor the chat group events, users can listen for the callbacks in the `AgoraChatGroupManager` class and add app logics accordingly. If a user wants to stop listening for the callbacks, make sure that the user removes the listener to prevent memory leakage.

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

```objective-c
// Occurs when a user receives a group invitation.
- (void)groupInvitationDidReceive:(NSString *)aGroupId inviter:(NSString *)aInviter message:(NSString *)aMessage

// Occurs when the chat group owner receives a join request.
- (void)joinGroupRequestDidReceive:(AgoraChatGroup *)aGroup user:(NSString *)aUsername reason:(NSString *)aReason

// Occurs when the chat group owner approves a join request.
- (void)joinGroupRequestDidApprove:(AgoraChatGroup *)aGroup

// Occurs when the chat group owner rejects a join request.
- (void)joinGroupRequestDidDecline:(NSString *)aGroupId reason:(NSString *)aReason

// Occurs when a user accepts a group invitation.
- (void)groupInvitationDidAccept:(AgoraChatGroup *)aGroup invitee:(NSString *)aInvitee

// Occurs when a user declines a group invitation.
- (void)groupInvitationDidDecline:(AgoraChatGroup *)aGroup invitee:(NSString *)aInvitee reason:(NSString *)aReason

// Occurs when a user automatically accepts a group invitation. The invitee receives this event.
- (void)didJoinGroup:(AgoraChatGroup *)aGroup inviter:(NSString *)aInviter message:(NSString *)aMessage

// Occurs when a user is added to the chat group mute list.
- (void)groupMuteListDidUpdate:(AgoraChatGroup *)aGroup addedMutedMembers:(NSArray *)aMutedMembers muteExpire:(NSInteger)aMuteExpire

// Occurs when a user is removed from the chat group mute list.
- (void)groupMuteListDidUpdate:(AgoraChatGroup *)aGroup removedMutedMembers:(NSArray *)aMutedMembers

// Occurs when a user is added to the chat group allow list.
- (void)groupWhiteListDidUpdate:(AgoraChatGroup *)aGroup addedWhiteListMembers:(NSArray *)aMembers

// Occurs when a user is removed from the chat group allow list.
- (void)groupWhiteListDidUpdate:(AgoraChatGroup *)aGroup removedWhiteListMembers:(NSArray *)aMembers

// Occurs when all group members are muted.
- (void)groupAllMemberMuteChanged:(AgoraChatGroup *)aGroup isAllMemberMuted:(BOOL)aMuted

// Occurs when a chat group member is added to the admin list.
- (void)groupAdminListDidUpdate:(AgoraChatGroup *)aGroup addedAdmin:(NSString *)aAdmin

// Occurs when a chat group admin is removed from the admin list.
- (void)groupAdminListDidUpdate:(AgoraChatGroup *)aGroup removedAdmin:(NSString *)aAdmin

// Occurs when the chat group owner is changed.
- (void)groupOwnerDidUpdate:(AgoraChatGroup *)aGroup newOwner:(NSString *)aNewOwner oldOwner:(NSString *)aOldOwner

// Occurs when a user joins a chat group.
- (void)userDidJoinGroup:(AgoraChatGroup *)aGroup user:(NSString *)aUsername

// Occurs when a user leaves a chat group.
- (void)userDidLeaveGroup:(AgoraChatGroup *)aGroup user:(NSString *)aUsername

// Occurs when a user updates the announcement of a chat group.
- (void)groupAnnouncementDidUpdate:(AgoraChatGroup *)aGroup announcement:(NSString *)aAnnouncement

// Occurs when a user uploads a shared file to a chat group.
- (void)groupFileListDidUpdate:(AgoraChatGroup *)aGroup addedSharedFile:(AgoraChatGroupSharedFile *)aSharedFile

// Occurs when a user removes a shared file from the chat group.
- (void)groupFileListDidUpdate:(AgoraChatGroup *)aGroup removedSharedFile:(NSString *)aFileId
```