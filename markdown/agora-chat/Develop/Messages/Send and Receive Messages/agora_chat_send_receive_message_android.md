登录即时通讯 IM 后，用户可以在单聊、群聊或聊天室中发送如下类型的消息：

- 文本消息，包括超链接和表情符号。
- 附件消息，包括图片、语音、视频和文件消息。
- 位置消息。
- 透传消息。
- 自定义消息。

针对聊天室消息并发量较大的场景，即时通讯服务提供消息分级功能。你可以通过设置消息优先级，将消息划分为高、普通和低三种级别。你可以在创建消息时，将指定消息类型，或指定成员的所有消息设置为高优先级，确保此类消息优先送达。这种方式可以确保在聊天室内消息并发量较大或消息发送频率过高的情况下，服务器首先丢弃低优先级消息，将资源留给高优先级消息，确保重要消息（如打赏、公告等）优先送达，以此提升重要消息的可靠性。请注意，该功能并不保证高优先级消息必达。在聊天室内消息并发量过大的情况下，为保证用户实时互动的流畅性，即使是高优先级消息仍然会被丢弃。

本文介绍如何使用即时通讯 IM Android SDK 实现发送和接收这些类型的消息。

## 技术原理

即时通讯 IM SDK 使用 `ChatManager` 类实现消息的发送、接收和撤回。

发送和接收消息的过程如下：

1. 发送方调用相应 `create` 方法创建文本、文件、附件等类型的消息。
2. 发送方调用 `sendMessage` 发送消息。
3. 发送方可通过 `recallMessage` 撤回自己发出的消息。
4. 消息发送方调用 `addMessageListener` 监听消息事件并通过 `OnMessageReceived` 接收回调。

## 前提条件

开始前，请确保满足以下条件：

- 集成了 SDK，完成了 SDK 初始化，并且实现了账号注册和登录的功能。详见 [Android 快速开始](./agora_chat_get_started_android)。
- 了解消息相关限制，详见[消息概述](./agora_chat_message_overview)。
- 了解即时通讯 IM API 的调用频率限制，详见 [限制条件](./agora_chat_limitation)。

## 实现方法

本节介绍如何实现发送和接收各种类型的消息。

### 发送文本消息

使用 `ChatMessage` 类创建文本消息并发送消息。

```java
 // 创建一条文本消息，`content` 为消息文字内容，`conversationId` 为会话 ID，在单聊时为对端用户 ID、群聊时为群组 ID，聊天室时为聊天室 ID。
ChatMessage message = ChatMessage.createTxtSendMessage(content, conversationId);
 // 设置聊天类型为群聊。默认为单聊 `Chat`，也可以设置为聊天室 `ChatRoom`。
message.setChatType(ChatType.GroupChat);
 // 发送消息。
 ChatClient.getInstance().chatManager().sendMessage(message);
// 发送消息时可以设置 `CallBack` 的实例来获得消息发送的状态。可以在该回调中更新消息的显示状态，例如消息发送失败后的提示等。
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
 //发送消息。
 ChatClient.getInstance().chatManager().sendMessage(message);
```

对于聊天室消息，可设置消息优先级。

```java
ChatMessage message = ChatMessage.createTextSendMessage(content, toChatUsername);
message.setChatType(ChatMessage.ChatType.ChatRoom);
// 聊天室消息的优先级。如果不设置，默认值为 `Normal`，即`普通`优先级。
message.setPriority(ChatMessage.ChatRoomMessagePriority.PriorityHigh);
sendMessage(message);
```

### 接收文本消息

你可以注册 `MessageListener` 用来监听消息事件。可添加多个 `MessageListener` 监听多个事件。不再监听事件时，请及时删除监听器。

收到消息时，收件人会收到 `onMessagesReceived` 回调。每个回调包含一条或多条消息。你可以遍历消息列表，在该回调中解析和显示这些消息。

```java
ChatClient.getInstance().chatManager().addMessageListener(msgListener);
MessageListener msgListener = new MessageListener() {

// 收到消息时，遍历消息列表，解析和显示消息。
@Override
public void onMessageReceived(List<ChatMessage> messages) {

}
};
ChatClient.getInstance().chatManager().removeMessageListener(msgListener);
```

### 撤回消息

消息发送后 2 分钟之内，消息的发送方可以撤回该消息。如果需要调整可撤回时限，请联系 [support@agora.io](mailto:support@agora.io)。

```java
try {
    ChatClient.getInstance().chatManager().recallMessage(message);
    EMLog.d("TAG", "Recalling message succeeds");
} catch (ChatException e) {
    e.printStackTrace();
    EMLog.e("TAG", "Recalling message fails: "+e.getDescription());
}
```

你还可以使用 `onMessageRecalled` 监听消息撤回状态：

```java
/**
 * 接收到消息被撤回时触发此回调。
 */
void onMessageRecalled(List<ChatMessage> messages);
```

### 发送和接收附件类型的消息

除文本消息外，SDK 还支持发送附件类型消息，包括语音、图片、视频和文件消息。

附件消息的发送和接收过程如下：

1. 创建和发送附件类型消息。SDK 将附件上传到环信服务器。
2. 接收附件消息。SDK 自动下载语音消息，默认自动下载图片和视频的缩略图。若下载原图、视频和文件，需调用 `downloadAttachment` 方法。
3. 获取附件的服务器地址和本地路径。

此外，发送附件类型消息时，可以在 `onProgress` 回调中获取附件上传的进度，以百分比表示，示例代码如下：

```java
// 发送消息时可以设置 `EMCallBack` 的实例，获得消息发送的状态。可以在该回调中更新消息的显示状态。例如，消息发送失败后的提示等等。
message.setMessageStatusCallback(new CallBack() {
    @Override
    public void onSuccess() {
        // 发送消息成功
    }

    @Override
    public void onError(int code, String error) {
        // 发送消息失败
    }

    // 消息发送的状态，这里只用于附件类型的消息。
    @Override
    public void onProgress(int progress, String status) {

    }
});
// 发送消息
ChatClient.getInstance().chatManager().sendMessage(message);
```

#### 发送和接收语音消息

发送和接收语音消息的过程如下：

1. 发送语音消息前，在应用层录制语音文件。
2. 发送方调用 `createVoiceSendMessage` 方法传入语音文件的 URI、语音时长和接收方的用户 ID（群聊或聊天室分别为群组 ID 或聊天室 ID）创建语音消息，然后调用 `sendMessage` 方法发送消息。SDK 会将语音文件上传至环信服务器。

```java
// `voiceUri` 为语音文件的本地资源标志符，`duration` 为语音时长（单位为秒）。
ChatMessage message = ChatMessage.createVoiceSendMessage(voiceUri, duration, toChatUsername);
// 设置会话类型，即`EMMessage` 类的 `ChatType` 属性，包含 `Chat`、`GroupChat` 和 `ChatRoom`，表示单聊、群聊或聊天室，默认为单聊。
message.setChatType(ChatMessage.ChatType.GroupChat);
// 发送消息
ChatClient.getInstance().chatManager().sendMessage(message);
```

3. 接收方收到语音消息时，自动下载语音文件。

4. 接收方收到 `onMessageReceived` 回调，调用 `getRemoteUrl` 或 `getLocalUri` 方法获取语音文件的服务器地址或本地路径，从而获取语音文件。

```java
VoiceMessageBody voiceBody = (VoiceMessageBody) msg.getBody();
// 获取语音文件在服务器的地址。
String voiceRemoteUrl = voiceBody.getRemoteUrl();
// 本地语音文件的资源路径。
Uri voiceLocalUri = voiceBody.getLocalUri();
```

#### 发送和接收图片消息

发送和接收图片消息的流程如下：

1. 发送方调用 `createImageSendMessage` 方法传入图片的本地资源标志符 URI、设置是否发送原图以及接收方的用户 ID （群聊或聊天室分别为群组 ID 或聊天室 ID）创建图片消息，然后调用 `sendMessage` 方法发送该消息。SDK 会将图片上传至环信服务器，服务器自动生成图片缩略图。
```java
// `imageUri` 为图片本地资源标志符，`false` 为不发送原图（默认超过 100 KB 的图片会压缩后发给对方），若需要发送原图传 `true`，即设置 `original` 参数为 `true`。
ChatMessage message = ChatMessage.createImageSendMessage(imageUri, false, toChatUsername);
// 会话类型，包含 `Chat`、`GroupChat` 和 `ChatRoom`，表示单聊、群聊或聊天室，默认为单聊。
if (chatType == CHATTYPE_GROUP)
    message.setChatType(ChatType.GroupChat);
// 发送消息
ChatClient.getInstance().chatManager().sendMessage(message);
```

2. 接收方收到图片消息，自动下载图片缩略图。

SDK 默认自动下载缩略图，即 `ChatClient.getInstance().getOptions().setAutoDownloadThumbnail(true)`。若设置为手动下载缩略图，即 `ChatClient.getInstance().getOptions().setAutoDownloadThumbnail(false)`，需调用 `ChatClient.getInstance().chatManager().downloadThumbnail(message)` 下载。

3. 接收方收到 `onMessageReceived` 回调，调用 `downloadAttachment` 下载原图。

```java
@Override
public void onMessageReceived(List<ChatMessage> messages) {
    for(ChatMessage message : messages) {
        if (message.getType() == Type.IMAGE) {
            message.setMessageStatusCallback(new CallBack() {
               @Override
               public void onSuccess() {
                   // 附件下载成功
               }
               @Override
               public void onError(int code, String error) {
                   // 附件下载失败
               }

               @Override
               public void onProgress(int progress, String status) {
                   // 附件下载进度
               }

           });
           // 下载附件
           ChatClient.getInstance().chatManager().downloadAttachment(message);
        }
    }
}
```

4. 获取图片消息的缩略图和附件。

```java
ImageMessageBody imgBody = (ImageMessageBody) message.getBody();
// 从服务器端获取图片文件。
String imgRemoteUrl = imgBody.getRemoteUrl();
// 从服务器端获取图片缩略图。
String thumbnailUrl = imgBody.getThumbnailUrl();
// 从本地获取图片文件。
Uri imgLocalUri = imgBody.getLocalUri();
// 从本地获取图片缩略图。
Uri thumbnailLocalUri = imgBody.thumbnailLocalUri();
```

#### 发送和接收视频消息

发送和接收视频消息的流程如下：

1. 发送视频消息前，在应用层完成视频文件的选取或者录制。

2. 发送方调用 `createVideoSendMessage` 方法传入视频文件的本地资源标志符、缩略图的本地存储路径、视频时长以及接收方的用户 ID（群聊或聊天室分别为群组 ID 或聊天室 ID），然后调用 `sendMessage` 方法发送消息。SDK 会将视频文件上传至消息服务器。若需要视频缩略图，你需自行获取视频首帧的路径，将该路径传入 `createVideoSendMessage` 方法。

```java
// 在应用层获取视频首帧
String thumbPath = getThumbPath(videoUri);
ChatMessage message = ChatMessage.createVideoSendMessage(videoUri, thumbPath, videoLength, toChatUsername);
// 会话类型，包含 `Chat`、`GroupChat` 和 `ChatRoom`，表示单聊、群聊或聊天室，默认为单聊。
if (chatType == CHATTYPE_GROUP)
    message.setChatType(ChatType.GroupChat);
// 发送消息
ChatClient.getInstance().chatManager().sendMessage(message);
```

3. 接收方收到视频消息时，自动下载视频缩略图。

SDK 默认自动下载缩略图，即 `ChatClient.getInstance().getOptions().setAutoDownloadThumbnail(true)`。若设置为手动下载缩略图，即 `ChatClient.getInstance().getOptions().setAutoDownloadThumbnail(false)`，需调用 `ChatClient.getInstance().chatManager().downloadThumbnail(message)` 下载。

4. 接收方收到 `onMessageReceived` 回调，可以调用 `ChatClient.getInstance().chatManager().downloadAttachment(message)` 方法下载视频原文件。

```java
/**
 * 下载视频文件。
 */
private void downloadVideo(final ChatMessage message) {
    message.setMessageStatusCallback(new CallBack() {
        @Override
        public void onSuccess() {
        }

        @Override
        public void onProgress(final int progress,String status) {
        }

        @Override
        public void onError(final int error, String msg) {
        }
    });
    // 下载附件
    ChatClient.getInstance().chatManager().downloadAttachment(message);
}
```

5. 获取视频缩略图和视频原文件。

```java
// 从服务器端获取视频文件。
String imgRemoteUrl = ((VideoMessageBody) body).getRemoteUrl();
// 从服务器获取视频缩略图文件。
String thumbnailUrl = ((VideoMessageBody) body).getThumbnailUrl();
// 从本地获取视频文件文件。
Uri localUri = ((VideoMessageBody) body).getLocalUri();
// 从本地获取视频缩略图文件。
Uri localThumbUri = ((VideoMessageBody) body).thumbnailLocalUri();
```

#### 发送和接收文件消息

发送和接收文件消息的流程如下：

1. 发送方调用 `createFileSendMessage` 方法传入文件的本地资源标志符和接收方的用户 ID（群聊或聊天室分别为群组 ID 或聊天室 ID）创建文件消息，然后调用 `sendMessage` 方法发送文件消息。SDK 将文件上传至环信服务器。

```java
// `fileLocalUri` 为本地资源标志符。
ChatMessage message = ChatMessage.createFileSendMessage(fileLocalUri, toChatUsername);
// 如果是群聊，设置 `ChatType` 为 `GroupChat`，该参数默认是单聊（`Chat`）。
if (chatType == CHATTYPE_GROUP)    
    message.setChatType(ChatType.GroupChat);
// 发送消息
ChatClient.getInstance().chatManager().sendMessage(message);
```

2. 接收方收到 `onMessageReceived` 回调，调用 `downloadAttachment` 方法下载文件。

```java
/**
 * 下载视频文件。
 */
private void downloadFile(final ChatMessage message) {
    message.setMessageStatusCallback(new CallBack() {
        @Override
        public void onSuccess() {
        }

        @Override
        public void onProgress(final int progress,String status) {
        }

        @Override
        public void onError(final int error, String msg) {
        }
    });
    // 下载附件
    ChatClient.getInstance().chatManager().downloadAttachment(message);
}
```

3. 调用以下方法从服务器或本地获取文件附件：

```java
NormalFileMessageBody fileMessageBody = (NormalFileMessageBody) message.getBody();
// 从服务器获取文件。
String fileRemoteUrl = fileMessageBody.getRemoteUrl();
// 从本地获取文件。
Uri fileLocalUri = fileMessageBody.getLocalUri();
```

#### 下载缩略图及附件

SDK 默认自动下载缩略图，即 `ChatClient.getInstance().getOptions().setAutoDownloadThumbnail(true)`。若设置为手动下载缩略图，即 `ChatClient.getInstance().getOptions().setAutoDownloadThumbnail(false)`，需主动调用 `ChatClient.getInstance().chatManager().downloadThumbnail(message)` 下载。下载完成后，调用相应消息 body 的 `thumbnailLocalUri()` 获取缩略图路径。

```java
// 从服务器下载缩略图。
message.setMessageStatusCallback(new CallBack() {
    @Override
    public void onSuccess() {
        ImageMessageBody imgBody = (ImageMessageBody) message.getBody();
        // 从本地获取图片缩略图。
        Uri thumbnailLocalUri = imgBody.thumbnailLocalUri();
    }
    
    @Override
    public void onProgress(final int progress,String status) {
    }
    
    @Override
    public void onError(final int error, String msg) {
    }
});
// 下载缩略图
ChatClient.getInstance().chatManager().downloadThumbnail(message);
```

对于原文件来说，语音消息收到后会自动下载语音文件。若下载原图片、视频或文件，调用 `ChatClient.getInstance().chatManager().downloadAttachment(message)` 方法。下载完成后，调用相应消息 body 的 `getLocalUri()` 获取附件路径。

例如：

```java
message.setMessageStatusCallback(new CallBack() {
    @Override
    public void onSuccess() {
        ImageMessageBody imgBody = (ImageMessageBody) message.getBody();
        // 从本地获取图片文件。
        Uri imgLocalUri = imgBody.getLocalUri();
    }

    @Override
    public void onProgress(final int progress,String status) {
    }
    
    @Override
    public void onError(final int error, String msg) {
    }
});
// 下载附件
ChatClient.getInstance().chatManager().downloadAttachment(message);
```

### 发送位置消息

要发送和接收位置信息，你需要集成第三方地图服务，获取该位置的经纬度信息；接收到位置信息时，提取接收到的经纬度信息，并在第三方地图上显示位置。

```java
// 设置经度、维度和具体位置描述。
ChatMessage message = ChatMessage.createLocationSendMessage(latitude, longitude, locationAddress, toChatUsername);
// 设置聊天类型为群聊。你也可以设置为单聊 `Chat` 或聊天室 `ChatRoom`。该参数默认是单聊（`Chat`）。
if (chatType == CHATTYPE_GROUP)    message.setChatType(ChatType.GroupChat);ChatClient.getInstance().chatManager().sendMessage(message);
```

### 发送和接收透传消息

透传消息可视为命令消息，通过发送这条命令给对方，通知对方要进行的操作，收到消息可以自定义处理。具体功能可以根据自身业务需求自定义，例如实现头像、昵称的更新等。

<div class="alert note"><li>透传消息不存入本地数据库中，所以在 UI 上不会显示。<li>以 <code>em_</code> 和 <code>easemob::</code> 开头的 action 为内部字段，请勿使用。</div>

1. 参考以下代码，实现透传消息发送：

```java
ChatMessage cmdMsg = ChatMessage.createSendMessage(ChatMessage.Type.CMD);
// 设置聊天类型为单聊、群聊或聊天室。
cmdMsg.setChatType(ChatType.GroupChat)String action="action1";
// 可自定义 action。
CmdMessageBody cmdBody = new CmdMessageBody(action);
String toUsername = "test1";
// 设置透传消息的接收方的用户 ID。
cmdMsg.setTo(toUsername);cmdMsg.addBody(cmdBody); 
ChatClient.getInstance().chatManager().sendMessage(cmdMsg);
```

请注意透传消息的接收方，也是由单独的回调进行通知，方便用户进行不同的处理。

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

#### 通过透传消息实现输入指示器

输入指示器显示其他用户何时输入消息。通过该功能，用户之间可进行有效沟通，增加了用户对聊天应用中交互的期待感。

你可以通过透传消息实现输入指示器。下图为输入指示器的工作原理。

![](https://web-cdn.agora.io/docs-files/1671159551013)

![img](typing_indicator.png)


监听用户 A 的输入状态。一旦有文本输入，通过透传消息将输入状态发送给用户 B，用户 B 收到该消息，了解到用户 A 正在输入文本。

- 用户 A 向用户 B 发送消息，通知其开始输入文本。
- 收到消息后，如果用户 B 与用户 A 的聊天页面处于打开状态，则显示用户 A 的输入指示器。
- 如果用户 B 在几秒后未收到用户 A 的输入，则自动取消输入指示器。

<div class="alert info"> 用户 A 可根据需要设置透传消息发送间隔。</div>

以下示例代码展示如何发送输入状态的透传消息。

```java
//发送表示正在输入的透传消息
EditText.addTextChangedListener(new TextWatcher() {
	@Override
	public void onTextChanged(CharSequence s, int start, int before, int count) {
    sendCmdMessage(ACTION_TYPING_BEGIN);

});	
	
public void sendCmdMessage(String action) {
        ChatMessage beginMsg = ChatMessage.createSendMessage(ChatMessage.Type.CMD);
        CmdMessageBody body = new CmdMessageBody(action);
        // 将该透传消息只发送给在线用户
        body.deliverOnlineOnly(true);
        beginMsg.addBody(body);
        beginMsg.setTo(toChatUsername);
        ChatClient.getInstance().chatManager().sendMessage(beginMsg);
    }
```

以下示例代码展示如何接收和解析输入状态的透传消息。

```java
ChatManager.getInstance().addMessageListener(new MessageListener() {

	@Override
	public void onCmdMessageReceived(List<ChatMessage> messages) {
		for (final ChatMessage msg : messages) {
            final CmdMessageBody body = (CmdMessageBody) msg.getBody();
            EMLog.i(TAG, "Receive cmd message: " + body.action() + " - " + body.isDeliverOnlineOnly());
            EaseThreadManager.getInstance().runOnMainThread(() -> {
                if(TextUtils.equals(msg.getFrom(), conversationId)) {
                     if (TextUtils.equals(action, EaseChatLayout.ACTION_TYPING_BEGIN)) {
                            binding.subTitle.setText(getString(R.string.alert_during_typing));
                            binding.subTitle.setVisibility(View.VISIBLE);
                        } else if (TextUtils.equals(action, EaseChatLayout.ACTION_TYPING_END)) {
                            setDefaultTitle();
                        }
                    if(typingHandler != null) {
                        typingHandler.removeMessages(MSG_OTHER_TYPING_END);
                        typingHandler.sendEmptyMessageDelayed(MSG_OTHER_TYPING_END, OTHER_TYPING_SHOW_TIME);
                    }
                }
            });
        }
	}
});
```

### 发送自定义类型消息

除以上消息类型外，你还可以通过键值对的形式自定义消息类型和消息内容。

以下代码示例显示了如何创建和发送自定义消息：

```java
ChatMessage customMessage = ChatMessage.createSendMessage(ChatMessage.Type.CUSTOM);
// `event` 为需要传递的自定义消息事件，例如设置礼物消息：
String event = "gift";
CustomMessageBody customBody = new CustomMessageBody(event);
// `params` 类型为 `Map<String, String>`。
customBody.setParams(params);
customMessage.addBody(customBody);
// 设置消息接收方用户名、群组 ID 或聊天室 ID。
customMessage.setTo(to);
// 设置聊天类型为群聊。你也可以设置为单聊 `Chat` 或聊天室 `ChatRoom`。
customMessage.setChatType(chatType);
ChatClient.getInstance().chatManager().sendMessage(customMessage);
```

### 使用消息的扩展字段

如果上面列出的消息类型不满足需求时，可以使用消息扩展来为消息添加属性。这可以应用于更复杂的消息传递场景。

```java
ChatMessage message = ChatMessage.createTxtSendMessage(content, toChatUsername);
// 添加自定义扩展属性。
message.setAttribute("attribute1", "value");
message.setAttribute("attribute2", true);
// 接收消息时获取扩展属性。
ChatClient.getInstance().chatManager().sendMessage(message);
// 获取自定义属性，第 2 个参数为没有此定义的属性时返回的默认值。
String attribute1 = message.getStringAttribute("attribute1",null);
boolean attribute2 = message.getBooleanAttribute("attribute2", false);
```

## 后续步骤

实现消息发送和接收后，您可以参考以下文档为您的应用添加更多消息功能：

- [管理本地消息](./agora_chat_manage_message_android)
- [从服务器获取会话和消息](./agora_chat_retrieve_message_android)
- [消息回执](./agora_chat_message_receipt_android)