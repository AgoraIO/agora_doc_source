# 发送和接收消息

登录 Agora Chat 后，用户可以向对等用户、聊天组或聊天室发送以下类型的消息：

- 短信，包括超链接和表情符号。
- 附件消息，包括图像、语音、视频和文件消息。
- 位置信息。
- CMD 消息。
- 扩展消息。
- 自定义消息。

本页展示了如何使用 Agora Chat SDK 实现这些消息的发送和接收。

## 了解技术

Agora Chat SDK 使用 `IAgoraChatManager`和`Message` 类来发送、接收和撤回消息。

发送和接收消息的过程如下：

1. `init` 消息发送者使用相应的方法创建文本、文件或附件消息。
2. 消息发送者调用 `sendMessage` 发送消息。
3. 消息接收者调用 `addDelegate` 监听消息事件并在 `messageDidReceive` 回调中接收消息。

## 先决条件

在继续之前，请确保您满足以下要求：

- 您已经集成了 Agora Chat SDK，初始化了 SDK，并实现了注册账号和登录功能。详情请参见 [Agora Chat 入门](https://docs.agora.io/en/agora-chat/agora_chat_get_started_ios?platform=iOS)。
- 了解 [使用限制](https://docs.agora.io/en/agora-chat/agora_chat_limitation?platform=iOS)。

## 执行

本节介绍如何实现发送和接收各种类型的消息。

### 发一个短信

使用`AgoraChatTextMessageBody`类创建文本消息，然后发送消息。

```objectivec
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

### 接收消息

你可以 `AgoraChatManagerDelegate` 用来监听消息事件。您可以添加多个委托来侦听多个事件。当您不再侦听事件时，请确保删除侦听器。

当消息到达时，收件人会收到 `messagesDidReceive` 回调。每个回调包含一条或多条消息。您可以遍历消息列表，并在此回调中解析和渲染这些消息并渲染这些消息。

```objectivec
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

### 撤回消息

用户发送消息两分钟后，该用户可以撤回消息。如需调整时间限制，请联系[support@agora.io 。](mailto:support@agora.io)

```objectivec
[[AgoraChatClient sharedClient].chatManager recallMessageWithMessageId:@"messageId" completion:^(AgoraChatError *aError) {
        if (!aError) {
               NSLog(@"Recalling message succeeds");
           } else {
               NSLog(@"Recalling message fails — %@", aError.errorDescription);
           }
    }];
```

您还可以使用`messagesDidRecall`来监听消息召回状态：

```objectivec
/**
 * Occurs when a received message is recalled.
 */
- (void)messagesDidRecall:(NSArray *)aMessages;
```

### 发送和接收附件消息

语音、图像、视频和文件消息本质上是附件消息。本节介绍如何发送这些类型的消息。

#### 发送和接收语音消息

在发送语音消息之前，您应该在应用程序级别实现录音，它提供了录制的音频文件的 URI 和持续时间。

请参考以下代码示例来创建和发送语音消息：

```objectivec
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

当收件人收到消息时，参考以下代码示例获取音频文件：

```objectivec
AgoraChatVoiceMessageBody *voiceBody = (AgoraChatVoiceMessageBody *)message.body;
// Retrieves the path of the audio file on the server.
NSString *voiceRemotePath = voiceBody.remotePath;
// Retrieves the path of the audio file on the local device.
NSString *voiceLocalPath = voiceBody.localPath;
```

#### 发送和接收图像消息

默认情况下，SDK 在发送之前会压缩图像文件。要发送原始文件，您可以设置`original`为`true`.

请参考以下代码示例来创建和发送图像消息：

```objectivec
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

当收件人收到消息时，参考以下代码示例获取图片消息的缩略图和附件文件：

```objectivec
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

如果在接收方客户端`[AgoraChatClient sharedClient].options.isAutoDownloadThumbnail`设置为`YES`，SDK 收到消息后会自动下载缩略图。如果没有，您需要调用`[[AgoraChatClient sharedClient].chatManager downloadMessageThumbnail:message progress:nil completion:nil];`以下载缩略图并`thumbnailLocalPath`从`messageBody`.

#### 发送和接收视频消息

在发送视频消息之前，您应该在应用程序级别实现视频捕获，它提供了捕获的视频文件的时长。

请参考以下代码示例来创建和发送视频消息：

```objectivec
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

默认情况下，当收件人收到消息时，SDK 会下载视频消息的缩略图。

如果不希望SDK自动下载视频缩略图，设置`[AgoraChatClient sharedClient].options.isAutoDownloadThumbnail`为`NO`，下载缩略图，需要调用，从成员`[[AgoraChatClient sharedClient].chatManager downloadMessageThumbnail:message progress:nil completion:nil]`处获取缩略图的路径。`thumbnailLocalPath``messageBody`

要下载实际的视频文件，请调用，并从 中的成员`[[AgoraChatClient sharedClient].chatManager downloadMessageAttachment:progress:completion:]`那里获取视频文件的路径。`getLocalUri``messageBody`

```objectivec
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

#### 发送和接收文件消息

请参考以下代码示例来创建、发送和接收文件消息：

```objectivec
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

发送文件消息时，参考以下示例代码获取附件文件上传进度：

```objectivec
[[AgoraChatClient sharedClient].chatManager sendMessage:message progress:^(int progress) {
        //progress indicates the progress of uploading the attachment
} completion:^(AgoraChatMessage *message, AgoraChatError *error) {
    //error indicates the result of sending the message, and message indicates the sent message
}];
```

当收件人收到邮件时，参考以下代码示例获取附件文件：

```objectivec
AgoraChatFileMessageBody *body = (AgoraChatFileMessageBody *)message.body;
// Retrieves the path of the attachment file from the server.
NSString *remotePath = body.remotePath;
// Retrieves the path of the attachment file on the local device.
NSString *localPath = body.localPath;
```

### 发送位置信息

要发送和接收位置信息，您需要集成第三方地图服务提供商。发送位置信息时，您从地图服务提供商处获取该位置的经纬度信息；接收到位置信息时，提取接收到的经纬度信息，并在第三方地图上显示位置。

```objectivec
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

### 发送和接收 CMD 消息

CMD 消息是指示指定用户采取特定操作的命令消息。接收者自己处理命令消息。

- CMD 消息不存储在本地数据库中。
- 以 `em_` 和 `easemob::` 开头的操作是内部字段。不要使用它们。

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

要通知收件人收到了 CMD 消息，请使用单独的委托，以便用户可以以不同的方式处理消息。

```objectivec
// Occurs when the CMD message is received.
- (void)cmdMessagesDidReceive:(NSArray *)aCmdMessages{
  for (AgoraChatMessage *message in aCmdMessages) {
        AgoraChatCmdMessageBody *body = (AgoraChatCmdMessageBody *)message.body;
        // Parse the message body
    }
}
```

### 发送自定义消息

自定义消息是自定义的键值对，包括消息类型和消息内容。

以下代码示例显示了如何创建和发送自定义消息：

```objectivec
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

### 使用附加短信信息

如果上面列出的消息类型不符合您的要求，您可以使用消息扩展来为消息添加属性。这可以应用于更复杂的消息传递场景。

```objectivec
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

## 下一步

实现消息发送和接收后，您可以参考以下文档为您的应用添加更多消息功能：

- [管理本地消息](https://docs.agora.io/en/agora-chat/agora_chat_manage_message_ios?platform=iOS)
- [从服务器检索对话和消息](https://docs.agora.io/en/agora-chat/agora_chat_retrieve_message_ios?platform=iOS)
- [消息回执](https://docs.agora.io/en/agora-chat/agora_chat_message_receipt_android?platform=iOS)