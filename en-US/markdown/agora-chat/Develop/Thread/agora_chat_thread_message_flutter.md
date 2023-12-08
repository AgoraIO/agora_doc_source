Threads enable users to create a separate conversation from a specific message within a chat group to keep the main chat uncluttered.

This page shows how to use the Agora Chat SDK to send, receive, recall, and retrieve thread messages in your app.

## Understand the tech

The Agora Chat SDK provides the `ChatThreadManager`, `ChatMessage`, and `ChatThread` classes for thread messages, which allows you to implement the following features:

- Send a thread message
- Receive a thread message
- Recall a thread message
- Retrieve a thread message

~338e0e30-e568-11ec-8e95-1b7dfd4b7cb0~

## Prerequisites

Before proceeding, ensure that you meet the following requirements:

- You have initialized the Agora Chat SDK. For details, see [Get Started with Flutter](./agora_chat_get_started_flutter).
- You understand the call frequency limit of the Agora Chat APIs supported by different pricing plans as described in [Limitations](./agora_chat_limitation).

<div class="alert info">The thread feature is supported by all types of <a href="https://docs.agora.io/en/agora-chat/agora_chat_plan">Pricing Plans</a> and is enabled by default once you have enabled Chat in <a href="https://console.agora.io/">Agora Console</a>.</div>

## Implementation

This section describes how to call the APIs provided by the Agora Chat SDK to implement thread features.

### Send a thread message

Sending a thread message is similar to sending a message in a chat group. The difference lies in the `isChatThreadMessage` field, as shown in the following code sample:

```dart
// Sets `targetId` to thread ID.
// Sets `content` to the message content.
ChatMessage msg = ChatMessage.createTxtSendMessage(
  targetId: threadId,
  content: content,
  chatType: ChatType.GroupChat,
);
// Sets `isChatThreadMessage` to `true` to mark this message as a thread message.
msg.isChatThreadMessage = true;
//  Sends the message.
ChatClient.getInstance.chatManager.sendMessage(msg);
```

For more information about sending a message, see [Send Messages](./agora_chat_send_receive_message_flutter#send-a-message).

### Receive a thread message

Once a thread has a new message, all chat group members receive the `ChatThreadEventHandler#onChatThreadUpdated` callback. Thread members can also listen for the `ChatEventHandler#onMessagesReceived` callback to receive thread messages, as shown in the following code sample:

```dart
  // Adds the chat event handler.
  ChatClient.getInstance.chatManager.addEventHandler(
    "UNIQUE_HANDLER_ID",
    ChatEventHandler(
      onMessagesReceived: (messages) {},
    ),
  );
  // Adds the thread event handler.
  ChatClient.getInstance.chatThreadManager.addEventHandler(
    "UNIQUE_HANDLER_ID",
    ChatThreadEventHandler(
      onChatThreadUpdate: (event) {},
    ),
  );
  ...
  // Removes the chat event handler.
  ChatClient.getInstance.chatManager.removeEventHandler("UNIQUE_HANDLER_ID");
  // Removes the chat thread event handler.
  ChatClient.getInstance.chatThreadManager.removeEventHandler("UNIQUE_HANDLER_ID");
```

For more information about receiving a message, see [Receive Messages](./agora_chat_send_receive_message_flutter#receive-the-message).

### Recall a thread message

For details about how to recall a message, refer to [Recall Messages](./agora_chat_send_receive_message_flutter#recall-a-message).

Once a message is recalled in a thread, all chat group members receive the `ChatThreadEventHandler#onChatThreadUpdated` callback. Thread members can also listen for the `ChatEventHandler#onMessagesRecalled` callback, as shown in the following code sample:

```dart
  // Adds the chat event handler.
  ChatClient.getInstance.chatManager.addEventHandler(
    "UNIQUE_HANDLER_ID",
    ChatEventHandler(
      onMessagesRecalled: (messages) {},
    ),
  );
  // Adds the thread event handler.
  ChatClient.getInstance.chatThreadManager.addEventHandler(
    "UNIQUE_HANDLER_ID",
    ChatThreadEventHandler(
      onChatThreadUpdate: (event) {},
    ),
  );
  ...
  // Removes the chat event handler.
  ChatClient.getInstance.chatManager.removeEventHandler("UNIQUE_HANDLER_ID");
  // Removes the chat thread event handler.
  ChatClient.getInstance.chatThreadManager.removeEventHandler("UNIQUE_HANDLER_ID");
```

### Retrieve thread messages

You can retrieve thread messages locally or from the server, depending on your production environment.

You can check `ChatConversation#isChatThread()` to determine whether the current conversation is a thread conversation.

#### Retrieve messages of a thread from the server

You can call `fetchHistoryMessages` to retrieve messages of a thread from the server. The only difference between retrieving messages of a thread from the server and retrieving group messages is that a thread ID needs to be passed in for the former and a group ID is required for the latter.

```dart
try {
  // The thread ID.
  String threadId = "threadId";
  // The conversation type is set to `GroupChat` as a thread belongs to a group conversation.
  ChatConversationType convType = ChatConversationType.GroupChat;
  // The number of thread messages that you expect to get on each page.
  int pageSize = 10;
  // The starting message ID for retrieving.
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

#### Retrieve messages of a thread locally

By calling [`loadAllConversations`](./agora_chat_manage_message_flutter?platform=flutter#retrieve-conversations), you can only retrieve local one-to-one chat conversations and group conversations. To retrieve messages of a thread locally, refer to the following code sample:

```dart
try {
  // The thread ID.
  String threadId = "threadId";
  // The conversation type is set to `GroupChat` as a thread belongs a group conversation.
  ChatConversationType convType = ChatConversationType.GroupChat;
  ChatConversation? conversation = await ChatClient.getInstance.chatManager
        .getThreadConversation(threadId);
  // The starting message for retrieving.
  String startMsgId = "startMsgId";
  // The number of messages that you expect to retrieve on each page.
  int pageSize = 10;
  List<ChatMessage>? list = await conversation?.loadMessages(
      startMsgId: startMsgId, loadCount: pageSize);
} on ChatError catch (e) {}
```