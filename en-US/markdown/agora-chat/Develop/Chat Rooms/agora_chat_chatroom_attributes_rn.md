# Manage Chat Room Attributes

Chat rooms enable real-time messaging among multiple users.

This page shows how to use the Agora Chat SDK to manage the attributes of a chat room in your app.

## Understand the tech

The Agora Chat SDK provides the `ChatRoom`, `ChatRoomManager`, and `ChatRoomEventListener` classes for chat room management, which allows you to implement the following features:

- Retrieve the announcements of a chat room
- Update the announcements of a chat room
- Update the name of a chat room
- Update the description of a chat room

## Prerequisites

Before proceeding, ensure that you meet the following requirements:

- You have initialized the Agora Chat SDK. For details, see [Get Started with RN](https://docs-preprod.agora.io/en/agora-chat/agora_chat_get_started_rn).
- You understand the call frequency limit of the Agora Chat APIs supported by different pricing plans as described in [Limitations](https://docs-preprod.agora.io/en/agora-chat/agora_chat_limitation).
- You understand the number of chat rooms supported by different pricing plans as described in [Pricing Plan Details](https://docs-preprod.agora.io/cn/agora-chat/agora_chat_plan).

## Implementation

This section describes how to call the APIs provided by the Agora Chat SDK to implement chat room features.

### Retrieve the chat room announcements

All chat room members can call `fetchChatRoomAnnouncement` to retrieve the chat room announcements.

The following code sample shows how to retrieve the chat room announcements:

```typescript
ChatClient.getInstance()
  .roomManager.fetchChatRoomAnnouncement(roomId)
  .then((ann) => {
    console.log("get ann success.", ann);
  })
  .catch((reason) => {
    console.log("get ann fail.", reason);
  });
```

### Update the chat room announcements

Only the chat room owner and admins can call `updateChatRoomAnnouncement` to set and update the announcements. The length of the chat room announcements can be a maximum of 512 characters. Once the chat room announcements are updated, all the other chat room members receive the `onAnnouncementChanged` callback.

The following code sample shows how to update the chat room announcements:

```typescript
ChatClient.getInstance()
  .roomManager.updateChatRoomAnnouncement(roomId, announcement)
  .then(() => {
    console.log("update ann success.");
  })
  .catch((reason) => {
    console.log("update ann fail.", reason);
  });
```

### Update the chat room name

The chat room owner and admins can call `changeChatRoomSubject` to set and update the chat room name. The length of a chat room name can be a maximum of 128 characters.

The following code sample shows how to update the chat room name:

```typescript
ChatClient.getInstance()
  .roomManager.changeChatRoomSubject(roomId, subject)
  .then(() => {
    console.log("change subject success.");
  })
  .catch((reason) => {
    console.log("change subject fail.", reason);
  });
```

### Update the chat room description

The chat room owner and admins can call `changeChatRoomDescription` to set and update the chat room description. The length of a chat room description can be a maximum of 512 characters.

The following code sample shows how to update the chat room description:

```typescript
ChatClient.getInstance()
  .roomManager.changeChatRoomDescription(roomId, desc)
  .then(() => {
    console.log("change desc success.");
  })
  .catch((reason) => {
    console.log("change desc fail.", reason);
  });
```

### Listen for chat room events

For details, see [Chat Room Events](https://docs-preprod.agora.io/en/agora-chat/agora_chat_chatroom_rn?platform=React%20Native#listen-for-chat-room-events).