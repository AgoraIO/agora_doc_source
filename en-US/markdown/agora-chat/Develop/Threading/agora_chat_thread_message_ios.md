# Thread Management

Threads enable users to create a separate conversation from a specific message within a chat group to keep the main chat uncluttered.

This page shows how to use the Agora Chat SDK to send, receive, recall, and retrieve a thread message in your app.

## Understand the tech

The Agora Chat SDK provides the `AgoraChatChatManager`, `AgoraChatMessage`, and `AgoraChatChatThreadInfo` classes for thread messages, which allows you to implement the following features:

- Send a thread message
- Receive a thread message
- Recall a thread message
- Retrieve a thread message

The following figure shows the workflow of how clients send and receive peer-to-peer messages.

![](https://web-cdn.agora.io/docs-files/1643082196337)

1. Clients retrieve a token from your app server.
2. Client A and Client B log in to Agora Chat.
3. Client A sends a message to Client B. The message is sent to the Agora Chat server and the server delivers the message to Client B. When Client B receives the message, the SDK triggers an event. Client B listens for the event and gets the message.

## Prerequisites

Before proceeding, ensure that you meet the following requirements:

- You have initialized the Agora Chat SDK. For details, see [Get Started with iOS](./agora_chat_get_started_ios?platform=ios).
- You understand the call frequency limit of the Agora Chat APIs supported by different pricing plans as described in [Limitations](./agora_chat_limitation?platform=ios).
- You understand the number of threads and thread members supported by different pricing plans as described in [Pricing Plan Details](./agora_chat_plan?platform=ios).
- Contact support@agora.io to activate the threading feature.

## Implementation

This section describes how to call the APIs provided by the Agora Chat SDK to implement thread features.

### Send a thread message

Send a thread message is similar to send a message in a chat group. The difference lies in the `isThread` field, as shown in the following code sample:

```ObjectiveC
// Call `initWithConversationID` to create a text message. 
// Set `*message` to the content of the text message.
// Set `*to` to the ID of a thread that receives the text message.
NSString *from = [[AgoraChatClient sharedClient] currentUsername];
NSString *to = self.currentConversation.conversationId;
AgoraChatMessage *message = [[AgoraChatMessage alloc] initWithConversationID:to from:from to:to body:aBody ext:aExt];
// Specify whether a read receipt is required for this text message.
if([aExt objectForKey:MSG_EXT_READ_RECEIPT]) {
    message.isNeedGroupAck = YES;
}
// Set `chatType` to `AgoraChatTypeGroupChat` as a thread belongs to a chat group.
message.chatType = (AgoraChatType)self.conversationType;
// Set `isChatThread` to `true` to mark this message as a thread message.
message.isChatThread = self.isChatThread;
// Call `sendMessage` to send the text message.
[[AgoraChatClient sharedClient].chatManager sendMessage:message progress:nil completion:^(AgoraChatMessage *message, AgoraChatError *error) {

}];
```

For more information about sending a message, see [Send Messages](./agora_chat_message_ios?platform=iOS#send-and-receive-messages).


### Receive a thread message

Once a thread has a new message, all chat group members receive the `AgoraChatThreadManagerDelegate#onChatThreadUpdated` callback. For thread members, they can also listen for the `AgoraChatManagerDelegate#messagesDidReceive` callback to receive thread messages, as shown in the following code sample:

```ObjectiveC
- (void)messagesDidReceive:(NSArray *)aMessages
{
    // The SDK triggers the `AgoraChatManagerDelegate#messagesDidReceive` callback to notify that the thread has a new message.
}
// Call `addDelegate` to add a message listener.
[[AgoraChatClient sharedClient].chatManager addDelegate:self delegateQueue:nil];
// Call `removeDelegate` to remove the message listener.
[[AgoraChatClient sharedClient].chatManager removeDelegate:self];
```

For more information about receiving a message, see [Receive Messages](./agora_chat_message_ios?platform=iOS#send-and-receive-messages).


### Recall a thread message

For details about how to recall a message, refer to [Recall Messages](./agora_chat_message_ios?platform=iOS#recall-messages).

Once a message is recalled in a thread, all chat group members receive the `AgoraChatThreadManagerDelegate#onChatThreadUpdated` callback. For thread members, they can also listen for the `AgoraChatManagerDelegate#messagesDidReceive` callback, as shown in the following code sample:

```ObjectiveC
- (void)messagesInfoDidRecall:(NSArray<EMRecallMessageInfo *> *)aRecallMessagesInfo
{}
```

### Retrieve thread messages from the server

For details about how to retrieve messages from the server, see [Retrieve Historical Messages](./agora_chat_message_ios?platform=iOS#retrieve-historical-messages-from-the-server).