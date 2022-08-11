# 管理子区消息

子区消息消息类型属于群聊消息类型，与普通群组消息的区别是需要添加 `isChatThreadMessage` 标记。本文介绍 SDK 如何发送、接收以及撤回子区消息。

## 技术原理

Agora Chat SDK 提供 `ChatManager`、`ChatMessage` 和 `ChatThread` 类，可以实现以下功能：

- 发送子区消息
- 接收子区消息
- 撤回子区消息
- 获取子区消息

消息收发流程如下：

![img](https://web-cdn.agora.io/docs-files/1636443945728)

1. 客户端从应用服务器获取 token。
2. 客户 A 和客户 B 登录 Agora Chat。
3. 用户 A 向用户 B 发送消息，消息被发送到 Agora Chat 服务器，服务器将消息传递给用户 B。 B 收到消息后，SDK 触发事件。客户端 B 监听事件并获取消息。

子区创建和查看如下图：

[![img](https://docs-im.easemob.com/_media/ccim/ios/threads.png)](https://docs-im.easemob.com/_detail/ccim/ios/threads.png?id=ccim%3Aandroid%3Athread)

## 前提条件

开始前，请确保满足以下条件：

- 初始化 1.0.3 及以上版本 SDK，详见 [Android 入门](https://docs.agora.io/en/agora-chat/agora_chat_get_started_android)。
- 了解 [使用限制](https://docs.agora.io/en/agora-chat/agora_chat_limitation)。
- 在 [Agora 控制台](http://console.agora.io/) 中启用子区功能。

## 实现方法

本节介绍如何调用 Agora Chat SDK 提供的 API 实现上述功能。

### 发送子区消息

发送子区消息和发送群组消息的方法基本一致。区别在于 `isChatThreadMessage` 字段，如以下代码所示：

```java
// 创建一条文本消息，`content` 为消息文字内容，`chatThreadId` 为子区 ID。
ChatMessage message = ChatMessage.createTxtSendMessage(content, chatThreadId);
// 设置消息类型，子区消息需要将 `ChatType` 设置为 `GroupChat`。
message.setChatType(ChatType.GroupChat);
// 设置消息标记 `isChatThreadMessage` 为 `true`。
message.setisChatThreadMessage(true);
// 调用 `setMessageStatusCallback` 获得消息发送的状态。可以在该回调中更新消息的显示状态。例如消息发送失败后的提示等等。
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
// 发送消息。
ChatClient.getInstance().chatManager().sendMessage(message);
```

有关发送消息的更多信息，详见 [发送消息](https://docs.agora.io/en/agora-chat/agora_chat_message_android?platform=Android#send-and-receive-messages)。

### 接收子区消息

接收消息的具体逻辑，请参考 [接收消息](https://docs.agora.io/en/agora-chat/agora_chat_message_android?platform=Android#send-and-receive-messages)。

子区有新增消息时，子区所属群组的所有成员收到 `ChatThreadChangeListener#onChatThreadUpdated` 回调，子区成员收到 `MessageListener#onMessageReceived`回调。

示例代码如下：

```java
MessageListener msgListener = new MessageListener() {
   // 收到消息，遍历消息队列，解析和显示。
   @Override
   public void onMessageReceived(List<ChatMessage> messages) {
       for (ChatMessage message : messages) {
           if(message.isChatThreadMessage()) {
               // 接收到子区消息，添加处理逻辑。
           }
       }
   }
   ...// 其他回调，此处省略。
};
// 添加消息监听器。
ChatClient.getInstance().chatManager().addMessageListener(msgListener);
// 移除消息监听器。
ChatClient.getInstance().chatManager().removeMessageListener(msgListener);
```

有关接收消息的更多信息，请参阅[接收消息](https://docs.agora.io/en/agora-chat/agora_chat_message_android?platform=Android#send-and-receive-messages)。

### 撤回子区消息

接收消息的具体逻辑，请参考 [撤回消息](https://docs.agora.io/en/agora-chat/agora_chat_message_android?platform=Android#recall-messages)，此处只介绍子区消息和其他消息的区别。

子区有消息撤回时，子区所属群组的所有成员收到 `ChatThreadChangeListener#onChatThreadUpdated` 回调，子区成员收到 `MessageListener#onMessageRecalled`回调，如下代码示例所示：

```java
MessageListener msgListener = new MessageListener() {
   // 收到撤回消息回调，遍历消息队列，解析和显示。
   @Override
   public void onMessageRecalled(List<ChatMessage> messages) {
       for (ChatMessage message : messages) {
           if(message.isChatThreadMessage()) {
               // 接收到子区消息被撤回，添加处理逻辑。
           }
       }
   }
   ...
};
```

### 获取子区消息

从服务器还是本地数据库获取子区消息取决于你的生产环境。

进入单个子区会话后默认展示最早消息，用户可以从服务器获取子区历史消息；当你需要合并处理本地和服务器拉取到的消息（例如有用户撤回子区消息的提示是 SDK 在本地生成的一条消息）的时候，可以选择从本地获取子区消息。

#### 从服务器获取子区消息（消息漫游）

关于如何从服务器获取子区消息，详见 [历史消息](https://docs.agora.io/en/agora-chat/agora_chat_message_android?platform=Android#retrieve-historical-messages-from-the-server)。

#### 管理本地子区消息

通过调用 [`getAllConversations`](https://docs.agora.io/en/agora-chat/agora_chat_message_android#retrieve-local-conversations)，您只能检索一对一聊天或群聊的对话。要检索线程的对话，请参阅以下代码示例：

```java
// 需要指定会话类型为 `ChatConversationType.GroupChat`，且 `isChatThread` 设置为 `true`
ChatConversation conversation = ChatClient.getInstance().chatManager().getConversation(chatThreadId, ChatConversationType.GroupChat, createIfNotExists, isChatThread);
// 获取此会话的所有内存中的消息
List<ChatMessage> messages = conversation.getAllMessages();
// 如需处理本地数据库中消息，用以下方法到数据库中获取，SDK 会将这些消息自动存入此会话
List<ChatMessage> messages = conversation.loadMoreMsgFromDB(startMsgId, pagesize, searchDirection);
```

**注意：**

- 判断当前会话是否是子区会话，可以通过 `ChatConversation#isChatThread()` 进行判断。