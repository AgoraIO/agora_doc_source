# 管理聊天室成员

聊天室支持多个用户之间的实时消息传递。

本页介绍如何使用即时通讯 IM（环信）SDK 管理应用中的聊天室成员。

## 了解技术

即时通讯 IM（环信）SDK 提供了聊天室管理的`ChatManager`和`ChatRoom`类，允许您实现以下功能：

- 从聊天室中删除成员
- 检索聊天室的成员列表
- 管理聊天室的黑名单
- 管理聊天室的静音列表
- 将所有聊天室成员静音和取消静音
- 管理聊天室允许列表
- 管理聊天室的所有者和管理员

## 先决条件

在继续之前，请确保您满足以下要求：

- 您已经初始化了 即时通讯 IM（环信）SDK。有关详细信息，请参阅[Android 入门](https://docs.agora.io/en/agora-chat/agora_chat_get_started_android?platform=Android)。
- 您了解不同定价方案支持的即时通讯 IM（环信）API 的调用频率限制，如[限制](https://docs.agora.io/en/agora-chat/agora_chat_limitation?platform=Android)中所述。
- 如[定价计划详细信息](https://docs.agora.io/en/agora-chat/agora_chat_plan?platform=Android)中所述，您了解不同定价计划支持的聊天室数量。

## 执行

本节介绍如何调用即时通讯 IM（环信）SDK 提供的 API 来实现上述功能。

### 管理聊天室成员

所有聊天室成员都可以调用`fetchChatRoomMembers`来检索当前聊天室的成员列表。

```java
Map<String, Long> members = ChatClient.getInstance().chatroomManager().fetchChatRoomMembers(chatRoomId, cursor, pageSize);
```

聊天室所有者和管理员可以调用`removeChatRoomMember`以从聊天室中删除指定成员。删除成员后，该成员收到`onRemovedFromChatRoom`回调，其他聊天室成员收到`onMemberExited`回调。被移出聊天室后，您可以再次加入该聊天室。

```java
ChatClient.getInstance().chatroomManager().removeChatRoomMembers(chatRoomId, members);
```

### 管理聊天室阻止列表

聊天室所有者和管理员可以将指定的成员添加到聊天室阻止列表中并从中删除。将聊天室成员添加到阻止列表后，该成员将无法发送或接收聊天室消息，也无法再次加入聊天室。

```java
// The chat room owner or admin call blockChatroomMembers to add the specified member to the chat room block list.
ChatRoom chatRoom = ChatClient.getInstance().chatroomManager().blockChatroomMembers(chatRoomId, members);

// The chat room owner or admin call unblockChatroomMembers to remove the specified user out of the block list.
ChatRoom chatRoom = ChatClient.getInstance().chatroomManager().unblockChatRoomMembers(chatRoomId, members);

// The chat room owner or admin call fetchChatRoomBlackList to reveive the block list of the current chat room.
ChatClient.getInstance().chatroomManager().fetchChatRoomBlackList(chatRoomId, new ValueCallBack<List<String>>() {
    @Override
    public void onSuccess(List<String> value) {

    }

    @Override
    public void onError(int error, String errorMsg) {

    }
});
```

### 管理聊天室静音列表

要管理聊天室中的消息，聊天室所有者和管理员可以将指定成员添加到聊天室静音列表中，并将其从其中删除。将聊天室成员添加到静音列表后，该成员将无法再发送聊天室消息，即使添加到聊天室允许列表后也无法发送。

```java
// The chat room owner or admin call muteChatRoomMembers to add the specified user to the chat room block list. The muted member and all the other chat room admins or owner receive the onMuteListAdded callback.
ChatRoom chatRoom = ChatClient.getInstance().chatroomManager().muteChatRoomMembers(chatRoomId, members, duration);

// The chat room owner or admin can call unMuteChatRoomMembers to remove the specified user from the chat room block list. The unmuted member and all the other chat room admins or owner receive the onMuteListRemoved callback.
ChatRoom chatRoom = ChatClient.getInstance().chatroomManager().unMuteChatRoomMembers(chatRoomId, members);

// The chat room owner or admin can call fetchChatRoomMuteList to fetch the mute list of the current chat room.
Map<String, Long> memberMap =  ChatClient.getInstance().chatroomManager().fetchChatRoomMuteList(chatRoomId, pageNum, pageSize);
```

### 将所有聊天室成员静音和取消静音

聊天室所有者或管理员可以使用 将所有聊天室成员静音或取消静音`muteAllMembers`。将所有成员静音后，只有聊天室允许列表中的成员才能在聊天室中发送消息。

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

### 管理聊天室允许列表

即使聊天室所有者或管理员已将所有使用 的聊天室成员静音，聊天室允许列表中的成员也可以发送聊天室消息`muteAllMembers`。但是，如果某个成员已经在聊天室静音列表中，则将该成员添加到允许列表中不会生效。

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

### 管理聊天室所有权和管理员

聊天室所有者可以将所有权转让给指定的聊天室成员。一旦所有权转移，原来的聊天室所有者就会成为普通成员。新的聊天室所有者和聊天室管理员会收到 `onOwnerChanged` 回调。

聊天室所有者还可以添加管理员。添加到聊天室管理员列表后，新添加的管理员和其他聊天室管理员都会收到 `onAdminAdded` 回调。

```java
// The chat room owner can call changeOwner to transfer the ownership to the other chat room member.
ChatRoom chatRoom = ChatClient.getInstance().chatroomManager().changeOwner(chatRoomId, newOwner);

// The chat room owner can call addChatRoomAdmin to add the chat room admin.
ChatRoom chatRoom = ChatClient.getInstance().chatroomManager().addChatRoomAdmin(chatRoomId, admin);

// The chat room owner can call removeChatRoomAdmin to remove the chat room admin. The removed admin and the other admins receive the onAdminRemoved callback.
ChatRoom chatRoom = ChatClient.getInstance().chatroomManager().removeChatRoomAdmin(chatRoomId, admin);
```

### 监听聊天室事件

有关详细信息，请参阅 [聊天室事件](https://docs.agora.io/en/agora-chat/agora_chat_chatroom_android?platform=Android#listen-for-chat-room-events)。