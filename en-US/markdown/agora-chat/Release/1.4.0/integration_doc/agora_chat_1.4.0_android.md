## 1. 发送和接收 GIF 图片消息

### 发送 GIF 图片消息

- 自 Android SDK 1.4.0 开始，支持发送 GIF 图片消息。
- GIF 图片消息是一种特殊的图片消息，与普通图片消息不同，**GIF 图片发送时不能压缩**。
- 图片缩略图的生成与普通图片消息相同，详见 [发送图片消息](#发送图片消息)。

发送 GIF 图片消息的过程如下：

1. 发送方调用 `ChatMessage#createGifImageMessage` 方法构造 GIF 图片消息体。
2. 发送方调用 `ChatManager#sendMessage` 发送 GIF 图片消息。SDK 会将图片上传至 Agora Chat 服务器，服务器自动生成图片缩略图。

```java
// `imageUri` 为图片本地资源标志符
ChatMessage message = ChatMessage.createGifImageMessage(imageUri, toChatUsername);
// 设置会话类型，即`ChatMessage` 类的 `ChatType` 属性，包含 `Chat`、`GroupChat` 和 `ChatRoom`，表示单聊、群聊或聊天室，默认为单聊。
// message.setChatType(ChatMessage.ChatType.GroupChat);
// 发送消息
ChatClient.getInstance().chatManager().sendMessage(message);
```

### 接收 GIF 图片消息

自 Android SDK 1.4.0 开始，支持接收 GIF 图片消息。

图片缩略图的下载与普通图片消息相同，详见 [接收图片消息](#接收图片消息)。

与普通消息相同，接收 GIF 图片消息时，接收方会收到 `onMessageReceived` 回调方法。接收方判断为图片消息后，读取消息体的 `isGif` 属性，若值是 `YES`， 则为 GIF 图片消息。

```java
public void onMessageReceived(List<ChatMessage> messages) {
    for(ChatMessage message : messages) {
        if (message.getType() == ChatMessage.Type.IMAGE) {
            ImageMessageBody body = (ImageMessageBody) message.getBody();
            if(body.isGif()) {
                // 根据业务情况处理gif message, 例如下载展示该消息
            }
        }
    }
    
}
```

## 2. 管理群组头像

自 Android SDK 1.4.0 开始，支持群组头像功能。

### 设置群组头像

- 创建群组时，可设置群组头像：

```java
GroupOptions option = new GroupOptions();
option.maxUsers = 100;
option.style = GroupManager.GroupStyle.GroupStylePrivateMemberCanInvite;
// 同步方法，会阻塞当前线程。
// 异步方法为 asyncCreateGroup(String, String, String, String[], String, GroupOptions, ValueCallBack)。
ChatClient.getInstance().groupManager().createGroup(groupName, avatar,  desc, allMembers, reason, option);
```

- 创建群组后，若设置群组头像，可调用 [修改群组头像](#修改群组头像) API 设置头像。

### 修改群组头像

创建群组完成后，群主或管理员可调用 `GroupManager#changeGroupAvatar` 设置或修改群组头像：

```java
// 同步方法，会阻塞当前线程。
// 异步方法为 asyncChangeGroupAvatar(String, String, CallBack)。
ChatClient.getInstance().groupManager().changeGroupAvatar(groupId,changedAvatar);
```

群组头像被修改后，其他群成员会收到 `GroupChangeListener#onSpecificationChanged` 回调：

```java
GroupChangeListener#onSpecificationChanged(Group group)
```

### 获取群组头像

群成员可以通过获取群详情的方法 `GroupManager#getGroupFromServer`，获取群组头像：

```java
// 根据群组 ID 从服务器获取群组详情。
// 同步方法，会阻塞当前线程。异步方法为 asyncGetGroupFromServer(String, ValueCallBack)。
Group group = ChatClient.getInstance().groupManager().getGroupFromServer(groupId);
String avatar = group.getGroupAvatar();
```

## 3. 聊天室成员加入禁言列表事件

请在 Android 端的 [Manage chat rooms 文档中的 Listen for chat room events 一节中](https://docs.agora.io/en/agora-chat/client-api/chat-room/manage-chatrooms?platform=android#listen-for-chat-room-events) 更新 `onMuteListAdded` 事件：

```java
    // 有成员被加入禁言列表。被添加的成员收到该事件。
    void onMuteListAdded(final String chatRoomId, Map<String,Long> muteInfo);
```

## 4. 从服务器获取指定群成员发送的消息

自 1.4.0 版本开始，对于单个群组会话，你可以从服务器获取指定成员（而非全部成员）发送的消息。

```java
String conversationId = " ";
Conversation.ConversationType type = Conversation.ConversationType.Chat;
FetchMessageOption option = new FetchMessageOption();
//例如，设置获取的消息保存到数据库。
//option.setIsSave(true);
//例如，你可以获取群组中某2个用户ID的消息
//List<String> fromIds = new ArrayList<String>();
//fromIds.add("user1");
//fromIds.add("user2");
//option.setFromIds(fromIds);
int pageSize = 40;
String cursor = "";
List<ChatMessage> messages = new ArrayList<>();
doAsyncFetchHistoryMessages(conversationId, type, pageSize, cursor, option, messages);

private void doAsyncFetchHistoryMessages(String conversationId,
        Conversation.ConversationType type,
int pageSize,String cursor,
        FetchMessageOption option,
        List<ChatMessage> messages){
    ChatClient.getInstance().chatManager().asyncFetchHistoryMessages(conversationId, type, pageSize, 
                                cursor, option, new ValueCallBack<CursorResult<ChatMessage>>() {
        @Override
        public void onSuccess(CursorResult<ChatMessage> value) {
            if (value != null ) {
                List<ChatMessage> list = value.getData();
                if (list != null && list.size() > 0) {
                    messages.addAll(list);
                }
                String newCursor = value.getCursor();
                if( !TextUtils.isEmpty(newCursor)) {
                    doAsyncFetchHistoryMessages(conversationId, type, pageSize, newCursor, option, messages);
                }
            }
        }

        @Override
        public void onError(int error, String errorMsg) {

        }
    });
}

```

## 5. 从本地获取指定群成员发送的消息

自 1.4.0 版本开始，对于单个群组会话，你可以从本地获取指定成员（而非全部成员）发送的消息。

```java
String conversationId = "user_or_group_id";
Conversation conversation = ChatClient.getInstance()
        .chatManager()
        .getConversation(conversationId);
if (conversation != null) {
    String keywords = "hello";
    long timeStamp = -1; // 小于 0 表示从当前时间开始搜索
    int maxCount = 20;
    // 限制发送人，最多 10 个；如果不限制发送人，传 null 或空列表
    List<String> senders = Arrays.asList("user1", "user2");
    conversation.asyncSearchMsgFromDB(
            keywords,
            timeStamp,
            maxCount,
            senders,
            Conversation.SearchDirection.UP,
            Conversation.ChatMessageSearchScope.CONTENT,
            new ValueCallBack<List<ChatMessage>>() {
                @Override
                public void onSuccess(List<ChatMessage> messages) {
                    for (ChatMessage message : messages) {
                        String msgId = message.getMsgId();
                        String from = message.getFrom();
                        long msgTime = message.getMsgTime();
                        // TODO: 处理搜索结果
                    }
                }

                @Override
                public void onError(int code, String error) {
                    // TODO: 处理错误
                }
            }
    );
}
```

## 6. 根据关键字获取本地会话中的消息

自 SDK 1.4.0 版本开始，你可以通过设置关键词获取本地会话中的某些消息。SDK 返回会话 ID 及消息 ID 列表，消息 ID 根据你设置的 `direction` 参数按照消息时间戳的正序或倒序列明。

```java
String keyword="Time";
ChatClient.getInstance().chatManager().asyncLoadConversationMessagesWithKeyword(keyword, -1, null, Conversation.SearchDirection.UP, Conversation.ChatMessageSearchScope.CONTENT, new ValueCallBack<Map<String, List<String>>>() {
    @Override
    public void onSuccess(Map<String, List<String>> value) {
        EMLog.e(TAG, "asyncLoadConversationMessagesWithKeyword onSuccess value:" + value);
    }

    @Override
    public void onError(int error, String errorMsg) {
        EMLog.e(TAG,"asyncLoadConversationMessagesWithKeyword onError error:" + error + " errorMsg:" + errorMsg);
    }
});

```

## 7. 根据消息 ID 获取本地消息

自 SDK 1.4.0 版本开始，你可以传入单个或多个消息 ID 获取单个本地会话中的消息。

```java
// messageIds：消息 ID 列表。每次最多可传入 20 个消息 ID。
ChatClient.getInstance().chatManager().asyncLoadMessages(messageIds, conversationId, new ValueCallBack<List<ChatMessage>>() {
        @Override
        public void onSuccess(List<ChatMessage> value) {
            EMLog.e(TAG, "asyncLoadMessages onSuccess value:" + value);
        }

        @Override
        public void onError(int error, String errorMsg) {
            EMLog.e(TAG, "asyncLoadMessages onError error:" + error + " errorMsg:" + errorMsg);
        }
    });
```

## 8. 批量通知群成员进出群

1. 请在 Chat Android 端的 [Manage chat group 页面](https://docs.agora.io/en/agora-chat/client-api/chat-group/manage-chat-groups?platform=android#listen-for-chat-group-events)  的 "Listen for chat group events" 中添加进出群组的新事件，并移掉旧事件。

```java
// 有新成员（单个或多个）加入群组。除了新成员，其他群成员会收到该回调。
    @Override
    public void onMembersJoined(final String groupId, final List<String> members) {
    }

// 有成员（单个或多个）退出群（主动或被动）。除了退群的成员，其他群成员会收到该回调。
    @Override
    public void onMembersExited(final String groupId,  final List<String> members) {
    }
```

2. 此外，请在 Chat Android 端的 [Manage chat group 页面](https://docs.agora.io/en/agora-chat/client-api/chat-group/manage-chat-groups?platform=android) 中搜索所有的旧事件，用新事件进行替换。

## 9. 修改消息

对于单聊、群组和聊天室聊天会话中已经发送成功的消息，SDK 支持对这些消息的内容进行修改。

- SDK 1.4.0 之前的版本仅支持对单聊和群组会话中发送后的文本消息进行修改。
- SDK 1.4.0 及之后版本支持对单聊、群组和聊天室会话中各类消息进行修改：
  - 文本/自定义消息：支持修改消息内容（body）和扩展字段 `ext`。
  - 文件/视频/音频/图片/位置/合并转发消息：只支持修改消息扩展字段 `ext`。
  - 命令消息：不支持修改。

```java
// 文本消息：可同时修改消息体和消息扩展属性
TextMessageBody textBody = new TextMessageBody("new content");
Map<String, Object> ext = new HashMap<>();
ext.put("newkey", "new value");

// textBody 和 ext 不能同时为 null
ChatClient.getInstance().chatManager().asyncModifyMessage(this.messageId, textBody, ext, new ValueCallBack<ChatMessage>() {
            @Override
            public void onSuccess(ChatMessage emMessage) {
                // 修改成功
            }

            @Override
            public void onError(int i, String s) {
                // 修改失败
            }
        });


// 自定义消息：可同时修改消息体和消息扩展属性
CustomMessageBody customBody = new CustomMessageBody("new action");
Map<String, Object> newExt = new HashMap<>();
newExt.put("newkey1", "newkey1");
newExt.put("newkey2", 123);

ChatClient.getInstance().chatManager().asyncModifyMessage(this.messageId, customBody, newExt, new ValueCallBack<ChatMessage>() {
            @Override
            public void onSuccess(ChatMessage emMessage) {
                // 修改成功
            }

            @Override
            public void onError(int i, String s) {
                // 修改失败
            }
        });
        

// 文件/视频/音频/图片/位置/合并转发消息：只能修改消息扩展属性
Map<String, Object> newExt = new HashMap<>();
newExt.put("newkey1", false);
newExt.put("newkey2", "new value");

ChatClient.getInstance().chatManager().asyncModifyMessage(this.messageId, null, newExt, new ValueCallBack<ChatMessage>() {
            @Override
            public void onSuccess(ChatMessage emMessage) {
                // 修改成功
            }

            @Override
            public void onError(int i, String s) {
                // 修改失败
            }
        });
```

## 10. 撤回消息

- 对于单聊会话，只支持发送方撤回发送成功的消息。若消息过期，撤回失败。
- 对于群组/聊天室会话，普通成员只能撤回自己发送的消息，若消息过期，撤回失败。自 SDK 1.4.0 开始，群主/聊天室所有者和管理员可撤回其他用户发送的消息，即使消息过期也能撤回。

## 11. Token 即将过期回调触发时机变化

```java
ConnectionListener connectionListener = new ConnectionListener() {
    @Override
    // 自 1.4.0 版本，SDK 会在 Token 有效期达到 80% 时回调即将过期通知（之前版本为 50%）。
    public void onTokenWillExpire() {

    }
};

```

## 12. 群成员列表包含群成员的用户 ID、加群时间和成员角色

自 1.4.0 版本开始，你可调用 `asyncFetchGroupMembersInfo` 方法获取全部群成员（包括群主和群管理员）的信息，包括群成员的用户 ID、加群时间和成员角色。

```java
ChatClient.getInstance().groupManager().asyncFetchGroupMembersInfo(groupId, null, 50, new ValueCallBack<CursorResult<GroupMemberInfo>>() {
            @Override
            public void onSuccess(CursorResult<GroupMemberInfo> value) {
                List<GroupMemberInfo> list = value.getData();
                for (GroupMemberInfo groupMemberInfo : list) {
                    //获取群成员的用户 ID、加群时间和成员角色
                    String id = groupMemberInfo.getMemberId();
                    long joinTime = groupMemberInfo.getJoinTime();
                    Group.GroupPermissionType role = groupMemberInfo.getRole();
                }
            }

            @Override
            public void onError(int error, String errorMsg) {

            }
        });
```