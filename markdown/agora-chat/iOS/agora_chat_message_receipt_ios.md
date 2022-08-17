# 消息管理–管理消息回执

用户在单聊中发送消息后，可以查看该消息的送达和已读状态，了解接收方是否及时收到并阅读了消息，也可以了解整个会话是否已读。

用户在群聊中发送信息后，可以查看该消息的已读状态。

本文介绍如何使用即时通讯 IM iOS SDK 的消息已读回执和送达回执在 app 中实现上述功能。

## 技术原理

使用即时通讯 IM iOS SDK 可以实现消息的送达回执与已读回执。核心方法如下：

- `AgoraChatOptions.enableRequireReadAck`：开启消息已读回执。
- `AgoraChatOptions.enableDeliveryAck`：开启消息送达回执。
- `ackConversationRead` 发出指定会话的已读回执；
- `sendMessageReadAck` 发出指定消息的已读回执；
- `sendGroupMessageReadAck` 发出群组消息的已读回执。

实现送达回执和已读回执逻辑分别如下：

- 单聊会话及消息已读回执
  1. 你可以通过设置 `AgoraChatOptions.enableRequireReadAck` 为 `YES` 开启已读回执功能。
  2. 消息接收方收到消息后，调用 API `ackConversationRead` 或 `sendMessageReadAck`发送会话或消息已读回执。
  3. 消息发送方通过监听 `onConversationRead` 或 `messagesDidRead` 来接收会话或消息回执。

已读回执：

- 单聊会话及消息已读回执
  1. 你可以通过设置 `AgoraChatOptions.enableRequireReadAck` 为 `YES` 开启已读回执功能。
  2. 消息接收方收到消息后，调用 API `ackConversationRead`或`sendMesageReadAck`发送会话或消息已读回执。
  3. 消息发送方通过监听 `onConversationRead` 或 `messageDidRead` 来接收会话或消息回执。
- 群聊只支持消息已读回执：
  1. 你可以通过设置 `isNeedGroupAck` 开启群聊消息已读回执功能；
  2. 消息接收方收到消息后通过 `sendGroupMessageReadAck` 发送群组消息的已读回执。

## 前提条件

开始前，请确保满足以下条件：

- 完成 SDK 初始化，并连接到服务器，详见 [Agora Chat 入门](https://docs.agora.io/en/agora-chat/agora_chat_get_started_ios?platform=iOS)。
- 了解即时通讯 IM 的 [使用限制](https://docs.agora.io/en/agora-chat/agora_chat_limitation?platform=iOS)。
- 在群组中实现消息已读回执功能默认不开启。如需使用请联系 [support@agora.io](mailto:support@agora.io)。

## 实现方法

### 消息送达回执

1. 打开消息送达开关，即将 `enableDeliveryAck` 设置为 `YES`，当接收方收到消息后，SDK 底层会自动进行消息送达回执。

   ```objective-C
    options.enableDeliveryAck = YES;
   ```

2. 发送方监听事件 `onMessageDelivered` 回调，收到接收方的送达回执。

   ```Objective-C
     // 收到消息送达回执。
    - (void)messagesDidDeliver:(NSArray *)aMessages
    {

    }

// 记得在不需要的时候移除监听器，如在 viewController 的 dealloc 时。
    [[AgoraChatClient sharedClient].chatManager removeDelegate:self];
   ```

### 消息和会话的已读回执

消息已读回执用于告知单聊或群聊中的用户接收方已阅读其发送的消息。为降低消息已读回执方法的调用次数，SDK 还支持在单聊中使用会话已读回执功能，用于获知接收方是否阅读了会话中的未读消息。

#### 单聊

单聊既支持消息已读回执，也支持会话已读回执。我们建议你按照如下逻辑结合使用两种回执，减少发送消息已读回执数量。

- 聊天页面未打开时，若有未读消息，进入聊天页面，发送会话已读回执；
- 聊天页面打开时，若收到消息，发送消息已读回执。

发送方若要接收消息已读回执，你首先需要设置打开已读回执，即将 `enableRequireReadAck` 设置为 `YES`，当接收方阅读消息后，SDK 底层会自动进行消息已读回执。

```objective-c
options.enableRequireReadAck = YES;
```

##### 会话已读回执

参考以下步骤在单聊中实现会话已读回执。

1. 接收方发送会话已读回执。

消息接收方进入会话页面，查看会话中是否有未读消息。若有，发送会话已读回执，没有则不再发送。

     ```Objective-C
     [[AgoraChatClient sharedClient].chatManager ackConversationRead:conversationId completion:nil];
     ```

2. 消息发送方监听会话已读回执的回调。

   ```Objective-C
   - (void)onConversationRead:(NSString *)from to:(NSString *)to
   {
    // 添加刷新页面通知等逻辑。
   }
   ```

同一用户 ID 登录多设备的情况下，用户在一台设备上发送会话已读回执，服务器会将会话的未读消息数置为 `0`，同时其他设备会收到 `OnConversationRead` 回调。

##### 消息已读回执

参考如下步骤在单聊中实现消息已读回执。

1. 接收方发送已读回执消息。

消息接收方进入会话时，发送会话已读回执。

     ```Objective-C
     [[AgoraChatClient sharedClient].chatManager sendMessageReadAck:messageId toUser:conversationId completion:nil];
     ```

在会话页面，接收到消息时，根据消息类型发送消息已读回执，如下所示：

     ```Objective-C
     // Occurs when the message is received.
     - (void)messagesDidReceive:(NSArray *)aMessages
     {
        for (AgoraChatMessage *message in aMessages) {
            // Sends a message read receipt
            [self sendReadAckForMessage:message];
        }
     }

     - (void)sendReadAckForMessage:(AgoraChatMessage *)aMessage
     {
        // The received message
        if (aMessage.direction == AgoraChatMessageDirectionSend || aMessage.isReadAcked || aMessage.chatType != AgoraChatTypeChat)
            return;

        MessageBody *body = aMessage.body;
        // For audio, video, and file messages, send them after the user clicks the file.
        if (body.type == MessageBodyTypeFile || body.type == MessageBodyTypeVoice || body.type == MessageBodyTypeImage)
            return;

        [[AgoraChatClient sharedClient].chatManager sendMessageReadAck:aMessage.messageId toUser:aMessage.conversationId completion:nil];
     }
     ```

2. 消息发送方监听消息已读回调。

可以调用接口监听指定消息是否已读，示例代码如下：
     ```Objective-C
     // Occurs when the message read receipt is received
     - (void)messagesDidRead:(NSArray *)aMessages
     {
        for (AgoraChatMessage *message in aMessages) {
            // Adds handling logics
        }
     }
     ```

#### 群聊

对于群消息，消息发送方（目前为群主和群管理员）可设置指定消息是否需要已读回执。

按照步骤实现聊天消息已读回执。

1. 对于聊天群消息，群主和管理员可以设置在发送消息时要求消息已读回执。

   ```Objective-C
    AgoraChatMessage *message = [[AgoraChatMessage alloc] initWithConversationID:to from:from to:to body:aBody ext:aExt];
    message.isNeedGroupAck = YES;
   ```

2. 群成员阅读群聊消息后，群成员客户端调用 `sendGroupMessageReadAck` 发送消息已读回执：

   ```Objective-C
    - (void)sendGroupMessageReadAck:(AgoraChatMessage *)msg
    {
        if (msg.isNeedGroupAck && !msg.isReadAcked) {
            [[AgoraChatClient sharedClient].chatManager sendGroupMessageReadAck:msg.messageId toGroup:msg.conversationId content:@"123" completion:^(AgoraChatError *error) {
                if (error) {

                }
            }];
        }
    }
   ```

3. 消息发送方监听群组消息已读回调。

群消息已读回调在回调代理 `AgoraChatManagerDelegate` 中实现。

   ```Objective-C
// 接收到群组消息的已读回执, 消息的接收方已经阅读此消息。
    - (void)groupMessageDidRead:(AgoraChatMessage *)aMessage groupAcks:(NSArray *)aGroupAcks
    {
        for (AgoraChatGroupMessageAck *messageAck in aGroupAcks) {
            //receive group message read ack
        }
    }
   ```

4. 消息发送方可以调用 `asyncFetchGroupMessageAcksFromServer` 获取已读回执的详细信息。

   ```Objective-C
   /**
    * 从服务器获取指定群已读回执。
    */
    [[AgoraChatClient sharedClient].chatManager asyncFetchGroupMessageAcksFromServer:messageId groupId:groupId startGroupAckId:nil pageSize:pageSize completion:^(AgoraChatCursorResult *aResult, AgoraChatError *error, int totalCount) {
   // 页面刷新等操作。
    }];
   ```