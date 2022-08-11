# 消息表情回复

表情符号被广泛用于实时聊天，因为它们允许用户以直接和生动的方式表达自己的感受。在 Agora Chat 中，消息表情回复（下文统称 “Reaction”）允许用户在一对一聊天和聊天组中使用表情符号快速对消息做出反应。在群聊中，Reaction 也可用于投票，例如，通过计算附加到消息的不同表情符号的数量来确认投票。

下图展示了将 Reaction 添加到消息、带有 Reaction 的对话的外观以及获取 Reaction 列表（带有相关信息）的外观。

![img](https://web-cdn.agora.io/docs-files/1655257598155)

注意：目前 Reaction 仅适用于单聊和群组。聊天室暂不支持 Reaction 功能。

## 技术原理

SDK 提供 API 来实现如下功能：

- `asyncAddReaction` 在消息上添加 Reaction；
- `asyncRemoveReaction` 删除消息的 Reaction；
- `asyncGetReactionList` 获取消息的 Reaction 列表；
- `asyncGetReactionDetail` 获取 Reaction 详情；
- `ChatMessage.getMessageReaction`：从本地数据库中的 `ChatMessage` 对象中获取 Reaction 列表。

## 前提条件

开始前，请确保满足以下条件：

- 集成 v1.0.3 及以上 Agora Chat SDK 版本，并实现了 [基本的实时聊天功能](https://docs.agora.io/en/agora-chat/agora_chat_get_started_android?platform=Android)。
- 了解 [使用限制](https://docs.agora.io/en/agora-chat/agora_chat_limitation?platform=Android)。

在 [Agora 控制台](https://console.agora.io/) 中启用聊天功能，会默认启用 Reaction 功能。

## 实现方法

### 在消息上添加 Reaction

调用 `asyncAddReaction` 在消息上添加 Reaction，在 `onReactionChanged` 监听事件中会收到这条消息的最新 Reaction 概览。

示例代码如下：

```java
// 添加 Reaction。
ChatClient.getInstance().chatManager().asyncAddReaction(message.getMsgId(), reaction, new CallBack() {
            @Override
            public void onSuccess() {

            }
            @Override
            public void onError(int error, String errorMsg) {

            }
            @Override
            public void onProgress(int i, String s) {
            }
        });

// 监听 Reaction 更新。
public class MyClass implements MessageListener {
    private void init() {
        ChatClient.getInstance().chatManager().addMessageListener(this);
    }
    @Override
    public void onReactionChanged(List<MessageReactionChange> list) {

    }
}
```

### 删除消息的 Reaction

调用 `asyncRemoveReaction` 删除消息的 Reaction，在 `onReactionChanged` 监听事件中会收到这条消息的最新 Reaction 概览。

示例代码如下：

```java
// 删除 Reaction。
ChatClient.getInstance().chatManager().asyncRemoveReaction(message.getMsgId(), reaction, new CallBack() {
            @Override
            public void onSuccess() {

            }
            @Override
            public void onError(int error, String errorMsg) {

            }
            @Override
            public void onProgress(int i, String s) {
            }
        });

// 监听 Reaction 更新。
public class MyClass implements MessageListener {
    private void init() {
        ChatClient.getInstance().chatManager().addMessageListener(this);
    }
    @Override
    public void onReactionChanged(List<MessageReactionChange> list) {

    }
}
```

### 获取消息的 Reaction 列表

调用 `asyncGetReactionLis` 可以从服务器获取指定消息的 Reaction 概览列表，列表内容包含 Reaction 内容，用户数量，用户列表（概要数据，即前三个用户信息）。示例代码如下：

```java
ChatClient.getInstance().chatManager().asyncGetReactionList(msgIdList, ChatMessage.ChatType.Chat, groupId, new ValueCallBack<Map<String, List<MessageReaction>>>() {
            @Override
            public void onSuccess(Map<String, List<MessageReaction>> stringListMap) {

            }
            @Override
            public void onError(int i, String s) {

            }
   });
```

### 获取 Reaction 详情

调用 `asyncgetReactionDetail` 可以从服务器获取指定 Reaction 的详情，包括 Reaction 内容，用户数量和全部用户列表。示例代码如下：

```java
ChatClient.getInstance().chatManager().asyncGetReactionDetail(mMsgId, emojiconId, pageCurosr, 30, new ValueCallBack<CursorResult<MessageReaction>>() {
                    @Override
                    public void onSuccess(CursorResult<MessageReaction> messageReactionCursorResult) {

                    }
                    @Override
                    public void onError(int i, String s) {

                    }
                });
```

## 下一步

[Chat UIKit](https://docs.agora.io/en/agora-chat/agora_chat_uikit_android?platform=Android) 也支持 Reaction 功能，其中包含更丰富的表情符号。你可以使用 UIKit 在项目中实现 Reaction 功能。