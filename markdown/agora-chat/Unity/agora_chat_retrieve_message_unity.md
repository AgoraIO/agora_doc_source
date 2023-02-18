本文介绍用户如何从消息服务器获取会话和消息，该功能也称为消息漫游，指即时通讯服务将用户的历史消息保存在消息服务器上，用户即使切换终端设备，也能从服务器获取到单聊、群聊的历史消息，保持一致的会话场景。

## 实现原理

使用即时通讯 IM SDK 可以通过 `IChatManager` 类的以下方法从服务器获取历史消息：

- `GetConversationsFromServerWithPage` 分页获取服务器保存的会话列表；
- `FetchHistoryMessagesFromServer` 获取服务器保存的指定会话中的消息;
- `RemoveMessagesFromServer` 单向删除服务端的历史消息；
- `DeleteConversationFromServer` 删除服务端的会话及其历史消息。

## 前提条件

开始前，请确保满足以下条件：

- 完成 SDK 初始化，详见 [快速开始](./agora_chat_get_started_unity)。
- 了解 [使用限制](./agora_chat_limitation)。

## 实现方法

### 从服务器分页获取会话

调用 `GetConversationsFromServerWithPage` 从服务端分页获取会话。我们建议在 app 安装时或本地没有会话时调用该 API。否则调用 `LoadAllConversations` 即可。示例代码如下：

```C#
SDKClient.Instance.ChatManager.GetConversationsFromServerWithPage(pageNum, pageSize, new ValueCallBack<List<Conversation>>(
    //获取会话成功后的处理逻辑。
    //list 为 List<Conversation> 类型。
    onSuccess: (list) =>
    {
    },
    onError: (code, desc) =>
    {
    }
));
```

对于不支持 `GetConversationsFromServerWithPage` 接口的用户，可以调用 `GetConversationsFromServer` 从服务端获取会话列表。默认情况下，用户可拉取 7 天内的 10 个会话（每个会话包含最新一条历史消息），如需调整会话数量或时间限制请联系 [support@agora.io](mailto:support@agora.io)。

### 分页获取指定会话的历史消息

你还可以从服务器分页获取指定会话的历史消息，实现消息漫游功能。为确保数据可靠，我们建议你多次调用该方法，且每次获取的消息数小于 50 条。获取到数据后，SDK 会自动将消息更新到本地数据库。

```C#
SDKClient.Instance.ChatManager.FetchHistoryMessagesFromServer(conversationId, type, startId, pageSize, new ValueCallBack<CursorResult<Message>>(
  // 获取历史消息成功。
  // result 为 CursorResult<Message> 类型。
  onSuccess: (result) => {
  },

  // 获取历史消息失败。
  onError:(code, desc) => {
  }
));
```

### 单向删除服务端的历史消息

你可以调用 `RemoveMessagesFromServer` 方法单向删除服务端的历史消息，每次最多可删除 50 条消息。消息删除后，该用户无法从服务端拉取到该消息。其他用户不受该操作影响。已删除的消息自动从设备本地移除。

```C#
// 按时间戳删除消息
SDKClient.Instance.ChatManager.RemoveMessagesFromServer(convId, ctype, time, new CallBack(
    onSuccess: () =>
    {
    },
    onError: (code, desc) =>
    {
    }
));
// 按消息 ID 删除消息
SDKClient.Instance.ChatManager.RemoveMessagesFromServer(convId, ctype, msgList, new CallBack(
    onSuccess: () =>
    {
    },
    onError: (code, desc) =>
    {
    }
));
```

### 删除服务端会话及其历史消息

你可以调用 `DeleteConversationFromServer` 方法删除服务器端会话和历史消息。会话删除后，当前用户和其他用户均无法从服务器获取该会话。若该会话的历史消息也删除，所有用户均无法从服务器获取该会话的消息。

```C#
SDKClient.Instance.ChatManager.DeleteConversationFromServer(conversationId, conversationType, isDeleteServerMessages, new CallBack(
    onSuccess: () =>
    {
    },
    onError: (code, desc) =>
    {
    }
));
```