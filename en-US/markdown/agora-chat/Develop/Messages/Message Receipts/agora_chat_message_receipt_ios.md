After a user sends a message to another chat user or chat group, this user expects to know whether the message is delievered or read. The Agora Chat SDK provides the message receipt feature, which enables you to send a receipt to the message sender once the message is delievered or read.

This page introduces how to use the Agora Chat SDK to implement message receipt functionalities in one-to-one chats and chat groups.

## Understand the tech

The Agora Chat SDK uses `IAgoraChatManager` to provide message receipt. Followings are the core methods:

- `AgoraChatOptions.enableRequireReadAck`: Enables message read receipt.
- `AgoraChatOptions.enableDeliveryAck`: Enables message delievery receipt.
- `ackConversationRead`: Sends a conversation read receipt.
- `sendMessageReadAck`: Sends a message read receipt.
- `sendGroupMessageReadAck`: Sends a message read receipt for group chat.

The logic for implementing these receipts are as follows:

- Message delivery receipts

  1. The message sender enables delivery receipts by setting `AgoraChatOptions.enableDeliveryAck` as `YES`.
  2. After the recipient receives the message, the SDK automatically sends a delivery receipt to the sender.
  3. The sender receives the delivery receipt by listening for `messageDidDeliver`.

- Conversation and message read receipts

  1. The message sender enables read receipt by setting `AgoraChatOptions.enableRequireReadAck` as `YES`.
  2. After reading the message, the recipient calls `ackConversationRead` or `sendMesageReadAck` to send a conversation or message read receipt.
  3. The sender receives the conversation or message receipt by listening for `onConversationRead` or `messageDidRead`.

## Prerequisites

Before proceeding, ensure that you meet the following requirements:

- You have integrated the Agora Chat SDK, initialized the SDK and implemented the functionality of registering accounts and login. For details, see [Get Started with Agora Chat](./agora_chat_get_started_ios?platform=iOS).
- You understand the API call frequency limits as described in [Limitations](./agora_chat_limitation?platform=iOS).
- Message read receipts for chat groups are not enabled by default. To use this feature, contact support@agora.io.

## Implementation

This section introduces how to implement message delivery and read receipts in your chat app.

### Message delievery receipts

To send a message delievery receipt, take the following steps:

1. The message sender sets `enableDeliveryAck` in `AgoraChatOptions` as `YES` before sending the message:

    ```objective-C
    options.enableDeliveryAck = YES;
    ```

2. Once the recipient receives the message, the SDK triggers `messageDidDeliver` on the message sender's client, notifying the message sender that the message has been delivered to the recipent.

    ```objective-c
    - (void)messagesDidDeliver:(NSArray *)aMessages
    {

    }

    [[AgoraChatClient sharedClient].chatManager removeDelegate:self];
    ```

### Conversation and message read receipts

In both one-to-one chats and group chats, you can use message read receipts to notify the message sender that the message has been read. To minimize the method call for message read receipts, the SDK also supports conversation read receipts in one-to-one chats. 

#### One-to-one chats

In one-to-one chats, the SDK supports sending both the conversation read receipts and message read receipts. Agora recommends using conversation read receipts if the new message arrives when the message recipient has not entered the conversation UI. 

- Conversation read receipts

 Follow the steps to implement conversation read receipts in one-to-one chats.

 1. When a user enters the conversation UI, check whether the conversation contains unread messages. If yes, call `ackConversationRead` to send a conversation read receipt.

    ```objective-c
    [[AgoraChatClient sharedClient].chatManager ackConversationRead:conversationId completion:nil];
    ```
    

 2. The message sender listens for message events and receives the conversation read receipt in `onConversationRead`.

    ```objective-c
    - (void)onConversationRead:(NSString *)from to:(NSString *)to
    {
        // Add handling logics, for example, for refreshing the UI
    }
    ```

 <div class="alert note">In scenarios where a user is logged in multiple devices, if the user sends a conversation read receipt from one device, the server sets the count of unread messages in the conversation as 0, and all the other devices receive <code>onConversationRead</code>.</note>

- Message read receipts

 To implement the message read receipt, take the following steps:

 1. Send a conversation read receipt when the recipient enters the conversation.

    ```objective-c
    [[AgoraChatClient sharedClient].chatManager sendMessageReadAck:messageId toUser:conversationId completion:nil];
    ```

 2. When a new message arrives, send the message read receipt and add proper handling logics for the different message types.

    ```objective-c
    // Occurs when the message is received.
    - (void)messagesDidReceive:(NSArray *)aMessages
    {
        for (AgoraChatMessage *message in aMessages) {
            // Sends a message read receipt
            [self sendReadAckForMessage:message];
        }
    }

    - (void)sendReadAckForMessage:(AgoraChatMessage *)aMessage
    {
        // The received message
        if (aMessage.direction == AgoraChatMessageDirectionSend || aMessage.isReadAcked || aMessage.chatType != AgoraChatTypeChat)
            return;
    
        MessageBody *body = aMessage.body;
        // For audio, video, and file messages, send them after the user clicks the file.
        if (body.type == MessageBodyTypeFile || body.type == MessageBodyTypeVoice || body.type == MessageBodyTypeImage)
            return;
            
        [[AgoraChatClient sharedClient].chatManager sendMessageReadAck:aMessage.messageId toUser:aMessage.conversationId completion:nil];
    }
    ```

 3. The message sender listens for the message receipt:

    ```objective-c
    // Occurs when the message read receipt is received
    - (void)messagesDidRead:(NSArray *)aMessages
    {
        for (AgoraChatMessage *message in aMessages) {
            // Adds handling logics
        }
    }
    ```

#### Chat groups

For a group chat, group members can determine whether to require message read receipts when sending a message. If yes, after a group member reads the message, the SDK sends a read receipt. In a group chat, the number of message read receipts that are sent for the message refers to the number of group members that have read this message.

The following table shows the restrictions of this feature:

| Feature Restriction| Default | Description | 
| :--------- | :----- | :------- | 
| Enabling the function   | Disabled   | To use this feature, contact support@agora.io to enable it.   |
| Permission  | Group owner and administrators  | By default, only the group owner and administrators can request read receipts when sending a message. <br/>You can contact [support@agora.io](mailto:support@agora.io) to grant the permission to regular group members.| 
| Number of days before read receipts cannot be returned after the message is sent   | 3 days    | The server no longer records the group members that read the message three days after it is sent, nor sends the read receipts.   | 
| Chat group size   | 500 members   | This feature is available only to groups with up to 500 members. In other words, each message in a group can have up to 500 read receipts. If the upper limit is exceeded, the latest read receipt record will overwrite the earliest one.  | 
| Maximum number of group messages that can have read receipts per day   | 500 | A group can have up to 500 messages each day for which read receipts can be returned. | 

Follow the steps to implement read receipts for a chat group message:

1. When sending a message, a group member can set whether to require a message read receipt.

    ```objective-c
    AgoraChatMessage *message = [[AgoraChatMessage alloc] initWithConversationID:to from:from to:to body:aBody ext:aExt];
    message.isNeedGroupAck = YES;
    ```

2. After the group member reads the chat group message, call `sendGroupMessageReadAck` from the group member's client to send a message read receipt:

    ```objective-c
    - (void)sendGroupMessageReadAck:(AgoraChatMessage *)msg
    {
        if (msg.isNeedGroupAck && !msg.isReadAcked) {
            [[AgoraChatClient sharedClient].chatManager sendGroupMessageReadAck:msg.messageId toGroup:msg.conversationId content:@"123" completion:^(AgoraChatError *error) {
                if (error) {
                
                }
            }];
        }
    }
    ```

3. The message sender listens for the message read receipt.

    ```objective-c
    // Occurs when the group message is received.
    - (void)groupMessageDidRead:(AgoraChatMessage *)aMessage groupAcks:(NSArray *)aGroupAcks
    {
        for (AgoraChatGroupMessageAck *messageAck in aGroupAcks) {
            //receive group message read ack
        }
    } 
    ```

4. The message sender can get the detailed information of the read receipt using `asyncFetchGroupMessageAcksFromServer`.

    ```objective-c
   // messageId: The message ID.
   // pageSize: The page size. The value range is [1,50].
   // startGroupAckId: The starting receipt ID for query. Set it as nil or "" for the first call of the method and the SDK retrieves from the latest receipt.
    [[AgoraChatClient sharedClient].chatManager asyncFetchGroupMessageAcksFromServer:messageId groupId:groupId startGroupAckId:nil pageSize:pageSize completion:^(AgoraChatCursorResult *aResult, AgoraChatError *error, int totalCount) {
        // Add subsequent logics, for example, refreshing the UI
    }];
    ```