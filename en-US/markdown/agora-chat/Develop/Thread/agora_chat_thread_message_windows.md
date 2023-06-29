# Thread messages

Threads enable users to create a separate conversation from a specific message within a chat group to keep the main chat uncluttered.

This page shows how to use the Agora Chat SDK to send, receive, recall, and retrieve thread messages in your app.


## Understand the tech

The Agora Chat SDK allows you to implement the following features:

- Send a thread message
- Receive a thread message
- Recall a thread message
- Retrieve a thread message

~338e0e30-e568-11ec-8e95-1b7dfd4b7cb0~

## Prerequisites

Before proceeding, ensure that you meet the following requirements:

- You have initialized the Agora Chat SDK. For details, see [Get Started with Windows](./agora_chat_get_started_windows).
- You understand the call frequency limit of the Agora Chat APIs supported by different pricing plans as described in [Limitations](./agora_chat_limitation).

<div class="alert info">The thread feature is supported by all types of <a href="https://docs.agora.io/en/agora-chat/agora_chat_plan">Pricing Plans</a> and is enabled by default once you have enabled Chat in <a href="https://console.agora.io/">Agora Console</a>.</div>


## Implementation

This section describes how to call the APIs provided by the Agora Chat SDK to implement thread features.


### Send a thread message

Send a thread message is similar to send a message in a chat group. The difference lies in the `IsThread` field, as shown in the following code sample:

```c#
// Creates a text message. Sets `chatThreadId` to the thread ID and `content` to the message content. 
Message msg = Message.CreateTextSendMessage(chatThreadId, content);
// Sets the message type. For thread messages, set `ChatType` as `GroupChat`.
msg.MessageType = MessageType.Group
// Set the `IsThread` flag as `true`.
mmsg.IsThread = true;
// You can create an `CallBack` instance to get the status of message sending. You can update the message status in the callback, such as the information to display when users failed to send a message.
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

For more information about sending a message, see [Send Messages](./agora_chat_send_receive_message_windows#send-a-text-message).


### Receive a thread message

Once a thread has a new message, all chat group members receive the `IChatThreadManagerDelegate#OnUpdateMyThread` callback. Thread members can also listen for the `IChatManagerDelegate#OnMessagesReceived` callback to receive thread messages, as shown in the following code sample:

```c#
// Inherits and implements `IChatManagerDelegate`.
public class ChatManagerDelegate : IChatManagerDelegate {
    // Implements the `MessagesReceived` callback.
    public void OnMessagesReceived(List<Message> messages)
    {
      // When receiving messages, iterates through the message list and parses and displays the message.
    }
}
// Registers an listener.
ChatManagerDelegate adelegate = new ChatManagerDelegate();
SDKClient.Instance.ChatManager.AddChatManagerDelegate(adelegate);
// Removes the listener.
SDKClient.Instance.ChatManager.RemoveChatManagerDelegate(adelegate);
```

For more information about receiving a message, see [Receive Messages](./agora_chat_send_receive_message_windows#receive-a-message).


### Recall a thread message

Send a thread message is similar to send a message in a chat group. The difference lies in the `isChatThread` field.

Once a message is recalled in a thread, all chat group members receive the `IChatThreadManagerDelegate#OnUpdateMyThread` callback. Thread members can also listen for the `IChatManagerDelegate#OnMessagesRecalled` callback, as shown in the following code sample:

```c#
// Inherits and implements IChatManagerDelegate.
public class ChatManagerDelegate : IChatManagerDelegate {
    // Implements the `OnMessagesRecalled` callback.
    public void OnMessagesRecalled(List<Message> messages)
    {
      // When receiving messages, iterates through the message list and parses and displays the message.
    }
}
// Registers an listener.
ChatManagerDelegate adelegate = new ChatManagerDelegate();
SDKClient.Instance.ChatManager.AddChatManagerDelegate(adelegate);
// Removes the listener.
SDKClient.Instance.ChatManager.RemoveChatManagerDelegate(adelegate);
```

For more information about recalling a message, see [Recall Messages](./agora_chat_send_receive_message_windows#recall-a-message).


### Retrieve thread messages

You can retrieve thread messages locally or from the server, depending on your production environment.

You can check `Conversation#IsThread()` to determine whether the current conversation is a thread conversation.

#### Retrieve messages of a thread from the server

You can call `ChatManager#FetchHistoryMessagesFromServer` to retrieve messages of a thread from the server. The only difference between retrieving messages of a thread from the server and retrieving group messages is that a thread ID needs to be passed in for the former and a group ID is required for the latter.

```c#
SDKClient.Instance.ChatManager.FetchHistoryMessagesFromServer(threadId, ConversationType.Group, startMsgId, pageSize, MessageSearchDirection.DOWN, new ValueCallBack<CursorResult<Message>>(
          onSuccess: (result) =>
          {
              foreach (var msg in result.Data)
              {
                  //process every message
              }
          },
          onError: (code, desc) =>
          {
          }
      ));
```      

#### Retrieve messages of a thread locally

By calling `ChatManager#LoadAllConversations`, you can only retrieve local one-to-one chat conversations and group conversations. To retrieve messages of a thread locally, refer to the following code sample:

```c#
// Specifies the conversation type by setting `ConversationType.Group` and setting `isChatThread` as `true`.
Conversation conversation = SDKClient.Instance.ChatManager.GetConversation(chatThreadId, EMConversationType.GroupChat, createIfNotExists, isChatThread);
// If you want to handle thread messages from your local database, use the following methods to retrieve the messages. The SDK automatically stores the retrieved messages to the memory.
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