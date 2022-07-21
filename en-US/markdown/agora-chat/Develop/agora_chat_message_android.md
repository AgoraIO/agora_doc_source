The Agora Chat SDK supports sending and receiving various types of messages:
- Text messages, including hyperlinks and emojis.
- Attachment messages, including image, voice, video, and file messages.
- Location messages.
- CMD messages.
- Extended messages.
- Custom messages.

You can send a message to a peer user, a chat group, or a chat room. After sending a message, you can listen for the message read receipt. You can also recall the message. 

To manage messages, for example, to delete a conversation, you can also retrieve historical messages from the local device or from the server.

This page introduces how to use the Agora Chat SDK to implement these functionalities in your app.

## Understand the tech

The Agora Chat SDK provides a `ChatMessage` class that defines the message type, and a `ChatManager` class that allows you to send, recieve, recall, and retrieve messages.

## Prerequisites

Before proceeding, ensure that you meet the following requirements:

- You have integrated the Agora Chat SDK, initialized the SDK, and implemented the functionality of users logging in. For details, see [Get Started with Agora Chat](agora_chat_get_started_android?platform=Android).
- You understand the [API call frequency limits](./agora_chat_limitation_android?platform=Android).


## Send and recieve messages

The process of sending and receiving a message is as follows:

1. On the sender's client, create a message and send it. The message is sent to the Agora Chat server.
2. The server delivers the message to the receiver.
3. When the receiver receives the message, the SDK triggers an event.
4. On the receiver's client, listen for the event, and get the message.

Followings are the core methods for sending, receiving, and recalling messages:
- `sendMessage`: Sends a message to the specified user, chat group, or chat room.
- `recallMessage`: Recalls a message that has been sent.
- `addMessageListener`: Adds a message event listener.

### Text messages

Refer to the following code sample to create, send, and receive a text message:

```java
 // Call createTxtSendMessage to create a text message. Set content as the text content and toChatUsername to the username to whom you want to send this text message.
 ChatMessage message = ChatMessage.createTxtSendMessage(content, toChatUsername);
 // Call setChatType to set the chat type. You can set it as chat (one-to-one chat), group chat, or chat room.
 message.setChatType(ChatType.GroupChat);
// Call setMessageStatusCallback to listen for the status of the message sending. You can implement subsequence settings in this callback, for example, adding a tip pop-up if the message sending fails.
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
 });
 // Call sendMessage to send the message.
 ChatClient.getInstance().chatManager().sendMessage(message);

// Call addMessageListener to add a message listener.
ChatClient.getInstance().chatManager().addMessageListener(msgListener);
MessageListener msgListener = new MessageListener() {

// The SDK triggers the onMessageReceived callback when it receives a message.
// After receiving this callback, the SDK parses the message and displays it.
@Override
public void onMessageReceived(List<ChatMessage> messages) {

}
};

// Call removeMessageListener to remove the message listener.
ChatClient.getInstance().chatManager().removeMessageListener(msgListener);
```

### Attachment messages

Attachment messages include voice, image, video, and file messages. When you send an attachment message, the attachment is uploaded to the Agora Chat server.
- For voice, image, and video messages, the SDK automatically downloads the audio, image, or video thumbnail when they arrive.
- For file messages, the SDK does not automatically download the attachment. You need to call APIs to download the file on the receiver's client.

#### Create an attachment message

Before you create an attachment message, you need to implement the function of getting the attachment in your app, for example, to send an audio message, you need to implement the recording function.

To create an attachment message, call the corresponding `create` method in the `ChatMessage` class according to the type of the attachment.

```java
// Create a voice message
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
// Set videoUri as the URI of the video file, thumbPath as the URI of the thumbnail and videoLength as the video duration (in seconds).
ChatMessage message = ChatMessage.createVideoSendMessage(videoUri, thumbPath, videoLength, toChatUsername);
```
```java
// Create a file message
// Get the URI of the file to be sent
Uri fileLocalUri = Uri.fromFile(new File("/sdcard/cats.jpg"));
// Set fileLocalUri as the URI of the local file
ChatMessage message = ChatMessage.createFileSendMessage(fileLocalUri, toChatUsername);
```

#### Send the attachment message

To send the attachment message, call `sendMessage` in the `ChatMessage` class.

```java
 // Call setChatType to set the chat type. You can set it as chat (one-to-one chat), group chat, or chat room.
 message.setChatType(ChatType.GroupChat);
 // Call sendMessage to send the message.
 ChatClient.getInstance().chatManager().sendMessage(message);
 ```

 #### Listen for the message status

To validate that a message is successfully sent, or to track the upload progress of an attachment, call `setMessageStatusCallback` to listen for the message status:

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

#### Receive the attachment message

Call the `addMessageListener` to add a message listener. If the received message is an image, video, or file message, download the attachment before opening it.

The following code shows how to receive an image message:

```java
ChatClient.getInstance().chatManager().addMessageListener(msgListener);
MessageListener msgListener = new MessageListener() {
  // Receives a message.
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

### Location messages

To send and receive a location message, you need to integrate a third-party map service provider. When sending a location message, you get the longtitude and latitude information of the location from the map service provider; when receiving the location message, you extract the received longitude and latitude information and display the location on the third-party map.

The following code sample shows how to send a location message:

```java
// Set the longitude and latitude information and descriptions of the position.
ChatMessage message = ChatMessage.createLocationSendMessage(latitude, longitude, locationAddress, toChatUsername);
// Set the chat group type. You can set it as chat (one-to-one chat), group chat, or chat room.
if (chatType == CHATTYPE_GROUP)    message.setChatType(ChatType.GroupChat);ChatClient.getInstance().chatManager().sendMessage(message);
```

### CMD messages

CMD messages are command messages that tell the specified user to take a certain action. The receiver deals with the command message themselves.

<div class="alert note"><li>CMD messages are not stored in the local database.<li>Actions beginning with <code>em_</code> and <code>easemob::</code> are internal fields. Do not use them.</div>

The following code sample shows how to send and receive a CMD message:

```java
ChatMessage cmdMsg = ChatMessage.createSendMessage(ChatMessage.Type.CMD);
// Set the chat type. You can set it as chat (one-to-one chat), group chat, or chat room.
cmdMsg.setChatType(ChatType.GroupChat)String action="action1";
// Set the CMD message body. You can customize the action.
CmdMessageBody cmdBody = new CmdMessageBody(action);String toUsername = "test1";
// Send the CMD message.
cmdMsg.setTo(toUsername);cmdMsg.addBody(cmdBody); ChatClient.getInstance().chatManager().sendMessage(cmdMsg);

// Add a message listener to receive the CMD message.
MessageListener msgListener = new MessageListener()
{
  // Occurs when a message is received.
  @Override
  public void onMessageReceived(List<ChatMessage> messages) {
  }
  // Occurs when a CMD message is received.
  @Override
  public void onCmdMessageReceived(List<ChatMessage> messages) {
  }
}
```

### Custom messages

Custom messages are self-defined key-value pairs that include the message type and the message content.

The following code sample shows how to send a custom message:

```java
ChatMessage customMessage = ChatMessage.createSendMessage(ChatMessage.Type.CUSTOM);
// Set event as the custom message event, for example, sending a gift.
event = "gift"CustomMessageBody customBody = new CustomMessageBody(event);
// The data type of params is Map<String, String>.
customBody.setParams(params);customMessage.addBody(customBody);
// Set the username, chat group ID, or chatroom ID of the receiver.
customMessage.setTo(to);
// Set the chat type. You can set it as chat (one-to-one chat), group chat, or chat room.
customMessage.setChatType(chatType);ChatClient.getInstance().chatManager().sendMessage(customMessage);
```

### Extended messages

You can also custom the message content by extending the message type. The following code sample shows how to send an extended message:

```java
ChatMessage message = ChatMessage.createTxtSendMessage(content, toChatUsername);
// Add a custom message attribute.
message.setAttribute("attribute1", "value");message.setAttribute("attribute2", true);
// Send the message.
ChatClient.getInstance().chatManager().sendMessage(message);

// Call getStringAttribute to get the custom message attribute when receiving the message.
message.getStringAttribute("attribute1",null);message.getBooleanAttribute("attribute2", false)
```

### Recall messages

After sending a message, you can recall it using the `recallMessage` method. The default time limit for recalling a message is two minutes after the message. To customize this time limit, contact support@agora.io.

Refer to the following code sample to recall a message:

```java
ChatClient.getInstance().chatManager().recallMessage(contextMenuMessage);
```

## Manage local messages

The Agora Chat SDK stores the sent and received messages in the local database, and you can manage these messages in conversations. 

The followings are the core methods for managing the local messages:
- `loadAllConversations`: Loads all the conversations on the local device.
- `deleteConversation`: Deletes the conversation on the local device.
- `getUnreadMsgCount`: Retrieves the count of the unread messages in the specified conversation.
- `getUnreadMessageCount`: Retrieves the count of all the unread messages.
- `searchMsgFromDS`: Searches for messages using keywords or the timestamp from the local database.
- `importMessages`: Imports the specified historial message to the database.
- `insertMessage`: Inserts the specified historial message into the conversation.

### Retrieve local conversations

Call `loadAllConversations` and `getAllConversations` to load all the conversations to the local device.

```java
Map<String, Conversation> conversations = ChatClient.getInstance().chatManager().loadAllConversations();
Map<String, Conversation> conversations = ChatClient.getInstance().chatManager().getAllConversations();
```

### Retreive messages from the specified conversation

Refer to the following code sample for retrieving all the messages of the current conversation:

```java
Conversation conversation = ChatClient.getInstance().chatManager().getConversation(username);
// Call getAllMessages to retrieve the messages in the current conversation.
List<ChatMessage> messages = conversation.getAllMessages();
// Only one message is loaded during SDK initilization. Call loadMoreMsgFromDB to retrieve more messages.
List<ChatMessage> messages = conversation.loadMoreMsgFromDB(startMsgId, pagesize);
```

### Retrieve the count of the unread messages in the specified conversation

Call `getUnreadMsgCount` to retrieve the count of the unread messages in the current conversation.

```java
// Retrieve the count of the unread messages in the current conversation.
Conversation conversation = ChatClient.getInstance().chatManager().getConversation(username);
conversation.getUnreadMsgCount();
```

### Retrieve all the unread messages

Call `getUnreadMessageCount` to retrieve the count of all the unread messages in all the conversations.

```java
ChatClient.getInstance().chatManager().getUnreadMessageCount();
```
### Mark messages as read

You can mark the specified message or all the messages in the specified conversation as read. You can also mark all the conversations as read. Refer to the following code sample:

```java
Conversation conversation = ChatClient.getInstance().chatManager().getConversation(username);
// Mark the current conversation as read.
conversation.markAllMessagesAsRead();
// Mark the specified message in the current conversation as read.
conversation.markMessageAsRead(messageId);

// Mark all the conversations as read.
ChatClient.getInstance().chatManager().markAllConversationsAsRead();
```

### Delete local conversations and messages

You can delete the specified conversation or the specified message in the current conversation from the local device. Refer to the following code:

```java
// Delete the specified conversation
ChatClient.getInstance().chatManager().deleteConversation(username, true);

// Delete the specified message in the current conversation
Conversation conversation = ChatClient.getInstance().chatManager().getConversation(username);
conversation.removeMessage(deleteMsg.msgId);
```

### Search historial messages

Refer to the following code to search the historial messages. You can use fields such as keyword, timestamp, and sender for the search.

```java
// Call searchMsgFromDB to search for messages in the current conversation.
List<ChatMessage> messages = conversation.searchMsgFromDB(keywords, timeStamp, maxCount, from, Conversation.SearchDirection.UP);
```

### Import historial messages to the local database

You can import a historial message to the local database by constructing a `ChatMessage` object:

```java
ChatClient.getInstance().chatManager().importMessages(msgs);
```

### Insert messages

Refer to the following code sample to insert a message into the current conversation:

```java
// Insert a message into the current conversation.
Conversation conversation = ChatClient.getInstance().chatManager().getConversation(username);
conversation.insertMessage(message);
// Store the message in the local database.
ChatClient.getInstance().chatManager().saveMessage(message);
```

## Retrieve historial messages from the server

The Agora Chat SDK also stores historial messages on the chat server, and you can retrieve these historial messages by conversations.

The followings are the core methods for retrieving historical messages from the server
- `asyncFetchConversationsFromServer`: Retrieves the conversation list from the server.
- `fetchHistoryMesssages`: Retrieves the messages in the specified conversation from the server.

Agora recommends calling these methods when the app is first installed or before any conversation occurs on the local device.

### Retrieve the conversation list

Refer to the following code sample to retrieve the conversation list from the server. For each message call, a maximum number of 100 conversations are returned.

```java
ChatClient.getInstance().chatManager().asyncFetchConversationsFromServer(new ValueCallBack<Map<String, Conversation>>() {
    // Occurs when the conversation is successfully fetched from the server.
    @Override
    public void onSuccess(Map<String, Conversation> value) {
    }
    // Occurs when the conversation fails to be fetched from the server.
    @Override
    public void onError(int error, String errorMsg) {
    }
});
```

### Retrieve the historical messages of the specified conversation by pagination

Refer to the following code to retrieve the historial messages from the specified conversation by pagination. For each method call, a maximum number of 50 messages are returned.

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

## Message delivery and read receipts

After you send a message, once this message is delivered or read, the Agora Chat SDK supports sending a receipt to you, informing you that the message is delivered or read.

The followings are the core methods for implementing message delivery and read receipts:
- `setRequireAck`: Enables message read receipts.
- `setRequireDeliveryAck`: Enables message delivery receipts.
- `ackConversationRead`: Sends the receipt when the specified conversation is read.
- `ackMessageRead`: Sends the receipt when the specified message is read.
- `ackGroupMessageRead`: Sends the receipt when the specified group message is read.

### Message delivery receipts

Call `setRequireDeliveryAck` to enable the message delivery receipt feature. The following code sample shows how to implement message delivery receipts:

```java
// Call setRequireDeliveryAck to enable message delivery receipts. Once you enable this feature, the message sender receives the delivery receipt once the messgage is successfully received.
options.setRequireDeliveryAck(true);

// Add a message listener to listen for the receipt message.
MessageListener msgListener = new MessageListener() {
    // Occurs when the message is received.
    @Override
      public void onMessageReceived(List<ChatMessage> messages) {
    }
    // Occurs when the message delivery receipt is received
    @Override
      public void onMessageDelivered(List<ChatMessage> message) {
    }
};
// Remove the message listener.
ChatClient.getInstance().chatManager().removeMessageListener(msgListener);
```

### Read receipts

Once the message sender enables message read receipts by calling `setRequireAck`, the message receiver sends this receipt after reading the message.

#### Conversation read receipts

Refer to the following code to implement read receipts for all the messages in the specified conversation:

- The message receiver

    ```java
    // The message receiver calls ackConversationRead to send the conversation read receipt.
    // This is an asynchronous method.
    try {
        ChatClient.getInstance().chatManager().ackConversationRead(conversationId);
    } catch (ChatException e) {
        e.printStackTrace();
    }
    ```

- The message sender

    ```java
    // The message sender calls addConversationListener to listen for conversation events.
    ChatClient.getInstance().chatManager().addConversationListener(new ConversationListener() {
                ...
                @Override
                // Occurs when the all the messages in the conversation are read.
                public void onConversationRead(String from, String to) {
                    // Add follow-up logics such as popping up a notification.
                }
            });
    ```

In scenarios where a user has logged in to multiple devices, once the read receipt is sent from one of these devices, the server marks the unread messages on the other devices as read as well.

#### Message read receipts

Refer to the following code to implement read receipts for the specified message:

- The message receiver
    
  You can send the message read receipt when entering the conversation:

    ```java
    // The message receiver calls ackMessageRead to send the conversation read receipt.
    try {
        ChatClient.getInstance().chatManager().ackMessageRead(conversationId);
    }catch (ChatException e) {
        e.printStackTrace();
    }
    ```

  You can also send the message read receipt when receiving a message:

    ```java
    ChatClient.getInstance().chatManager().addMessageListener(new MessageListener() {
        ......

        @Override
        // Occurs when the specified message is received.
        public void onMessageReceived(List<ChatMessage> messages) {
            ......
            // Send the message read receipt.
            sendReadAck(message);
            ......
        }
        ......
    });
    // Send the message read receipt.
    public void sendReadAck(ChatMessage message) {
        // For messages in one-to-one chat
        if(message.direct() == ChatMessage.Direct.RECEIVE
                && !message.isAcked()
                && message.getChatType() == ChatMessage.ChatType.Chat) {
            ChatMessage.Type type = message.getType();
            // For voice, video, and file messages, you need to send the receipt after clicking the files.
            if(type == ChatMessage.Type.VIDEO || type == ChatMessage.Type.VOICE || type == ChatMessage.Type.FILE) {
                return;
            }
            try {
                // Call ackMessageRead to send the message read receipt.
                ChatClient.getInstance().chatManager().ackMessageRead(message.getFrom(), message.getMsgId());
            } catch (ChatException e) {
                e.printStackTrace();
            }
        }
    }
    ```

- The message sender

    ```java
    // // The message sender calls addMessageListener to listen for message events.
    ChatClient.getInstance().chatManager().addMessageListener(new MessageListener() {
        ......
        @Override
        // Occurs when the specified message is read.
        public void onMessageRead(List<ChatMessage> messages) {
            // Add follow-up logics such as popping up a notification.
        }
        ......
    });
    ```

#### Group message read receipts

For chat group messages, when the group owner or an admin sends a messge, they can set whether to require a message read receipt.

<div class="alert note">You need to contact support@agora.io to enable the group message read receipt feature. Once enabled, this feature applies to the chat group owner and chat group admins only.</div>

To receive the chat message receipt, the message sender needs to set `setIsNeedGroupAck` as true when sending the message.

```java
// Set setIsNeedGroupAck as true when sending the group message
ChatMessage message = ChatMessage.createTxtSendMessage(content, to);
message.setIsNeedGroupAck(true);
```

The following code sample shows how to implement chat message receipts:

- The message receiver


    ```java
    // Send the group message read receipt.
    public void sendAckMessage(ChatMessage message) {
            if (!validateMessage(message)) {
                return;
            }

            if (message.isAcked()) {
                return;
            }

            // If a user can log in from multiple devices, the ack messasg does not need to be sent.
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

- The message sender

    ```java
    // Occurs when the group message is read.
    void onGroupMessageRead(List<GroupReadAck> groupReadAcks) {
        // Add follow-up notifications
    }
    ```

    After receiving the `onGroupMessageRead` callback, the message sender can also call `asyncFetchGroupReadAcks` to know the details of the receipt.

    ```java
    /**
     * Fetches the details of the group message read receipt.
     * @param msgId The message ID.
     * @param pageSize The page size.
     * @param startAckId The receipt ID from which you want to fetch. If you set it as null, the SDK fetches from the latest receipt.
     * @return The message receipt list and a cursor.
     */
    public void asyncFetchGroupReadAcks(final String msgId, final int pageSize,final String startAckId, final ValueCallBack<CursorResult<GroupReadAck>> callBack) {}
    ```
