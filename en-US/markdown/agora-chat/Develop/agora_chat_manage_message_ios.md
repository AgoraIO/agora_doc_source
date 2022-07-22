In chat apps, a conversation is composed of all the messages in a peer-to-peer chat, chat group, or chatroom. The Agora Chat SDK supports managing messages by conversations, including retrieving and managing unread messages, deleting the historical messages on the local device, and searching historical messages.

This page introduces how to use the Agora Chat SDK to implement these functionalities.

## Understand the tech

The Agora Chat SDK uses `ChatManager` to manage local messages. Followings are the core methods:

- `getAllConversations`: Loads the conversation list on the local device.
- `deleteConversations`: Deletes the specified conversation.
- `AgoraChatConversation.unreadMessagesCount`: Retrieves the count of unread messages in the specified conversation.
- `deleteConversation`: Deletes the conversation from the server.
- `AgoraChatConversation.loadMessagesStartFromId`: Searches for messages from the local database.
- `AgoraChatConversation.insertMessage`: Inserts messages in the specified conversation.

## Prerequisites

Before proceeding, ensure that you meet the following requirements:

- You have integrated the Agora Chat SDK, initialized the SDK and implemented the functionality of registering accounts and login. For details, see [Get Started with Agora Chat](./agora_chat_get_started_ios?platform=iOS).
- You understand the API call frequency limits as described in [Limitations](./agora_chat_limitation?platform=iOS).

## Implementation

This section shows how to implement managing messages.

### Retrieve conversations

Call `getAllConversations` to retrieve all the conversations on the local device:

```Objective-C
NSArray *conversations = [[AgoraChatClient sharedClient].chatManager getAllConversations];
```

### Retrieve messages in the specified conversation

Refer to the following code sample to retrieve the messages in the specified conversation:

```Objective-C
// Retrieves the conversation ID
AgoraConversation *conversation = [[AgoraChatClient sharedClient].chatManager getConversation:conversationId type:type createIfNotExist:YES];
// Only one message is loaded during SDK initialization. Call loadMessagesStartFromId to retrieve more messages.
NSArray<AgoraChatMessage *> *messages = [conversation loadMessagesStartFromId:startMsgId count:count searchDirection:MessageSearchDirectionUp];
```

### Retrieve the count of unread messages in the specified conversation

Refer to the following code example to retrieve the count of unread messages:

```Objective-C
// Retrieves the ID of the specified conversation.
AgoraConversation *conversation = [[AgoraChatClient sharedClient].chatManager getConversation:conversationId type:type createIfNotExist:YES];
// Retrieves the count of unread messages.
NSInteger unreadCount = conversation.unreadMessagesCount;
```


### Retrieve the count of unread messages in all conversations

Refer to the following code example to retrieve the count of all unread messages:

```Objective-C
NSArray *conversations = [[AgoraChatClient sharedClient].chatManager getAllConversations];
NSInteger unreadCount = 0;
for (AgoraConversation *conversation in conversations) {
  unreadCount += conversation.unreadMessagesCount;
}
```


### Mark unread messages as read

Refer to the following code example to mark the specified messages as read:

```Objective-C
AgoraConversation *conversation = [[AgoraChatClient sharedClient].chatManager getConversation:conversationId type:type createIfNotExist:YES];
// Marks all messages of the specified conversation as read.
[conversation markAllMessagesAsRead:nil];
// Marks the specified message as read.
[onversation markMessageAsReadWithId:messageId error:nil];
```

### Delete conversations and historical messages

You can delete conversations on both the local device and the server.

To delete them on the local device, call `deleteConversation` and `removeMessage`:

```Objective-C
// Deletes the specified conversation. To keep the historical messages, set isDeleteMessages as NO.
[[AgoraChatClient sharedClient].chatManager deleteConversation:conversationId isDeleteMessages:YES completion:nil];
// Deletes the specified conversation.
NSArray *conversations = @{@"conversationID1",@"conversationID2"};
[[AgoraChatClient sharedClient].chatManager deleteConversations:conversations isDeleteMessages:YES completion:nil];
// Deletes the specified message of the current conversation.
AgoraConversation *conversation = [[AgoraChatClient sharedClient].chatManager getConversation:conversationId type:type createIfNotExist:YES];
[conversation deleteMessageWithId:.messageId error:nil];
```

### Search for messages using keywords

Call `loadMessagesWithKeyword` to search for messages by keywords, timestamp, and message sender:

```Objective-C
NSArray<AgoraChatMessage *> *messages = [conversation loadMessagesWithKeyword:keyword timestamp:0 count:50 fromUser:nil searchDirection:MessageSearchDirectionDown];
```

### Import messages

Call `importMessages` to import multiple messages to the specified conversation. This applies to scenarios where chat users want to formard messages from another conversation.

```Objective-C
[[AgoraChatClient sharedClient].chatManager importMessages:messages completion:nil];
```

### Insert messages

If you want to insert a message to the current conversation without actually sending the message, construct the message body and call `insertMessage`. This can be used to send notification messages such as "XXX recalls a message", "XXX joins the chat group", and "Typing ...".

```Objective-C
// Inserts a message to the specified conversation.
AgoraConversation *conversation = [[AgoraChatClient sharedClient].chatManager getConversation:conversationId type:type createIfNotExist:YES];
[conversation insertMessage:message error:nil];
```

## Next steps

After implementing managing messages, you can refer to the following documents to add more messaging functionalities to your app:

- [Retrieve conversations and messages from the server](./agora_chat_retrieve_message_ios?platform=iOS)
- [Message receipts](./agora_chat_message_receipt_ios?platform=iOS)

