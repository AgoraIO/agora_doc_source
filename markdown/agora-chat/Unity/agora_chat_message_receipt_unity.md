用户在单聊和群聊中发送信息后，可以查看该信息的送达和已读状态，了解接收方是否及时收到并阅读了信息。

本文介绍如何使用即时通讯 IM Unity SDK 的消息已读回执和送达回执在 app 中实现上述功能。

## 技术原理

即时通讯 IM Unity SDK 通过 `IChatManager` 类提供消息已回执功能，包含的核心方法如下：

- `Options.RequireDeliveryAck` 开启送达回执；
- `IChatManager.SendConversationReadAck` 发出指定会话的已读回执；
- `IChatManager.SendMessageReadAck` 发出指定单聊消息的已读回执；
- `SendReadAckForGroupMessage` 发送群组消息的已读回执。

实现消息送达和已读回执的逻辑分别如下：

消息送达回执：

1. 消息发送方在发送消息前通过 `ChatOptions.RequireDeliveryAck` 开启送达回执功能；
2. 消息接收方收到消息后，SDK 自动向发送方触发送达回执；
3. 消息发送方通过监听 `OnMessageDelivered` 回调接收消息送达回执。

已读回执：

- 单聊会话及消息已读回执
    1. 设置 `RequireAck` 为 `true`；
    2. 消息接收方收到消息后，调用 API `SendConversationReadAck` 或 `SendMessageReadAck` 发送会话或消息已读回执；
    3. 消息发送方通过监听 `OnConversationRead` 或 `OnMessageRead` 回调接收会话或消息已读回执。
- 群聊只支持消息已读回执：
    1. 你可以通过设置 `isNeedGroupAck` 开启群聊消息已读回执功能；
    2. 消息接收方收到消息后通过 `SendReadAckForGroupMessage` 发送群组消息的已读回执。

## 前提条件

开始前，请确保满足以下条件：

- 完成 SDK 初始化，详见 [快速开始](./agora_chat_get_started_unity)。
- 了解 [使用限制](./agora_chat_limitation)。
- 默认情况下不启用群组的消息已读回执。要使用此功能，请联系 [support@agora.io](mailto:support@agora.io)。

## 实现方法

### 消息送达回执

1. 发送方若要接收消息送达回执，你需要将 `Options` 中的 `RequireDeliveryAck` 设为 `true`。当接收方收到消息后，SDK 底层会自动进行消息送达回执。

```C#
// 设置是否需要消息送达回执，设为 `true`。
Options.RequireDeliveryAck = true;
```

2. 发送方监听事件 `OnMessagesDelivered` 回调，收到接收方的送达回执。

```C#
// 继承并实现 `IChatManagerDelegate`。
public class ChatManagerDelegate : IChatManagerDelegate {

    // 收到已送达回执。
    public void OnMessagesDelivered(List<Message> messages)
      {
      }
  }

// 注册监听器。
ChatManagerDelegate adelegate = new ChatManagerDelegate();
SDKClient.Instance.ChatManager.AddChatManagerDelegate(adelegate);

// 移除监听器。
SDKClient.Instance.ChatManager.RemoveChatManagerDelegate(adelegate);
```

### 消息和会话的已读回执

消息已读回执用于告知单聊或群聊中的用户接收方已阅读其发送的消息。为降低消息已读回执方法的调用次数，SDK 还支持在单聊中使用会话已读回执功能，用于获知接收方是否阅读了会话中的未读消息。

#### 单聊

单聊既支持消息已读回执，也支持会话已读回执。我们建议你按照如下逻辑结合使用两种回执，减少发送消息已读回执数量。

- 聊天页面未打开时，若有未读消息，进入聊天页面，发送会话已读回执；
- 聊天页面打开时，若收到消息，发送消息已读回执。

第一步是在设置中打开已读回执开关：

```c#
// 设置是否需要消息已读回执，设为 `true`。
Options.RequireReadAck = true;
```

##### 会话已读回执

参考以下步骤在单聊中实现会话已读回执。

1. 接收方发送会话已读回执。

消息接收方进入会话页面，查看会话中是否有未读消息。若有，发送会话已读回执，没有则不再发送。

```c#
SDKClient.Instance.ChatManager.SendConversationReadAck(conversationId, new CallBack(
  onSuccess: () => {

  },
  onError:(code, desc) => {

  }
));
```

2. 消息发送方监听会话已读回执的回调。

```c#
// 继承并实现 `IChatManagerDelegate`。
public class ChatManagerDelegate : IChatManagerDelegate {
    // 收到已读回执。`from` 表示发送该会话已读回执的消息接收方，`to` 表示收到该会话已读回执的消息发送方。
    public void OnConversationRead(string from, string to)
    {
    }
}

// 注册监听器。
ChatManagerDelegate adelegate = new ChatManagerDelegate()
SDKClient.Instance.ChatManager.AddChatManagerDelegate(adelegate);

// 移除监听器。
SDKClient.Instance.ChatManager.RemoveChatManagerDelegate(adelegate);
```

同一用户 ID 登录多设备的情况下，用户在一台设备上发送会话已读回执，服务器会将会话的未读消息数置为 `0`，同时其他设备会收到 `OnConversationRead` 回调。

##### 消息已读回执

参考如下步骤在单聊中实现消息已读回执。

1. 接收方发送已读回执消息。

消息接收方进入会话时，发送会话已读回执。

```c#
SDKClient.Instance.ChatManager.SendConversationReadAck(conversationId, new CallBack(
  onSuccess: () => {

  },
  onError:(code, desc) => {

  }
));
```

2.在会话页面，接收到消息时，根据消息类型发送消息已读回执，如下所示：

```c#
// 继承并实现 `IChatManagerDelegate`。
public class ChatManagerDelegate : IChatManagerDelegate {

    // 收到已送达回执。
    public void OnMessageReceived(List<Message> messages)
    {
      ......
      sendReadAck(message);
      ......
    }
}

// 注册监听器。
ChatManagerDelegate adelegate = new ChatManagerDelegate()
SDKClient.Instance.ChatManager.AddChatManagerDelegate(adelegate);


// 发送已读回执。
public void sendReadAck(Message message) {

    // 这里是接收的消息，未发送过已读回执且是单聊。
    if(message.Direction == MessageDirection.RECEIVE
    && !message.HasReadAck
    && message.MessageType == MessageType.Chat) {

        MessageBodyType type = message.Body.Type;

        // 视频、语音及文件需要点击后再发送，可根据需求进行调整。
        if(type == MessageBodyType.VIDEO || type == MessageBodyType.VOICE || type == MessageBodyType.FILE) {
            return;
        }

        SDKClient.Instance.ChatManager.SendMessageReadAck(message.MsgId, new CallBack(
          onSuccess: () => {

          },
          onError: (code, desc) => {

          }
        );
    }
}
```

3. 消息发送方监听消息已读回调。

你可以调用接口监听指定消息是否已读，示例代码如下：

```c#
// 继承并实现 `IChatManagerDelegate`。
public class ChatManagerDelegate : IChatManagerDelegate {

    // 收到消息已读回执。
    public void OnMessagesRead(string from, string to)
    {
    }
}
// 注册监听器。
ChatManagerDelegate adelegate = new ChatManagerDelegate()
SDKClient.Instance.ChatManager.AddChatManagerDelegate(adelegate);

// 移除监听器。
SDKClient.Instance.ChatManager.RemoveChatManagerDelegate(adelegate);
```

#### 群聊

对于群组消息，消息发送方（目前为群主和群管理员）可设置消息是否需要已读回执。

1. 消息发送方在发送消息时，设置 `Message` 的 `IsNeedGroupAck` 为 `true`。

```c#
Message msg = Message.CreateTextSendMessage("to", "hello world");
msg.IsNeedGroupAck = true;
```

2. 消息接收方发送群组消息的已读回执。

```c#
void SendReadAckForGroupMessage(string messageId, string ackContent)
{
    SDKClient.Instance.ChatManager.SendReadAckForGroupMessage(messageId, ackContent，handle: new CallBack(
        onSuccess: () =>
        {

            },
            onError: (code, desc) =>
            {

            }
        ));
    }
```

3. 消息发送方监听群组消息已读回调。

群组消息已读回调在消息监听类 `IChatManagerDelegate` 中实现。

```c#
// 继承并实现 `IChatManagerDelegate`。
public class ChatManagerDelegate : IChatManagerDelegate {

    // 收到群组消息的已读回执, 表明消息的接收方已阅读此消息。
    public void OnGroupMessageRead(List<GroupReadAck> list)
    {

    }
}

// 注册监听器。
ChatManagerDelegate adelegate = new ChatManagerDelegate()
SDKClient.Instance.ChatManager.AddChatManagerDelegate(adelegate);
```

4. 消息发送方获取群组消息的已读回执详情。

你可以调用 `FetchGroupReadAcks` 获取群组消息的已读回执的详情，示例代码如下：

```c#
SDKClient.Instance.ChatManager.FetchGroupReadAcks(messageId, groupId, startAckId, pageSize, new ValueCallBack<List<GroupReadAck>>(
    onSuccess: (list) =>
    {
        // 页面刷新等操作。
    },
    onError: (code, desc) =>
    {
    }
));
```