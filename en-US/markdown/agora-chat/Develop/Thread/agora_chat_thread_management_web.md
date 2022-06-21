# Thread Management

Threads enable users to create a separate conversation from a specific message within a chat group to keep the main chat uncluttered, as shown in the following illustration:

![](https://web-cdn.agora.io/docs-files/1655176932917)

This page shows how to use the Agora Chat SDK to create and manage threads in your app.


## Understand the tech

The Agora Chat SDK allows you to implement the following features:

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

- You have initialized the Agora Chat SDK. For details, see [Get Started with Web](./agora_chat_get_started_web?platform=Web).
- You understand the call frequency limit of the Agora Chat APIs supported by different pricing plans as described in [Limitations](./agora_chat_limitation?platform=Web).
- You understand the number of threads and thread members supported by different pricing plans as described in [Pricing Plan Details](./agora_chat_plan?platform=Web).


## Implementation

This section describes how to call the APIs provided by the Agora Chat SDK to implement thread features.

### Create a thread

All chat group members can call `createChatThread` to create a thread from a specific message in a chat group.

Once a thread is created in a chat group, all chat group members receive the `onChatThreadChange` callback triggered by the `create` event. In a multi-device scenario, all the other devices receive the `onMultiDeviceEvent` callback triggered by the `chatThreadCreate` event.

The following code sample shows how to create a thread in a chat group:

```javascript
// parentId: The ID of a chat group where a thread resides.
// threadName: The name of a thread. The maximum length of a thread name is 64 characters.
// messageId: The ID of a message, from which a thread is created.
conn.createChatThread({parentId: 'parentId',name: 'threadName',messageId: 'messageId'})
// Listen for the creating thread callback.
conn.addEventHandler('THREAD',{
  onChatThreadChange:(threadMsg) =>{
			console.log(threadMsg)
	},
});
```

### Destroy a thread

Only the chat group owner and admins can call `destroyChatThread` to disband a thread in a chat group.

Once a thread is disbanded, all chat group members receive the `onChatThreadChange` callback triggered by the `destroy` event. In a multi-device scenario, all the other devices receive the `onMultiDeviceEvent` callback triggered by the `chatThreadDestroy` event.

<div class="alert note">Once a thread is destroyed or the chat group where a thread resides is destroyed, all data of the thread is deleted from the local database and memory.</div>

The following code sample shows how to destroy a thread:

```javascript
// chatThreadId: The ID of a thread that you want to destroy.
conn.destroyChatThread({chatThreadId: 'chatThreadId'})
// Listen for the destroying thread callback.
conn.addEventHandler('THREAD',{
  onChatThreadChange:(threadMsg) =>{
			console.log(threadMsg)
	},
});
```

### Join a thread

All chat group members can refer to the following steps to join a thread:

1. Use either of the following two approaches to retrieve the thread ID:
- Retrieve the thread list in a chat group by calling `getChatThreads`, and locate the ID of the thread that you want to join.
- Retrieve the thread ID within the `onChatThreadChange` callback that you receive.
2. Call `joinChatThread` to pass in the thread ID and join the specified thread.

In a multi-device scenario, all the other devices receive the `onMultiDeviceEvent` callback triggered by the `chatThreadJoin` event.

The following code sample shows how to join a thread:

```javascript
// chatThreadId: The ID of a thread that you want to join.
conn.joinChatThread({chatThreadId: 'chatThreadId'});
```


### Leave a thread

All thread members can call `leaveChatThread` to leave a thread. Once a member leaves a thread, they can no longer receive the thread messages.

In a multi-device scenario, all the other devices receive the `onMultiDeviceEvent` callback triggered by the `chatThreadLeave` event.

The following code sample shows how to leave a thread:

```javascript
// chatThreadId: The ID of a thread that you want to leave.
conn.leaveChatThread({chatThreadId: 'chatThreadId'});
```


### Remove a member from a thread

Only the chat group owner and admins can call `removeChatThreadMember` to remove the specified member from a thread.

Once a member is removed from a thread, they receive the `onChatThreadChange` callback triggered by the `userRemove` event and can no longer receive the thread messages.

The following code sample shows how to remove a member from a thread:

```javascript
// chatThreadId: The ID of a thread.
// username: The ID of the user to be removed from a thread.
conn.removeChatThreadMember({chatThreadId: 'chatThreadId',username:'username'}); 
```


### Update the name of a thread

Only the chat group owner, chat group admins, and thread creator can call `changeChatThreadName` to update a thread name.

Once a thread name is updated, all chat group members receive the `onChatThreadChange` callback triggered by the `update` event. In a multi-device scenario, all the other devices receive the `onMultiDeviceEvent` callback triggered by the `chatThreadNameUpdate` event.

The following code sample shows how to update a thread name:

```javascript
// chatThreadId: The ID of a thread.
// name: The updated thread name. The maximum length of a thread name is 64 characters.
conn.changeChatThreadName({chatThreadId: 'chatThreadId',name: 'name'})
// Listen for the updating thread name callback.
conn.addEventHandler('THREAD',{
  onChatThreadChange:(threadMsg) =>{
			console.log(threadMsg)
	},
});
```


### Retrieve the attributes of a thread

All chat group members can call `getChatThreadDetail` to retrieve the thread attributes from the server.

The following code sample shows how to retrieve the thread attributes:

```javascript
// chatThreadID: The thread ID.
conn.getChatThreadDetail({chatThreadId: 'chatThreadId'}).then((res)=>{
  console.log(res)
});
```


### Retrieve the member list of a thread

All chat group members can call `getChatThreadMembers` to retrieve a paginated member list of a thread from the server.

```javascript
// chatThreadId: The thread ID.
// pageSize: The maximum number of members to retrieve per page. The range is [1, 50].
// cursor: The position from which to start getting data. Pass in `null` or an empty string at the first call.
conn.getChatThreadMembers({chatThreadId: 'chatThreadId ',pageSize:20,cursor:'cursor'}).then((res)=>{
  console.log(res)
});
```


### Retrieve a thread list

Users can call `getJoinedChatThreads` to retrieve a paginated list from the server of all the threads they have joined, as shown in the following code sample:

```javascript
// pageSize: The maximum number of threads to retrieve per page. The range is [1, 50].
// cursor: The position from which to start getting data. Pass in `null` or an empty string at the first call.
conn.getJoinedChatThreads({cursor: 'cursor',pageSize: 20}).then((res)=>{
  console.log(res)
});
```

Users can call `getJoinedChatThreads` to retrieve a paginated list from the server of all the threads they have joined in a specified chat group, as shown in the following code sample:

```javascript
// parentId: The chat group ID.
// pageSize: The maximum number of threads to retrieve per page. The range is [1, 50].
// cursor: The position from which to start getting data. Pass in `null` or an empty string at the first call.
conn.getJoinedChatThreads({parentId: 'parentId',cursor: 'cursor',pageSize: 20}).then((res)=>{
  console.log(res)
});
```

Users can also call `getChatThreads` to retrieve a paginated list from the server of all the threads in a specified chat group, as shown in the following code sample:

```javascript
// parentId: The chat group ID.
// pageSize: The maximum number of threads to retrieve per page. The range is [1, 50].
// cursor: The position from which to start getting data. Pass in `null` or an empty string at the first call.
conn.getChatThreads({parentId: 'parentId', cursor:'cursor', pageSize: 20}).then((res)=>{
  console.log(res)
});
```


### Retrieve the latest message from multiple threads

Users can call `getChatThreadLastMessage` to retrieve the latest message from multiple threads.

The following code sample shows how to retrieve the latest message from multiple threads:

```javascript
// chatThreadIds: The thread IDs. You can pass in a maximum of 20 thread IDs.
conn.getChatThreadLastMessage({chatThreadIds: ['chatThreadId1','chatThreadId2']}).then((res)=>{
  console.log(res)
});
```