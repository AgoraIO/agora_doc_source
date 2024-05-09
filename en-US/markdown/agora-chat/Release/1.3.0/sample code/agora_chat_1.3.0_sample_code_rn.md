1. Clear all conversations and messages in them

https://doc.easemob.com/document/react-native/message_delete.html#清空聊天记录

2. Search for messages by search scope

a. Search for messages in all conversations by search scope

https://doc.easemob.com/document/react-native/message_search.html#根据搜索范围搜索所有会话中的消息

b. Search for messages in a conversation by search scope

https://doc.easemob.com/document/react-native/message_search.html#根据搜索范围搜索当前会话中的消息


3. Mark a conversation

https://doc.easemob.com/document/react-native/conversation_mark.html

4. Set whether the message is delivered only when the recipient(s) is/are online.  

https://doc.easemob.com/document/react-native/message_deliver_only_online.html

5. Allow the current user to retrieve the total number of joined groups

https://doc.easemob.com/document/react-native/group_manage.html#查询当前用户已加入的群组数量

6. Added the support for retrieval of historical messages of chat rooms from the server



7. `ChatGroupEventListener#onRequestToJoinDeclined`

Search for `onRequestToJoinDeclined` on the following page:

https://doc.easemob.com/document/react-native/group_manage.html#监听群组事件   

8. Pin a message

https://doc.easemob.com/document/react-native/message_pin.html

9. Forward a single message    

https://doc.easemob.com/document/react-native/message_forward.html


10. Quick start modification

Search for `loginWithAgoraToken(username, chatToken)` in the quick start and replace it with `login(username, chatToken, false)`, as the former method is deprecated.


11. Chatroom: member count callback

### Update the chat room member count in real time

https://doc.easemob.com/document/react-native/room_manage.html#实时更新聊天室成员人数

12. Replace `searchMsgFromDB` with `getMsgsWithMsgType` on the page of the URL: https://docs.agora.io/en/agora-chat/client-api/messages/manage-messages?platform=react-native#search-for-messages-using-keywords

See the following:

### Retrieves messages of a certain type in a local conversation

You can call the `getMsgsWithMsgType` method to retrieve messages of a certain type in a conversation in the local database. You can retrieve a maximum of 400 messages each time. If no message is retrieved, the SDK returns an empty list. 

:::tip
To use this function, you need to upgrade the SDK to 1.3.0 or later.
:::

```typescript
// convId: The conversation ID.
// convType: The conversation type, which is `PeerChat` for one-to-one chat, `GroupChat` for group chat, and `RoomChat` for chat room chat.
// msgType: The message type.
// direction: The message search direction
// `ChatSearchDirection.UP`: Messages are retrieved in the descending order of the Unix timestamp included in them.
// `ChatSearchDirection.DOWN`: Messages are retrieved in the ascending order of the Unix timestamp included in them.
// timestamp: The starting Unix timestamp in the message for query. The unit is millisecond. After this parameter is set, the SDK retrieves messages, starting from the specified one, according to the message search direction.
// If you set this parameter as a negative value, the SDK retrieves messages, starting from the current time, in the descending order of the timestamp included in them.
// count: The maximum number of messages to retrieve each time. The value range is [1,400].
// sender：The message sender, which is the user ID of the peer user for one-to-one chat or group ID for group chat. 
// isChatThread: Whether the conversation is a thread conversation.
ChatClient.getInstance()
  .getMsgsWithMsgType({
    convId,
    convType,
    msgType,
    direction,
    timestamp,
    count,
    sender,
    isChatThread,
  })
  .then((messages) => {
    console.log("get message success");
  })
  .catch((reason) => {
    console.log("get message fail.", reason);
  });
```













