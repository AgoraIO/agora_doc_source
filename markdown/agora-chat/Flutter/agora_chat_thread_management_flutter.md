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

- 完成 `1.0.5 或以上版本` SDK 初始化，详见 [快速开始](https://docs.agora.io/en/agora-chat/agora_chat_get_started_flutter)。
- 了解 [使用限制](https://docs.agora.io/en/agora-chat/agora_chat_limitation)中所述。

## 实现方法

本节介绍如何使用即时通讯 IM Flutter SDK 提供的 API 实现上述功能。

### 创建线程

所有聊天组成员都可以调用`createChatThread`以从聊天组中的特定消息创建线程。

在聊天组中创建线程后，所有聊天组成员都会收到`ChatThreadEventHandler#onChatThreadCreate`回调。在多设备场景下，所有其他设备都会收到事件`ChatMultiDeviceEventHandler#onChatThreadEvent`触发的回调`ChatMultiDevicesEvent#CHAT_THREAD_CREATE`。

以下代码示例显示了如何在聊天组中创建线程：

```dart
// name: The name of a thread. The maximum length of a thread name is 64 characters.
// messageId: The ID of a message, from which a thread is created.
// parentId: The ID of a chat group where a thread resides.
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

### 销毁线程

只有群主和管理员可以调用`destroyChatThread`解散群中的话题。

一旦线程被解散，所有聊天组成员都会收到`ChatThreadEventHandler#onChatThreadDestroy`回调。在多设备场景下，所有其他设备都会收到事件`ChatMultiDeviceEventHandler#onChatThreadEvent`触发的回调`ChatMultiDevicesEvent#CHAT_THREAD_DESTROY`。

一旦线程被销毁或者线程所在的聊天组被销毁，该线程的所有数据都会从本地数据库和内存中删除。

以下代码示例显示了如何销毁线程：

```dart
// chatThreadID: The ID of a thread.
try {
  await ChatClient.getInstance.chatThreadManager.destroyChatThread(
    chatThreadId: chatThreadId,
  );
} on ChatError catch (e) {
}
```

### 加入一个线程

所有聊天群成员可以参考以下步骤加入话题：

1. 使用以下两种方法之一来检索线程 ID：

- 调用 获取聊天群中的话题列表[`fetchChatThreadsWithParentId`](https://docs.agora.io/en/agora-chat/agora_chat_thread_management_flutter?platform=Flutter#fetch)，找到你想加入的话题ID。
- 在您收到的`ChatThreadEventHandler#onChatThreadCreate`和回调中检索线程 ID 。`ChatThreadEventHandler#onChatThreadUpdate`

1. 调用`joinChatThread`传入线程ID，加入指定线程。

在多设备场景下，所有其他设备都会收到事件`ChatMultiDeviceEventHandler#onChatThreadEvent`触发的回调`ChatMultiDevicesEvent#CHAT_THREAD_JOIN`。

以下代码示例显示了如何加入线程：

```dart
// chatThreadId: The ID of a thread.
try {
  ChatThread chatThead =
      await ChatClient.getInstance.chatThreadManager.joinChatThread(
    chatThreadId: chatThreadId,
  );
} on ChatError catch (e) {
}
```

### 留下一个话题

所有线程成员都可以调用`leaveChatThread`离开线程。一旦成员离开线程，他们将无法再收到线程消息。

在多设备场景下，所有其他设备都会收到事件`ChatMultiDeviceEventHandler#onThreadEvent`触发的回调`ChatMultiDevicesEvent#CHAT_THREAD_LEAVE`。

以下代码示例显示了如何离开线程：

```dart
// chatThreadId: The ID of a thread.
try {
  await ChatClient.getInstance.chatThreadManager.leaveChatThread(
    chatThreadId: chatThreadId,
  );
} on ChatError catch (e) {
}
```

### 从线程中删除成员

只有聊天组所有者和管理员可以调用`removeMemberFromChatThread`从线程中删除指定成员。

一旦成员从线程中删除，他们就会收到`ChatThreadEventHandler#onUserKickOutOfChatThread`回调并且不能再接收线程消息。在多设备场景下，所有其他设备都会收到事件`ChatMultiDeviceEventHandler#onChatThreadEvent`触发的回调`ChatMultiDevicesEvent#CHAT_THREAD_KICK`。

以下代码示例显示了如何从线程中删除成员：

```dart
// chatThreadId: The ID of a thread.
// memberId: The ID of the user to be removed from a thread.
try {
  await ChatClient.getInstance.chatThreadManager.removeMemberFromChatThread(
    memberId: memberId,
    chatThreadId: chatThreadId,
  );
} on ChatError catch (e) {
}
```

### 更新线程的名称

只有聊天组所有者、聊天组管理员和线程创建者可以调用`updateChatThreadName`以更新线程名称。

更新线程名称后，所有聊天组成员都会收到`ChatThreadEventHandler#onChatThreadUpdate`回调。在多设备场景下，所有其他设备都会收到事件`ChatMultiDeviceEventHandler#onThreadEvent`触发的回调`ChatMultiDevicesEvent#CHAT_THREAD_UPDATE`。

以下代码示例显示了如何更新线程名称：

```dart
// chatThreadId: The ID of a thread.
// name: The updated thread name. The maximum length of a thread name is 64 characters.
try {
  await ChatClient.getInstance.chatThreadManager.updateChatThreadName(
    newName: name,
    chatThreadId: chatThreadId,
  );
} on ChatError catch (e) {
}
```

### 检索线程的属性

所有聊天组成员都可以调用`fetchChatThread`从服务器检索线程属性。

以下代码示例显示了如何检索线程属性：

```dart
// chatThreadId: The ID of a thread.
try {
  ChatThread? chatThread =
      await ChatClient.getInstance.chatThreadManager.fetchChatThread(
    chatThreadId: chatThreadId,
  );
} on ChatError catch (e) {
}
```

### 检索线程的成员列表

所有聊天组成员都可以调用`fetchChatThreadMember`从服务器获取线程的分页成员列表，如以下代码示例所示：

```dart
// chatThreadId: The thread ID.
// limit: The maximum number of members to retrieve per page. The range is [1, 50].
// cursor: The position from which to start getting data. Pass in `null` or an empty string at the first call.
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

### 检索线程列表

用户可以调用`fetchJoinedChatThreads`从服务器获取他们加入的所有线程的分页列表，如以下代码示例所示：

```dart
// limit: The maximum number of threads to retrieve per page. The range is [1, 50].
// cursor: The position from which to start getting data. Pass in `null` or an empty string at the first call.
try {
  ChatCursorResult<ChatThread> chatThreads =
      await ChatClient.getInstance.chatThreadManager.fetchJoinedChatThreads(
    limit: limit,
    cursor: cursor,
  );
} on ChatError catch (e) {
}
```

用户可以通过调用`fetchJoinedChatThreadsWithParentId`从服务器中获取他们在指定聊天组中加入的所有线程的分页列表，如以下代码示例所示：

```dart
// parentId: The chat group ID.
// limit: The maximum number of threads to retrieve per page. The range is [1, 50].
// cursor: The position from which to start getting data. Pass in `null` or an empty string at the first call.
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

用户也可以调用`fetchChatThreadsWithParentId`从服务器获取指定聊天组中所有线程的分页列表，如下代码示例所示：

```dart
// parentId: The chat group ID.
// limit: The maximum number of threads to retrieve per page. The range is [1, 50].
// cursor: The position from which to start getting data. Pass in `null` or an empty string at the first call.
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

### 从多个线程中检索最新消息

用户可以调用`fetchLatestMessageWithChatThreads`从多个线程中检索最新消息。

以下代码示例显示了如何从多个线程中检索最新消息：

```dart
// chatThreadIds: The thread IDs. You can pass in a maximum of 20 thread IDs at each call.
try {
  Map<String, ChatMessage> map = await ChatClient.getInstance.chatThreadManager
      .fetchLatestMessageWithChatThreads(
    chatThreadIds: chatThreadIds,
  );
} on ChatError catch (e) {
}
```

### 监听线程事件

为了监控线程事件，用户可以监听`ChatThreadManager`类中的回调并相应地添加应用程序逻辑。如果用户想停止侦听回调，请确保用户删除侦听器以防止内存泄漏。

参考以下代码示例监听线程事件：

```dart
    // Adds the chat thread event handler.
    ChatClient.getInstance.chatThreadManager.addEventHandler(
      "UNIQUE_HANDLER_ID",
      ChatThreadEventHandler(),
    );

    // Removes the chat thread event handler.
    ChatClient.getInstance.chatThreadManager.removeEventHandler("UNIQUE_HANDLER_ID");
}
```