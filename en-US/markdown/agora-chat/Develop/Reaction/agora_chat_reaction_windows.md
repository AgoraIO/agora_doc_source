Emojis are widely used in real-time chats because they allow users to express their feelings in a direct and vivid way. In Agora Chat, "reactions" allow users to quickly react to a message using emojis in one-to-one chats and chat groups. In group chats, reactions can also be used to cast a vote, for example, by calculating the number of different emojis attached to the message.

The following illustration shows the implementation of adding a reaction to a message, how a conversation looks with reactions, and what retrieving a list of reactions (with related information) looks like.

![](https://web-cdn.agora.io/docs-files/1655257598155)

This page shows how to use the Agora Chat SDK to implement reactions in your project.

## Understand the tech

The SDK provides the following APIs to implement reaction functionalities:

- `AddReaction`: Adds a reaction to the specified message.
- `RemoveReaction`: Removes the reaction from the specified message.
- `GetReactionList`: Retrieves a list of reactions from the server.
- `GetReactionDetail`: Retrieves the details of the reaction from the server.
- `Message.ReactionList`: Retrieves a list of reactions from the Message object.

## Prerequisites

Before proceeding, ensure that your environment meets the following requirements:

- Your project integrates a version of the Agora Chat SDK later than v1.0.6 and has implemented the basic [real-time chat functionalities](../Unity/quick_start_windows.md).
- You understand the API call frequency limit as described in [Limitations](./agora_chat_limitation?platform=Windows).

<div class="alert info">The reaction feature is supported by all types of <a href="https://docs.agora.io/en/agora-chat/agora_chat_plan">Pricing Plans</a> and is enabled by default once you have enabled Chat in <a href="https://console.agora.io/">Agora Console</a>.</div>

## Implementation

This section introduces how to implement reaction functionalities in your project.

### Add a reaction

Call `AddReaction` to add a reaction to the specified message. You can use `MessageReactionDidChange` to listen for the state of adding the reaction.

```c#
// Adds a reaction to the specified message
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

// Listens for the reaction changes.
class ReactionManagerDelegate : IReactionManagerDelegate
{
    public void MessageReactionDidChange(List<MessageReactionChange> list)
    {
        if (list.Count == 0) return;
        foreach(var it in list)
        {
            // Add the iteration logic here.
        }
    }
}

// Adds a listener for the reaction.
ReactionManagerDelegate reactionManagerDelegate = new ReactionManagerDelegate();
SDKClient.Instance.ChatManager.AddReactionManagerDelegate(reactionManagerDelegate);
```

### Remove a reaction

Call `RemoveReaction` to remove the specified reaction. You can also listen for the reaction change in `MessageReactionDidChange`.

```c#
// Removes the reaction.
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

// Listens for the reaction changes.
class ReactionManagerDelegate : IReactionManagerDelegate
{
    public void MessageReactionDidChange(List<MessageReactionChange> list)
    {
        if (list.Count == 0) return;
        foreach(var it in list)
        {
            // Add the iteration logic here.
        }
    }
}

// Adds a listener for the reaction.
ReactionManagerDelegate reactionManagerDelegate = new ReactionManagerDelegate();
SDKClient.Instance.ChatManager.AddReactionManagerDelegate(reactionManagerDelegate);
```

### Retrieve a list of reactions

Call `GetReactionList` to retrieve a list of reactions from the server. This method also returns the basic information of the reactions, including the content of the reaction, the number of users that added or removed the reaction, and a list of the first three user IDs that added or removed the reaction.

```c#
SDKClient.Instance.ChatManager.GetReactionList(messageIdList, chatType, groupId, new ValueCallBack<Dictionary<string, List<MessageReaction>>>(
onSuccess: (dict) =>
{
    // Iterates through the returned reaction dictionary.
    foreach (var it in dict)
    {
        // Iterates each list of reaction in the dictionary.
        List<MessageReaction> rl = it.Value;
        foreach (var lit in rl)
        {
            // Handles each reaction.
        }
    }
},
onError: (code, desc) =>
{
    Debug.Log($"GetReactionList failed, code:{code}, desc:{desc}");
}
));
```

### Retrieve the details of the reaction

Call `GetReactionDetail` to get the detailed information of the reaction from the server. The detailed information includes the reaction content, the number of users that added or removed the reaction, and the complete list of user IDs that added or removed the reaction.

```c#
SDKClient.Instance.ChatManager.GetReactionDetail(msg_id, reaction, cursor, pageSize, new ValueCallBack<CursorResult<MessageReaction>>(
onSuccess: (ret) =>
{
    Debug.Log($"GetReactionDetail success");
    if (ret.Data.Count > 0)
    {
        MessageReaction mr = ret.Data[0];
        // Handles the retrieved reaction.
    }
},
onError: (code, desc) =>
{
    Debug($"GetReactionDetail failed, code:{code}, desc:{desc}");
}
));
```

