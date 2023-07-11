# Thread Messages

Threads enable users to create a separate conversation from a specific message within a chat group to keep the main chat uncluttered.

This page shows how to use the Agora Chat SDK to send, receive, recall, and retrieve thread messages in your app.

## Understand the tech

The Agora Chat SDK provides the `ChatManager`, `ChatMessage`, and `ChatThread` classes for thread messages, which allows you to implement the following features:

- Send a thread message
- Receive a thread message
- Recall a thread message
- Retrieve thread messages

~338e0e30-e568-11ec-8e95-1b7dfd4b7cb0~


## Prerequisites

Before proceeding, ensure that you meet the following requirements:

- You have initialized the Agora Chat SDK. For details, see [Get Started with Android](./agora_chat_get_started_android?platform=Android).
- You understand the call frequency limit of the Agora Chat APIs supported by different pricing plans as described in [Limitations](./agora_chat_limitation?platform=Android).

<div class="alert info">The thread feature is supported by all types of <a href="https://docs.agora.io/en/agora-chat/agora_chat_plan">Pricing Plans</a> and is enabled by default once you have enabled Chat in <a href="https://console.agora.io/">Agora Console</a>.</div>

## Implementation

This section describes how to call the APIs provided by the Agora Chat SDK to implement thread features.

### Send a thread message

Sending a thread message is similar to sending a message in a chat group. The difference lies in the `isChatThreadMessage` field, as shown in the following code sample:

```java
// Calls `createTxtSendMessage` to create a text message. 
// Sets `content` to the content of the text message.
// Sets `chatThreadId` to the thread ID.
ChatMessage message = ChatMessage.createTxtSendMessage(content, chatThreadId); 
// Sets `ChatType` to `GroupChat` as a thread belongs to a chat group.
message.setChatType(ChatType.GroupChat); 
// Sets `isChatThreadMessage` to `true` to mark this message as a thread message.
message.setIsChatThreadMessage(true);
// Calls `setMessageStatusCallback` to listen for the message sending status. You can implement subsequent settings in this callback, for example, displaying a pop-up if the message sending fails.
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
// Calls `sendMessage` to send the text message.
ChatClient.getInstance().chatManager().sendMessage(message);
```

For more information about sending a message, see [Send Messages](./agora_chat_send_receive_message_android?platform=Android#send-a-text-message).


### Receive a thread message

Once a thread has a new message, all chat group members receive the `ChatThreadChangeListener#onChatThreadUpdated` callback. Thread members can also listen for the `MessageListener#onMessageReceived` callback to receive thread messages, as shown in the following code sample:

```java
MessageListener msgListener = new MessageListener() {
   // The SDK triggers the `onMessageReceived` callback when it receives a message.
   // After receiving this callback, the SDK parses the message and displays it.
   @Override
   public void onMessageReceived(List<ChatMessage> messages) {
       for (ChatMessage message : messages) {
           if(message.isChatThreadMessage()) {
               // You can implement subsequent settings in this callback.
           }
       }
   }
   ...
};
// Calls `addMessageListener` to add a message listener.
ChatClient.getInstance().chatManager().addMessageListener(msgListener);
// Calls `removeMessageListener` to remove the message listener.
ChatClient.getInstance().chatManager().removeMessageListener(msgListener);
```

For more information about receiving a message, see [Receive Messages](./agora_chat_send_receive_message_android?platform=Android#receive-a-message).


### Recall a thread message

For details about how to recall a message, refer to [Recall Messages](./agora_chat_send_receive_message_android?platform=Android#recall-a-message).

Once a message is recalled in a thread, all chat group members receive the `ChatThreadChangeListener#onChatThreadUpdated` callback. Thread members can also listen for the `MessageListener#onMessageRecalled` callback, as shown in the following code sample:

```java
MessageListener msgListener = new MessageListener() {
   // The SDK triggers the `onMessageRecalled` callback when it recalls a message.
   // After receiving this callback, the SDK parses the message and updates its display.
   @Override
   public void onMessageRecalled(List<ChatMessage> messages) {
       for (ChatMessage message : messages) {
           if(message.isChatThreadMessage()) {
               // You can implement subsequent settings in this callback.
           }
       }
   }
   ...
};
```

### Retrieve thread messages

You can retrieve thread messages locally or from the server, depending on your production environment.

You can check `ChatConversation#isChatThread()` to determine whether the current conversation is a thread conversation.

#### Retrieve messages of a thread from the server

You can call `asyncFetchHistoryMessage` to retrieve messages of a thread from the server. The only difference between retrieving messages of a thread from the server and retrieving group messages is that a thread ID needs to be passed in for the former and a group ID is required for the latter.

```java
String chatThreadId = "{your chatThreadId}";
Conversation.ConversationType type = Conversation.ConversationType.GroupChat;
int pageSize = 10;
String startMsgId = "";// Starting message ID for retrieving. If you pass in an empty string, the SDK will retrieve messages according to the search direction while ignoring this parameter.
Conversation.SearchDirection direction = Conversation.SearchDirection.DOWN;

ChatClient.getInstance().chatManager().asyncFetchHistoryMessage(chatThreadId, type, 
        pageSize, startMsgId, direction, new ValueCallBack<CursorResult<ChatMessage>>() {
    @Override
    public void onSuccess(CursorResult<ChatMessage> value) {
        
    }

    @Overrid
    public void onError(int error, String errorMsg) {

    }
});
```

#### Retrieve messages of a thread locally

By calling [`getAllConversations`](./agora_chat_manage_message_android?platform=Android#retrieve-conversations), you can only retrieve local one-to-one chat conversations and group conversations. To retrieve messages of a thread locally, refer to the following code sample:

```java
// Sets the conversation type to group chat as a thread belongs to a chat group.
// Sets `isChatThread` to `true` to mark the conversation as a thread.
ChatConversation conversation = ChatClient.getInstance().chatManager().getConversation(chatThreadId, ChatConversationType.GroupChat, createIfNotExists, isChatThread);
// Retrieves messages in the specified thread from the local database. The SDK automatically loads and stores the retrieved messages to the memory.
List<ChatMessage> messages = conversation.loadMoreMsgFromDB(startMsgId, pagesize, searchDirection);
```