单聊会话支持消息送达回执、会话已读回执和消息已读回执，发送方发送消息后可及时了解接收方是否及时收到并阅读了信息，也可以了解整个会话是否已读。

群聊会话只支持消息已读回执。群主和群管理员在发送消息时，可以设置该消息是否需要已读回执。若使用该功能，请联系 [sales@agora.io](mailto:sales@agora.io) 开通。

本文介绍如何使用即时通讯 IM SDK 在单聊和群聊中实现消息回执功能。

## 技术原理

即时通讯 IM SDK 在 `ChatManager` 类中提供消息回执。以下是核心方法：

- `ChatOptions.setRequireAck`：开启消息已读回执。
- `ChatOptions.setRequireDeliveryAck`：开启消息送达回执。
- `ackConversationRead`：发送指定会话的已读回执。
- `ackMessageRead`：发送指定消息的已读回执。
- `ackGroupMessageRead`：发送群组消息的已读回执。

送达和已读回执逻辑分别如下：

- 单聊消息送达回执：

1. 消息发送方在发送消息前将 `ChatOptions.setRequireDeliveryAck` 设置为 `true` 开启送达回执功能。
2. 消息接收方收到消息后，SDK 自动向发送方发送送达回执；
3. 消息发送方通过监听 `OnMessageDelivered` 回调接收消息送达回执。

- 单聊会话及消息已读回执
  1. 消息发送方将 `ChatOptions.setRequireAck` 设置为`true`，开启已读回执功能。
  2. 消息接收方收到消息后，调用 `ackConversationRead` 或 `ackMessageRead` 发送会话或消息已读回执；
  3. 消息发送方通过监听 `onConversationRead` 或 `onMessageRead` 回调接收会话或消息已读回执。

- 群聊只支持消息已读回执：

  1. 你可以通过设置 `isNeedGroupAck` 为 `true` 开启群聊消息已读回执功能；
  2. 消息接收方收到消息后通过 `ackGroupMessageRead` 发送群组消息的已读回执。

## 前提条件

开始前，请确保满足以下条件：

- 完成 SDK 初始化，详见 [Android 快速开始](./agora_chat_get_started_android)。
- 了解即时通讯 IM API 的调用频率限制，详见[限制条件](./agora_chat_limitation)。
- 若使用群聊的消息已读回执功能，需联系 [sales@agora.io](mailto:sales@agora.io) 开通。

## 实现方法

本节介绍如何在你的聊天应用中实现消息的送达和已读回执。

### 消息送达回执

要发送消息送达回执，请执行以下步骤：

1. 在发送消息之前，消息发送方将 `ChatOptions` 中的 `setRequireDeliveryAck` 设置为 `true`。

```java
Chatoptions.setRequireDeliveryAck(true);
```

2. 接收方收到消息后，SDK 会通过 `onMessageDelivered` 在消息发送方的客户端上自动触发回调，通知消息发送方消息已送达接收方。

```java
// 添加消息监听。
MessageListener msgListener = new MessageListener() {
    // 收到消息。
    @Override
    public void onMessageReceived(List<ChatMessage> messages) {
    }
    // 收到已送达回执。
    @Override
    public void onMessageDelivered(List<ChatMessage> message) {
    }
};
// 记得在不需要的时候移除 listener，如在 activity 的 onDestroy() 时。
ChatClient.getInstance().chatManager().removeMessageListener(msgListener);
```

### 会话和消息已读回执

消息已读回执用于告知单聊或群聊中的用户接收方已阅读其发送的消息。为降低消息已读回执方法的调用次数，SDK 还支持在单聊中使用会话已读回执功能，用于获知接收方是否阅读了会话中的未读消息。

#### 单聊

单聊既支持消息已读回执，也支持会话已读回执。我们建议你按照如下逻辑结合使用两种回执，减少发送消息已读回执数量。

- 聊天页面未打开时，若有未读消息，进入聊天页面，发送会话已读回执；
- 聊天页面打开时，若收到消息，发送消息已读回执。

第一步是在设置中打开已读回执开关：

```java
// 设置是否需要消息已读回执，设为 `true`。
chatOptions.setRequireAck(true);
```

**会话已读回执**

参考以下步骤在单聊中实现会话已读回执。

1. 接收方发送会话已读回执。

消息接收方进入会话页面，查看会话中是否有未读消息。若有，调用 `ackConversationRead` 方法发送会话已读回执，没有则不再发送。

```java
// 消息接收方调用 `ackConversationRead` 发送会话已读回执。
try {
 ChatClient.getInstance().chatManager().ackConversationRead(conversationId);
 } catch (ChatException e) {
  e.printStackTrace();
}
```

该方法为异步方法，需要捕捉异常。

2. 消息发送方监听消息事件，通过 `onConversationRead` 收到会话已读回执。

```java
// 消息发送方调用 `addConversationListener` 监听会话已读回执。
ChatClient.getInstance().chatManager().addConversationListener(new ConversationListener() {
            ...
            @Override
            // 会话中所有消息已读。
            public void onConversationRead(String from, String to) {
        // 添加刷新页面通知等逻辑。
            }
        });
```

<div class="alert info">同一用户 ID 登录多设备的情况下，用户在一台设备上发送会话已读回执，服务器会将会话的未读消息数置为 `0`，同时其他设备会收到 `OnConversationRead` 回调。</div>

**消息已读回执**

要实现消息已读回执，请执行以下步骤：

1. 当消息接收方进入会话时发送会话已读回执。

```java
// 消息发送方调用 `ackMessageRead` 方法发送会话已读回执。
try {
  ChatClient.getInstance().chatManager().ackMessageRead(conversationId);
 }catch (ChatException e) {
  e.printStackTrace();
 }
```

2. 当有新消息到达时，发送消息已读回执并为不同的消息类型添加适当的处理逻辑。

```java
ChatClient.getInstance().chatManager().addMessageListener(new MessageListener() {
  ......

  @Override
  // 指定消息已送达。
  public void onMessageReceived(List<ChatMessage> messages) {
   ......
  // 发送消息已读回执。
  sendReadAck(message);
  ......
  }
   ......
 });
  // 发送消息已读回执。
 public void sendReadAck(ChatMessage message) {
  // 单聊
  if(message.direct() == ChatMessage.Direct.RECEIVE
      undefined message.getChatType() == ChatMessage.ChatType.Chat) {
      ChatMessage.Type type = message.getType();
    // 视频，语音及文件需要点击后再发送，可以根据需求进行调整。
      if(type == ChatMessage.Type.VIDEO || type == ChatMessage.Type.VOICE || type == ChatMessage.Type.FILE) {
          return;
      }
      try {
      // 调用 `ackMessageRead` 方法发送已读回执。
      ChatClient.getInstance().chatManager().ackMessageRead(message.getFrom(), message.getMsgId());
      } catch (ChatException e) {
           e.printStackTrace();
      }
  }
 }
```

3. 消息发送方监听消息已读回调。

你可以调用接口监听指定消息是否已读，示例代码如下：

```java
// 添加消息监听。
ChatClient.getInstance().chatManager().addMessageListener(new MessageListener() {
 ......
 @Override
 // 指定消息已读。
 public void onMessageRead(List<ChatMessage> messages) {
 // 添加刷新消息等逻辑。
  }
  ......
 });
```

#### 群聊

对于群聊，群主和群管理员发送消息时，可以设置该消息是否需要已读回执。若需要，每个群成员在阅读消息后，SDK 均会发送已读回执，即阅读该消息的群成员数量即为已读回执的数量。

若要使用该功能，需联系 [sales@agora.io](mailto:sales@agora.io) 开通。

1. 群主或群管理员发送消息时若需已读回执，需设置 `ChatMessage` 中的方法 `setIsNeedGroupAck()` 为 `true`。

```java
ChatMessage message = ChatMessage.createTxtSendMessage(content, to);
message.setIsNeedGroupAck(true);
```

2. 群成员阅读群聊消息后，SDK 自动调用 `sendAckMessage` 方法发送消息已读回执：

```java
// 发送群聊消息已读回执。
public void sendAckMessage(ChatMessage message) {
    if (!validateMessage(message)) {
        return;
    }

    if (message.isAcked()) {
        return;
    }

    // 用户登录多台设备时，不用重复发送。
    if (ChatClient.getInstance().getCurrentUser().equalsIgnoreCase(message.getFrom())) {
        return;
    }

    try {
        if (message.isNeedGroupAck() && !message.isUnread()) {
            String to = message.conversationId(); // do not use getFrom() here
            String msgId = message.getMsgId();
            ChatClient.getInstance().chatManager().ackGroupMessageRead(to, msgId, ((TextMessageBody)message.getBody()).getMessage());
            message.setUnread(false);
            EMLog.i(TAG, "Send the group ack cmd-type message.");
        }
    } catch (Exception e) {
        EMLog.d(TAG, e.getMessage());
    }
}
```

3. 消息发送方监听群组消息已读回调。

群消息已读回调在消息监听类 `ChatMessageListener` 中。

```java
// 指定群组消息已读。
void onGroupMessageRead(List<GroupReadAck> groupReadAcks) {
    // 添加后续逻辑。
}
```

接收到群组消息已读回执后，发出消息的属性 `groupAckCount` 会有相应变化；

4. 消息发送方可以调用 `asyncFetchGroupReadAcks` 获取已读回执的详细信息。

```java
// 从服务器获取群组消息回执详情。
public void asyncFetchGroupReadAcks(final String msgId, final int pageSize,final String startAckId, final ValueCallBack<CursorResult<GroupReadAck>> callBack) {}
```