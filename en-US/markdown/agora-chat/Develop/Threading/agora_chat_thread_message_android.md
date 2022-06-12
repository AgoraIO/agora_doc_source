# Thread Messages

Threads enable users to create a separate conversation from a specific message within a chat group to keep the main chat uncluttered.

This page shows how to use the Agora Chat SDK to send, receive, recall, and retrieve a thread message in your app.

## Understand the tech

The Agora Chat SDK provides the `ChatManager`, `ChatMessage`, and `ChatThread` classes for thread messages, which allows you to implement the following features:

- Send a thread message
- Receive a thread message
- Recall a thread message
- Retrieve a thread message

~338e0e30-e568-11ec-8e95-1b7dfd4b7cb0~


## Prerequisites

Before proceeding, ensure that you meet the following requirements:

- You have initialized the Agora Chat SDK. For details, see [Get Started with Android](./agora_chat_get_started_android?platform=Android).
- You understand the call frequency limit of the Agora Chat APIs supported by different pricing plans as described in [Limitations](./agora_chat_limitation?platform=Android).
- You understand the number of threads and thread members supported by different pricing plans as described in [Pricing Plan Details](./agora_chat_plan?platform=Android).
- Contact support@agora.io to activate the threading feature.


## Implementation

This section describes how to call the APIs provided by the Agora Chat SDK to implement thread features.

### Send a thread message

Send a thread message is similar to send a message in a chat group. The difference lies in the `IsThread` field, as shown in the following code sample:

```java
// Call `createTxtSendMessage` to create a text message. 
// Set `content` to the content of the text message.
// Set `chatThreadId` to the ID of a thread that receives the text message.
ChatMessage message = ChatMessage.createTxtSendMessage(content, chatThreadId); 
// Set `ChatType` to `GroupChat` as a thread belongs to a chat group.
message.setChatType(ChatType.GroupChat); 
// Set `IsThread` to `true` to mark this message as a thread message.
message.setIsThread(true);
// Call `setMessageStatusCallback` to listen for the message sending status. You can implement subsequent settings in this callback, for example, popping a tip if the message sending fails.
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
     @Override
     public void onProgress(int progress, String status) {
     }
});
// Call `sendMessage` to send the text message.
ChatClient.getInstance().chatManager().sendMessage(message);
```

For more information about sending a message, see [Send Messages](./agora_chat_message_android?platform=Android#send-and-receive-messages).


### Receive a thread message

Once a thread has a new message, all chat group members receive the `ChatThreadChangeListener#onChatThreadUpdated` callback. For thread members, they can also listen for the `MessageListener#onMessageReceived` callback to receive thread messages, as shown in the following code sample:

```java
MessageListener msgListener = new MessageListener() {
   // The SDK triggers the `onMessageReceived` callback when it receives a message.
   // After receiving this callback, the SDK parses the message and displays it.
   @Override
   public void onMessageReceived(List<ChatMessage> messages) {
       for (ChatMessage message : messages) {
           if(message.isThread()) {
               // You can implement subsequent settings in this callback.
           }
       }
   }
   ...
};
// Call `addMessageListener` to add a message listener.
ChatClient.getInstance().chatManager().addMessageListener(msgListener);
// Call `removeMessageListener` to remove the message listener.
ChatClient.getInstance().chatManager().removeMessageListener(msgListener);
```

For more information about receiving a message, see [Receive Messages](./agora_chat_message_android?platform=Android#send-and-receive-messages).


### Recall a thread message

For details about how to recall a message, refer to [Recall Messages](./agora_chat_message_android?platform=Android#recall-messages).

Once a message is recalled in a thread, all chat group members receive the `ChatThreadChangeListener#onChatThreadUpdated` callback. For thread members, they can also listen for the `MessageListener#onMessageRecalled` callback, as shown in the following code sample:

```java
MessageListener msgListener = new MessageListener() {
   // The SDK triggers the `onMessageRecalled` callback when it recalls a message.
   // // After receiving this callback, the SDK parses the message and updates the display.
   @Override
   public void onMessageRecalled(List<ChatMessage> messages) {
       for (ChatMessage message : messages) {
           if(message.isThread()) {
               // You can implement subsequent settings in this callback.
           }
       }
   }
   ...
};
```

### Retrieve thread messages from the server

For details about how to retrieve messages from the server, see [Retrieve Historical Messages](./agora_chat_message_android?platform=Android#retrieve-historical-messages-from-the-server).