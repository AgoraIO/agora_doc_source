# Manage Chat Rooms

Chat rooms enable real-time messaging among multiple users.

Chat rooms do not have a strict membership, and members do not retain any permanent relationship with each other. Once a chat room member goes offline, this member does not receive any push messages from the chat room and automatically leaves the chat room after 5 minutes. Chat rooms are widely applied in live broadcast use cases such as stream chat in Twitch.

This page shows how to use the Agora Chat SDK to create and manage a chat room in your app.


## Understand the tech

The Agora Chat SDK allows you to implement the following features:

- Create and destroy a chat room
- Join and leave a chat room
- Retrieve the chat room list from the server
- Retrieve the attributes of a chat room
- Listen for chat room events

## Prerequisites

Before proceeding, ensure that you meet the following requirements:

- You have initialized the Agora Chat SDK. For details, see [Get Started with Web](./agora_chat_get_started_web?platform=Web).
- You understand the call frequency limit of the Agora Chat APIs supported by different pricing plans as described in [Limitations](./agora_chat_limitation?platform=Web).
- You understand the number of chat rooms supported by different pricing plans as described in [Pricing Plan Details](./agora_chat_plan?platform=Web).
- Only the app super admin has the privilege of creating a chat room. Ensure that you have added an app super admin by calling the [super-admin RESTful API](./agora_chat_restful_chatroom_superadmin?platform=RESTful#adding-a-chat-room-super-admin).


## Implementation

This section introduces how to call the APIs provided by the Agora Chat SDK to implement the features listed above.

### Create and destroy a chat room

The [app super admin](agora_chat_restful_chatroom_superadmin) can create a chat room and set the chat room attributes such as the chat room name, description, and the maximum number of members. Once a chat room is created, the super admin automatically becomes the chat room owner.

Only the chat room owner can disband a chat room. Once a chat room is disbanded, all members of that chat room are immediately removed from the chat room.

```javascript
// The super admin can call createChatRoom to create a chat room.
let options = {
    name: 'chatRoomName', // The name of the chat room
    description: 'description', // The description of the chat room
    maxusers: 200, // The maximum number of members. Default value: 200. Maximum value: 5,000.
    members: ['user1', 'user2'] // (Optional) The chat room members. Specify at least one user.
}
conn.createChatRoom(options).then(res => console.log(res))

// The chat room owner can call destroyChatRoom to disband a chat room.
let option = {
    chatRoomId: 'chatRoomId'
}
conn.destroyChatRoom(option).then(res => console.log(res))
```

### Join and leave a chat room

All chat users can call `joinChatRoom` to join the specified chat room. Once a chat user joins a chat room, all the other chat room members receive the `memberPresence` callback.

All chat room members can call `leaveChatRoom` to leave the specified chat room. Once a chat room member leaves a chat room, all the other members receive the `memberAbsence` callback.

```javascript
// All chat users can call joinChatRoom to join the specified chat room.
let option = {
    roomId: 'roomId',
    message: 'reason'
}
conn.joinChatRoom(option).then(res => console.log(res))

// All chat room members can call leaveChatRoom to leave the specified chat room.
let option = {
    roomId: 'roomId'
}
conn.leaveChatRoom(option).then(res => console.log(res))
```

### Retrieve the chat room list and attributes

All chat users can get the chat room list from the server and retrieve the basic information of the specified chat room using the chat room ID.

```javascript
// Chat room members can call getChatRooms to retrieve the specified number of chat rooms from the server by page. The maximum value of pageSize is 1,000.
let option = {
    pagenum: 1,
    pagesize: 20
};
conn.getChatRooms(option).then(res => console.log(res))
														
// Chat room members can call getChatRoomDetails to get the basic information of the specified chat room by passing the chat room ID.
let option = {
    chatRoomId: 'chatRoomId'
}
conn.getChatRoomDetails(option).then(res => console.log(res))
```


### Listen for chat room events

To monitor the chat room events, you can call `addEventHandler` to listen for the callbacks and add app logics accordingly.

```javascript
conn.addEventHandler("eventName", {
  onGroupEvent: function(msg){
    switch(msg.operation){
         // Occurs when all the chat room members are unmuted.
        case 'unmuteAllMembers':
            break;
        // Occurs when all the chat room members are muted.
        case 'muteAllMembers':
            break;
        // Occurs when a member is removed from the chat room allow list.
        case 'removeAllowlistMember':
            break;
        // Occurs when a member is added to the chat room allow list.
        case 'addUserToAllowlist':
            break;
        // Occurs when a member deletes a chat room announcement.
        case 'deleteAnnouncement':
            break;
        // Occurs when a member updates a chat room announcement.
        case 'updateAnnouncement':
            break;
        // Occurs when a member is removed from the chat room mute list.
        case 'unmuteMember':
            break;
        // Occurs when a member is added to the chat room mute list.
        case 'muteMember':
            break;
        // Occurs when a chat room admin is removed from the admin list.
        case 'removeAdmin':
            break;
        // Occurs when a chat room member is added to the admin list.
        case 'setAdmin':
            break;
        // Occurs when the chat room owner is changed.
        case 'changeOwner':
            break;
        // Occurs when a chat room member leaves a chat room.
        case 'memberAbsence':
            break;
        // Occurs when a user joins a chat room.
        case 'memberPresence':
            break;
        default:
            break;
    }
  }
})
```