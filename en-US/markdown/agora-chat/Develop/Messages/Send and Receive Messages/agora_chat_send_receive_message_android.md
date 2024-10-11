After logging in to Agora Chat, users can send the following types of messages to a peer user, a chat group, or a chat room:
- Text messages, including hyperlinks and emojis.
- Attachment messages, including image, voice, video, and file messages.
- Location messages.
- CMD messages.
- Custom messages.

In high-concurrency scenarios, you can set a certain message type or messages from a chat room member as high, normal, or low. In this case, low-priority messages are dropped first to reserve resources for the high-priority ones (e.g. gifts and announcements) when the server is overloaded. This ensures that the high-priority messages can be dealt with first when loads of messages are being sent in high concurrency or high frequency. Note that this feature can increase the delivery reliability of high-priority messages, but cannot guarantee the deliveries. Even high-priorities messages can be dropped when the server load goes too high.

This page shows how to implement sending and receiving these messages using the Agora Chat SDK.

## Understand the tech

The Agora Chat SDK uses the `ChatManager` class to send, receive, and withdraw messages.

The process of sending and receiving a message is as follows:

1. The message sender creates a text, file, or attachment message using the corresponding `create` method.
2. The message sender calls `sendMessage` to send the message.
3. The message recipient calls `addMessageListener` to listens for message events and receives the message in the `OnMessageReceived` callback.

## Prerequisites

Before proceeding, ensure that you meet the following requirements:
- You have integrated the Agora Chat SDK, initialized the SDK and implemented the functionality of registering accounts and login. For details, see [Get Started with Agora Chat](./agora_chat_get_started_android?platform=Android).
- You understand the API call frequency limits as described in [Limitations](./agora_chat_limitation?platform=Android).

## Implementation

This section shows how to implement sending and receiving the various types of messages.

### Send a text message

Use the `ChatMessage` class to create a text message, and send the message. 

```java
// Call createTextSendMessage to create a text message. 
// Set `content` as the content of the text message.
// Set `conversationId` to the user ID of the peer user in one-to-one chat, group ID in group chat, and chat room ID in room chat.
ChatMessage message = ChatMessage.createTextSendMessage(content, conversationId); 
// Set `ChatType` as `Chat`, `GroupChat`, or `ChatRoom` for one-to-one chat, group chat, or room chat.  
message.setChatType(ChatMessage.ChatType.GroupChat); 
 // Send the message. 
 ChatClient.getInstance().chatManager().sendMessage(message);
```

```java
// Call setMessageStatusCallback to set the callback instance to get the status of messaging sending. 
// You can update the status of messages in this callback, for example, adding a tip when the message sending fails.
 message.setMessageStatusCallback(new CallBack() {
     @Override
     public void onSuccess() {
         showToast("Message sending succeeds");
     }
     @Override
     public void onError(int code, String error) {
         showToast("Message sending fails");
     }
 });
 ChatClient.getInstance().chatManager().sendMessage(message);
```

You can set the priority of chat room messages. 

```java
// Set `content` as the content of the text message.
// Set `conversationId` to chat room ID in room chat.
ChatMessage message = ChatMessage.createTextSendMessage(content, conversationId);
message.setChatType(ChatMessage.ChatType.ChatRoom);
// Set the message priority. The default value is `PriorityNormal`, indicating the normal priority.
message.setPriority(ChatMessage.ChatRoomMessagePriority.PriorityHigh);
ChatClient.getInstance().chatManager().sendMessage(message);
```

### Receive a message

You can use `MessageListener` to listen for message events. You can add multiple `MessageListener`s to listen for multiple events. When you no longer listen for an event, ensure that you remove the listener.

When a message arrives, the recipient receives an `onMessagesReceived` callback. Each callback contains one or more messages. You can traverse the message list, and parse and render these messages in this callback.

```java
MessageListener msgListener = new MessageListener() {
    // Traverse the message list, and parse and render the messages.
    @Override
    public void onMessageReceived(List<ChatMessage> messages) {
    }
};
// Add a message listener
ChatClient.getInstance().chatManager().addMessageListener(msgListener);
// Remove a message listener
ChatClient.getInstance().chatManager().removeMessageListener(msgListener);
```

### Recall a message

After a message is sent, you can recall it. The `recallMessage` method recalls a message that is saved both locally and on the server, whether it is a historical message, offline message or a roaming message on the server, or a message in the memory or local database of the message sender or recipient. 

You can recall a message sent within two minutes by default. If you want to adjust the time limit, contact [support@agora.io](mailto:support@agora.io).

<div class="alert info">1. Except CMD messages, you can recall all types of message. 2. If an attachment message, like an image, voice, video, or file message, is recalled, the attachment of the message is also deleted.</div> // Add the note for all platforms/frameworks of the SDK.

```java
try {
    ChatClient.getInstance().chatManager().recallMessage(message);
    EMLog.d("TAG", "Recalling message succeeds");
} catch (ChatException e) {
    e.printStackTrace();
    EMLog.e("TAG", "Recalling message fails: "+e.getDescription());
}
```

You can also use `onMessageRecalled` to listen for the message recall state:

```java
MessageListener msgListener = new MessageListener() {

    /**
    * Occurs when a received message is recalled.
    */
    void onMessageRecalled(List<ChatMessage> messages);
};

```

### Send and receive an attachment message

Voice, image, video, and file messages are essentially attachment messages. This section introduces how to send these types of messages.

#### Send and receive a voice message

Before sending a voice message, you should implement audio recording on the app level, which provides the URI and duration of the recorded audio file.

Refer to the following code example to create and send a voice message:

```java
// Set voiceUri as the local URI of the audio file, and duration as the length of the file in seconds.
ChatMessage message = ChatMessage.createVoiceSendMessage(voiceUri, duration, conversationId); 
// Sets the chat type as one-to-one chat, group chat, or chatroom.
if (chatType == CHATTYPE_GROUP) {
    message.setChatType(ChatType.GroupChat); 
}
ChatClient.getInstance().chatManager().sendMessage(message);
```

When the recipient receives the message, refer to the following code example to get the audio file:

```java
VoiceMessageBody voiceBody = (VoiceMessageBody) msg.getBody();
// Retrieves the URL of the audio file on the server.
String voiceRemoteUrl = voiceBody.getRemoteUrl();
// Retrieves the URI if the audio file on the local device.
//If 'ChatClient.getInstance().getOptions().setAutodownloadThumbnail' is set as `false` or the attachment has not been downloaded yet, 
//the file may not exist in 'voiceLocalUri' and you can manually call 'ChatClient.getInstance().chatManager().downloadAttachment(message)' to download the attachment, 
//and call the 'message. SetMessageStatusCallback (the callback)' to see if the download succeeds.
Uri voiceLocalUri = voiceBody.getLocalUri();
```


#### Send and receive an image message

By default, the SDK compresses the image file before sending it. To send the original file, you can set `original` as `true`.

Refer to the following code example to create and send an image message:

```java
// Set imageUri as the URI of the image file on the local device. false means not to send the original image. The SDK compresses image files that exceeds 100K before sending them. 
ChatMessage.createImageSendMessage(imageUri, false, conversationId); 
// Sets the chat type as one-to-one chat, group chat, or chatroom.
if (chatType == CHATTYPE_GROUP) {
    message.setChatType(ChatType.GroupChat); 
}
ChatClient.getInstance().chatManager().sendMessage(message);
```

When the recipient receives the message, refer to the following code example to get the thumbnail and attachment file of the image message:

```java
// Retrieves the thumbnail and attachment of the image file.
ImageMessageBody imgBody = (ImageMessageBody) message.getBody();
// Retrieves the image file the server.
String imgRemoteUrl = imgBody.getRemoteUrl();
// Retrieves the image thumbnail from the server.
String thumbnailUrl = imgBody.getThumbnailUrl();
// Retrives the URI of the image file on the local device.
Uri imgLocalUri = imgBody.getLocalUri();
// Retrieves the URI of the image thumbnail on the local device.
Uri thumbnailLocalUri = imgBody.thumbnailLocalUri();
```

<div class="alert note">If <code>ChatClient.getInstance().getOptions().getAutodownloadThumbnail()</code> is set as <code>true</code> on the recipient's client, the SDK automatically downloads the thumbnail after receiving the message. If not, you need to call <code>ChatClient.getInstance().chatManager().downloadThumbnail(message)</code> to download the thumbnail and get the path from the <code>thumbnailLocalUri</code> member in <code>messageBody</code>.
If the file does not exist in <code>imgLocalUri</code>, you can manually call <code>ChatClient.getInstance().chatManager().downloadAttachment(message)</code> to download the attachment, and call the <code>message. SetMessageStatusCallback (the callback)</code>to see if the download succeeds.
</div>

#### Send and receive a video message

Before sending a video message, you should implement video capturing on the app level, which provides the duration of the captured video file.

Refer to the following code example to create and send a video message:

```java
String thumbPath = getThumbPath(videoUri);
ChatMessage message = ChatMessage.createVideoSendMessage(videoUri, thumbPath, videoLength, conversationId);
// Sets the chat type as one-to-one chat, group chat, or chatroom.
if (chatType == CHATTYPE_GROUP) {
    message.setChatType(ChatType.GroupChat); 
}
ChatClient.getInstance().chatManager().sendMessage(message);
```

By default, when the recipient receives the message, the SDK downloads the thumbnail of the video message. 

If you do not want the SDK to automatically download the video thumbnail, set `ChatClient.getInstance().getOptions().setAutodownloadThumbnail` as `false`, and to download the thumbnail, you need to call `ChatClient.getInstance().chatManager().downloadThumbnail(message)`, and get the path of the thumbnail from the `thumbnailLocalUri` member in `messageBody`.

To download the actual video file, call `ChatClient.getInstance().chatManager().downloadAttachment(message)`, and get the path of the video file from the `getLocalUri` member in `messageBody`.

```java
// If you received a message with video attachment, you need download the attachment before you open it.
if (message.getType() == ChatMessage.Type.VIDEO) {
  VideoMessageBody messageBody = (VideoMessageBody)message.getBody();
  // Set Callback to know whether the download is finished.
  final CallBack callback = new CallBack() {
        public void onSuccess() {
            EMLog.e(TAG, "onSuccess" );
            // After the download finishes onSuccess, get the URI of the local file.
            Uri videoLocalUri = messageBody.getLocalUri();
            
        }

        public void onError(final int error, String message) {
            EMLog.e(TAG, "offline file transfer error:" + message);
        }

        public void onProgress(final int progress, String status) {
            EMLog.d(TAG, "Progress: " + progress);
        }
   };
	

	message.setMessageStatusCallback(callback);

	ChatClient.getInstance().chatManager().downloadAttachment(message);
  
}
```

#### Send and receive a file message

Refer to the following code example to create, send, and receive a file message:

```java
// Set fileLocalUri as the URI of the file message on the local device.
ChatMessage message = ChatMessage.createFileSendMessage(fileLocalUri, conversationId);
// Sets the chat type as one-to-one chat, group chat, or chatroom.
if (chatType == CHATTYPE_GROUP){
    message.setChatType(ChatType.GroupChat);
} 
ChatClient.getInstance().chatManager().sendMessage(message);
```

While sending a file message, refer to the following sample code to get the progress for uploading the attachment file:

```java
// Calls setMessageStatusCallback to set the callback instance to listen for the state of messaging sending. You can update the message states in this callback.
message.setMessageStatusCallback(new CallBack() {
    @Override
    public void onSuccess() {
        showToast("Message sending succeeds");
    }
    @Override
    public void onError(int code, String error) {
        showToast("Message sending fails");
    }
     
    // The status of sending the message. This only applies to sending attachment files.
    @Override
    public void onProgress(int progress, String status) {
        
    }
});
ChatClient.getInstance().chatManager().sendMessage(message);
```

When the recipient receives the message, refer to the following code example to get the attachment file:

```java
NormalFileMessageBody fileMessageBody = (NormalFileMessageBody) message.getBody();
// Retrieves the file from the server.
String fileRemoteUrl = fileMessageBody.getRemoteUrl();
// Retrieves the file from the local device.
Uri fileLocalUri = fileMessageBody.getLocalUri();
```

<div class="alert note">If the file does not exist in fileLocalUri, you can manually call <code>ChatClient.getInstance().chatManager().downloadAttachment(message)</code> to download the attachment, and call the <code>message. SetMessageStatusCallback (the callback)</code>to see if the download succeeds.</div>

### Send a location message

To send and receive a location message, you need to integrate a third-party map service provider. When sending a location message, you get the longitude and latitude information of the location from the map service provider; when receiving a location message, you extract the received longitude and latitude information and displays the location on the third-party map.

```java
// Sets the latitude and longitude information of the address. 
ChatMessage message = ChatMessage.createLocationSendMessage(latitude, longitude, locationAddress, conversationId);
// Sets the chat type as one-to-one chat, group chat, or chatroom.
if (chatType == CHATTYPE_GROUP){
    message.setChatType(ChatType.GroupChat);
} 
ChatClient.getInstance().chatManager().sendMessage(message);
```

### Send and receive a CMD message

CMD messages are command messages that instruct a specified user to take a certain action. The recipient deals with the command messages themselves.

<div class="alert note"><ul><li>CMD messages are not stored in the local database.</li><li>Actions beginning with <code>em_</code> and <code>easemob::</code> are internal fields. Do not use them.</li></ul></div>

```java
ChatMessage cmdMsg = ChatMessage.createSendMessage(ChatMessage.Type.CMD);
// Sets the chat type as one-to-one chat, group chat, or chat room.
if (chatType == CHATTYPE_GROUP){
    cmdMsg.setChatType(ChatType.GroupChat);
} 
String action="action1";
// You can customize the action.
CmdMessageBody cmdBody = new CmdMessageBody(action);
// Sets the message recipient: user ID of the recipient for one-to-one chat, group ID for group chat, or chat room ID for a chat room.
cmdMsg.setTo(conversationId);
cmdMsg.addBody(cmdBody); 
ChatClient.getInstance().chatManager().sendMessage(cmdMsg);
```

To notify the recipient that a CMD message is received, use a separate delegate so that users can deal with the message differently.

```java
MessageListener msgListener = new MessageListener() 
{       
  // Occurs when the normal message is received 
  @Override    
  public void onMessageReceived(List<ChatMessage> messages) { 
  }        
  // Occurs when a CMD message is received 
  @Override    
  public void onCmdMessageReceived(List<ChatMessage> messages) { 
  }
}
```

### Send a customized message

The following code example shows how to create and send a customized message:

```java
ChatMessage customMessage = ChatMessage.createSendMessage(ChatMessage.Type.CUSTOM);
// Set event as the customized message type, for example, gift.
String event = "gift";
CustomMessageBody customBody = new CustomMessageBody(event);
// The data type of params is Map<String, String>.
customBody.setParams(params);
customMessage.addBody(customBody);
// Sets the message recipient: user ID of the recipient for one-to-one chat, group ID for group chat, or chat room ID for a chat room.
customMessage.setTo(to);
// Sets the chat type as one-to-one chat, group chat, or chat room
customMessage.setChatType(chatType);
ChatClient.getInstance().chatManager().sendMessage(customMessage);        
```


### Use message extensions

If the message types listed above do not meet your requirements, you can use message extensions to add attributes to the message. This can be applied in more complicated messaging scenarios.

```java
ChatMessage message = ChatMessage.createTextSendMessage(content, conversationId); 
// Adds message attributes.
message.setAttribute("attribute1", "value");
message.setAttribute("attribute2", true);
// Sends the message
ChatClient.getInstance().chatManager().sendMessage(message);

// Retrieves the message attributes when receiving the message.
message.getStringAttribute("attribute1",null);
message.getBooleanAttribute("attribute2", false)
```

## Next steps

After implementing sending and receiving messages, you can refer to the following documents to add more messaging functionalities to your app:

- [Manage local messages](./agora_chat_manage_message_android?platform=Android)
- [Retrieve conversations and messages from the server](./agora_chat_retrieve_message_android?platform=Android)
- [Message receipts](./agora_chat_message_receipt_android?platform=Android)


