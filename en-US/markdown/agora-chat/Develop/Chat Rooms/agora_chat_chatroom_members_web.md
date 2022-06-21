# Manage Chat Room Members

Chat rooms enable real-time messaging among multiple users.

This page shows how to use the Agora Chat SDK to manage the members of a chat room in your app.

## Understand the tech

The Agora Chat SDK allows you to implement the following features:

- Retrieve the member list of a chat room
- Manage the block list of a chat room
- Manage the mute list of a chat room
- Mute and unmute all the chat room members
- Manage the chat room allow list
- Manage the admins of a chat room


## Prerequisites

Before proceeding, ensure that you meet the following requirements:

- You have initialized the Agora Chat SDK. For details, see [Get Started with Web](./agora_chat_get_started_web?platform=Web).
- You understand the call frequency limit of the Agora Chat APIs supported by different pricing plans as described in [Limitations](./agora_chat_limitation?platform=Web).
- You understand the number of chat rooms supported by different pricing plans as described in [Pricing Plan Details](./agora_chat_plan?platform=Web).


## Implementation

This section introduces how to call the APIs provided by the Agora Chat SDK to implement the features listed above.

### Retrieve the chat room member list

All chat room members can call `listChatRoomMembers` to retrieve the member list of the current chat room.

```javascript
let option = {
    pageNum: 1,
    pageSize: 10,
    chatRoomId: 'chatRoomId'
}
conn.listChatRoomMembers(option).then(res => console.log(res))
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

// The chat room owner or admin can call unblockChatRoomMembers to remove the specified users from the block list.
let option = {
    chatRoomId: "chatRoomId",
    usernames: ["user1", "user2"] // The array of usernames
}
conn.let option = {
    chatRoomId: "chatRoomId",
    usernames: ["user1", "user2"] // The array of usernames
}
conn.unblockChatRoomMembers(option).then(res => console.log(res));(option).then(res => console.log(res));

// The chat room owner or admin can call getChatRoomBlocklist to retrieve the block list of the current chat room.
AgoraError *error = nil;
let option = {
    chatRoomId: "chatRoomId",
};
conn.getChatRoomBlocklist(option);
```


### Manage the chat room mute list

The chat room owner and admins can add and remove the specified members from the chat room mute list. Once a chat room member is added to the mute list, this member can no longer send chat room messages, not even after being added to the chat room allow list.

```javascript
// The chat room owner or admin can call muteChatRoomMember to add the specified user to the chat room block list.
// The muted member and all other chat room admins or owner receive the muteMember callback.
let option = {
    chatRoomId: "chatRoomId", // The ID of the chat room
    username: 'username',     // The username of the muted user
    muteDuration: -1000       // The mute duration. Unit: millisecond. The value of "-1000" means permanant mute.
};
conn.muteChatRoomMember(option).then(res => console.log(res))

// The chat room owner or admin can call unmuteChatRoomMember to remove the specified user from the chat room mute list.
// The unmuted member and all the other chat room admins or owner receive the unmuteMember callback.
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
// Once all the members are muted, these members receive the muteAllMembers callback.
let option = {
    chatRoomId: "chatRoomId"
};
conn.disableSendChatRoomMsg(option).then(res => console.log(res))

// The chat room owner or admin can call enableSendChatRoomMsg to unmute all the chat room members.
// Once all the members are unmuted, these members receive the unmuteAllMembers callback.
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
// The chat room owner or admin can call addUsersToChatRoomAllowlist to add the specified member to the chat room allow list.
let option = {
    chatRoomId: "chatRoomId",
    users: ["user1", "user2"] // The array of usernames
};
conn.addUsersToChatRoomAllowlist(option);

// The chat room owner or admin can call removeChatRoomAllowlistMember to remove the specified member from the chat room allow list.
let option = {
    chatRoomId: "chatRoomId",
    userName: "user"
}
conn.removeChatRoomAllowlistMember(option);

// Chat room members can call isInChatRoomAllowlist to check whether they are in the chat room allow list.
let option = {
    chatRoomId: "chatRoomId",
    userName: "user"
}
conn.isInChatRoomAllowlist(option);

// The chat room owner or admin can call getChatRoomAllowlist to retrieve the allow list of the current chat room.
let option = {
    chatRoomId: "chatRoomId"
}
conn.getChatRoomAllowlist(option).then(res => console.log(res));
```


### Manage the chat room admins

The chat room owner can add admins. Once added to the chat room admin list, the newly added admin and the other chat room admins receive the `setAdmin` callback.

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


### Listen for chat room events

For details, see [Chat Room Events](./agora_chat_chatroom_web?platform=Web#listen-for-chat-room-events).