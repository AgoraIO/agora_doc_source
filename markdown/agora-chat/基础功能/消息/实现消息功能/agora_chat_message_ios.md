本文主要介绍如何通过 Agora Chat SDK 实现消息发送和接收，以及其他消息功能。

## 技术原理

Agora Chat SDK 提供 `ChatManager` 和 `Message` 类，用于发送、接收消息，实现消息已读回执，以及管理本地消息。包含的核心方法如下：

-   `sendMessage`：发送消息给指定用户、群组或聊天室。
-   `recallMessage`：撤回已发出的消息。
-   `addMessageListener` ：添加收到消息事件监听。
-   `ackConversationRead`：实现会话消息已读回执。
-   `ackMessageRead`：实现指定消息已读回执。

下图展示在客户端发送和接收消息的工作流程：

![](https://web-cdn.agora.io/docs-files/1643082196337)

如上图所示，实现消息发送和接收的步骤如下：

1. 用户向你的应用服务器请求 Token，你的应用服务器返回 Token。
2. 用户 A 和用户 B 使用获得的 Token 登录 Agora Chat。
3. 用户 A 发送消息到 Agora Chat 服务器。
4. 单聊时，Agora Chat 服务器将消息给用户 B；群聊时，Agora Chat 服务器将消息投递给群内其他成员。

## 前提条件

开始前，请确保满足以下条件：

- 已[集成 Agora Chat SDK](./agora_chat_get_started_ios?platform=iOS#集成-agora-chat-sdk)。
- 了解消息相关限制和 Agora Chat API 的调用频率限制，详见[限制条件](./agora_chat_limitation_ios?platform=iOS)。

## 实现方法

### 发送文本消息

参考如下代码，实现文本消息发送：

```objective-c
// 创建一条文本消息，content 为消息文字内容，toChatUsername 为对方用户名或群 ID。
TextMessageBody *textMessageBody = [[TextMessageBody alloc] initWithText:content];
Message *message = [[Message alloc] initWithConversationID:toChatUsername from:fromChatUsername to:toChatUsername body:textMessageBody ext:messageExt];
// 设置聊天类型为群聊。你也可以设置为单聊 Chat 或聊天室 ChatRoom。
message.chatType = AgoraChatTypeGroupChat;
// 发送消息。
[[AgoraChatClient sharedClient].chatManager sendMessage:message progress:nil completion:nil];
// 发送消息时可以设置 `CallBack` 的实例来得到消息发送的状态。你可以在该回调中更新消息的显示状态，例如消息发送失败后的提示等。
[[AgoraChatClient sharedClient].chatManager sendMessage:message progress:nil completion:^(Message *message, AgoraError *error) {
    if (!error) {
        //发送消息成功！
    } else {
        //发送消息失败！
    }
}];
```

### 接收文本消息

参考如下代码，添加收到消息事件监听 `AgoraChatManagerDelegate`。

当收到消息时，SDK 会触发 `messagesDidReceive` 回调。

```objective-c
// 添加代理。
[[AgoraChatClient sharedClient].chatManager addDelegate:self delegateQueue:nil];

// 收到消息回调。
- (void)messagesDidReceive:(NSArray *)aMessages
{
	// 收到消息后，遍历消息列表。
	for ( Message *message in aMessages )
	{
		// 解析和显示消息。
	}
}

// 移除代理。
- (void)dealloc
{
	[[AgoraChatClient sharedClient].chatManager removeDelegate:self];
}
```

### 发送和接收附件消息

除文本消息外，你还可以发送附件类型的消息，包括语音、图片、视频、文件。

#### 发送和接收语音消息

1. 参考如下代码，实现语音消息发送：

```objective-c
// localPath 为语音文件的本地路径，displayName 为语音文件名称。
VoiceMessageBody *body = [[VoiceMessageBody alloc] initWithLocalPath:localPath
			  displayName:displayName];
Message *message = [[Message alloc] initWithConversationID:toChatUsername
		    from:fromChatUsername
		    to:toChatUsername
		    body:body
		    ext:messageExt];
message.chatType = AgoraChatTypeChat;
// 设置聊天类型为群聊。你也可以设置为单聊 Chat 或聊天室 ChatRoom。
message.chatType = AgoraChatTypeGroupChat;
// 发送消息。
[[AgoraChatClient sharedClient].chatManager sendMessage:message
 progress:nil
 completion:nil];
```

2. 参考如下代码，实现语音消息接收：

```objective-c
VoiceMessageBody *voiceBody = (VoiceMessageBody *) message.body;
// 获取语音文件在服务器的地址。
NSString *voiceRemotePath = voiceBody.remotePath;
// 获取语音文件的本地路径。
NSString *voiceLocalPath = voiceBody.localPath;
```

#### 发送图片消息

参考如下代码，实现图片消息发送和接收：

```objective-c
// imageData 为图片本地路径，displayName 为图片文件名称。
ImageMessageBody *body = [[ImageMessageBody alloc] initWithData:imageData
			  displayName:displayName];
Message *message = [[Message alloc] initWithConversationID:toChatUsername
		    from:fromChatUsername
		    to:toChatUsername
		    body:body
		    ext:messageExt];
message.chatType = AgoraChatTypeChat;
// 设置聊天类型为群聊。你也可以设置为单聊 Chat 或聊天室 ChatRoom。
message.chatType = AgoraChatTypeGroupChat;
// 发送消息。
[[AgoraChatClient sharedClient].chatManager sendMessage:message
 progress:nil
 completion:nil];
// 收到消息时，获取图片文件和缩略图。
ImageMessageBody *body = (ImageMessageBody *) message.body;
// 从服务器获取图片文件。
NSString *remotePath = body.remotePath;
// 从服务器获取图片缩略图。
NSString *thumbnailPath = body.thumbnailRemotePath;
// 从本地获取图片文件。
NSString *localPath = body.localPath;
// 从本地获取图片缩略图。
NSString *thumbnailLocalPath = body.thumbnailLocalPath;
```

-   消息接收方收到图片消息后，默认自动下载图片缩略图。
-   如需取消自动下载，调用 `AgoraChatClient sharedClient.options.isAutoDownloadThumbnail(false)`，并在收到消息后主动调用 `AgoraChatClient sharedClient.chatManager downloadMessageThumbnail:message progress:nil completion:nil` 下载图片缩略图。

#### 发送和接收视频消息

发送视频消息时，应用层需要完成视频文件的选取或者录制。视频消息支持输入视频的首帧作为缩略图，也支持给出视频的时长作为参数，发送给接收方。

```objective-c
// localPath 为视频文件本地路径，displayName 为视频文件名称。
VideoMessageBody *body = [[VideoMessageBody alloc] initWithLocalPath:localPath displayName:@"displayName"];
// 视频时长。 
body.duration = duration;

Message *message = [[Message alloc] initWithConversationID:toChatUsername
		    from:fromChatUsername
		    to:toChatUsername
		    body:body
		    ext:messageExt];
message.chatType = AgoraChatTypeChat;
// 设置聊天类型为群聊。你也可以设置为单聊 Chat 或聊天室 ChatRoom。
message.chatType = AgoraChatTypeGroupChat;
// 发送消息。
[[AgoraChatClient sharedClient].chatManager sendMessage:message
 progress:nil
 completion:nil];
// 收到视频消息后，获取视频缩略图及视频文件。
VideoMessageBody *body = (VideoMessageBody *) message.body;
// 从服务器获取视频文件地址。
NSString *remotePath = body.remotePath;
// 从服务器获取视频缩略图地址。
NSString *thumbnailPath = body.thumbnailRemotePath;
// 从本地获取视频文件路径。
NSString *localPath = body.localPath;
// 从本地获取视频缩略图路径。
NSString *thumbnailLocalPath = body.thumbnailLocalPath;
```

-   消息接收方收到视频消息后，默认自动下载视频缩略图。
-   如需取消自动下载，调用 `AgoraChatClient sharedClient.options.isAutoDownloadThumbnail(false)`，并在收到消息后主动调用 `AgoraChatClient sharedClient.chatManager downloadMessageThumbnail:message progress:nil completion:nil` 下载视频缩略图。

#### 发送和接收文件消息

1. 参考如下代码，实现文件消息发送：

```objective-c
// fileData 为本地资源，fileName 为附件显示名称。
EMFileMessageBody *body = [[EMFileMessageBody alloc] initWithData:fileData displayName:fileName]; Message *message = [[Message alloc initWithConversationID:toChatUsername from:fromChatUsername to:toChatUsername body:body ext:messageExt]; message.chatType = AgoraChatTypeChat;
// 设置聊天类型为群聊。你也可以设置为单聊 Chat 或聊天室 ChatRoom。
														      message.chatType = AgoraChatTypeGroupChat;
// 发送消息。
														      [[AgoraChatClient sharedClient].chatManager sendMessage:messag progress:nil completion:nil];
```

2. 参考如下代码，实现文件消息接收：

```objective-c
FileMessageBody *body = (FileMessageBody *) message.body;
// 从服务器获取文件地址。
NSString *remotePath = body.remotePath;
// 从本地获取文件路径。
NSString *localPath = body.localPath;
```

#### 获取附件上传进度

发送附件类型消息时，在 `Progress` 回调中获取附件上传的进度：

```objective-c
// 发送消息时可以设置 EMCallBack 的实例，来得到消息发送的状态。可以在该回调中更新消息的显示状态。例如消息发送失败后的提示等等。
[[AgoraChatClient sharedClient].chatManager sendMessage:message progress:^(int progress) {
               // 附件上传进度百分比
 } completion:^(Message * message, AgoraError * error) {
                // 发送消息内容和错误处理逻辑 
 }];
```

#### 下载缩略图及附件

**下载缩略图**

当发送图片或视频消息时，SDK 默认生成缩略图。当接收方收到图片或视频消息时，SDK 默认下载缩略图。下载完成后，调用 `thumbnailLocalPath` 获取缩略图 URI。

```objective-c
ImageMessageBody *body = (ImageMessageBody *) message.body;
// 从服务器端获取图片缩略图。 
NSString *thumbnailPath = body.thumbnailRemotePath;
// 从本地获取图片缩略图。
NSString *thumbnailLocalPath = body.thumbnailLocalPath;
```

**下载附件**

当接收方收到语音或文件消息时，SDK 默认下载附件。如需取消自动下载，则调用 `AgoraChatClient sharedClient.options.isAutoDownloadMessageThumbnail(false)`，并调用 `AgoraChatClient sharedClient.chatManager downloadMessageThumbnail:message progress:nil completion:nil` 下载附件。
下载完成后，调用 `LocalPath` 获取附件本地路径：

```objective-c
ImageMessageBody *body = (ImageMessageBody *) message.body;
// 从本地获取图片文件路径。
NSString *localPath = body.localPath;
```

### 发送位置消息

当发送位置消息时，集成第三方的地图服务以获取到位置点的经纬度信息。当接收方收到位置消息时，将该位置的经纬度信息通过第三方地图服务展示在地图上。

```objective-c
// latitude 为纬度，longitude 为经度，address 为具体位置描述。
LocationMessageBody	*body		= [[LocationMessageBody alloc] initWithLatitude:latitude longitude:longitude address:aAddress];
Message			*message	= [[Message alloc] initWithConversationID:toChatUsername
					   from:fromChatUsername
					   to:toChatUsername
					   body:body
					   ext:messageExt];
message.chatType = AgoraChatTypeChat;
// 设置聊天类型为群聊。你也可以设置为单聊 Chat 或聊天室 ChatRoom。
message.chatType = AgoraChatTypeGroupChat;
// 发送消息。
[[AgoraChatClient sharedClient].chatManager sendMessage:message
 progress:nil
 completion:nil];
```

### 发送透传消息

透传消息相当于一条指令，通过发送指令给消息接收方，指定对方要做的行为，接收消息方可以根据业务需求自行处理该消息。

<div class="alert note"><li>透传消息不存入本地数据库中。<li>以 <code>em_</code> 和 <code>easemob::</code> 开头的 action 为内部字段，请勿使用。</div>

1. 参考以下代码，实现透传消息发送：

```objective-c
// action 为自定义 NSString 类型的命令内容。
CmdMessageBody	*body		= [[CmdMessageBody alloc] initWithAction:action];
Message		*message	= [[Message alloc] initWithConversationID:toChatUsername
				   from:fromChatUsername
				   to:toChatUsername
				   body:body
				   ext:messageExt];
message.chatType = AgoraChatTypeChat;
// 设置聊天类型为群聊。你也可以设置为单聊 Chat 或聊天室 ChatRoom。
message.chatType = AgoraChatTypeGroupChat;
// 发送消息。
[[AgoraChatClient sharedClient].chatManager sendMessage:message
 progress:nil
 completion:nil];
```

2. 参考以下代码，添加透传消息接收回调：

```objective-c
// 添加收到透传消息回调。
- (void)cmdMessagesDidReceive:(NSArray *)aCmdMessages
{
	for ( Message *message in aCmdMessages )
	{
		CmdMessageBody *body = (CmdMessageBody *) message.body;
		// 解析透传消息体。
	}
}
```

### 发送自定义类型消息

除以上消息类型外，你还可以通过键值对的形式自定义消息类型和消息内容。

```objective-c
// event 为需要传递的自定义消息事件，比如名片消息，可以设置 "userCard"； ext 为事件扩展字段，比如可以设置 uid、nickname、avatar。
CustomMessageBody	* body		= [[CustomMessageBody alloc] initWithEvent:@"userCard" ext:@ { @"uid":aUid, @"nickname":aNickName, @"avatar":aUrl }];
Message			*message	= [[Message alloc] initWithConversationID:toChatUsername
					   from:fromChatUsername
					   to:toChatUsername
					   body:body
					   ext:messageExt];
message.chatType = AgoraChatTypeChat;
// 设置聊天类型为群聊。你也可以设置为单聊 Chat 或聊天室 ChatRoom。
message.chatType = AgoraChatTypeGroupChat;
// 发送消息。
[[AgoraChatClient sharedClient].chatManager sendMessage:message
 progress:nil
 completion:nil];
```

### 使用消息的扩展字段

当消息类型不满足需求时，你可以通过消息扩展字段来传递自定义的消息内容。

```objective-c
TextMessageBody *textMessageBody = [[TextMessageBody alloc] initWithText:content];
// 添加自定义扩展属性。
NSDictionary	*messageExt = @ { @"attribute" : @"value" };
Message		*message = [[Message alloc] initWithConversationID:toChatUsername
			    from:fromChatUsername
			    to:toChatUsername
			    body:textMessageBody
			    ext:messageExt];
message.chatType = AgoraChatTypeChat;
// 发送消息。 
[[AgoraChatClient sharedClient].chatManager sendMessage:message
 progress:nil
 completion:nil];

// 接收消息时，获取扩展属性。
- (void)messagesDidReceive:(NSArray *)aMessages
{
	// 收到消息后，遍历消息列表。
	for ( Message *message in aMessages )
	{
		// value 为消息扩展里 attribute 字段的值。 
		NSString *value = [message.ext objectForKey:@"attribute"];
	}
}
```

### 撤回消息

1. 参考如下代码，实现消息发出后一定时间内的消息撤回。默认消息撤回时限为 2 分钟，如需调整请联系 [Agora 商务](mailto:sales@agora.io)。

```objective-c
 [[AgoraChatClient sharedClient].chatManager recallMessageWithMessageId:@"messageId" completion:^(AgoraChatError *aError) {
         if (!aError) {
                NSLog(@"撤回消息成功");
            } else {
                NSLog(@"撤回消息失败的原因 — %@", aError.errorDescription);
            }
     }];
```

2. 监听消息撤回事件。

```objective-c
/*
 *  收到消息撤回。
 *
 *  @param aMessages  撤回消息列表。
 */
- (void)messagesDidRecall:(NSArray *)aMessages;
```



## 管理本地历史消息

Agora Chat SDK 将发送和接收到的消息存储在本地数据库中，支持以会话为单位管理历史消息。包含如下核心方法：

-   `getAllConversations`：加载本地会话。
-   `deleteConversations`：删除本地会话。
-   `conversation.unreadMessagesCount`：获取指定会话的未读消息数。
-   `deleteConversation`：删除指定会话。
-   `conversation.loadMessagesStartFromId`：搜索本地历史消息。
-   `importMessages`：将历史消息导入到数据库中。
-   `insertMessage`：将历史消息加入指定会话中。

### 加载并获取本地会话

参考如下代码，加载并获取本地所有的会话：

```objective-c
NSArray *conversations = [[AgoraChatClient sharedClient].chatManager getAllConversations];
```

### 获取指定会话中的消息

参考如下代码，从本地数据库中获取指定会话中的消息：

```objective-c
// 获取指定会话。
AgoraConversation *conversation = [[AgoraChatClient sharedClient].chatManager getConversation:conversationId type:type createIfNotExist:YES];
// SDK 初始化时仅加载一条消息，因此需要加载数据库中更多消息。
NSArray<Message *> *messages = [conversation loadMessagesStartFromId:startMsgId count:count searchDirection:MessageSearchDirectionUp];
```

### 获取指定会话的未读消息数量

参考如下代码，获取指定会话的未读消息数量：

```objective-c
// 获取指定会话。 
AgoraConversation *conversation = [[AgoraChatClient sharedClient].chatManager getConversation:conversationId type:type createIfNotExist:YES];
// 获取未读消息数。
NSInteger unreadCount = conversation.unreadMessagesCount;
```

### 获取所有会话的未读消息数量

参考如下代码，获取应用中所有会话的未读消息数量：

```objective-c
NSArray		*conversations	= [[AgoraChatClient sharedClient].chatManager getAllConversations];
NSInteger	unreadCount	= 0;
for ( AgoraConversation *conversation in conversations )
{
	unreadCount += conversation.unreadMessagesCount;
}
```

### 指定会话的未读消息数清零

参考如下代码，清零指定的会话或所有会话的未读消息：

```objective-c
AgoraConversation *conversation = [[AgoraChatClient sharedClient].chatManager getConversation:conversationId type:type createIfNotExist:YES];
// 指定会话消息未读数清零。
[conversation markAllMessagesAsRead:nil];
// 把一条消息置为已读。 
[onversation markMessageAsReadWithId:messageId error:nil];
```

### 删除本地会话和历史消息

参考如下代码，删除指定本地会话，或会话中指定历史消息：

```objective-c
// 是否删除会话中的历史消息。 
[[AgoraChatClient sharedClient].chatManager deleteConversation:conversationId isDeleteMessages:YES completion:nil];
// 删除指定会话。
NSArray *conversations = @ { @"conversationID1", @"conversationID2" };
[[AgoraChatClient sharedClient].chatManager deleteConversations:conversations isDeleteMessages:YES completion:nil];
// 删除当前会话的指定历史消息。 
AgoraConversation *conversation = [[AgoraChatClient sharedClient].chatManager getConversation:conversationId type:type createIfNotExist:YES];
[conversation deleteMessageWithId:.messageId error:nil];
```

### 搜索会话消息

参考如下代码，根据关键字对会话里的消息内容进行搜索：

```objective-c
NSArray<Message *> *messages = [conversation loadMessagesWithKeyword:keyword timestamp:0 count:50 fromUser:nil searchDirection:MessageSearchDirectionDown];
```

### 导入历史消息到数据库

构造 `Message` 对象，将历史消息导入到本地数据库中：

```objective-c
[[AgoraChatClient sharedClient].chatManager importMessages:messages completion:nil];
```

### 插入消息

参考如下代码，在本地会话中插入一条消息：

```objective-c
// 在指定会话中插入消息。
AgoraConversation *conversation = [[AgoraChatClient sharedClient].chatManager getConversation:conversationId type:type createIfNotExist:YES];
[conversation insertMessage:message error:nil];
```

## 获取服务器端历史消息

Agora Chat SDK 将历史消息存储在消息服务器中，支持以会话为单位获取历史消息。包含以下核心方法：

-   `getConversationsFromServer`：获取在服务器中的会话列表。
-   `asyncFetchHistoryMessagesFromServer`：获取服务器中指定会话中的消息。

> Agora 建议仅在首次安装应用或本地中没有会话时调用以上方法。

### 获取会话列表

参考如下代码获取服务器中的会话列表。单次调用最多返回 100 条数据。

```objective-c
[[AgoraChatClient sharedClient].chatManager getConversationsFromServer:^(NSArray * aCoversations, AgoraError * aError) {
	 if ( !aError )
	 {
		 for ( AgoraConversation * conversation in aCoversations )
		 {
                         /* conversation 会话解析 */
		 }
	 }
 }];
```

### 分页获取指定会话的历史消息

参考如下代码，从服务器中分页获取指定会话的历史消息，单次调用最多返回 50 条消息。

```objective-c
[[AgoraChatClient sharedClient].chatManager asyncFetchHistoryMessagesFromServer:conversationId conversationType:conversationType startMessageId:messageId pageSize:pageSize completion:^(AgoraCursorResult * aResult, AgoraError * aError) {
	 AgoraConversation *conversation = [[AgoraChatClient sharedClient].chatManager getConversation:conversationId type:type createIfNotExist:YES];
	 [conversation loadMessagesStartFromId:messageId count:count searchDirection:MessageSearchDirectionUp completion:nil];
 }];
```

## 实现消息的已读回执和送达回执

Agora Chat SDK 支持消息投递成功后返回送达回执，以及消息接收方查看消息后返回已读回执。包含核心方法如下：

-   `enableRequireReadAck`：开启送达回执。
-   `ackConversationRead`：实现指定会话的已读回执。
-   `sendMessageReadAck`：实现指定消息的已读回执。
-   `sendGroupMessageReadAck`：实现群组消息的已读回执。

### 实现消息送达回执

1. 开启送达回执，实现在消息到达接收方设备时，发送方收到通知。

```objective-c
// 设置是否需要消息送达回执，默认为 YES。 
options.enableRequireReadAck = YES;
```

2. 添加收到消息送达回执时消息送达状态的事件监听。

```objective-c
- (void)messagesDidRead:(NSArray *)aMessages
{
	for ( EMMessage *message in aMessages )
	{
		// 消息已读处理等 
	}
}

// 移除 delegate。
[[AgoraChatClient sharedClient].chatManager removeDelegate:self];
```

### 实现消息已读回执

消息被接收方阅读后，SDK 会发送已读回执到消息发送方。

#### 实现会话已读回执

参考如下步骤，实现指定会话中所有消息的已读回执。

1. 实现会话消息已读回执。

```objective-c
[[AgoraChatClient sharedClient].chatManager ackConversationRead:conversationId completion:nil];
```

2. 监听会话消息已读回执事件。

```objective-c
- (void)onConversationRead:(NSString *)from to:(NSString *)to
{
	// 添加刷新页面通知等逻辑。
}
```
使用场景如下：
- 消息被接收方阅读，且 SDK 发送了已读回执。
- 多端多设备登录场景下，一端发送已读回执，服务器将未读消息数置为 0，同时其他端会触发 `onConversationRead` 回调。

#### 实现单个消息的已读回执

参考如下步骤，实现指定消息的已读回执：

1. 实现指定消息的已读回执。进入会话时，发送会话已读回执 `conversation ack`：

```objective-c
[[AgoraChatClient sharedClient].chatManager sendMessageReadAck:messageId toUser:conversationId completion:nil];
}
```
在会话页面，可以在接收到消息时，根据消息类型发送消息已读回执 `read ack`：

```objective-c
// 收到消息回调。
- (void)messagesDidReceive:(NSArray *)aMessages
{
	for ( Message *message in aMessages )
	{
		// 发送消息已读回执。 
		[self sendReadAckForMessage:message];
	}
}


// 发送已读回执。
- (void)sendReadAckForMessage:(Message *)aMessage
{
	// 接收消息。
	if ( aMessage.direction == EMMessageDirectionSend || aMessage.isReadAcked || aMessage.chatType != EMChatTypeChat )
		return;

	MessageBody *body = aMessage.body;
	// 视频、语音及文件消息需要点击后再发送，可以根据需求进行调整。 
	if ( body.type == MessageBodyTypeFile || body.type == MessageBodyTypeVoice || body.type == MessageBodyTypeImage )
		return;

	[[AgoraChatClient sharedClient].chatManager sendMessageReadAck:aMessage.messageId toUser:aMessage.conversationId completion:nil];
}
```

2. 监听指定消息已读事件。

```objective-c
// 收到已读回执。
- (void)messagesDidRead:(NSArray *)aMessages
{
	for ( Message *message in aMessages )
	{
		// 添加刷新页面通知等逻辑。
	}
}
```

#### 实现群组消息已读回执

当消息为群消息时，消息发送方（仅管理员和群主）可以设置此消息是否需要已读回执：

```objective-c
Message *message = [[Message alloc] initWithConversationID:to from:from to:to body:aBody ext:aExt];
message.isNeedGroupAck = YES;
```

> 目前群聊已读回执功能为增值服务，如需使用请联系 [Agora 商务](mailto:sales@agora.io)。

1. 实现群组消息的已读回执。

```objective-c
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

2. 监听群组消息已读事件。

```objective-c
// 群组消息的已读回调。 
- (void)groupMessageDidRead:(Message *)aMessage groupAcks:(NSArray *)aGroupAcks
{
	for ( GroupMessageAck *messageAck in aGroupAcks )
	{
		// 收到群组消息已读回执。
	}
}
```

接收到群组消息已读回执后，发出消息的属性 `groupAckCount` 会有相应变化；

3. 获取群组消息已读回执详情。

```objective-c
/**
 * 从服务器获取指定群已读回执。该方法为异步方法。
 *  @param  aMessageId           要获取的消息 ID
 *  @param  aGroupId             要获取回执对应的群 ID
 *  @param  aGroupAckId          要获取的群回执 ID
 *  @param  aPageSize            获取消息条数
 *  @param  aCompletionBlock     获取消息结束的 callback
 */
[[AgoraChatClient sharedClient].chatManager asyncFetchGroupMessageAcksFromServer:messageId groupId:groupId startGroupAckId:nil pageSize:pageSize completion:^(EMCursorResult * aResult, EMError * error, int totalCount) {
         // 页面刷新等操作。
 }];
```

#### 已读回执推荐方案

Agora 推荐将会话已读回执 (`conversation ack`) 和单条消息已读回执 (`read ack`) 结合实现：

-   未启动聊天页面：收到消未读息时点击进入会话页面，消息发送方收到会话已读回执 (`conversation ack`)。
-   已经启动聊天页面：收到消息时，消息发送方收到单条消息已读回执 (`read ack`) 。