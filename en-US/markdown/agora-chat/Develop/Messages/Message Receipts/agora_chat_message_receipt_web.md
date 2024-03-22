# Message receipts

After a user sends a message to another chat user or chat group, this user expects to know whether the message is delivered or read. The Chat SDK provides the message receipt feature, which enables you to send a receipt to the message sender once the message is delivered or read.

This page introduces how to use the Chat SDK to implement message receipt functionalities in one-to-one chats and chat groups.

## Understand the tech

The logic for implementing the message delivery and read receipts are as follows:

- Message delivery receipts
  1. The message sender enables delivery receipts by setting `options.delivery` as `true` when creating the `connection` object.
  2. After the recipient receives the message, the SDK automatically sends a delivery receipt to the sender.
  3. The sender receives the delivery receipt by listening for `onDeliveredMessage`.
- Conversation and message read receipts
  1. After reading the message, the recipient calls `send` to send a conversation or message read receipt.
  2. The sender receives the conversation or message receipt by listening for `onReadMessage`.
  
## [Prerequisites](https://docs.agora.io/en/agora-chat/client-api/messages/message-receipts?platform=web#prerequisites)

Before proceeding, ensure that you meet the following requirements:

- You have integrated the Chat SDK, initialized the SDK and implemented the functionality of registering accounts and login. For details, see [Chat SDK quickstart](https://docs.agora.io/en/agora-chat/get-started/get-started-sdk).
- You understand the API call frequency limits as described in [Limitations](https://docs.agora.io/en/agora-chat/reference/limitations).
- Message read receipts for chat groups are not enabled by default. To use this feature, contact [support@agora.io](mailto:support@agora.io).

## [Implementation](https://docs.agora.io/en/agora-chat/client-api/messages/message-receipts?platform=web#implementation)

This section introduces how to implement message delivery and read receipts in your chat app.

### [Message delivery receipts](https://docs.agora.io/en/agora-chat/client-api/messages/message-receipts?platform=web#message-delivery-receipts)

To send a message delivery receipt, take the following steps:

1. The message sender sets `delivery` in `options` as `true` when initializing the `connection` object.

   ```javascript
   const conn = new websdk.connection({
    appKey: "your appKey",
    delivery: true
    });
   ```

2. Once the recipient receives the message, the SDK triggers `onDeliveredMessage` on the message sender's client, notifying the message sender that the message has been delivered to the recipient.

   ```javascript
   conn.addEventHandler('customEvent', {
   onReceivedMessage: function(message){},    // Received a receipt for message delivery to the server.
   onDeliveredMessage: function(message){},   // Receive a receipt for message delivery to the client.

   });
   ```


### [Conversation and message read receipts](https://docs.agora.io/en/agora-chat/client-api/messages/message-receipts?platform=web#conversation-and-message-read-receipts)

In both one-to-one chats and group chats, you can use message read receipts to notify the message sender that the message has been read. To minimize the method call for message read receipts, the SDK also supports conversation read receipts in one-to-one chats.

#### [Conversation read receipts](https://docs.agora.io/en/agora-chat/client-api/messages/message-receipts?platform=web#conversation-read-receipts)

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

#### [Message read receipts](https://docs.agora.io/en/agora-chat/client-api/messages/message-receipts?platform=web#message-read-receipts)

Chat supports sending message read receipts in both one-to-one chats and chat groups. Refer to the following steps to implement message read receipt in one-to-one chats:

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
   let option = {
       type: 'txt',            // message type.
       chatType: 'groupChat',  // Conversation type, here is group chat.
       to: 'groupId',          // The recipient of the message, which is the group ID.
       msg: 'message content'  // Message content.
       msgConfig: { allowGroupAck: true } // Setting this message requires a read receipt.
   }

   let msg = WebIM.message.create(option);
   conn.send(msg).then((res) => {
       console.log('send message success');
   }).catch((e) => {
       console.log("send message error");
   })
   }
   ```

2. After reading the group message, the recipient calls `send` to send the group message read receipt:

   ```javascript
   sendReadMsg = () => {
    let option = {
        type: 'read',           // Whether the message has been read.
        chatType: 'groupChat',  // Conversation type, here is group chat.
        id: 'msgId',            // The message ID for which read receipts need to be sent.
        to: 'groupId',          // Group ID.
        ackContent: JSON.stringify({}) // Receipt content.
        }  
        let msg = WebIM.message.create(option); 
        conn.send(msg)
        }
   ```     


3. The message sender receives the message read receipt by listening for either of the following callbacks:

  - `onReadMessage`, when the message sender is online.
  - `onStatisticsMessage`, when the message sender is offline.

   ```javascript 
    // You can listen in onReadMessage when online.
   conn.addEventHandler('customEvent', {
    onReadMessage: (message) => {
        let { mid } = message;
        let msg = {
             id: mid
             };
             if(message.groupReadCount){
                // The message has been read.
                msg.groupReadCount = message.groupReadCount[message.mid];
                }
                },
                // Receipt is received when offline, and it will be monitored here after logging in.
                onStatisticMessage: (message) => {
                    let statisticMsg = message.location && JSON.parse(message.location);
                    let groupAck = statisticMsg.group_ack || [];
                    }
                    })
   ```

  

4. After receiving the group message receipt, the sender can retrieve the detailed information of the users that have read the message:

   ```javascript
   conn.getGroupMsgReadUser({
       msgId: 'messageId',  // Message ID.
       groupId: 'groupId' // Group ID.
       }).then((res)=>{
           console.log(res)
            })
   ```      

   
   