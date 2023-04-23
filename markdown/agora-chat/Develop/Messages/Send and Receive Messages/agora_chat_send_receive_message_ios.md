登录即时通讯 app 后，用户可以在一对一单聊、群聊或聊天室中发送如下类型的消息：

- 文字消息，包含超链接和表情消息。
- 附件消息，包含图片、语音、视频及文件消息。
- 位置消息。
- 透传消息。
- 自定义消息。

针对聊天室消息并发量较大的场景，即时通讯服务提供消息分级功能。你可以通过设置消息优先级，将消息划分为高、普通和低三种级别。你可以在创建消息时，将指定消息类型，或指定成员的所有消息设置为高优先级，确保此类消息优先送达。这种方式可以确保在聊天室内消息并发量较大或消息发送频率过高的情况下，服务器首先丢弃低优先级消息，将资源留给高优先级消息，确保重要消息（如打赏、公告等）优先送达，以此提升重要消息的可靠性。请注意，该功能并不保证高优先级消息必达。在聊天室内消息并发量过大的情况下，为保证用户实时互动的流畅性，即使是高优先级消息仍然会被丢弃。

本文介绍如何使用即时通讯 IM SDK 实现发送和接收这些类型的消息。

## 技术原理

即时通讯 IM SDK 使用 `IAgoraChatManager`和 `Message` 类发送、接收和撤回消息、发送、接收消息已读回执，并管理用户设备上存储的消息会话数据。

发送和接收消息的过程如下：

1. 消息发送者使用 `init` 方法创建文本、文件或附件消息。
2. 消息发送者调用 `sendMessage` 发送消息。
3. 消息接收者调用 `addDelegate` 监听消息事件并在 `messageDidReceive` 回调中接收消息。

## 前提条件

开始前，请确保满足以下条件：

- 完成 SDK 初始化，详见 [iOS 快速开始](./agora_chat_get_started_ios)。
- 了解消息相关限制，详见[消息概述](./agora_chat_message_overview)。
- 了解即时通讯 IM API 的调用频率限制，详见 [限制条件](./agora_chat_limitation)。

## 实现方法

本节介绍如何实现发送和接收各种类型的消息。

### 发送文本消息

使用 `AgoraChatTextMessageBody` 类创建文本消息，然后发送消息。

```objectivec
// 创建一条文本消息，`content` 为消息文字内容，`toChatUsername` 为对方用户或者群聊的 ID，`fromChatUsername` 为发送方用户或群聊的 ID，`textMessageBody` 为消息体，`messageExt` 为消息扩展，后文皆是如此。
AgoraChatTextMessageBody *textMessageBody = [[AgoraChatTextMessageBody alloc] initWithText:content];
AgoraChatMessage *message = [[AgoraChatMessage alloc] initWithConversationID:toChatUsername
                                                      from:fromChatUsername
                                                        to:toChatUsername
                                                      body:textMessageBody
                                                       ext:messageExt];
 // 构造消息时需设置 `AgoraChatMessage` 类的 `ChatType` 属性。该属性的值为 `AgoraChatTypeChat`、`AgoraChatTypeGroupChat` 和 `AgoraChatTypeChatRoom`，表明该消息是单聊、群聊或聊天室消息，默认为单聊。例如，设置消息类型为单聊消息即设置 `ChatType` 为 `EMChatTypeChat`。
message.chatType = AgoraChatTypeGroupChat;
 // 发送消息。
[[AgoraChatClient sharedClient].chatManager sendMessage:message
                                               progress:nil
                                             completion:nil];
```

对于聊天室消息，可设置消息优先级。

```objectivec
AgoraChatTextMessageBody* textBody = [[AgoraChatTextMessageBody alloc] initWithText:@"Hi"];
    AgoraChatMessage* message = [[AgoraChatMessage alloc] initWithConversationID:@"roomId" body:textBody ext:nil];
    message.chatType = AgoraChatTypeChatRoom;
    // 聊天室消息的优先级。如果不设置，默认值为 `Normal`，即`普通`优先级。
    message.priority = AgoraChatRoomMessagePriorityHigh;
[AgoraChatClient.sharedClient.chatManager sendMessage:message progress:nil completion:nil];
```

### 接收消息

你可以 `AgoraChatManagerDelegate` 用来监听消息事件。可以多次添加。请确保在不需要的时候移除监听。

在新消息到来时，你会收到 `messagesDidReceive` 的回调，消息接收时可能是一条，也可能是多条。你可以在该回调里遍历消息队列，解析并显示收到的消息。

```objectivec
// 添加代理。
[[AgoraChatClient sharedClient].chatManager addDelegate:self delegateQueue:nil];

// 收到消息回调。
- (void)messagesDidReceive:(NSArray<AgoraChatMessage*> *)aMessages
{
  // 收到消息，遍历消息列表。
  for (AgoraChatMessage *message in aMessages) {
    // 消息解析和展示。
  }
}

// 移除代理。
- (void)dealloc
{
  [[AgoraChatClient sharedClient].chatManager removeDelegate:self];
}
```

### 撤回消息

消息撤回功能指用户可以撤回一定时间内自己发送出去的消息，消息撤回时限默认 2 分钟。如需调整时间限制，请联系 [sales@agora.io](mailto:sales@agora.io)。

```objectivec
[[AgoraChatClient sharedClient].chatManager recallMessageWithMessageId:@"messageId" completion:^(AgoraChatError *aError) {
        if (!aError) {
               NSLog(@"Recalling message succeeds");
           } else {
               NSLog(@"Recalling message fails — %@", aError.errorDescription);
           }
    }];
```

你还可以使用 `messagesDidRecall` 监听消息撤回状态：

```objectivec
// 收到的消息撤回时触发的回调。
- (void)messagesDidRecall:(NSArray *)aMessages;
```

### 发送和接收附件类型的消息

除文本消息外，SDK 还支持发送附件类型消息，包括语音、图片、视频和文件消息。

附件消息的发送和接收过程如下：

1. 创建和发送附件类型消息。SDK 将附件上传到声网服务器。
2. 接收附件消息。SDK 自动下载语音消息，默认自动下载图片和视频的缩略图。若下载原图、视频和文件，需调用 `downloadAttachment` 方法。
3. 获取附件的服务器地址和本地路径。 

此外，发送附件类型消息时，可以在 progress 回调中获取附件上传的进度，以百分比表示，示例代码如下：

```objectivec
// 发送消息时可以设置 completion 回调，在该回调中更新消息的显示状态。例如消息发送失败后的提示等等。
[[AgoraChatClient sharedClient].chatManager sendMessage:message progress:^(int progress) {
        // progress 为附件上传进度块的百分比。
} completion:^(AgoraChatMessage *message, AgoraChatError *error) {
    // error 为发送结果，message 为发送的消息。
}];
```

#### 发送和接收语音消息

发送和接收语音消息的过程如下：

1. 发送语音消息前，在应用层录制语音文件。
2. 发送方调用 `initWithLocalPath` 和 `initWithConversationID` 方法传入语音文件的 URI、语音时长和接收方的用户 ID（群聊或聊天室分别为群组 ID 或聊天室 ID）创建语音消息，然后调用 `sendMessage` 方法发送消息。SDK 会将文件上传至声网服务器。

```objectivec
// `localPath` 为语音文件本地资源路径，`displayName` 为附件的显示名称。
AgoraChatVoiceMessageBody *body = [[AgoraChatVoiceMessageBody alloc] initWithLocalPath:localPath displayName:displayName];
AgoraChatMessage *message = [[AgoraChatMessage alloc] initWithConversationID:toChatUsername from:fromChatUsername to:toChatUsername body:body ext:messageExt];
// 设置 `AgoraChatMessage` 类的 `ChatType` 属性。该属性的值为 `AgoraChatTypeChat`、`AgoraChatTypeGroupChat` 和 `AgoraChatTypeChatRoom`，表明该消息是单聊、群聊或聊天室消息，默认为单聊。
message.chatType = AgoraChatTypeGroupChat;
// 发送消息。
[[AgoraChatClient sharedClient].chatManager sendMessage:message progress:nil completion:nil];
```

3. 接收方收到语音消息时，自动下载语音文件。

4. 接收方收到 `messagesDidReceive` 回调，调用 `remotePath` 或 `localPath` 方法获取语音文件的服务器地址或本地路径，从而获取语音文件。

```objectivec
AgoraChatVoiceMessageBody *voiceBody = (AgoraChatVoiceMessageBody *)message.body;
// 获取语音文件在服务器的地址。
NSString *voiceRemotePath = voiceBody.remotePath;
// 本地语音文件的资源路径。
NSString *voiceLocalPath = voiceBody.localPath;
```

#### 发送和接收图片消息

发送和接收图片消息的流程如下：

1. 发送方调用 `initWithData` 和 `initWithConversationID` 方法传入图片的本地资源标志符 URI、设置是否发送原图以及接收方的用户 ID （群聊或聊天室分别为群组 ID 或聊天室 ID）创建图片消息，然后调用 `sendMessage` 方法发送该消息。SDK 会将图片上传至声网服务器，服务器自动生成图片缩略图。

```objectivec
// `imageData` 为图片本地资源，`displayName` 为附件的显示名称。
AgoraChatImageMessageBody *body = [[AgoraChatImageMessageBody alloc] initWithData:imageData displayName:displayName];
AgoraChatMessage *message = [[AgoraChatMessage alloc] initWithConversationID:toChatUsername from:fromChatUsername to:toChatUsername body:body ext:messageExt];

// 设置 `AgoraChatMessage` 类的 `ChatType` 属性。该属性的值为 `AgoraChatTypeChat`、`AgoraChatTypeGroupChat` 和 `AgoraChatTypeChatRoom`，表明该消息是单聊、群聊或聊天室消息，默认为单聊。
message.chatType = AgoraChatTypeGroupChat; 
// 发送消息。
[[AgoraChatClient sharedClient].chatManager sendMessage:message progress:nil completion:nil];
```

```objectivec
// 发送成功后，获取图片消息缩略图及附件。
AgoraChatImageMessageBody *body = (AgoraChatImageMessageBody *)message.body;
// 从服务器端获取图片文件。
NSString *remotePath = body.remotePath;
// 从服务器端获取图片缩略图。
NSString *thumbnailPath = body.thumbnailRemotePath;
// 从本地获取图片文件。
NSString *localPath = body.localPath;
// 从本地获取图片缩略图。
NSString *thumbnailLocalPath = body.thumbnailLocalPath;
```

2. 接收方收到图片消息，自动下载图片缩略图。

SDK 默认自动下载缩略图，即 `[AgoraChatClient sharedClient].options.isAutoDownloadThumbnail;` 为 `YES`。若设置为手动下载缩略图，即 `[AgoraChatClient sharedClient].options.isAutoDownloadThumbnail(NO);`，需调用 `[[AgoraChatClient sharedClient].chatManager downloadMessageThumbnail:message progress:nil completion:nil];` 下载。

3. 接收方收到 `messagesDidReceive` 回调，调用 `downloadMessageAttachment` 下载原图。

下载完成后，在回调里调用相应消息 `body` 的 `thumbnailLocalPath` 获取缩略图路径。


```objectivec
AgoraChatImageMessageBody *imageBody = (AgoraChatImageMessageBody *)message.body;
// 图片文件的本地缩略图资源路径。
NSString *thumbnailLocalPath = imageBody.thumbnailLocalPath;
```

4. 获取图片消息的附件。


```objectivec
[[AgoraChatClient sharedClient].chatManager downloadMessageAttachment:message progress:nil completion:^(AgoraChatMessage *message, AgoraChatError *error) {
            if (!error) {
                AgoraChatImageMessageBody *imageBody = (AgoraChatImageMessageBody *)message.body;
                NSString *localPath = imageBody.localPath;
            }
        }];
```

#### 发送和接收视频消息

发送和接收视频消息的流程如下：

1. 发送视频消息前，在应用层完成视频文件的选取或者录制。

2. 发送方调用 `initWithLocalPath` 方法传入视频文件的本地资源标志符、消息的显示名称和视频时长，构建视频消息体。然后，调用 `initWithConversationID` 方法传入会话 ID 和视频消息体，构建视频消息。最后，调用 `sendMessage` 方法发送消息。SDK 会将视频文件上传至声网消息服务器，自动将视频的首帧作为视频缩略图。

```objectivec
// `localPath` 为本地资源路径，`displayName` 为视频的显示名称。
AgoraChatVideoMessageBody *body = [[AgoraChatVideoMessageBody alloc] initWithLocalPath:localPath displayName:@"displayName"];
body.duration = duration;// 视频时长。

AgoraChatMessage *message = [[AgoraChatMessage alloc] initWithConversationID:toChatUsername from:fromChatUsername to:toChatUsername body:body ext:messageExt];
// 设置 `AgoraChatMessage` 类的 `ChatType` 属性。该属性的值为 `AgoraChatTypeChat`、`AgoraChatTypeGroupChat` 和 `AgoraChatTypeChatRoom`，表明该消息是单聊、群聊或聊天室消息，默认为单聊。
message.chatType = AgoraChatTypeGroupChat; 
// 发送消息。
[[AgoraChatClient sharedClient].chatManager sendMessage:message progress:nil completion:nil];
```

3. 接收方收到视频消息时，自动下载视频缩略图。

SDK 默认自动下载缩略图，即 `[AgoraChatClient sharedClient].options.isAutoDownloadThumbnail;` 为 `YES`。若设置为手动下载缩略图，即 `[AgoraChatClient sharedClient].options.isAutoDownloadThumbnail(NO);`，需调用 `[[AgoraChatClient sharedClient].chatManager downloadMessageThumbnail:message progress:nil completion:nil];` 下载。

4. 接收方收到 `messagesDidReceive` 回调，可以调用 `downloadMessageAttachment` 方法下载视频原文件。

5. 获取视频缩略图和视频原文件。

```objectivec
// 发送成功后，获取视频消息缩略图及附件。
AgoraChatVideoMessageBody *body = (AgoraChatVideoMessageBody *)message.body;
// 从服务器端获取视频文件的地址。
NSString *remotePath = body.remotePath;
// 从服务器端获取视频缩略图。
NSString *thumbnailPath = body.thumbnailRemotePath;
// 从本地获取视频文件。
NSString *localPath = body.localPath;
// 从本地获取视频缩略图。
NSString *thumbnailLocalPath = body.thumbnailLocalPath;
```

#### 发送和接收文件消息

发送和接收文件消息的流程如下：

1. 发送方调用 `initWithData` 和 `initWithConversationID` 方法传入文件的本地资源标志符和接收方的用户 ID（群聊或聊天室分别为群组 ID 或聊天室 ID）创建文件消息，然后调用 `sendMessage` 方法发送文件消息。SDK 将文件上传至声网服务器。

```objectivec
// `fileData` 为本地资源，`fileName` 为附件的显示名称。
AgoraChatFileMessageBody *body = [[AgoraChatFileMessageBody alloc] initWithData:fileData displayName:fileName];
AgoraChatMessage *message = [[AgoraChatMessage alloc] initWithConversationID:toChatUsername from:fromChatUsername to:toChatUsername body:body ext:messageExt];
// 设置 `AgoraChatMessage` 类的 `ChatType` 属性。该属性的值为 `AgoraChatTypeChat`、`AgoraChatTypeGroupChat` 和 `AgoraChatTypeChatRoom`，表明该消息是单聊、群聊或聊天室消息，默认为单聊。
message.chatType = AgoraChatTypeGroupChat;
// 发送消息。
[[AgoraChatClient sharedClient].chatManager sendMessage:message progress:nil completion:nil];
```

2. 接收方收到 `messagesDidReceive` 回调，调用 `downloadMessageAttachment` 方法下载文件。

```objectivec
[[AgoraChatClient sharedClient].chatManager downloadMessageAttachment:message progress:nil completion:^(AgoraChatMessage *message, AgoraChatError *error) {
            if (!error) {
                // 附件下载成功
            }
        }];
```

3. 调用以下方法从服务器或本地获取文件附件：

```objectivec
AgoraChatFileMessageBody *body = (AgoraChatFileMessageBody *)message.body;
// 从服务器端获取文件路径。
NSString *remotePath = body.remotePath;
// 从本地获取文件路径。
NSString *localPath = body.localPath;
```

#### 下载缩略图及附件

SDK 默认自动下载缩略图，即 `[AgoraChatClient sharedClient].options.isAutoDownloadThumbnail;` 为 `YES`。如果设置为手动下载附件，可修改 `[[AgoraChatClient sharedClient].options setIsAutoDownloadThumbnail:NO];`，需主动调用 `[[AgoraChatClient sharedClient].chatManager downloadMessageThumbnail:message progress:nil completion:nil];` 下载附件。下载完成后，调用相应消息体的 `thumbnailLocalPath` 获取缩略图路径。

```objectivec
AgoraChatImageMessageBody *body = (AgoraChatImageMessageBody *)message.body;
// 从服务器端获取图片缩略图。
NSString *thumbnailPath = body.thumbnailRemotePath;
// 从本地获取图片缩略图。
NSString *thumbnailLocalPath = body.thumbnailLocalPath;
```

对于原文件来说，语音消息收到后会自动下载语音文件。若下载原图片、视频或文件，调用 `[[AgoraChatClient sharedClient].chatManager downloadMessageThumbnail:message progress:nil completion:nil];` 方法。下载完成后，调用相应消息 body 的 `localPath` 获取附件路径。

```objectivec
AgoraChatImageMessageBody *body = (AgoraChatImageMessageBody *)message.body;
// 从本地获取文件。
NSString *localPath = body.localPath;
```

### 发送位置消息

要发送和接收位置信息，需要集成第三方地图服务。发送位置信息时，从地图服务提供商处获取该位置的经纬度信息；接收到位置信息时，提取接收到的经纬度信息，并在第三方地图上显示位置。

```objectivec
// `latitude` 为纬度，`longitude` 为经度，`address` 为具体位置内容。
AgoraChatLocationMessageBody *body = [[AgoraChatLocationMessageBody alloc] initWithLatitude:latitude longitude:longitude address:aAddress];
AgoraChatMessage *message = [[AgoraChatMessage alloc] initWithConversationID:toChatUsername
                                                      from:fromChatUsername
                                                                           to:toChatUsername
                                                                       body:body
                                                       ext:messageExt];
// 设置 `AgoraChatMessage` 类的 `ChatType` 属性。该属性的值为 `AgoraChatTypeChat`、`AgoraChatTypeGroupChat` 和 `AgoraChatTypeChatRoom`，表明该消息是单聊、群聊或聊天室消息，默认为单聊。
message.chatType = AgoraChatTypeChat;
// 若为群聊，添加以下代码。
// message.chatType = AgoraChatTypeGroupChat;
// 发送消息。
[[AgoraChatClient sharedClient].chatManager sendMessage:message
                                                                     progress:nil
                                                                   completion:nil];
```

### 发送和接收透传消息

透传消息可视为命令消息，通过发送这条命令给对方，通知对方要进行的操作，收到消息可以自定义处理。具体功能可以根据自身业务需求自定义，例如实现头像、昵称的更新等。

<div class="alert note"><li>透传消息不存入本地数据库中。<li>以 <code>em_</code> 和 <code>easemob::</code> 开头的 action 为内部字段，请勿使用。</div>

```Objective
// `action` 自定义 `NSString` 类型的命令内容。
AgoraChatCmdMessageBody *body = [[AgoraChatCmdMessageBody alloc] initWithAction:action];
AgoraChatMessage *message = [[AgoraChatMessage alloc] initWithConversationID:toChatUsername
                                                      from:fromChatUsername
                                                                           to:toChatUsername
                                                                       body:body
                                                       ext:messageExt];
message.chatType = AgoraChatTypeChat;
// 设置 `AgoraChatMessage` 类的 `ChatType` 属性。该属性的值为 `AgoraChatTypeChat`、`AgoraChatTypeGroupChat` 和 `AgoraChatTypeChatRoom`，表明该消息是单聊、群聊或聊天室消息，默认为单聊。
message.chatType = AgoraChatTypeGroupChat;
// 发送消息。
[[AgoraChatClient sharedClient].chatManager sendMessage:message
                                                                     progress:nil
                                                                   completion:nil];
```

请注意透传消息的接收方，也是由单独的回调进行通知，方便用户进行不同的处理。

```objectivec
// 收到透传消息时触发该回调。
- (void)cmdMessagesDidReceive:(NSArray *)aCmdMessages{
  for (AgoraChatMessage *message in aCmdMessages) {
        AgoraChatCmdMessageBody *body = (AgoraChatCmdMessageBody *)message.body;
        // 解析消息 body。
    }
}
```

#### 通过透传消息实现输入指示器

输入指示器显示其他用户何时输入消息。通过该功能，用户之间可进行有效沟通，增加了用户对聊天应用中交互的期待感。你可以通过透传消息实现输入指示器。

下图为输入指示器的工作原理。

![](https://web-cdn.agora.io/docs-files/1671159551013)

![img](typing_indicator.png)

监听用户 A 的输入状态。一旦有文本输入，通过透传消息将输入状态发送给用户 B，用户 B 收到该消息，了解到用户 A 正在输入文本。

- 用户 A 向用户 B 发送消息，通知其开始输入文本。
- 收到消息后，如果用户 B 与用户 A 的聊天页面处于打开状态，则显示用户 A 的输入指示器。
- 如果用户 B 在几秒后未收到用户 A 的输入，则自动取消输入指示器。

<div class="alert info"> 用户 A 可根据需要设置透传消息发送间隔。</div>

以下示例代码展示如何发送输入状态的透传消息。

```objectivec
//发送表示正在输入的透传消息
#define MSG_TYPING_BEGIN @"TypingBegin"

- (void)textViewDidChange:(UITextView *)textView
{
    long long currentTimestamp = [self getCurrentTimestamp];
    // 5 秒内不能重复发送消息
    if ((currentTimestamp - _previousChangedTimeStamp) > 5) {
        // 发送开始输入的透传消息
        [self _sendBeginTyping];
        _previousChangedTimeStamp = currentTimestamp;
    }
}

- (void)_sendBeginTyping
{
    AgoraChatCmdMessageBody *body = [[AgoraChatCmdMessageBody alloc] initWithAction:MSG_TYPING_BEGIN];
    body.isDeliverOnlineOnly = YES;
    AgoraChatMessage *message = [[AgoraChatMessage alloc] initWithConversationID:conversationId body:body ext:nil];
    message.chatType = AgoraChatTypeChat;
    [[AgoraChatClient sharedClient].chatManager sendMessage:message progress:nil completion:nil];
}

```

以下示例代码展示如何接收和解析输入状态的透传消息。

```objectivec
#define TypingTimerCountNum 10
- (void)cmdMessagesDidReceive:(NSArray *)aCmdMessages
{
    NSString *conId = self.currentConversation.conversationId;
    for (AgoraChatMessage *message in aCmdMessages) {
        if (![conId isEqualToString:message.conversationId]) {
            continue;
        }
        AgoraChatCmdMessageBody *body = (AgoraChatCmdMessageBody *)message.body;
        // 收到正在输入的透传消息
        if ([body.action isEqualToString:MSG_TYPING_BEGIN]) {
            if (_receiveTypingCountDownNum == 0) {
                [self startReceiveTypingTimer];
            }else {
                _receiveTypingCountDownNum = TypingTimerCountNum;
            }
        }

    }
}

- (void)startReceiveTypingTimer {
    [self stopReceiveTypingTimer];
    _receiveTypingCountDownNum = TypingTimerCountNum;
    _receiveTypingTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(startReceiveCountDown) userInfo:nil repeats:YES];

    [[NSRunLoop currentRunLoop] addTimer:_receiveTypingTimer forMode:UITrackingRunLoopMode];
    [_receiveTypingTimer fire];
    // 这里需更新 UI，显示“对方正在输入”
}

- (void)startReceiveCountDown
{
    if (_receiveTypingCountDownNum == 0) {
        [self stopReceiveTypingTimer];
        // 这里需更新 UI，不再显示“对方正在输入”
        
        return;
    }
    _receiveTypingCountDownNum--;
}

- (void)stopReceiveTypingTimer {
    _receiveTypingCountDownNum = 0;
    if (_receiveTypingTimer) {
        [_receiveTypingTimer invalidate];
        _receiveTypingTimer = nil;
    }
}
```

### 发送自定义消息

除了几种消息之外，你可以自己定义消息类型，方便业务处理，即首先设置一个消息类型名称，然后可添加多种自定义消息。自定义消息内容是 key，value 格式，你需要自己添加并解析该内容。

以下代码示例显示了如何创建和发送自定义消息：

```objectivec
// event 为需要传递的自定义消息事件，比如名片消息，可以设置 "userCard"； `ext` 为事件扩展字段，比如可以设置 `uid`，`nickname`，`avatar`。
AgoraChatCustomMessageBody* body = [[AgoraChatCustomMessageBody alloc] initWithEvent:@"userCard" ext:@{@"uid":aUid ,@"nickname":aNickName,@"avatar":aUrl}];
AgoraChatMessage *message = [[AgoraChatMessage alloc] initWithConversationID:toChatUsername
                                                      from:fromChatUsername
                                                                           to:toChatUsername
                                                                       body:body
                                                       ext:messageExt];
message.chatType = AgoraChatTypeChat;
// 设置 `AgoraChatMessage` 类的 `ChatType` 属性。该属性的值为 `AgoraChatTypeChat`、`AgoraChatTypeGroupChat` 和 `AgoraChatTypeChatRoom`，表明该消息是单聊、群聊或聊天室消息，默认为单聊。
message.chatType = AgoraChatTypeGroupChat;
// 发送消息。
[[AgoraChatClient sharedClient].chatManager sendMessage:message
                                                 progress:nil
                                               completion:nil];
```

### 使用消息的扩展字段

当 SDK 提供的消息类型不满足需求时，你可以通过消息扩展字段来传递自定义的内容，从而生成自己需要的消息类型。

当目前消息类型不满足用户需求时，可以在扩展部分保存更多信息，例如消息中需要携带被回复的消息内容或者是图文消息等场景。

```objectivec
AgoraChatTextMessageBody *textMessageBody = [[AgoraChatTextMessageBody alloc] initWithText:content];
// 增加自定义属性。
NSDictionary *messageExt = @{@"attribute":@"value"};
AgoraChatMessage *message = [[AgoraChatMessage alloc] initWithConversationID:toChatUsername
                                                       from:fromChatUsername
                                                                                              to:toChatUsername
                                                                                          body:textMessageBody
                                                        ext:messageExt];
message.chatType = AgoraChatTypeChat;
// 发送消息。
[[AgoraChatClient sharedClient].chatManager sendMessage:message
                                                                                           progress:nil
                                                                                       completion:nil];

// 接收消息的时候获取扩展属性。
- (void)messagesDidReceive:(NSArray *)aMessages
{
  // 收到消息，遍历消息列表。
  for (AgoraChatMessage *message in aMessages) {
     // value 为消息扩展里 attribute 字段的值。
     NSString *value = [message.ext objectForKey:@"attribute"];
  }
}
```

## 后续步骤

实现消息发送和接收后，可以参考以下文档为您的应用添加更多消息功能：

- [管理本地消息](./agora_chat_manage_message_ios)
- [从服务器检索对话和消息](./agora_chat_retrieve_message_ios)
- [消息回执](./agora_chat_message_receipt_ios)