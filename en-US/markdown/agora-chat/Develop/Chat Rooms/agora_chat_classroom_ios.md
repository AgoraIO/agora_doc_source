# Implement Chat Room Workflow

Chat rooms enable real-time messaging among multiple users.

Chat rooms do not have a strict membership, and members do not retain any permanent relationship with each other. Once a chat room member goes offline, this member does not receive any push messages from the chat room and automatically leaves the chat room in 5 minutes. Chat rooms are widely applied in live broadcast use cases as stream chat in Twitch.

This page shows how to use the Agora Chat SDK to create and manage a chat room in your app.


## Understand the tech

The Agora Chat SDK provides the `IAgoraChatroomManager`, `AgoraChatroomManagerDelegate`, `AgoraChatRoom` classes for chat room management, which allows you to implement the following features:
- Create and destroy a chat room
- Join and leave a chat room
- Retrieve the chat room list
- Manage chat room members
- Manage the attributes and announcements of a chat room


## Prerequisites

Before proceeding, ensure that you meet the following requirements:

- You have initialized the Agora Chat SDK. For details, see [Get Started with iOS](agora_chat_get_started_ios).
- You understand the call frequency limit of the Agora Chat APIs supported by different pricing plans as described in [Limitations](agora_chat_limitation).
- You understand the number of chat rooms supported by different pricing plans as described in [Pricing Plan Details](agora_chat_plan).
- Only the app super admin has the privilege of creating a chat room. Ensure that you have added an app super admin by [calling the super-admin RESTful API](agora_chat_restful_chatroom_superadmin).


## Implementation

This section describes how to call the APIs provided by the Agora Chat SDK to implement chat room features.

### Create and destroy a chat room

The [app super admin](agora_chat_restful_chatroom_superadmin) can create a chat room and set the chat room attributes such as the chat room subject, description, and the maximum number of members. Once a chat room is created, the super admin automatically becomes the chat room owner.

Only the chat room owner can disband a chat room. Once a chat room is disbanded, all the chat room members receive the `didDismissFromChatroom` callback and are immediately removed from the chat room.

```objective-c
// The super admin can call createChatroomWithSubject to create a chat room.
AgoraError *error = nil;
AgoraChatroom *retChatroom = [[AgoraChatClient sharedClient].roomManager createChatroomWithSubject:@"aSubject" description:@"aDescription" invitees:@[@"user1",@[user2]]message:@"aMessage" maxMembersCount:aMaxMembersCount error:&error];

// The chat room owner can call destroyChatroom to disband a chat room.
AgoraError *error = nil;
[[AgoraChatClient sharedClient].roomManager destroyChatroom:self.chatroom.chatroomId error:&error];
```


### Retrieve the chat room list

All chat users can get the chat room list from the server and retrieve the basic information of the specified chat room using the chat room ID.

```objective-c
// Chat room members can call getChatroomsFromServerWithPage to retrieve the specified number of chat rooms from the server by page. The maximum value of pageSize is 1,000.
AgoraError *error = nil;
[[AgoraChatClient sharedClient].roomManager getChatroomsFromServerWithPage:1 pageSize:50 error:&error];
														
// Chat room members can call chatroomWithId to get the basic information of the specified chat room by passing the chat room ID.
AgoraChatroom *chatRoom = [AgoraChatroom chatroomWithId:@"chatroomId"];
```


### Join and leave a chat room

All chat users can call `joinChatroom` to join the specified chat room. Once a chat user joins a chat room, all the other chat room members receive the `userDidJoinChatroom` callback.

All chat room members can call `leaveChatroom` to leave the specified chat room. Once a chat room member leaves a chat room, all the other members receive the `userDidLeaveChatroom` callback and all the local data is deleted by default. To retain data on the local device, set the `isDeleteMessagesWhenExitChatRoom` parameter of `AgoraOptions` to `NO`.

```objective-c
// All chat users can call joinChatroom to join the specified chat room.
AgoraError *error = nil;
[[AgoraChatClient sharedClient].roomManager joinChatroom:@"aChatroomId" error:&error]; 

// All chat room members can call leaveChatroom to leave the specified chat room.
AgoraError *error = nil;
[AgoraChatClient sharedClient].roomManager leaveChatroom:@"aChatroomId" error:&error];
```


### Retrieve and modify the chat room attributes

All chat room members can retrieve the detailed information of the current chat room, including the subject, announcements, description, member type, and admin list.

The chat room owner and admins can also set and update the chat room information.

```objective-c
// Chat room members can call getChatroomSpecificationFromServerWithId to get the information of the specified chat room.
AgoraError *error = nil;
AgoraChatroom *chatroom = [[AgoraChatClient sharedClient].roomManager getChatroomSpecificationFromServerWithId:@“chatroomId” error:&error];

// The chat room owner and admins can call updateSubject to update the chat room subject.
AgoraError *error = nil;
[[AgoraChatClient sharedClient].roomManager updateSubject:textString forChatroom:self.chatroom.chatroomId error:&error];

// The chat room owner and admins can call updateDescription to update the chat room description.
AgoraError *error = nil;
[[AgoraChatClient sharedClient].roomManager updateDescription:textString forChatroom:self.chatroom.chatroomId error:&error];
```


### Manage chat room members

All chat room members can call `getChatroomMemberListFromServerWithId` to retrieve the member list of the current chat room.

```objective-c
AgoraError *error = nil;
[[AgoraChatClient sharedClient].roomManager getChatroomMemberListFromServerWithId:@"chatroomId" cursor:1 pageSize:20 error:&error];
```

The chat room owner and admin can call `removeMembers` to remove the specified member from the chat room. Once a member is removed, the other chat room members receive the `didDismissFromChatroom` callback. After being removed from a chat room, the chat user can join this chat room again.

```objective-c
AgoraError *error = nil;
[[AgoraChatClient sharedClient].roomManager removeMembers:@[@"userName"] fromChatroom:@"chatroomId" error:&error];
```


### Manage the chat room block list

The chat room owner and admins can add and remove the specified member from the chat room block list. Once a chat room member is added to the block list, this member cannot send or receive chat room messages, nor can they join the chat room again.

```objective-c
// The chat room owner or admin can call blockMembers to add the specified member to the chat room block list.
AgoraError *error = nil;
[[AgoraChatClient sharedClient].roomManager blockMembers:@[@"userName"] fromChatroom:@"chatroomId" error:&error];

// The chat room owner or admin can call unblockMembers to remove the specified user from the block list.
AgoraError *error = nil;
[[AgoraChatClient sharedClient].roomManager unblockMembers:@[@"userName"] fromChatroom:@"chatroomId" error:&error];

// The chat room owner or admin can call getChatroomBlacklistFromServerWithId to retrieve the block list of the current chat room.
AgoraError *error = nil;
[[AgoraChatClient sharedClient].roomManager getChatroomBlacklistFromServerWithId:@"chatroomId" pageNumber:1 pageSize:20 error:&error];
```


### Manage the chat room mute list

The chat room owner and admins can add and remove the specified member from the chat room mute list. Once a chat room member is added to the mute list, this member can no longer send chat room messages, not even after being added to the chat room allow list.

```objective-c
// The chat room owner or admin can call muteMembers to add the specified user to the chat room block list.
// The muted member and all the other chat room admins or owner receive the onMuteListAdded callback.
AgoraError *error = nil;
[[AgoraChatClient sharedClient].roomManager muteMembers:@[@"userName"] muteMilliseconds:-1 fromChatroom:@"chatroomId" error:&error];

// The chat room owner or admin can call unMuteChatRoomMembers to remove the specified user from the chat room mute list.
// The unmuted member and all the other chat room admins or owner receive the chatroomMuteListDidUpdate callback.
AgoraError *error = nil;
[[AgoraChatClient sharedClient].roomManager unmuteMembers:@[@"userName"] fromChatroom:@"chatroomId" error:&error];

// The chat room owner or admin can call getChatroomMuteListFromServerWithId to retrieve the mute list of the current chat room.
AgoraError *error = nil;
[[AgoraChatClient sharedClient].roomManager getChatroomMuteListFromServerWithId:@"chatroomId" pageNumber:1 pageSize:20 error:&error];
```


### Mute and unmute all chat room members

The chat room owner and admins can mute or unmute all the chat room members. Once all the members are muted, only those in the chat room allow list can send messages in the chat room.

```objective-c
// The chat room owner or admin can call muteAllMembersFromChatroom to mute all the chat room members.
// Once all the members are muted, these members receive the chatroomMuteListDidUpdate callback.
ChatClient.getInstance().chatroomManager().muteAllMembers(chatRoomId, new ValueCallBack<ChatRoom>() {
AgoraError *error = nil;
[AgoraChatClient.sharedClient.roomManager muteAllMembersFromChatroom:@"chatRoomId" error:&error];

// The chat room owner or admin can call unmuteAllMembersFromChatroom to unmute all the chat room members.
// Once all the members are unmuted, these members receive the chatroomMuteListDidUpdate callback.
AgoraError *error = nil;
[AgoraChatClient.sharedClient.roomManager unmuteAllMembersFromChatroom:@"chatRoomId" error:&error];
```


### Manage the chat room allow list

Members in the chat room allow list can send chat room messages even when the chat room owner or an admin has muted all the chat room members. However, if a member is already in the chat room mute list, adding this member to the allow list does not take effect.

```objective-c
// The chat room owner or admin can call addWhiteListMembers to add the specified member to the chat room allow list.
AgoraError *error = nil;  
[AgoraChatClient.sharedClient.roomManager addWhiteListMembers:@[@"userId1",@"userId2"] fromChatroom:@"aChatroomId" error:&error];

// The chat room owner or admin can call removeWhiteListMembers to remove the specified member from the chat room allow list.
AgoraError *error = nil;  
[AgoraChatClient.sharedClient.roomManager removeWhiteListMembers:@[@"userId1",@"userId2"] fromChatroom:@"aChatroomId" error:&error];

// Chat room members can call isMemberInWhiteListFromServerWithChatroomId to check whether they are in the chat room allow list.
AgoraError *error = nil;
[AgoraChatClient.sharedClient.roomManager isMemberInWhiteListFromServerWithChatroomId:@"aChatroomId" error:&error];

// The chat room owner or admin can call getChatroomWhiteListFromServerWithId to retrieve the allow list of the current chat room.
AgoraError *error = nil;
[AgoraChatClient.sharedClient.roomManager getChatroomWhiteListFromServerWithId:@"aChatroomId" error:&error];
```


### Manage chat room ownership and admin

The chat room owner can transfer ownership to the specified chat room member. Once ownership is transferred, the original chat room owner becomes a chat room member. The new chat room owner and the chat room admins receive the `chatroomOwnerDidUpdate` callback.

The chat room owner can add admins. Once added to the chat room admin list, the newly added admin and the other chat room admins receive the `chatroomAdminListDidUpdate` callback.

The chat room owner can remove admins. Once removed from the chat room admin list, the removed admin and the other chat room admins receive the `chatroomAdminListDidUpdate` callback.

```objective-c
// The chat room owner can call updateChatroomOwner to transfer ownership to the other chat room member.
AgoraError *error = nil;
[[AgoraChatClient sharedClient].roomManager updateChatroomOwner:@"chatroomId" newOwner:@"textString" error:&error];

// The chat room owner can call addAdmin to add a chat room admin.
AgoraError *error = nil;
[[AgoraChatClient sharedClient].roomManager addAdmin:@"userName" toChatroom:@"chatroomId" error:&error];

// The chat room owner can call removeAdmin to remove a chat room admin.
AgoraError *error = nil;
[[AgoraChatClient sharedClient].roomManager removeAdmin:@"userName" fromChatroom:@"chatroomId" error:&error];
```


### Manage chat room announcements

All chat room members can retrieve the chat room announcements.

The chat room owner and admins can set and update the chat room announcements. Once the announcements are updated, all the chat room members receive the `groupAnnouncementDidUpdate` callback.

```objective-c
// Chat room members can call getChatroomAnnouncementWithId to retrieve the chat room announcements.
[AgoraChatClient.sharedClient.roomManager getChatroomAnnouncementWithId:@"chatRoomId" error:&error];

// The chat room owner and admins can call updateChatroomAnnouncementWithId to set or update the chat room announcements.
AgoraError *error =  nil;
[[AgoraChatClient sharedClient].roomManager updateChatroomAnnouncementWithId:_chatroomId announcement:textString error:&error];
```


### Listen for chat room events

To monitor the chat room events, you can listen for the callbacks in the `ChatRoomManager` class and add app logics accordingly. If you want to stop listening for the callback, make sure that you remove the listener to prevent memory leakage.

```objective-c
// Listen for the callback.
[[AgoraChatClient sharedClient].roomManager addDelegate:self delegateQueue:nil];

// Stop listening for the callback.
[[AgoraChatClient sharedClient].roomManager removeDelegate:self];
```

```objective-c
/**
 *  Occurs when a user joins a chat room.
 *  @param aChatroom    The chat room ID
 *  @param aUsername    The username of the new chat room member
 */
- (void)userDidJoinChatroom:(AgoraChatroom *)aChatroom
                   user:(NSString *)aUsername{

}

/**
 *  Occurs when a member leaves a chat room.
 *  @param aChatroom    The chat room ID
 *  @param aUsername    The username of the member that leaves the chat room
 */
- (void)userDidLeaveChatroom:(AgoraChatroom *)aChatroom
                        user:(NSString *)aUsername {
}

/**
 *  Occurs when a member is removed from a chat room.
 *  @param aChatroom    The chat room ID
 *  @param aReason      The reason why this member is removed
 */
- (void)didDismissFromChatroom:(AgoraChatroom *)aChatroom
                        reason:(AgoraChatroomBeKickedReason)aReason {
                        
  }

/**
 *  Occurs when a member is added to the chat room mute list.
 *  @param aChatroom        The chat room ID
 *  @param aMutedMembers    The username of the member added to the must list
 *  @param aMuteExpire      The Unix timestamp when the mute expires. Not currently available.
 */
- (void)chatroomMuteListDidUpdate:(AgoraChatroom *)aChatroom
                addedMutedMembers:(NSArray *)aMutes
                       muteExpire:(NSInteger)aMuteExpire {
                        
  }

/**
 *  Occurs when a member is removed from the chat room mute list.
 *  @param aChatroom        The chat room ID
 *  @param aMutedMembers    The username of the member removed from the mute list
 */
- (void)chatroomMuteListDidUpdate:(AgoraChatroom *)aChatroom
              removedMutedMembers:(NSArray *)aMutes {
                        
  }
  
/**
 *  Occurs when a member is added to the chat room admin list.
 *  @param aChatroom    The chat room ID
 *  @param aAdmin       The username of the member added to the admin list
 */
- (void)chatroomAdminListDidUpdate:(AgoraChatroom *)aChatroom
                        addedAdmin:(NSString *)aAdmin {
                        
  }

/**
 *  Occurs when a member is removed from the chat room admin list.
 *  @param aChatroom    The chat room ID
 *  @param aAdmin       The username of the admin removed from the admin list
 */
- (void)chatroomAdminListDidUpdate:(AgoraChatroom *)aChatroom
                      removedAdmin:(NSString *)aAdmin {
                        
  }

/**
 *  Occurs when the chat room owner is changed.
 *  @param aChatroom    The chat room ID.
 *  @param aNewOwner    The username of the new chat room owner.
 *  @param aOldOwner    The username of the original chat room owner.
 */
- (void)chatroomOwnerDidUpdate:(AgoraChatroom *)aChatroom
                      newOwner:(NSString *)aNewOwner
                      oldOwner:(NSString *)aOldOwner {
                        
  }
```