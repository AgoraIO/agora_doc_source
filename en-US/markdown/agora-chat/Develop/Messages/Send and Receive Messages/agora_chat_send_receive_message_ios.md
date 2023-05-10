After logging in to Agora Chat, users can send the following types of messages to a peer user, a chat group, or a chat room:
- Text messages, including hyperlinks and emojis.
- Attachment messages, including image, voice, video, and file messages.
- Location messages.
- CMD messages.
- Extended messages.
- Custom messages.

In high-concurrency scenarios, you can set a certain message type or messages of a chat room member as high, normal, or low. In this case, low-priority messages are dropped first to reserve resources for the high-priority ones (e.g. gifts and announcements) when the server is overloaded. This ensures that the high-priority messages can be dealt with first when loads of messages are being sent in high concurrency or high frequency. Note that this feature can increase the delivery reliability of high-priority messages, but cannot guarantee the deliveries. Even high-priorities messages can be dropped when the server load goes too high.

This page shows how to implement sending and receiving these messages using the Agora Chat SDK.

## Understand the tech

The Agora Chat SDK uses the `IAgoraChatManager` and `Message` classes to send, receive, and withdraw messages.

The process of sending and receiving a message is as follows:

1. The message sender creates a text, file, or attachment message using the corresponding `init` method.
2. The message sender calls `sendMessage` to send the message.
3. The message recipient calls `addDelegate` to listens for message events and receives the message in the `messageDidReceive` callback.

## Prerequistes

Before proceeding, ensure that you meet the following requirements:
- You have integrated the Agora Chat SDK, initialized the SDK and implemented the functionality of registering accounts and login. For details, see [Get Started with Agora Chat](./agora_chat_get_started_ios?platform=iOS).
- You understand the API call frequency limits as described in [Limitations](./agora_chat_limitation?platform=iOS).

## Implementation

This section shows how to implement sending and receiving the various types of messages.

### Send a text message

Use the `AgoraChatTextMessageBody` class to create a text message, and then send the message.

```objective-c
// Call initWithText to create a text message. Set content as the text content and toChatUsername to the username to whom you want to send this text message.
AgoraChatTextMessageBody *textMessageBody = [[AgoraChatTextMessageBody alloc] initWithText:content];
AgoraChatMessage *message = [[AgoraChatMessage alloc] initWithConversationID:toChatUsername
                                                      from:fromChatUsername
                                                        to:toChatUsername
                                                      body:textMessageBody
                                                       ext:messageExt];
// Set the chat type as Group chat. You can also set is as chat (one-to-one chat) or chat room.
message.chatType = AgoraChatTypeGroupChat;
// Sends the message
[[AgoraChatClient sharedClient].chatManager sendMessage:message
                                               progress:nil
                                             completion:nil];
```

You can set the priority of chat room messages. 

```objective-c
AgoraChatTextMessageBody* textBody = [[AgoraChatTextMessageBody alloc] initWithText:@"Hi"];
    AgoraChatMessage* message = [[AgoraChatMessage alloc] initWithConversationID:@"roomId" body:textBody ext:nil];
    message.chatType = AgoraChatTypeChatRoom;
    // Set the message priority. The default value is `Normal`, indicating the normal priority.
    message.priority = AgoraChatRoomMessagePriorityHigh;
[AgoraChatClient.sharedClient.chatManager sendMessage:message progress:nil completion:nil];
```

### Receive a message

You can use `AgoraChatManagerDelegate` to listen for message events. You can add multiple delegates to listen for multiple events. When you no longer listen for an event, ensure that you remove the listener.

When a message arrives, the recipient receives an `messagesDidReceive` callback. Each callback contains one or more messages. You can traverse the message list, and parse and render these messages in this callback and render these messages.

```objective-c
// Adds the delegate.
[[AgoraChatClient sharedClient].chatManager addDelegate:self delegateQueue:nil];

// Occurs when the message is received.
- (void)messagesDidReceive:(NSArray<AgoraChatMessage*> *)aMessages
{
  // Traverse the message list
  for (AgoraChatMessage *message in aMessages) {
    // Parse the message and display it on the UI
  }
}

// Removes the delegate.
- (void)dealloc
{
  [[AgoraChatClient sharedClient].chatManager removeDelegate:self];
}
```


### Recall a message

Two minutes after a user sends a message, this user can withdraw it. Contact support@agora.io if you want to adjust the time limit.

```objective-c
[[AgoraChatClient sharedClient].chatManager recallMessageWithMessageId:@"messageId" completion:^(AgoraChatError *aError) {
        if (!aError) {
               NSLog(@"Recalling message succeeds");
           } else {
               NSLog(@"Recalling message fails — %@", aError.errorDescription);
           }
    }];
```

You can also use `messagesDidRecall` to listen for the message recall state:

```objective-c
/**
 * Occurs when a received message is recalled.
 */
- (void)messagesDidRecall:(NSArray *)aMessages;
```

### Send and receive an attachment message

Voice, image, video, and file messages are essentially attachment messages. This section introduces how to send these types of messages.

#### Send and receive a voice message

Before sending a voice message, you should implement audio recording on the app level, which provides the URI and duration of the recorded audio file.

Refer to the following code example to create and send a voice message:

```objective-c
// Set localPath as the local path of the voice file and displayName the display name of the attachment.
AgoraChatVoiceMessageBody *body = [[AgoraChatVoiceMessageBody alloc] initWithLocalPath:localPath
                          							     displayName:displayName];
AgoraChatMessage *message = [[AgoraChatMessage alloc] initWithConversationID:toChatUsername
                                                      from:fromChatUsername 
                     									                  to:toChatUsername 
                     								                  body:body
                                                       ext:nil];
message.chatType = AgoraChatTypeChat;
// Set the chat type as Group chat. You can also set is as chat (one-to-one chat) or chat room.
message.chatType = AgoraChatTypeGroupChat;
// Sends the message
[[AgoraChatClient sharedClient].chatManager sendMessage:message 
  											                       progress:nil
  											                     completion:nil];
```

When the recipient receives the message, refer to the following code example to get the audio file:

```objective-c
AgoraChatVoiceMessageBody *voiceBody = (AgoraChatVoiceMessageBody *)message.body;
// Retrieves the path of the audio file on the server.
NSString *voiceRemotePath = voiceBody.remotePath;
// Retrieves the path of the audio file on the local device.
NSString *voiceLocalPath = voiceBody.localPath;
```

#### Send and receive an image message

By default, the SDK compresses the image file before sending it. To send the originial file, you can set `original` as `true`.

Refer to the following code example to create and send an image message:

```objective-c
// Set imageData as the path of the image file on the local device, and displayName as the display name of the file.
AgoraChatImageMessageBody *body = [[AgoraChatImageMessageBody alloc] initWithData:imageData
                          							            displayName:displayName];
AgoraChatMessage *message = [[AgoraChatMessage alloc] initWithConversationID:toChatUsername
                                                      from:fromChatUsername 
                     									                  to:toChatUsername 
                     								                  body:body
                                                       ext:messageExt];
message.chatType = AgoraChatTypeChat;
// Set the chat type as Group chat. You can also set is as chat (one-to-one chat) or chat room.
message.chatType = AgoraChatTypeGroupChat;
// Sends the message
[[AgoraChatClient sharedClient].chatManager sendMessage:message 
  											                       progress:nil
  											                     completion:nil];
```

When the recipient receives the message, refer to the following code example to get the thumbnail and attachment file of the image message:

```objective-c
AgoraChatImageMessageBody *body = (AgoraChatImageMessageBody *)message.body;
// Retrieves the path of the image file on the server.
NSString *remotePath = body.remotePath;
// Retrieves the path of the image thumbnail from the server.
NSString *thumbnailPath = body.thumbnailRemotePath;
// Retrieves the path of the image file on the local device.
NSString *localPath = body.localPath;
// Retrieves the path of the image thumbnail on the local device.
NSString *thumbnailLocalPath = body.thumbnailLocalPath;
```

<div class="alert note">If <code>[AgoraChatClient sharedClient].options.isAutoDownloadThumbnail</code> is set as <code>YES</code> on the recipient's client, the SDK automatically downloads the thumbnail after receiving the message. If not, you need to call <code>[[AgoraChatClient sharedClient].chatManager downloadMessageThumbnail:message progress:nil completion:nil];</code> to download the thumbnail and get the path from the <code>thumbnailLocalPath</code> member in <code>messageBody</code>.</div>

#### Send and receive a video message

Before sending a video message, you should implement video capturing on the app level, which provides the duration of the captured video file.

Refer to the following code example to create and send a video message:

```objective-c
// Set localPath as the path of the video file on the local device and displayName the display name of the video file.
AgoraChatVideoMessageBody *body = [[AgoraChatVideoMessageBody alloc] initWithLocalPath:localPath displayName:@"displayName"];
// The duration of the video file
body.duration = duration;

AgoraChatMessage *message = [[AgoraChatMessage alloc] initWithConversationID:toChatUsername
                                                      from:fromChatUsername 
                     									                  to:toChatUsername 
                     								                  body:body
                                                       ext:messageExt];
message.chatType = AgoraChatTypeChat;
// Set the chat type as Group chat. You can also set is as chat (one-to-one chat) or chat room.
message.chatType = AgoraChatTypeGroupChat;
// Sends the message 
[[AgoraChatClient sharedClient].chatManager sendMessage:message 
  											                       progress:nil
  											                     completion:nil];

```

By default, when the recipient receives the message, the SDK downloads the thumbnail of the video message. 

If you do not want the SDK to automatically download the video thumbnail, set `[AgoraChatClient sharedClient].options.isAutoDownloadThumbnail` as `NO`, and to download the thumbnail, you need to call `[[AgoraChatClient sharedClient].chatManager downloadMessageThumbnail:message progress:nil completion:nil]`, and get the path of the thumbnail from the `thumbnailLocalPath` member in `messageBody`.

To download the actual video file, call `[[AgoraChatClient sharedClient].chatManager downloadMessageAttachment:progress:completion:]`, and get the path of the video file from the `getLocalUri` member in `messageBody`.

```objective-c
AgoraChatVideoMessageBody *body = (AgoraChatVideoMessageBody *)message.body;
// Retrieves the path of the video file from the server.
NSString *remotePath = body.remotePath;
// Retrieves the thumbnail of the video file from the server.
NSString *thumbnailPath = body.thumbnailRemotePath;
// Retrieves the path of the video file on the local device.
NSString *localPath = body.localPath;
// Retrieves the thumbnail of the video file on the local deivce.
NSString *thumbnailLocalPath = body.thumbnailLocalPath;
```

#### Send and receive a file message

Refer to the following code example to create, send, and receive a file message:

```objective-c
// Set fileData as the path of the file on the local device, and fileName the display name of the attachment file.
AgoraChatFileMessageBody *body = [[AgoraChatFileMessageBody  initWithData:fileData 
                           							            displayName:fileName];
AgoraChatMessage *message = [[AgoraChatMessage alloc] initWithConversationID:toChatUsername
                                                      from:fromChatUsername 
                     								                    to:toChatUsername 
                     								                  body:body
                                                       ext:messageExt];
message.chatType = AgoraChatTypeChat;
// Set the chat type as Group chat. You can also set is as chat (one-to-one chat) or chat room.
message.chatType = AgoraChatTypeGroupChat;
// Sends the message
[[AgoraChatClient sharedClient].chatManager sendMessage:message 
  											                       progress:nil
  											                     completion:nil];
```

While sending a file message, refer to the following sample code to get the progress for uploading the attachment file:

```objective-c
[[AgoraChatClient sharedClient].chatManager sendMessage:message progress:^(int progress) {
		//progress indicates the progress of uploading the attachment
} completion:^(AgoraChatMessage *message, AgoraChatError *error) {
    //error indicates the result of sending the message, and message indicates the sent message
}];
```

When the recipient receives the message, refer to the following code example to get the attachment file:

```objective-c
AgoraChatFileMessageBody *body = (AgoraChatFileMessageBody *)message.body;
// Retrieves the path of the attachment file from the server.
NSString *remotePath = body.remotePath;
// Retrieves the path of the attachment file on the local device.
NSString *localPath = body.localPath;
```

### Send a location message

To send and receive a location message, you need to integrate a third-party map service provider. When sending a location message, you get the longitude and latitude information of the location from the map service provider; when receiving a location message, you extract the received longitude and latitude information and displays the location on the third-party map.

```objective-c
// Sets the latitude and longitude information of the location.
AgoraChatLocationMessageBody *body = [[AgoraChatLocationMessageBody alloc] initWithLatitude:latitude longitude:longitude address:aAddress];
AgoraChatMessage *message = [[AgoraChatMessage alloc] initWithConversationID:toChatUsername
                                                      from:fromChatUsername 
                     									                  to:toChatUsername 
                     								                  body:body
                                                       ext:messageExt];
message.chatType = AgoraChatTypeChat;
// Set the chat type as Group chat. You can also set is as chat (one-to-one chat) or chat room.
message.chatType = AgoraChatTypeGroupChat;
// Sends the message
[[AgoraChatClient sharedClient].chatManager sendMessage:message 
  											                       progress:nil
  											                     completion:nil];
```

### Send and receive a CMD message

CMD messages are command messages that instruct a specified user to take a certain action. The recipient deals with the command messages themselves.

<div class="alert note"><ul><li>CMD messages are not stored in the local database.</li><li>Actions beginning with `em_` and `easemob::` are internal fields. Do not use them.</li></ul></div>

```Objective
// Use action to customize the CMD message
AgoraChatCmdMessageBody *body = [[AgoraChatCmdMessageBody alloc] initWithAction:action];
AgoraChatMessage *message = [[AgoraChatMessage alloc] initWithConversationID:toChatUsername
                                                      from:fromChatUsername 
                     									                  to:toChatUsername 
                     								                  body:body
                                                       ext:messageExt];
message.chatType = AgoraChatTypeChat;
// Set the chat type as Group chat. You can also set is as chat (one-to-one chat) or chat room.
message.chatType = AgoraChatTypeGroupChat;
// Sends the message
[[AgoraChatClient sharedClient].chatManager sendMessage:message 
  											                       progress:nil
  											                     completion:nil];
```

To notify the recipient that a CMD message is received, use a seperate delegate so that users can deal with the message differently.

```objective-c
// Occurs when the CMD message is received.
- (void)cmdMessagesDidReceive:(NSArray *)aCmdMessages{
  for (AgoraChatMessage *message in aCmdMessages) {
        AgoraChatCmdMessageBody *body = (AgoraChatCmdMessageBody *)message.body;
        // Parse the message body
    }
}
```

### Send a customized message

Custom messages are self-defined key-value pairs that include the message type and the message content.

The following code example shows how to create and send a customized message:

```objective-c
// Set event as the custom message event, for example "userCard".
// Set ext as the extension field of the event, for example as uid, nichname, and avator.
AgoraChatCustomMessageBody* body = [[AgoraChatCustomMessageBody alloc] initWithEvent:@"userCard" ext:@{@"uid":aUid ,@"nickname":aNickName,@"avatar":aUrl}];
AgoraChatMessage *message = [[AgoraChatMessage alloc] initWithConversationID:toChatUsername
                                                      from:fromChatUsername 
                     									                  to:toChatUsername 
                     								                  body:body
                                                       ext:messageExt];
message.chatType = AgoraChatTypeChat;
// Set the chat type as Group chat. You can also set is as chat (one-to-one chat) or chat room.
message.chatType = AgoraChatTypeGroupChat;
// Sends the message.
[[AgoraChatClient sharedClient].chatManager sendMessage:message 
  											   progress:nil
  											 completion:nil];
       
```

### Use message extensions

If the message types listed above do not meet your requirements, you can use message extensions to add attributes to the message. This can be applied in more complicated messaging scenarios.

```objective-c
AgoraChatTextMessageBody *textMessageBody = [[AgoraChatTextMessageBody alloc] initWithText:content];
// Adds the message extension.
NSDictionary *messageExt = @{@"attribute":@"value"};
AgoraChatMessage *message = [[AgoraChatMessage alloc] initWithConversationID:toChatUsername
                                                       from:fromChatUsername 
                     																		 to:toChatUsername 
                     																	 body:textMessageBody
                                                        ext:messageExt];
message.chatType = AgoraChatTypeChat; 
// Sends the message 
[[AgoraChatClient sharedClient].chatManager sendMessage:message 
  																						 progress:nil
  																					 completion:nil];

// Retrieves the extension when receiving the message
- (void)messagesDidReceive:(NSArray *)aMessages
{
  // Traverse the message list
  for (AgoraChatMessage *message in aMessages) {
     //value indicates the value of the attribute field in the message extension
     NSString *value = [message.ext objectForKey:@"attribute"];
  }
}
```

## Next steps

After implementing sending and receiving messages, you can refer to the following documents to add more messaging functionalities to your app:

- [Manage local messages](./agora_chat_manage_message_ios?platform=iOS)
- [Retrieve conversations and messages from the server](./agora_chat_retrieve_message_ios?platform=iOS)
- [Message receipts](./agora_chat_message_receipt_android?platform=iOS)

