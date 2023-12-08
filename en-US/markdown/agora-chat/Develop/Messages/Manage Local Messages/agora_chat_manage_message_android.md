In chat apps, a conversation is composed of all the messages in a peer-to-peer chat, chat group, or chatroom. The Agora Chat SDK supports managing messages by conversations, including retrieving and managing unread messages, deleting the historical messages on the local device, and searching historical messages.

This page introduces how to use the Agora Chat SDK to implement these functionalities.

## Understand the tech

SQLCipher is used to encrypt the database that stores local messages. The Agora Chat SDK uses `ChatManager` to manage local messages. Followings are the core methods:

- `getAllConversations`: Loads the conversation list on the local device.
- `getAllMessages`/`loadMoreMsgFromDB`: Loads messages of a conversation.
- `deleteConversation`: Deletes the specified conversation.
- `Conversation.getUnreadMsgCount`: Retrieves the count of unread messages in the specified conversation.
- `getUnreadMessageCount`: Retrieves the count of all unread messages.
- `deleteConversation`: Deletes the conversation from the server.
- `searchMsgFromDB`: Searches for messages from the local database.
- `Conversation.insertMessages`: Inserts messages in the specified conversation.


## Prerequisites 

Before proceeding, ensure that you meet the following requirements:

- You have integrated the Agora Chat SDK, initialized the SDK and implemented the functionality of registering accounts and login. For details, see [Get Started with Agora Chat](./agora_chat_get_started_android?platform=Android).
- You understand the API call frequency limits as described in [Limitations](./agora_chat_limitation?platform=Android).

## Implementation

This section shows how to implement managing messages.

### Retrieve conversations

Call `loadAllConversations` to retrieve all the conversations on the local device:

```java
Map<String, Conversation> conversations = ChatClient.getInstance().chatManager().getAllConversations();
```

### Retrieve messages in the specified conversation

Call `getAllMessages` to retrieve all the messages of this conversation in the memory. Alternatively, you can call `loadMoreMsgFromDB` to load messages from the local database. The loaded message will be placed in the memory based on the timestamp of the messages.

```java
Conversation conversation = ChatClient.getInstance().chatManager().getConversation(conversationId);
List<ChatMessage> messages = conversation.getAllMessages();
// startMsgId: Starting message ID for query. The SDK loads messages, starting from the specified one, in the descending order of the timestamp included in the messages.
// pageSize: Number of message to load on each page. The value range is [1,400].
List<ChatMessage> messages = conversation.loadMoreMsgFromDB(startMsgId, pagesize);
```

### Retrieve the count of unread messages in the specified conversation

Refer to the following code example to retrieve the count of unread messages:

```java
Conversation conversation = ChatClient.getInstance().chatManager().getConversation(conversationId);
conversation.getUnreadMsgCount();
```

### Retrieve the count of unread messages in all conversations

Refer to the following code example to retrieve the count of all unread messages:

```java
ChatClient.getInstance().chatManager().getUnreadMessageCount();
```

### Mark unread messages as read

Refer to the following code example to mark the specified messages as read:

```java
Conversation conversation = ChatClient.getInstance().chatManager().getConversation(conversationId);
// Mark all the messages in the current conversation as read.
conversation.markAllMessagesAsRead();
// Mark the specified message as read.
conversation.markMessageAsRead(messageId);
// Mark all unread messages as read.
ChatClient.getInstance().chatManager().markAllConversationsAsRead();
```

### Delete conversations and historical messages

You can delete conversations on both the local device and the server.

To delete them on the local device, call `deleteConversation` and `removeMessage`:

```java
// true indicates to keep the historical messages while deleting the conversation. To remove the historical messages as well, set it as false.
ChatClient.getInstance().chatManager().deleteConversation(conversationId, deleteMessages);
// Delete the specified message in the current conversaiton.
Conversation conversation = ChatClient.getInstance().chatManager().getConversation(conversationId);
conversation.removeMessage(deleteMsg.msgId);
```

### Search for messages using keywords

Call `searchMsgFromDB` to search for messages by keywords, timestamp, and message sender:

```java
List<ChatMessage> messages = conversation.searchMsgFromDB(keywords, timeStamp, maxCount, from, Conversation.SearchDirection.UP);
```

### Import messages

Call `importMessages` to import multiple messages to the specified conversation. This applies to scenarios where chat users want to formard messages from another conversation.

```java
ChatClient.getInstance().chatManager().importMessages(msgs);
```

### Insert messages

If you want to insert a message to the current conversation without actually sending the message, construct the message body and call `insertMessages`. This can be used to send notification messages such as "XXX recalls a message", "XXX joins the chat group", and "Typing ...".

```java
// Insert a message to the specified conversation.
Conversation conversation = ChatClient.getInstance().chatManager().getConversation(conversationId);
conversation.insertMessage(message);
// Insert a message.
// ChatClient.getInstance().chatManager().saveMessage(message);
```

## Next steps

After implementing managing messages, you can refer to the following documents to add more messaging functionalities to your app:

- [Retrieve conversations and messages from the server](./agora_chat_retrieve_message_android?platform=Android)
- [Message receipts](./agora_chat_message_receipt_android?platform=Android)

