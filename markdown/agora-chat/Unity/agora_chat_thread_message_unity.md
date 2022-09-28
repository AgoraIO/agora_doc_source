线程使用户能够从聊天组中的特定消息创建单独的对话，以保持主聊天整洁。

子区消息消息类型属于群聊消息类型，与普通群组消息的区别是需要添加 `IsThread` 标记。

本文介绍即时通讯 IM Unity SDK 如何发送、接收以及撤回子区消息。
\
## 技术原理

即时通讯 IM Unity SDK 提供 `IChatManager`、`Message` 和 `IChatThreadManager` 类，用于管理子区消息，支持你通过调用 API 在项目中实现如下功能：

- 发送子区消息
- 接收子区消息
- 撤回子区消息
- 获取子区消息

消息收发流程如下：

![img](https://web-cdn.agora.io/docs-files/1636443945728)

如图所示，点对点消息的工作流程如下：

1. 用户 A 发送一条消息到环信的消息服务器；
2. 单聊时消息时，服务器投递消息给用户 B；对于群聊时消息，服务器投递给群内其他每一个成员；对于子区消息，服务器投递给子区内其他每一个成员；
3. 用户收到消息。

## 前提条件

开始前，请确保满足以下条件：

- 完成 `1.0.5 或 以上版本` SDK 初始化，详见 [快速开始](./agora_chat_get_started_unity)。
- 了解 [使用限制](./agora_chat_limitation)。

## 实现方法

本节介绍如何使用即时通讯 IM Unity SDK 提供的 API 实现上述功能。

### 发送子区消息

发送子区消息和发送群组消息的方法基本一致，详情请参考 [发送消息](./agora_chat_send_receive_message_unity#发送文本消息)。唯一不同的是，发送子区消息需要指定标记 `IsThread` 为 `true`。

示例代码如下：

```c#
// 创建一条文本消息，`content` 为消息文字内容，`chatThreadId` 为子区 ID。
Message msg = Message.CreateTextSendMessage(chatThreadId, content);
// 设置消息类型，子区消息需要将 `ChatType` 设置为 `GroupChat`。
msg.MessageType = MessageType.Group
// 设置消息标记 `IsThread` 为 `true`。
mmsg.IsThread = true;
// 发送消息时可以设置 `CallBack` 的实例，获得消息发送的状态。可以在该回调中更新消息的显示状态。例如消息发送失败后的提示等等。
SDKClient.Instance.ChatManager.SendMessage(ref msg, new CallBack(
    onSuccess: () => {
        Debug.Log($"SendTxtMessage success. msgid:{msg.MsgId}");
    },
    onProgress: (progress) => {
        Debug.Log($"SendTxtMessage progress :{progress.ToString()}");
    },
    onError: (code, desc) => {
        Debug.Log($"SendTxtMessage failed, code:{code}, desc:{desc}");
    }
));
```

### 接收子区消息

接收消息的具体逻辑，请参考 [接收消息](./agora_chat_send_receive_message_unity#接收消息)，此处只介绍子区消息和其他消息的区别。

子区有新增消息时，子区所属群组的所有成员收到 `IChatThreadManagerDelegate#OnUpdateMyThread` 回调，子区成员收到 `IChatManagerDelegate#OnMessagesReceived` 回调。

示例代码如下：

```c#
//继承并实现 IChatManagerDelegate。
public class ChatManagerDelegate : IChatManagerDelegate {

    //实现 OnMessagesReceived 回调。
    public void OnMessagesReceived(List<Message> messages)
    {
      //收到消息，遍历消息列表，解析和显示。
    }
}

// 申请并注册监听。
ChatManagerDelegate adelegate = new ChatManagerDelegate();
SDKClient.Instance.ChatManager.AddChatManagerDelegate(adelegate);

// 移除监听。
SDKClient.Instance.ChatManager.RemoveChatManagerDelegate(adelegate);
```

### 撤回子区消息

接收消息的具体逻辑，请参考 [撤回消息](./agora_chat_send_receive_message_unity#撤回消息)，此处只介绍子区消息和其他消息的区别。

子区有消息撤回时，子区所属群组的所有成员收到 `IChatThreadManagerDelegate#OnUpdateMyThread` 回调，子区成员收到 `IChatManagerDelegate#OnMessagesRecalled` 回调。

示例代码如下：

```c#
//继承并实现 IChatManagerDelegate。
public class ChatManagerDelegate : IChatManagerDelegate {

    //实现 OnMessagesRecalled 回调。
    public void OnMessagesRecalled(List<Message> messages)
    {
      //收到消息，遍历消息列表，解析和显示。
    }
}

//申请并注册监听。
ChatManagerDelegate adelegate = new ChatManagerDelegate();
SDKClient.Instance.ChatManager.AddChatManagerDelegate(adelegate);

//移除监听。
SDKClient.Instance.ChatManager.RemoveChatManagerDelegate(adelegate);
```

### 获取子区消息

进入单个子区会话后默认展示最早消息，用户可以从服务器获取子区历史消息；当你需要合并处理本地和服务器拉取到的消息（例如有用户撤回子区消息的提示是 SDK 在本地生成的一条消息）的时候，可以选择从本地获取子区消息。

#### 从服务器获取子区消息（消息漫游）

从服务器获取子区消息，请参考 [从服务器获取消息 (消息漫游)](./agora_chat_retrieve_message_unity)。

#### 管理本地子区消息

调用 `EMChatManager#getAllConversations()` 会返回单聊和群聊的会话，不会返回子区会话，你可以从本地数据库中读取指定会话的消息：

```c#
// 需要指定会话类型为 `ConversationType.Group`，且 `isChatThread` 设置为 `true`
Conversation conversation = SDKClient.Instance.ChatManager.GetConversation(chatThreadId, EMConversationType.GroupChat, createIfNotExists, isChatThread);
// 如需处理本地数据库中消息，用以下方法到数据库中获取，SDK 会将这些消息自动存入此会话
conversation.LoadMessages(startMsgId, count, direct, new ValueCallBack<List<Message>>(
    onSuccess: (list) => {
        Console.WriteLine($"LoadMessages found {list.Count} messages");
        foreach (var it in list)
        {
            Debug.Log($"message id: {it.MsgId}");
        }
    },
    onError: (code, desc) => {
        Debug.Log($"LoadMessages failed, code:{code}, desc:{desc}");
    }
));
```

**注意：**
可以通过 `Conversation#IsThread()` 判断当前会话是否是子区会话。
