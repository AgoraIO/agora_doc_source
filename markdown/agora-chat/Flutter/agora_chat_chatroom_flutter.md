聊天室没有严格的成员资格，成员之间不保持任何永久关系。聊天室成员下线后，该成员不会收到聊天室的推送消息，5 分钟后自动离开聊天室。聊天室广泛应用于直播用例，例如 Twitch 中的流式聊天。

本文介绍如何使用即时通讯 IM SDK 在实时互动 app 中创建和管理聊天室，并实现聊天室的相关功能。

如需查看消息相关内容，参见 [消息管理](./agora_chat_send_receive_message_flutter)。

## 技术原理

即时通讯 IM Flutter SDK 提供 `ChatRoom`、`ChatRoomManager` 和 `ChatRoomEventHandler` 类用于聊天室管理，可以实现以下功能：

- 创建聊天室
- 从服务器获取聊天室列表
- 加入聊天室
- 获取聊天室详情
- 退出聊天室
- 解散聊天室
- 监听聊天室事件

## 前提条件

开始前，请确保满足以下条件：

- 完成 SDK 初始化，详见 [快速开始](./agora_chat_get_started_flutter)。
- 了解 [使用限制](./agora_chat_limitation)。
- 了解聊天室的数量限制，详见 [套餐包详情](./agora_chat_plan)。
- 只有应用超级管理员才有创建聊天室的权限。确保你已通过 [调用创建应用超级管理员 RESTful API](./agora_chat_restful_chatroom_superadmin#添加超级管理员) 添加了应用超级管理员。
- 聊天室创建者和管理员的数量之和不能超过 100，即管理员最多可添加 99 个。

## 实现方法

本节介绍如何调用 Agora Chat SDK 提供的 API 实现聊天室功能。

### 创建聊天室

只有 [应用超级管理员](./agora_chat_restful_chatroom_superadmin#创建应用超级管理员) 可以调用 `createChatRoom` 创建聊天室并设置聊天室名称、描述、最大成员数等信息。创建聊天室后，该超级管理员自动成为聊天室所有者。

示例代码如下：

```dart
try {
  ChatRoom room = await ChatClient.getInstance.chatRoomManager.createChatRoom(name);
} on ChatError catch (e) {
}
```

### 解散聊天室

只有聊天室所有者可以调用 `destroyChatRoom` 解散聊天室。聊天室解散后，所有聊天室成员都会收到 `ChatRoomEventHandler#onChatRoomDestroyed` 事件并立即从聊天室中删除。

示例代码如下：

```dart
try {
  await ChatClient.getInstance.chatRoomManager.destroyChatRoom(roomId);
} on ChatError catch (e) {
}
```

### 从服务器获取聊天室列表

用户可以调用 `fetchPublicChatRoomsFromServer` 从服务器获取聊天室列表。

```dart
try {
  ChatPageResult<ChatRoom> result = await ChatClient
      .getInstance.chatRoomManager
      .fetchPublicChatRoomsFromServer(
    // The page number from which to start retrieving chat rooms.
    pageNum: pageNum,
    // The maximum number of chat rooms to retrieve with pagination.
    pageSize: pageSize,
  );
} on ChatError catch (e) {
}
```

### 加入聊天室

请参考以下步骤加入聊天室：

1. 调用 [`fetchPublicChatRoomsFromServer`](./agora_chat_chatroom_flutter#从服务器获取聊天室列表) 从服务器获取聊天室列表并找到要加入的聊天室的 ID。
2. 调用 `joinChatRoom` 传入聊天室 ID，加入指定聊天室。一旦用户加入聊天室，所有其他聊天室成员都会收到 `ChatRoomEventHandler#onMemberJoinedFromChatRoom` 事件。

示例代码如下：

```dart
try {
   await ChatClient.getInstance.chatRoomManager.joinChatRoom(roomId);
} on ChatError catch (e) {
}
```

### 退出聊天室

聊天室所有成员均可以调用 `ChatRoomEventHandler#leaveChatRoom` 方法退出当前聊天室。成员退出聊天室时，其他成员收到 `onMemberExitedFromChatRoom` 回调。

与群主（不能离开群组）不同，聊天室所有者可以离开聊天室。重新进入聊天室后，该用户仍然是聊天室的所有者。

示例代码如下：

```dart
try {
   await ChatClient.getInstance.chatRoomManager.leaveChatRoom(roomId);
} on ChatError catch (e) {
}
```

退出聊天室时，SDK 默认删除该聊天室的所有本地消息，若要保留这些消息，可在 SDK 初始化时将 `ChatOptions#deleteMessagesAsExitChatRoom` 设置为 `false`。

示例代码如下：

```dart
ChatOptions options = ChatOptions(
      appKey: "<#Your AppKey#>",
      deleteMessagesAsExitChatRoom: false,
    );
```

### 获取聊天室详情

聊天室所有成员均可以调用 `ChatManager#fetchChatRoomInfoFromServer` 获取聊天室详情，包括聊天室 ID、聊天室名称，聊天室描述、最大成员数、聊天室所有者、是否全员禁言以及聊天室权限类型。聊天室公告、管理员列表、成员列表、黑名单列表、禁言列表需单独调用接口获取。

以下代码示例显示了如何检索聊天室属性：

```dart
try {
  ChatRoom room = await ChatClient.getInstance.chatRoomManager.fetchChatRoomInfoFromServer(roomId);
} on ChatError catch (e) {
}
```



### 监听聊天室事件

`ChatChatRoomEventHandler` 类中提供了聊天室事件的监听接口。你可以通过注册聊天室监听器，获取聊天室事件，并作出相应处理。如不再使用该监听，需要移除，防止出现内存泄露。

示例代码如下：

```dart
    // 添加监听器
    ChatClient.getInstance.chatRoomManager.addEventHandler(
      "UNIQUE_HANDLER_ID",
      ChatRoomEventHandler(),
    );

    ...

    // 移除监听器
    ChatClient.getInstance.chatRoomManager.removeEventHandler("UNIQUE_HANDLER_ID");
```