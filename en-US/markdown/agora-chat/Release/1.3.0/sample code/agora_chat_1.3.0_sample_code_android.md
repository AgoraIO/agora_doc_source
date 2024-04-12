1. Clear all conversations and messages in them

`ChatManager#asyncDeleteAllMsgsAndConversations`

```java
boolean clearServerData=true;
ChatClient.getInstance().chatManager().asyncDeleteAllMsgsAndConversations(clearServerData, new CallBack() {
    @Override
    public void onSuccess() {
        
    }

    @Override
    public void onError(int code, String error) {

    }
});

```

2. Search for messages by search scope

`ChatManager#searchMsgFromDB(String, long, int, String, Conversation.SearchDirection, Conversation.EMMessageSearchScope)`

```java
List<ChatMessage> chatMessages = ChatClient.getInstance().chatManager().searchMsgFromDB("keyword", System.currentTimeMillis(), 100, "message sender id", Conversation.SearchDirection.UP, Conversation.ChatMessageSearchScope.ALL);
```

`Conversation#searchMsgFromDB(String, long, int, String, Conversation.SearchDirection, Conversation.EMMessageSearchScope)`

```java
List<ChatMessage> chatMessages = ChatClient.getInstance().chatManager().getConversation("conversationId").searchMsgFromDB("keyword", System.currentTimeMillis(), 100, "message sender id", Conversation.SearchDirection.UP, Conversation.ChatMessageSearchScope.ALL);   
```

3. Mark a conversation

`ChatManager#asyncAddConversationMark`

```java
String conversationId = "Derry";
List<String> ids=new ArrayList<>();
ids.add(conversationId);
ChatClient.getInstance().chatManager().asyncAddConversationMark(ids, Conversation.EMMarkType.MARK_0, new CallBack() {
    @Override
    public void onSuccess() {

    }

    @Override
    public void onError(int code, String error) {

    }
});

```

`ChatManager#asyncRemoveConversationMark`

```java
String conversationId = "Derry";
List<String> ids=new ArrayList<>();
ids.add(conversationId);
ChatClient.getInstance().chatManager().asyncRemoveConversationMark(ids, Conversation.EMMarkType.MARK_0,new CallBack() {
    @Override
    public void onSuccess() {

    }

    @Override
    public void onError(int code, String error) {

    }
});

```

`ChatManager#asyncGetConversationsFromServerWithCursor`

```java
//All the query results are put into `result`.
List<Conversation> result = new ArrayList<>();
//cursor: The starting position of the query. Pass in an empty string for the first call of the method and the SDK starts to get from the conversation with the latest marked operation.
String cursor = "";
// filter: Conversation query options, including conversation marks and the number of conversations obtained per page (up to 10).
// For example, query all conversations marked with Conversation.EMMarkType.MARK_0 on the server.
ConversationFilter filter = new ConversationFilter(Conversation.EMMarkType.MARK_0, 10);
doAsyncGetConversationsFromServerWithCursor(result, cursor, filter);

private void doAsyncGetConversationsFromServerWithCursor(List<Conversation> result, @NonNull String cursor, @NonNull ConversationFilter filter) {
    ChatClient.getInstance().chatManager().asyncGetConversationsFromServerWithCursor(cursor, filter, new ValueCallBack<CursorResult<Conversation>>() {
        @Override
        public void onSuccess(CursorResult<Conversation> value) {
            List<Conversation> datas=value.getData();
            if(!CollectionUtils.isEmpty(datas)){
                result.addAll(datas);
            }
            String cursor_ = value.getCursor();
            if(!TextUtils.isEmpty(cursor_)){
                doAsyncGetConversationsFromServerWithCursor(result,cursor_,filter);
            }
        }

        @Override
        public void onError(int error, String errorMsg) {

        }
    });

```

`Gets local conversations by conversation mark`

```java
//All the query results are put into result.
List<Conversation> result=new ArrayList<>();
Map<String, Conversation> localConversations = ChatClient.getInstance().chatManager().getAllConversations();
if(localConversations!=null&&!localConversations.isEmpty()){
    for(Conversation conversation:localConversations.values()){
        Set<Conversation.EMMarkType> marks = conversation.marks();
        if(marks!=null&&!marks.isEmpty()){
            for(Conversation.EMMarkType mark:marks){
                if(mark==Conversation.EMMarkType.MARK_0){
                    result.add(conversation);
                }
            }
        }
    }
}

```

`Conversation#marks`

```java
Set<Conversation.EMMarkType> conversationMarks = ChatClient.getInstance().chatManager().getConversation("conversationId").marks();
```

4. Set whether the message is delivered only when the recipient(s) is/are online.

`ChatMessage#deliverOnlineOnly` 

```java
ChatMessage sendMessage = ChatMessage.createTextSendMessage("hello","userId");
sendMessage.deliverOnlineOnly(true);
ChatClient.getInstance().chatManager().sendMessage(sendMessage);
```

5. Allow the current user to retrieve the total number of joined groups

`GroupManager#asyncGetJoinedGroupsCountFromServer`

```java
ChatClient.getInstance().groupManager().asyncGetJoinedGroupsCountFromServer(new ValueCallBack<Integer>() {
    @Override
    public void onSuccess(Integer integer) {
        showToast("success: " + integer);
    }

    @Override
    public void onError(int code, String error) {
        showToast("error: " + error);
    }
});

```

6. Pin a message

`ChatManager#asyncPinMessage`

```java
ChatClient.getInstance().chatManager().asyncPinMessage(message.getMsgId(), new CallBack() {
    @Override
    public void onSuccess() {

    }

    @Override
    public void onError(int code, String error) {

    }

    @Override
    public void onProgress(int progress, String status) {

    }
});

```

`ChatManager#asyncUnPinMessage`

```java
ChatClient.getInstance().chatManager().asyncUnPinMessage(message.getMsgId(), new CallBack() {
    @Override
    public void onSuccess() {

    }

    @Override
    public void onError(int code, String error) {

    }

    @Override
    public void onProgress(int progress, String status) {

    }
});

```

`ChatManager#asyncGetPinnedMessagesFromServer`

```java
ChatClient.getInstance().chatManager().asyncGetPinnedMessagesFromServer(conversationId, new ValueCallBack<List<ChatMessage>>() {
    @Override
    public void onSuccess(List<ChatMessage> pinedMessages) {

    }

    @Override
    public void onError(int error, String errorMsg) {

    }
});

```

`Conversation#pinnedMessages`: Gets the list of pinned messages in a local conversation.

```java
List<ChatMessage> chatMessages = ChatClient.getInstance().chatManager().getConversation("conversationId").pinnedMessages();
```

`MessagePinInfo`: Gets pinning details of a message.

```java
MessagePinInfo emPinnedInfo = message.pinnedInfo();
if(emPinnedInfo!=null) {
    long pinTime = emPinnedInfo.pinTime();
    String operatorId = emPinnedInfo.operatorId();
}else{
    //If the value is empty, the message is in the unpinned state.
}
```

`MessageListener#onMessagePinChanged`

```java
ChatClient.getInstance().chatManager().addMessageListener(new MessageListener() {
    @Override
    public void onMessageReceived(List<ChatMessage> messages) {

    }

    @Override
    public void onMessagePinChanged(String messageId, String conversationId, MessagePinInfo.PinOperation pinOperation, MessagePinInfo pinInfo) {
        switch (pinOperation) {
            case PIN:
                // The message is pinned.
                break;
            case UNPIN:
                // The message is unpinned.
                break;
        }
    }
});

```

7. `GroupChangeListener#onRequestToJoinDeclined`

```java
ChatClient.getInstance().groupManager().addGroupChangeListener(new GroupChangeListener() {

    @Override
    public void onRequestToJoinDeclined(String groupId, String groupName, String decliner, String reason, String applicant) { 
        
    }
});
```    

8. Forward a single message 

```java
// messageId: ID of the message for forwarding.
String messageId = "";
ChatMessage targetMessage = ChatClient.getInstance().chatManager().getMessage(messageId);
// to: The peer user ID for one-to-one chat, group ID for a group chat, and chat room ID for a room chat.
String to = "the conversationId you want to send to";
ChatMessage newMessage = ChatMessage.createSendMessage(targetMessage.getType());
newMessage.setTo(to);
// chatType: ChatMessage.ChatType.Chat for one-to-one chat, ChatMessage.ChatType.GroupChat for group chat, or ChatMessage.ChatType.ChatRoom.
// The default value is `ChatMessage.ChatType.Chat`. For a group chat, add the following line.
//newMessage.setChatType(ChatMessage.ChatType.GroupChat);

// Create a new message with the body and extension fields of the original message.
MessageBody targetMessageBody = targetMessage.getBody();
newMessage.addBody(targetMessageBody);
Map<String, Object> ext = targetMessage.ext();
//Traverse extension fields.
if (ext != null) {
    for (Map.Entry<String, Object> entry : ext.entrySet()) {
        Object value = entry.getValue();
        if (value instanceof Long) {
            newMessage.setAttribute(entry.getKey(), (long) value);
        } else if (value instanceof Integer) {
            newMessage.setAttribute(entry.getKey(), (int) value);
        } else if (value instanceof String) {
            newMessage.setAttribute(entry.getKey(), (String) value);
        } else if (value instanceof Boolean) {
            newMessage.setAttribute(entry.getKey(), (boolean) value);
        } else if (value instanceof Double) {
            newMessage.setAttribute(entry.getKey(), (double) value);
        } else if (value instanceof Float) {
            newMessage.setAttribute(entry.getKey(), (float) value);
        } else if (value instanceof JSONArray) {
            newMessage.setAttribute(entry.getKey(), (JSONArray) value);
        } else if (value instanceof JSONObject) {
            newMessage.setAttribute(entry.getKey(), (JSONObject) value);
        }
    }
}
ChatClient.getInstance().chatManager().sendMessage(newMessage);
```

I provide the Easemob IM Doc here for your reference:

https://doc.easemob.com/document/ios/message_forward.html


8. Search for `loginWithAgoraToken` in the quick start and replace it with `loginWithToken`, as the former method is deprecated.


9. Dynamically load `.so` library files

To reduce the size of the app installation package, the SDK provides the `ChatOptions#setNativeLibBasePath` method to allow you to dynamically load the required `.so` files. Take the SDK 1.3.0 as an example, `.so` files include `libcipherdb.so` and `libagora-chat-sdk.so`.

Take the following steps to implement the feature:

1. Download the SDK of the latest version and decompress it.
2. Integrate `agorachat_1.3.0.jar` into your project.
3. Upload `.so` files for all architectures to your server and ensure that the app can download `.so` files for the target architecture through the Internet.
4. The app checks whether `.so` files exist during runtime. If not, the app will download the files and save them to the private directory you set for the app.
5. When you call `ChatClient#init` for SDK initialization, pass in the app's private directory that contains `.so` files to the `path` parameter in the `ChatOptions#setNativeLibBasePath` method.
6. The SDK automatically loads the `.so` files upon initialization. 

Tips:
1. This method is applicable when you integrate the SDK manually but not when you integrate the SDK with Maven Central. 
2. You can specify the path of `.so` files with the `path` parameter in the `ChatOptions#setNativeLibBasePath` method. The path must be a valid and private directory of the app.  
   - If you set this parameter, the SDK will use `System.load` to load the `.so` library from the directory you specify, so that the app dynamically loads the required .so files when it runs, thereby reducing the package size.
   - If you do not set this parameter or set it to null, the SDK will use `system.loadLibrary` to load the `.so` library from the default path, when compiling the app, thus increasing the package size compared to the previous method.
  
```java
// Assume that you have put two .so libraries, `libcipherdb.so` and `libagora-chat-sdk.so` in the /data/data/packagename/files directory of the app.
String filesPath = mContext.getFilesDir().getAbsolutePath();

ChatOptions options = new ChatOptions();
options.setNativeLibBasePath(filesPath);

ChatClient.getInstance().init(mContext, options);

```


Above is my English translation. 

Following is the Chinese version of Chat for your reference. 

动态加载 `.so` 库文件

为了减少应用安装包的大小，SDK 提供了 `ChatOptions#setNativeLibBasePath` 方法支持动态加载 SDK 所需的 `.so` 文件。以 SDK 1.3.0 为例，`.so` 文件包括 `libcipherdb.so` 和 `libagora-chat-sdk.so` 两个文件。该功能的实现步骤如下：

1. 下载最新版本的 SDK 并解压缩。
2. 集成 `agorachat_1.3.0.jar` 到你的项目中。
3. 将所有架构的 `.so` 文件上传到你的服务器，并确保应用程序可以通过网络下载目标架构的 `.so` 文件。
4. 应用运行时，会检查 `.so` 文件是否存在。如果未找到，应用会下载该 `.so` 文件并将其保存到你自定义的应用程序的私有目录中。
5. 调用 `ChatClient#init` 初始化时，将 `.so` 文件所在的 app 私有目录作为参数设置进 `ChatOptions#setNativeLibBasePath` 方法中。
6. 调用 `ChatClient#init` 初始化后，SDK 会自动从指定路径加载 `.so` 文件。

Tips
1. 该方法仅适合手动集成 Android SDK，不适用于通过 Maven Central 集成。
2. so 库的路径取决于 `ChatOptions#setNativeLibBasePath` 方法的 `path` 参数：
- `path` 参数为空或者不调用该方法时，SDK 内部会使用 `system.loadLibrary` 从系统默认路径中搜索并加载 so 库。
- `path` 参数不为空时，SDK 内部会使用 `System.load` 从设置的路径下搜索和加载 so 库。该路径必须为有效的 app 的私有目录路径。

```java
//假设用户已经通过动态下发的方式，将 SDK 中的 libcipherdb.so 和 libagora-chat-sdk.so 两个 so 库，放到 app 的 /data/data/packagename/files 目录下。 
String filesPath = mContext.getFilesDir().getAbsolutePath();

ChatOptions options = new ChatOptions();
options.setNativeLibBasePath(filesPath);

ChatClient.getInstance().init(mContext, options);

```







