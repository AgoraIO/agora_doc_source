The Agora Chat SDK stores historical messages on the chat server. When a chat user logs in from a different device, you can retrieve the historical messages from the server, so that the user can also browse these messages on the new device.

This page introduces how to use the Agora Chat SDK to retrieve messages from the server.

## Understand the tech

The Agora Chat SDK uses `ChatManager` to retrieve historical messages from the server. Followings are the core methods:

- `fetchAllConversations`: Retrieves a list of conversations stored on the server.
- `fetchHistoryMessages`: Retrieves the historical messages in the specified conversation from the server.
- `removeMessagesFromServerWithTimestamp`/`removeMessagesFromServerWithMsgIds`: Deletes historical messages from the server unidirectionally.
- `removeConversationFromServer`: Deletes conversations and related messages from the server.

## Prerequisites

Before proceeding, ensure that you meet the following requirements:

- You have integrated the Agora Chat SDK, initialized the SDK, and implemented the functionality of users logging in. For details, [Get Started with Agora Chat](./agora_chat_get_started_rn?platform=React%20Native).
- You understand the [API call frequency limits](./agora_chat_limitation?platform=React%20Native).

## Implementation

This section shows how to implement retrieving conversations and messages.

## Retrieve a list of conversations from the server

Call `fetchConversationsFromServerWithPage` to retrieve conversations from the server with pagination. Each retrieved conversation contains one last historical message. We recommend calling this method when the app is first installed, or when there is no conversation on the local device. Otherwise, you can call `getAllConversations` to retrieve conversations on the local device.

```java
// pageNum: The current page number, starting from 1.
// pageSize: The number of conversations to get per page. The value range is [1,20].
ChatClient.getInstance()
  .chatManager.fetchConversationsFromServerWithPage(pageSize, pageNum)
  .then((result) => {
    console.log("test:success:", result);
  })
  .catch((error) => {
    console.warn("test:error:", error);
  });
```

For users that do not support `fetchConversationsFromServerWithPage`, call `fetchAllConversations` to retrieve the conversations from the server. By default, the SDK retrieves the last ten conversations in the past seven days, and each conversation contains one last historical message. To adjust the time limit or the number of conversations retrieved, contact [support@agora.io](mailto:support@agora.io).

### Retrieve historical messages of the specified conversation

After retrieving conversations, you can retrieve historical messages by pagination from the server. 

To ensure data reliablity, we recommend retrieving less than 50 historical messages for each method call. To retrieve more than 50 historical messages, call this method multiple times. Once the messages are retrieved, the SDK automatically updates these messages in the local database.

```typescript
// Specify the conversation ID.
const convId = "convId";
// Specify the conversation type. For details, see descriptions in  ChatConversationType.
const convType = ChatConversationType.PeerChat;
// Specify the maximum count of the retrieved messages.
const pageSize = 10;
// Specify the message ID from which to retrieve the historical messages.
const startMsgId = "";
// Specify the message search direction.
const direction = ChatSearchDirection.UP;
ChatClient.getInstance()
  .chatManager.fetchHistoryMessages(convId, chatType, {
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

### Delete Historical Messages from the Server Unidirectionally

Call `removeMessagesFromServerWithTimestamp` or `removeMessagesFromServerWithMsgIds` to delete historical messages one way from the server. You can remove a maximum of 50 messages from the server each time. Once the messages are deleted, you can no longer retrieve them from the server. The deleted messages are automatically removed from your local device. Other chat users can still get the messages from the server.

<div class="alert note">To use this function, you need to contact [support@agora.io](mailto:support@agora.io) to enable it.</div>

```typescript
// Delete messages by message ID
ChatClient.getInstance()
  .chatManager.removeMessagesFromServerWithMsgIds(convId, convType, msgIds)
  .then((result) => {
    console.log("test:success:", result);
  })
  .catch((error) => {
    console.warn("test:error:", error);
  });
// Delete messages by timestamp
ChatClient.getInstance()
  .chatManager.removeMessagesFromServerWithTimestamp(
    convId,
    convType,
    timestamp
  )
  .then((result) => {
    console.log("test:success:", result);
  })
  .catch((error) => {
    console.warn("test:error:", error);
  });
```

### Delete conversations and related messages from the server unidirectionally

Call `removeConversationFromServer` to delete conversations and their historical messages unidirectionally from the server. After the conversations and messages are deleted from the server, you can no longer get them from the server. The deleted conversations still exist on the local device, but the messages are automatically removed from the device. Other chat users can still get the conversations and their historical messages from the server. 

```typescript
// convId: conversation ID
// convType: conversation type.
// isDeleteMessage: Whether to delete historical messages from the server and local storage with the conversation.
ChatClient.getInstance()
  .chatManager.removeConversationFromServer(convId, convType, isDeleteMessage)
  .then(() => {
    console.log("remove conversions success");
  })
  .catch((reason) => {
    console.log("remove conversions fail.", reason);
  });
```

## Next steps

After implementing retrieving messages, you can refer to the following documents to add more messaging functionalities to your app:

- [Message receipts](./agora_chat_message_receipt_rn?platform=React%20Native)