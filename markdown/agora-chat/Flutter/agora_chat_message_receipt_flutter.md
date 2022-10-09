用户在单聊和群聊中发送完信息后，可以查看该信息的送达和已读状态，了解接收方是否及时收到并阅读了信息。

本文介绍如何使用即时通讯 IM Flutter SDK 的消息已读回执和送达回执在 app 中实现上述功能。

## 技术原理

即时通讯 IM Flutter SDK 用 `ChatManager` 类提供消息回执功能，包括消息送达回执和已读回执。以下是核心方法：

- `ChatOptions.requireDeliveryAck`：送达回执的全局开关。
- `ChatOptions.requireAck`：已读回执的全局开关。
- `ChatManager.sendConversationReadAck`：发送会话的已读回执。
- `ChatManager.sendMessageReadAck`：发送单聊消息已读回执。
- `ChatManager.sendGroupMessageReadAck`：发送群聊消息已读回执。

实现送达和已读回执的逻辑分别如下：

- 消息送达回执
  1. 消息发送方在发送消息前通过设置 `ChatOptions.requireDeliveryAck` 为 `true` 启用送达回执功能。
  2. 消息接收方收到消息后，SDK 自动向发送方触发送达回执。
  3. 消息发送方通过监听 `onMessageDelivered` 接收消息送达回执。

- 会话及消息已读回执
  1. `ChatOptions.requireAck`消息发送者通过设置为启用阅读回执`true`。
  2. 阅读完留言后，收件人会打电话`sendConversationReadAck`或`sendMessageReadAck`发送对话或留言阅读回执。
  3. 发件人通过侦听`onConversationRead`或来接收对话或消息回执`onMessagesRead`。

## 先决条件

在继续之前，请确保您满足以下要求：

- 完成 SDK 初始化，并连接到服务器，详见 [快速开始](./agora_chat_get_started_flutter)。
- 了解 [使用限制](./agora_chat_limitation)。
- 默认情况下不启用群组的消息已读回执。要使用此功能，请联系 [support@agora.io](mailto:support@agora.io)。

## 实现方法

### 消息送达回执

1. 发送方开启全局送达回执。当接收方收到消息后，SDK 底层会自动进行消息送达回执。即初始化 SDK 时，`ChatOptions` 中设置 `requireDeliveryAck` 为 `true` 在发送方的客户端上。

   ```dart
    // App Key
    String appKey = "appKey";
    // 开启消息送达回执
    bool requireDeliveryAck = true;
    ChatOptions options = ChatOptions(
    appKey: appKey,
    requireDeliveryAck: requireDeliveryAck,
    );
    await ChatClient.getInstance.init(options);
   ```

2. 发送方监听事件 `onMessagesDelivered` 回调，收到接收方的送达回执。

   ```dart
    // 添加监听器
    ChatClient.getInstance.chatManager.addEventHandler(
      "UNIQUE_HANDLER_ID",
      ChatEventHandler(
        onMessagesDelivered: (messages) {},
      ),
    );
   ```

### 消息和会话的已读回执

消息已读回执用于告知单聊或群聊中的用户接收方已阅读其发送的消息。为降低消息已读回执方法的调用次数，SDK 还支持在单聊中使用会话已读回执功能，用于获知接收方是否阅读了会话中的未读消息。

#### 单聊

单聊既支持消息已读回执，也支持会话已读回执。我们建议你按照如下逻辑结合使用两种回执结合使用，减少发送消息已读回执数量。

- 聊天页面未打开时，若有未读消息，进入聊天页面，发送会话已读回执；
- 聊天页面打开时，若收到消息，发送消息已读回执。

##### 会话已读回执

参考如下步骤在单聊中实现会话已读回执。

1. 初始化 SDK 时，`ChatOptions` 中设置 `requireAck` 为 `true` 开启全局的消息已读回执开关。如果全局设置不开启，消息和会话的相应设置也无法生效。

   ```dart
    ChatOptions options = ChatOptions(
    appKey: "<#Your AppKey#>",
    requireAck: true,
    );
    ChatClient.getInstance.init(options);
   ```

2. 接收方执行会话已读回执操作。进入会话页面，查看会话中是否有未读消息。若有，调用 `sendConversationReadAck` 发送会话已读回执，没有则不再发送。

   ```dart
    String convId = "convId";
    try {
    await ChatClient.getInstance.chatManager.sendConversationReadAck(convId);
    } on ChatError catch (e) {
    // Sending conversation read receipts fails. See e.code for the error code and e.description for the error description.
    }
   ```

3. 发送方监听 `onConversationRead` 回调，接收会话已读回执。

   ```dart
    ChatClient.getInstance.chatManager.addEventHandler(
      "UNIQUE_HANDLER_ID",
      ChatEventHandler(
        onConversationRead: (from, to) {},
      ),
    );
   ```

> 同一用户 ID 登录多设备的情况下，用户在一台设备上发送会话已读回执，服务器会将会话的未读消息数置为 `0`，同时其他设备会收到 `onConversationRead` 回调。

##### 消息已读回执

参考如下步骤在单聊中实现消息已读回执。

1. 初始化 SDK 时，在 `ChatOptions` 中设置 `requireAck` 为 `true` 开启全局的消息已读回执开关。如果全局设置不开启，消息和会话的相应设置也无法生效。

   ```dart
    ChatOptions options = ChatOptions(
    appKey: "<#Your AppKey#>",
    requireAck: true,
    );
    ChatClient.getInstance.init(options);
   ```

2. 消息发送方监听 `onMessagesRead` 事件。

   ```dart
    ChatClient.getInstance.chatManager.addEventHandler(
      "UNIQUE_HANDLER_ID",
      ChatEventHandler(
        onMessagesRead: (messages) {},
      ),
    );
   ```

3. 当消息到达时，消息接收方读取消息并调用 `sendMessageReadAck` 以发送消息已读回执。

   ```dart
    try {
    ChatClient.getInstance.chatManager.sendMessageReadAck(msg);
    } on ChatError catch (e) {

    }
   ```

### 群聊

对于群组消息，消息发送方（目前为群主和群管理员）可设置指定消息是否需要已读回执。

1. 消息发送方需要知道群组消息是否已读，需要监听 `onGroupMessageRead` 事件。

   ```dart
    ChatClient.getInstance.chatManager.addEventHandler(
      "UNIQUE_HANDLER_ID",
      ChatEventHandler(
        onGroupMessageRead: (messages) {},
      ),
    );
   ```

2. 发送群组消息。并设置 `needGroupAck` 为 `true`，表示需要群组消息已读回执。

   ```dart
    // 设置消息类型为群消息
    msg.chatType = ChatType.GroupChat;
    // 设置本条消息需要群消息回执
    msg.needGroupAck = true;
    try {
    await ChatClient.getInstance.chatManager.sendMessage(msg);
    } on ChatError catch (e) {

    }
   ```

3. 群组里面的接收方收到消息，调用 `sendGroupMessageReadAck` 告知消息发送方消息已读。成功发送后，消息发送方会收到 `onGroupMessageRead` 回调。

```dart
try {
  ChatClient.getInstance.chatManager.sendGroupMessageReadAck(msgId, groupId);
} on ChatError catch (e) {
  // 发送群消息已读失败，错误代码：e.code，错误描述：e.description
}
```