Chat rooms enable real-time messaging among multiple users.

This page shows how to use the Agora Chat SDK to manage the attributes of a chat room in your app.

## Understand the tech

The Agora Chat SDK provides the `IAgoraChatroomManager`, `AgoraChatroomManagerDelegate`, and `AgoraChatRoom` classes for chat room management, which allows you to implement the following features:

- Update the name of a chat room
- Update the description of a chat room
- Retrieve the announcements of a chat room
- Update the announcements of a chat room


## Prerequisites

Before proceeding, ensure that you meet the following requirements:

- You have initialized the Agora Chat SDK. For details, see [Get Started with iOS](./agora_chat_get_started_ios?platform=iOS).
- You understand the call frequency limit of the Agora Chat APIs supported by different pricing plans as described in [Limitations](./agora_chat_limitation?platform=iOS).
- You understand the number of chat rooms supported by different pricing plans as described in [Pricing Plan Details](./agora_chat_plan?platform=iOS).


## Implementation

This section introduces how to call the APIs provided by the Agora Chat SDK to implement the features listed above.

### Retrieve and modify the chat room attributes

All chat room members can retrieve the detailed information of the current chat room, including the subject, announcements, description, member type, and admin list.

The chat room owner and admins can also set and update the chat room information.

```objective-c
// Chat room members can call getChatroomSpecificationFromServerWithId to get the information of the specified chat room.
AgoraChatError *error = nil;
AgoraChatroom *chatroom = [[AgoraChatClient sharedClient].roomManager getChatroomSpecificationFromServerWithId:@“chatroomId” error:&error];

// The chat room owner and admins can call updateSubject to update the chat room subject.
AgoraChatError *error = nil;
[[AgoraChatClient sharedClient].roomManager updateSubject:textString forChatroom:self.chatroom.chatroomId error:&error];

// The chat room owner and admins can call updateDescription to update the chat room description.
AgoraChatError *error = nil;
[[AgoraChatClient sharedClient].roomManager updateDescription:textString forChatroom:self.chatroom.chatroomId error:&error];
```

### Manage chat room announcements

All chat room members can retrieve the chat room announcements.

The chat room owner and admins can set and update the chat room announcements. Once the announcements are updated, all the chat room members receive the `groupAnnouncementDidUpdate` callback.

```objective-c
// Chat room members can call getChatroomAnnouncementWithId to retrieve the chat room announcements.
[AgoraChatClient.sharedClient.roomManager getChatroomAnnouncementWithId:@"chatRoomId" error:&error];

// The chat room owner and admins can call updateChatroomAnnouncementWithId to set or update the chat room announcements.
AgoraChatError *error =  nil;
[[AgoraChatClient sharedClient].roomManager updateChatroomAnnouncementWithId:_chatroomId announcement:textString error:&error];
```

### Listen for chat room events

For details, see [Chat Room Events](./agora_chat_chatroom_ios?platform=iOS#listen-for-chat-room-events).