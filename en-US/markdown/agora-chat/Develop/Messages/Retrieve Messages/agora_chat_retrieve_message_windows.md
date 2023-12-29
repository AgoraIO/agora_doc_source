The Agora Chat SDK stores historical messages on the chat server. When a chat user logs in from a different device, you can retrieve the historical messages from the server, so that the user can also browse these messages on the new device.

This page introduces how to use the Agora Chat SDK to retrieve messages from the server.

## Understand the tech

The Agora Chat SDK uses `IChatManager` to retrieve historical messages from the server. Followings are the core methods:

- `GetConversationsFromServerWithPage`: Retrieve conversations stored on the server with pagination.
- `FetchHistoryMessagesFromServer`: Retrieve the historical messages in the specified conversation from the server.
- `RemoveMessagesFromServer`: Deletes historical messages from the server unidirectionally.
- `DeleteConversationFromServer`: Deletes conversations and their historical messages from the server.

## Prerequisites

Before proceeding, ensure that you meet the following requirements:

- You have integrated the Agora Chat SDK, initialized the SDK and implemented the functionality of registering accounts and login. For details, see [Get Started with Agora Chat](./agora_chat_get_started_windows?platform=Windows).
- You understand the API call frequency limits as described in [Limitations](./agora_chat_limitation?platform=Windows).

## Implementation

This section shows how to implement retrieving conversations and messages.

### Retrieve a list of conversations from the server

Call `GetConversationsFromServerWithPage` to retrieve conversations from the server with pagination. Each retrieved conversation contains one last historical message. We recommend calling this method when the app is first installed, or when there is no conversation on the local device. Otherwise, you can call `LoadAllConversations` to retrieve conversations on the local device.

```C#
SDKClient.Instance.ChatManager.GetConversationsFromServerWithPage(pageNum, pageSize, new ValueCallBack<List<Conversation>>(
   // Add subsequent logics after retrieving the conversation.
  // `list` is in the format of List<Conversation>.
    onSuccess: (list) =>
    {
    },
    onError: (code, desc) =>
    {
    }
));
```

For users that do not support `GetConversationsFromServerWithPage`, call `GetConversationsFromServer` to retrieve all the conversations from the server. By default, the SDK retrieves the last ten conversations in the past seven days, and each conversation contains one last historical message. To adjust the time limit or the number of conversations retrieved, contact [support@agora.io](mailto:support@agora.io).

### Retrieve historical messages of the specified conversation

After retrieving conversations, you can retrieve historical messages by pagination from the server. 

To ensure data reliablity, we recommend retrieving less than 50 historical messages for each method call. To retrieve more than 50 historical messages, call this method multiple times. Once the messages are retrieved, the SDK automatically updates these messages in the local database.

```C#
SDKClient.Instance.ChatManager.FetchHistoryMessagesFromServer(conversationId, type, startId, pageSize, new ValueCallBack<CursorResult<Message>>(
  // Fetching historical messages succeeds.
  // `result` is in the format of CursorResult<Message>.
  onSuccess: (result) => {
  },
  // Fetching historical messages fails.
  onError:(code, desc) => {
  }
));
```

### Delete historical messages from the server unidirectionally

Call `RemoveMessagesFromServer` to delete historical messages one way from the server. You can remove a maximum of 50 messages from the server each time. Once the messages are deleted, you can no longer retrieve them from the server. The deleted messages are automatically removed from your local device. Other chat users can still get the messages from the server.

<div class="alert note">To use this function, you need to contact [support@agora.io](mailto:support@agora.io) to enable it.</div>

```C#
SDKClient.Instance.ChatManager.RemoveMessagesFromServer(convId, ctype, time, new CallBack(
    onSuccess: () =>
    {
    },
    onError: (code, desc) =>
    {
    }
));
SDKClient.Instance.ChatManager.RemoveMessagesFromServer(convId, ctype, msgList, new CallBack(
    onSuccess: () =>
    {
    },
    onError: (code, desc) =>
    {
    }
));
```

### Delete conversations and related messages from the server unidirectionally

Call `DeleteConversationFromServer` to delete conversations and their historical messages unidirectionally from the server. After the conversations and messages are deleted from the server, you can no longer get them from the server. The deleted conversations still exist on your local device, but the messages are automatically removed from the device. Other chat users can still get the conversations and their historical messages from the server.

```C#
SDKClient.Instance.ChatManager.DeleteConversationFromServer(conversationId, conversationType, isDeleteServerMessages, new CallBack(
    onSuccess: () =>
    {
    },
    onError: (code, desc) =>
    {
    }
));
```

## Next steps

After implementing retrieving messages, you can refer to the following documents to add more messaging functionalities to your app:

- [Message receipts](./agora_chat_message_receipt_windows?platform=Windows)