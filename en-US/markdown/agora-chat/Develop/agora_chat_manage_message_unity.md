In chat apps, a conversation is composed of all the messages in a peer-to-peer chat, chat group, or chatroom. The Agora Chat SDK supports managing messages by conversations, including retrieving and managing unread messages, deleting the historical messages on the local device, and searching historical messages.

This page introduces how to use the Agora Chat SDK to implement these functionalities.

## Understand the tech

The Agora Chat SDK uses `IChatManager` and `IConversationManager` to manage local messages. Followings are the core methods:

- `IChatManager.LoadAllConversations`: Loads the conversation list on the local device.
- `IChatManage.DeleteConversation`: Deletes the specified conversation.
- `IConversationManager.UnReadCount`: Retrieves the count of unread messages in the specified conversation.
- `IChatManager.GetUnreadMessageCount`: Retrieves the count of all unread messages.
- `IChatManager.DeleteConversationFromServer`: Deletes the conversation from the server.
- `IChatManager.searchMsgFromDB`: Searches for messages from the local database.
- `Conversation.insertMessage`: Inserts messages in the specified conversation.

## Prerequisites

Before proceeding, ensure that you meet the following requirements:

- You have integrated the Agora Chat SDK, initialized the SDK and implemented the functionality of registering accounts and login. For details, see [Get Started with Agora Chat](./agora_chat_get_started_unity?platform=Unity).
- You understand the API call frequency limits as described in [Limitations](./agora_chat_limitation?platform=Unity).

## Implementation

This section shows how to implement managing messages.

### Retrieve conversations

Call `LoadAllConversations` to retrieve all the conversations on the local device:

```C#
List<Conversation>list = SDKClient.Instance.ChatManager.LoadAllConversations();
```

### Retrieve messages in the specified conversation

Refer to the following code sample to retrieve the messages in the specified converation:

```C#
// Get the specified conversation on the local device.
Conversation conv = SDKClient.Instance.ChatManager.GetConversation(conversationId, convType);
// Call LoadMessages to retrieve messages by specifying the `startMsgId` and `pageSize`.
conv.LoadMessages(startMsgId, pagesize, handle:new ValueCallBack<List<Message>>(
  onSuccess: (list) => {
     Debug.Log($"{list.Count} Messages retrieved.");
  },
  onError:(code, desc) => {
     Debug.Log($"Fails to retrieve the message, errCode={code}, errDesc={desc}");
  }
));
```

### Retrieve the count of unread messages in the specified conversation

Refer to the following code example to retrieve the count of unread messages:

```C#
Conversation conv = SDKClient.Instance.ChatManager.GetConversation(conversationId, convType);
int unread = conv.UnReadCount;
```

### Retrieve the count of unread messages in all conversations

Refer to the following code example to retrieve the count of all unread messages:

```C#
SDKClient.Instance.ChatManager.GetUnreadMessageCount();
```

### Mark unread messages as read

Refer to the following code example to mark the specified messages as read:

```C#
Conversation conv = SDKClient.Instance.ChatManager.GetConversation(conversationId, convType);
// Mark all the messages in the current conversation as read.
conv.MarkAllMessageAsRead();
// Mark the specified message as read.
conv.MarkMessageAsRead(msgId);
// Mark all unread messages as read.
SDKClient.Instance.ChatManager.MarkAllConversationsAsRead();
```

### Delete conversations and historical messages

You can delete conversations on both the local device and the server.

To delete them on the local device, call `DeleteConversation` and `DeleteMessage`:

```C#
// Call DeleteConversation to delete the specified conversation. 
// `true` indicates to keep the historical messages while deleting the conversation. To remove the historical messages as well, set it as `false`.
SDKClient.Instance.ChatManager.DeleteConversation(conversationId, true);
// Delete the specified message in the current conversaiton.
Conversation conv = SDKClient.Instance.ChatManager.GetConversation(conversationId, convType);
conv.DeleteMessage(msgId);
```

To delete conversations on the server, call `DeleteConversationFromServer`:

```C#
//从服务器端删除和特定 ID 的会话，如果需要保留聊天记录，第三个参数传 `false`。
SDKClient.Instance.ChatManager.DeleteConversationFromServer(conversationId, type, true, new CallBack(
    onSuccess: () => {
    },
    onError: (code, desc) => {
    }
));
```

### Search for messages using keywords

Call `SearchMsgFromDB` to search for messages by keywords, timestamp, and message sender:

```C#
List<Message> list = SDKClient.Instance.ChatManager.SearchMsgFromDB(keywords, timeStamp, maxCount, from, MessageSearchDirection.UP);
```

### Import messages

Call `ImportMessages` to import multiple messages to the specified conversation. This applies to scenarios where chat users want to formard messages from another converation.

```C#
SDKClient.Instance.ChatManager.ImportMessages(msgs);
```

### Insert messages

If you want to insert a message to the current conversation without actually sending the message, construct the message body and call `InsertMessage`. This can be used to send notification messages such as "XXX recalls a message", "XXX joins the chat group", and "Typing ...".

```C#
// Insert the message to the current conversation.
Conversation conv = SDKClient.Instance.ChatManager.GetConversation(conversationId, convType);
conv.InsertMessage(message);
```

## Next steps

After implementing managing messages, you can refer to the following documents to add more messaging functionalities to your app:

- [Retrieve conversations and messages from the server](./agora_chat_retrieve_message_unity?platform=Unity)
- [Message receipts](./agora_chat_message_receipt_unity?platform=Unity)

