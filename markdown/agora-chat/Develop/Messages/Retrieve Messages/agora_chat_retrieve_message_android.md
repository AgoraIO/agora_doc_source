即时通讯 IM 提供消息漫游功能，即将用户的所有会话的历史消息保存在消息服务器，用户在任何一个终端设备上都能获取到历史信息，使用户在多个设备切换使用的情况下也能保持一致的会话场景。

本文介绍用户如何获取和删除服务端的会话和消息。

## 技术原理

即时通讯 IM SDK 通过 `ChatManager` 类从服务器获取历史消息。以下是核心方法：

- `asyncFetchConversationsFromServer` 分页获取会话列表以及会话中的最新一条消息；
- `asyncFetchHistoryMessage` 按服务器接收消息的时间顺序获取服务器上保存的指定会话中的消息；
- `removeMessagesFromServer` 单向删除服务端的历史消息；
- `deleteConversationFromServer` 删除服务器端会话和历史消息。

## 前提条件

开始前，请确保满足以下条件：

- 完成 SDK 初始化，并连接到服务器，详见 [Android 快速开始](./agora_chat_get_started_android)。
- 了解即时通讯 IM API 的调用频率限制，详见 [限制条件](./agora_chat_limitation)。

## 实现方法

本节介绍如何实现从服务器获取会话和消息。

## 从服务器分页获取会话列表

你可以调用 `asyncFetchConversationsFromServer` 方法从服务端分页获取会话列表，每个会话包含最新一条历史消息。我们建议你在首次安装应用或本地设备上没有会话时调用此方法，其他情况下调用 `getAllConversations` 方法获取本地设备上的会话列表。

```java
// pageNum：当前页面，从 1 开始。
// pageSize：每页获取的会话数量。取值范围为 [1,20]。
ChatClient.getInstance().chatManager().asyncFetchConversationsFromServer(pageNum, pageSize, new ValueCallBack<Map<String, Conversation>>() {
    // 获取会话成功处理逻辑。
    @Override
    public void onSuccess(Map<String, Conversation> value) {

    }
    // 获取会话失败处理逻辑。
    @Override
    public void onError(int error, String errorMsg) {

    }
});
```

对于使用 `asyncFetchConversationsFromServer` 方法未实现分页获取会话的用户，SDK 默认可拉取 7 天内的 10 个会话，每个会话包含最新一条历史消息。如需调整时间限制或会话数量，请联系 [support@agora.io](mailto:support@agora.io)。

### 从服务器获取指定会话的历史消息

你可以调用 `asyncFetchHistoryMessage` 方法从服务器获取指定会话的消息（消息漫游）。你可以指定消息查询方向，即明确按服务器接收消息的时间顺序或时间倒序获取消息。为确保数据可靠，我们建议你每次获取少于 50 条消息，可多次获取。拉取后默认 SDK 会自动将消息更新到本地数据库。

```java
ChatClient.getInstance().chatManager().asyncFetchHistoryMessage(conversationId, conversationType, pageSize, startMsgId, new ValueCallBack<CursorResult<ChatMessage>>() {
            @Override
            public void onSuccess(CursorResult<ChatMessage> value) {

            }

            @Override
            public void onError(int error, String errorMsg) {

            }
        });
```

### 单向删除服务端的历史消息

你可以调用 `removeMessagesFromServer` 方法单向删除服务端的历史消息，每次最多可删除 50 条消息。消息删除后，该用户无法从服务端拉取到该消息。其他用户不受该操作影响。已删除的消息自动从设备本地移除。

示例代码如下：

```java
Conversation conversation = ChatClient.getInstance().chatManager().getConversation(username);
// 按时间戳删除历史消息
conversation.removeMessagesFromServer(beforeTimeStamp, new CallBack() {
    @Override
    public void onSuccess() {
    }
    @Override
    public void onError(int code, String error) {
    }
});
// 按消息 ID 删除历史消息
conversation.removeMessagesFromServer(msgIdList, new CallBack() {
    @Override
    public void onSuccess() {
        
    }
    @Override
    public void onError(int code, String error) {
    }
});
```

### 删除服务端会话及其历史消息

你可以调用 `deleteConversationFromServer` 方法删除服务器端会话和历史消息。会话删除后，当前用户和其他用户均无法从服务器获取该会话。若该会话的历史消息也删除，所有用户均无法从服务器获取该会话的消息。

示例代码如下：

```java
ChatClient.getInstance().chatManager().deleteConversationFromServer(conversationId, conversationType, isDeleteServerMessage, new CallBack() {
    @Override
    public void onSuccess() {
        
    }
    
    @Override
    public void onError(int code, String error) {

    }
});
```

## 后续步骤

你可以参考以下文档为应用添加更多消息功能：

- [消息回执](./agora_chat_message_receipt_android)