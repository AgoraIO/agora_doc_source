1. Clear all conversations and messages in them

`deleteAllMessagesAndConversations`

```javascript
conn.deleteAllMessagesAndConversations().then(() => {
  // Succeeded in clearing all conversations and messages in them.
})


```

2. Mark a conversation

`addConversationMark`

```javascript
const options = {
  conversations: [
    {conversationId: 'test', conversationType: 'singleChat'},
    {conversationId: 'groupId', conversationType: 'groupChat'}
  ],
  mark: 0,
}

conn.addConversationMark(options).then(() => {
  console.log('addConversationMark success')
})

```

`removeConversationMark`

```javascript
const options = {
  conversations: [
    {conversationId: 'test', conversationType: 'singleChat'},
    {conversationId: 'groupId', conversationType: 'groupChat'}
  ],
  mark: 0,
}

conn.removeConversationMark(options).then(() => {
  console.log('removeConversationMark success')
})

```

`getServerConversationsByFilter`

```javascript
const options = {
  pageSize: 10,
  cursor: '',
  filter: {
    mark: 0
  }
}
conn.getServerConversationsByFilter().then((res) => {
  console.log('getServerConversationsByFilter success', res)
})

```

3. Set whether the message is delivered only when the recipient(s) is/are online.

`deliverOnlineOnly` 

```javascript
// Send a text message.
function sendTextMessage() {
  let option = {
    // Message type.
    type: "txt",
    // Message content.
    msg: "message content",
    // Message recipient which is the peer user ID for one-to-one chat and group ID for group chat. 
    to: "username",
    // Conversation type which is `singleChat` for one-to-one chat and `groupChat` for group chat. The default value is `singleChat`.
    chatType: "singleChat",
    // Whether the message is delivered only when the recipient(s) is/are online.
    // `true`：The message is delivered only when the recipient(s) is/are online. If the recipient is offline, the message is discarded.
    // (Default) `false`：The message is delivered when the recipient(s) is/are online. If the recipient(s) is/are offline, the message will not be delivered to them until they get online.
    deliverOnlineOnly: "true",
  };
  // Create a text message.
  let msg = WebIM.message.create(option);
  // Call the `send` method to send the text message.
    conn.send(msg).then((res)=>{
      console.log("Send message success",res);
    }).catch((e)=>{
      console.log("Send message fail",e);
    });
}
```

4. Pin a message

`pinMessage`

```javascript
const options = {
   // Conversation type which is `groupChat` for group chat and `chatRoom` for chat room chat.
   conversationType: 'groupChat',
   // Conversation ID.
   conversationId: 'conversationId',
   // Message ID.
   messageId: 'messageId'
}

conn.pinMessage(options).then(()=>{
   // Succeeded in pinning the message.
   console.log('Succeeded in pinning the message')
})

```

`unpinMessage`

```javascript
const options = {
   // Conversation type which is `groupChat` for group chat and `chatRoom` for chat room chat.
   conversationType: 'groupChat',
   // Conversation ID.
   conversationId: 'conversationId',
   // Message ID.
   messageId: 'messageId'
}

conn.unpinMessage(options).then(()=>{
   // Succeeded in unpinning the message.
   console.log('Succeeded in unpinning the message.')
})

```

`getServerPinnedMessages`

```javascript
const options = {
   // Conversation ID.
   conversationId: 'conversationId',
   // Conversation type which is `groupChat` for group chat and `chatRoom` for chat room chat.
   conversationType: 'groupChat',
   // The number of pinned messages to retrieve per page. The value range is [1,50] and the default value is `10`
   pageSize: 20,
   // The cursor position that indicates where to start getting data. 
   // Pass in an empty string ('') for the first call of the API and the SDK returns the pinned messages in the descending order of the pinning time.
   cursor: ''
}

conn.getServerPinnedMessages(options).then((res)=>{
   // Succeeded in retrieving the list of pinned messages in a conversation.
   console.log(res)
})
```

`onMessagePinEvent`

```javascript
conn.addEventHandler("eventName", {
  onMessagePinEvent: (event) => {
    console.log(event, 'Message pinning/unpinning event')
    switch (event.operation) {
      // Occurs when a message is pinned.
      case "pin":
        break;
      // Occurs when a message is unpinned.
      case "unpin":
        break;
      default:
        break;
    }
  }
});      
```


5. Add the `LocalCache` module for local conversation data management

This feature involves three parts:

1. Import the Web SDK files as required

The local conversation data management is supported only if the Web SDK files are imported as required. Therefore, you need to add the item g (presenting how to import the SDK files as required). You can determine where to put the item g.

2. To use the local conversation data management, you need to integrate the plug-in. 

3. APIs for local conversation management

For the part 2 and part 3, you can translate the local conversation management page of Easemob IM (https://doc.easemob.com/document/web/conversation_local.html), except that you replace `easemob-websdk` with `agora-chat` in the sample code.

As Agora Chat Web SDK shares the same sample code as Easemob IM, the sample code (a-f) is the same as the Easemob IM doc page and I have translated the Chinese comments into English.

a. `getLocalConversations`

```javascript

miniCore.localCache.getLocalConversations().then((res)=>{
   // Succeeded in getting the local conversation list.
   console.log(res)
})
```

b. `getLocalConversation`

```javascript
const options = {
   // Conversation type which is `singleChat` for one-to-one chat and `groupChat` for group chat.
   conversationType: 'singleChat',
   // Conversation ID.
   conversationId: 'conversationId'
}

miniCore.localCache.getLocalConversation(options).then((res)=>{
   // Succeeded in getting the local conversation.
   console.log(res)
})
```

c. `setLocalConversationCustomField`: Sets a custom field for a local conversation.

```javascript

const options = {
   // Conversation type which is `singleChat` for one-to-one chat and `groupChat` for group chat.
   conversationType: 'singleChat',
   // Conversation ID.
   conversationId: 'conversationId',
   // Custom field of the conversation.
   customField: { custom: 'custom' }
}

miniCore.localCache.setLocalConversationCustomField(options).then(()=>{
   // Succeeded in setting the custom field for the conversation.
})
```

d. `clearConversationUnreadCount`：Resets the number of unread messages of a conversation to zero. 

```javascript

const options = {
   // Conversation type which is `singleChat` for one-to-one chat and `groupChat` for group chat.
   conversationType: 'singleChat',
   // Conversation ID.
   conversationId: 'conversationId'
}

miniCore.localCache.clearConversationUnreadCount(options).then(()=>{
   // Reset the number of unread messages of the conversation to zero.
})
```

e. `removeLocalConversation`: Deletes a local conversation.

```javascript
const options = {
   // Conversation type which is `singleChat` for one-to-one chat and `groupChat` for group chat.
   conversationType: 'singleChat',
   // Conversation ID.
   conversationId: 'conversationId',
   // Whether to delete local messages in the conversation. The default value is `true`.
   isRemoveLocalMessage: true
}

miniCore.localCache.removeLocalConversation(options).then(()=>{
   // Succeeded in deleting the local conversation.
})
```

f. `getServerConversations`: Synchronizes the conversation list from the server to the local database.

```javascript
const options = {
   // The number of conversations to retrieve per page. The value range is [1,50] and the default value is `20`.
   pageSize: 20,
   // The cursor position that indicates where to start getting data. 
   // Pass in an empty string ('') for the first call of the API and the SDK returns the list of all conversations, starting from the most active one.
   cursor: ''
}
miniCore.contact.getServerConversations(options).then((res)=>{
   // Succeeded in retrieving the conversation list from the server and synchronizing it to the local database.
   console.log(res)
})
``` 

g. Import the Web SDK files as required:

If you want to minimize the SDK size, you can import the SDK files as required.

| Function    | File for import       | Usage                     |
| :------------- | :---------------- | :------------------- |
| Contact and message | import \* as contactPlugin from "agora-chat/contact/contact";             | miniCore.usePlugin(contactPlugin, "contact");         |
| Group            | import \* as groupPlugin from "agora-chat/group/group";                   | miniCore.usePlugin(groupPlugin, "group");             |
| Chat room           | import \* as chatroomPlugin from "agora-chat/chatroom/chatroom";          | miniCore.usePlugin(chatroomPlugin, "chatroom");       |
| Thread            | import \* as threadPlugin from "agora-chat/thread/thread";                | miniCore.usePlugin(threadPlugin, "thread");           |
| Translation      | import \* as translationPlugin from "agora-chat/translation/translation"; | miniCore.usePlugin(translationPlugin, "translation"); |
| Presence    | import \* as presencePlugin from "agora-chat/presence/presence";          | miniCore.usePlugin(presencePlugin, "presence");       |

The sample code is as follows:

```javascript
import MiniCore from "agora-chat/miniCore/miniCore";
import * as contactPlugin from "agora-chat/contact/contact";

const miniCore = new MiniCore({
  appKey: "your appKey",
});

// The fixed value "contact" is used here.
miniCore.usePlugin(contactPlugin, "contact");

// Get the contact list.
miniCore.contact.getContacts();

// Add the listener.
miniCore.addEventHandler("handlerId", {
  onTextMessage: (message) => {},
});

// Login
miniCore.open({
  username: "username",
  password: "password",
});
```

6. As the `agoraToken` parameter in the login method `open` is marked deprecated, search for `agoraToken ` in the quick start and replace it with `accessToken` and add the comment " Use accessToken for Chat 1.3.0 and later, but agoraToken for versions earlier than 1.3.0.  ". It's like the following:

     // Use `accessToken` for Chat 1.3.0 and later, but `agoraToken` for earlier versions.
			accessToken: token,


7. Chatroom: member count callback

### Update the chat room member count in real time

If many members join or leave a chat room in a very short time, you can update the chat room member count in real time:

1. When a user joins a chat room, other members in the chat room receive the `memberPresence` event. When a member leaves or is removed from a chat room, other members in the chat room receive the `memberAbsence` event.

2. After the event is received, you can get the current member count of the chat room by checking the value of the `memberCount` parameter in the event.

```javascript
conn.addEventHandler("CHATROOM", {
        onChatroomEvent: (e) => {
          switch (e.operation) {
            case "memberPresence":
              // The current number of members in the chat room.
              console.log(e?.memberCount);
              break;
            case "memberAbsence":
              // The current number of members in the chat room.
              console.log(e?.memberCount);
              break;
            default:
              break;
          }
        }
      });
```

Above is my English translation. 

Following is the Chinese version of the Agora Chat doc for your reference. 

### 实时更新聊天室成员人数

如果聊天室短时间内有成员频繁加入或退出时，实时更新聊天室成员人数的逻辑如下：

1. 聊天室内有成员加入时，其他成员会收到 `onChatroomEvent` 的 `memberPresence` 事件。有成员主动或被动退出时，其他成员会收到 `onChatroomEvent` 的 `memberAbsence` 事件。

2. 收到通知事件后，可以通过事件回调参数获取聊天室当前人数。

```javascript
conn.addEventHandler("CHATROOM", {
        onChatroomEvent: (e) => {
          switch (e.operation) {
            case "memberPresence":
              // 当前聊天室在线人数
              console.log(e?.memberCount);
              break;
            case "memberAbsence":
              // 当前聊天室在线人数
              console.log(e?.memberCount);
              break;
            default:
              break;
          }
        }
      });
```






