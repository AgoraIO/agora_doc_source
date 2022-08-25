# 从服务器获取会话和消息

本文介绍用户如何从消息服务器获取会话和消息，该功能也称为消息漫游，指即时通讯服务将用户的历史消息保存在消息服务器上，用户即使切换终端设备，也能从服务器获取到单聊、群聊的历史消息，保持一致的会话场景。

## 技术原理

即时通讯 IM（环信）SDK 通过 `ChatManager` 类从服务器获取历史消息。以下是核心方法：

- `asyncFetchConversationsFromServer`：从服务器获取会话列表。
- `asyncFetchHistoryMessage`：从服务器获取指定会话中的历史消息。

## 前提条件

开始前，请确保满足以下条件：

- 完成 SDK 初始化，并连接到服务器，详见 [即时通讯 IM（环信）入门](https://docs.agora.io/en/agora-chat/agora_chat_get_started_android?platform=Android)。
- 了解即时通讯 [使用限制](https://docs.agora.io/en/agora-chat/agora_chat_limitation?platform=Android)。

## 实现方法

本节介绍如何实现从服务器获取会话和消息。

## 获取服务器端历史消息

调用 `asyncFetchConversationsFromServer` 方法从服务器获取所有会话。我们建议在首次安装应用或本地设备上没有会话时调用此方法。其他情况下调用 `loadAllConversations` 获取本地设备上的会话列表即可。

```java
ChatClient.getInstance().chatManager().asyncFetchConversationsFromServer(new ValueCallBack<Map<String, Conversation>>() {
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

默认情况下，SDK 会获取过去 7 天内的最后 10 个会话，每个会话包含最后一条历史消息。如需调整时间限制或会话数量，请联系 [support@agora.io](mailto:support@agora.io)。

### 分页获取指定会话的历史消息

参考如下代码，从服务器中分页获取指定会话的历史消息，单次调用最多返回 50 条消息。

你可以设置搜索方向，以服务器接收消息的时间顺序或时间倒序获取消息。

为确保数据可靠性，我们建议每次方法调用获取的历史消息少于 50 条。要获取超过 50 条历史消息，请多次调用此方法。获取到消息后，SDK 会自动在本地数据库中更新这些消息。

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

## 下一步

你可以参考以下文档为应用添加更多消息功能：

- [消息回执](https://docs.agora.io/en/agora-chat/agora_chat_message_receipt_android?platform=Android)