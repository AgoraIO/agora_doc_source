# Manage Chat Room Attributes

Chat rooms enable real-time messaging among multiple users.

This page shows how to use the Agora Chat SDK to manage the attributes of a chat room in your app.

## Understand the tech

The Agora Chat SDK allows you to implement the following features:

- Modify the chat room attributes
- Retrieve the announcements of a chat room
- Update the announcements of a chat room


## Prerequisites

Before proceeding, ensure that you meet the following requirements:

- You have initialized the Agora Chat SDK. For details, see [Get Started with Web](./agora_chat_get_started_web?platform=Web).
- You understand the call frequency limit of the Agora Chat APIs supported by different pricing plans as described in [Limitations](./agora_chat_limitation?platform=Web).
- You understand the number of chat rooms supported by different pricing plans as described in [Pricing Plan Details](./agora_chat_plan?platform=Web).


## Implementation

This section introduces how to call the APIs provided by the Agora Chat SDK to implement the features listed above.

### Modify the chat room attributes

All chat room members can retrieve the detailed information of the current chat room, including the subject, announcements, description, member type, and admin list.

The chat room owner and admins can also set and update the chat room information.

```javascript
// Chat room members can call getChatRoomDetails to get the information of the specified chat room.
AgoraError *error = nil;
let option = {
    chatRoomId: 'chatRoomId'
}
conn.getChatRoomDetails(option).then(res => console.log(res))

// The chat room owner and admins can call modifyChatRoom to update the chat room attributes.
let option = {
    chatRoomId: 'chatRoomId',
    chatRoomName: 'chatRoomName', // The name of the chat room
    description: 'description',   // The description of the chat room
    maxusers: 200                 // The maximum number of chat room members
}
conn.modifyChatRoom(option).then(res => console.log(res))
```

### Manage chat room announcements

All chat room members can retrieve the chat room announcements.

The chat room owner and admins can set and update the chat room announcements. Once the announcements are updated, all the chat room members receive the `updateAnnouncement` callback.

```javascript
// Chat room members can call fetchChatRoomAnnouncement to retrieve the chat room announcements.
var option = {
    roomId: 'roomId'                        
};
conn.fetchChatRoomAnnouncement(option).then(res => console.log(res))

// The chat room owner and admins can call updateChatRoomAnnouncement to set or update the chat room announcements.
let option = {
    roomId: 'roomId',  
    announcement: 'hello everyone'                  
};
conn.updateChatRoomAnnouncement(option).then(res => console.log(res))
```


### Listen for chat room events

For details, see [Chat Room Events](./agora_chat_chatroom_web?platform=Web#listen-for-chat-room-events).