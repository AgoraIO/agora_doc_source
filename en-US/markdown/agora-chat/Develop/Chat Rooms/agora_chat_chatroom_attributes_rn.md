Chat room attributes consists of basic attributes (such as room name, room description, and room announcement) and custom attributes. When basic attributes cannot satisfy the business requirements, users can add custom attributes that are synchronized with all chat room members. 
Custom attributes can be used to store information such as chat room type, game roles, game status, and host positions. They are stored as key-value maps, and the updates of custom attributes are synchronized with all chat room members.

This page shows how to use the Agora Chat SDK to manage basic and custom attributes of chat rooms in your app.

## Understand the tech

The Agora Chat SDK provides the `ChatManager` and `ChatRoom` classes for chat room management, which allows you to implement the following features:

- Retrieve or modify basic attributes of a chat room
- Retrieve custom attributes of a chat room
- Set custom attributes of a chat room
- Remove custom attributes of a chat room

## Prerequisites

Before proceeding, ensure that you meet the following requirements:

- You have initialized the Agora Chat SDK. For details, see [Get Started with rn](./agora_chat_get_started_android?platform=rn).
- You understand the call frequency limit of the Agora Chat APIs supported by different pricing plans as described in [Limitations](./agora_chat_limitation?platform=rn).
- You understand the number of chat rooms supported by different pricing plans as described in [Pricing Plan Details](./agora_chat_plan?platform=rn).


## Implementation

This section introduces how to call the APIs provided by the Agora Chat SDK to implement the features listed above.

### Manage basic chat room attributes

#### Retrieve basic chat room attributes
All the chat room members can call `fetchChatRoomFromServer` to retrieve the detailed information of the current chat room, including the subject, announcements, description, member type, and admin list. 

```typescript
// The fetchPublicChatRoomsFromServer method returns basic attributes including ID, name, description, maximum members, owners, roles, and whether all members are muted.
ChatClient.getInstance()
  .roomManager.fetchPublicChatRoomsFromServer(pageNum, pageSize)
  .then((response) => {
    rollLog(`success: ${response}`);
  })
  .catch((error) => {
    rollLog(`fail: ${error}`);
  });
```

#### Change chat room subject or description
Only the chat room owner and admin can set and update the chat room subject and description.

```typescript
// The chat room owner and admin call changeChatRoomSubject to modify the chat room subject.
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

#### Retrieve or change chat room announcements
All the chat room members can retrieve the chat room announcements. 

Only the chat room owner and admin can set and update the announcements. Once the announcements are updated, all the chat room members receive the `onAnnouncementChanged` callback.

```typescript
// Chat room members can call fetchChatRoomAnnouncement to retrieve the chat room announcements.
ChatClient.getInstance()
  .roomManager.fetchChatRoomAnnouncement(roomId)
  .then((response) => {
    rollLog(`success: ${response}`);
  })
  .catch((error) => {
    rollLog(`fail: ${error}`);
  });

// The chat room owner and admin can call updateChatRoomAnnouncement to set or update the chat room announcements.
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
All chat room members can call `fetchChatRoomAttributes` to retrieve specified or all custom attributes of the chat room.

```typescript
// Retrieves certain custom attributes by specifying chat room ID and attribute keys. Get all if key is empty.
ChatClient.getInstance()
  .roomManager.fetchChatRoomAttributes(roomId, keys)
  .then((response) => {
    rollLog(`success: ${response}`);
  })
  .catch((error) => {
    rollLog(`fail: ${error}`);
  });
```

#### Set custom attribute
Chat room members can call `addAttributes` to set one single custom attribute. Use this method to add new custom attributes or update existing attributes that set by yourself. After you successfully call this method, other members in the chat room receive an `onAttributesUpdated` callback. 

```typescript
// Sets a custom attribute by specifying chat room ID, attribute key, attribute value, deleteWhenLeft and overwrite. \
// deleteWhenLeft means to delete the property when leaving the room.
// overwrite means forcibly overwrite properties of the same key.
// attributes can be an array, supporting multiple pairs of k-v attributes.
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

#### Remove custom attribute
Chat room members can call `asyncRemoveChatRoomAttributesFromServer` to remove one single custom attribute that is set by themselves. After you successfully call this method, other members in the chat room receive an `onAttributesRemoved` callback. 

```typescript
// Removes a custom attribute by specifying chat room ID, attribute keys and forced. 
// keys can make an array, delete multiple properties at the same time, and return an error message if it fails.
// forced means to force the removal of an attribute.
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