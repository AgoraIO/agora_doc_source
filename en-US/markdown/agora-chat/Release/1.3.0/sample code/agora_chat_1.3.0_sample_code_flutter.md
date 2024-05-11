1. Clear all conversations and messages in them

`ChatManager#deleteAllMessageAndConversation`

```dart
try {
  await ChatClient.getInstance.chatManager.deleteAllMessageAndConversation(clearServerData: true);
} on ChatError catch (e) {
  debugPrint('deleteAllMessageAndConversation error: ${e.code} ${e.description}');
}
```

2. Search for messages by search scope

`ChatManager#loadMessagesWithKeyword`

```dart
try {
  List<ChatMessage> msgs = await ChatClient.getInstance.chatManager.loadMessagesWithKeyword(
    'keyword',
    searchScope: MessageSearchScope.All,
  );
} on ChatError catch (e) {
  debugPrint('loadMessagesWithKeyword error: ${e.code} ${e.description}');
}
```

`conversation#loadMessagesWithKeyword`

```dart
 try {
  ChatConversation? conversation = await ChatClient.getInstance.chatManager.getConversation(targetId);
  List<ChatMessage>? msgs = await conversation?.loadMessagesWithKeyword(
    'keyword',
    searchScope: MessageSearchScope.All,
  );
} on ChatError catch (e) {
  debugPrint('loadMessagesWithKeyword error: ${e.code} ${e.description}');
}
```

3. Mark a conversation

`ChatManager#addRemoteAndLocalConversationsMark`

```dart
try {
  await ChatClient.getInstance.chatManager.addRemoteAndLocalConversationsMark(
    conversationIds: conversationIds,
    mark: ConversationMarkType.Type0,
  );
} on ChatError catch (e) {
  debugPrint('addRemoteAndLocalConversationsMark error: ${e.code} ${e.description}');
}
```

`ChatManager#deleteRemoteAndLocalConversationsMark`

```dart
try {
  await ChatClient.getInstance.chatManager.deleteRemoteAndLocalConversationsMark(
    conversationIds: conversationIds,
    mark: ConversationMarkType.Type0,
  );
} on ChatError catch (e) {
  debugPrint('deleteRemoteAndLocalConversationsMark error: ${e.code} ${e.description}');
}
```

`ChatManager#fetchConversationsByOptions`

```dart
try {
  ChatCursorResult<ChatConversation> result = await ChatClient.getInstance.chatManager.fetchConversationsByOptions(
    options: ConversationFetchOptions.mark(
      ConversationMarkType.Type0,
    ),
  );
} on ChatError catch (e) {
  debugPrint('fetchConversationsByOptions error: ${e.code} ${e.description}');
}
```

`Gets local conversations by conversation mark`: 

```dart
try {
  List<ChatConversation> markedConversations = [];
  List<ChatConversation> conversations = await ChatClient.getInstance.chatManager.loadAllConversations();
  for (var conversation in conversations) {
    if (conversation.marks?.contains(ConversationMarkType.Type0) == true) {
      markedConversations.add(conversation);
    }
  }
  debugPrint('marked conversations: $markedConversations');
} on ChatError catch (e) {
  debugPrint('get marks conversations error: ${e.code} ${e.description}');
}
```

`Conversation#marks`

```dart
try {
  ChatConversation? conversation = await ChatClient.getInstance.chatManager.getConversation(targetId);
  List<ConversationMarkType>? markType = conversation?.marks;
} on ChatError catch (e) {
  debugPrint('get marks error: ${e.code} ${e.description}');
}
```

4. Set whether the message is delivered only when the recipient(s) is/are online.

`ChatMessage#deliverOnlineOnly` 

```dart
// Create a text message.
final msg = ChatMessage.createTxtSendMessage(
  // `targetId`: The message recipient, which is the user ID of the peer user for one-to-one chat and group ID for group chat.
  targetId: conversationId,
  // `content`: The text content of the message.
  content: 'hello',
  // The chat type, which is `Chat` for one-to-one chat and `GroupChat` for group chat. The default value is `Chat`.
  chatType: ChatType.Chat,
  deliverOnlineOnly: true,
);

// Send the message.
ChatClient.getInstance.chatManager.sendMessage(msg);
```

5. Allow the current user to retrieve the total number of joined groups

`GroupManager#fetchJoinedGroupCount`

```dart
try {
  int count = await ChatClient.getInstance.groupManager.fetchJoinedGroupCount();
} on ChatError catch (e) {
  debugPrint('fetchJoinedGroupCount error: ${e.code} ${e.description}');
}
```

6. Pin a message

`ChatManager#pinMessage`

```dart
try {
  await ChatClient.getInstance.chatManager.pinMessage(messageId: msgId);
} on ChatError catch (e) {
  debugPrint('pinMessage error: ${e.code} ${e.description}');
}
```

`ChatManager#unpinMessage`

```dart
  try {
  await ChatClient.getInstance.chatManager.unpinMessage(messageId: msgId);
} on ChatError catch (e) {
  debugPrint('unpinMessage error: ${e.code} ${e.description}');
}
```

`ChatManager#fetchPinnedMessages`

```dart
try {
  List<ChatMessage> pinnedMessages = await ChatClient.getInstance.chatManager.fetchPinnedMessages(
    conversationId: conversationId,
  );
} on ChatError catch (e) {
  debugPrint('fetchPinnedMessages error: ${e.code} ${e.description}');
}
```

`Conversation#loadPinnedMessages`: Gets the list of pinned messages in a local conversation.

```dart
try {
  ChatConversation? conversation = await ChatClient.getInstance.chatManager.getConversation(targetId);
  List<ChatMessage>? pinnedMessages = await conversation?.loadPinnedMessages();
} on ChatError catch (e) {
  debugPrint('loadPinnedMessages error: ${e.code} ${e.description}');
}
```

`MessagePinInfo`: Gets pinning details of a message.

```dart
try {
  MessagePinInfo? pinInfo = await message.pinInfo();
} on ChatError catch (e) {
  debugPrint('pinInfo error: ${e.code} ${e.description}');
}
```

`MessageListener#onMessagePinChanged`

```dart
ChatClient.getInstance.chatManager.addEventHandler(
  'UNIQUE_HANDLER_ID',
  ChatEventHandler(
    onMessagePinChanged: (messageId, conversationId, pinOperation, pinInfo) {},
  ),
);

//...
ChatClient.getInstance.chatManager.removeEventHandler('UNIQUE_HANDLER_ID');

```

7. `ChatGroupEventHandler#onRequestToJoinDeclinedFromGroup`

```dart
ChatClient.getInstance.groupManager.addEventHandler(
  'UNIQUE_HANDLER_ID',
  ChatGroupEventHandler(
    onRequestToJoinReceivedFromGroup: (groupId, groupName, applicant, reason) {},
  ),
);

//...
ChatClient.getInstance.groupManager.removeEventHandler('UNIQUE_HANDLER_ID');
```    

8. Forward a single message

```dart
void forwardMessage(ChatMessage message) async {
  var msg = ChatMessage.createSendMessage(
    to: message.to,
    body: message.body,
    chatType: message.chatType,
  );

  ChatClient.getInstance.chatManager.sendMessage(msg);
}
```

9. Search for `loginWithAgoraToken` in the quick start and replace it with `loginWithToken`, as the former method is deprecated.

```dart
try {
  await ChatClient.getInstance.loginWithToken(userId, token);
} on ChatError catch (e) {
  debugPrint("login failed, code: ${e.code}, desc: ${e.description}");
}
```

10. Chatroom: member count callback

### Update the chat room member count in real time

If many members join or leave a chat room in a very short time, you can update the chat room member count in real time:

1. When a user joins a chat room, other members in the chat room receive the `onMemberJoinedFromChatRoom` event. When a member leaves or is removed from a chat room, other members in the chat room receive the `onMemberExitedFromChatRoom` event.

2. After the event is received, you can call the `getChatRoomWithId` method to get local details of the chat room, including the current number of members in the chat room.

```dart
ChatClient.getInstance.chatRoomManager.addEventHandler(
    'UNIQUE_HANDLER_ID',
    ChatRoomEventHandler(
      onMemberJoinedFromChatRoom: (roomId, participant) async {
        ChatRoom? room = await ChatClient.getInstance.chatRoomManager.getChatRoomWithId(roomId);
        debugPrint("current room member count ${room?.memberCount}");
      },
      onMemberExitedFromChatRoom: (roomId, roomName, participant) async {
        ChatRoom? room = await ChatClient.getInstance.chatRoomManager.getChatRoomWithId(roomId);
        debugPrint("current room member count ${room?.memberCount}");
      },
    ));

// ...
ChatClient.getInstance.chatRoomManager.removeEventHandler('UNIQUE_HANDLER_ID');
```

Above is my English translation.

Following is the Chinese version of the Agora Chat doc for your reference.

### 实时更新聊天室成员人数

如果聊天室短时间内有成员频繁加入或退出时，实时更新聊天室成员人数的逻辑如下：

1. 聊天室内有成员加入时，其他成员会收到 `ChatRoomEventHandler#onMemberJoinedFromChatRoom` 事件。有成员主动或被动退出时，其他成员会收到 `ChatRoomEventHandler#onMemberExitedFromChatRoom` 事件。

2. 收到通知事件后，调用 `ChatRoomManager#getChatRoomWithId` 方法获取本地聊天室详情，其中包括聊天室当前人数。

```dart
ChatClient.getInstance.chatRoomManager.addEventHandler(
    'UNIQUE_HANDLER_ID',
    ChatRoomEventHandler(
      onMemberJoinedFromChatRoom: (roomId, participant) async {
        ChatRoom? room = await ChatClient.getInstance.chatRoomManager.getChatRoomWithId(roomId);
        debugPrint("current room member count ${room?.memberCount}");
      },
      onMemberExitedFromChatRoom: (roomId, roomName, participant) async {
        ChatRoom? room = await ChatClient.getInstance.chatRoomManager.getChatRoomWithId(roomId);
        debugPrint("current room member count ${room?.memberCount}");
      },
    ));

// ...
ChatClient.getInstance.chatRoomManager.removeEventHandler('UNIQUE_HANDLER_ID');
```


11. Replace `ChatManager#fetchConversation` with `ChatManager#fetchConversationsByOptions` and add the following source code on the page of the following URL: https://docs.agora.io/en/agora-chat/client-api/messages/retrieve-messages?platform=flutter#retrieve-a-list-of-conversations-from-the-server

```dart
ChatClient.getInstance.chatManager.fetchConversationsByOptions(
      options: ConversationFetchOptions(),
    );
```

12. Replace `ChatManager#fetchPinnedConversations` with `ChatManager#fetchConversationsByOptions` and add the following source code on the page of the following URL: https://docs.agora.io/en/agora-chat/client-api/messages/retrieve-messages?platform=flutter#retrieve-the-pinned-conversations-from-the-server-with-pagination

```dart
ChatClient.getInstance.chatManager.fetchConversationsByOptions(
      options: ConversationFetchOptions.pinned(),
    );
```



