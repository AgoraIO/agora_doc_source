
表情符号被广泛用于实时聊天，因为它们允许用户以直接和生动的方式表达自己的感受。在即时通讯 IM 中，消息表情回复（下文统称 “Reaction”）功能允许用户在单聊和群聊中使用表情符号快速对消息做出反应。同时在群组中，利用 Reaction 可以发起投票，根据不同表情的追加数量来确认投票。

目前 Reaction 仅适用于单聊和群组。聊天室暂不支持 Reaction 功能。

下图显示了将 Reaction 添加到消息、带有 Reaction 的会话的外观以及获取 Reaction 列表（带有相关信息）的外观。

![img](https://web-cdn.agora.io/docs-files/1655257598155)

本页展示了如何使用即时通讯 IM SDK 在你的项目中实现 Reaction。

## 技术原理

即时通讯 IM SDK 支持你通过调用 API 在项目中实现如下功能：

- `AddReaction` 在消息上添加 Reaction；
- `RemoveReaction` 删除消息的 Reaction；
- `GetReactionList` 获取消息的 Reaction 列表；
- `GetReactionDetail` 获取 Reaction 详情；
- `Message.ReactionList` 从 `Message` 对象获取 Reaction 列表。

## 前提条件

开始前，请确保满足以下条件：

- 完成 `1.0.5 或 以上版本` SDK 初始化，详见 [快速开始](./agora_chat_get_started_unity)。
- 了解 [使用限制](./agora_chat_limitation)。

## 实现方法

### 在消息上添加 Reaction

调用 `AddReaction` 在消息上添加 Reaction，在 `MessageReactionDidChange` 监听事件中会收到这条消息的最新 Reaction 概览。

示例代码如下：

```c#
// 添加 Reaction。
SDKClient.Instance.ChatManager.AddReaction(msg_id, reaction, new CallBack(
     onSuccess: () =>
     {
         Debug.Log($"AddReaction success.");
     },
     onError: (code, desc) =>
     {
         Debug.Log($"AddReaction failed, code:{code}, desc:{desc}");
     }
));

// 监听 Reaction 更新。
class ReactionManagerDelegate : IReactionManagerDelegate
{
    public void MessageReactionDidChange(List<MessageReactionChange> list)
    {
        if (list.Count == 0) return;
        foreach(var it in list)
        {
            //此处添加遍历列表代码
        }
    }
}

//添加 Reaction 监听器
ReactionManagerDelegate reactionManagerDelegate = new ReactionManagerDelegate();
SDKClient.Instance.ChatManager.AddReactionManagerDelegate(reactionManagerDelegate);
```

### 删除消息的 Reaction

调用 `RemoveReaction` 删除消息的 Reaction，在 `MessageReactionDidChange` 监听事件中会收到这条消息的最新 Reaction 概览。

示例代码如下：

```c#
// 删除 Reaction。
SDKClient.Instance.ChatManager.RemoveReaction(msg_id, reaction, new CallBack(
     onSuccess: () =>
     {
         Debug.Log($"RemoveReaction success.");
     },
     onError: (code, desc) =>
     {
         Debug.Log($"RemoveReaction failed, code:{code}, desc:{desc}");
     }
));

// 监听 Reaction 更新。
class ReactionManagerDelegate : IReactionManagerDelegate
{
    public void MessageReactionDidChange(List<MessageReactionChange> list)
    {
        if (list.Count == 0) return;
        foreach(var it in list)
        {
            //此处添加遍历列表代码
        }
    }
}

//添加 Reaction 监听器
ReactionManagerDelegate reactionManagerDelegate = new ReactionManagerDelegate();
SDKClient.Instance.ChatManager.AddReactionManagerDelegate(reactionManagerDelegate);
```

### 获取消息的 Reaction 列表

调用 `GetReactionList` 可以从服务器获取指定消息的 Reaction 概览列表，列表内容包含 Reaction 内容，用户数量，用户列表（概要数据，即前三个用户信息）。示例代码如下：

```c#
SDKClient.Instance.ChatManager.GetReactionList(messageIdList, chatType, groupId, new ValueCallBack<Dictionary<string, List<MessageReaction>>>(
onSuccess: (dict) =>
{
    //遍历返回的 Reaction 字典
    foreach (var it in dict)
    {
        //遍历字典每一个 List<MessageReaction>
        List<MessageReaction> rl = it.Value;
        foreach (var lit in rl)
        {
            //处理每一个 Reaction
        }
    }
},
onError: (code, desc) =>
{
    Debug.Log($"GetReactionList failed, code:{code}, desc:{desc}");
}
));
```

### 获取 Reaction 详情

调用 `GetReactionDetail` 可以从服务器获取指定 Reaction 的详情，包括 Reaction 内容，用户数量和全部用户列表。示例代码如下：

```c#
SDKClient.Instance.ChatManager.GetReactionDetail(msg_id, reaction, cursor, pageSize, new ValueCallBack<CursorResult<MessageReaction>>(
onSuccess: (ret) =>
{
    Debug.Log($"GetReactionDetail success");
    if (ret.Data.Count > 0)
    {
        MessageReaction mr = ret.Data[0];
        //处理获取到的 Reaction
    }
},
onError: (code, desc) =>
{
    Debug($"GetReactionDetail failed, code:{code}, desc:{desc}");
}
));
```