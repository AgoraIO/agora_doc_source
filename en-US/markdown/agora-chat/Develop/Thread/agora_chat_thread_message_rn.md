# Thread Messages

Threads enable users to create a separate conversation from a specific message within a chat group to keep the main chat uncluttered.

This page shows how to use the Agora Chat SDK to send, receive, recall, and retrieve thread messages in your app.

## Understand the tech

The Agora Chat SDK provides the `ChatManager`, `ChatMessage`, and `ChatMessageThread` classes for thread messages, which allows you to implement the following features:

- Send a thread message
- Receive a thread message
- Recall a thread message
- Retrieve a thread message

~338e0e30-e568-11ec-8e95-1b7dfd4b7cb0~

## Prerequisites

Before proceeding, ensure that you meet the following requirements:

- You have initialized the Agora Chat SDK. For details, see [Get Started with React Native](./agora_chat_get_started_rn).
- You understand the call frequency limit of the Agora Chat APIs supported by different pricing plans as described in [Limitations](./agora_chat_limitation).

<div class="alert info">The thread feature is supported by all types of <a href="https://docs.agora.io/en/agora-chat/agora_chat_plan">Pricing Plans</a> and is enabled by default once you have enabled Chat in <a href="https://console.agora.io/">Agora Console</a>.</div>

## Implementation

This section describes how to call the APIs provided by the Agora Chat SDK to implement thread features.

### Send a thread message

Sending a thread message is similar to sending a message in a chat group. The difference lies in the `isChatThread` field, as shown in the following code sample:

```typescript
// Sets `chatThreadId` to the thread ID.
// Sets `content` to the message content.
// Sets `chatType` to `GroupChat` as a thread belongs to a chat group.
// Sets `isChatThread` to `true` to mark this message as a thread message.
const message = ChatMessage.createTextMessage(chatThreadId, content, chatType, {
  isChatThread: true,
});
// Implements `ChatMessageCallback` to listen for the message sending event.
const callback = new ChatMessageCallback();
// Sends the message.
ChatClient.getInstance()
  .chatManager.sendMessage(message, callback)
  .then(() => {
    // Prints the log here if the method call succeeds.
    console.log("send message operation success.");
  })
  .catch((reason) => {
    // Prints the log here if the method call fails.
    console.log("send message operation fail.", reason);
  });
```

For more information about sending a message, see [Send Messages](./agora_chat_send_receive_messages_rn#send-a-message).


### Receive a thread message

Once a thread has a new message, all chat group members receive the `ChatMessageEventListener#onChatMessageThreadUpdated` callback. Thread members can also listen for the `ChatMessageEventListener#onMessagesReceived` callback to receive thread messages, as shown in the following code sample:

```typescript
// Inherits and implements `ChatMessageEventListener`.
class ChatMessageEvent implements ChatMessageEventListener {
  // Occurs when a message is received.
  onMessagesReceived(messages: ChatMessage[]): void {
    console.log(`onMessagesReceived: `, messages);
  }
  // Occurs when the thread has a new message.
  onChatMessageThreadUpdated(msgThread: ChatMessageThreadEvent): void {
    console.log(`onChatMessageThreadUpdated: `, msgThread);
  }
}
// Adds the message listener.
const listener = new ChatMessageEvent();
ChatClient.getInstance().chatManager.addMessageListener(listener);
// Removes the message listener.
ChatClient.getInstance().chatManager.removeMessageListener(listener);
// Removes all the message listeners.
ChatClient.getInstance().chatManager.removeAllMessageListener();
```

For more information about receiving a message, see [Receive Messages](./agora_chat_send_receive_messages_rn#receive-the-message).


### Recall a thread message

For details about how to recall a message, refer to [Recall Messages](./agora_chat_send_receive_messages_rn#recall-a-message).

Once a message is recalled in a thread, all chat group members receive the `ChatMessageEventListener#onChatMessageThreadUpdated` callback. Thread members can also listen for the `ChatMessageEventListener#onMessagesRecalled` callback, as shown in the following code sample:

```typescript
// Inherits and implements `ChatMessageEventListener`.
class ChatMessageEvent implements ChatMessageEventListener {
  // Occurs when a message is recalled.
  onMessagesRecalled(messages: ChatMessage[]): void {
    console.log(`onMessagesRecalled: `, messages);
  }
  // Occurs when a thread message is recalled.
  onChatMessageThreadUpdated(msgThread: ChatMessageThreadEvent): void {
    console.log(`onChatMessageThreadUpdated: `, msgThread);
  }
}
```

### Retrieve thread messages

You can retrieve thread messages locally or from the server, depending on your production environment.

You can check `ChatConversation#isChatThread()` to determine whether the current conversation is a thread conversation.

#### Retrieve messages of a thread from the server

You can call `asyncFetchHistoryMessage` to retrieve messages of a thread from the server. The only difference between retrieving messages of a thread from the server and retrieving group messages is that a thread ID needs to be passed in for the former and a group ID is required for the latter.

```typescript
// chatThreadID: The thread ID.
const chatThreadID = "chatThreadID";
// The chat type is set to ChatConversationType.GroupChat as a thread belongs to a group.
const convType = ChatConversationType.GroupChat;
// The number of thread messages that you expect to get on each page.
const pageSize = 10;
// The starting message ID for retrieving.
const startMsgId = "";
// The message search direction.
const direction = ChatSearchDirection.UP;
ChatClient.getInstance()
  .chatManager.fetchHistoryMessages(chatThreadID, chatType, {
    pageSize,
    startMsgId,
    direction,
  })
  .then((messages) => {
    console.log("get message success: ", messages);
  })
  .catch((reason) => {
    console.log("load conversions fail.", reason);
  });
```

#### Retrieve messages of a thread locally

By calling [`getAllConversations`](./agora_chat_manage_message_rn?platform=react-native#retrieve-conversations), you can only retrieve local one-to-one chat conversations and group conversations. To retrieve messages of a thread locally, refer to the following code sample:

```typescript
// Gets a thread conversation.
ChatClient.getInstance()
  .chatManager.getThreadConversation(chatThreadID, createIfNeed)
  .then((conv) => {
    // Gets messages of the thread from the local database. The SDK automatically loads and stores the retrieved messages to the memory.
    conv
      .getMessages(
        chatThreadID,
        ChatConversationType.GroupChat,
        startMsgId,
        direction,
        loadCount
      )
      .then((messages) => {
        console.log("success.", messages);
      })
      .catch((reason) => {
        console.log("fail.", reason);
      });
  })
  .catch((reason) => {
    console.log("fail.", reason);
  });
```