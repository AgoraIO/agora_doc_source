The Agora Chat SDK stores historical messages on the chat server. When a chat user logs in from a different device, you can retrieve the historical messages from the server, so that the user can also browse these messages on the new device.

This page introduces how to use the Agora Chat SDK to retrieve and delete messages from the server.

## Understand the tech

The Agora Chat SDK uses `ChatManager` to retrieve historical messages from the server. Followings are the core methods:

- `getConversationList`: Retrieves a list of conversations stored on the server.
- `getHistoryMessages`: Retrieves the historical messages in the specified conversation from the server.
- `removeHistoryMessages`: Deletes historical messages from the server unidirectionally.
- `deleteConversation`: Deletes conversations and their historical messages from the server.

## Prerequisites

Before proceeding, ensure that you meet the following requirements:

- You have integrated the Agora Chat SDK, initialized the SDK and implemented the functionality of registering accounts and login. For details, see [Get Started with Agora Chat](./agora_chat_get_started_web?platform=Web).
- You understand the API call frequency limits as described in [Limitations](./agora_chat_limitation?platform=Web).

## Implementation

This section shows how to implement retrieving conversations and messages.

## Retrieve a list of conversations from the server

Call `getConversationlist` to retrieve conversations from the server with pagination. Each retrieved conversation contains one last historical message. We recommend calling this method when the app is first installed, or when there is no conversation on the local device. 

<div class="alert note">Do not use mixed upper-case.</div>

```java
// pageNum: The current page number, starting from 1.
// pageSize: The number of conversations to get per page. The value range is [1,20].
connection.getConversationlist({pageNum: 1, pageSize: 20}).then((res) => {})
```

If you still use the `getConversationlist` method to retrieve the conversations from the server without pagination, the SDK, by default, retrieves the last ten conversations in the past seven days, and each conversation contains one last historical message. To adjust the time limit or the number of conversations retrieved, contact [support@agora.io](mailto:support@agora.io).

### Retrieve historical messages of the specified conversation

After retrieving conversations, you can retrieve historical messages by pagination from the server. 

You can set the search direction to retrieve messages in the chronological or reverse chronological order of when the server receives them. 

To ensure data reliability, we recommend retrieving less than 50 historical messages for each method call. To retrieve more than 50 historical messages, call this method multiple times. Once the messages are retrieved, the SDK automatically updates these messages in the local database.

```javascript
var options = {
    // The ID of the peer user, or chat group, or chat room, depending on the chat type.
    targetId:'user1',
    // (Optional) The number of messages that you expect to get on each page. The value range is [1,50] and the default value is 20.
    pageSize: 20,
    // (Optional) The starting message ID for query. If the parameter is set as -1, an empty string, or null, the SDK retrieves messages from the latest one.
    cursor: -1,
    // (Optional) The conversation type. (Default) singleChat: one-to-one conversation; groupChat: group conversation; chatRoom: chat room conversation.
    chatType:'groupChat',
    // The message search direction. 
    // (Default) up: Messages are retrieved in the reverse chronological order of when the server receives them;
    // down: Messages are retrieved in the chronological order of when the server receives them.
    searchDirection: 'up',
}
WebIM.conn.getHistoryMessages(options).then((res)=>{
    // Occurs when historical messages are successfully retrieved.
    console.log(res) 
}).catch((e)=>{
    // Occurs when historical messages fail to be retrieved.
})
```

### Delete historical messages from the server unidirectionally

Call `removeHistoryMessages` to delete historical messages one way from the server. You can remove a maximum of 50 messages from the server each time. Once the messages are deleted, you can no longer retrieve them from the server. Other chat users can still get the messages from the server.

```javascript
// Delete messages by timestamp
connection.removeHistoryMessages({targetId: 'userId', chatType: 'singleChat', beforeTimeStamp: Date.now()})

// Delete messages by message ID
connection.removeHistoryMessages({targetId: 'userId', chatType: 'singleChat', messageIds: ['messageId']})
```

### Delete conversations and related messages from the server unidirectionally

Call `deleteConversation` to delete conversations and related messages unidirectionally from the server. Other chat users can still get the conversations and their historical messages from the server.

```javascript
let options = {
  // conversation ID: The conversation ID is the user ID of the peer user for one-to-one chat and the group ID for group chat.
  channel: "channel",
  // Conversation type: (Default) `singleChat`: one-to-one chat; `groupChat`: group chat.
  chatType: "singleChat",
  // Whether to delete historical messages from the server with the conversation.
  deleteRoam: true,
};
WebIM.conn
  .deleteConversation(options)
  .then((res) => {
    console.log(res);
  })
  .catch((e) => {
    // Deletion failure.
  });
```

## Next steps

After implementing retrieving messages, you can refer to the following documents to add more messaging functionalities to your app:

- [Message receipts](./agora_chat_message_receipt_web?platform=Web)