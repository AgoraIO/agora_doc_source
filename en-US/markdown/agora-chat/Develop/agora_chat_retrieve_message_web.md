The Agora Chat SDK stores historical messages on the chat server. When a chat user logs in from a different device, you can retrieve the historical messages from the server, so that the user can also browse these messages on the new device.

This page introduces how to use the Agora Chat SDK to retrieve messages from the server.

## Understand the tech

The Agora Chat SDK uses `ChatManager` to retrieve historical messages from the server. Followings are the core methods:

- `getConversationList`: Retrieve a list of conversations stored on the server.
- `getHistoryMessages`: Retrieve the historical messages in the specified conversation from the server.

## Prerequisites

Before proceeding, ensure that you meet the following requirements:

- You have integrated the Agora Chat SDK, initialized the SDK and implemented the functionality of registering accounts and login. For details, see [Get Started with Agora Chat](./agora_chat_get_started_web?platform=Web).
- You understand the API call frequency limits as described in [Limitations](./agora_chat_limitation?platform=Web).
- Retrieving conversations from the server is not enabled by default. To implement this feature, contact support@agora.io to enable the service. 

## Implementation

This section shows how to implement retrieving conversations and messages.

### Retrieve a list of conversations from the server

Call `getConversationList` to retrieve all the conversations from the server. We recommend calling this method when the app is first installed, or when there is no conversation on the local device.

<div class="alert note">Do not use mixed upper-case </div>

```javascript
WebIM.conn.getConversationList().then((res) => {
    console.log(res)
    /**
    Descriptions of the returned parameters:
    channel_infos - The conversation information
    channel_id - The conversation ID
    lastMessage - The last message
    unread_num - The count of unread messages of the current conversation
    */
})
```

By default, the SDK retrieves the last ten conversations in the past seven days, and each conversation contains one last historical message. To adjust the time limit or the number of conversations retrieved, contact support@agora.io.

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
    // (Optional) The cursor position from which to start to get data. If the parameter is set as -1, an empty string, or null, the SDK retrieves messages from the latest one.
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

## Next steps

After implementing retrieving messages, you can refer to the following documents to add more messaging functionalities to your app:

- [Message receipts](./agora_chat_message_receipt_web?platform=Web)