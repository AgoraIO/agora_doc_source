The Agora Chat SDK supports sending and receiving various types of messages:
- Text messages, including hyperlinks and emojis.
- Attachment messages, including image, voice, video, and file messages.
- Location messages.
- CMD messages.
- Extended messages.
- Custom messages.

You can send a message to a peer user, a chat group, or a chat room. After sending a message, you can listen for the message read receipt. You can also recall the message. 

To manage messages, for example, to delete a conversation, you can also retrieve historical messages from the local device or from the server.

This page introduces how to use the Agora Chat SDK to implement these functionalities in your app.

## Understand the tech

The Agora Chat SDK provides a `Message` class that defines the message type, and a `ChatManager` class that allows you to send, recieve, recall, and retrieve messages.

## Prerequisites

Before proceeding, ensure that you meet the following requirements:

- You have integrated the Agora Chat SDK, initialized the SDK, and implemented the functionality of users logged in. For details, see [Get Started with Agora Chat](agora_chat_get_started_ios?platform=iOS).
- You understand the [API call frequency limits](./agora_chat_limitation_ios?platform=iOS).


## Send and recieve messages

The process of sending and receiving a message is as follows:

1. On the sender's client, create a message and send it. The message is sent to the Agora Chat server.
2. The server delivers the message to the receiver.
3. When the receiver receives the message, the SDK triggers an event.
4. On the receiver's client, listen for the event, and get the message.

Followings are the core methods for sending, receiving, and recalling messages:
- `sendMessage`: Sends a message to the specified user, chat group, or chat room.
- `recallMessage`: Recalls a message that has been sent.
- `addMessageListener`: Adds a message event listener.

### Text messages

Refer to the following code sample to create, send, and receive a text message:

```Objective-C
// Call initWithText to create a text message. Set content as the text content and toChatUsername to the username to whom you want to send this text message.
TextMessageBody *textMessageBody = [[TextMessageBody alloc] initWithText:content];
Message *message = [[Message alloc] initWithConversationID:toChatUsername from:fromChatUsername to:toChatUsername body:textMessageBody ext:messageExt];
// Set the chat type as Group chat. You can also set is as chat (one-to-one chat) or chat room.
message.chatType = AgoraChatTypeGroupChat;
// Call sendMessage to send the text message.
[[AgoraChatClient sharedClient].chatManager sendMessage:message progress:nil completion:nil];
// Set the completion callback to get the state of sending message.
// You can update the message state in this callback, for example, adding a tip pop-up if the message sending failes.
[[AgoraChatClient sharedClient].chatManager sendMessage:message progress:nil completion:^(Message *message, AgoraError *error) {
    if (!error) {
    // If the message is successfully sent
    } else {
    // If the message fails to be sent
    }
}];

// Call addDelegate to add a message listener.
[[AgoraChatClient sharedClient].chatManager addDelegate:self delegateQueue:nil];

// The SDK triggers the messageDidReceive callback when it receives a message.
- (void)messagesDidReceive:(NSArray *)aMessages
{
    for ( Message *message in aMessages )
    {
        // After receiving this callback, the SDK parses the message and displays it.
    }
}

// Call removeDelegate to remove the event listener.
- (void)dealloc
{
    [[AgoraChatClient sharedClient].chatManager removeDelegate:self];
}
```

### Attachment messages

Attachment messages include voice, image, video, and file messages. When you send an attachment message, the attachment is uploaded to the Agora Chat server.
- For voice, image, and video messages, the SDK automatically downloads the audio, image, or video thumbnail when they arrive.
- For file messages, the SDK does not automatically download the attachment. You need to call APIs to download the file on the receiver's client.

#### Create an attachment message

Before you create an attachment message, you need to implement the function of getting the attachment in your app, for example, to send an audio message, you need to implement the recording function.

To create an attachment message, call the corresponding `create` method in the `ChatMessage` class according to the type of the attachment.

```Objective-C
// Call initWithLocalPath to create a voice message.
// Set local path as the path of the local audio file, and displayName as the name of the audio.
VoiceMessageBody *body = [[VoiceMessageBody alloc] initWithLocalPath:localPath
              displayName:displayName];
Message *message = [[Message alloc] initWithConversationID:toChatUsername
            from:fromChatUsername
            to:toChatUsername
            body:body
            ext:messageExt];
```
```Objective-C
// Call initWithData to create an image message.
// Set imageData as the path of the local iamge file, and displayName as the name of the image file.
ImageMessageBody *body = [[ImageMessageBody alloc] initWithData:imageData
              displayName:displayName];
Message *message = [[Message alloc] initWithConversationID:toChatUsername
            from:fromChatUsername
            to:toChatUsername
            body:body
            ext:messageExt];
```
```Objective-C
// Call initWithLocalPath to create a video message
// Set localPath as the path of the local video file, displayName as the name of the video file, and duration as the duration of the video file
VideoMessageBody *body = [[VideoMessageBody alloc] initWithLocalPath:localPath displayName:@"displayName"];
body.duration = duration;

Message *message = [[Message alloc] initWithConversationID:toChatUsername
            from:fromChatUsername
            to:toChatUsername
            body:body
            ext:messageExt];
```
```Objective-C
// Call initWithData to create a file message
// Set fileData as the local file and displayName as the name of the file.
EMFileMessageBody *body = [[EMFileMessageBody alloc] initWithData:fileData displayName:fileName];
Message *message = [[Message alloc] initWithConversationID:toChatUsername
            from:fromChatUsername
            to:toChatUsername
            body:body
            ext:messageExt]; 
```

#### Send the attachment message

To send the attachment message, call `sendMessage` in the `ChatMessage` class.

```Objective-C
 // Set the chat type as group chat. You can also set it as chat (one-to-one chat) or chat room.
 message.chatType = AgoraChatTypeGroupChat;
 // Call sendMessage to send the message.
 ChatClient.getInstance().chatManager().sendMessage(message);
 ```

 #### Listen for the message status

To validate that a message is successfully sent, or to track the upload progress of an attachment, use the `progress` callback to listen for the message status:

```Objective-C
// When sending the message, you can set the EMCallback instance to get the state of sending the message.
[[AgoraChatClient sharedClient].chatManager sendMessage:message progress:^(int progress) {
               // The progress of uploading the attachement附件上传进度百分比
 } completion:^(Message * message, AgoraError * error) {
                // Error-handling logics for sending the message 
 }];
});
```

#### Receive the attachment message

Call the `addMessageListener` to add a message listener. If the received message is an image, video, or file message, download the attachment before opening it.

The following code shows how to receive an image message:

```java
// Get the image file and thumbnail when receiving the message.
ImageMessageBody *body = (ImageMessageBody *) message.body;
// Get the image file from the server.
NSString *remotePath = body.remotePath;
// Get the image thumbnail from the server.
NSString *thumbnailPath = body.thumbnailRemotePath;
// Get the path of the image file on the local device.
NSString *localPath = body.localPath;
// Get the image thumbnail from the local device.
NSString *thumbnailLocalPath = body.thumbnailLocalPath;
```

### Location messages

To send and receive a location message, you need to integrate a third-party map service provider. When sending a location message, you get the longitude and latitude information of the location from the map service provider; when receiving the location message, you extract the received longitude and latitude information and display the location on the third-party map.

The following code sample shows how to send a location message:

```Objective-C
// Set the longitude and latitude information and description of the location.
LocationMessageBody    *body        = [[LocationMessageBody alloc] initWithLatitude:latitude longitude:longitude address:aAddress];
Message            *message    = [[Message alloc] initWithConversationID:toChatUsername
                       from:fromChatUsername
                       to:toChatUsername
                       body:body
                       ext:messageExt];
message.chatType = AgoraChatTypeChat;
// Set the chat type as group chat. You can also set it as chat (one-to-one chat) or chat room.
message.chatType = AgoraChatTypeGroupChat;
// Sends the message.
[[AgoraChatClient sharedClient].chatManager sendMessage:message
 progress:nil
 completion:nil];
```

### CMD messages

CMD messages are command messages that tell the specified user to take a certain action. The receiver deals with the command message themselves.

<div class="alert note"><li>CMD messages are not stored in the local database.<li>Actions beginning with <code>em_</code> and <code>easemob::</code> are internal fields. Do not use them.</div>

The following code sample shows how to send and receive a CMD message:

```Objective-C
// Set action as the custom command content in NSString.
CmdMessageBody    *body        = [[CmdMessageBody alloc] initWithAction:action];
Message        *message    = [[Message alloc] initWithConversationID:toChatUsername
                   from:fromChatUsername
                   to:toChatUsername
                   body:body
                   ext:messageExt];
message.chatType = AgoraChatTypeChat;
// Set the chat type as group chat. You can also set it as chat (one-to-one) chat or chat room.
message.chatType = AgoraChatTypeGroupChat;
// Send the CMD message.
[[AgoraChatClient sharedClient].chatManager sendMessage:message
 progress:nil
 completion:nil];

// Occurs when the CMD message is received.
- (void)cmdMessagesDidReceive:(NSArray *)aCmdMessages
{
    for ( Message *message in aCmdMessages )
    {
        CmdMessageBody *body = (CmdMessageBody *) message.body;
        // Parse the CMD message.
    }
}
```

### Custom messages

Custom messages are self-defined key-value pairs that include the message type and the message content.

The following code sample shows how to send a custom message:

```Objective-C
// Set event as the custom event, for example, as userCard to send a namecard message.
// Set ext as the extented message, such as uid, nickname, and avatar.
CustomMessageBody    * body        = [[CustomMessageBody alloc] initWithEvent:@"userCard" ext:@ { @"uid":aUid, @"nickname":aNickName, @"avatar":aUrl }];
Message            *message    = [[Message alloc] initWithConversationID:toChatUsername
                       from:fromChatUsername
                       to:toChatUsername
                       body:body
                       ext:messageExt];
message.chatType = AgoraChatTypeChat;
// Set the chat type as group chat. You can also set it as chat (one-to-one) chat or chat room.
message.chatType = AgoraChatTypeGroupChat;
// Send the message.
[[AgoraChatClient sharedClient].chatManager sendMessage:message
 progress:nil
 completion:nil];
```

### Extended messages

You can also custom the message content by extending the message type. The following code sample shows how to send an extended message:

```Objective-C
TextMessageBody *textMessageBody = [[TextMessageBody alloc] initWithText:content];
// Add an extended attribute.
NSDictionary    *messageExt = @ { @"attribute" : @"value" };
Message        *message = [[Message alloc] initWithConversationID:toChatUsername
                from:fromChatUsername
                to:toChatUsername
                body:textMessageBody
                ext:messageExt];
// Set the chat type as group chat. You can also set it as chat (one-to-one) chat or chat room.
message.chatType = AgoraChatTypeChat;
// Send the message.
[[AgoraChatClient sharedClient].chatManager sendMessage:message
 progress:nil
 completion:nil];

// Retrieve the extended attribute when the message is received.
- (void)messagesDidReceive:(NSArray *)aMessages
{
    // Parse the message when receiving it.
    for ( Message *message in aMessages )
    {
        // value represents the attribute in the extended message. 
        NSString *value = [message.ext objectForKey:@"attribute"];
    }
}
```

### Recall messages

After sending a message, you can recall it using the `recallMessage` method. The default time limit for recalling a message is two minutes after the message. To customize this time limit, contact sales@agora.io.

Refer to the following code sample to recall a message:

```Objective-C
 [[AgoraChatClient sharedClient].chatManager recallMessageWithMessageId:@"messageId" completion:^(AgoraChatError *aError) {
         if (!aError) {
                NSLog(@"Message recell succeeds.");
            } else {
                NSLog(@"Message recall fails with the error desctiption — %@", aError.errorDescription);
            }
     }];
```

## Manage local messages

The Agora Chat SDK stores the sent and received messages in the local database, and you can manage these messages in conversations. 

The followings are the core methods for managing the local messages:
- `getAllConversations`: Retrieves all the conversations on the local device.
- `deleteConversation`: Deletes the conversation on the local device.
- `unreadMessagesCount`: Retrieves the count of the unread messages in the specified conversation.
- `loadMessagesStartFromId`: Searches for messages using keywords or the timestamp from the local database.
- `importMessages`: Imports the specified historial message to the database.
- `insertMessage`: Inserts the specified historial message into the conversation.

### Retrieve local conversations

Call `getAllConversations` to retrieve all the conversations to the local device.

```Objective-C
NSArray *conversations = [[AgoraChatClient sharedClient].chatManager getAllConversations];
```

### Retreive messages from the specified conversation

Refer to the following code sample for retrieving all the messages of the current conversation:

```Objective-C
// Retrieve the specified conversation.
AgoraConversation *conversation = [[AgoraChatClient sharedClient].chatManager getConversation:conversationId type:type createIfNotExist:YES];
// Only one message is loaded during SDK initialization. Call loadMessagesStartFromId to retrieve more messages.
NSArray<Message *> *messages = [conversation loadMessagesStartFromId:startMsgId count:count searchDirection:MessageSearchDirectionUp];
```

### Retrieve the count of the unread messages in the specified conversation

Call `unreadMessageCount` to retrieve the count of the unread messages in the current conversation.

```Objective-C
// Get the current conversation
AgoraConversation *conversation = [[AgoraChatClient sharedClient].chatManager getConversation:conversationId type:type createIfNotExist:YES];
// Retrieve the count of the unread messages in the current conversation.
NSInteger unreadCount = conversation.unreadMessagesCount;
```

### Retrieve all the unread messages

You can also call `unreadMessagesCount` to retrieve the count of all the unread messages in all the conversations.

```Objective-C
NSArray        *conversations    = [[AgoraChatClient sharedClient].chatManager getAllConversations];
NSInteger    unreadCount    = 0;
for ( AgoraConversation *conversation in conversations )
{
    unreadCount += conversation.unreadMessagesCount;
}
```
### Mark messages as read

You can mark the specified message or all the messages in the specified conversation as read. Refer to the following code sample:

```Objective-C
AgoraConversation *conversation = [[AgoraChatClient sharedClient].chatManager getConversation:conversationId type:type createIfNotExist:YES];
// Mark all the messages in the current conversation as read
[conversation markAllMessagesAsRead:nil];
// Mark the specified message in the current conversation as read.
[onversation markMessageAsReadWithId:messageId error:nil];
```

### Delete local conversations and messages

You can delete the specified conversation or the specified message in the current conversation from the local device. Refer to the following code:

```Objective-C
// Set whether to delete all the historial messages in the current conversation.
[[AgoraChatClient sharedClient].chatManager deleteConversation:conversationId isDeleteMessages:YES completion:nil];
// Delete the specified conversations.
NSArray *conversations = @ { @"conversationID1", @"conversationID2" };
[[AgoraChatClient sharedClient].chatManager deleteConversations:conversations isDeleteMessages:YES completion:nil];
// Delete the specified historial messages in the current conversation.
AgoraConversation *conversation = [[AgoraChatClient sharedClient].chatManager getConversation:conversationId type:type createIfNotExist:YES];
[conversation deleteMessageWithId:.messageId error:nil];
```

### Search historial messages

Refer to the following code to search the historial messages. You can use fields such as keyword, timestamp, and sender for the search.

```Objective-C
// Call searchMsgFromDB to search for messages in the current conversation.
NSArray<Message *> *messages = [conversation loadMessagesWithKeyword:keyword timestamp:0 count:50 fromUser:nil searchDirection:MessageSearchDirectionDown];
```

### Import historial messages to the local database

You can import a historial message to the local database by constructing a `ChatMessage` object:

```Objective-C
[[AgoraChatClient sharedClient].chatManager importMessages:messages completion:nil];
```

### Insert messages

Refer to the following code sample to insert a message into the current conversation:

```Objective-C
// Insert a message into the current conversation.
AgoraConversation *conversation = [[AgoraChatClient sharedClient].chatManager getConversation:conversationId type:type createIfNotExist:YES];
[conversation insertMessage:message error:nil];
```

## Retrieve historial messages from the server

The Agora Chat SDK also stores historial messages on the chat server, and you can retrieve these historial messages by conversations.

The followings are the core methods for retrieving historical messages from the server
- `getConversationsFromServer`: Retrieves the conversation list from the server.
- `asyncFetchHistoryMessagesFromServer`: Retrieves the messages in the specified conversation from the server.

Agora recommends calling these methods when the app is first installed or before any conversation occurs on the local device.

### Retrieve the conversation list

Refer to the following code sample to retrieve the conversation list from the server. For each message call, a maximum number of 100 conversations are returned.

```Objective-C
[[AgoraChatClient sharedClient].chatManager getConversationsFromServer:^(NSArray * aCoversations, AgoraError * aError) {
     if ( !aError )
     {
         for ( AgoraConversation * conversation in aCoversations )
         {
                         /* Parse theconversation.*/
         }
     }
 }];
```

### Retrieve the historical messages of the specified conversation by pagination

Refer to the following code to retrieve the historial messages from the specified conversation by pagination. For each method call, a maximum number of 50 messages are returned.

```Objective-C
[[AgoraChatClient sharedClient].chatManager asyncFetchHistoryMessagesFromServer:conversationId conversationType:conversationType startMessageId:messageId pageSize:pageSize completion:^(AgoraCursorResult * aResult, AgoraError * aError) {
     AgoraConversation *conversation = [[AgoraChatClient sharedClient].chatManager getConversation:conversationId type:type createIfNotExist:YES];
     [conversation loadMessagesStartFromId:messageId count:count searchDirection:MessageSearchDirectionUp completion:nil];
 }];
```

## Message delivery and read receipts

After you send a message, once this message is delivered or read, the Agora Chat SDK supports sending a receipt to you, informing you that the message is delivered or read.

The followings are the core methods for implementing message delivery and read receipts:
- `enableRequireReadAck`: Enables message read receipts.
- `ackConversationRead`: Sends the receipt when the specified conversation is read.
- `sendMessageReadAck`: Sends the receipt when the specified message is read.
- `sendGroupMessageReadAck`: Sends the receipt when the specified group message is read.

### Message delivery receipts

Call `setRequireDeliveryAck` to enable the message delievery receipt feature. The following code sample shows how to implement message delivery receipts:

```java
// Call enableRequireReadAck to enable message delivery receipt. 
options.enableRequireReadAck = YES;

- (void)messagesDidRead:(NSArray *)aMessages
{
    for ( EMMessage *message in aMessages )
    {
        // Handling message delievery receipts.
    }
}

// Remove the delegate.
[[AgoraChatClient sharedClient].chatManager removeDelegate:self];
```

### Read receipts

Once the message sender enables message read receipts by calling `enableRequireReadAck`, the message receiver sends this receipt after reading the message.

#### Conversation read receipts

Refer to the following code to implement read receipts for all the messages in the specified conversation:

- The message receiver

    ```Objective-C
    // The message receiver calls ackConversationRead to send the conversation read receipt.
    // This is an asynchronous method.
    [[AgoraChatClient sharedClient].chatManager ackConversationRead:conversationId completion:nil];
    ```

- The message sender

    ```java
    // The message sender receives the onConversationRead callback.
    - (void)onConversationRead:(NSString *)from to:(NSString *)to
    {
        // Add handling logics
    }
    ```

In scenarios where a user has logged in to multiple devices, once the read receipt is sent from one of these devices, the server marks the unread messagea on the other devices as read as well.

#### Message read receipts

Refer to the following code to implement read receipts for the specified message:

- The message receiver
    
  You can send the message read receipt when entering the conversation:

    ```Objective-C
    // The message receiver calls sendMessageReadAck to send the message read receipt.
    [[AgoraChatClient sharedClient].chatManager sendMessageReadAck:messageId toUser:conversationId completion:nil];
    }
    ```

  You can also send the message read receipt when receiving a message:

    ```Objective-C
    // Occurs when the message is received
    - (void)messagesDidReceive:(NSArray *)aMessages
    {
        for ( Message *message in aMessages )
        {
            // Send the message read receipt
            [self sendReadAckForMessage:message];
        }
    }
    
    // Send the message read receipt
    - (void)sendReadAckForMessage:(Message *)aMessage
    {
        // Receive the message
        if ( aMessage.direction == EMMessageDirectionSend || aMessage.isReadAcked || aMessage.chatType != EMChatTypeChat )
            return;

        MessageBody *body = aMessage.body;
        // For voice, video, and file messages, you need to send the receipt after clicking the files.
        if ( body.type == MessageBodyTypeFile || body.type == MessageBodyTypeVoice || body.type == MessageBodyTypeImage )
            return;

        [[AgoraChatClient sharedClient].chatManager sendMessageReadAck:aMessage.messageId toUser:aMessage.conversationId completion:nil];
    }
    ```

- The message sender

    ```Objective-C
    // Occurs when the message is read.
    - (void)messagesDidRead:(NSArray *)aMessages
    {
        for ( Message *message in aMessages )
        {
            // Add handling logics.
        }
    }
    ```

#### Group message read receipts

For chat group messages, when the group owner or an admin sends a messge, they can set whether to require a message read receipt.

<div class="alert note">You need to contact sales@agora.io to enable the group message read receipt feature. Once enabled, this feature applies to the chat group owner and chat group admins only.</div>

To receive the chat message receipt, the message sender needs to set `isNeedGroupAck` as `YES` when sending the message.

```Objective-C
// Set isNeedGroupAck as YES when initializing the group message
Message *message = [[Message alloc] initWithConversationID:to from:from to:to body:aBody ext:aExt];
message.isNeedGroupAck = YES;
```

The following code sample shows how to implement chat message receipts:

- The message receiver

    ```Objective-C
    // Send the group message read receipt.
    - (void)sendGroupMessageReadAck:(Message *)msg
    {
        if ( msg.isNeedGroupAck && !msg.isReadAcked )
        {
            [[AgoraChatClient sharedClient].chatManager sendGroupMessageReadAck:msg.messageId toGroup:msg.conversationId content:@"123" completion:^(EMError * error) {
                if ( error )
                {
                }
            }];
        }
    }
    ```

- The message sender

    ```Objecitive-C
    // Occurs when the group message is read.
    - (void)groupMessageDidRead:(Message *)aMessage groupAcks:(NSArray *)aGroupAcks
    {
        for ( GroupMessageAck *messageAck in aGroupAcks )
        {
            // Receive the group message read receipt.
        }
    }
    ```

    After receiving the `groupMessageDidRead` callback, the message sender can also call `asyncFetchGroupReadAcks` to know the details of the receipt.

    ```Objective-C
    /**
     * Fetches the details of the group message read receipt.
     * @param messageId The message ID.
     * @param groupId The group ID.
     * @param startGroupAckId The receipt ID from which you want to fetch. If you set it as null, the SDK fetches from the latest receipt.
     * @param pageSize The page size.
     * @return The message receipt list and a cursor.
     */
    [[AgoraChatClient sharedClient].chatManager asyncFetchGroupMessageAcksFromServer:messageId groupId:groupId startGroupAckId:nil pageSize:pageSize completion:^(EMCursorResult * aResult, EMError * error, int totalCount) {
            // Add follow-up logics such as popping up a notification.
    }];
    ```