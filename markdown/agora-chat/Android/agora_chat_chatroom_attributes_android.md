# 管理聊天室属性

聊天室是支持多人沟通的即时通讯系统。本文介绍如何管理聊天室的属性信息。

## 了解技术

即时通讯 IM（环信）SDK 提供 `ChatRoomManager` 和 `ChatRoom` 类用于聊天室属性管理，可以实现以下功能：

- 更新聊天室名称
- 更新聊天室描述
- 获取聊天室的公告
- 更新聊天室的公告

## 前提条件

开始前，请确保满足以下条件：

- 完成 SDK 初始化，详见 [Android 入门](https://docs.agora.io/en/agora-chat/agora_chat_get_started_android?platform=Android)。
- 了解 [使用限制](https://docs.agora.io/en/agora-chat/agora_chat_limitation?platform=Android)中所述。
- 了解聊天室的数量限制，详见 [套餐包详情](https://docs.agora.io/en/agora-chat/agora_chat_plan?platform=Android)。

## 实现方法

本节介绍如何调用即时通讯 IM（环信）SDK 提供的 API 来实现上述功能。

### 获取和修改聊天室属性

方法示例如下：

```java
// 所有聊天室成员都可以调用 `fetchChatRoomFromServer` 来获取当前聊天室的详细信息，包括主题、公告、描述、成员类型和管理员列表。
ChatRoom chatRoom = ChatClient.getInstance().chatroomManager().fetchChatRoomFromServer(chatRoomId);

// 仅聊天室所有者和聊天室管理员可以调用 `changeChatRoomSubject` 方法设置和更新聊天室名称，聊天室名称的长度限制为 128 个字符。
ChatRoom chatRoom = ChatClient.getInstance().chatroomManager().changeChatRoomSubject(chatRoomId, newSubject);

// 仅聊天室所有者和聊天室管理员可以调用 `changeChatroomDescription` 方法设置和更新聊天室描述，聊天室描述的长度限制为 512 个字符。

ChatRoom chatRoom = ChatClient.getInstance().chatroomManager().changeChatroomDescription(chatRoomId, newDescription);
```

### 管理聊天室公告

具体方法如下：

```java
// 聊天室所有成员均可调用 `fetchChatRoomAnnouncement` 方法获取聊天室公告。
String announcement = ChatClient.getInstance().chatroomManager().fetchChatRoomAnnouncement(chatRoomId);

// 聊天室所有者和管理员可以设置和更新公告，聊天室公告的长度限制为 512 个字符。公告更新后，所有聊天室成员都会收到 `onAnnouncementChanged` 回调。

ChatClient.getInstance().chatroomManager().updateChatRoomAnnouncement(chatRoomId, announcement);
```

### 监听聊天室事件

有关详细信息，请参阅[聊天室事件](https://docs.agora.io/en/agora-chat/agora_chat_chatroom_android?platform=Android#listen-for-chat-room-events)。