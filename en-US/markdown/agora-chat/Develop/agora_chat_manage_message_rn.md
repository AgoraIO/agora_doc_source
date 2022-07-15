In chat apps, a conversation is composed of all the messages in a peer-to-peer chat, chat group, or chatroom. The Agora Chat SDK supports managing messages by conversations, including retrieving and managing unread messages, deleting the historical messages on the local device, and searching historical messages.

This page introduces how to use the Agora Chat SDK to implement these functionalities.

## Understand the tech

The Agora Chat SDK uses `ChatManager` and `ChatConversation` to manage local messages. Followings are the core methods:

- `ChatManager.loadAllConversations`: Loads the conversation list on the local device.
- `ChatManage.deleteConversation`: Deletes the specified conversation.
- `ChatConversation.getUnreadMessageCount`: Retrieves the count of unread messages in the specified conversation.
- `ChatManager.getUnreadMessageCount`: Retrieves the count of all unread messages.
- `ChatManager.deleteRemoteConversation`: Deletes the conversation and historial messages from the server.
- `ChatManager.searchMsgFromDB`: Searches for messages from the local database.
- `ChatConversation.insertMessage`: Inserts messages in the specified conversation.

## Prerequisites

Before proceeding, ensure that you meet the following requirements:

- You have integrated the Agora Chat SDK, initialized the SDK, and implemented the functionality of users logging in. For details, see [Get Started with Agora Chat](./agora_chat_get_started_rn?platform=React%20Native).
- You understand the [API call frequency limits](./agora_chat_limitation?platform=React%20Native).

## Implementation

This section shows how to implement managing messages.

### Retrieve conversations

Call `loadAllConversations` to retrieve all the conversations on the local device:

```typescript
ChatClient.getInstance()
  .chatManager.loadAllConversations()
  .then(() => {
    console.log("Loading conversations succeeds");
  })
  .catch((reason) => {
    console.log("Loading conversations fails", reason);
  });
```

### Retrieve messages in the specified conversation

You can retrieve the messages in the specified converation from the local database by specifying the conversation ID and chat type:

```typescript
// Sepcify the conversation ID.
const convId = "convId";
// Whether to create a conversation if the specified one does not exist. If you set it as true, this method always returns a conversation object.
const createIfNeed = true;
// Set conversation type. For details, see descriptions in ChatConversationType.
const convType = ChatConversationType.PeerChat;
// Call getConversation to retrieve the specified conversation.
ChatClient.getInstance()
  .chatManager.getConversation(convId, convType, createIfNeed)
  .then((message) => {
    console.log("Getting conversations succeeds", message);
  })
  .catch((reason) => {
    console.log("Getting conversations fails.", reason);
  });
```

### Retrieve the count of unread messages in the specified conversation

Refer to the following code example to retrieve the count of unread messages:

```typescript
// Specify the conversation ID.
const convId = "convId";
// Specify the conversation type. For details, see descriptions in ChatConversationType.
const convType = ChatConversationType.PeerChat;
// Call unreadCount to retrieve the count of unread messages in the current conversation.
ChatClient.getInstance()
  .chatManager.unreadCount(convId, convType)
  .then((count) => {
    console.log("Getting conversations succeeds: ", count);
  })
  .catch((reason) => {
    console.log("Getting conversations fails.", reason);
  });
```


### Retrieve the count of unread messages in all conversations

Refer to the following code example to retrieve the count of all unread messages:

```typescript
ChatClient.getInstance()
  .chatManager.getUnreadMessageCount()
  .then((count) => {
    console.log("Getting all conversations succeeds: ", count);
  })
  .catch((reason) => {
    console.log("Getting all conversations fails.", reason);
  });
```

### Mark unread messages as read

Refer to the following code example to mark the specified messages as read:

```typescript
// Specify the conversation ID.
const convId = "convId";
// Specify the message ID that you want to mark as read.
const msgId = "100";
// Specify the conversation type. For details, see descriptions in ChatConversationType.
const convType = ChatConversationType.PeerChat;
// Call markMessageAsRead
ChatClient.getInstance()
  .chatManager.markMessageAsRead(convId, convType, msgId)
  .then(() => {
    console.log("Marking message read succeeds: ");
  })
  .catch((reason) => {
    console.log("Marking message read fails.", reason);
  });
```

You can also mark all unread messages of the specified conversation as read:

```typescript
// Call markAllMessagesAsRead
ChatClient.getInstance()
  .chatManager.markAllMessagesAsRead("convId", ChatConversationType.PeerChat)
  .then((count) => {
    console.log("Marking conversations read succeeds: ", count);
  })
  .catch((reason) => {
    console.log("Marking conversations read fails.", reason);
  });
```

### Delete conversations and historical messages

The SDK provides two methods, which enables you to delete the conversations and historial messages on the local device and on the server respectively.

To delete them on the local device, call `deleteConversation`:

```typescript
// Specify the conversation ID.
const convId = "convId";
// Whether to delete the messages as well.
const withMessage = true;
// Call deleteConversation
ChatClient.getInstance()
  .chatManager.deleteConversation(convId, withMessage)
  .then(() => {
    console.log("Removing conversations succeeds: ");
  })
  .catch((reason) => {
    console.log("Removing conversations fails.", reason);
  });
```

To delete them on the server, call `deleteRemoteConversation`:

```typescript
// Specify the conversation ID
const convId = "convId";
// Whether to delete the messages as well.
const isDeleteMessage = true;
// Specify the conversation type. For details, see descriptions in ChatConversationType.
const convType = ChatConversationType.PeerChat;
// Call deleteRemoteConversation.
ChatClient.getInstance()
  .chatManager.deleteRemoteConversation(convId, convType, isDeleteMessage)
  .then(() => {
    console.log("Removing conversations succeeds: ");
  })
  .catch((reason) => {
    console.log("Removing conversations fails.", reason);
  });
```

### Search for messages using keywords

Call `SearchMsgFromDB` to search for messages by keywords, timestamp, and message sender:

```typescript
// Specify the keyword,
const keywords = 'key';
// timestamp,
const timestamp = 10000000;
// the maximum count of searched messages,
const maxCount = 10;
// the message sender,
const from = 'tom';
// and the search direction. For details, see descriptions in ChatSearchDirection.
const direction = ChatSearchDirection.UP;
// Call searchMsgFromDB
ChatClient.getInstance().chatManager.searchMsgFromDB(
              keywords,
              timestamp,
              maxCount,
              from,
              direction
            )
  .then((messages[]) => {
    console.log("Searching conversations succeeds: ", messages);
  })
  .catch((reason) => {
    console.log("Searching conversations fails.", reason);
  });
```

### Import messages

Call `importMessages` to import multiple messages to the specified conversation. This applies to scenarios where chat users want to formard messages from another converation.

```typescript
// Construct the messages.
const msgs = [];
ChatClient.getInstance()
  // Call import Messages.
  .chatManager.importMessages(msgs)
  .then(() => {
    console.log("Importing conversations succeeds: ");
  })
  .catch((reason) => {
    console.log("Importing conversations fails.", reason);
  });
```

## Next steps

After implementing managing messages, you can refer to the following documents to add more messaging functionalities to your app:

- [Retrieve conversations and messages from the server](./agora_chat_retrieve_message_rn?platform=React%20Native)
- [Message receipts](./agora_chat_message_receipt_rn?platform=React%20Native)

