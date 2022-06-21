# Thread Management

Threads enable users to create a separate conversation from a specific message within a chat group to keep the main chat uncluttered.

The following illustration shows the implementation of creating a thread, a conversation in a thread, and the operations you can perform in a thread.

![](https://web-cdn.agora.io/docs-files/1655176216910)

This page shows how to use the Agora Chat SDK to create and manage threads in your app.

## Understand the tech

The Agora Chat SDK provides the `AgoraChatThreadManager`, `AgoraChatThread`, `AgoraChatThreadManagerDelegate`, and `AgoraChatThreadEvent` classes for thread management, which allows you to implement the following features:

- Create and destroy a thread
- Join and leave a thread
- Remove a member from a thread
- Update the name of a thread
- Retrieve the attributes of a thread
- Retrieve the member list of a thread
- Retrieve a thread list
- Retrieve the latest message from multiple threads
- Listen for thread events

## Prerequisites

Before proceeding, ensure that you meet the following requirements:

- You have initialized the Agora Chat SDK. For details, see [Get Started with iOS](./agora_chat_get_started_ios?platform=ios).
- You understand the call frequency limit of the Agora Chat APIs supported by different pricing plans as described in [Limitations](./agora_chat_limitation?platform=ios).
- You understand the number of threads and thread members supported by different pricing plans as described in [Pricing Plan Details](./agora_chat_plan?platform=ios).

## Implementation

This section describes how to call the APIs provided by the Agora Chat SDK to implement thread features.

### Create a thread

All chat group members can call `createChatThread` to create a thread from a specific message in a chat group.

Once a thread is created in a chat group, all chat group members receive the `AgoraChatThreadManagerDelegate#onChatThreadCreated` callback. In a multi-device scenario, all the other devices receive the `multiDevicesThreadEventDidReceive` callback triggered by the `AgoraChatMultiDevicesEventThreadCreate` event. 

The following code sample shows how to create a thread in a chat group:

```ObjectiveC
// threadName: The name of a thread. The maximum length of a thread name is 64 characters.
// messageId: The ID of a message, from which a thread is created.
// parentId: The ID of a chat group where a thread resides.
[[AgoraChatClient sharedClient].threadManager createChatThread:self.threadName messageId:self.message.message.messageId parentId:self.message.message.to completion:^(AgoraChatThread *thread, AgoraChatError *aError) {
    if (!aError) {

    } else {

    }
}];
```

### Destroy a thread

Only the chat group owner and admins can call `destroyChatThread` to disband a thread in a chat group.

Once a thread is disbanded, all chat group members receive the `AgoraChatThreadManagerDelegate#onChatThreadDestroyed` callback. In a multi-device scenario, all the other devices receive the `multiDevicesThreadEventDidReceive` callback triggered by the `AgoraChatMultiDevicesEventThreadDestroy` event. 

<div class="alert note">Once a thread is destroyed or the chat group where a thread resides is destroyed, all data of the thread is deleted from the local database and memory.</div>

The following code sample shows how to destroy a thread:

```ObjectiveC
[AgoraChatClient.sharedClient.threadManager destroyChatThread:self.conversationId completion:^(AgoraChatError *aError) {
    if (!aError) {

    } else {

    }
}];
```

### Join a thread

All chat group members can refer to the following steps to join a thread:

1. Use either of the following two approaches to retrieve the thread ID:
- Retrieve the thread list in a chat group by calling [`getChatThreadsFromServer`](#fetch), and locate the ID of the thread that you want to join.
- Retrieve the thread ID within the `AgoraChatThreadManagerDelegate#onChatThreadCreated` and `AgoraChatThreadManagerDelegate#onChatThreadUpdated` callbacks that you receive.

2. Call `joinChatThread` to pass in the thread ID and join the specified thread.

In a multi-device scenario, all the other devices receive the `multiDevicesThreadEventDidReceive` callback triggered by the `AgoraChatMultiDevicesEventThreadJoin` event. 

The following code sample shows how to join a thread:

```ObjectiveC
[AgoraChatClient.sharedClient.threadManager joinChatThread:model.message.threadOverView.threadId completion:^(AgoraChatThread *thread,AgoraChatError *aError) {
    if (!aError || aError.code == AgoraChatErrorUserAlreadyExist) {
  
    }
}];
```

### Leave a thread

All thread members can call `leaveChatThread` to leave a thread. Once a member leaves a thread, they can no longer receive the thread messages.

In a multi-device scenario, all the other devices receive the `multiDevicesThreadEventDidReceive` callback triggered by the `AgoraChatMultiDevicesEventThreadLeave` event. 

The following code sample shows how to leave a thread:

```ObjectiveC
[AgoraChatClient.sharedClient.threadManager leaveChatThread:self.conversationId completion:^(AgoraChatError *aError) {
    if (!aError) {

    } else {

    }
}];
```

### Remove a member from a thread

Only the chat group owner and admins can call `removeMemberFromChatThread` to remove the specified member from a thread.

Once a member is removed from a thread, they receive the `AgoraChatThreadManagerDelegate#onUserKickOutOfChatThread` callback and can no longer receive the thread messages.

The following code sample shows how to remove a member from a thread:

```ObjectiveC
// chatThreadId: The ID of a thread.
// member: The ID of the user to be removed from a thread.
[AgoraChatClient.sharedClient.threadManager removeMemberFromChatThread:member threadId:self.threadId completion:^(AgoraChatError *aError) {
    if (!aError) {

    } else {

    }
}];
```

### Update the name of a thread

Only the chat group owner, chat group admins, and thread creator can call `updateChatThreadName` to update a thread name.

Once a thread name is updated, all chat group members receive the `AgoraChatThreadManagerDelegate#onChatThreadUpdated` callback. In a multi-device scenario, all the other devices receive the `multiDevicesThreadEventDidReceive` callback triggered by the `AgoraChatMultiDevicesEventThreadUpdate` event.

The following code sample shows how to update a thread name:

```ObjectiveC
// threadId: The ID of a thread.
// ThreadName: The updated thread name. The maximum length of a thread name is 64 characters.
[AgoraChatClient.sharedClient.threadManager updateChatThreadThreadName:self.threadNameField.text threadId:self.threadId completion:^(AgoraChatError *aError) {
    if (!aError) {

    } else {

    }
}];
```

### Retrieve the attributes of a thread

All chat group members can call `getChatThreadDetail` to retrieve the thread attributes from the server.

The following code sample shows how to retrieve the thread attributes:

```ObjectiveC
// threadId: The thread ID.
[AgoraChatClient.sharedClient.threadManager getChatThreadDetail:self.currentConversation.conversationId completion:^(AgoraChatThread *thread, AgoraChatError *aError) {
    if (!aError) {

    } else {

    }
}];
```

### Retrieve the member list of a thread

All chat group members can call `getChatThreadMemberListFromServerWithId` to retrieve a paginated member list of a thread from the server, as shown in the following code sample:

```ObjectiveC
// threadId: The thread ID.
// pageSize: The maximum number of members to retrieve per page. The range is [1, 50].
// cursor: The position from which to start getting data. Pass in `null` or an empty string at the first call.
[[AgoraChatClient sharedClient].threadManager getChatThreadMemberListFromServerWithId:self.threadId cursor:aCursor pageSize:pageSize completion:^(AgoraChatCursorResult *aResult, AgoraChatError *aError) {
    if !aError { self.cursor = aResult; }
}];
```

### Retrieve a thread list

Users can call `getJoinedChatThreadsFromServer` to retrieve a paginated list from the server of all the threads they have joined, as shown in the following code sample:

```ObjectiveC
// limit: The maximum number of threads to retrieve per page. The range is [1, 50].
// cursor: The position from which to start getting data. Pass in `null` or an empty string at the first call.        
[AgoraChatClient.sharedClient.threadManager getJoinedChatThreadsFromServerWithCursor:@"" pageSize:20 completion:^(AgoraChatCursorResult * _Nonnull result, AgoraChatError * _Nonnull aError) {
        
}];
```

Users can call `getJoinedChatThreadsFromServer` to retrieve a paginated list from the server of all the threads they have joined in a specified chat group, as shown in the following code sample:

```ObjectiveC
// parentId: The chat group ID.
// pageSize: The maximum number of threads to retrieve per page. The range is [1, 50].
// cursor: The position from which to start getting data. Pass in `null` or an empty string at the first call. 
[AgoraChatClient.sharedClient.threadManager getJoinedChatThreadsFromServerWithParentId:self.group.groupId cursor:self.cursor ? self.cursor.cursor:@"" pageSize:20 completion:^(AgoraChatCursorResult * _Nonnull result, AgoraChatError * _Nonnull aError) {
    if (!aError) {

    }
}];
```

Users can also call `getChatThreadsFromServer` to retrieve a paginated list from the server of all the threads in a specified chat group, as shown in the following code sample:<a name="fetch"></a>

```ObjectiveC
// parentId: The chat group ID.
// pageSize: The maximum number of threads to retrieve per page. The range is [1, 50].
// cursor: The position from which to start getting data. Pass in `null` or an empty string at the first call. 
[[AgoraChatClient sharedClient].threadManager getChatThreadsFromServerWithParentId:self.group.groupId cursor:self.cursor ? self.cursor.cursor:@"" pageSize:20 completion:^(AgoraChatCursorResult *result, AgoraChatError *aError) {
    if (!aError) {

    }
}];
```

### Retrieve the latest message from multiple threads

Users can call `getLastMessageFromSeverWithChatThreads` to retrieve the latest message from multiple threads.

The following code sample shows how to retrieve the latest message from multiple threads:

```ObjectiveC
// threadIds: The thread IDs. You can pass in a maximum of 20 thread IDs.
[[AgoraChatClient sharedClient].threadManager getLastMessageFromSeverWithChatThreads:ids completion:^(NSDictionary<NSString *,AgoraChatMessage *> * _Nonnull messageMap, AgoraChatError * _Nonnull aError) {
    if (!aError) {

    }
}];
```

### Listen for thread events

To monitor the thread events, users can listen for the callbacks in the `AgoraChatThreadManager` class and add app logics accordingly. If a user wants to stop listening for the callbacks, make sure that the user removes the listener to prevent memory leakage.

Refer to the following code sample to listen for thread events:

```ObjectiveC
AgoraChatThreadManagerDelegate 
// Occurs when a thread is created.
- (void)onChatThreadCreate:(AgoraChatThreadEvent *)event;

// Occurs when a thread has a new message, a thread name is updated, or a thread message is recalled.
- (void)onChatThreadUpdate:(AgoraChatThreadEvent *)event;

// Occurs when a thread is destroyed.
- (void)onChatThreadDestroy:(AgoraChatThreadEvent *)event;

// Occurs when a member is removed from a thread.
- (void)onUserKickOutOfChatThread:(AgoraChatThreadEvent *)event;

// Adds the thread listener.
[[AgoraChatClient sharedClient].threadManager addDelegate:self delegateQueue:nil];
// Removes the thread listener.
[[AgoraChatClient sharedClient].threadManager removeDelegate:self];
```