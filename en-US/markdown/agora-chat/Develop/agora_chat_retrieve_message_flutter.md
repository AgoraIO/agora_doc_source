The Agora Chat SDK stores historical messages on the chat server. When a chat user logs in from a different device, you can retrieve the historical messages from the server, so that the user can also browse these messages on the new device.

This page introduces how to use the Agora Chat SDK to retrieve messages from the server.

## Understand the tech

The Agora Chat SDK uses `ChatManager` to retrieve historical messages from the server. Followings are the core methods:

- `getConversationsFromServer`: Retrieve a list of conversations stored on the server.
- `fetchHistoryMessages`: Retrieve the historical messages in the specified conversation from the server.

## Prerequsites

Before proceeding, ensure that you meet the following requirements:

- You have integrated the Agora Chat SDK, initialized the SDK, and implemented the functionality of users logging in. For details, [Get Started with Agora Chat](./agora_chat_get_started_flutter?platform=Flutter).
- You understand the [API call frequency limits](./agora_chat_limitation?platform=Flutter).
- Retrieving conversations from the server is not enabled by default. To implement this feature, contact support@agora.io to enable the service. 

## Implementation

This section shows how to implement retrieving conversations and messages.

### Retrieve a list of conversations from the server

Call `getConversationsFromServer` to retrieve all the conversations from the server. We recommend calling this method when the app is first installed, or when there is no conversation on the local device. Otherwise, you can call `loadAllConversations` to retrieve conversations on the local device.

```dart
try {
  List<ChatConversation> list =
      await ChatClient.getInstance.chatManager.getConversationsFromServer();
} on ChatError catch (e) {
}
```

By default, the SDK retrieves the last ten conversations in the past seven days, and each conversation contains one last historical message. To adjust the time limit or the number of conversations retrieved, contact support@agora.io.

### Retrieve historical messages of the specified conversation

After retrieving conversations, you can retrieve historical messages by pagination from the server. 

To ensure data reliablity, we recommend retrieving less than 50 historical messages for each method call. To retrieve more than 50 historical messages, call this method multiple times. Once the messages are retrieved, the SDK automatically updates these messages in the local database.

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

## Next steps

After implementing retrieving messages, you can refer to the following documents to add more messaging functionalities to your app:

- [Message receipts](./agora_chat_message_receipt_flutter?platform=Flutter)