## 1. 发送和接收 GIF 图片消息

### 发送 GIF 图片消息

自 Flutter SDK 1.4.0 开始，支持发送 GIF 图片消息。

GIF 图片消息是一种特殊的图片消息，与普通图片消息不同，**GIF 图片发送时不能压缩**。

图片缩略图的生成和下载与普通图片消息相同，详见 [发送图片消息](#发送图片消息)。

使用 `ChatMessage#createImageSendMessage` 方法构造 GIF 图片消息体。

```dart
final msg = ChatMessage.createImageSendMessage(
  targetId: 'targetId',
  filePath: 'filePath',
  isGif: true,
);

ChatClient.getInstance.chatManager.sendMessage(msg);
```

### 接收 GIF 图片消息

自 Flutter SDK 1.4.0 开始，支持接收 GIF 图片消息。

与普通消息相同，接收 GIF 图片消息时，接收方会收到 `onMessagesReceived` 回调。接收方判断为图片消息后，读取消息体的 `isGif` 属性，若值为 `true`，则为 GIF 图片消息。

```dart
final handler = ChatEventHandler(
  onMessagesReceived: (messages) {
    for (final message in messages) {
      final body = message.body;
      if (body is ChatImageMessageBody && body.isGif) {
        // 根据业务情况处理 GIF 消息，例如下载并展示该消息。
      }
    }
  },
);

ChatClient.getInstance.chatManager.addEventHandler(
  'UNIQUE_HANDLER_ID',
  handler,
);
```

## 2. 管理群组头像

自 Flutter SDK 1.4.0 开始，支持群组头像功能。

### 设置群组头像

- 创建群组时，可设置群组头像：

```dart
try {
  await ChatClient.getInstance.groupManager.createGroup(
    groupName: 'groupName',
    avatarUrl: 'avatarUrl',
    options: ChatGroupOptions(
      style: ChatGroupStyle.PrivateOnlyOwnerInvite,
      maxCount: 200,
    ),
  );
} on ChatError catch (e) {}
```

- 创建群组后，若设置群组头像，可调用 [修改群组头像](#修改群组头像) API 设置头像。

### 修改群组头像

创建群组完成后，群主或管理员可调用 `ChatGroupManager#updateGroupAvatar` 设置或修改群组头像：

```dart
try {
  await ChatClient.getInstance.groupManager.updateGroupAvatar(
    groupId: 'groupId',
    avatarUrl: 'avatarUrl',
  );
} on ChatError catch (e) {}
```

群组头像被修改后，其他群成员会收到 `ChatGroupEventHandler#onSpecificationDidUpdate` 回调：

```dart
ChatClient.getInstance.groupManager.addEventHandler(
  'UNIQUE_HANDLER_ID',
  ChatGroupEventHandler(
    onSpecificationDidUpdate: (group) {},
  ),
);
```

### 获取群组头像

群成员可以通过获取群详情的方法 `ChatGroupManager#fetchGroupInfoFromServer`，获取群组头像：

```dart
try {
  ChatGroup group =
      await ChatClient.getInstance.groupManager.fetchGroupInfoFromServer(
    'groupId',
  );
  String? avatarUrl = group.avatarUrl;
} on ChatError catch (e) {}
```

## 3. 聊天室成员加入禁言列表事件

请在 Flutter 端的 [Manage chat rooms 文档中的 Listen for chat room events 一节中](https://docs.agora.io/en/agora-chat/client-api/chat-room/manage-chatrooms?platform=flutter#listen-for-chat-room-events) 添加 `onMuteListAddedFromChatRoom` 事件，替换旧事件：

```dart
// 禁言指定成员。被禁言的成员会收到该事件。
onMuteListAddedFromChatRoom: (roomId, mutes) {},
```

## 4. 从服务器获取指定群成员发送的消息

自 1.4.0 版本开始，对于单个群组会话，你可以从服务器获取指定成员（而非全部成员）发送的消息。

```dart
ChatCursorResult<ChatMessage> result =
    await ChatClient.getInstance.chatManager.fetchHistoryMessagesByOption(
  'conversationId',
  ChatConversationType.GroupChat,
  options: const FetchMessageOptions(senders: ['senderA', 'senderB']),
);
```

## 5. 从本地获取指定群成员发送的消息

自 1.4.0 版本开始，对于单个群组会话，你可以从本地获取指定成员（而非全部成员）发送的消息。

```dart
List<ChatMessage> list = await conversation.loadMessagesWithKeyword(
  keywords,
  senders: ['senderA', 'senderB'],
);
```

## 6. 根据关键字获取本地会话中的消息

自 SDK 1.4.0 版本开始，你可以通过设置关键词获取本地会话中的某些消息。SDK 返回会话 ID 及消息 ID 列表，消息 ID 根据你设置的 `direction` 参数按照消息时间戳的正序或倒序列出。

```dart
Map<String, List<String>> result =
    await ChatClient.getInstance.chatManager.loadConversationMessagesWithKeyword(
  keyword: 'hello',
  timestamp: -1,
  sender: null,
  direction: ChatSearchDirection.Up,
  scope: MessageSearchScope.All,
);
```

## 7. 根据消息 ID 获取本地消息

自 SDK 1.4.0 版本开始，你可以调用 `loadMessagesWithIds` 方法传入单个或多个消息 ID 获取单个本地会话中的消息。

每次最多可获取单个会话的 20 条消息。

```dart
// messageIdList：消息 ID 列表。每次最多可传入 20 个消息 ID。
List<ChatMessage> messages =
    await ChatClient.getInstance.chatManager.loadMessagesWithIds(
  messageIdList,
  conversationId,
);
```

## 8. 批量通知群成员进出群

1. 请在 Chat Flutter 端的 [Manage chat group 页面](https://docs.agora.io/en/agora-chat/client-api/chat-group/manage-chat-groups?platform=flutter#listen-for-chat-group-events)  的 "Listen for chat group events" 中添加进出群组的新事件，并移掉旧事件。

```dart
// 有新成员加入了群。除了新成员，其他群成员会收到该回调。
onMembersJoinedFromGroup: (groupId, userIds) {},

// 有成员主动退出群。除了退群的成员，其他群成员会收到该回调。
onMembersExitedFromGroup: (groupId, userIds) {},
```

2. 此外，请在 Chat Flutter 端的 [Manage chat group 页面](https://docs.agora.io/en/agora-chat/client-api/chat-group/manage-chat-groups?platform=flutter) 中搜索所有的旧事件，用新事件进行替换。

## 9. 修改消息

对于单聊、群组和聊天室聊天会话中已经发送成功的消息，SDK 支持对这些消息的内容进行修改。若使用该功能，**需联系环信商务开通**。

- SDK 1.4.0 之前的版本仅支持对单聊和群组会话中发送后的文本消息进行修改。
- SDK 1.4.0 及之后版本支持对单聊、群组和聊天室会话中各类消息进行修改：
  - 文本/自定义消息：支持修改消息内容（body）和扩展字段 `ext`。
  - 文件/视频/音频/图片/位置/合并转发消息：只支持修改消息扩展字段 `ext`。
  - 命令消息：不支持修改。

示例代码如下：

```dart
// 文本消息：可同时修改消息体和消息扩展属性
final txtBody = ChatTextMessageBody(content: 'new content');
final attributes = {
  'newKey': 'new value',
};
await ChatClient.getInstance.chatManager.modifyMessage(
  messageId: messageId,
  msgBody: txtBody,
  attributes: attributes,
);

// 自定义消息：可同时修改消息体和消息扩展属性
final customBody = ChatCustomMessageBody(event: 'new event');
final customAttributes = {
  'newKey': 'new value',
};
await ChatClient.getInstance.chatManager.modifyMessage(
  messageId: messageId,
  msgBody: customBody,
  attributes: customAttributes,
);

// 文件/视频/音频/图片/位置/合并转发消息：只能修改消息扩展属性
final fileAttributes = {
  'newKey': 'new value',
};
await ChatClient.getInstance.chatManager.modifyMessage(
  messageId: messageId,
  attributes: fileAttributes,
);
```

```dart
final handler = ChatEventHandler(
  onMessageContentChanged: (message, operatorId, operationTime) {},
);

// 添加消息监听
ChatClient.getInstance.chatManager.addEventHandler(
  "UNIQUE_HANDLER_ID",
  handler,
);

// 移除消息监听
ChatClient.getInstance.chatManager.removeEventHandler("UNIQUE_HANDLER_ID");
```

## 10. 撤回消息

- 对于单聊会话，只支持发送方撤回发送成功的消息。若消息过期，撤回失败。
- 对于群组/聊天室会话，普通成员只能撤回自己发送的消息，若消息过期，撤回失败。自 SDK 1.4.0 开始，群主/聊天室所有者和管理员可撤回其他用户发送的消息，即使消息过期也能撤回。

## 11. Token 即将过期回调触发时机变化

你可以在登录相关流程中注册连接监听。自 1.4.0 版本开始，SDK 会在 Token 有效期达到 80% 时回调即将过期通知。

```dart
ChatClient.getInstance.addConnectionEventHandler(
  'Identifier',
  ConnectionEventHandler(
    // 自 1.4.0 版本，SDK 会在 Token 有效期达到 80% 时回调即将过期通知（之前版本为 50%）。
    onTokenWillExpire: () {},
  ),
);
```

## 12. 群成员列表包含群成员的用户 ID、加群时间和成员角色

自 1.4.0 版本开始，获取群成员列表时除了成员的用户 ID，还包括成员角色和加入群组的时间。

```dart
try {
  ChatCursorResult<GroupMemberInfo> result =
      await ChatClient.getInstance.groupManager.fetchGroupMembersInfo(
    groupId: groupId,
    cursor: cursor,
    //limit: 每页期望返回的群成员数量，上限取决于服务端，详见 https://docs.agora.io/en/agora-chat/restful-api/chat-group-management/manage-group-members#retrieving-group-members。
    limit: limit,
  );
} on ChatError catch (e) {}
```
