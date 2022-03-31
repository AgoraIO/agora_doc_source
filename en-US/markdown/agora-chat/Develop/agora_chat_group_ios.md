# Implement Chat Group Workflow

Chat groups enable real-time messaging among multiple users.

This page describes how to use the Agora Chat SDK to create and manage a chat group in your app.


## Understand the tech

The Agora Chat SDK provides a `IAgoraChatGroupManager`, a `AgoraChatGroupManagerDelegate`, and a `AgoraChatGroup` class for chat group management, which allows you to implement the following features:
- Create and destroy a chat group
- Join and leave a chat group
- Retrieve the member list of a chat group
- Mute and unmute a chat group
- Manage chat group members
- Manage the attributes, announcements, and shared files of a chat group


## Prerequisites

Before proceeding, ensure that you meet the following requirements:

- You have initialized the Agora Chat SDK. For details, see [Get Started with iOS](agora_chat_get_started_ios).
- You understand the call frequency of the Agora Chat APIs supported by different pricing plans as described in [Limitations](agora_chat_limitation).
- You understand the number of chat groups and chat group members supported by different pricing plans as described in [Pricing Plan Details](agora_chat_plan).


## Implementation

This section describes how to call the APIs provided by the Agora Chat SDK to implement the features listed above.

### Create and destroy a chat group

You can create a chat group and set the chat group attributes such as the name, description, group members, and reasons to create the group. You can also specify the size and type of a chat group. Once a chat group is created, the creator of the chat group becomes the chat group owner automatically.

Only chat group owners can destroy chat groups. Once a chat group is destroyed, all the chat group members are immediately removed from the chat group. Data related to the chat group are also removed from the database and memory.

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


// Call destroyGroup to destroy a chat group. Once a chat group is destroyed, all the chat group members receive the didLeaveGroup callback.
[[AgoraChatClient sharedClient].groupManager destroyGroup:@"groupID"];
```


### Join and leave a chat group

You can request to join a public chat group as follows:

1. Call `getJoinedGroupsFromServerWithPage` to retrieve the list of the groups that you are already in. This prevents repetitive join requests.
2. Call `getPublicGroupsFromServerWithCursor` to retrieve the list of public groups by page. You can obtain the ID of the group that you want to join.
3. Call `joinPublicGroup` to send a join request to the chat group:
    - If the type of the chat group is set to `AgoraChatGroupStylePublicOpenJoin`, your request is accepted automatically and the chat group memebers receive the `userDidJoinGroup` callback.
    - If the type of the chat group is set to `AgoraChatGroupStylePublicJoinNeedApproval`, the chat group owner and chat group admins receive the `joinGroupRequestDidReceive` callback and determine whether to accept your request. Once the join request is approved, you receive the `joinGroupRequestDidApprove` callback. Otherwise, you receive the `joinGroupRequestDidDecline` callback.

You can call `leaveGroup` to leave a chat group. Once you leave the chat group, all the other group members receive the `didLeaveGroup` callback.

Refer to the following sample code to join and leave a chat group:

```objective-c
// Call getJoinedGroupsFromServerWithPage to retrieve the list of joined groups by page.
NSArray *groupList = [[AgoraChatClient sharedClient].groupManager
                      				 getJoinedGroupsFromServerWithPage:nil 
                      																  pageSize:-1 
                      																     error:nil];

// Call getJoinedGroups to retrieve the list of joined groups.
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


### Mute and unmute a chat group

Group members can mute and unmute a chat group, whereas the chat group owner and chat group admins cannot perform such operations. Once you mute a chat group, you won't receive push notifications from this chat group.

Refer to the following sample code to mute and unmute a chat group:

```objective-c
// Call blockGroup to mute a chat group.
[[AgoraChatClient sharedClient].groupManager blockGroup:@"groupID"error:nil];

// Call unblockGroup to unmute a chat group.
[[AgoraChatClient sharedClient].groupManager unblockGroup:@"groupID" error:nil];
```

The chat group owner and chat group admins can call `getGroupSpecificationFromServerWithId` to retrieve the member list of a chat group and call `isBlocked` to further retrieve the list of members who mute the chat group.  
Chat group members can call `isBlocked` to check whether they mute the chat group.


### Manage chat group members

1. Add users to a chat group.  
Whether a chat group is public or private, the chat group owner and chat group admins can add users to the chat group. As for private groups, if the type of a chat group is set to `AgoraChatGroupStylePrivateMemberCanInvite`, group members can invite users to join the chat group.

2. Implement chat group invitations.  
After a user is invited to join a chat group, the implementation logic varies based on the settings of the user:
    - If the user requires a group invitation confirmation, the invitor receives the `groupInvitationDidReceive` callback. Once the user accepts the request and joins the group, the invitor receives the `groupInvitationDidAccept` callback and all the group members receive the `userDidJoinGroup` callback. Otherwise, the invitor receives the `groupInvitationDidDecline` callback.
    - If the user doesn't require a group invitation confirmation, the invitor receives the `groupInvitationDidAccept` callback. In this case, the user automatically accepts the group invitation and receives the `didJoinGroup` callback. All the group members receive the `userDidJoinGroup` callback.  

3. Remove chat group members from a chat group.  
The chat group owner and chat group admins can remove chat group members from a chat group, whereas chat group members do not have this privilege. Once a group member is removed, this group member receives the `didLeaveGroup` callback and all the other group members receive the `userDidLeaveGroup` callback.

Refer to the following sample code to add and remove a user:

```objective-c
// Group members can call addMembers to add users to a chat group.
[[AgoraChatClient sharedClient].groupManager addMembers:@{@"member1",@"member2"}
 																							  toGroup:@"groupID" 
 																								message:@"message" 
 																						 completion:nil];

// The chat group owner and chat group admins can call removeMembers to remove group members from a chat group.
[[AgoraChatClient sharedClient].groupManager removeMembers:@{@"member"}
 																								 fromGroup:@"groupsID" 
 																								completion:nil];
```


### Manage chat group ownership and admin

1. Transfer the chat group ownership.  
The chat group owner can transfer the ownership to the specified chat group member. Once the ownership is transferred, the original chat group owner becomes a group member. All the other chat group members receive the `groupOwnerDidUpdate` callback.

2. Add chat group admins.  
The chat group owner can add admins. Once added to the chat group admin list, the newly added admin and the other chat group admins receive the `groupAdminListDidUpdate` callback.

3. Remove chat group admins.  
The chat group owner can remove admins. Once removed from the chat group admin list, the removed admin and the other chat group admins receive the `groupAdminListDidUpdate` callback.

Refer to the following sample code to manage chat group ownership and admin:

```objective-c
// The chat group owner can call updateGroupOwner to transfer the ownership to the specified chat group member.
[[AgoraChatClient sharedClient].groupManager updateGroupOwner:@"groupID"
 																										newOwner:@"newOwner"
 																												error:nil];

// The chat group owner can call addAdmin to add admins.
[[AgoraChatClient sharedClient].groupManager addAdmin:@"member" 
 																						  toGroup:@"groupID" 
 																								error:nil];

// The chat group owner can call removeAdmin to remove admins.
[[AgoraChatClient sharedClient].groupManager removeAdmin:@"admin" 
 																						   fromGroup:@"groupID" 
 																									 error:nil];
```


### Manage the chat group block list

The chat group owner and chat group admins can add the specified member to the chat group block list and remove them from it. Once a chat group member is added to the block list, this member cannot send or receive chat group messages, nor can this member join the chat group again.

Refer to the following sample code to manage the chat group block list:

```objective-c
// The chat group owner and admins can call blockMembers to add the specified member to the chat group block list.
[[AgoraChatClient sharedClient].groupManager blockMembers:members 
 																								fromGroup:@"groupID" 
 																							 completion:nil];

// The chat group owner and admins can call unblockMembers to remove the specified member from the chat group block list.
[[AgoraChatClient sharedClient].groupManager unblockMembers:members
                                                      fromGroup:@"groupId"
                                                     completion:nil];

// The chat group owner and admins can call getGroupBlacklistFromServerWithId to retrieve the chat group block list.
[[AgoraChatClient sharedClient].groupManager getGroupBlacklistFromServerWithId:@"groupId" 
 											 pageNumber:pageNumber 
 												 pageSize:pageSize 
 											 completion:nil];
```


### Manage the chat group mute list

The chat group owner and chat group admins can add the specified member to the chat group mute list and remove them from it. Once a chat group member is added to the mute list, this member can no longer send chat group messages, not even after being added to the chat group allow list.

Refer to the following sample code to manage the chat group mute list:

```objective-c
// The chat group owner and admins can call muteMembers to add the specified member to the chat group mute list.
// The muted member and all the other chat group admins or owner receive the groupMuteListDidUpdate callback. 
[[AgoraChatClient sharedClient].groupManager muteMembers:members 
 																				muteMilliseconds:60 
 																							 fromGroup:@"groupID" 
 																									 error:nil];

// The chat group owner and admins can call unmuteMembers to remove the specified user from the chat group mute list.
// The unmuted member and all the other chat group admins or owner recieve the groupMuteListDidUpdate callback.
[[AgoraChatClient sharedClient].groupManager unmuteMembers:members 
 																								 fromGroup:@"groupID" 
 																										 error:nil];

// The chat group owner or admin can call getGroupMuteListFromServerWithId to retrieve the chat group mute list.
[[AgoraChatClient sharedClient].groupManager getGroupMuteListFromServerWithId:@"groupID"
 		 																															pageNumber:pageNumber
 																																		pageSize:pageSize
 																																			 error:nil];
```


### Mute and unmute all the chat group members

The chat group owner and chat group admins can mute or unmute all the chat group members. Once all the members are muted, only those in the chat group allow list can send messages in the chat group.

Refer to the following sample code to mute and unmute all the chat group members:

```objective-c
// The chat group owner or admin can call muteAllMembersFromGroup to mute all the chat group members.
// Once all the members are muted, these members receive the groupAllMemberMuteChanged callback.
[[AgoraChatClient sharedClient].groupManager muteAllMembersFromGroup:@"groupID"
 																															 error:nil];

// The chat group owner or admin can call unmuteAllMembersFromGroup to unmute all the chat group members.
// Once all the members are unmuted, these members receive the groupAllMemberMuteChanged callback.
[[AgoraChatClient sharedClient].groupManager unmuteAllMembersFromGroup:@"groupID"
 																																 error:nil];
```


### Manage the chat group allow list

Members in the chat group allow list can send chat group messages even when the chat group owner or admin has muted all the chat group members. However, if a member is already in the chat group mute list, adding this member to the allow list does not take effect.

Refer to the following sample code to manage the chat group allow list:

```objective-c
// The chat group owner or admin can call addWhiteListMembers to add the specified member to the chat group allow list.
// Once the member is added, all the other chat group admins or owner receive the groupWhiteListDidUpdate callback.
[[AgoraChatClient sharedClient].groupManager addWhiteListMembers:members
 																										   fromGroup:@"groupID" 
 																													 error:nil];

// The chat group owner or admin can call removeWhiteListMembers to remove the specifeid member from the chat group list.
// Once the member is removed, all the other chat group admins or owner receive the groupWhiteListDidUpdate callback.
[[AgoraChatClient sharedClient].groupManager removeWhiteListMembers:members
 																										      fromGroup:@"groupID" 
 																													    error:nil];

// Chat group members can call isMemberInWhiteListFromServerWithGroupId to check whether they are in the chat group allow list.
[[AgoraChatClient sharedClient].groupManager
 																isMemberInWhiteListFromServerWithGroupId:@"groupID"
																																   error:nil];

// The chat group owner or admin can call getGroupWhiteListFromServerWithId to retrieve the chat group allow list.
[[AgoraChatClient sharedClient].groupManager getGroupWhiteListFromServerWithId:@"groupID" 																																				 error:nil];
```


### Modify the chat group name and description

The chat group owner and chat group admins can modify the name and description of the chat group.

Refer to the following sample code to modify the chat group name and description:

```objective-c
// The chat group owner and chat group admins can call changeGroupSubject to modify the name of the chat group. Thd name length can be up to 128 characters.
[[AgoraChatClient sharedClient].groupManager changeGroupSubject:@"subject"
 																											 forGroup:@"groupID" 
 																												  error:nil];

// The chat group owner and chat group admins can call changeDescription to modify the description of the caht group. The description length can be up to 512 characters.
[[AgoraChatClient sharedClient].groupManager changeDescription:@"desc"
 																											forGroup:@"groupID" 
 																										 	   error:nil];
```


### Manage chat group announcements

The chat group owner and chat group admins can set and update the announcements. Once the announcements are updated, all the chat group members receive the `groupAnnouncementDidUpdate` callback. All the chat group members can retrieve the chat group announcements.

Refer to the following sample code to manage chat group announcements:

```objective-c
// The chat group owner and chat group admins can call updateGroupAnnouncementWithId to set or update the chat group announcements. The announcement length can be up to 512 characters.
[[AgoraChatClient sharedClient].groupManager updateGroupAnnouncementWithId:@"groupID"
 																														 announcement:@"announcement" 
 																										 	   					  error:nil];

// Chat group members can call getGroupAnnouncementWithId to retrieve the chat group announcements.
[[AgoraChatClient sharedClient].groupManager getGroupAnnouncementWithId:@"groupID" 
 																																  error:nil];
```


### Manage chat group shared files

All the chat group members can upload or download group shared files. The chat group owner and chat group admins can delete all the group shared files, whereas group members can only delete the shared files that they have personally uploaded.

Refer to the following sample code to manage chat group shared files:

```objective-c
// All the chat group members can call uploadGroupSharedFileWithId to upload group shared files. The file size can be up to 10 MB.
// Once shared files are uploaded, group members receive the groupFileListDidUpdate callback.
[[AgoraChatClient sharedClient].groupManager uploadGroupSharedFileWithId:@"groupID"
 																																filePath:@"filePath" 
 																															  progress:nil 
 																															completion:nil];

// All the chat group members can call removeGroupSharedFileWithId to delete group shared files.
// Once shared files are deleted, chat group members receive the groupFileListDidUpdate callback.
[[AgoraChatClient sharedClient].groupManager removeGroupSharedFileWithId:@"groupID"
 																													  sharedFileId:@"fileID" 
 																															     error:nil];

// All the chat group memebers can call getGroupFileListWithId to retrieve the list of the shared files in the chat group.
[[AgoraChatClient sharedClient].groupManager getGroupFileListWithId:@"groupID"
 																												 pageNumber:pageNumber 
 																												   pageSize:pageSize 
 																														  error:nil];
```


### Listen for chat group events

To monitor the chat group events, you can listen for the callbacks in the `AgoraChatGroupManagerDelegate` class and add app logics accordingly. If you want to stop listening for the callbacks, make sure that you remove the listener to prevent memory leakage.

Refer to the following sample code to listen for chat group events:

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

Refer to the following sample code to add callbacks:

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

// Occurs when a user joins a chat group.
- (void)didJoinGroup:(AgoraChatGroup *)aGroup inviter:(NSString *)aInviter message:(NSString *)aMessage

// Occurs when a user is added to the chat group mute list.
- (void)groupMuteListDidUpdate:(AgoraChatGroup *)aGroup addedMutedMembers:(NSArray *)aMutedMembers muteExpire:(NSInteger)aMuteExpire

// Occurs when a user is removed from the chat group mute list.
- (void)groupMuteListDidUpdate:(AgoraChatGroup *)aGroup removedMutedMembers:(NSArray *)aMutedMembers

// Occurs when a user is added to the chat group allow list.
- (void)groupWhiteListDidUpdate:(AgoraChatGroup *)aGroup addedWhiteListMembers:(NSArray *)aMembers

// Occurs when a user is removed from the chat group allow list.
- (void)groupWhiteListDidUpdate:(AgoraChatGroup *)aGroup removedWhiteListMembers:(NSArray *)aMembers

// Occurs when all the group members are muted.
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