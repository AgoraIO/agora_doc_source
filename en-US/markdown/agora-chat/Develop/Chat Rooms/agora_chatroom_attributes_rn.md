Chat room attributes consist of basic attributes (such as room subject, room description, and room announcement) and custom attributes. When basic attributes cannot satisfy the business requirements, users can add custom attributes that are synchronized with all chat room members. 
Custom attributes can be used to store information such as chat room type, game roles, game status, and host positions. They are stored as key-value maps, and the updates of custom attributes are synchronized with all chat room members.

This page shows how to use the Agora Chat SDK to manage basic and custom attributes of chat rooms in your app.

## Understand the tech

The Agora Chat SDK provides the `ChatManager` and `ChatRoom` classes for chat room management, which allow you to implement the following features:

- Retrieve or modify basic attributes of a chat room
- Retrieve custom attributes of a chat room
- Set custom attributes of a chat room
- Remove custom attributes of a chat room

## Prerequisites

Before proceeding, ensure that you meet the following requirements:

- You have initialized the Agora Chat SDK. For details, see [Get Started with React Native](./agora_chat_get_started_rn).
- You understand the call frequency limit of the Agora Chat APIs supported by different pricing plans as described in [Limitations](./agora_chat_limitation).
- You understand the number of chat rooms supported by different pricing plans as described in [Pricing Plan Details](./agora_chat_plan).

## Implementation

This section introduces how to call the APIs provided by the Agora Chat SDK to implement the features listed above.

### Manage basic chat room attributes

#### Retrieve basic chat room attributes

All the chat room members can call `fetchChatRoomInfoFromServer` to retrieve the detailed information of the current chat room, including the subject, announcement, description, member type, and admin list. 

```typescript
// Chat room members can call fetchChatRoomInfoFromServer to retrieve the basic attributes of the chat room.
ChatClient.getInstance()
  .roomManager.fetchChatRoomInfoFromServer(roomId)
  .then((response) => {
    rollLog(`success: ${response}`);
  })
  .catch((error) => {
    rollLog(`fail: ${error}`);
  });
```

#### Change the chat room subject or description

Only the chat room owner and admin can set and update the chat room subject and description.

```typescript
// The chat room owner and admin call changeChatRoomSubject to change the chat room subject.
ChatClient.getInstance()
  .roomManager.changeChatRoomSubject(roomId, subject)
  .then((response) => {
    rollLog(`success: ${response}`);
  })
  .catch((error) => {
    rollLog(`fail: ${error}`);
  });

// The chat room owner and admin call changeChatroomDescription to modify the chat room description.
ChatClient.getInstance()
  .roomManager.changeChatRoomDescription(roomId, desc)
  .then((response) => {
    rollLog(`success: ${response}`);
  })
  .catch((error) => {
    rollLog(`fail: ${error}`);
  });
```

#### Retrieve or change the chat room announcement

All chat room members can retrieve the chat room announcement. 

Only the chat room owner and admin can set and update the announcement. Once the announcement is updated, all the other chat room members receive the `onAnnouncementChanged` callback.

```typescript
// Chat room members can call fetchChatRoomAnnouncement to retrieve the chat room announcement.
ChatClient.getInstance()
  .roomManager.fetchChatRoomAnnouncement(roomId)
  .then((response) => {
    rollLog(`success: ${response}`);
  })
  .catch((error) => {
    rollLog(`fail: ${error}`);
  });

// The chat room owner and admin can call updateChatRoomAnnouncement to set or update the chat room announcement.
ChatClient.getInstance()
  .roomManager.updateChatRoomAnnouncement(roomId, announcement)
  .then((response) => {
    rollLog(`success: ${response}`);
  })
  .catch((error) => {
    rollLog(`fail: ${error}`);
  });
```

### Manage custom chat room attributes

#### Retrieve specified or all custom attributes 

All chat room members can call `fetchChatRoomAttributes` to retrieve the specified or all custom attributes of the chat room.

```typescript
// Retrieves certain custom attributes by specifying chat room ID and attribute keys.
// Retrieves all custom attributes if you pass an empty key.
ChatClient.getInstance()
  .roomManager.fetchChatRoomAttributes(roomId, keys)
  .then((response) => {
    rollLog(`success: ${response}`);
  })
  .catch((error) => {
    rollLog(`fail: ${error}`);
  });
```

#### Set one or more custom attributes

All chat room members can call `addAttributes` to set one or more custom attribute. Use this method to add new custom attributes or update existing attributes that are set by yourself and others. After you successfully call this method, other members in the chat room receive an `onAttributesUpdated` callback. 

```typescript
// Sets custom attribute by specifying the chat room ID and the key-value maps of the attributes.
ChatClient.getInstance()
  .roomManager.addAttributes({
    roomId,
    attributes,
    deleteWhenLeft,
    overwrite,
  })
  .then((response) => {
    rollLog(`success: ${response}`);
  })
  .catch((error) => {
    rollLog(`fail: ${error}`);
  });
```

#### Remove one or more custom attributes

All chat room members can call `removeAttributes` to remove one or more custom attributes that are set by themselves and others. After you successfully call this method, other members in the chat room receive an `onAttributesRemoved` callback. 

```typescript
// Removes custom attributes by specifying the chat room ID and the attribute key list.
ChatClient.getInstance()
  .roomManager.removeAttributes({
    roomId,
    keys,
    forced,
  })
  .then((response) => {
    rollLog(`success: ${response}`);
  })
  .catch((error) => {
    rollLog(`fail: ${error}`);
  });
```

### Listen for chat room events

For details, see [Chat Room Events](./agora_chat_chatroom_rn#listen-for-chat-room-events).