表情符号被广泛用于实时聊天，允许用户以直接和生动的方式表达自己的感受。在即时通讯 IM 中，消息表情回复（下文统称 “Reaction”）允许用户在单聊和群聊中使用表情符号对消息进行快速回复。在群聊中，Reaction 也可用于投票，例如，计算对消息回复的各种表情符号的数量确认投票。

下图展示如何将 Reaction 添加到消息、添加了 Reaction 的会话以及获取 Reaction 列表（带有相关信息）。

![img](https://web-cdn.agora.io/docs-files/1655257598155)

<div class="alert note">目前 Reaction 仅适用于单聊和群组，暂不适用于聊天室。</div>

本页介绍如何使用即时通讯 IM SDK 在项目中实现 Reaction 功能。

## 技术原理

SDK 提供 API 实现如下功能：

- `asyncAddReaction` 在消息上添加 Reaction；
- `asyncRemoveReaction` 删除消息的 Reaction；
- `asyncGetReactionList` 获取消息的 Reaction 列表；
- `asyncGetReactionDetail` 获取指定 Reaction 的详情；
- `ChatMessage.getMessageReaction`：从本地数据库中的 `ChatMessage` 对象中获取 Reaction 列表。

## 前提条件

开始前，请确保满足以下条件：

- 集成 v1.0.3 及以上即时通讯 IM SDK 版本，并实现了 [基本的实时聊天功能](./agora_chat_get_started_android)。
- 了解 [使用限制](./agora_chat_limitation)。

所有版本的 [套餐包](./agora_chat_plan) 都支持 Reaction 功能，因此在 [Agora 控制台](https://console.agora.io/) 中启用即时通讯 IM 会默认开启 Reaction 功能。

## 实现方法

### 在消息上添加 Reaction

调用 `asyncAddReaction` 方法在消息上添加 Reaction，在 `onReactionChanged` 监听事件中会收到该消息的最新 Reaction 概览。

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

调用 `asyncRemoveReaction` 删除指定消息的 Reaction，在 `onReactionChanged` 监听事件中会收到该消息的最新 Reaction 概览。

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

调用 `asyncGetReactionList` 可以从服务器获取指定消息的 Reaction 概览列表，列表内容包含 Reaction 内容，添加或移除 Reaction 的用户数量，以及添加或移除 Reaction 的前三个用户的用户 ID。示例代码如下：

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

调用 `asyncGetReactionDetail` 可以从服务器获取指定 Reaction 的详情，包括 Reaction 内容，添加或移除 Reaction 的用户数量以及添加或移除 Reaction 的全部用户列表。示例代码如下：

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

## 后续步骤

[即时通讯 IM UIKit](./agora_chat_uikit_android) 也支持 Reaction 功能，其中包含更丰富的表情符号。你可以使用 UIKit 在项目中实现 Reaction 功能。