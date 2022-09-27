聊天室是支持多人沟通的即时通讯系统。本文介绍如何管理聊天室的属性信息。

## 技术原理

即时通讯 IM Flutter SDK 提供 `ChatRoom`、`ChatRoomManager` 和 `ChatRoomEventHandler` 类用于聊天室管理，可以实现以下功能：

- 获取聊天室公告
- 更新聊天室公告
- 更新聊天室名称
- 更新聊天室描述

## 前提条件

开始前，请确保满足以下条件：

- 完成 SDK 初始化，详见 [快速开始](./agora_chat_get_started_flutter)。
- 了解 [使用限制](./agora_chat_limitation)。
- 了解聊天室的数量限制，详见 [套餐包详情](./agora_chat_plan)。

## 实现方法

本节介绍如何使用即时通讯 IM Flutter SDK 提供的 API 实现上述功能。

### 获取聊天室公告

聊天室所有成员均可调用 `ChatRoomManager#fetchChatRoomAnnouncement` 方法获取聊天室公告。

示例代码如下：

```dart
try {
  String? announcement =
      await ChatClient.getInstance.chatRoomManager.fetchChatRoomAnnouncement(
    roomId,
  );
} on ChatError catch (e) {
}
```

### 更新聊天室公告

仅聊天室所有者和聊天室管理员可以调用 `ChatRoomManager#updateChatRoomAnnouncement` 方法设置和更新聊天室公告，聊天室公告的长度限制为 512 个字符。公告更新后，其他聊天室成员收到 `ChatRoomEventHandler#onAnnouncementChangedFromChatRoom` 事件。

示例代码如下：

```dart
try {
  await ChatClient.getInstance.chatRoomManager.updateChatRoomAnnouncement(
    roomId,
    newAnnouncement,
  );
} on ChatError catch (e) {
}
```

### 更新聊天室名称

仅聊天室所有者和聊天室管理员可以调用 `ChatRoomManager#changeChatRoomName` 方法设置和更新聊天室名称，聊天室名称的长度限制为 128 个字符。

示例代码如下：

```dart
try {
  await ChatClient.getInstance.chatRoomManager.changeChatRoomName(
    roomId,
    newName,
  );
} on ChatError catch (e) {
}
```

### 更新聊天室描述

仅聊天室所有者和聊天室管理员可以调用 `ChatRoomManager#changeChatRoomDescription` 方法设置和更新聊天室描述，聊天室描述的长度限制为 512 个字符。

示例代码如下：

```dart
try {
  await ChatClient.getInstance.chatRoomManager.changeChatRoomDescription(
    roomId,
    newDesc,
  );
} on ChatError catch (e) {
}
```

### 监听聊天室事件

详见 [监听聊天室事件](./agora_chat_chatroom_flutter#监听聊天室事件)。