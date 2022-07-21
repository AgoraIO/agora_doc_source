Chat rooms enable real-time messaging among multiple users. Chat rooms do not have a strict membership, and members do not retain any permanent relationship with each other. Once a chat room member goes offline, this member does not receive any push messages from the chat room and automatically leaves the chat room in five minutes. Chat rooms are widely applied in live broadcast use cases as stream chat in Twitch.

This page shows how to use the Agora Chat SDK to create and manage a chat room in your app.

## Understand the tech

The Agora Chat SDK provides a `ChatManager` and a `ChatRoom` class for chat room management, which allows you to implement the following features:
- Create and destroy a chat room
- Join and leave a chat room
- Retrieve all the chat rooms from the server
- Manage chat room members
- Manage the chat room attributes and announcements

## Prerequistes

Before proceeding, ensure that you have the following:
- Initialized the SDK. For details, see [Get Started with Agora Chat](/agora_chat_get_started_android?platform=Android).
- Understand the call frequency limits of the Agora Chat APIs as described in [Limitations](/agora_chat_limitation_android?platform=Android).
- Understand the number of chat rooms supported by different pricing plans as described in [Pricing Plan Details](/agora_chat_limitation?platform=Android).
- Only the app super admin has the privilege of creating a chat room. Ensure that you have added an app super admin by calling the [super-admin RESTful API](./agora_chat_restful_chatroom_superadmin?platform=RESTful#adding-a-chat-room-super-admin).

## Implementation

This section introduces how to call the APIs provided by the Agora Chat SDK to implement chat room features.

### Create and destroy a chat room

[The app super admin](./agora_chat_restful_chatroom_superadmin?platform=RESTful#adding-a-chat-room-super-admin) can call `createChatRoom` to create a chat room and set the chat room attributes such as the chat room subject, description, and the maximum number of members. Once a chat room is created, the super admin automatically becomes the chat room owner.

```java
// The app super admin calls createChatRoom to create a chat room.
// Once the chat room is created, the super admin becomes the chat room owner.
ChatRoom  chatRoom = ChatClient.getInstance().chatroomManager().createChatRoom(subject, description, welcomMessage, maxUserCount, members);

// Only the chat room owner can call destroyChatRoom to disband the chat room.
// Once the chat room is disbanded, all members of that chat room receive the onChatRoomDestroyed callback and are immediately removed from the chat room.
ChatClient.getInstance().chatroomManager().destroyChatRoom(chatRoomId);
```

### Retrieve the chat room list

All chat users can get the chat room list from the server and retrieve the basic information of the specified chat room using the chat room ID.

```java
// Chat room members can call fetchPublicChatRoomsFromServer to get the specified number of chat rooms from the server. The maximum value of pageSize is 100.
PageResult<ChatRoom> chatRooms = ChatClient.getInstance().chatroomManager().
                            fetchPublicChatRoomsFromServer(pageNumber, pageSize);

// Chat room members can call fetchChatRoomFromServer to get the basic information of the specified chat room by passing the chat room ID.
ChatRoom chatRoom = ChatClient.getInstance().chatroomManager().fetchChatRoomFromServer(chatRoomId);
```

### Join and leave a chat room

All chat users can call `joinChatRoom` to join and `leaveChatRoom` to leave a specified chat room.

```java
// Once chat users successfully joins the chat room, all the other chat room members receive the onMemberJoined callback.
ChatClient.getInstance().chatroomManager().joinChatRoom(chatRoomId, new ValueCallBack<ChatRoom>() {
    @Override
    public void onSuccess(ChatRoom value) {

    }

    @Override
    public void onError(int error, String errorMsg) {

    }
});

// All chat room members can call leaveChatRoom to leave the specified chat room. Once a member leaves the chat room, all the other members receive the onMemberExited callback.
ChatClient.getInstance().chatroomManager().leaveChatRoom(chatRoomId);
```

By default, when you leave a chat room, the SDK removes all the chat room messages on the local device. If you do not want these messages removed, set `setDeleteMessagesAdExitChatRoom` in `ChatOptions` as `false`.

### Retrieve and modify the chat room attributes

All chat room members can call `fetchChatRoomFromServer` to retrieve the detailed information of the current chat room, including the subject, announcenments, description, member type, and admin list. The chat room owner and admin can also set and update the chat room information.

```java
// The chat room member can call fetchChatRoomFromServer to get the information of the specifeid chat room.
ChatRoom chatRoom = ChatClient.getInstance().chatroomManager().fetchChatRoomFromServer(chatRoomId);

// The chat room owner and admin can call changeChatRoomSubject to modify the chat room subject.
ChatRoom chatRoom = ChatClient.getInstance().chatroomManager().changeChatRoomSubject(chatRoomId, newSubject);

// The chat room owner and admin can call changeChatroomDescription to modify the chat room description.
ChatRoom chatRoom = ChatClient.getInstance().chatroomManager().changeChatroomDescription(chatRoomId, newDescription);
```

### Manage chat room members

All chat room members can call `fetchChatRoomMembers` to retrieve the member list of the current chat room.

```java
Map<String, Long> members = ChatClient.getInstance().chatroomManager().fetchChatRoomMembers(chatRoomId, cursor, pageSize);
```

The chat room owner and admin can call `removeChatRoomMember` to remove the specified member from the chat room. Once a member is removed, this member receives the `onRemovedFromChatRoom` callback, and all the other chat room members receive the `onMemberExited` callback. After being removed from a chat room, the chat user can join this chat room again.

```java
ChatClient.getInstance().chatroomManager().removeChatRoomMembers(chatRoomId, members);
```

### Manage the chat room block list

The chat room owner and admin can add and remove the specified members from the chat room block list. Once a chat room member is added to the block list, this member cannot send or receive chat room messages, nor can they join the chat room again.

```java
// The chat room owner or admin can call blockChatroomMembers to add the specified member to the chat room block list.
ChatRoom chatRoom = ChatClient.getInstance().chatroomManager().blockChatroomMembers(chatRoomId, members);

// The chat room owner or admin can call unblockChatroomMembers to remove the specified user out of the block list.
ChatRoom chatRoom = ChatClient.getInstance().chatroomManager().unblockChatRoomMembers(chatRoomId, members);

// The chat room owner or admin can call fetchChatRoomBlackList to reveive the block list of the current chat room.
ChatClient.getInstance().chatroomManager().fetchChatRoomBlackList(chatRoomId, new ValueCallBack<List<String>>() {
    @Override
    public void onSuccess(List<String> value) {

    }

    @Override
    public void onError(int error, String errorMsg) {

    }
});
```

### Manage the chat room mute list

To manage the messages in the chat room, the chat room owner and admin can add and remove the specified member from the chat room mute list. Once added to the mute list, the chat room member can no longer send chat room message, not even after being added to the chat room allow list.

```java
// The chat room owner or admin can call muteChatRoomMembers to add the specified user to the chat room block list. The muted member and all the other chat room admins or owner receive the onMuteListAdded callback.
ChatRoom chatRoom = ChatClient.getInstance().chatroomManager().muteChatRoomMembers(chatRoomId, members, duration);

// The chat room owner or admin can call unMuteChatRoomMembers to remove the specified user from the chat room block list. The unmuted member and all the other chat room admins or owner receive the onMuteListRemoved callback.
ChatRoom chatRoom = ChatClient.getInstance().chatroomManager().unMuteChatRoomMembers(chatRoomId, members);

// The chat room owner or admin can call fetchChatRoomMuteList to fetch the mute list of the current chat room.
Map<String, Long> memberMap =  ChatClient.getInstance().chatroomManager().fetchChatRoomMuteList(chatRoomId, pageNum, pageSize);
```

### Mute and unmute all the chat room members

The chat room owner or admin can mute or unmute all the chat room members using `muteAllMembers`. Once all the members are muted, only those in the chat room allow list can send messages in the chat room.

```java
// The chat room owner or admin can call muteAllMembers to mute all the chat room members. Once all the members are muted, these members receive the onAllMemberMuteStateChanged callback.
ChatClient.getInstance().chatroomManager().muteAllMembers(chatRoomId, new ValueCallBack<ChatRoom>() {
    @Override
    public void onSuccess(ChatRoom value) {

    }

    @Override
    public void onError(int error, String errorMsg) {

    }
});

// The chat room owner or admin can call unmuteAllMembers to unmute all the chat room members. Once all the members are unmuted, these members receive the onAllMemberMuteStateChanged callback.
ChatClient.getInstance().chatroomManager().unmuteAllMembers(chatRoomId, new ValueCallBack<ChatRoom>() {
    @Override
    public void onSuccess(ChatRoom value) {

    }

    @Override
    public void onError(int error, String errorMsg) {

    }
});
```

### Manage the chat room allow list

Members in the chat room allow list can send chat room messages even when the chat room owner or an admin has muted all the chat room members using `muteAllMembers`. However, if a member is already in the chat room mute list, adding this member to the allow list does not take effect.

```java
// The chat room owner or admin can call addToChatRoomWhiteList to add the specified member to the chat room allow list.
ChatClient.getInstance().chatroomManager().addToChatRoomWhiteList(chatRoomId, members, new ValueCallBack<ChatRoom>() {
    @Override
    public void onSuccess(ChatRoom value) {

    }

    @Override
    public void onError(int error, String errorMsg) {

    }
});

// The chat room owner or admin can call removeFromChatRoomWhiteList to add remove the specifeid member from the chat room allow list.
ChatClient.getInstance().chatroomManager().removeFromChatRoomWhiteList(chatRoomId, members, new ValueCallBack<ChatRoom>() {
    @Override
    public void onSuccess(ChatRoom value) {

    }

    @Override
    public void onError(int error, String errorMsg) {

    }
});

// Chat room members can call checkIfInChatRoomWhiteList to check whether they are in the chat room allow list.
ChatClient.getInstance().chatroomManager().checkIfInChatRoomWhiteList(chatRoomId, new ValueCallBack<Boolean>() {
    @Override
    public void onSuccess(Boolean value) {

    }

    @Override
    public void onError(int error, String errorMsg) {

    }
});

// The chat room owner or admin can call fetchChatRoomWhiteList to retrive the allow list of the current chat room.
ChatClient.getInstance().chatroomManager().fetchChatRoomWhiteList(chatRoomId, new ValueCallBack<List<String>>() {
    @Override
    public void onSuccess(List<String> value) {

    }

    @Override
    public void onError(int error, String errorMsg) {

    }
});
```

### Manage chat room ownership and admin

The chat room owner can transfer the ownership to the specified chat room member. Once the ownership is transferred, the originial chat room owner becomes a regular member. The new chat room owner and the chat room admins receive the `onOwnerChanged` callback.

The chat room owner can also add annd remove admins. Once added to the chat room admin list, the newly added admin and the other chat room admins receive the `onAdminAdded` callback.

```java
// The chat room owner can call changeOwner to transfer the ownership to the other chat room member.
ChatRoom chatRoom = ChatClient.getInstance().chatroomManager().changeOwner(chatRoomId, newOwner);

// The chat room owner can call addChatRoomAdmin to add the chat room admin.
ChatRoom chatRoom = ChatClient.getInstance().chatroomManager().addChatRoomAdmin(chatRoomId, admin);

// The chat room owner can call removeChatRoomAdmin to remove admins. Once removed from the chat group admin list, the removed admin and the other chat room admins receive the onAdminRemoved callback.
ChatRoom chatRoom = ChatClient.getInstance().chatroomManager().removeChatRoomAdmin(chatRoomId, admin);
```

### Manage chat room announcements

All chat room members can retrieve the chat room announcements. The chat room owner and admin can set and update the announcements. Once the announcements are updated, all the chat room members receive the `onAnnouncementChanged` callback.

```java
// Chat room members can call fetchChatRoomAnnouncement to retrieve the chat room announcements.
String announcement = ChatClient.getInstance().chatroomManager().fetchChatRoomAnnouncement(chatRoomId);

// The chat room owner and admin can call updateChatRoomAnnouncement to set or update the chat room announcements.
ChatClient.getInstance().chatroomManager().updateChatRoomAnnouncement(chatRoomId, announcement);
```

### Listen for chat room events

To monitor the chat room events, you can listen for the callbacks in the `ChatRoomManager` class and add app logics accordingly. If you want to stop listening for the callback, make sure that you remove the listener to prevent memory leakage.

```java
public interface ChatRoomChangeListener {
    /**
     * Occurs when the chat room instance is destroyed.
     * 
     * @param roomId        The chat room ID
     * @param roomName      The chat room name
     */
    void onChatRoomDestroyed(final String roomId, final String roomName);

    /**
     * Occurs when a new member joins the chat room.
     * 
     * @param roomId        The chat room ID
     * @param participant   The username of the new chat room member
     */
    void onMemberJoined(final String roomId, final String participant);

    /**
     * Occurs when a member leaves the chat room.
     * 
     * @param roomId        The chat room ID
     * @param roomName      The chat room name
     * @param participant   The username of the member that leaves the chat room
      */
    void onMemberExited(final String roomId, final String roomName, final String participant);

    /**
     * Occurs when a chat room member is removed.
     *
     * @param reason        The reason why this member is removed, either being kicked by the chat room admin, or being offline due to network conditions
     * @param roomId        The chat room ID
     * @param roomName      The chat room name
     * @param participant   The username of the member that is removed from the chat room
     */
    void onRemovedFromChatRoom(final int reason, final String roomId, final String roomName, final String participant);

    /**
     * Occurs when a member is added to the chat room mute list.
     *
     * @param chatRoomId    The chat room ID
     * @param mutes         The usernames of the members added to the chat room mute list
     * @param expireTime    The Unix timestamp when the mute expires, in miliseconds
     */
    void onMuteListAdded(final String chatRoomId, final List<String> mutes, final long expireTime);

    /**
     * Occurs when a member is removed from the chat room mute list.
     *
     * @param chatRoomId    The chat room ID
     * @param mutes         The usernames of the members removed from the chat room mute list
     */
    void onMuteListRemoved(final String chatRoomId, final List<String> mutes);

    /**
     * Occurs when a member is added to the chat room allow list.
     *
     * @param chatRoomId    The chat room ID
     * @param whitelist     The usernmaes of the members added to the chat room allow list
     */
    void onWhiteListAdded(final String chatRoomId, final List<String> whitelist);

    /**
     * Occurs when a member is removed from the chat room allow list.
     *
     * @param chatRoomId    The chat room ID
     * @param whitelist     The usernames of the members removed from the chat room allow list
     */
    void onWhiteListRemoved(final String chatRoomId, final List<String> whitelist);

    /**
     * Occurs when the state of muting all the chat room members changes.
     *
     * @param chatRoomId    The chat room ID
     * @param isMuted       Whether all the chat room members are muted
     */
    void onAllMemberMuteStateChanged(final String chatRoomId, final boolean isMuted);

    /**
     * Occurs when a member is added to the chat room admin list.
     *
     * @param chatRoomId    The chat room ID
     * @param admin         The username of the chat room member added to the admin list
     */
    void onAdminAdded(final String chatRoomId, final String admin);

    /**
     * Occurs when a member is removed from the chat room admin list.
     *
     * @param  chatRoomId   The chat room ID
     * @param  admin        The username of the chat name member removed from the admin list
     */
    void onAdminRemoved(final String chatRoomId, final String admin);

    /**
     * Occurs when the chat room ownership is transferred.
     *
     * @param chatRoomId    The chat room ID
     * @param newOwner      The username of the new chat room owner
     * @param oldOwner      The username of the original chat room owner
     */
    void onOwnerChanged(final String chatRoomId, final String newOwner, final String oldOwner);


    /**
     * Occurs when the chat room announcements change.
     * @param chatRoomId    The chat room ID
     * @param announcement  The new chat room announcements
     */
    void onAnnouncementChanged(String chatRoomId, String announcement);
}

// Adds a chat room listener to monitor chat room callback events.
ChatClient.getInstance().chatroomManager().addChatRoomChangeListener(chatRoomChangeListener);

// Removes the chat room listener.
ChatClient.getInstance().chatroomManager().removeChatRoomListener(chatRoomChangeListener);
```