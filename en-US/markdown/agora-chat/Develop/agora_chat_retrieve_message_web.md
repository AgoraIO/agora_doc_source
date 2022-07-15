The Agora Chat SDK stores historical messages on the chat server. When a chat user logs in from a different device, you can retrieve the historial messages from the server, so that the user can also browse these messages on the new device.

This page introduces how to use the Agora Chat SDK to retrieve messages from the server.

## Understand the tech

The Agora Chat SDK uses `ChatManager` to retrieve historical messages from the server. Followings are the core methods:

- `getSessionList`: Retrieve a list of conversations stored on the server.
- `fetchHistoryMessages`: Retrieve the historical messages in the specified conversation from the server.

## Prerequsites

Before proceeding, ensure that you meet the following requirements:

- You have integrated the Agora Chat SDK, initialized the SDK and implemented the functionality of registering accounts and login. For details, see [Get Started with Agora Chat](./agora_chat_get_started_web?platform=Web).
- You understand the API call frequency limits as described in [Limitations](./agora_chat_limitation?platform=Web).
- Retrieving conversations from the server is not enabled by default. To implement this feature, contact support@agora.io to enable the service. 

## Implementation

This section shows how to implement retrieving conversations and messages.

### Retrieve a list of conversations from the server

Call `getSessionList` to retrieve all the conversations from the server. We recommend calling this method when the app is first installed, or when there is no conversation on the local device.

<div class="alert note">Do not use mixed upper-case </div>

```javascript
WebIM.conn.getSessionList().then((res) => {
    console.log(res)
    /**
    Descriptions of the returned parameters:
    channel_infos - The conversation information
    channel_id - The conversation ID
    meta - The last message
    unread_num - The count of unread messages of the current conversation
    */
})
```

By default, the SDK retrieves the last ten conversations in the past seven days, and each conversation contains one last historical message. To adjust the time limit or the number of conversations retrieved, contact support@agora.io.

### Retrieve historial messages of the specified conversation

After retrieving conversations, you can retrieve historial messages by pagination from the server. 

To ensure data reliablity, we recommend retrieving less than 50 historical messages for each method call. To retrieve more than 50 historial messages, call this method multiple times. Once the messages are retrieved, the SDK automatically updates these messages in the local database.

```javascript
var options = {
    // The ID of the peer user, or chat group, or chat room, depending on the chat type.
    // The value of queue must all be in lowercase. If the actual ID contains both uppercase and lowcase letters, change the uppercase letters to lowercase.
    queue: "test1",
    // Whether it is a group conversation.
    isGroup: false,
    // The number of conversations retrieved for each method call.
    count: 10,
    // Occurs when the historical messages are retrieved.
    success: function (res) {
        console.log(res);
    },
    fail: function () {},
};
// Call fetchHistoryMessages to retrieve the historical messages.
WebIM.conn.fetchHistoryMessages(options);
```

## Next steps

After implementing retrieving messages, you can refer to the following documents to add more messaging functionalities to your app:

- [Message receipts](./agora_chat_message_receipt_web?platform=Web)