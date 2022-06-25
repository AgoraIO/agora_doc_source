# Thread Messages

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
- You understand the number of threads and thread members supported by different pricing plans as described in [Pricing Plan Details](./agora_chat_plan).

## Implementation

This section describes how to call the APIs provided by the Agora Chat SDK to implement thread features.

### Send a thread message

Sending a thread message is similar to sending a message in a chat group. The difference lies in the `isChatThreadMessage` field, as shown in the following code sample:

```dart
// Sets `targetGroup` to the ID of the chat group that receives the message.
// Sets `content` to the message content.
ChatMessage msg = ChatMessage.createTxtSendMessage(
  targetId: targetGroup,
  content: content,
);
// Sets `ChatType` to GroupChat as a thread that belongs to a chat group.
msg.chatType = ChatType.GroupChat;
// Sets `isChatThreadMessage` to `true` to mark this message as a thread message.
msg.isChatThreadMessage = true;
//  Sends the message.
ChatClient.getInstance.chatManager.sendMessage(msg);
```

For more information about sending a message, see [Send Messages](./agora_chat_send_receive_message_flutter#send-a-message).

### Receive a thread message

Once a thread has a new message, all chat group members receive the `ChatThreadManagerListener#onChatThreadUpdated` callback. Thread members can also listen for the `ChatManagerListener#onMessagesReceived` callback to receive thread messages, as shown in the following code sample:

```dart
class _ChatPageState extends State<ChatPage>
// Inherits and implements `ChatThreadManagerListener`.
    implements ChatThreadManagerListener, ChatManagerListener {
  @override
  void initState() {
    super.initState();
    // Adds the message listener.
    ChatClient.getInstance.chatManager.addChatManagerListener(this);
    // Adds the thread listener.
    ChatClient.getInstance.chatThreadManager.addChatThreadManagerListener(this);
  }
  @override
  void dispose() {
    // Removes the message listener.
    ChatClient.getInstance.chatManager.removeChatManagerListener(this);
    // Removes the thread listener.
    ChatClient.getInstance.chatThreadManager.removeChatThreadManagerListener(this);
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Container();
  }
  // Occurs when the thread has a new message.
  @override
  void onChatThreadUpdate(ChatThreadEvent event) {}
  // Occurs when a message is received.
  @override
  void onMessagesReceived(List<ChatMessage> messages) {}
  ...
}
```

For more information about receiving a message, see [Receive Messages](./agora_chat_send_receive_message_flutter#receive-the-message).

### Recall a thread message

For details about how to recall a message, refer to [Recall Messages](./agora_chat_send_receive_message_flutter#recall-a-message).

Once a message is recalled in a thread, all chat group members receive the `ChatThreadManagerListener#onChatThreadUpdated` callback. Thread members can also listen for the `ChatManagerListener#onMessagesRecalled` callback, as shown in the following code sample:

```dart
class _ChatPageState extends State<ChatPage>
    implements ChatThreadManagerListener, ChatManagerListener {
  @override
  void initState() {
    super.initState();
    // Adds the message listener.
    ChatClient.getInstance.chatManager.addChatManagerListener(this);
    // Adds the thread listener.
    ChatClient.getInstance.chatThreadManager.addChatThreadManagerListener(this);
  }
  @override
  void dispose() {
    // Removes the message listener.
    ChatClient.getInstance.chatManager.removeChatManagerListener(this);
    // Removes the thread listener.
    ChatClient.getInstance.chatThreadManager.removeChatThreadManagerListener(this);
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Container();
  }
  // Occurs when a thread message is recalled.
  @override
  void onChatThreadUpdate(ChatThreadEvent event) {}
  // Occurs when a message is recalled.
  @override
  void onMessagesRecalled(List<ChatMessage> messages) {}
  ...
}
```

### Retrieve thread messages from the server

For details about how to retrieve messages from the server, see [Retrieve Conversations and Messages from Server](./agora_chat_retrieve_message_flutter).