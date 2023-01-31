子区消息属于群聊消息类，与普通群消息的区别是需要添加 `isChatThreadMessage` 标记。本文介绍 SDK 如何发送、接收、撤回以及获取子区消息。

## 技术原理

即时通讯 IM SDK 提供 `ChatManager`、`ChatMessage` 和 `ChatThread` 类，可以实现以下功能：

- 发送子区消息
- 接收子区消息
- 撤回子区消息
- 获取子区消息

消息收发流程如下：

![img](https://web-cdn.agora.io/docs-files/1636443945728)

1. 客户端从应用服务器获取 token。
2. 客户端 A 和 B 登录即时通讯。
3. 客户端 A 向客户端 B 发送消息。消息发送至即时通讯 IM 服务器，服务器将消息传递给客户端 B。客户端 B 收到消息后，SDK 触发事件。客户端 B 监听事件并获取消息。

## 前提条件

开始前，请确保满足以下条件：

- 初始化 1.0.3 及以上版本 SDK，详见 [Android 快速开始](./agora_chat_get_started_android)。
- 了解[使用限制](./agora_chat_limitation)。
- 在 [Agora 控制台](http://console.agora.io/) 中启用子区功能。

## 实现方法

本节介绍如何调用即时通讯 IM SDK 提供的 API 实现上述功能。

### 发送子区消息

关于发送消息的逻辑，详见 [发送消息](./agora_chat_send_receive_message_android#发送文本消息)。

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

### 接收子区消息

关于接收消息的具体逻辑，详见 [接收消息](./agora_chat_send_receive_message_android#接收文本消息)。

子区有新增消息时，子区所属群组的所有成员收到 `ChatThreadChangeListener#onChatThreadUpdated` 回调，子区成员收到 `MessageListener#onMessageReceived` 回调。

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

### 撤回子区消息

关于撤回消息逻辑，详见 [撤回消息](./agora_chat_send_receive_message_android#撤回消息)。此处只介绍子区消息和其他消息的区别。

子区有消息撤回时，子区所属群组的所有成员收到 `ChatThreadChangeListener#onChatThreadUpdated` 回调，子区成员收到 `MessageListener#onMessageRecalled` 回调，如下代码示例所示：

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

进入单个子区会话后默认展示最早消息，用户可以从服务器获取子区历史消息；若需要合并本地和服务器拉取到的消息（例如有用户撤回子区消息的提示是 SDK 在本地生成的一条消息，可以选择从本地获取子区消息。

#### 从服务器获取子区消息（消息漫游）

关于如何从服务器获取子区消息，详见 [获取历史消息](./agora_chat_retrieve_message_android#从服务器获取指定会话的历史消息)。

#### 从内存和本地数据库中获取子区会话

调用 [`getAllConversations`](./agora_chat_manage_message_android#获取本地所有会话)方法只能获取单聊或群聊会话。要获取子区会话，参考以下示例代码：

```java
// 需设置会话类型为 `ChatConversationType.GroupChat` 和 `isChatThread` 为 `true`
ChatConversation conversation = ChatClient.getInstance().chatManager().getConversation(chatThreadId, ChatConversationType.GroupChat, createIfNotExists, isChatThread);
// 获取此会话的所有内存中的消息
List<ChatMessage> messages = conversation.getAllMessages();
// 如需处理本地数据库中消息，用以下方法到数据库中获取，SDK 会将这些消息自动存入此会话
List<ChatMessage> messages = conversation.loadMoreMsgFromDB(startMsgId, pagesize, searchDirection);
```

<div class="alert note">判断当前会话是否为子区会话，可以调用 `ChatConversation#isChatThread()` 方法。</div>