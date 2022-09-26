Chat rooms enable real-time messaging among multiple users.

This page shows how to use the Agora Chat SDK to manage the attributes of a chat room in your app.

## Understand the tech

The Agora Chat SDK provides the `ChatManager` and `ChatRoom` classes for chat room management, which allows you to implement the following features:

- Update the name of a chat room
- Update the description of a chat room
- Retrieve the announcements of a chat room
- Update the announcements of a chat room


## Prerequisites

Before proceeding, ensure that you meet the following requirements:

- You have initialized the Agora Chat SDK. For details, see [Get Started with Android](./agora_chat_get_started_android?platform=Android).
- You understand the call frequency limit of the Agora Chat APIs supported by different pricing plans as described in [Limitations](./agora_chat_limitation?platform=Android).
- You understand the number of chat rooms supported by different pricing plans as described in [Pricing Plan Details](./agora_chat_plan?platform=Android).


## Implementation

This section introduces how to call the APIs provided by the Agora Chat SDK to implement the features listed above.

### Retrieve and modify the chat room attributes

All the chat room members can call `fetchChatRoomFromServer` to retrieve the detailed information of the current chat room, including the subject, annoucenments, description, member type, and admin list. The chat room owner and admin can also set and update the chat room information.

```java
// The chat room member call fetchChatRoomFromServer to get the information of the specifeid chat room.
ChatRoom chatRoom = ChatClient.getInstance().chatroomManager().fetchChatRoomFromServer(chatRoomId);

// The chat room owner and admin call changeChatRoomSubject to modify the chat room subject.
ChatRoom chatRoom = ChatClient.getInstance().chatroomManager().changeChatRoomSubject(chatRoomId, newSubject);

// The chat room owner and admin call changeChatroomDescription to modify the chat room description.
ChatRoom chatRoom = ChatClient.getInstance().chatroomManager().changeChatroomDescription(chatRoomId, newDescription);
```


### Manage chat room announcements

All the chat room members can retrieve the chat room announcements. The chat room owner and admin can set and update the announcements. Once the announcements are updated, all the chat room members receive the `onAnnouncementChanged` callback.

```java
// Chat room members can call fetchChatRoomAnnouncement to retrieve the chat room annoucements.
String announcement = ChatClient.getInstance().chatroomManager().fetchChatRoomAnnouncement(chatRoomId);

// The chat room owner and admin can call updateChatRoomAnnouncement to set or update the chat room announcements.
ChatClient.getInstance().chatroomManager().updateChatRoomAnnouncement(chatRoomId, announcement);
```

### Listen for chat room events

For details, see [Chat Room Events](./agora_chat_chatroom_android?platform=Android#listen-for-chat-room-events).