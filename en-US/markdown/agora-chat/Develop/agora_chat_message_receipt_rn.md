After a user sends a message to another chat user or chat group, this user expects to know whether the message is delievered or read. The Agora Chat SDK provides the message receipt feature, which enables you to send a receipt to the message sender once the message is delievered or read.

This page introduces how to use the Agora Chat SDK to implement message receipt functionalities in one-to-one chats and chat groups.

## Understand the tech

The Agora Chat SDK uses `IChatManager` to provide message receipt, which includes delivery receipts and read receipts. Followings are the core methods:

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

- You have integrated the Agora Chat SDK, initialized the SDK, and implemented the functionality of users logging in. For details, see [Get Started with Agora Chat](./agora_chat_get_started_rn?platform=React%20Native).
- You understand the [API call frequency limits](./agora_chat_limitation?platform=React%20Native).
- Message read receipts for chat groups are not enabled by default. To use this feature, contact support@agora.io.

## Implementation

This section introduces how to implement message delivery and read receipts in your chat app.

### Message delievery receipts

To send a message delievery receipt, take the following steps:

1. When initializing the SDK, set `requireDeliveryAck` in `ChatOptions` as `true` on the sender's client. 

    ```typescript
    // Set the SDK app key.
    const appKey = "appKey";
    // Enable message delivery receipts.
    const requireDeliveryAck = true;
    ChatClient.getInstance()
    .init(
        new ChatOptions({
        appKey,
        requireDeliveryAck,
        })
    )
    .then(() => {
        console.log("init sdk success");
    })
    .catch((reason) => {
        console.log("init sdk fail.", reason);
    });
    ```

2. Once the recipient receives the message, the SDK triggers `OnMessageDelivered` on the message sender's client, notifying the message sender that the message has been delivered to the recipent. Listen for the `onMessageDelivered` callback on the sender's client:

    ```typescript
    class ChatMessageEvent implements ChatMessageEventListener {
    onMessagesDelivered(messages: ChatMessage[]): void {
        console.log(`onMessagesDelivered: `, messages);
    }
    // ...
    }
    // Add a message listener
    const listener = new ChatMessageEvent();
    ChatClient.getInstance().chatManager.addMessageListener(listener);
    ```


### Conversation and message read receipts

In both one-to-one chats and group chats, you can use message read receipts to notify the message sender that the message has been read. To minimize the method call for message read receipts, the SDK also supports conversation read receipts in one-to-one chats. 

#### One-to-one chats

In one-to-one chats, the SDK supports sending both the conversation read receipts and message read receipts. Agora recommends using conversation read receipts if the new message arrives when the message recipient has not entered the conversation UI. 

##### Conversation read receipts

Follow the steps to implement conversation read receipts in one-to-one chats.

1. When initializing the SDK, set `requireAck` in `ChatOptions` as `true`.

    ```typescript
    // Set the SDK app key.
    const appKey = "appKey";
    // Enable the conversation and message read receipt.
    const requireAck = true;
    ChatClient.getInstance()
    .init(
        new ChatOptions({
        appKey,
        requireAck,
        requireDeliveryAck,
        })
    )
    .then(() => {
        console.log("init sdk success");
    })
    .catch((reason) => {
        console.log("init sdk fail.", reason);
    });
    ```

2. When a user enters the conversation UI, check whether the conversation contains unread messages. If yes, call `sendConversationReadAck` to send a conversation read receipt.

    ```typescript
    // Get the conversation ID
    const convId = "convId";
    // Call sendConversationReadAck to send the receipt.
    ChatClient.getInstance()
    .chatManager.sendConversationReadAck(convId)
    .then(() => {
        console.log("send conversation read success");
    })
    .catch((reason) => {
        console.log("send conversation read fail.", reason);
    });
    ```

3. The message sender listens for message events and receives the conversation read receipt in `onConversationRead`.

```typescript
class ChatMessageEvent implements ChatMessageEventListener {
  onConversationRead(from: string, to?: string): void {
    // `from` indicates the message recipient that sends this receipt, and `to` indicates the message sender that receives this receipt.
    console.log(`onConversationRead: `, from, to);
  }
  // ...
}
// Add a chat message event.
const listener = new ChatMessageEvent();
ChatClient.getInstance().chatManager.addMessageListener(listener);
```

<div class="alert note">In scenarios where a user is logged in multiple devices, if the user sends a conversation read receipt from one device, the server sets the count of unread messages in the conversation as 0, and all the other devices receive `onConversationRead`.</div>

##### Message read receipts

To implement the message read receipt in one-to-one chats, take the following steps:

1. When initializing the SDK, set `requireAck` in `ChatOptions` as `true`.

    ```typescript
    // Set the SDK app key.
    const appKey = "appKey";
    // Enable the conversation and message read receipt.
    const requireAck = true;
    ChatClient.getInstance()
    .init(
        new ChatOptions({
        appKey,
        requireAck,
        requireDeliveryAck,
        })
    )
    .then(() => {
        console.log("init sdk success");
    })
    .catch((reason) => {
        console.log("init sdk fail.", reason);
    });
    ```

2. The message sender listens for the message receipt in `onMessageRead`:

    ```typescript
    class ChatMessageEvent implements ChatMessageEventListener {
    onMessagesRead(messages: ChatMessage[]): void {
        // Receive the onMessageRead callback
        console.log(`onMessagesRead: `, messages);
    }
    // ...
    }
    // Add a chat message event.
    const listener = new ChatMessageEvent();
    ChatClient.getInstance().chatManager.addMessageListener(listener);
    ```

3. The sender sends a message. Ensure that you set `msg.hasReadAck` as `true`.

    ```typescript
    // Send a message.
    // Set hasReadAck as true to require a message read receipt.
    msg.hasReadAck = true;
    // Call sendMessage to send the message
    ChatClient.getInstance()
    .chatManager.sendMessage(msg)
    .then(() => {
        // Print a log if message sending succeeds.
        console.log("send message success.");
    })
    .catch((reason) => {
        // Print a log if message sends fails.
        console.log("send message fail.", reason);
    });
    ```

4. When the message arrives, the recipient reads the message and call `sendMessageReadAck` to notify the send that the message is read. The SDK will trigger `onMessageRead` on the sender's client.

    ```typescript
    // The message that requires a read receipt.
    const msg;
    // Call sendMessageReadAck to send a message read receipt.
    ChatClient.getInstance()
    .chatManager.sendMessageReadAck(msg)
    .then(() => {
        console.log("send message read success");
    })
    .catch((reason) => {
        console.log("send message read fail.", reason);
    });
    ```
    
#### Chat groups

In group chats, you can use message read receipts to notify the group owner or admins that the chat group message has been read. Ensure that each group member that has read the message should send a message read receipt.

Follow the steps to implement chat message read receipts.

1. To receive the chat group message read receipts, the sender listends for the `onGroupMessageRead` callback.

    ```typescript
    class ChatMessageEvent implements ChatMessageEventListener {
    onGroupMessageRead(groupMessageAcks: ChatGroupMessageAck[]): void {
        // Receive the onGroupMessageRead callback.
        console.log(`onGroupMessageRead: `, messages);
    }
    // ...
    }
    // Add a chat message event.
    const listener = new ChatMessageEvent();
    ChatClient.getInstance().chatManager.addMessageListener(listener);
    ```

2. The sender sends a chat group message. Ensure that you set `needGroupAck` as `true`.

    ```typescript
    // Send a group message
    // Set needGroupAck as true to require a chat group message read receipt
    msg.needGroupAck = true;
    // Call sendMessage to send the group message
    ChatClient.getInstance()
    .chatManager.sendMessage(msg)
    .then(() => {
        // Print a log here if the message sending succeeds.
        console.log("send message success.");
    })
    .catch((reason) => {
        // Print a log here if the message sending fails.
        console.log("send message fail.", reason);
    });
    ```

3. The chat group member reads the message and call `sendGroupMessageReadAck` to send a chat group message receipt. The SDK will trigger `onGroupMessageRead` on the sender's client.

    ```typescript
    // Send a chat group message read receipt
    // The ID of the message that requires a read receipt
    const msgId;
    // The chat group ID
    const groupId;
    // Call sendGroupMessageReadAck
    ChatClient.getInstance()
    .chatManager.sendGroupMessageReadAck(msgId, groupId)
    .then(() => {
        // Print a log here is the message sending succeeds.
        console.log("send message read success.");
    })
    .catch((reason) => {
        // Print a log here is the message sending fails.
        console.log("send message read fail.", reason);
    });
    ```
