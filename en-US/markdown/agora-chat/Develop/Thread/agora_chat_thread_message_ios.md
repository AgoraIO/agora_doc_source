# Thread Messages

Threads enable users to create a separate conversation from a specific message within a chat group to keep the main chat uncluttered.

This page shows how to use the Agora Chat SDK to send, receive, recall, and retrieve thread messages in your app.

## Understand the tech

The Agora Chat SDK provides the `AgoraChatManager`, `AgoraChatMessage`, and `AgoraChatThread` classes for thread messages, which allows you to implement the following features:

- Send a thread message
- Receive a thread message
- Recall a thread message
- Retrieve a thread message

~338e0e30-e568-11ec-8e95-1b7dfd4b7cb0~

## Prerequisites

Before proceeding, ensure that you meet the following requirements:

- You have initialized the Agora Chat SDK. For details, see [Get Started with iOS](./agora_chat_get_started_ios?platform=ios).
- You understand the call frequency limit of the Agora Chat APIs supported by different pricing plans as described in [Limitations](./agora_chat_limitation?platform=ios).

<div class="alert info">The thread feature is supported by all types of <a href="https://docs.agora.io/en/agora-chat/agora_chat_plan">Pricing Plans</a> and is enabled by default once you have enabled Chat in <a href="https://console.agora.io/">Agora Console</a>.</div>

## Implementation

This section describes how to call the APIs provided by the Agora Chat SDK to implement thread features.

### Send a thread message

Sending a thread message is similar to sending a message in a chat group. The difference lies in the `isChatThread` field, as shown in the following code sample:

```ObjectiveC
// Calls `initWithConversationID` to create a text message. 
// Sets `*message` to the content of the text message.
// Sets `chatThreadId` to the thread ID.
NSString *from = [[AgoraChatClient sharedClient] currentUsername];
NSString *chatThreadId = self.currentConversation.conversationId;
AgoraChatMessage *message = [[AgoraChatMessage alloc] initWithConversationID:chatThreadId from:from to:chatThreadId body:aBody ext:aExt];
// Specifies whether a read receipt is required for this text message.
if([aExt objectForKey:MSG_EXT_READ_RECEIPT]) {
    message.isNeedGroupAck = YES;
}
// Sets `chatType` to `AgoraChatTypeGroupChat` as a thread belongs to a chat group.
message.chatType = (AgoraChatType)self.conversationType;
// Sets `isChatThread` to `YES` to mark this message as a thread message.
message.isChatThreadMessage = self.isChatThread;
// Calls `sendMessage` to send the text message.
[[AgoraChatClient sharedClient].chatManager sendMessage:message progress:nil completion:^(AgoraChatMessage *message, AgoraChatError *error) {

}];
```

For more information about sending a message, see [Send Messages](./agora_chat_send_receive_message_ios?platform=iOS#send-a-text-message).


### Receive a thread message

Once a thread has a new message, all chat group members receive the `AgoraChatThreadManagerDelegate#onChatThreadUpdated` callback. Thread members can also listen for the `AgoraChatManagerDelegate#messagesDidReceive` callback to receive thread messages, as shown in the following code sample:

```ObjectiveC
// The SDK triggers the `messagesDidReceive` callback when it receives a message.
// After receiving this callback, the SDK parses the message and displays it.
- (void)messagesDidReceive:(NSArray *)aMessages
{
    // You can implement subsequent settings in this callback.
}
// Calls `addDelegate` to add a message listener.
[[AgoraChatClient sharedClient].chatManager addDelegate:self delegateQueue:nil];
// Calls `removeDelegate` to remove the message listener.
[[AgoraChatClient sharedClient].chatManager removeDelegate:self];
```

For more information about receiving a message, see [Receive Messages](./agora_chat_send_receive_message_ios?platform=iOS#receive-a-message).


### Recall a thread message

For details about how to recall a message, refer to [Recall Messages](./agora_chat_send_receive_message_ios?platform=iOS#recall-a-message).

Once a message is recalled in a thread, all chat group members receive the `AgoraChatThreadManagerDelegate#onChatThreadUpdated` callback. Thread members can also listen for the `AgoraChatManagerDelegate#messagesInfoDidRecall` callback, as shown in the following code sample:

```ObjectiveC
// The SDK triggers the `messagesInfoDidRecall` callback when it recalls a message.
// After receiving this callback, the SDK parses the message and updates its display.
- (void)messagesInfoDidRecall:(NSArray<EMRecallMessageInfo *> *)aRecallMessagesInfo
{}
```

### Retrieve thread messages

You can retrieve thread messages locally or from the server, depending on your production environment.

You can check `AgoraChatConversation#isChatThread()` to determine whether the current conversation is a thread conversation.

#### Retrieve messages of a thread from the server

You can call `asyncFetchHistoryMessagesFromServer` to retrieve messages of a thread from the server. The only difference between retrieving messages of a thread from the server and retrieving group messages is that a thread ID needs to be passed in for the former and a group ID is required for the latter.

```ObjectiveC
[AgoraChatClient.sharedClient.chatManager asyncFetchHistoryMessagesFromServer:@"threadId" conversationType:AgoraChatConversationTypeGroupChat startMessageId:@"" fetchDirection:AgoraChatMessageFetchHistoryDirectionUp pageSize:20 completion:^(AgoraChatCursorResult<AgoraChatMessage *> * _Nullable aResult, AgoraChatError * _Nullable aError) {
            
    }];
```

#### Retrieve messages of a thread locally

By calling [`getAllConversations`](./agora_chat_manage_message_ios?platform=ios#retrieve-conversations), you can only retrieve local one-to-one chat conversations and group conversations. To retrieve messages of a thread locally, refer to the following code sample:

```ObjectiveC
AgoraChatConversation *conversation = [AgoraChatClient.sharedClient.chatManager getConversation:@"threadId" type:AgoraChatConversationTypeGroupChat createIfNotExist:NO isThread:YES];
[conversation loadMessagesStartFromId:msgId count:50 searchDirection:AgoraChatMessageSearchDirectionUp completion:^(NSArray *aMessages, AgoraChatError *aError) {
}];
```
