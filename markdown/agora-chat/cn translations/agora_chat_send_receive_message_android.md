登录 Agora 即时通讯后，用户可以向对方用户、群组或聊天室发送以下消息类型：
- 文本消息，可以包含超链接和表情符号等。
- 附件消息，包括图片像、语音、视频、文件消息。
- 位置消息。
- 透传消息。
- 扩展消息。
- 自定义消息。

本文主要介绍如何通过 Agora Chat SDK 实现消息发送和接收。

## 技术原理

Agora Chat SDK 使用 `ChatManager` 类来实现发送、接收和撤回消息。

发送和接收消息的过程如下：

1. 消息发送方使用对应的 `create` 方法创建文本、文件或附件消息。
2. 消息发送方调用 `sendMessage` 发送消息。
3. 消息接收方调用 `addMessageListener` 监听消息事件，并在 `OnMessageReceived` 回调中接收消息。

## 前提条件

开始前，请确保满足以下条件：
- 已经集成并初始化 Agora Chat SDK，并且已经注册和登录账号。详见[实现发送和接收消息](./agora_chat_get_started_android?platform=Android)。
- 了解 Agora Chat API 的调用频率限制，详见[限制条件](./agora_chat_limitation?platform=Android)。

## 实现方法

本节介绍如何实现发送和接收各种类型的消息。

### 发送文本消息

使用 `ChatMessage` 类创建并发送文本消息。

```java
// 调用 createTextSendMessage 创建文本消息。content 为文本消息的内容，toChatUsernames 为消息接收方的用户 ID。
ChatMessage message = ChatMessage.createTxtSendMessage(content, toChatUsername);
// 使用 Message 中的 MessageType 属性设置消息类型。
// MessageType 可以设置为 Chat 表示发送至对方用户，Group 表示发送至群组，或 Room 表示发送至聊天室。
message.setChatType(ChatType.GroupChat);
 // 发送消息。
 ChatClient.getInstance().chatManager().sendMessage(message);
```

```java
// 调用 setMessageStatusCallback 设置回调实例，获取消息发送状态。可以在该回调中更新消息状态，例如在消息发送失败后添加提示。
 message.setMessageStatusCallback(new CallBack() {
     @Override
     public void onSuccess() {
         showToast("Message sending succeeds");
          dialog.dismiss();
     }
     @Override
     public void onError(int code, String error) {
         showToast("Message sending fails");
     }
 });
 ChatClient.getInstance().chatManager().sendMessage(message);
```

### 接收消息

你可以使用 `MessageListener` 来监听消息事件。添加多个 `MessageListener` 可以监听多个事件。不再监听事件时，请确保移除监听。

收到消息时，接收方会收到一个 `onMessgesReceived` 回调。每个回调包含一条或多条消息。你可以遍历消息队列，在该回调中解析和渲染消息。

```java
ChatClient.getInstance().chatManager().addMessageListener(msgListener);
MessageListener msgListener = new MessageListener() {

// 遍历消息队列，解析并渲染消息。
@Override
public void onMessageReceived(List<ChatMessage> messages) {

}
};
ChatClient.getInstance().chatManager().removeMessageListener(msgListener);
```

### 撤回消息

消息发送后两分钟内，用户可以撤回消息。如需调整时间限制，请联系 support@agora.io。

```java
try {
    ChatClient.getInstance().chatManager().recallMessage(message);
    EMLog.d("TAG", "Recalling message succeeds");
} catch (ChatException e) {
    e.printStackTrace();
    EMLog.e("TAG", "Recalling message fails: "+e.getDescription());
}
```

你可以使用 `onMessageRecall` 监听消息撤回状态：

```java
/**
 * 撤回已接收消息回调。
 */
void onMessageRecalled(List<ChatMessage> messages);
```

### 发送和接收附件消息

语音、图片、视频和文件消息都是附件消息。本节介绍如何发送附件消息。

#### 发送和接收语音消息

发送语音消息前，需要在 app 实现录音功能，提供录音文件的 URI 和时长。

参考以下代码示例，实现语音消息创建和发送：

```java
// voiceUri 为本地语音文件的 URI，duration 为语音时长（秒）。
ChatMessage message = ChatMessage.createVoiceSendMessage(voiceUri, duration, toChatUsername);
// 设置即时通讯类型为一对一单聊、多人群聊或聊天室。
if (chatType == CHATTYPE_GROUP)
    message.setChatType(ChatType.GroupChat);
ChatClient.getInstance().chatManager().sendMessage(message);
```

参考以下代码示例，获取音频文件：

```java
VoiceMessageBody voiceBody = (VoiceMessageBody) msg.getBody();
// 获取服务器上音频文件的 URL。
String voiceRemoteUrl = voiceBody.getRemoteUrl();
// 获取本地音频文件的 URI。
Uri voiceLocalUri = voiceBody.getLocalUri();
```


#### 发送和接收图片消息

默认发送消息前压缩图片文件。要发送原始图片文件，可以将 `original` 设置为 `true`。

参考以下代码示例，实现图片消息创建和发送：

```java
// imageUri 为本地图片文件的 URI。false 表示不发送原始图片。消息发送前，超过 100K 的图片文件会被压缩。
ChatMessage.createImageSendMessage(imageUri, false, toChatUsername);
// 设置即时通讯类型为一对一单聊、多人群聊或聊天室。
if (chatType == CHATTYPE_GROUP)
    message.setChatType(ChatType.GroupChat);
ChatClient.getInstance().chatManager().sendMessage(message);
```

接收方收到消息后，参考以下代码示例获取图片消息的缩略图和附件：

```java
// 获取图片文件的缩略图和附件。
ImageMessageBody imgBody = (ImageMessageBody) message.getBody();
// 从服务器获取图片文件。
String imgRemoteUrl = imgBody.getRemoteUrl();
// 从服务器获取缩略图。
String thumbnailUrl = imgBody.getThumbnailUrl();
// 获取本地图片文件的 URI。
Uri imgLocalUri = imgBody.getLocalUri();
// 获取本地图片缩略图的 URI。
Uri thumbnailLocalUri = imgBody.thumbnailLocalUri();
```

<div class="alert note">如在接收方客户端将 <code>ChatClient.getInstance().getOptions().getAutodownloadThumbnail()</code> 设置为 <code>true</code>，收到消息后会自动下载缩略图。如未设置，则需要调用 <code>ChatClient.getInstance().chatManager().downloadThumbnail(message)</code> 下载缩略图，并从 <code>messageBody</code> 中的 <code>thumbnailLocalUri</code> 成员中获取路径。</div>

#### 发送和接收视频消息

发送视频消息前，需要在 app 实现视频采集功能，提供视频文件的时长。

参考以下代码示例，实现视频消息创建和发送：

```java
String thumbPath = getThumbPath(videoUri);
ChatMessage message = ChatMessage.createVideoSendMessage(videoUri, thumbPath, videoLength, toChatUsername);
sendMessage(message);
```

默认收到消息时下载视频文件的缩略图。

如无需自动下载视频缩略图，设置`ChatClient.getInstance().getOptions().setAutodownloadThumbnail`为`false`即可。设置生效后，如需下载缩略图，调用`ChatClient.getInstance().chatManager().downloadThumbnail (message)`，并从 `messageBody` 的 `thumbnailLocalUri` 成员中获取缩略图的路径。

如需下载视频文件，调用 `SChatClient.getInstance().chatManager().downloadAttachment(message)`，从 `messageBody` 的 `getLocalUri` 成员中获取视频文件的路径。

```java
// 视频消息需要下载才能打开。
if (message.getType() == ChatMessage.Type.VIDEO) {
  VideoMessageBody messageBody = (VideoMessageBody)message.getBody();
  // 从服务器获取视频的 URL。
  String videoRemoteUrl = messageBody.getRemoteUrl();
  // 下载视频。
  ChatClient.getInstance().chatManager().downloadAttachment(message);
      // 通过回调设置知晓下载完成状态。
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
	

	

 msg.setMessageStatusCallback(callback);

	 ChatClient.getInstance().chatManager().downloadAttachment(msg);

  // 下载完成后，获取本地视频文件的 URI。
  Uri videoLocalUri = messageBody.getLocalUri();
}
```

#### 发送和接收文件消息

参考以下代码示例，实现文件消息创建和发送：

```java
// fileLocalUri 为本地文件的URI。
ChatMessage message = ChatMessage.createFileSendMessage(fileLocalUri, toChatUsername);
// 设置即时通讯类型为一对一单聊、多人群聊或聊天室。
if (chatType == CHATTYPE_GROUP) message.setChatType(ChatType.GroupChat);ChatClient.getInstance().chatManager().sendMessage(message);
```

参考以下示例代码，获取附件文件上传进度：

```java
// 调用 setMessageStatusCallback 设置回调实例，监听消息发送状态。你可以在该回调中更新消息状态。
message.setMessageStatusCallback(new CallBack() {
    @Override
    public void onSuccess() {
        showToast("Message sending succeeds");
        dialog.dismiss();
    }
    @Override
    public void onError(int code, String error) {
        showToast("Message sending fails");
    }

    // 发送消息的状态。以下仅适用于附件消息。
    @Override
    public void onProgress(int progress, String status) {

        }
});
ChatClient.getInstance().chatManager().sendMessage(message);
```

参考以下代码示例，获取附件文件：

```java
NormalFileMessageBody fileMessageBody = (NormalFileMessageBody) message.getBody();
// 从服务器获取附件文件。
String fileRemoteUrl = fileMessageBody.getRemoteUrl();
// 从本地设备获取附件文件。
URI fileLocalUri = fileMessageBody.getLocalUri();
```

### 发送位置消息

位置消息需要集成第三方地图服务。发送位置信息时，第三方地图服务提供经纬度信息。接收方接收到位置消息，可以通过接收的经纬度信息在第三方地图服务中显示位置。

```java
// 设置位置的经纬度信息。
ChatMessage message = ChatMessage.createLocationSendMessage(latitude, longitude, locationAddress, toChatUsername);
// 设置即时通讯类型为一对一单聊、多人群聊或聊天室。
if (chatType == CHATTYPE_GROUP) message.setChatType(ChatType.GroupChat);ChatClient.getInstance().chatManager().sendMessage(message);
```

### 发送和接收透传消息

透传消息指示指定用户采取特定操作。接收方自行处理透传消息。

<div class="alert note"><ul><li>透传消息不会存入本地数据库。</li><li>以 <code>em_</code> 和 <code>easemob::</code> 开头的操作为内部字段。请勿使用。</li></ul></div>

```java
ChatMessage cmdMsg = ChatMessage.createSendMessage(ChatMessage.Type.CMD);
// 设置即时通讯类型为一对一单聊、多人群聊或聊天室。
cmdMsg.setChatType(ChatType.GroupChat)String action="action1";
// 可以自定义操作。
CmdMessageBody cmdBody = new CmdMessageBody(action);String toUsername = "test1";
// 设置发送透传消息的用户名。
cmdMsg.setTo(toUsername);cmdMsg.addBody(cmdBody); ChatClient.getInstance().chatManager().sendMessage(cmdMsg);
```

如需通知接收方收到透传消息，需要单独使用代理，以便用户能以不同的方式处理消息。

```java
MessageListener msgListener = new MessageListener()
{
  // 收到消息回调。
  @Override    
  public void onMessageReceived(List<ChatMessage> messages) {
  }
  // 收到透传消息回调。
  @Override    
  public void onCmdMessageReceived(List<ChatMessage> messages) {
  }
}
```

### 发送自定义消息

自定义消息是自定义的键值对，包含消息类型和消息内容。

参考以下代码示例，实现自定义消息创建和发送：

```java
ChatMessage customMessage = ChatMessage.createSendMessage(ChatMessage.Type.CUSTOM);
// event 为自定义消息类型，例如设置为 gift。
event = "gift"CustomMessageBody customBody = new CustomMessageBody(event);
// params 的数据类型是 Map<String, String>。
customBody.setParams(params);customMessage.addBody(customBody);
// 设置接收消息的用户ID，例如即时通讯 ID、群组 ID 或聊天室 ID。
customMessage.setTo(to);
// 设置即时通讯类型为一对一单聊、多人群聊或聊天室。
customMessage.setChatType(chatType);ChatClient.getInstance().chatManager().sendMessage(customMessage);
```


### 使用消息扩展内容

如以上消息类型无法满足需求，你可以通过消息扩展内容来为消息添加属性。消息扩展内容可用于更复杂的通信场景。

```java
ChatMessage message = ChatMessage.createTxtSendMessage(content, toChatUsername);
// 添加消息属性。
message.setAttribute("attribute1", "value");message.setAttribute("attribute2", true);
// 发送消息。
ChatClient.getInstance().chatManager().sendMessage(message);

// 接收消息时获取消息属性。
message.getStringAttribute("attribute1",null);message.getBooleanAttribute("attribute2", false)
```

## 后续步骤

实现消息收发功能后，可以参考以下文档为 app 添加更多消息功能：

- [管理本地消息](./agora_chat_manage_message_android?platform=Android)
- [从服务器获取会话和消息](./agora_chat_retrieve_message_android?platform=Android)
- [消息回执](./agora_chat_message_receipt_android?platform=Android)


