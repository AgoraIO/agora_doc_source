单聊会话支持消息送达回执、会话已读回执和消息已读回执，发送方发送消息后可及时了解接收方是否及时收到并阅读了信息，也可以了解整个会话是否已读。

群聊会话只支持消息已读回执。群主和群管理员在发送消息时，可以设置该消息是否需要已读回执。若使用该功能，请联系 [sales@agora.io](mailto:sales@agora.io) 开通。

本文介绍如何使用即时通讯 IM iOS SDK 实现单聊和群聊的消息回执功能。

## 技术原理

使用即时通讯 IM iOS SDK 可以实现消息的送达回执与已读回执，主要功能如下：

- 开启消息已读回执；
- 开启消息送达回执；
- 发出指定会话的已读回执；
- 发出指定消息的已读回执；
- 发出群组消息的已读回执。

实现送达回执和已读回执逻辑分别如下：

- 单聊会话及消息已读回执
  1. 你可以通过设置 `AgoraChatOptions.enableDeliveryAck` 为 `YES` 开启送达回执功能。
  2. 消息接收方收到消息后，SDK 自动向发送方发送送达回执。
  3. 消息发送方通过监听 `messageDidDeliver` 接收送达回执。

- 单聊会话及消息已读回执
  1. 消息发送方设置 `AgoraChatOptions.enableRequireReadAck` 为 `YES` 开启已读回执功能。
  2. 消息接收方收到消息后，调用 `ackConversationRead`或`sendMessageReadAck` 方法发送会话或消息已读回执。
  3. 消息发送方通过监听 `onConversationRead` 或 `messageDidRead` 接收会话或消息回执。
- 群聊只支持消息已读回执：
  1. 消息发送方设置 `isNeedGroupAck` 开启群聊消息已读回执功能；
  2. 消息接收方收到消息后调用 `sendGroupMessageReadAck` 方法发送群组消息的已读回执。

## 前提条件

开始前，请确保满足以下条件：

- 完成 SDK 初始化，并连接到服务器，详见 [iOS 快速开始](./agora_chat_get_started_ios)。
- 了解即时通讯 IM API 的调用频率限制，详见 [限制条件](./agora_chat_limitation)。
- 若使用群聊的消息已读回执功能，需联系 [sales@agora.io](mailto:sales@agora.io) 开通。

## 实现方法

### 消息送达回执

1. 打开消息送达开关，即将 `enableDeliveryAck` 设置为 `YES`，当接收方收到消息后，SDK 底层会自动进行消息送达回执。

   ```objective-C
    options.enableDeliveryAck = YES;
   ```

2. 发送方监听事件 `messagesDidDeliver` 回调，收到接收方的送达回执。

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

发送方若要接收消息已读回执，需首先设置开启已读回执功能，即将 `enableRequireReadAck` 设置为 `YES`，当接收方阅读消息后，SDK 底层会自动发送消息已读回执。

```objective-c
options.enableRequireReadAck = YES;
```

**会话已读回执**

参考以下步骤在单聊中实现会话已读回执。

1. 接收方发送会话已读回执。

消息接收方进入会话页面，查看会话中是否有未读消息。若有，调用 `ackConversationRead` 方法发送会话已读回执。

   ```Objective-C
   [[AgoraChatClient sharedClient].chatManager ackConversationRead:conversationId completion:nil];
   ```

2. 消息发送方监听消息事件，通过 `onConversationRead` 接收会话已读回执。

   ```Objective-C
   - (void)onConversationRead:(NSString *)from to:(NSString *)to
   {
    // 添加刷新页面通知等逻辑。
   }
   ```

<div class="alert info">同一用户 ID 登录多设备的情况下，用户在一台设备上发送会话已读回执，服务器会将会话的未读消息数置为 `0`，同时其他设备会收到 `OnConversationRead` 回调。</div>

**消息已读回执**

参考如下步骤在单聊中实现消息已读回执。

1. 消息接收方进入会话时，发送会话已读回执。

     ```Objective-C
     [[AgoraChatClient sharedClient].chatManager sendMessageReadAck:messageId toUser:conversationId completion:nil];
     ```

在会话页面，接收到消息时，根据消息类型发送消息已读回执，如下所示：

     ```Objective-C
     // 消息收到的回调。
     - (void)messagesDidReceive:(NSArray *)aMessages
     {
        for (AgoraChatMessage *message in aMessages) {
            // 发送消息已读回执
            [self sendReadAckForMessage:message];
        }
     }

     - (void)sendReadAckForMessage:(AgoraChatMessage *)aMessage
     {
        // 收到的消息
        if (aMessage.direction == AgoraChatMessageDirectionSend || aMessage.isReadAcked || aMessage.chatType != AgoraChatTypeChat)
            return;

        MessageBody *body = aMessage.body;
        // 对于语音、视频和文件消息，在用户点击文件时发送消息已读回执。
        if (body.type == MessageBodyTypeFile || body.type == MessageBodyTypeVoice || body.type == MessageBodyTypeImage)
            return;

        [[AgoraChatClient sharedClient].chatManager sendMessageReadAck:aMessage.messageId toUser:aMessage.conversationId completion:nil];
     }
     ```

2. 消息发送方监听消息已读回调。

可以调用接口监听指定消息是否已读，示例代码如下：

     ```Objective-C
     // 收到消息已读回执的回调。
     - (void)messagesDidRead:(NSArray *)aMessages
     {
        for (AgoraChatMessage *message in aMessages) {
            // 添加处理逻辑
        }
     }
     ```

#### 群聊

对于群聊，群主和群管理员发送消息时，可以设置该消息是否需要已读回执。若需要，每个群成员在阅读消息后，SDK 均会发送已读回执，即阅读该消息的群成员数量即为已读回执的数量。

若要使用该功能，需联系 [sales@agora.io](mailto:sales@agora.io) 开通。

按以下步骤实现聊天消息已读回执。

1. 群主或群管理员发送消息时若需已读回执，需设置 `isNeedGroupAck` 为 `true`。

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

3. 消息发送方监听群组消息已读回调。群消息已读回调在回调代理 `AgoraChatManagerDelegate` 中实现。
 
   ```Objective-C
   // 接收到群组消息的已读回执, 消息的接收方已经阅读此消息。
    - (void)groupMessageDidRead:(AgoraChatMessage *)aMessage groupAcks:(NSArray *)aGroupAcks
    {
        for (AgoraChatGroupMessageAck *messageAck in aGroupAcks) {
            // 收到群组消息的已读回执
        }
    }
   ```

4. 消息发送方可以调用 `asyncFetchGroupMessageAcksFromServer` 获取已读回执的详细信息。

   ```Objective-C
   /**
    * 从服务器获取指定的群消息已读回执。
    */
    [[AgoraChatClient sharedClient].chatManager asyncFetchGroupMessageAcksFromServer:messageId groupId:groupId startGroupAckId:nil pageSize:pageSize completion:^(AgoraChatCursorResult *aResult, AgoraChatError *error, int totalCount) {
   // 页面刷新等操作。
    }];
   ```