# 管理本地消息

在聊天应用程序中，对话由点对点聊天、聊天组或聊天室中的所有消息组成。即时通讯 IM（环信）SDK 支持按会话管理消息，包括检索和管理未读消息、删除本地设备上的历史消息、查找历史消息。

本页介绍如何使用即时通讯 IM（环信）SDK 实现这些功能。

## 了解技术

即时通讯 IM（环信）SDK 通过 `ChatManager` 类管理用户设备上存储的消息会话数据。以下是核心方法：

- `loadAllConversations`：加载本地存储的会话列表;
- `deleteConversation`： 删除本地存储的会话；
- `Conversation.getUnreadMsgCount`：获取指定会话的未读消息数；
- `getUnreadMessageCount`：获取所有未读消息数；
- `deleteConversation`：从服务器删除指定会话和历史消息。
- `searchMsgFromDB`：从本地数据库中搜索历史消息。
- `Conversation.insertMessages`：在指定会话中插入消息。

## 前提条件

开始前，请确保满足以下条件：

- 已 [集成即时通讯 IM（环信）SDK](./agora_chat_get_started_android?platform=Android#集成-agora-chat-sdk)。
- 了解消息相关限制和即时通讯 IM（环信）API 的调用频率限制，详见 [限制条件](./agora_chat_limitation_android?platform=Android)。

## 实现方法

本节介绍如何实现管理消息。

### 获取本地所有会话

调用 `loadAllConversations` 方法获取本地所有会话：

```java
Map<String, Conversation> conversations = ChatClient.getInstance().chatManager().getAllConversations();
```

如果出现偶尔返回的 `conversations` 的 `size` 为 `0`，很有可能是未调用 `ChatClient.getInstance().chatManager().loadAllConversations()`。

### 从本地数据库中读取指定会话的消息

参考如下代码，从本地数据库中获取指定会话中的消息：

```java
Conversation conversation = ChatClient.getInstance().chatManager().getConversation(username);
// 获取指定会话中的所有消息
List<ChatMessage> messages = conversation.getAllMessages();
// SDK 初始化时，为每个会话加载 1 条聊天记录。如需更多消息，请到数据库中获取。该方法获取 `startMsgId` 之前的 `pagesize` 条消息，SDK 会将这些消息自动存入此会话，app 无需添加到会话中。
List<ChatMessage> messages = conversation.loadMoreMsgFromDB(startMsgId, pagesize);
```

### 获取指定会话的未读消息数量

参考如下代码，获取指定会话的未读消息数量：

```java
Conversation conversation = ChatClient.getInstance().chatManager().getConversation(username);
conversation.getUnreadMsgCount();
```

### 获取所有会话的未读消息数量

参考如下代码，获取应用中所有会话的未读消息数量：

```java
ChatClient.getInstance().chatManager().getUnreadMessageCount();
```

### 指定会话的未读消息数清零

参考如下代码，清零指定的会话或所有会话的未读消息：

```java
Conversation conversation = ChatClient.getInstance().chatManager().getConversation(username);
// 指定会话消息未读数清零。
conversation.markAllMessagesAsRead();
// 将一条消息置为已读。
conversation.markMessageAsRead(messageId);
// 将所有未读消息数清零。
ChatClient.getInstance().chatManager().markAllConversationsAsRead();
```

### 删除会话及聊天记录

SDK 提供两个接口，分别可以删除本地会话和聊天记录或者删除当前用户在服务器端的会话和聊天记录。

- 删除本地会话和聊天记录

要同时在本地设备上删除会话和消息，请调用 `deleteConversation` 和 `removeMessage`：

```java
// 删除与指定用户的会话。
ChatClient.getInstance().chatManager().deleteConversation(username, true);
// 删除当前会话的指定历史消息。
Conversation conversation = ChatClient.getInstance().chatManager().getConversation(username);
conversation.removeMessage(deleteMsg.msgId);
```

- 删除服务器端会话和聊天记录

```java
// 删除指定会话，如果需要保留聊天记录，`isDeleteServerMessages` 传 `false`。
ChatClient.getInstance().chatManager().deleteConversationFromServer(conversationId, conversationType, isDeleteServerMessages, new CallBack() {
            @Override
            public void onSuccess() {

            }

            @Override
            public void onError(int code, String error) {

            }
        });
```
### 搜索会话消息

调用 `searchMsgFromDB` 按关键字、时间戳和消息发送方搜索消息：

```java
List<ChatMessage> messages = conversation.searchMsgFromDB(keywords, timeStamp, maxCount, from, Conversation.SearchDirection.UP);
```

### 导入消息

调用 `importMessages` 以将多条消息导入指定对话。这适用于聊天用户想要将历史消息导入到本地数据库中的场景。

```java
ChatClient.getInstance().chatManager().importMessages(msgs);
```

### 插入消息

如果你需要在本地会话中加入一条消息，比如收到某些通知消息时，可以构造一条消息写入会话。

例如插入一条无需发送但有需要显示给用户看的内容，类似 “XXX 撤回一条消息”、“XXX 入群”、“对方正在输入” 等。
示例代码如下：

```java
// 将消息插入到指定会话中。
Conversation conversation = ChatClient.getInstance().chatManager().getConversation(username);
conversation.insertMessage(message);
// 直接插入消息。
ChatClient.getInstance().chatManager().saveMessage(message);
```

### 更新消息到 SDK 本地数据库

如果需要更新消息可以选用以下方法的任意一种：

```java
// 直接通过 `ChatManager` 更新 SDK 本地数据库消息
ChatClient.getInstance().chatManager().updateMessage(message);

// 先获取会话，再更新 SDK 本地数据库会话中的消息
Conversation conversation = ChatClient.getInstance().chatManager().getConversation(conversationId);
conversation.updateMessage(message);
```

## 下一步

实现消息管理后，您可以参考以下文档为应用添加更多消息功能：

- [从服务器获取会话和消息](https://docs.agora.io/en/agora-chat/agora_chat_retrieve_message_android?platform=Android)
- [消息回执](https://docs.agora.io/en/agora-chat/agora_chat_message_receipt_android?platform=Android)