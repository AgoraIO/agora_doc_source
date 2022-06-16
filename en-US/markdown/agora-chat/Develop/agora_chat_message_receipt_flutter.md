After a user sends a message to another chat user or chat group, this user expects to know whether the message is delievered or read. The Agora Chat SDK provides the message receipt feature, which enables you to send a receipt to the message sender once the message is delievered or read.

This page introduces how to use the Agora Chat SDK to implement message receipt functionalities in one-to-one chats and chat groups.

## Understand the tech

The Agora Chat SDK uses `ChatManager` to provide message receipt, which includes delivery receipts and read receipts. Followings are the core methods:

- `ChatOptions.requireDeliveryAck`: Enable message delivery receipts. 
- `ChatOptions.requireAck`: Enable conversation and message read receipts.
- `ChatManager.sendConversationReadAck`: Send a conversation read receipt.
- `ChatManager.sendMessageReadAck`: Send a message read receipt.
- `ChatManager.sendGroupMessageReadAck`: Send a group message read receipt.

The logic for implementing these receipts are as follows:

- Message delivery receipts

  1. The message sender enables delivery receipts by setting `ChatOptions.requireDeliveryAck` as `true`.
  2. After the recipient receives the message, the SDK automatically sends a delivery receipt to the sender.
  3. The sender receives the delivery receipt by listening for `onMessageDelivered`.

- Conversation and message read receipts

  1. The message sender enables read receipt by setting `ChatOptions.requireAck` as `true`.
  2. After reading the message, the recipient calls `sendConversationReadAck` or `sendMessageReadAck` to send a conversation or message read receipt.
  3. The sender receives the conversation or message receipt by listening for `onConversationRead` or `onMessageRead`.

## Prerequisites

Before proceeding, ensure that you meet the following requirements:

- You have integrated the Agora Chat SDK, initialized the SDK, and implemented the functionality of users logging in. For details, see [Get Started with Agora Chat](./agora_chat_get_started_flutter?platform=Flutter).
- You understand the [API call frequency limits](./agora_chat_limitation?platform=Flutter).
- Message read receipts for chat groups are not enabled by default. To use this feature, contact support@agora.io.

## Implementation

This section introduces how to implement message delivery and read receipts in your chat app.

### Message delievery receipts

To send a message delievery receipt, take the following steps:

1. When initializing the SDK, set `requireDeliveryAck` in `ChatOptions` as `true` on the sender's client. 

    ```dart
    // The App Key
    String appKey = "appKey";
    // Enables message delievery receipt
    bool requireDeliveryAck = true;
    ChatOptions options = ChatOptions(
    appKey: appKey,
    requireDeliveryAck: requireDeliveryAck,
    );
    await ChatClient.getInstance.init(options);
    ```

2. Once the recipient receives the message, the SDK triggers `onMessageDelivered` on the message sender's client, notifying the message sender that the message has been delivered to the recipent. Listen for the `onMessageDelivered` callback on the sender's client:

    ```dart
    class _ChatMessagesPageState extends State<ChatMessagesPage>
        implements ChatManagerListener {
    @override
    void onMessagesDelivered(List<ChatMessage> messages) {
      }
    }
    // Add a chat manager listener
    ChatClient.getInstance.chatManager.addChatManagerListener(this);
    ```

### Conversation and message read receipts

In both one-to-one chats and group chats, you can use message read receipts to notify the message sender that the message has been read. To minimize the method call for message read receipts, the SDK also supports conversation read receipts in one-to-one chats. 

#### One-to-one chats

In one-to-one chats, the SDK supports sending both the conversation read receipts and message read receipts. Agora recommends using conversation read receipts if the new message arrives when the message recipient has not entered the conversation UI. 

##### Conversation read receipts

Follow the steps to implement conversation read receipts in one-to-one chats.

1. When initializing the SDK, set `requireAck` in `ChatOptions` as `true`.

    ```dart
    ChatOptions options = ChatOptions(
    appKey: appKey,
    requireAck: true,
    );
    ChatClient.getInstance.init(options);
    ```

2. When a user enters the conversation UI, check whether the conversation contains unread messages. If yes, call `sendConversationReadAck` to send a conversation read receipt.

    ```dart
    String convId = "convId";
    try {
    await ChatClient.getInstance.chatManager.sendConversationReadAck(convId);
    } on ChatError catch (e) {
    // Sending conversation read receipts fails. See e.code for the error code and e.description for the error description.
    }
    ```

3. The message sender listens for message events and receives the conversation read receipt in `onConversationRead`.

    ```dart
    class _ChatMessagesPageState extends State<ChatMessagesPage>
        implements ChatManagerListener {
    @override
    void onConversationRead(String from, String to) {
    }
    }
    // Adds a chat listener.
    ChatClient.getInstance.chatManager.addChatManagerListener(this);
    ```


<div class="alert note">In scenarios where a user is logged in multiple devices, if the user sends a conversation read receipt from one device, the server sets the count of unread messages in the conversation as 0, and all the other devices receive `onConversationRead`.</div>

##### Message read receipts

To implement the message read receipt in one-to-one chats, take the following steps:

1. When initializing the SDK, set `requireAck` in `ChatOptions` as `true`.

    ```dart
    ChatOptions options = ChatOptions(
    appKey: "appKey",
    requireAck: true,
    );
    ChatClient.getInstance.init(options);
    ```

2. The message sender listens for the message receipt in `onMessageRead`:

    ```dart
    class _ChatMessagesPageState extends State<ChatMessagesPage>
        implements ChatManagerListener {
    @override
    void onMessagesRead(List<ChatMessage> messages) {
    }
    }
    // Adds a chat listener
    ChatClient.getInstance.chatManager.addChatManagerListener(this);
    ```

3. When the message arrives, the recipient reads the message and call `sendMessageReadAck` to notify the send that the message is read. The SDK will trigger `onMessageRead` on the sender's client.

    ```dart
    try {
    ChatClient.getInstance.chatManager.sendMessageReadAck(msg);
    } on ChatError catch (e) {
    // Fails to send the message. See e.code for the error code, and e.description for the error description.
    }
    ```
    
#### Chat groups

In group chats, you can use message read receipts to notify the group owner or admins that the chat group message has been read. Ensure that each group member that has read the message should send a message read receipt.

Follow the steps to implement chat message read receipts.

1. To receive the chat group message read receipts, the sender listends for the `onGroupMessageRead` callback.

    ```dart
    class _ChatMessagesPageState extends State<ChatMessagesPage>
        implements ChatManagerListener {
    @override
    void onGroupMessageRead(List<ChatGroupMessageAck> groupMessageAcks) {
    }
    }
    // Adds a chat listener.
    ChatClient.getInstance.chatManager.addChatManagerListener(this);
    ```


2. The sender sends a chat group message. Ensure that you set `needGroupAck` as `true`.

    ```dart
    // Sets the chat type as group chat
    msg.chatType = ChatType.GroupChat;
    // Whether to require a group message read receipt
    msg.needGroupAck = true;
    try {
    await ChatClient.getInstance.chatManager.sendMessage(msg);
    } on ChatError catch (e) {
        // Fails to send the message. See e.code for the error code, and e.description for the error description.
    }
    ```

3. The chat group member reads the message and call `sendGroupMessageReadAck` to send a chat group message receipt. The SDK will trigger `onGroupMessageRead` on the sender's client.

```dart
try {
  ChatClient.getInstance.chatManager.sendGroupMessageReadAck(msgId, groupId);
} on ChatError catch (e) {
  // Fails to send the group message read receipt. See e.code for the error code, and e.description for the error description.
}
```
