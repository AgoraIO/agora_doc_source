The Agora Chat SDK stores historical messages on the chat server. When a chat user logs in from a different device, you can retrieve the historial messages from the server, so that the user can also browse these messages on the new device.

This page introduces how to use the Agora Chat SDK to retrieve messages from the server.

## Understand the tech

The Agora Chat SDK uses `IChatManager` to retrieve historical messages from the server. Followings are the core methods:

- `GetConversationsFromServer`: Retrieve a list of conversations stored on the server.
- `FetchHistoryMessagesFromServer`: Retrieve the historical messages in the specified conversation from the server.

## Prerequsites

Before proceeding, ensure that you meet the following requirements:

- You have integrated the Agora Chat SDK, initialized the SDK and implemented the functionality of registering accounts and login. For details, see [Get Started with Agora Chat](./agora_chat_get_started_unity?platform=Unity).
- You understand the API call frequency limits as described in [Limitations](./agora_chat_limitation?platform=Unity).
- Retrieving conversations from the server is not enabled by default. To implement this feature, contact support@agora.io to enable the service. 

## Implementation

This section shows how to implement retrieving conversations and messages.

### Retrieve a list of conversations from the server

Call `GetConversationsFromServer` to retrieve all the conversations from the server. We recommend calling this method when the app is first installed, or when there is no conversation on the local device. Otherwise, you can call `LoadAllConversations` to retrieve conversations on the local device.

```C#
SDKClient.Instance.ChatManager.GetConversationsFromServer(new ValueCallBack<List<Conversation>>(
  // Add subsequent logics after retrieving the conversation.
  // `list` is in the format of List<Conversation>.
  onSuccess: (list) =>
  {
  },
  // Retrieve the reason for failing to retreive the conversation and add troubleshooting logics accordingly.
  onError: (code, desc) =>
  {
  }
));
```

By default, the SDK retrieves the last ten conversations in the past seven days, and each conversation contains one last historical message. To adjust the time limit or the number of conversations retrieved, contact support@agora.io.

### Retrieve historial messages of the specified conversation

After retrieving conversations, you can retrieve historial messages by pagination from the server. 

To ensure data reliablity, we recommend retrieving less than 50 historical messages for each method call. To retrieve more than 50 historial messages, call this method multiple times. Once the messages are retrieved, the SDK automatically updates these messages in the local database.

```C#
SDKClient.Instance.ChatManager.FetchHistoryMessagesFromServer(conversationId, type, startId, pageSize, new ValueCallBack<CursorResult<Message>>(
  // Fetching historial messages succeeds.
  // `result` is in the format of CursorResult<Message>.
  onSuccess: (result) => {
  },
  // Fetching historial messages fails.
  onError:(code, desc) => {
  }
));
```

## Next steps

After implementing retrieving messages, you can refer to the following documents to add more messaging functionalities to your app:

- [Message receipts](./agora_chat_message_receipt_unity?platform=Unity)