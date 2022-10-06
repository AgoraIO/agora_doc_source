子区是群组成员的子集，是支持多人沟通的即时通讯系统，子区让用户能够在群组中的特定消息上创建单独的会话，以保持主聊天界面整洁。

下图展示了如何创建子区、子区中的会话以及可以在子区中执行的操作：

![img](https://web-cdn.agora.io/docs-files/1655176216910)

本文介绍如何使用即时通讯 IM Flutter SDK 在实时互动 app 中创建和管理子区，并实现子区相关功能。

## 技术原理

即时通讯 IM Flutter SDK 提供 `ChatThreadManager`, `ChatThread`, `ChatThreadEventHandler` 和 `ChatThreadEvent` 类用于子区管理，可以实现以下功能：

- 创建、解散子区
- 加入、退出子区
- 子区踢人
- 修改子区名称
- 获取子区详情
- 获取子区成员列表
- 获取子区列表
- 批量获取子区中的最新消息
- 监听子区事件

## 前提条件

开始前，请确保满足以下条件：

- 完成 `1.0.5 或以上版本` SDK 初始化，详见 [快速开始](./agora_chat_get_started_flutter)。
- 了解 [使用限制](./agora_chat_limitation)。

## 实现方法

本节介绍如何使用即时通讯 IM Flutter SDK 提供的 API 实现上述功能。

### 创建子区

所有群组成员都可以调用 `createChatThread` 以从群组中的特定消息创建子区。

在群组中创建子区后，所有群组成员都会收到 `ChatThreadEventHandler#onChatThreadCreate` 回调。在多设备场景下，所有其他设备都会收到事件 `ChatMultiDeviceEventHandler#onChatThreadEvent` 触发的回调 `ChatMultiDevicesEvent#CHAT_THREAD_CREATE`。

示例代码如下：

```dart
try {
  ChatThread chatThread =
      await ChatClient.getInstance.chatThreadManager.createChatThread(
    name: name,
    messageId: messageId,
    parentId: parentId,
  );
} on ChatError catch (e) {
}
```

### 解散子区

仅子区所在群组的群主和群管理员可以调用 `ChatChatThreadManager#destroyChatThread` 方法解散子区。

单设备登录时，子区所属群组的所有成员均会收到 `ChatChatThreadEventHandler#onChatThreadDestroy` 事件；多设备登录时，其他设备会同时收到 `ChatMultiDeviceEventHandler#onChatThreadEvent` 事件，回调事件为 `ChatMultiDevicesEvent#CHAT_THREAD_DESTROY`。

解散子区或解散子区所在的群组后，将删除本地数据库及内存中关于该子区的全部数据，需谨慎操作。

示例代码如下：

```dart
// chatThreadId: 子区 ID
try {
  await ChatClient.getInstance.chatThreadManager.destroyChatThread(
    chatThreadId: chatThreadId,
  );
} on ChatError catch (e) {
}
```

### 加入子区

子区所在群组的所有成员均可以调用 `ChatChatThreadManager#joinChatThread` 方法加入群组，

加入子区的具体步骤如下：

1. 收到 `ChatThreadManagerEventHandler#onChatThreadCreate` 事件或 `ChatThreadManagerEventHandler#onChatThreadUpdate` 事件，或调用 `fetchChatThreadWithParentId` 方法从服务器获取指定群组的子区列表，从中获取到想要加入的子区 ID。
2. 调用 `joinChatThread` 传入子区 ID 加入对应子区。


多设备登录时，其他设备会同时收到 `ChatMultiDeviceEventHandler#onChatThreadEvent` 事件，回调事件为 `ChatMultiDevicesEvent#CHAT_THREAD_JOIN`。

示例代码如下：

```dart
// chatThreadId: 子区 ID
try {
  ChatThread chatThead =
      await ChatClient.getInstance.chatThreadManager.joinChatThread(
    chatThreadId: chatThreadId,
  );
} on ChatError catch (e) {
}
```

### 退出子区

子区成员均可以主动调用 `ChatThreadManager#leaveChatThread` 方法退出子区，退出子区后，该成员将不会再收到子区消息。

多设备登录时，其他设备会同时收到 `ChatMultiDeviceEventHandler#onThreadEvent` 事件，回调事件为 `ChatMultiDevicesEvent#CHAT_THREAD_LEAVE`。

示例代码如下：

```dart
// chatThreadId: 子区 ID
try {
  await ChatClient.getInstance.chatThreadManager.leaveChatThread(
    chatThreadId: chatThreadId,
  );
} on ChatError catch (e) {
}
```

### 从子区移出成员

仅群主和群管理员可以调用 `ChatThreadManager#removeMemberFromChatThread` 方法将指定成员 (群管理员或普通成员) 踢出子区，被踢出子区的成员将不再接收到子区消息。

被踢出子区的成员会收到 `ChatThreadEventHandler#onUserKickOutOfChatThread` 事件；多设备登录时，执行踢人操作的成员的其他设备会同时收到 `ChatMultiDeviceEventHandler#onThreadEvent` 事件，回调事件为 `ChatMultiDevicesEvent#CHAT_THREAD_KICK`。

示例代码如下：

```dart
// chatThreadId: 子区 ID
// memberId: 子区成员的用户 ID
try {
  await ChatClient.getInstance.chatThreadManager.removeMemberFromChatThread(
    memberId: memberId,
    chatThreadId: chatThreadId,
  );
} on ChatError catch (e) {
}
```

### 修改子区名称

仅群主和群管理员以及子区的创建者可以调用 `ChatThreadManager#updateChatThreadName` 方法修改子区名称。

单设备登录时，子区所属群组的所有成员会收到 `ChatThreadManagerEventHandler#onChatThreadUpdate` 事件；多设备登录时，其他设备会同时收到 `MultiDeviceEventHandler#onThreadEvent` 事件，回调事件为 `ChatMultiDevicesEvent#CHAT_THREAD_UPDATE`。

示例代码如下：

```dart
// chatThreadId: 子区 ID
// name: 修改的子区名称，长度不超过 64 个字符
try {
  await ChatClient.getInstance.chatThreadManager.updateChatThreadName(
    newName: name,
    chatThreadId: chatThreadId,
  );
} on ChatError catch (e) {
}
```

### 获取子区详情

子区所属群组的所有成员均可以调用 `ChatThreadManager#fetchChatThread` 从服务器获取子区详情。

示例代码如下：

```dart
// chatThreadId: 子区 ID
try {
  ChatThread? chatThread =
      await ChatClient.getInstance.chatThreadManager.fetchChatThread(
    chatThreadId: chatThreadId,
  );
} on ChatError catch (e) {
}
```

### 获取子区成员列表

子区所属群组的所有成员均可以调用 `ChatThreadManager#fetchChatThreadMember` 方法从服务器分页获取子区成员列表。

```dart
// chatThreadId: 子区 ID
// limit: 单次请求返回的成员数，取值范围为 [1, 50]
// cursor: 开始获取数据的游标位置，首次调用方法时传 `null` 或空字符串
try {
  List<String> members =
      await ChatClient.getInstance.chatThreadManager.fetchChatThreadMember(
    chatThreadId: chatThreadId,
    limit: limit,
    cursor: cursor,
  );
} on ChatError catch (e) {
}
```

### 获取子区列表

1. 用户可以调用 `ChatThreadManager#fetchJoinedChatThreads` 方法从服务器分页获取自己加入和创建的子区列表：

```dart
// limit: 单次请求返回的子区数，取值范围为 [1, 50]
// cursor: 开始获取数据的游标位置，首次调用方法时传 `null` 或空字符串
try {
  ChatCursorResult<ChatThread> chatThreads =
      await ChatClient.getInstance.chatThreadManager.fetchJoinedChatThreads(
    limit: limit,
    cursor: cursor,
  );
} on ChatError catch (e) {
}
```

2. 用户可以调用 `ChatThreadManager#fetchChatThreadsWithParentId` 方法从服务器分页获取指定群组的子区列表：

```dart
// parentId: 群组 ID
// limit: 单次请求返回的子区数，取值范围为 [1, 50]
// cursor: 开始获取数据的游标位置，首次调用方法时传 `null` 或空字符串
try {
  ChatCursorResult<ChatThread> chatThreads = await ChatClient
      .getInstance.chatThreadManager
      .fetchJoinedChatThreadsWithParentId(
    parentId: parentId,
    limit: limit,
    cursor: cursor,
  );
} on ChatError catch (e) {
}
```

3. 用户还可以调用 `ChatThreadManager#fetchJoinedChatThreadsWithParentId` 方法从服务器分页获取指定群组的子区列表：

```dart
// parentId: 群组 ID
// limit: 单次请求返回的子区数，取值范围为 [1, 50]
// cursor: 开始获取数据的游标位置，首次调用方法时传 `null` 或空字符串
try {
  ChatCursorResult<ChatThread> chatThreads = await ChatClient
      .getInstance.chatThreadManager
      .fetchChatThreadsWithParentId(
    parentId: parentId,
    limit: limit,
    cursor: cursor,
  );
} on ChatError catch (e) {
}
```

### 批量获取子区中的最新一条消息

用户可以调用 `ChatThreadManager#fetchLatestMessageWithChatThreads` 方法从服务器批量获取子区中的最新一条消息。

示例代码如下：

```dart
// chatThreadIds: 要查询的子区 ID 列表，每次最多可传入 20 个子区 ID
try {
  Map<String, ChatMessage> map = await ChatClient.getInstance.chatThreadManager
      .fetchLatestMessageWithChatThreads(
    chatThreadIds: chatThreadIds,
  );
} on ChatError catch (e) {
}
```

### 监听子区事件

`ChatThreadManager` 类中提供子区事件的监听接口。开发者可以通过设置此监听，获取子区中的事件，并做出相应处理。如果不再使用该监听，需要移除，防止出现内存泄漏。

示例代码如下：

```dart
    // 注册监听
    ChatClient.getInstance.chatThreadManager.addEventHandler(
      "UNIQUE_HANDLER_ID",
      ChatThreadEventHandler(),
    );

    // 移除监听
    ChatClient.getInstance.chatThreadManager.removeEventHandler("UNIQUE_HANDLER_ID");
}
```