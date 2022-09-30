Chat room attributes consist of basic attributes (such as room subject, room description, and room announcement) and custom attributes. When basic attributes cannot satisfy the business requirements, users can add custom attributes that are synchronized with all chat room members.
Custom attributes can be used to store information such as chat room type, game roles, game status, and host positions. They are stored as key-value maps, and the updates of custom attributes are synchronized with all chat room members.

This page shows how to use the Agora Chat SDK to manage basic and custom attributes of chat rooms in your app.


## Understand the tech

The Agora Chat SDK provides the `ChatRoom`, `ChatRoomManager`, and `ChatRoomEventHandler` classes for chat room management, which allow you to implement the following features:

- Retrieve or modify basic attributes of a chat room
- Retrieve custom attributes of a chat room
- Set custom attributes of a chat room
- Remove custom attributes of a chat room

## Prerequisites

Before proceeding, ensure that you meet the following requirements:

- You have initialized the Agora Chat SDK. For details, see [Get Started with Flutter](./agora_chat_get_started_flutter).
- You understand the call frequency limit of the Agora Chat APIs supported by different pricing plans as described in [Limitations](./agora_chat_limitation).
- You understand the number of chat rooms supported by different pricing plans as described in [Pricing Plan Details](./agora_chat_plan).

## Implementation

This section introduces how to call the APIs provided by the Agora Chat SDK to implement the features listed above.

### Manage basic chat room attributes

#### Retrieve basic chat room attributes

 All chat room members can call `fetchChatRoomInfoFromServer` to retrieve the basic attributes of a chat room, including the chat room ID, name, description, announcement, owner, admin list, maximum number of members, and whether all members are muted.

The following code sample shows how to retrieve basic chat room attributes:

```dart
// Chat room members can call fetchChatRoomInfoFromServer to retrieve the basic attributes of a chat room.
try {
  ChatRoom room = await ChatClient.getInstance.chatRoomManager.fetchChatRoomInfoFromServer(roomId);
} on ChatError catch (e) {
}
``` 

#### Change the chat room subject or description

Only the chat room owner and admin can set and update the chat room subject and description.

```dart
// The chat room owner and admin can call changeChatRoomName to change the chat room subject.
try {
  await ChatClient.getInstance.chatRoomManager.changeChatRoomName(
    roomId,
    newName,
  );
} on ChatError catch (e) {
}

// The chat room owner and admin call changeChatRoomDescription to modify the chat room description.
try {
  await ChatClient.getInstance.chatRoomManager.changeChatRoomDescription(
    roomId,
    newDesc,
  );
} on ChatError catch (e) {
}
```

#### Retrieve or change the chat room announcement

All chat room members can retrieve the chat room announcement. 

Only the chat room owner and admin can set and update the announcement. Once the announcement is updated, all the other chat room members receive the `ChatRoomEventHandler#onAnnouncementChangedFromChatRoom` callback.

```dart
// Chat room members can call fetchChatRoomAnnouncement to retrieve the chat room announcement.
try {
  String? announcement =
      await ChatClient.getInstance.chatRoomManager.fetchChatRoomAnnouncement(
    roomId,
  );
} on ChatError catch (e) {
}
// The chat room owner and admin can call updateChatRoomAnnouncement to set or update the chat room announcement.
try {
  await ChatClient.getInstance.chatRoomManager.updateChatRoomAnnouncement(
    roomId,
    newAnnouncement,
  );
} on ChatError catch (e) {
}
```

### Manage custom chat room attributes

#### Retrieve specified or all custom attributes

All chat room members can call `fetchChatRoomAttributes` to retrieve the specified or all custom attributes of the chat room.

```dart
// Retrieves certain or all custom attributes by specifying chat room ID and attribute keys.
try {
    Map<String, String>? attributes =
        await ChatClient.getInstance.chatRoomManager.fetchChatRoomAttributes(
        roomId,
        keys,
    );
} on ChatError catch (e) {}
```

#### Set custom attributes

Chat room members can call `addAttributes` to set one or more custom attributes. Use this method to add new custom attributes or update existing attributes that are set by yourself and others. After you successfully call this method, other members in the chat room receive an `EMChatRoomEventHandler#onAttributesUpdated` callback.

```dart
// Sets a custom attribute by specifying the chat room ID and the key-value maps of the attributes. 
try {
  Map<String, int>? failInfo =
      await ChatClient.getInstance.chatRoomManager.addAttributes(
    "room",
    attributes: kv,
    deleteWhenLeft: true,
    overwrite: true,
  );
} on ChatError catch (e) {}
```

#### Remove custom attributes

Chat room members can call `removeAttributes` to remove one or more custom attributes. After you successfully call this method, other members in the chat room receive an `EMChatRoomEventHandler#onAttributesRemoved` callback.

```dart
// Removes custom attributes by specifying the chat room ID and the attribute key list. 
try {
  Map<String, int>? failInfo =
      await ChatClient.getInstance.chatRoomManager.removeAttributes(
    roomId,
    keys: keys,
    force: true,
  );
} on ChatError catch (e) {}
```

### Listen for chat room events

For details, see [Chat Room Events](./agora_chat_chatroom_flutter#listen-for-chat-room-events).