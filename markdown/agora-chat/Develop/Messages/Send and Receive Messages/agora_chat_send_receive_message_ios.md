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

消息撤回功能指用户可以撤回一定时间内自己发送出去的消息，消息撤回时限默认 2 分钟。如需调整时间限制，请联系 [support@agora.io](mailto:support@agora.io)。

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

语音，图片，视频，和文件消息实际上为附件消息。发送前，需先将附件上传到消息服务器。收到语音时，会自动下载，而图片和视频会自动下载缩略图。文件消息不会自动下载附件，接收方需调用下载附件的 API，具体实现参考下文。

#### 发送和接收语音消息

发送语音消息时，应用层需要完成语音文件录制的功能，并给出语音文件的 URI 和附件的显示名称。

请参考以下代码示例来创建和发送语音消息：

```objectivec
// `localPath` 为语音文件本地资源路径，`displayName` 为附件的显示名称。
AgoraChatVoiceMessageBody *body = [[AgoraChatVoiceMessageBody alloc] initWithLocalPath:localPath
                                                           displayName:displayName];
AgoraChatMessage *message = [[AgoraChatMessage alloc] initWithConversationID:toChatUsername
                                                      from:fromChatUsername
                                                                           to:toChatUsername
                                                                       body:body
                                                       ext:nil];
message.chatType = AgoraChatTypeChat;
// 如果是群聊，设置 chatType，默认是单聊。
message.chatType = AgoraChatTypeGroupChat;
// 发送消息。
[[AgoraChatClient sharedClient].chatManager sendMessage:message
                                                                     progress:nil
                                                                   completion:nil];
```                                                           

接收方收到语音消息后，参考如下示例代码获取语音消息的附件：

```objectivec
AgoraChatVoiceMessageBody *voiceBody = (AgoraChatVoiceMessageBody *)message.body;
// 获取语音文件在服务器的地址。
NSString *voiceRemotePath = voiceBody.remotePath;
// 本地语音文件的资源路径。
NSString *voiceLocalPath = voiceBody.localPath;
```

#### 发送和接收图片消息

默认情况下，SDK 在发送之前会压缩图片文件。要发送原始文件，可以设置 `original` 为 `true`。

请参考以下代码示例创建和发送图像消息：

```objectivec
// `imageData` 为图片本地资源，`displayName` 为附件的显示名称。
AgoraChatImageMessageBody *body = [[AgoraChatImageMessageBody alloc] initWithData:imageData
                                                                  displayName:displayName];
AgoraChatMessage *message = [[AgoraChatMessage alloc] initWithConversationID:toChatUsername
                                                      from:fromChatUsername
                                                                           to:toChatUsername
                                                                       body:body
                                                       ext:messageExt];
message.chatType = AgoraChatTypeChat;
// 设置消息类型，即设置 `Message` 类的 `MessageType` 属性。
// 设置该属性的值为 `Chat`、`Group` 和 `Room`，分别代表该消息是单聊、群聊或聊天室消息，默认为单聊。
message.chatType = AgoraChatTypeGroupChat;
// 发送消息。
[[AgoraChatClient sharedClient].chatManager sendMessage:message
                                                                     progress:nil
                                                                   completion:nil];
```

当收件人收到消息时，参考以下代码示例获取图片消息的缩略图和附件文件：

```objectivec
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

如果在接收方客户端 `[AgoraChatClient sharedClient].options.isAutoDownloadThumbnail` 设置为 `YES`，SDK 收到消息后会自动下载缩略图。若该选项设置为 `false`，需要调用 `[[AgoraChatClient sharedClient].chatManager downloadMessageThumbnail:message progress:nil completion:nil];` 下载缩略图并从 `messageBody` 的 `thumbnailLocalPath` 中获取缩略图路径。

#### 发送和接收视频消息

发送视频消息时，应用层需要完成视频文的捕获或者录制。视频消息支持输入视频的首帧作为缩略图，也支持给出视频的时长作为参数，发送给接收方。

请参考以下代码示例来创建和发送视频消息：

```objectivec
// `localPath` 为本地资源路径，`displayName` 为视频的显示名称。
AgoraChatVideoMessageBody *body = [[AgoraChatVideoMessageBody alloc] initWithLocalPath:localPath displayName:@"displayName"];
body.duration = duration;// 视频时长。

AgoraChatMessage *message = [[AgoraChatMessage alloc] initWithConversationID:toChatUsername
                                                      from:fromChatUsername
                                                                           to:toChatUsername
                                                                       body:body
                                                       ext:messageExt];
message.chatType = AgoraChatTypeChat;
// 将会话类型设置为群聊，也可设置为单聊或聊天室，默认为单聊。
message.chatType = AgoraChatTypeGroupChat;
// 发送消息。
[[AgoraChatClient sharedClient].chatManager sendMessage:message
                                                                     progress:nil
                                                                   completion:nil];
```
默认情况下，当接收方收到消息时，SDK 下载视频消息的缩略图。

若你要手动下载视频缩略图，需将 `[AgoraChatClient sharedClient].options.isAutoDownloadThumbnail;` 设置为 `NO`，主动调用 `[[AgoraChatClient sharedClient].chatManager downloadMessageThumbnail:message progress:nil completion:nil];` 下载缩略图，并从 `messageBody` 的 `thumbnailLocalPath` 获取视频缩略图路径。

```objectivec
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

请参考以下代码示例创建、发送和接收文件消息：

```objectivec
// `fileData` 为本地资源，`fileName` 为附件的显示名称。
AgoraChatFileMessageBody *body = [[AgoraChatFileMessageBody  initWithData:fileData
                                                                   displayName:fileName];
AgoraChatMessage *message = [[AgoraChatMessage alloc] initWithConversationID:toChatUsername
                                                      from:fromChatUsername
                                                                         to:toChatUsername
                                                                       body:body
                                                       ext:messageExt];
message.chatType = AgoraChatTypeChat;
// 将会话类型设置为群聊，也可设置为单聊或聊天室，默认为单聊。
message.chatType = AgoraChatTypeGroupChat;
// 发送消息。
[[AgoraChatClient sharedClient].chatManager sendMessage:message
                                                                     progress:nil
                                                                   completion:nil];
```

发送文件消息时，可以在 progress 回调中获取附件上传的进度，以百分比表示，示例代码如下：

```objectivec
// 发送消息时可以设置 `CallBack` 的实例，获得消息发送的状态。可以在该回调中更新消息的显示状态。例如消息发送失败后的提示等等。
[[AgoraChatClient sharedClient].chatManager sendMessage:message progress:^(int progress) {
        // progress 为附件上传进度块的百分比。
} completion:^(AgoraChatMessage *message, AgoraChatError *error) {
    // error 表示发送结果，message 表示发送的消息。
}];
```

当接收方收到消息时，参考以下代码示例获取附件文件：

```objectivec
AgoraChatFileMessageBody *body = (AgoraChatFileMessageBody *)message.body;
// 从服务器端获取附件文件。
NSString *remotePath = body.remotePath;
// 从本地获取附件文件。
NSString *localPath = body.localPath;
```

### 发送和接收位置消息

要发送和接收位置信息，需要集成第三方地图服务。发送位置信息时，从地图服务提供商处获取该位置的经纬度信息；接收到位置信息时，提取接收到的经纬度信息，并在第三方地图上显示位置。

```objectivec
// `latitude` 为纬度，`longitude` 为经度，`address` 为具体位置内容。
AgoraChatLocationMessageBody *body = [[AgoraChatLocationMessageBody alloc] initWithLatitude:latitude longitude:longitude address:aAddress];
AgoraChatMessage *message = [[AgoraChatMessage alloc] initWithConversationID:toChatUsername
                                                      from:fromChatUsername
                                                                           to:toChatUsername
                                                                       body:body
                                                       ext:messageExt];
// 将会话类型设置单聊，也可设置为群聊或聊天室，默认为单聊。
message.chatType = AgoraChatTypeChat;
// 将会话类型设置为群聊。
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
// 将会话类型设置为群聊，也可设置为单聊或聊天室，默认为单聊。
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
// 将会话类型设置为群聊，也可设置为单聊或聊天室，默认为单聊。
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
- [消息回执](./agora_chat_message_receipt_android)