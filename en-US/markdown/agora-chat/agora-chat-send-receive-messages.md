The Agora Chat SDK supports sending and receiving various types of messages:
- Text messages, including hyperlinks and emojis.
- Attachment messages, including the following types:
  - Image.
  - Audio.
  - Video.
  - File.
- Location messages.
- CMD messages.
- Extended messages.
- Custom messages.

This pages shows how to implement the functionality of sending and receiving messages.

## Understand the tech

The process of sending and receiving a message is as follows:

1. On the sender's client, create a message and send it.
   The message is sent to the Agora Chat server.
2. The server delivers the message to the receiver.
3. When the receiver receives the message, the SDK triggers an event.
4. On the receiver's client, listen for the event and get the message.

## Prerequisites

Before proceeding, ensure that you meet the following requirements:

- You have integrated and initialized the Agora Chat SDK.
- You have implemented the functionality of registering accounts and login. See [Get Started](link to the quick start).
- You understand the [API call frequency limits](link to the limitations).

## Implementation

This section uses attachment messages as an example to show to send and receive messages. For more message types, refer to [References]().

When you send an attachment message (image, audio, video or file), the attachment is uploaded to the Agora Chat server. 

- For audio, image and video messages, the SDK automatically downloads the audio and the image or video thumbnail when they arrive.
- For file messages, the SDK does not automatically download the attachment. You need to call APIs to download the file on the receiver's client.

### Create an attachment message

Before you create an attachment message, you need to implement the function of getting the attachment in your app, for example, to send an audio message, you need to implement the recording function.

To create an attachment message, call the corresponding `create` method in the `ChatMessage` class according to the type of the attachment.

```java
// Create an audio message
// Set voiceUri as the URI of the local audio file，and duration as the duration of the audio (in seconds).
ChatMessage message = ChatMessage.createVoiceSendMessage(voiceUri, duration, toChatUsername); 
```

```java
// Create an image message
// Set imageUri as the URI of the local iamge. To send the orginal image file, set the second parameter as true.
ChatMessage message = ChatMessage.createImageSendMessage(imageUri, false, toChatUsername); 
```

```java
// Create a video message
// Set videoUri as the URI of the video file, thumbPath as the URI of the thumbnail, videoLength as the video duration (in seconds).
ChatMessage message = ChatMessage.createVideoSendMessage(videoUri, thumbPath, videoLength, toChatUsername);
```

```java
// Create a file message
// Get the URI of the file to be sent
Uri fileLocalUri = Uri.fromFile(new File("/sdcard/cats.jpg"));
// Set fileLocalUri as the URI of the local file
ChatMessage message = ChatMessage.createFileSendMessage(fileLocalUri, toChatUsername);
```

### Send the message

To send the message, call `sendMessage` in the `ChatManager` class.

Note that to send a message to a group chat, set the chat type before calling `sendMessage`.

```java
// If the chat is a group chat, set the chat type.
if (chatType == CHATTYPE_GROUP)    message.setChatType(ChatType.GroupChat);
// Send the message
ChatClient.getInstance().chatManager().sendMessage(message);
```

### Monitor message status

To validate that a message is successfully sent, or to track the upload progress of an attachment, override an instance of `io.agora.CallBack` for the message being sent. For example, the following code shows how to display an [Android toast](https://developer.android.com/guide/topics/ui/notifiers/toasts) in the user interface of your app to show message success or failure:

```java
message.setMessageStatusCallback(new CallBack() {
  @Override
  public void onSuccess() {
    showToast("The message is successfully sent");
    dialog.dismiss();
  }
  @Override
  public void onError(int code, String error) {
    showToast("Failed to send the message");
  }
  
  // Upload status of an attachment message.
  @Override
  public void onProgress(int progress, String status) {
        
  }
});
```

### Receive messages

Sending messages is a great start. To enable conversations between users, your app must listen for incoming messages and post them to the conversations.

To receive messages, do the following:

1. Implement a `MessageListener` instance and listen for the `onMessageReceived` callback.
2. Call `addMessageListener` to register the message listener.
3. In the `onMessageReceived` callback, traverse the received messages and get the message content.
4. If the received message is an image, video, or file message, download the attachment before opening it.


You can add multiple message listeners, and remember to remove a listener when it is not needed, for example when your app is terminated with a call to [android.app.onDestroy()](https://developer.android.com/reference/android/app/Activity#onDestroy()).

The following code shows how to receive an image message.

```java
ChatClient.getInstance().chatManager().addMessageListener(msgListener);
MessageListener msgListener = new MessageListener() {
  // Receives a message
  @Override    
  public void onMessageReceived(List<ChatMessage> messages) {
    // If you receive an image message, download the image before opening it.
    if (message.getType() == ChatMessage.Type.IMAGE) {
        ImageMessageBody imgBody = (ImageMessageBody) message.getBody();
        // Get the URL of the image file on the server.
        String imgRemoteUrl = imgBody.getRemoteUrl();
        // Get the URL of the thumbnail on the server.
        String thumbnailUrl = imgBody.getThumbnailUrl();
        // Download the image
        ChatClient.getInstance().chatManager().downloadAttachment(message);
        // Get the URI of the local image file.
        Uri imgLocalUri = imgBody.getLocalUri();
        // If the auto-download of the thumbnail is disabled or fails
        ChatClient.getInstance().chatManager().downloadThumbnail(message);
        // Get the URI of the local thumbnail.
        Uri thumbnailLocalUri = imgBody.thumbnailLocalUri();
    }
  }        
};
// Remove the message listener.
ChatClient.getInstance().chatManager().removeMessageListener(msgListener);
```

## Next steps

After implementing the functionality of sending and receiving messages, you can add more features to your messaging app.

### Recall a message

Users can recall a sent message within a certain time period. The default time limit is two minutes. To change the time limit, contact sales-us@agora.io. You can extend the time limit up to seven days.

```java
ChatClient.getInstance().chatManager().recallMessage(message);
```

### Manage local messages

The Agora Chat SDK uses [SQLite](https://www.sqlite.org) to store the local messages. Messages are managed in conversations. You can load and display messages in conversations on users' devices.

 Agora Chat supports the following features for managing local messages:

- Get local conversations and messages.
  - [loadAllConversations](https://hyphenateinc.github.io/android_reference/classio_1_1agora_1_1chat_1_1_chat_manager.html#a670d44662419ddee494710e881096c43)
  - [getAllConversations](https://hyphenateinc.github.io/android_reference/classio_1_1agora_1_1chat_1_1_chat_manager.html#af25fbeed0527afb33bb5c24ad4e53e08)
  - [getConversation](https://hyphenateinc.github.io/android_reference/classio_1_1agora_1_1chat_1_1_chat_manager.html#a1dea229f1bc9e9d605a64228cc47a4e7)
  - [getAllMessages](https://hyphenateinc.github.io/android_reference/classio_1_1agora_1_1chat_1_1_conversation.html#a1698d376366ce172b9618e31c110e0ba)
  - [loadMoreMsgFromDB](https://hyphenateinc.github.io/android_reference/classio_1_1agora_1_1chat_1_1_conversation.html#a49135a1e780146b2d8324797857bc671)
- Get the unread message count.
  - [ChatManager.getUnreadMessageCount](https://hyphenateinc.github.io/android_reference/classio_1_1agora_1_1chat_1_1_chat_manager.html#af1ba2602185cc6b1255eb7bc40882ee7)
  - [Conversation.getUnreadMessageCount](https://hyphenateinc.github.io/android_reference/classio_1_1agora_1_1chat_1_1_conversation.html#a373241970670f03610e9364844780a8c)
- Mark messages as read.
  - [markAllMessagesAsRead](https://hyphenateinc.github.io/android_reference/classio_1_1agora_1_1chat_1_1_conversation.html#aa64a9865b7cb91b849a89cffa12f3111)
  - [markMessageAsRead](https://hyphenateinc.github.io/android_reference/classio_1_1agora_1_1chat_1_1_conversation.html#a1e331be4eea4f59fb7d1f6c1da915b09)
  - [markAllConversationsAsRead](https://hyphenateinc.github.io/android_reference/classio_1_1agora_1_1chat_1_1_chat_manager.html#aad13acd1db0358917450d1c5efd4806b)
- Delete conversations and message history.
  - [deleteConversation](https://hyphenateinc.github.io/android_reference/classio_1_1agora_1_1chat_1_1_chat_manager.html#a55f9d270ea1638fc556c3325ac348488)
  - [removeMessage](https://hyphenateinc.github.io/android_reference/classio_1_1agora_1_1chat_1_1_conversation.html#abb3c9448ab472a362f85370eddf6911c)
- Search messages.
  - [ChatManager.searchMsgFromDB](https://hyphenateinc.github.io/android_reference/classio_1_1agora_1_1chat_1_1_chat_manager.html#a81174f203f9493a171fa28a80d603828)
  - [Conversation.searchMsgFromDB](https://hyphenateinc.github.io/android_reference/classio_1_1agora_1_1chat_1_1_conversation.html#a4108b8b860a757be16ba600775128f97)
- Import messages: [importMessages](https://hyphenateinc.github.io/android_reference/classio_1_1agora_1_1chat_1_1_chat_manager.html#adf8f64a7885eb3ff1c840f2aba9056c3).
- Insert messages to a conversation: [insertMessage](https://hyphenateinc.github.io/android_reference/classio_1_1agora_1_1chat_1_1_conversation.html#a389c3652edc6a438483e04028ad7da1b).

### Fetch messages from the server

When the local database is empty, for example when a user logs in on a new device, you can fetch the history messages from the Agora Chat server.

To fetch conversations from the server, call `asyncFetchConversationsFromServer`:

```java
ChatClient.getInstance().chatManager().asyncFetchConversationsFromServer(new ValueCallBack<Map<String, Conversation>>() {   
    @Override    
    public void onSuccess(Map<String, Conversation> value) {        
    }    
  
    @Override    
    public void onError(int error, String errorMsg) {      
    }
});
```

To fetch the history messages of a conversation, call `fetchHistoryMessages`. This method returns at most 50 messages.

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
} catch (HyphenateException e) {
    e.printStackTrace();
}
```

### Delivery and read receipts

Agora Chat provides message devlivery and read receipts so that users can know when their messages are delivered and read.

#### Delivery receipts

To enable message delivery receipts, do the following:

1. Call `setRequireDeliveryAck(true)`.

    ```java
    options.setRequireDeliveryAck(true);
    ```
    
2. Listen for the `onMessageDelivered` callback. The SDK triggers this callback when a message is delivered.

    ```java
    MessageListener msgListener = new MessageListener() {                  
        @Override    
          public void onMessageDelivered(List<EMMessage> message) { 
        }
    };
    ```

#### Conversation read receipts

Conversation read receipts only apply to one-to-one chats.

To implement conversation read receipts, do the following:

1. On the receiver's client, send the read receipt for a conversation by calling `ackConversationRead`.

   Agora recommends calling this method when a user opens a conversation with unread messages.

   ```java
   try {
       ChatClient.getInstance().chatManager().ackConversationRead(conversationId);
   } catch (HyphenateException e) {
       e.printStackTrace();
   }
   ```

2. On the sender's client, listen for the `onConversationRead` callback.

   ```java
   ChatClient.getInstance().chatManager().addConversationListener(new ConversationListener() {
       ……
       @Override
       public void onConversationRead(String from, String to) {
       }
   });
   ```

#### One-to-one message read receipts

This section only applies to one-to-one messages. For group messages, the read receipt feature is available in the Pro and Enterprise packages. See [Group message read receipts](#group).

To implement the message read receipts, do the following:

1. On the receiver's client, send the read receipt for a message by calling `ackMessageRead`.

   You can call this method when the user is in a conversation and receives new messages, as the following code shows:

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
   
   public void sendReadAck(ChatMessage message) {
       // Determine if the received message has sent the read ack and the chat type is one-to-one chat.
       if(message.direct() == ChatMessage.Direct.RECEIVE
               && !message.isAcked()
               && message.getChatType() == ChatMessage.ChatType.Chat) {
           ChatMessage.Type type = message.getType();
           // For video, audio, and file messages, do not send the read receipt until the message is clicked.
           if(type == ChatMessage.Type.VIDEO || type == ChatMessage.Type.VOICE || type == ChatMessage.Type.FILE) {
               return;
           }
           try {
               ChatClient.getInstance().chatManager().ackMessageRead(message.getFrom(), message.getMsgId());
           } catch (HyphenateException e) {
               e.printStackTrace();
           }
       }
   }
   ```

2. On the sender's client, listen for the `onMessageRead` callback.

   ```java
   ChatClient.getInstance().chatManager().addMessageListener(new MessageListener() {
       ......
       @Override
       public void onMessageRead(List<ChatMessage> messages) {
       }
       ......
   });
   ```

To reduce the times of sending read receipts, Agora recommends using the message read receipts together with the conversation read receipts:

- When a user opens a conversation with unread messages, send the conversation read receipt.
- When a user is already in a conversation, and receives new messages, send the message read receipts.

#### Group message read receipts

This feature requires a Pro or Enterprise package.

In group chats, only the group owners and administrators can enable message read receipts.

To implement the group message read receipts, do the following:

1. On the sender's client, call `setIsNeedGroupAck(true)`:

   ```java
   ChatMessage message = ChatMessage.createTxtSendMessage("hello", "groupID");
   message.setIsNeedGroupAck(true);
   ```

2. On the receiver's client, call `ackGroupMessageRead` when the message is read.

   ```java
   public void sendAckMessage(ChatMessage message) {
           if (!validateMessage(message)) {
               return;
           }
   
           if (message.isAcked()) {
               return;
           }
   
           // Avoid sending duplicate read receipts in case a user logs in on multiple devices.
           if (ChatClient.getInstance().getCurrentUser().equalsIgnoreCase(message.getFrom())) {
               return;
           }
   
           try {
               if (message.isNeedGroupAck() && !message.isUnread()) {
                   String to = message.conversationId();
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

3. On the sender's client, listen for the `onGroupMessageread` callback.

   ```java
   ChatClient.getInstance().chatManager().addMessageListener(new MessageListener() {
       ......
       @Override
       public void onGroupMessageRead(List<EMGroupReadAck> groupReadAcks) {
    }
       ......
   });
   ```

If you need to display the read receipts in group chats, use the [asyncFetchGroupReadAcks](https://hyphenateinc.github.io/android_reference/classio_1_1agora_1_1chat_1_1_chat_manager.html#a9ba91f77211c49d1c9484c7caec69bde) method to get the details of the read receipts.

## Reference

This section provides additional information for your reference.

<a name="other"></a>

### Other message types

#### Location messages

A location message contains the information that locates a specific point on the surface of the earth. It can also include the address information.

To retrieve the latitude and longitude of a specific point, you integrate a third-party map service. 

```java
// Set locationAddress as the address of the location.
ChatMessage message = ChatMessage.createLocationSendMessage(latitude, longitude, locationAddress, toChatUsername);
// If the chat is a group chat, set the chat type.
if (chatType == CHATTYPE_GROUP)    message.setChatType(ChatType.GroupChat);
ChatClient.getInstance().chatManager().sendMessage(message);
```

#### CMD messages

A CMD is a signalling message. It is not displayed in a conversation, stored in the local database, and cannot be sent as a push notification when the receiver is offline.

CMD messages are applicable to scenarios like updating the avatar and nickname.

The following code snippets show how to use the CMD message to send a command and specify an action for the receiver. 

```java
ChatMessage cmdMsg = ChatMessage.createSendMessage(ChatMessage.Type.CMD);
// If the chat is a group chat, set the chat type.
cmdMsg.setChatType(ChatType.GroupChat)
// You can customize the action.
String action="action1";
CmdMessageBody cmdBody = new CmdMessageBody(action);
// Send to the user "test1".
String toUsername = "test1";
cmdMsg.setTo(toUsername);
cmdMsg.addBody(cmdBody); ChatClient.getInstance().chatManager().sendMessage(cmdMsg);
```

#### Extended messages

To easily add more information to a message without implementing a [custom message type](#custom), add attributes to a standard message.

For example, to send the original message in a message reply:

```java
ChatMessage message = ChatMessage.createTxtSendMessage(content, toChatUsername); 
// Set custom attributes
message.setAttribute("attribute1","value");
message.setAttribute("attribute2", true);
// Send the message
ChatClient.getInstance().chatManager().sendMessage(message);
// Get the custom attributes when receiving the message.
message.getStringAttribute("attribute1",null);
message.getBooleanAttribute("attribute2", false)
```

<a name="custom"></a>

#### Custom messages

When extending a standard message is not enough, you can build your own message from the ground up.

You need to set the key and value in a custom message.

```java
ChatMessage customMessage = ChatMessage.createSendMessage(ChatMessage.Type.CUSTOM);
// Set event as the name of the custom message type.
event = "gift"
CustomMessageBody customBody = new CustomMessageBody(event);
// The type of params is Map<String, String>.
customBody.setParams(params);
customMessage.addBody(customBody);
// Set toUserName as the ID of the receiver.
customMessage.setTo(toUserName);
// If the chat is a group chat, set the chat type.
customMessage.setChatType(chatType);
// Send the message.
ChatClient.getInstance().chatManager().sendMessage(customMessage);      
```

### Message size and expiration limits

- The maximum size of a message is 5 KB.
- The maximum size of an attachment is 10 MB.
- The expiration time of the messages on the Agora Chat server:
  - Starter package: 7 days.
  - Pro package: 90 days.
  - Enterprise package: 180 days.
