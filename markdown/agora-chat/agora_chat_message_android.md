本文主要介绍如何通过 Agora Chat SDK 实现消息发送和接收，以及其他消息功能。

## 技术原理

Agora Chat SDK 提供 `ChatManager` 和 `Message` 类，用于发送、接收消息，实现消息已读回执，以及管理本地消息。包含的核心方法如下：

- `sendMessage`：发送消息给指定用户、群组或聊天室。
- `recallMessage`：撤回已发送的消息。
- `addMessageListener` ：添加收到消息事件监听。
- `ackConversationRead`：实现会话消息已读回执。
- `ackMessageRead`：实现指定消息已读回执。

下图展示在客户端发送和接收消息的工作流程：

![](https://web-cdn.agora.io/docs-files/1643082196337)

如上图所示，实现消息发送和接收的步骤如下：

1. 用户向你的应用服务器请求 Token，你的应用服务器返回 Token。
2. 用户 A 和用户 B 使用获得的 Token 登录 Agora Chat。
3. 用户 A 发送消息到 Agora Chat 服务器。
4. 单聊时，Agora Chat 服务器将消息给用户 B；群聊时，Agora Chat 服务器将消息投递给群内其他成员。

## 前提条件

开始前，请确保满足以下条件：

- 已[集成 Agora Chat SDK](./agora_chat_get_started_android?platform=Android#集成-agora-chat-sdk)。
- 了解消息相关限制和 Agora Chat API 的调用频率限制，详见[限制条件](./agora_chat_limitation_android?platform=Android)。

## 实现方法

### 发送文本消息

参考如下代码，实现文本消息发送：

```java
 // 创建一条文本消息，content 为消息文字内容，toChatUsername 为对方用户名或群 ID。
 ChatMessage message = ChatMessage.createTxtSendMessage(content, toChatUsername);
 // 设置聊天类型为群聊。你也可以设置为单聊 Chat 或聊天室 ChatRoom。
 message.setChatType(ChatType.GroupChat);
 // 发送消息。
 ChatClient.getInstance().chatManager().sendMessage(message);
// 发送消息时可以设置 CallBack 的实例来得到消息发送的状态。你可以在该回调中更新消息的显示状态，例如消息发送失败后的提示等。
 message.setMessageStatusCallback(new CallBack() {
     @Override
     public void onSuccess() {
         showToast("发送消息成功");
          dialog.dismiss();
     }
     @Override
     public void onError(int code, String error) {
         showToast("发送消息失败");
     }
 });
 ChatClient.getInstance().chatManager().sendMessage(message);
```

### 接收文本消息

参考如下代码，添加收到消息事件监听 `MessageListener`。

当收到消息时，SDK 会触发 `onMessageReceived` 回调。

```java
ChatClient.getInstance().chatManager().addMessageListener(msgListener);
MessageListener msgListener = new MessageListener() {

// 收到消息时，遍历消息队列，解析和显示消息。
@Override
public void onMessageReceived(List<ChatMessage> messages) {

}
};
ChatClient.getInstance().chatManager().removeMessageListener(msgListener);
```

### 发送和接收附件消息

除文本消息外，你还可以发送附件类型的消息，包括语音、图片、视频、文件。

#### 发送和接收语音消息

1. 参考如下代码，实现语音消息发送：

```java
// voiceUri 为语音文件的本地 URI，duration 为语音时长(秒)。
ChatMessage message = ChatMessage.createVoiceSendMessage(voiceUri, duration, toChatUsername);
// 设置聊天类型为群聊。你也可以设置为单聊 Chat 或聊天室 ChatRoom。
if (chatType == CHATTYPE_GROUP)
    message.setChatType(ChatType.GroupChat);
ChatClient.getInstance().chatManager().sendMessage(message);
```

2. 参考如下代码，实现语音消息接收。

```java
VoiceMessageBody voiceBody = (VoiceMessageBody) msg.getBody();
// 获取语音文件在服务器的 URI。
String voiceRemoteUrl = voiceBody.getRemoteUrl();
// 获取语音文件的本地 URI。
Uri voiceLocalUri = voiceBody.getLocalUri();
```

#### 发送和接收图片消息

参考如下代码，实现图片消息发送和接收：

```java
// 设置图片本地 URI，且不发送原图。
ChatMessage.createImageSendMessage(imageUri, false, toChatUsername);
// 设置聊天类型为群聊。你也可以设置为单聊 Chat 或聊天室 ChatRoom。
if (chatType == CHATTYPE_GROUP)
    message.setChatType(ChatType.GroupChat);
ChatClient.getInstance().chatManager().sendMessage(message);
// 收到消息时，获取图片文件和缩略图。
ImageMessageBody imgBody = (ImageMessageBody) message.getBody();
// 获取图片文件服务器 URI。
String imgRemoteUrl = imgBody.getRemoteUrl();
// 获取图片缩略图服务器 URI。
String thumbnailUrl = imgBody.getThumbnailUrl();
// 获取图片文件本地 URI。
Uri imgLocalUri = imgBody.getLocalUri();
// 获取图片缩略图本地 URI。
Uri thumbnailLocalUri = imgBody.thumbnailLocalUri();
```

-   消息接收方收到图片消息后，默认自动下载图片缩略图。
-   如需取消自动下载，调用 `ChatClient.getInstance().getOptions().setAutodownloadThumbnail(false)`，并在收到消息后主动调用 `ChatClient.getInstance().chatManager().downloadThumbnail(message)` 下载图片缩略图。

#### 发送和接收视频消息

1. 参考如下代码，实现视频消息发送：

```java
String thumbPath = getThumbPath(videoUri);
ChatMessage message = ChatMessage.createVideoSendMessage(videoUri, thumbPath, videoLength, toChatUsername);
sendMessage(message);
```

2. 参考如下代码，实现视频消息接收。

```java
// 收到视频消息时，你需要先下载附件，再打开消息。
if (message.getType() == ChatMessage.Type.VIDEO) {
  VideoMessageBody messageBody = (VideoMessageBody)message.getBody();
  // 获取视频文件 服务器 URI。
  String videoRemoteUrl = messageBody.getRemoteUrl();
  // 下载视频文件。
  ChatClient.getInstance().chatManager().downloadAttachment(message);
  // 设置下载完成回调。
  		public void onError(final int error, String message) {
			EMLog.e(TAG, "offline file transfer error:" + message);
			runOnUiThread(new Runnable() {
				@Override
				public void run() {
					if (EaseShowBigImageActivity.this.isFinishing() || EaseShowBigImageActivity.this.isDestroyed()) {
					    return;
					}
                    image.setImageResource(default_res);
                    pd.dismiss();
                    if (error == Error.FILE_NOT_FOUND) {
						Toast.makeText(getApplicationContext(), R.string.Image_expired, Toast.LENGTH_SHORT).show();
					}
				}
			});
		}

		public void onProgress(final int progress, String status) {
			EMLog.d(TAG, "Progress: " + progress);
			final String str2 = getResources().getString(R.string.Download_the_pictures_new);
			runOnUiThread(new Runnable() {
				@Override
				public void run() {
                    if (EaseShowBigImageActivity.this.isFinishing() || EaseShowBigImageActivity.this.isDestroyed()) {
                        return;
                    }
					pd.setMessage(str2 + progress + "%");
				}
			});
		}
	};

  // 发送消息时可以设置 `CallBack` 的实例来得到消息发送的状态。你可以在该回调中更新消息的显示状态，例如消息发送失败后的提示等。
	msg.setMessageStatusCallback(callback);

	ChatClient.getInstance().chatManager().downloadAttachment(msg);

  // 下载完成后，获取视频文件本地 URI。
  Uri videoLocalUri = messageBody.getLocalUri();
}
```

-   消息接收方收到视频消息后，默认自动下载视频缩略图。
-   如需取消自动下载，调用 `ChatClient.getInstance().getOptions().setAutodownloadThumbnail(false)`，并在收到消息后主动调用 `ChatClient.getInstance().chatManager().downloadThumbnail(message)` 下载视频缩略图。
-   视频缩略图下载完成后，调用 `thumbnailLocalUri` 方法获取缩略图本地 URI。

#### 发送和接收文件消息

1. 参考如下代码，实现文件消息发送：

```java
// 获取文件本地 URI。
ChatMessage message = ChatMessage.createFileSendMessage(fileLocalUri, toChatUsername);
// 设置聊天类型为群聊。你也可以设置为单聊 Chat 或聊天室 ChatRoom。
if (chatType == CHATTYPE_GROUP)    message.setChatType(ChatType.GroupChat);ChatClient.getInstance().chatManager().sendMessage(message);
```

2. 参考如下代码，实现文件消息接收。

```java
NormalFileMessageBody fileMessageBody = (NormalFileMessageBody) message.getBody();
// 获取文件服务器 URI。
String fileRemoteUrl = fileMessageBody.getRemoteUrl();
//获取文件本地 URI。
Uri fileLocalUri = fileMessageBody.getLocalUri();
```

#### 获取附件上传进度

发送附件类型消息时，在 `onProgress` 回调中获取附件上传的进度：

```java
//发送消息时可以设置 `CallBack` 的实例，来得到消息发送的状态。可以在该回调中更新消息的显示状态。例如消息发送失败后的提示等等。
 message.setMessageStatusCallback(new CallBack() {
     @Override
     public void onSuccess() {
         showToast("发送消息成功");
          dialog.dismiss();
     }
     @Override
     public void onError(int code, String error) {
         showToast("发送消息失败");
     }

 //消息发送的状态，这里只用于附件类型的消息。
     @Override
     public void onProgress(int progress, String status) {

     }
 });
 ChatClient.getInstance().chatManager().sendMessage(message);
```

#### 下载附件及缩略图

**下载缩略图**

当发送图片或视频消息时，SDK 默认生成缩略图。当接收方收到图片或视频消息时，SDK 默认下载缩略图。下载完成后，调用 `thumbnailLocalUr` 获取缩略图 URI。

```java
ImageMessageBody imgBody = (ImageMessageBody) message.getBody();
// 获取图片或视频缩略图本地 URI。
Uri thumbnailLocalUri = imgBody.thumbnailLocalUri();
```

**下载附件**
当接收方收到语音或文件消息时，SDK 默认下载附件。如需取消自动下载，则调用 `ChatClient.getInstance().getOptions().setAutodownloadThumbnail(false)`，并调用 `ChatClient.getInstance().chatManager().downloadAttachment(message)` 下载附件。下载完成后，调用 `getLocalUri` 获取附件 URI。

```java
ImageMessageBody imgBody = (ImageMessageBody) message.getBody();
// 获取图片文件本地 URI。。
Uri imgLocalUri = imgBody.getLocalUri();
```

### 发送和接收位置消息

当发送位置消息时，集成第三方的地图服务以获取到位置点的经纬度信息。当接收方收到位置消息时，将该位置的经纬度信息通过第三方地图服务展示在地图上。

```java
// 设置经度、维度和具体位置描述。
ChatMessage message = ChatMessage.createLocationSendMessage(latitude, longitude, locationAddress, toChatUsername);
// 设置聊天类型为群聊。你也可以设置为单聊 Chat 或聊天室 ChatRoom。
if (chatType == CHATTYPE_GROUP)    message.setChatType(ChatType.GroupChat);ChatClient.getInstance().chatManager().sendMessage(message);
```

### 发送和接收透传消息

透传消息相当于一条指令，通过发送指令给消息接收方，指定对方要做的行为，接收消息方可以根据业务需求自行处理该消息。

<div class="alert note"><li>透传消息不存入本地数据库中。<li>以 <code>em_</code> 和 <code>easemob::</code> 开头的 action 为内部字段，请勿使用。</div>

1. 参考以下代码，实现透传消息发送：

```java
ChatMessage cmdMsg = ChatMessage.createSendMessage(ChatMessage.Type.CMD);
// 设置聊天类型为群聊。你也可以设置为单聊 Chat 或聊天室 ChatRoom。
cmdMsg.setChatType(ChatType.GroupChat)String action="action1";
// 设置消息体。其中 action 可以自行定义。
CmdMessageBody cmdBody = new CmdMessageBody(action);String toUsername = "test1";
// 发送透传消息。
cmdMsg.setTo(toUsername);cmdMsg.addBody(cmdBody); ChatClient.getInstance().chatManager().sendMessage(cmdMsg);
```

2. 参考以下代码，添加透传消息接收回调：

```java
MessageListener msgListener = new MessageListener()
{
  // 添加收到消息回调。
  @Override
  public void onMessageReceived(List<ChatMessage> messages) {
  }
  // 添加收到透传消息回调。
  @Override
  public void onCmdMessageReceived(List<ChatMessage> messages) {
  }
}
```

### 发送和接收自定义类型消息

除以上消息类型外，你还可以通过键值对的形式自定义消息类型和消息内容。

```java
ChatMessage customMessage = ChatMessage.createSendMessage(ChatMessage.Type.CUSTOM);
// event 为需要传递的自定义消息事件，例如设置礼物消息：
event = "gift"CustomMessageBody customBody = new CustomMessageBody(event);
// params 类型为 Map<String, String>。
customBody.setParams(params);customMessage.addBody(customBody);
// 设置消息接收方用户名、群组 ID 或聊天室 ID。
customMessage.setTo(to);
// 设置聊天类型为群聊。你也可以设置为单聊 Chat 或聊天室 ChatRoom。
customMessage.setChatType(chatType);ChatClient.getInstance().chatManager().sendMessage(customMessage);
```

### 使用消息的扩展字段

当消息类型不满足需求时，你可以通过消息扩展字段来传递自定义的消息内容。

```java
ChatMessage message = ChatMessage.createTxtSendMessage(content, toChatUsername);
// 添加自定义扩展属性。
message.setAttribute("attribute1", "value");message.setAttribute("attribute2", true);
// 接收消息时获取扩展属性。
ChatClient.getInstance().chatManager().sendMessage(message);
// 获取自定义扩展属性。
message.getStringAttribute("attribute1",null);message.getBooleanAttribute("attribute2", false)
```

### 撤回消息

参考如下代码，实现消息后一定时间内的消息撤回。默认消息撤回时限为 2 分钟，如需调整请联系 [Agora 商务](mailto:sales@agora.io)。

```java
ChatClient.getInstance().chatManager().recallMessage(contextMenuMessage);
```

## 管理本地历史消息

Agora Chat SDK 将发送和接收到的消息存储在本地数据库中，支持以会话为单位管理历史消息。包含如下核心方法：

-   `loadAllConversations`：加载本地会话。
-   `deleteConversation`：删除本地会话。
-   `conversation.getUnreadMsgCount`：获取指定会话的未读消息数。
-   `chatManager.getUnreadMessageCount`：获取所有未读消息数。
-   `deleteConversation`：删除指定会话。
-   `searchMsgFromDB`：搜索本地历史消息。
-   `importMessages`：将历史消息导入到数据库中。
-   `insertMessage`：将历史消息加入指定会话中。

### 加载并获取本地会话

参考如下代码，加载并获取本地所有的会话：

```java
Map<String, Conversation> conversations = ChatClient.getInstance().chatManager().loadAllConversations();
Map<String, Conversation> conversations = ChatClient.getInstance().chatManager().getAllConversations();
```

### 获取指定会话中的消息

参考如下代码，从本地数据库中获取指定会话中的消息：

```java
Conversation conversation = ChatClient.getInstance().chatManager().getConversation(username);
// 获取指定会话中的所有消息
List<ChatMessage> messages = conversation.getAllMessages();
// SDK 初始化时仅加载一条消息，因此需要加载数据库中更多消息。
List<ChatMessage> messages = conversation.loadMoreMsgFromDB(startMsgId, pagesize);
```

### 获取指定会话的未读消息数量

参考如下代码，获取指定会话的未读消息数量：

```java
Conversation conversation = ChatClient.getInstance().chatManager().getConversation(username);
conversation.getUnreadMsgCount();
```

### 获取所有会话的未读消息数量

参考如下代码，获取应用中所有会话的未读消息数量：

```java
ChatClient.getInstance().chatManager().getUnreadMessageCount();
```

### 指定会话的未读消息数清零

参考如下代码，清零指定的会话或所有会话的未读消息：

```java
Conversation conversation = ChatClient.getInstance().chatManager().getConversation(username);
// 指定会话消息未读数清零。
conversation.markAllMessagesAsRead();
// 把一条消息置为已读。
conversation.markMessageAsRead(messageId);
// 所有未读消息数清零。
ChatClient.getInstance().chatManager().markAllConversationsAsRead();
```

### 删除本地会话和历史消息

参考如下代码，删除指定本地会话，或会话中指定历史消息：

```java
// 删除与指定用户的会话。
ChatClient.getInstance().chatManager().deleteConversation(username, true);
// 删除当前会话的指定历史消息。
Conversation conversation = ChatClient.getInstance().chatManager().getConversation(username);
conversation.removeMessage(deleteMsg.msgId);
```

### 搜索会话消息

参考如下代码，根据关键字对会话里的消息内容进行搜索：

```java
List<ChatMessage> messages = conversation.searchMsgFromDB(keywords, timeStamp, maxCount, from, Conversation.SearchDirection.UP);
```

### 导入历史消息到数据库

构造 `ChatMessage` 对象，将历史消息导入到本地数据库中：

```java
ChatClient.getInstance().chatManager().importMessages(msgs);
```

### 插入消息

参考如下代码，在本地会话中插入一条消息：

```java
// 在指定会话中插入消息。
Conversation conversation = ChatClient.getInstance().chatManager().getConversation(username);
conversation.insertMessage(message);
// 保存消息到数据库。
ChatClient.getInstance().chatManager().saveMessage(message);
```

## 获取服务器端历史消息

Agora Chat SDK 将历史消息存储在消息服务器中，支持以会话为单位获取历史消息。包含以下核心方法：

-   `asyncFetchConversationsFromServer`：获取在服务器中的会话列表。
-   `fetchHistoryMessages`：获取服务器中指定会话中的消息。

> Agora 建议仅在首次安装应用或本地中没有会话时调用以上方法。

### 获取会话列表

参考如下代码获取服务器中的会话列表。单次调用最多返回 100 条数据。

```java
ChatClient.getInstance().chatManager().asyncFetchConversationsFromServer(new ValueCallBack<Map<String, Conversation>>() {
    // 获取会话成功处理逻辑。
    @Override
    public void onSuccess(Map<String, Conversation> value) {
    }
    // 获取会话失败处理逻辑。
    @Override
    public void onError(int error, String errorMsg) {
    }
});
```

### 分页获取指定会话的历史消息

参考如下代码，从服务器中分页获取指定会话的历史消息，单次调用最多返回 50 条消息。

```java
try {
    ChatClient.getInstance().chatManager().fetchHistoryMessages(
            toChatUsername, EaseCommonUtils.getConversationType(chatType), pagesize, "");
    final List<ChatMessage> msgs = conversation.getAllMessages();
    int msgCount = msgs != null ? msgs.size() : 0;
    if (msgCount < conversation.getAllMsgCount() && msgCount < pagesize) {
        String msgId = null;
        if (msgs != null && msgs.size() > 0) {
            msgId = msgs.get(0).getMsgId();
        }
        conversation.loadMoreMsgFromDB(msgId, pagesize - msgCount);
    }
    messageList.refreshSelectLast();
} catch (ChatException e) {
    e.printStackTrace();
}
```

## 实现消息的已读回执和送达回执

Agora Chat SDK 支持消息投递成功后返回送达回执，以及消息接收方查看消息后返回已读回执。包含核心方法如下：

-   `setRequireDeliveryAck`：开启送达回执。
-   `ackConversationRead`：实现指定会话的已读回执。
-   `ackMessageRead`：实现指定消息的已读回执。
-   `ackGroupMessageRead`：实现群组消息的已读回执。

### 实现消息送达回执

1. 开启送达回执，实现在消息到达接收方设备时，发送方收到通知。

```java
// 设置是否需要消息送达回执，默认为 false。
options.setRequireDeliveryAck(false);
```

2. 添加收到消息送达回执时消息送达状态的事件监听。

```java
MessageListener msgListener = new MessageListener() {
    // 收到消息回调。
    @Override
      public void onMessageReceived(List<ChatMessage> messages) {
    }
    // 收到消息送达回执回调。
    @Override
      public void onMessageDelivered(List<ChatMessage> message) {
    }
};
// 移除消息监听。
ChatClient.getInstance().chatManager().removeMessageListener(msgListener);
```

### 实现消息已读回执

消息被接收方阅读后，SDK 会发送已读回执到消息发送方。

#### 实现会话已读回执

参考如下步骤，实现指定会话中所有消息的已读回执。

1. 实现会话消息已读回执。

```java
try {
    ChatClient.getInstance().chatManager().ackConversationRead(conversationId);
} catch (ChatException e) {
    e.printStackTrace();
}
```

> 该方法为异步方法。

2. 监听会话消息已读回执事件。

```java
ChatClient.getInstance().chatManager().addConversationListener(new ConversationListener() {
            ...
            @Override
            public void onConversationRead(String from, String to) {
                // 添加刷新页面通知等逻辑。
            }
        });
```

使用场景如下：

-   消息被接收方阅读，且 SDK 发送了已读回执。
-   多端多设备登录场景下，一端发送已读回执，服务器将未读消息数置为 0，同时其他端会触发 `onConversationRead` 回调。

#### 实现单条消息的已读回执

参考如下步骤，实现指定消息的已读回执：

1. 实现指定消息的已读回执。
进入会话时，发送会话已读回执 `conversation ack`：

```java
try {
	ChatClient.getInstance().chatManager().ackMessageRead(conversationId);
}catch (ChatException e) {
	e.printStackTrace();
}
```

在会话页面，可以在收到消息时，根据消息类型发送消息已读回执：

```java
ChatClient.getInstance().chatManager().addMessageListener(new MessageListener() {
    ......

    @Override
    public void onMessageReceived(List<ChatMessage> messages) {
        ......
        sendReadAck(message);
        ......
    }
    ......
});
// 发送已读回执。
public void sendReadAck(ChatMessage message) {
    // 消息未发送过已读回执且是单聊。
    if(message.direct() == ChatMessage.Direct.RECEIVE
            && !message.isAcked()
            && message.getChatType() == ChatMessage.ChatType.Chat) {
        ChatMessage.Type type = message.getType();
        //视频，语音及文件需要点击后再发送,可以根据需求进行调整。
        if(type == ChatMessage.Type.VIDEO || type == ChatMessage.Type.VOICE || type == ChatMessage.Type.FILE) {
            return;
        }
        try {
            ChatClient.getInstance().chatManager().ackMessageRead(message.getFrom(), message.getMsgId());
        } catch (ChatException e) {
            e.printStackTrace();
        }
    }
}
```

2. 监听指定消息已读事件。

```java
ChatClient.getInstance().chatManager().addMessageListener(new MessageListener() {
    ......
    @Override
    public void onMessageRead(List<ChatMessage> messages) {
        //添加刷新消息等逻辑
    }
    ......
});
```

#### 实现群组消息已读回执

当消息为群消息时，消息发送方（仅管理员和群主）可以设置此消息是否需要已读回执：

```java
ChatMessage message = ChatMessage.createTxtSendMessage(content, to);
message.setIsNeedGroupAck(true);
```
> 目前群聊已读回执功能为增值服务，如需使用请联系 [Agora 商务](mailto:sales@agora.io)。

1. 实现群组消息的已读回执。

```java
public void sendAckMessage(ChatMessage message) {
        if (!validateMessage(message)) {
            return;
        }

        if (message.isAcked()) {
            return;
        }

        // May a user login from multiple devices, so do not need to send the ack msg.
        if (ChatClient.getInstance().getCurrentUser().equalsIgnoreCase(message.getFrom())) {
            return;
        }

        try {
            if (message.isNeedGroupAck() && !message.isUnread()) {
                String to = message.conversationId(); // do not use getFrom() here
                String msgId = message.getMsgId();
                ChatClient.getInstance().chatManager().ackGroupMessageRead(to, msgId, ((TextMessageBody)message.getBody()).getMessage());
                message.setUnread(false);
                EMLog.i(TAG, "Send the group ack cmd-type message.");
            }
        } catch (Exception e) {
            EMLog.d(TAG, e.getMessage());
        }
    }
```

2. 监听群组消息已读事件。

```java
//接受到群组消息体的已读回执, 消息的接收方已经阅读此消息。
 void onGroupMessageRead(List<GroupReadAck> groupReadAcks) {
      //receive group message read ack
 }
```

接收到群组消息已读回执后，发送消息的属性 `groupAckCount` 会相应变化。

3. 获取群组消息已读回执详情。

```java
/**
  * 从服务器获取群组消息回执详情。
  * @param msgId 消息 id。
  * @param pageSize 获取的页面大小。
  * @param startAckId 已读回执的 id，如果为空，从最新的回执向前开始获取。
  * @return 返回消息列表和用于继续获取群消息回执的 Cursor。
  */
public void asyncFetchGroupReadAcks(final String msgId, final int pageSize,final String startAckId, final ValueCallBack<CursorResult<GroupReadAck>> callBack) {}
```

#### 已读回执推荐方案

Agora 推荐将会话已读回执 (`conversation ack`) 和单条消息已读回执 (`read ack`) 结合实现：

- 未启动聊天页面：收到消未读息时点击进入会话页面，消息发送方收到会话已读回执 (`conversation ack`)。
- 已经启动聊天页面：收到消息时，消息发送方收到单条消息已读回执 (`read ack`) 。