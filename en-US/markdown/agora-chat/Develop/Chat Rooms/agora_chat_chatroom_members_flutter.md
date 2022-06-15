# Manage Chat Room Members

Chat rooms enable real-time messaging among multiple users.

This page shows how to use the Agora Chat SDK to manage the members of a chat room in your app.


## Understand the tech

The Agora Chat SDK provides the `ChatRoom`, `ChatRoomManager`, and `ChatRoomEventListener` classes for chat room management, which allows you to implement the following features:

- Remove a member from a chat room
- Retrieve the member list of a chat room
- Manage the block list of a chat room
- Manage the mute list of a chat room
- Manage the owner and admins of a chat room


## Prerequisites

Before proceeding, ensure that you meet the following requirements:

- You have initialized the Agora Chat SDK. For details, see [Get Started with Flutter](./agora_chat_get_started_flutter).
- You understand the call frequency limit of the Agora Chat APIs supported by different pricing plans as described in [Limitations](./agora_chat_limitation).
- You understand the number of chat rooms supported by different pricing plans as described in [Pricing Plan Details](./agora_chat_plan).


## Implementation

This section describes how to call the APIs provided by the Agora Chat SDK to implement chat room features.

### Remove a member from a chat room

Only the chat room owner and admins can call `removeChatRoomMembers` to remove the specified member from a chat room. Once removed from the chat room, this member receives the `ChatRoomEventListener#onRemovedFromChatRoom` callback, while all the other members receive the `ChatRoomEventListener#onMemberExitedFromChatRoom` callback. Users can join the chat room again after being removed.

The following code sample shows how to remove a member from a chat room:

```dart
try {
  await ChatClient.getInstance.chatRoomManager.removeChatRoomMembers(
    roomId,
    members,
  );
} on ChatError catch (e) {
}
```

### Retrieve the chat room member list

All chat room members can call `fetchChatRoomMembers` to retrieve the member list of the current chat room.

The following code sample shows how to retrieve the chat room member list:

```dart
try {
  await ChatClient.getInstance.chatRoomManager.fetchChatRoomMembers(
    roomId,
    pageSize: pageSize,
    cursor: cursor,
  );
} on ChatError catch (e) {
}
```

### Manage the chat room block list

#### Add a member to the chat room block list

Only the chat room owner and admins can call `blockChatRoomMembers` to add the specified member to the chat room block list. Once added to the block list, this member receives the `ChatRoomEventListener#onRemovedFromChatRoom` callback, while all the other members receive the `ChatRoomEventListener#onMemberExitedFromChatRoom` callback. After being added to block list, this user cannot send or receive messages in the chat room. They can no longer join the chat room again until they are removed from the block list.

The following code sample shows how to add a member to the chat room block list:

```dart
try {
  await ChatClient.getInstance.chatRoomManager.blockChatRoomMembers(
    roomId,
    members
  );
} on ChatError catch (e) {
}
```

#### Remove a member from the chat room block list

Only the chat room owner and admins can call `unBlockChatRoomMembers` to remove the specified member from the chat room block list.

The following code sample shows how to remove a member from the chat room block list:

```dart
try {
  await ChatClient.getInstance.chatRoomManager.unBlockChatRoomMembers(
    roomId,
    members
  );
} on ChatError catch (e) {
}
```

#### Retrieve the chat room block list

Only the chat room owner and admins can call `fetchChatRoomBlockList` to retrieve the chat room block list.

The following code sample shows how to retrieve the chat room block list:

```dart
try {
  List<String>? list= await ChatClient.getInstance.chatRoomManager.fetchChatRoomBlockList(
    roomId,
    pageNum: pageNum,
    pageSize: pageSize,
  );
} on ChatError catch (e) {
}
```

### Manage the chat room mute list

#### Add a member to the chat room mute list

Only the chat room owner and admins can call `muteChatRoomMembers` to add the specified member to the chat room mute list. Once added to the mute list, this member and all the other chat room admins or owner receive the `ChatRoomEventListener#onMuteListAddedFromChatRoom` callback.

**Note**: The chat room owner can mute chat room admins and regular members, whereas chat room admins can only mute regular members.

The following code sample shows how to add a member to the chat room mute list:

```dart
try {
  await ChatClient.getInstance.chatRoomManager.muteChatRoomMembers(
    roomId,
    members
  );
} on ChatError catch (e) {
}
```

#### Remove a member from the chat room mute list

Only the chat room owner and admins can call `unMuteChatRoomMembers` to remove the specified member from the chat room mute list. Once removed from the mute list, this member and all the other chat room admins or owner receive the `ChatRoomEventListener#onMuteListRemovedFromChatRoom` callback.

**Note**: The chat room owner can unmute chat room admins and regular members, whereas chat room admins can only unmute regular members.

The following code sample shows how to remove a member from the chat room mute list:

```dart
try {
  await ChatClient.getInstance.chatRoomManager.unMuteChatRoomMembers(
    roomId,
    members
  );
} on ChatError catch (e) {
}
```

#### Retrieve the chat room mute list

Only the chat room owner and admins can call `fetchChatRoomMuteList` to retrieve the chat room mute list.

The following code sample shows how to retrieve the chat room mute list:

```dart
try {
  List<String>? list =
      await ChatClient.getInstance.chatRoomManager.fetchChatRoomMuteList(
    roomId,
    pageNum: pageNum,
    pageSize: pageSize,
  );
} on ChatError catch (e) {
}
```

### Manage the chat room owner and admins

#### Transfer the chat room ownership

Only the chat room owner can call `changeOwner` to transfer the ownership to the specified chat room member. Once the ownership is transferred, the former chat room owner becomes a regular member. The new chat room owner and the chat room admins receive the `ChatRoomEventListener#onOwnerChangedFromChatRoom` callback.

The following code sample shows how to transfer the chat room ownership:

```dart
try {
  await ChatClient.getInstance.chatRoomManager.changeOwner(
    roomId,
    newOwner,
  );
} on ChatError catch (e) {
}
```

#### Add a chat room admin

Only the chat room owner can call `addChatRoomAdmin` to add an admin. Once promoted to an admin, the new admin and the other chat room admins receive the `ChatRoomEventListener#onAdminAddedFromChatRoom` callback.

The following code sample shows how to add a chat room admin:

```dart
try {
  await ChatClient.getInstance.chatRoomManager.addChatRoomAdmin(
    roomId,
    memberId,
  );
} on ChatError catch (e) {
}
```

#### Remove a chat room admin

Only the chat room owner can call `removeChatRoomAdmin` to remove an admin. Once demoted to a regular member, the former admin and the other chat room admins receive the `ChatRoomEventListener#onAdminRemovedFromChatRoom` callback.

The following code sample shows how to remove a chat room admin:

```dart
try {
  await ChatClient.getInstance.chatRoomManager.removeChatRoomAdmin(
    roomId,
    adminId,
  );
} on ChatError catch (e) {
}
```

### Listen for chat room events

For details, see [Chat Room Events](./agora_chat_chatroom_flutter#listen-for-chat-room-events).