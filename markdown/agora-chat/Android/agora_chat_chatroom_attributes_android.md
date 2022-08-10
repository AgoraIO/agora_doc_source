# 管理聊天室属性

聊天室是支持多人沟通的即时通讯系统。本文介绍如何管理聊天室的属性信息。

## 了解技术

Agora Chat SDK 提供 `ChatRoomManager` 和 `ChatRoom` 类用于聊天室属性管理，可以实现以下功能：

- 更新聊天室名称
- 更新聊天室描述
- 获取聊天室的公告
- 更新聊天室的公告

## 前提条件

开始前，请确保满足以下条件：

- 完成 SDK 初始化，详见 [Android 入门](https://docs.agora.io/en/agora-chat/agora_chat_get_started_android?platform=Android)。
- 了解 [使用限制](https://docs.agora.io/en/agora-chat/agora_chat_limitation?platform=Android)中所述。
- 了解聊天室的数量限制，详见 [套餐包详情](https://docs.agora.io/en/agora-chat/agora_chat_plan?platform=Android)中所述，您了解不同定价计划支持的聊天室数量。

## 执行

本节介绍如何调用 Agora Chat SDK 提供的 API 来实现上述功能。

### 检索和修改聊天室属性

所有聊天室成员都可以调用`fetchChatRoomFromServer`来检索当前聊天室的详细信息，包括主题、公告、描述、成员类型和管理员列表。聊天室所有者和管理员还可以设置和更新聊天室信息。

```java
// The chat room member call fetchChatRoomFromServer to get the information of the specifeid chat room.
ChatRoom chatRoom = ChatClient.getInstance().chatroomManager().fetchChatRoomFromServer(chatRoomId);

// The chat room owner and admin call changeChatRoomSubject to modify the chat room subject.
ChatRoom chatRoom = ChatClient.getInstance().chatroomManager().changeChatRoomSubject(chatRoomId, newSubject);

// The chat room owner and admin call changeChatroomDescription to modify the chat room description.
ChatRoom chatRoom = ChatClient.getInstance().chatroomManager().changeChatroomDescription(chatRoomId, newDescription);
```

### 管理聊天室公告

所有聊天室成员都可以检索聊天室公告。聊天室所有者和管理员可以设置和更新公告。公告更新后，所有聊天室成员都会收到`onAnnouncementChanged`回调。

```java
// Chat room members can call fetchChatRoomAnnouncement to retrieve the chat room annoucements.
String announcement = ChatClient.getInstance().chatroomManager().fetchChatRoomAnnouncement(chatRoomId);

// The chat room owner and admin can call updateChatRoomAnnouncement to set or update the chat room announcements.
ChatClient.getInstance().chatroomManager().updateChatRoomAnnouncement(chatRoomId, announcement);
```

### 监听聊天室事件

有关详细信息，请参阅[聊天室事件](https://docs.agora.io/en/agora-chat/agora_chat_chatroom_android?platform=Android#listen-for-chat-room-events)。