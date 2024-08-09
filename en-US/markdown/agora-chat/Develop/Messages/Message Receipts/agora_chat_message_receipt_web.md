# Message receipts

The Chat SDK provides the message receipt feature that allows the user, after sending a message, to know whether the message is delivered or read. Also, the Chat SDK supports the conversation read receipt that allows the message sender to know whether the conversation is read.

- Message delivery receipt: available only to one-to-one chats.
- Message read receipt: available to both one-to-one chats and group chats.
- Conversation read receipt: available only to one-to-one chats.

## Understand the tech

The message delivery receipts and read receipts are implemented as follows:

- Message delivery receipt for one-to-one chats

  1. The message sender enables delivery receipts by setting `delivery` as `true` when creating the `connection` object during SDK initialization. 
  2. A user sends a message.
  3. After the recipient receives the message, the SDK automatically sends a delivery receipt to the sender.
  4. The sender receives the delivery receipt by listening for `onDeliveredMessage`.

- Conversation and message read receipts for one-to-one chats

  1. A user sends a message.
  2. After reading the message, the recipient calls `send` to send a conversation or message read receipt.
  3. The sender receives the conversation or message receipt by listening for `onChannelMessage` or `onReadMessage`.

- Message read receipt for group chats

  1. A group member sends a message with `allowGroupAck` set to `true` to request message read receipts.
  2. After reading the message, the recipient calls `send` to send a read receipt.
  3. The sender receives the message read receipt by listening for `onReadMessage` when online or `onStatisticsMessage` when offline.
  4. The sender can know which group members have read the message by calling `getGroupMsgReadUser`.

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
     delivery: true,
   });
   ```

2. Once the recipient receives the message, the SDK triggers `onDeliveredMessage` on the message sender's client, notifying that the message has been delivered to the recipient.

   ```javascript
   conn.addEventHandler("customEvent", {
     onReceivedMessage: function (message) {}, // Received a receipt for message delivery to the server.
     onDeliveredMessage: function (message) {}, // Received a receipt for message delivery to the client.
   });
   ```

### [Conversation and message read receipts](https://docs.agora.io/en/agora-chat/client-api/messages/message-receipts?platform=web#conversation-and-message-read-receipts)

In both one-to-one chats and group chats, you can use message read receipts to notify the message sender that the message has been read. To minimize the method call for message read receipts, the SDK also supports conversation read receipts in one-to-one chats.

#### One-to-one chat

The one-to-one chats support both conversation read receipts and message read receipts. We recommend you use both types of read receipts together to reduce the number of message read receipts: 

- If several messages are received when the chat page is not opened yet, send a conversation read receipt when the chat page is opened.
- If a message is received on an open chat page, send a message read receipt.

##### [Conversation read receipts](https://docs.agora.io/en/agora-chat/client-api/messages/message-receipts?platform=web#conversation-read-receipts)

1. The message recipient sends a conversation read receipt.

The message recipient opens the conversation page to check whether there are unread messages. If yes, call `send` to send a conversation read receipt.

```javascript
let option = {
  chatType: "singleChat", // The chat type: singleChat for one-to-one.
  type: "channel", // The type of read receipt: channel indicates the conversation read receipt.
  to: "userId", // The user ID of the message recipient.
};
let msg = WebIM.message.create(option);
conn.send(msg);
```

2. The message sender receives the conversation read receipt in the `onChannelMessage` callback.

```javascript
conn.addEventHandler("customEvent", {
  onChannelMessage: (message) => {},
});
```

##### [Message read receipts](https://docs.agora.io/en/agora-chat/client-api/messages/message-receipts?platform=web#message-read-receipts)

For one-to-one chats, message read receipts are stored as long as messages on the Chat server. Specifically, message read receipts can be sent whenever the messages are available on the Chat server. The message storage period on the Chat server depends on your product plan. For details, see the [pricing plan details](https://docs.agora.io/en/agora-chat/reference/pricing-plan-details?platform=web#message).

Refer to the following steps to implement message read receipt in one-to-one chats:

1. The message recipient sends a message read receipt.

   - If there are several unread messages in the conversation, to minimize the number of sent message read receipts, we recommend that a conversation read receipt be sent when the message recipient enters the conversation. 

   ```javascript
   let option = {
     chatType: "singleChat", // The chat type: singleChat for one-to-one chat.
     type: "channel", // The type of read receipt: channel indicates the conversation read receipt.
     to: "userId", // The user ID of the message receipt.
   };
   let msg = WebIM.message.create(option);
   conn.send(msg);
   ```

   - If there is only one unread message in the conversation, after reading it, call `send` from the recipient's client to send the message read receipt.

```javascript
let option = {
  type: "read", // The message read receipt.
  chatType: "singleChat", // The chat type: singleChat for one-to-one chat.
  to: "userId", // The user ID of the message receipt.
  id: "id", // The ID of the message that requires the read receipt.
};
let msg = WebIM.message.create(option);
conn.send(msg);
```

2. The message sender listens for `onReadMessage` to receive the message read receipt.

   ```javascript
   conn.addEventHandler("customEvent", {
     onReadMessage: (message) => {},
   });
   ```

#### Group chat

For a group chat, group members can determine whether to require message read receipts when sending a message. If yes, after a group member reads the message, the SDK sends a read receipt. In a group chat, the number of message read receipts that are sent for the message refers to the number of group members that have read this message.

| Feature Restriction| Default | Description | Error |
| :--------- | :----- | :------- | :------- | 
| Enabling the function   | Disabled   | To use this feature, contact support@agora.io to enable it.   | The error 503 "group ack not open" is returned if you fail to enable this feature before using it.    |
| Permission  | Group owner and administrators  | By default, only the group owner and administrators can request read receipts when sending a message. <br/>You can contact [support@agora.io](mailto:support@agora.io) to grant the permission to regular group members.| The error "group ack msg permission denied" is returned if regular group members without the permission request read receipts when sending a message.  |
| Number of days before read receipts cannot be returned after the message is sent | 3 days | The server no longer records the group members that read the message three days after it is sent, nor sends the read receipts. | The error "group ack msg not found" is returned if read receipts are sent three days after the message is sent. | 
| Chat group size   | 500 members | This feature is available only to groups with up to 500 members. In other words, each message in a group can have up to 500 read receipts.  | If the upper limit is exceeded, no error is returned, but the latest read receipt record will overwrite the earliest one.|
| Maximum number of group messages that can have read receipts per day | 500 | A group can have up to 500 messages each day for which read receipts can be returned. | If the upper limit is exceeded, the error "limit send group ack msg" is returned. |

Follow the steps to implement read receipts for a chat group message:

1. When sending a message, a group member can set whether to require a message read receipt by setting `allowGroupAck` to `true`.

   ```javascript
   sendGroupReadMsg = () => {
       let option = {
           type: 'txt',            // Message type.
           chatType: 'groupChat',  // Conversation type: groupChat for group chat.
           to: 'groupId',          // The message recipient: group ID.
           msg: 'message content'  // Message content.
           msgConfig: { allowGroupAck: true } // Setting that this message requires a read receipt.
       }

      let msg = WebIM.message.create(option);
      conn.send(msg).then((res) => {
          console.log('send message success');
      }).catch((e) => {
          console.log("send message error");
      })
   }
   ```

2. After reading the group message, the recipient calls `send` to send the message read receipt.

   ```javascript
   sendReadMsg = () => {
     let option = {
       type: "read", // Whether the message has been read.
       chatType: "groupChat", // Conversation type: groupChat means group chat.
       id: "msgId", // The message ID for which the read receipt is sent.
       to: "groupId", // Group ID.
       ackContent: JSON.stringify({}), // The content of the message read receipt.
     };
     let msg = WebIM.message.create(option);
     conn.send(msg);
   };
   ````

3. The message sender receives the message read receipt by listening for either of the following callbacks.

- `onReadMessage`, when the message sender is online.
- `onStatisticsMessage`, when the message sender is offline.

 ```javascript
  // You can listen for onReadMessage when online.
 conn.addEventHandler('customEvent', {
    onReadMessage: (message) => {
      let { mid } = message;
      let msg = {
           id: mid,
      };
      if (message.groupReadCount){
              // The message has been read.
          msg.groupReadCount = message.groupReadCount[message.mid];
      }
   },
   // You can listen for onStatisticMessage upon login when the read receipt is received when you are offline.
    onStatisticMessage: (message) => {
      let statisticMsg = message.location && JSON.parse(message.location);
      let groupAck = statisticMsg.group_ack || [];
    },
});
```

4. After receiving the read receipt, the message sender can retrieve the detailed information of the group members that have read the message.

```javascript
conn.getGroupMsgReadUser({
    msgId: "messageId", // Message ID.
    groupId: "groupId", // Group ID.
 })
   .then((res) => {
     console.log(res);
 });
```
