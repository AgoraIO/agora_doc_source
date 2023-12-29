The Agora Chat SDK stores historical messages on the chat server. When a chat user logs in from a different device, you can retrieve the historical messages from the server, so that the user can also browse these messages on the new device.

This page introduces how to use the Agora Chat SDK to retrieve and delete messages from the server.

## Understand the tech

The Agora Chat SDK uses `ChatManager` to retrieve historical messages from the server. Followings are the core methods:

- `fetchConversationListFromServer`: Retrieves a list of conversations stored on the server.
- `fetchHistoryMessages`: Retrieves the historical messages in the specified conversation from the server.
- `deleteRemoteMessagesBefore`/`deleteRemoteMessagesWithIds`: Deletes historical messages from the server unidirectionally.
- `deleteRemoteConversation`: Deletes conversations and their historical messages from the server.

## Prerequisites

Before proceeding, ensure that you meet the following requirements:

- You have integrated the Agora Chat SDK, initialized the SDK, and implemented the functionality of users logging in. For details, [Get Started with Agora Chat](./agora_chat_get_started_flutter?platform=Flutter).
- You understand the [API call frequency limits](./agora_chat_limitation?platform=Flutter).

## Implementation

This section shows how to implement retrieving conversations and messages.

### Retrieve a list of conversations from the server

Call `fetchConversationListFromServer` to retrieve conversations from the server with pagination. Each retrieved conversation contains one last historical message. We recommend calling this method when the app is first installed, or when there is no conversation on the local device. Otherwise, you can call `loadAllConversations` to retrieve conversations on the local device.

```dart
try {
  List<ChatConversation> list =
      await ChatClient.getInstance.chatManager.fetchConversationListFromServer(
    pageNum: pageNum,
    pageSize: pageSize,
  );
} on ChatError catch (e) {
}
```

For users that do not support `fetchConversationListFromServer`, call `getConversationsFromServer` to retrieve the conversations from the server without pagination, the SDK, by default, retrieves the last ten conversations in the past seven days, and each conversation contains one last historical message. To adjust the time limit or the number of conversations retrieved, contact [support@agora.io](mailto:support@agora.io).

### Retrieve historical messages of the specified conversation

After retrieving conversations, you can retrieve historical messages by pagination from the server. 

To ensure data reliability, we recommend retrieving less than 50 historical messages for each method call. To retrieve more than 50 historical messages, call this method multiple times. Once the messages are retrieved, the SDK automatically updates these messages in the local database.

```dart
try {
  // The conversation ID.
  String convId = "convId";
  // The conversation type.
  ChatConversationType convType = ChatConversationType.Chat;
  // The maximin number of messages
  int pageSize = 10;
  // The message ID from which to start retrieving
  String startMsgId = "";
  ChatCursorResult<ChatMessage?> cursor =
      await ChatClient.getInstance.chatManager.fetchHistoryMessages(
    conversationId: convId,
    type: convType,
    pageSize: pageSize,
    startMsgId: startMsgId,
  );
} on ChatError catch (e) {
}
```

### Delete historical messages from the server unidirectionally

Call `deleteRemoteMessagesBefore` or `deleteRemoteMessagesWithIds` to delete historical messages one way from the server. You can remove a maximum of 50 messages from the server each time. Once the messages are deleted, you can no longer retrieve them from the server. The deleted messages are automatically removed from your local device. Other chat users can still get the messages from the server. 

<div class="alert note">To use this function, you need to contact [support@agora.io](mailto:support@agora.io) to enable it.</div>

```dart
try {
  // Delete messages by timestamp
  await ChatClient.getInstance.chatManager.deleteRemoteMessagesBefore(
    conversationId: conversationId,
    type: convType,
    timestamp: timestamp,
  );
} on ChatError catch (e) {}
try {
  // Delete messages by message ID
  await ChatClient.getInstance.chatManager.deleteRemoteMessagesWithIds(
    conversationId: conversationId,
    type: convType,
    msgIds: msgIds,
  );
} on ChatError catch (e) {}
```

### Delete conversations and related messages from the server unidirectionally

Call `deleteRemoteConversation` to delete conversations and their historical messages unidirectionally from the server. After the conversations and messages are deleted from the server, you can no longer get them from the server. The deleted conversations still exist on the local device, but the messages are automatically removed from your local device. Other chat users can still get the conversations and their historical messages from the server.

```dart
try {
  await ChatClient.getInstance.chatManager.deleteRemoteConversation(
    conversationId,
  );
} on ChatError catch (e) {}
```

## Next steps

After implementing retrieving messages, you can refer to the following documents to add more messaging functionalities to your app:

- [Message receipts](./agora_chat_message_receipt_flutter?platform=Flutter)