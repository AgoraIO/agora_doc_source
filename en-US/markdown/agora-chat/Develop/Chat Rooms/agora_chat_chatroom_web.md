# Implement Chat Room Workflow

Chat rooms enable real-time messaging among multiple users.

Chat rooms do not have a strict membership, and members do not retain any permanent relationship with each other. Once a chat room member goes offline, this member does not receive any push messages from the chat room and automatically leaves the chat room in 5 minutes. Chat rooms are widely applied in live broadcast use cases as stream chat in Twitch.

This page describes how to use the Agora Chat SDK to create and manage a chat room in your app.


## Understand the tech

The Agora Chat SDK allows you to implement the following features:
- Create and destroy a chat room
- Join and leave a chat room
- Retrieve the chat room list
- Retrieve chat room member list
- Manage the attributes and announcements of a chat room


## Prerequisites

Before proceeding, ensure that you meet the following requirements:
- You have initialized the Agora Chat SDK. For details, see [Get Started with Web](agora_chat_get_started_web).
- You understand the call frequency limits of the Agora Chat APIs supported by different pricing plans as described in [Limitations](agora_chat_limitation).
- You understand the number of chat rooms supported by different pricing plans as described in [Pricing Plan Details](agora_chat_plan).
- Only the app super admin has the privilege of creating a chat room. Ensure that you have added an app super admin by calling the [super-admin RESTful API](agora_chat_restful_chatroom_superadmin).


## Implementation

This section describes how to call the APIs provided by the Agora Chat SDK to implement the chat room features.

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


### Retrieve the chat room list

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


### Join and leave a chat room

All chat users can call `joinChatRoom` to join the specified chat room. Once a chat user joins a chat room, all the other chat room members receive the `memberJoinChatRoomSuccess` callback.

All chat room members can call `quitChatRoom` to leave the specified chat room. Once a chat room member leaves a chat room, all the other members receive the `leaveChatRoom` callback.

```javascript
// All chat users can call joinChatRoom to join the specified chat room.
let option = {
    roomId: 'roomId',
    message: 'reason'
}
conn.joinChatRoom(option).then(res => console.log(res))

// All chat room members can call quitChatRoom to leave the specified chat room.
let option = {
    roomId: 'roomId'
}
conn.quitChatRoom(option).then(res => console.log(res))
```


### Retrieve and modify the chat room attributes

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


### Retrieve the chat room member list

All chat room members can call `listChatRoomMember` to retrieve the member list of the current chat room.

```javascript
let option = {
    pageNum: 1,
    pageSize: 10,
    chatRoomId: 'chatRoomId'
}
conn.listChatRoomMember(option).then(res => console.log(res))
```


### Manage the chat room block list

The chat room owner and admins can add and remove the specified members from the chat room block list. Once a chat room member is added to the block list, this member cannot send or receive chat room messages, nor can they join the chat room again.

```javascript
// The chat room owner or admin can call blockChatRoomMembers to add the specified members to the chat room block list.
let option = {
    chatRoomId: 'chatRoomId',
    usernames: ['user1', 'user2'] // The array of usernames
};
conn.blockChatRoomMembers(option).then(res => console.log(res));

// The chat room owner or admin can call removeChatRoomBlockMulti to remove the specified users from the block list.
let option = {
    chatRoomId: "chatRoomId",
    usernames: ["user1", "user2"] // The array of usernames
}
conn.let option = {
    chatRoomId: "chatRoomId",
    usernames: ["user1", "user2"] // The array of usernames
}
conn.removeChatRoomBlockMulti(option).then(res => console.log(res));(option).then(res => console.log(res));

// The chat room owner or admin can call getChatRoomBlacklist to retrieve the block list of the current chat room.
AgoraError *error = nil;
let option = {
    chatRoomId: "chatRoomId",
};
conn.getChatRoomBlacklist(option);
```


### Manage the chat room mute list

The chat room owner and admins can add and remove the specified members from the chat room mute list. Once a chat room member is added to the mute list, this member can no longer send chat room messages, not even after being added to the chat room allow list.

```javascript
// The chat room owner or admin can call muteChatRoomMember to add the specified user to the chat room block list.
// The muted member and all other chat room admins or owner receive the addMute callback.
let option = {
    chatRoomId: "chatRoomId", // The ID of the chat room
    username: 'username',     // The username of the muted user
    muteDuration: -1000       // The mute duration. Unit: millisecond. The value of "-1000" means permanant mute.
};
conn.muteChatRoomMember(option).then(res => console.log(res))

// The chat room owner or admin can call unmuteChatRoomMember to remove the specified user from the chat room mute list.
// The unmuted member and all the other chat room admins or owner receive the removeMute callback.
let option = {
    chatRoomId: "chatRoomId",
    username: 'username'
};
conn.unmuteChatRoomMember(option).then(res => console.log(res))

// The chat room owner or admin can call getChatRoomMuteList to retrieve the mute list of the current chat room.
let option = {
    chatRoomId: "chatRoomId"
};
conn.getChatRoomMuteList(option).then(res => console.log(res))
```


### Mute and unmute all chat room members

The chat room owner and admins can mute or unmute all chat room members. Once all members are muted, only those in the chat room allow list can send messages in the chat room.

```javascript
// The chat room owner or admin can call disableSendChatRoomMsg to mute all the chat room members.
// Once all the members are muted, these members receive the onAllMemberMuteStateChanged callback.
let option = {
    chatRoomId: "chatRoomId"
};
conn.disableSendChatRoomMsg(option).then(res => console.log(res))

// The chat room owner or admin can call enableSendChatRoomMsg to unmute all the chat room members.
// Once all the members are unmuted, these members receive the onAllMemberMuteStateChanged callback.
let option = {
    chatRoomId: "chatRoomId"
};
conn.enableSendChatRoomMsg(option).then((res) => {
    console.log(res)
})
```


### Manage the chat room allow list

Members in the chat room allow list can send chat room messages even when the chat room owner or an admin has muted all the chat room members. However, if a member is already in the chat room mute list, adding this member to the allow list does not take effect.

```javascript
// The chat room owner or admin can call addUsersToChatRoomWhitelist to add the specified member to the chat room allow list.
let option = {
    chatRoomId: "chatRoomId",
    users: ["user1", "user2"] // The array of usernames
};
conn.addUsersToChatRoomWhitelist(option);

// The chat room owner or admin can call removeChatRoomWhitelistMember to remove the specified member from the chat room allow list.
let option = {
    chatRoomId: "chatRoomId",
    userName: "user"
}
conn.removeChatRoomWhitelistMember(option);

// Chat room members can call isChatRoomWhiteUser to check whether they are in the chat room allow list.
let option = {
    chatRoomId: "chatRoomId",
    userName: "user"
}
conn.isChatRoomWhiteUser(option);

// The chat room owner or admin can call getChatRoomWhitelist to retrieve the allow list of the current chat room.
let option = {
    chatRoomId: "chatRoomId"
}
conn.getChatRoomWhitelist(option).then(res => console.log(res));
```


### Manage the chat room admins

The chat room owner can add admins. Once added to the chat room admin list, the newly added admin and the other chat room admins receive the `addAdmin` callback.

The chat room owner can remove admins. Once removed from the chat room admin list, the removed admin and the other chat room admins receive the `removeAdmin` callback.

```javascript
// The chat room owner can call setChatRoomAdmin to add admins.
let option = {
    chatRoomId: 'chatRoomId',
    username: 'user1'
}
conn.setChatRoomAdmin(option).then(res => console.log(res))

// The chat room owner can call removeChatRoomAdmin to remove admins.
let option = {
    chatRoomId: 'chatRoomId',
    username: 'user1'
}
conn.removeChatRoomAdmin(option).then(res => console.log(res))
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

To monitor the chat room events, you can call `listen` to listen for the callbacks and add app logics accordingly.

```javascript
conn.listen({
  onPresence: function(msg){
    switch(msg.type){
        // Occurs when all the chat room members are unmuted.
        case 'rmChatRoomMute':
            break;
        // Occurs when all the chat room members are muted.
        case 'muteChatRoom':
            break;
        // Occurs when a member is removed from the chat room allow list.
        case 'rmUserFromChatRoomWhiteList':
            break;
        // Occurs when a member is added to the chat room allow list.
        case 'addUserToChatRoomWhiteList':
            break;
        // Occurs when a member deletes a chat room announcement.
        case 'deleteAnnouncement':
            break;
        // Occurs when a member updates a chat room announcement.
        case 'updateAnnouncement':
            break;
        // Occurs when a member is removed from the chat room mute list.
        case 'removeMute':
            break;
        // Occurs when a member is added to the chat room mute list.
        case 'addMute':
            break;
        // Occurs when a chat room admin is removed from the admin list.
        case 'removeAdmin':
            break;
        // Occurs when a chat room member is added to the admin list.
        case 'addAdmin':
            break;
        // Occurs when the chat room owner is changed.
        case 'changeOwner':
            break;
        // Occurs when a chat room member leaves a chat room.
        case 'leaveChatRoom':
            break;
        // Occurs when a user joins a chat room.
        case 'memberJoinChatRoomSuccess':
            break;
        default:
            break;
    }}
})
```