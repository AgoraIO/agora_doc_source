Chat rooms enable real-time messaging among multiple users.

Chat rooms do not have a strict membership, and members do not retain any permanent relationship with each other. Once a chat room member goes offline, this member does not receive any push messages from the chat room and automatically leaves the chat room after 5 minutes. Chat rooms are widely applied in live broadcast use cases such as stream chat in Twitch.

This page shows how to use the Agora Chat SDK to create and manage a chat room in your app.


## Understand the tech

The Agora Chat SDK provides the `ChatRoom`, `ChatRoomManager`, and `ChatRoomEventHandler` classes for chat room management, which allows you to implement the following features:

- Create and destroy a chat room
- Join and leave a chat room
- Retrieve the attributes of a chat room
- Retrieve the chat room list from the server
- Listen for chat room events


## Prerequisites

Before proceeding, ensure that you meet the following requirements:

- You have initialized the Agora Chat SDK. For details, see [Get Started with Flutter](./agora_chat_get_started_flutter).
- You understand the call frequency limit of the Agora Chat APIs supported by different pricing plans as described in [Limitations](./agora_chat_limitation).
- You understand the number of chat rooms supported by different pricing plans as described in [Pricing Plan Details](./agora_chat_plan).
- Only the app super admin has the privilege of creating a chat room. Ensure that you have added an app super admin by [calling the super-admin RESTful API](./agora_chat_restful_chatroom_superadmin#adding-a-chat-room-super-admin).


## Implementation

This section describes how to call the APIs provided by the Agora Chat SDK to implement chat room features.

### Create a chat room

Only the [app super admin](./agora_chat_restful_chatroom_superadmin#adding-a-chat-room-super-admin) can call `createChatRoom` to create a chat room and set the chat room attributes such as the chat room name, description, and maximum number of members. Once a chat room is created, the super admin automatically becomes the chat room owner.

The following code sample shows how to create a chat room:

```dart
try {
  ChatRoom room = await ChatClient.getInstance.chatRoomManager.createChatRoom(name);
} on ChatError catch (e) {
}
```

### Destroy a chat room

Only the chat room owner can call `destroyChatRoom` to disband a chat room. Once a chat room is disbanded, all chat room members receive the `ChatRoomEventHandler#onChatRoomDestroyed` callback and are immediately removed from the chat room.

The following code sample shows how to destroy a chat room:

```dart
try {
  await ChatClient.getInstance.chatRoomManager.destroyChatRoom(roomId);
} on ChatError catch (e) {
}
```

### Join a chat room

Refer to the following steps to join a chat room:

1. Call [`fetchPublicChatRoomsFromServer`](#retrieve-the-chat-room-list-from-the-server) to retrieve the list of chat rooms from the server and locate the ID of the chat room that you want to join.

2. Call `joinChatRoom` to pass in the chat room ID and join the specified chat room. Once a user joins a chat room, all the other chat room members receive the `ChatRoomEventHandler#onMemberJoinedFromChatRoom` callback.

The following code sample shows how to join a chat room:

```dart
try {
   await ChatClient.getInstance.chatRoomManager.joinChatRoom(roomId);
} on ChatError catch (e) {
}
```

### Leave a chat room

All chat room members can call `leaveChatRoom` to leave the specified chat room. Once a member leaves the chat room, all the other chat room members receive the `ChatRoomEventHandler#onMemberExitedFromChatRoom` callback.

<div class=alert note> Unlike chat group owners (who cannot leave their groups), a chat room owner can leave a chat room. After re-entering the chat room, this user remains the chat room owner.</div>

The following code sample shows how to leave a chat room:

```dart
try {
   await ChatClient.getInstance.chatRoomManager.leaveChatRoom(roomId);
} on ChatError catch (e) {
}
```

By default, after a user leaves a chat room, the Agora Chat SDK removes all chat room messages on the local device. If you do not want these messages removed, set `ChatOptions#deleteMessagesAsExitChatRoom` to `false` when initializing the SDK.

The following code sample shows how to retain the chat room messages after leaving a chat room:

```dart
ChatOptions options = ChatOptions(
      appKey: "<#Your AppKey#>",
      deleteMessagesAsExitChatRoom: false,
    );
```

### Retrieve the chat room attributes

All chat room members can call `fetchChatRoomInfoFromServer` to retrieve the attributes of the a chat room, including the chat room ID, name, description, announcements, owner, admin list, maximum number of members, and whether all members are muted.

The following code sample shows how to retrieve the chat room attributes:

```dart
try {
  ChatRoom room = await ChatClient.getInstance.chatRoomManager.fetchChatRoomInfoFromServer(roomId);
} on ChatError catch (e) {
}
```

### Retrieve the chat room list from the server

Users can call `fetchPublicChatRoomsFromServer` to retrieve the chat room list from the server.

```dart
try {
  ChatPageResult<ChatRoom> result = await ChatClient
      .getInstance.chatRoomManager
      .fetchPublicChatRoomsFromServer(
    // The page number from which to start retrieving chat rooms.
    pageNum: pageNum,
    // The maximum number of chat rooms to retrieve with pagination.
    pageSize: pageSize,
  );
} on ChatError catch (e) {
}
```

### Listen for chat room events

To monitor the chat room events, you can listen for the callbacks in the `ChatRoomEventHandler` class and add app logics accordingly. If you want to stop listening for the callback, make sure that you remove the listener to prevent memory leakage.

The following code sample shows how to add and remove the chat room event handler:

```dart
    // Adds the chat room event handler.
ChatClient.getInstance.chatRoomManager.addEventHandler(
  "UNIQUE_HANDLER_ID",
  ChatRoomEventHandler(
    // Occurs when the chat room ownership is transferred.
    onOwnerChangedFromChatRoom: (roomId, newOwner, oldOwner) {},
    // Occurs when chat room members are added to the mute list.
    onMuteListAddedFromChatRoom: (roomId, mutes, expireTime) {},
    // Occurs when chat room members are removed from the mute list.
    onMuteListRemovedFromChatRoom: (roomId, mutes) {},
    // Occurs when the chat room is destroyed.
    onChatRoomDestroyed: (roomId, roomName) {},
    // Occurs when the chat room specifications are changed. 
    onSpecificationChanged: (room) {},
    // Occurs when a user joins the chat room.
    onMemberJoinedFromChatRoom: (roomId, participant) {},
    // Occurs when a member leaves the chat room.
    onMemberExitedFromChatRoom: (roomId, roomName, participant) {},
    // Occurs when a member is removed from a chat room.
    onRemovedFromChatRoom: (roomId, roomName, participant) {},
    // Occurs when the chat room announcement is changed.
    onAnnouncementChangedFromChatRoom: (roomId, announcement) {},
    // Occurs when chat room members are added to the allow list.
    onAllowListAddedFromChatRoom: (roomId, members) {},
    // Occurs when chat room members are removed from the allow list.
    onAllowListRemovedFromChatRoom: (roomId, members) {},
    // Occurs when all chat room members are muted or unmuted.
    onAllChatRoomMemberMuteStateChanged: (roomId, isAllMuted) {},
    // Occurs when a member is promoted to an admin.
    onAdminAddedFromChatRoom: (roomId, admin) {},
    // Occurs when an admin is demoted to a member.
    onAdminRemovedFromChatRoom: (roomId, admin) {},
    // Occurs when the custom chat room attributes (key-value) are updated.
    onAttributesUpdated: (roomId, attributes, from) {},
    // Occurs when the custom chat room attributes (key-value) are removed.
    onAttributesRemoved: (roomId, keys, fromId) {},
  ),
);
    ...

    // Removes the chat room event handler.
    ChatClient.getInstance.chatRoomManager.removeEventHandler("UNIQUE_HANDLER_ID");
```