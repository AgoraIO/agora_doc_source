聊天室是支持多人沟通的即时通讯系统。聊天室属性可分为聊天室名称、描述和公告等基本属性和自定义属性（key-value）。若聊天室基本属性不满足业务要求，用户可增加自定义属性并同步给所有成员。利用自定义属性可以存储直播聊天室的类型、狼人杀等游戏中的角色信息和游戏状态以及实现语聊房的麦位管理和同步等。聊天室自定义属性以键值对（key-value）形式存储，属性信息变更会实时同步给聊天室成员。

本文介绍如何管理聊天室的属性信息。

## 技术原理

即时通讯 IM Flutter SDK 提供 `ChatRoom`、`ChatRoomManager` 和 `ChatRoomEventHandler` 类用于聊天室管理，可以实现以下功能：

- 获取和更新聊天室基本属性；
- 获取聊天室自定义属性；
- 设置聊天室自定义属性；
- 删除聊天室自定义属性。

## 前提条件

开始前，请确保满足以下条件：

- 完成 SDK 初始化，详见 [快速开始](./agora_chat_get_started_flutter)。
- 了解 [使用限制](./agora_chat_limitation)。
- 了解聊天室的数量限制，详见 [套餐包详情](./agora_chat_plan)。

## 实现方法

本节介绍如何使用即时通讯 IM Flutter SDK 提供的 API 实现上述功能。

### 管理聊天室基本属性

#### 获取聊天室名称和描述

对于聊天室名称和描述，你可以调用 [`fetchChatRoomInfoFromServer`](./agora_chat_chatroom_flutter#获取聊天室详情) 方法获取聊天室详情时查看。

#### 修改聊天室名称

仅聊天室所有者和聊天室管理员可以调用 `ChatRoomManager#changeChatRoomName` 方法设置和修改聊天室名称，聊天室名称的长度限制为 128 个字符。

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

#### 修改聊天室描述

仅聊天室所有者和聊天室管理员可以调用 `ChatRoomManager#changeChatRoomDescription` 方法设置和修改聊天室描述，聊天室描述的长度限制为 512 个字符。

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

#### 获取聊天室公告

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

#### 更新聊天室公告

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

### 管理聊天室自定义属性（key-value）

#### 获取聊天室自定义属性

聊天室所有成员均可调用 `fetchChatRoomAttributes` 方法获取聊天室自定义属性。

```dart
// 通过指定聊天室 ID 和属性 key 获取聊天室某些或全部自定义属性。
try {
    Map<String, String>? attributes =
        await ChatClient.getInstance.chatRoomManager.fetchChatRoomAttributes(
        roomId,
        keys,
    );
} on ChatError catch (e) {}
```

#### 设置聊天室自定义属性

聊天室所有成员均可调用 `addAttributes` 方法设置一个或多个聊天室自定义属性。利用该方法可设置新属性，也可以修改自己或其他成员设置的现有属性。设置后，其他聊天室成员收到 `EMChatRoomEventHandler#onAttributesUpdated` 回调。

```dart
// 通过设置聊天室 ID 和属性的键值对集合设置聊天室自定义属性。
try {
  Map<String, int>? failInfo =
      await ChatClient.getInstance.chatRoomManager.addAttributes(
    "room",
    attributes: kv,
    deleteWhenLeft: true,
    overwrite: true,
  );
} on ChatError catch (e) {}
```

#### 删除聊天室自定义属性

聊天室所有成员均可调用 `removeAttributes` 方法删除一个或多个聊天室自定义属性。利用该方法可删除自己和其他成员设置的自定义属性。删除后，聊天室其他成员收到 `EMChatRoomEventHandler#onAttributesRemoved` 回调。

```dart
// 通过设置聊天室 ID 和属性 key 列表删除聊天室自定义属性。
try {
  Map<String, int>? failInfo =
      await ChatClient.getInstance.chatRoomManager.removeAttributes(
    roomId,
    keys: keys,
    force: true,
  );
} on ChatError catch (e) {}
```

### 监听聊天室事件

详见 [监听聊天室事件](./agora_chat_chatroom_flutter#监听聊天室事件)。