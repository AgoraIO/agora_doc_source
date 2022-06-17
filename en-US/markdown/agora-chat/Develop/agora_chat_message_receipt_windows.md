After a user sends a message to another chat user or chat group, this user expects to know whether the message is delievered or read. The Agora Chat SDK provides the message receipt feature, which enables you to send a receipt to the message sender once the message is delievered or read.

This page introduces how to use the Agora Chat SDK to implement message receipt functionalities in one-to-one chats and chat groups.

## Understand the tech

The Agora Chat SDK uses `IChatManager` to provide message receipt. Followings are the core methods:

- `Options.RequireDeliveryAck`: Enable message delievery receipt.
- `IChatManager.SendConversationReadAck`: Send a conversation read receipt.
- `IChatManager.SendMessageReadAck`: Send a message read receipt.
- `SendReadAckForGroupMessage`: Send a message read receipt for group chat.

## Prerequisites

Before proceeding, ensure that you meet the following requirements:

- You have integrated the Agora Chat SDK, initialized the SDK and implemented the functionality of registering accounts and login. For details, see [Get Started with Agora Chat](./agora_chat_get_started_windows?platform=Windows).
- You understand the API call frequency limits as described in [Limitations](./agora_chat_limitation?platform=Windows).
- Message read receipts for chat groups are not enabled by default. To use this feature, contact support@agora.io.

## Implementation

This section introduces how to implement message delivery and read receipts in your chat app.

### Message delievery receipts

To send a message delievery receipt, take the following steps:

1. The message sender sets `RequireDeliveryAck` in `ChatOptions` as `true` before sending the message:

    ```C#
    Options.RequireDeliveryAck = true;
    ```

2. Once the recipient receives the message, the SDK triggers `OnMessageDelivered` on the message sender's client, notifying the message sender that the message has been delivered to the recipent.

    ```C#
    // Inherit and instantiate `IChatManagerDelegate`.
    public class ChatManagerDelegate : IChatManagerDelegate {
        // Occurs when the message is delivered.
        public void OnMessagesDelivered(List<Message> messages)
        {
        }
    }
    // Add the chat manager delegate.
    ChatManagerDelegate adelegate = new ChatManagerDelegate();
    SDKClient.Instance.ChatManager.AddChatManagerDelegate(adelegate);
    // Remove the delegate.
    SDKClient.Instance.ChatManager.RemoveChatManagerDelegate(adelegate);
    ```

### Conversation and message read receipts

In both one-to-one chats and group chats, you can use message read receipts to notify the message sender that the message has been read. To minimize the method call for message read receipts, the SDK also supports conversation read receipts in one-to-one chats. 

#### One-to-one chats

In one-to-one chats, the SDK supports sending both the conversation read receipts and message read receipts. Agora recommends using conversation read receipts if the new message arrives when the message recipient has not entered the conversation UI. 

- Conversation read receipts

    Follow the steps to implement conversation read receipts in one-to-one chats.

    1. When a user enters the conversation UI, check whether the conversation contains unread messages. If yes, call `SendConversationReadAck` to send a conversation read receipt.

        ```C#
        SDKClient.Instance.ChatManager.SendConversationReadAck(conversationId, new CallBack(
        onSuccess: () => {
                            
        },
        onError:(code, desc) => {
                    
        }
        ));
        ```

    2. The message sender listens for message events and receives the conversation read receipt in `OnConversationRead`.

        ```C#
        // Inherit and instantiate `IChatManagerDelegate`.
        public class ChatManagerDelegate : IChatManagerDelegate {
            // Occurs when the conversation read receipt is received.
            // `from` indicates the message recipient that sends this receipt, and `to` indicates the message sender that receives this receipt.
            public void OnConversationRead(string from, string to)
            {
            }
        }
        // Add a chat manager delegate.
        ChatManagerDelegate adelegate = new ChatManagerDelegate()
        SDKClient.Instance.ChatManager.AddChatManagerDelegate(adelegate);
        // Remove the delegate.
        SDKClient.Instance.ChatManager.RemoveChatManagerDelegate(adelegate);
        ```

    <div class="alert note">In scenarios where a user is logged in multiple devices, if the user sends a conversation read receipt from one device, the server sets the count of unread messages in the conversation as 0, and all the other devices receive `OnConversationRead`.</note>

- Message read receipts

    To implement the message read receipt, take the following steps:

    1. Send a converation read receipt when the recipient enters the conversation.

        ```C#
        SDKClient.Instance.ChatManager.SendConversationReadAck(conversationId, new CallBack(
        onSuccess: () => {
                            
        },
        onError:(code, desc) => {
                    
        }
        ));
        ```

    2. When a new message arrives, send the message read receipt and add proper handling logics for the different message types.

        ```C#
        // Inherit and instantiate `IChatManagerDelegate`.
        public class ChatManagerDelegate : IChatManagerDelegate {
            // Occurs when the message is received.
            public void OnMessageReceived(List<Message> messages)
            {
            ......
            sendReadAck(message);
            ......
            }
        }
        // Add a chat manager delegate.
        ChatManagerDelegate adelegate = new ChatManagerDelegate()
        SDKClient.Instance.ChatManager.AddChatManagerDelegate(adelegate);
        // Send a message read receipt.
        public void sendReadAck(Message message) {
            // For a received message that has not sent a read receipt.
            if(message.Direction == MessageDirection.RECEIVE
            && !message.HasReadAck
            && message.MessageType == MessageType.Chat) {
                MessageBodyType type = message.Body.Type;
                // For attachment messages such as video and voice, send the message read receipt after the receiver clicks the files.
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
    3. The message sender listens for the message receipt:

        ```C#
        // Inherit and instantiate `IChatManagerDelegate`.
        public class ChatManagerDelegate : IChatManagerDelegate {
            // Occurs when the message is read.
            public void OnMessagesRead(string from, string to)
            {
            }
        }
        // Add a chat manager delegate.
        ChatManagerDelegate adelegate = new ChatManagerDelegate()
        SDKClient.Instance.ChatManager.AddChatManagerDelegate(adelegate);
        // Remove the delegate.
        SDKClient.Instance.ChatManager.RemoveChatManagerDelegate(adelegate);
        ```



#### Chat groups

In group chats, you can use message read receipts to notify the group owner or admins that the chat group message has been read. Ensure that each group member that has read the message should send a message read receipt.

Follow the steps to implement chat message read receipts.

1. For chat group messages, the group owner and admins can set to require the message read receipt when sending the message.

    ```C#
    // Set `IsNeedGroupAck` in `Message` as `true` when creating the message.
    Message msg = Message.CreateTextSendMessage("to", "hello world");
    msg.IsNeedGroupAck = true;
    ```

2. After the group member reads the chat group message, call `SendReadAckForGroupMessage` from the group member's client to send a message read receipt:

    ```C#
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

3. The message sender listens for the message read receipt.

    ```C#
    // Inherit and instantiate `IChatManagerDelegate`.
    public class ChatManagerDelegate : IChatManagerDelegate {
        // Occurs when the group message is read.
        public void OnGroupMessageRead(List<GroupReadAck> list)
        {
        }
    }
    // Add a chat manager delegate.
    ChatManagerDelegate adelegate = new ChatManagerDelegate()
    SDKClient.Instance.ChatManager.AddChatManagerDelegate(adelegate);
    ```

4. The message sender can get the detailed informaiton of the read receipt using `FetchGroupReadAcks`.

    ```C#
    SDKClient.Instance.ChatManager.FetchGroupReadAcks(messageId, groupId, startAckId, pageSize, new ValueCallBack<List<GroupReadAck>>(
        onSuccess: (list) =>
        {
        // Updates the UI.
        },
        onError: (code, desc) =>
        {
        }
    ));
    ```
