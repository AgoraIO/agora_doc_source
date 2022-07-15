After a user sends a message to another chat user or chat group, this user expects to know whether the message is delievered or read. The Agora Chat SDK provides the message receipt feature, which enables you to send a receipt to the message sender once the message is delievered or read.

This page introduces how to use the Agora Chat SDK to implement message receipt functionalities in one-to-one chats and chat groups.

## Understand the tech

The logic for implementing the message delivery and read receipts are as follows:

- Message delivery receipts

  1. The message sender enables delivery receipts by setting `options.delivery` as `true` when creating the `connection` object.
  2. After the recipient receives the message, the SDK automatically sends a delivery receipt to the sender.
  3. The sender receives the delivery receipt by listening for `onDeliveredMessage`.

- Conversation and message read receipts

  1. After reading the message, the recipient calls `send` to send a conversation or message read receipt.
  2. The sender receives the conversation or message receipt by listening for `onReadMessage`.

## Prerequisites

Before proceeding, ensure that you meet the following requirements:

- You have integrated the Agora Chat SDK, initialized the SDK and implemented the functionality of registering accounts and login. For details, see [Get Started with Agora Chat](./agora_chat_get_started_web?platform=Web).
- You understand the API call frequency limits as described in [Limitations](./agora_chat_limitation?platform=Web).
- Message read receipts for chat groups are not enabled by default. To use this feature, contact support@agora.io.

## Implementation

This section introduces how to implement message delivery and read receipts in your chat app.

### Message delievery receipts

To send a message delievery receipt, take the following steps:

1. The message sender sets `delivery` in `options` as `true` when initializing the `connection` object.

2. Once the recipient receives the message, the SDK triggers `onDeliveredMessage` on the message sender's client, notifying the message sender that the message has been delivered to the recipent.

    ```javascript
    WebIM.conn.listen({
        onReceivedMessage: function(message){},    // Occurs when the message is received.
        onDeliveredMessage: function(message){},   // Occurs when the message is delivered.
    });
    ```

### Conversation and message read receipts

In both one-to-one chats and group chats, you can use message read receipts to notify the message sender that the message has been read. To minimize the method call for message read receipts, the SDK also supports conversation read receipts in one-to-one chats. 

#### Conversation read receipts

After the conversation is read, call `send` from the recipient's client to send a conversation read receipt:

```javascript
// One-to-one chat
var msg = new WebIM.message('channel');
msg.set({
    to: 'username'
});
WebIM.conn.send(msg.body);

// Group chat
var msg = new WebIM.message('channel');
msg.set({
    to: 'groupid'，
    chatType: 'groupChat'
});
WebIM.conn.send(msg.body);
```

The message sender can receive the conversation read receipt in the `onChannelMessage` callback:

```javascript
WebIM.conn.listen({
  onChannelMessage:function(message){
    ...
  }
})
```

#### Message read receipts

Agora Chat supports sending message read receipts in both one-to-one chats and chat groups. Refer to the following steps to implement message read receipt in one-to-one chats:

1. After the message is read, call `send` from the recipient's client to send the message read receipt

    ```javascript
    var bodyId = message.id;  // The message ID.
    var msg = new WebIM.message('read');
    msg.set({
        id: bodyId,
        to: message.from
    });
    conn.send(msg.body);
    ```

2. On the message sender's client, listen for `onReadMessage` to receive the message read receipt:

    ```javascript
    WebIM.conn.listen({
    onReadMessage:function(message){
        ...
    }
    })
    ```

Refer to the following steps to implement message read receipts in group chats.

1. When sending a chat group message, the group owner or admin can require the group message receipt:

    ```javascript
    sendGroupReadMsg = () => {
    let msg = new WebIM.message('txt');      // Creates a text message
    msg.set({
        msg: 'message content',                  // The message content
        to: 'username',                          // The user ID of the recipient
        chatType: 'groupChat',                   // The chat type
        success: function (id, serverMsgId) {
            console.log('send private text Success');
        },
        fail: function(e){
            console.log("Send private text error");
        }
    });
    msg.body.msgConfig = { allowGroupAck: true } // Sets to require the group message receipt
    conn.send(msg.body);
    }
    ```

2. After reading the group message, the recipient calls `send` to send the group message read receipt:

    ```javascript
    sendReadMsg = () => {
    let msg = new WebIM.message("read");
    msg.set({
        id：message.id,         // The message ID
        to: 'groupId',
        msgConfig: { allowGroupAck: true },
        ackContent: JSON.stringify({}) // The receipt content
    })
    msg.setChatType('groupChat')
    WebIM.conn.send(msg.body);
    }
    ```

3. The message sender receives the message read receipt by listening for either of the following callbacks:
 - `onReadMessage`, when the message sender is online.
 - `onStatisticsMessage`, when the message sender is offline. 

   ```javascript
    // If the sender is online, listen for the message read receipt in the onReadMessage callback.
    onReadMessage: (message) => {
    const { mid } = message;
    const msg = {
        id: mid
    };
    if(message.groupReadCount){
        // The count of users that have read the message.
        msg.groupReadCount = message.groupReadCount[message.mid];
    }
    }
        
    // If the sender is offline, listen for the message read receipt in the onStatisticMessage callback.
    onStatisticMessage: (message) => {
    let statisticMsg = message.location && JSON.parse(message.location);
    let groupAck = statisticMsg.group_ack || [];
    }
    ```

4. After receiving the group message receipt, the sender can retrieve the detailed information of the users that have read the message:

    ```javascript
    WebIM.conn.getGroupMsgReadUser({
        msgId,  // The messge ID
        groupId // The chat group ID
    }).then((res)=>{
        console.log(res)
    })
    ```