The Agora Chat SDK stores historical messages on the chat server. When a chat user logs in from a different device, you can retrieve the historial messages from the server, so that the user can also browse these messages on the new device.

This page introduces how to use the Agora Chat SDK to retrieve messages from the server.

## Understand the tech

The Agora Chat SDK uses `ChatManager` to retrieve historical messages from the server. Followings are the core methods:

- `asyncFetchConversationsFromServer`: Retrieve a list of conversations stored on the server.
- `fetchHistoryMessages`: Retrieve the historical messages in the specified conversation from the server.

## Prerequsites

Before proceeding, ensure that you meet the following requirements:

- You have integrated the Agora Chat SDK, initialized the SDK and implemented the functionality of registering accounts and login. For details, see [Get Started with Agora Chat](./agora_chat_get_started_android?platform=Android).
- You understand the API call frequency limits as described in [Limitations](./agora_chat_limitation?platform=Android).
- Retrieving conversations from the server is not enabled by default. To implement this feature, contact support@agora.io to enable the service. 

## Implementation

This section shows how to implement retrieving conversations and messages.

### Retrieve a list of conversations from the server

Call `asyncFetchConversationsFromServer` to retrieve all the conversations from the server. We recommend calling this method when the app is first installed, or when there is no conversation on the local device. Otherwise, you can call `loadAllConversations` to retrieve conversations on the local device.

```java
ChatClient.getInstance().chatManager().asyncFetchConversationsFromServer(new ValueCallBack<Map<String, Conversation>>() {    
    // Add subsequent logic if retrieving conversation succeeds.
    @Override    
    public void onSuccess(Map<String, Conversation> value) {        
    }    
    // Add subsequent logic if retrieving conversation fails.
    @Override    
    public void onError(int error, String errorMsg) {      
    }
});
```

By default, the SDK retrieves the last ten conversations in the past seven days, and each conversation contains one last historical message. To adjust the time limit or the number of conversations retrieved, contact support@agora.io.

### Retrieve historial messages of the specified conversation

After retrieving conversations, you can retrieve historial messages by pagination from the server. 

To ensure data reliablity, we recommend retrieving less than 50 historical messages for each method call. To retrieve more than 50 historial messages, call this method multiple times. Once the messages are retrieved, the SDK automatically updates these messages in the local database.

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

## Next steps

After implementing retrieving messages, you can refer to the following documents to add more messaging functionalities to your app:

- [Message receipts](./agora_chat_message_receipt_android?platform=Android)