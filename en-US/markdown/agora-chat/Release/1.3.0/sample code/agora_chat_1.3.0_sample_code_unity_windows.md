1. Clear all conversations and messages in them

https://doc.easemob.com/document/unity/message_delete.html#清空聊天记录

2. Search for messages by search scope

a. Search for messages in all conversations by search scope

https://doc.easemob.com/document/unity/message_search.html#根据搜索范围搜索所有会话中的消息

b. Search for messages in a conversation by search scope

https://doc.easemob.com/document/unity/message_search.html#根据搜索范围搜索当前会话中的消息

3. Mark a conversation

https://doc.easemob.com/document/unity/conversation_mark.html

4. Set whether the message is delivered only when the recipient(s) is/are online.  

https://doc.easemob.com/document/unity/message_deliver_only_online.html

5. Allow the current user to retrieve the total number of joined groups

https://doc.easemob.com/document/unity/group_manage.html#查询当前用户已加入的群组数量

6. `IGroupManagerDelegate#OnRequestToJoinDeclinedFromGroup`

Search for `OnRequestToJoinDeclinedFromGroup` on the following page:

https://doc.easemob.com/document/unity/group_manage.html#监听群组事件    

7. Pin a message

https://doc.easemob.com/document/unity/message_pin.html

8. Forward a single message    

https://doc.easemob.com/document/unity/message_forward.html


9. Chatroom: member count callback

### Update the chat room member count in real time

https://doc.easemob.com/document/unity/room_manage.html#实时更新聊天室成员人数

10. Modifications to quick start of Unity and Windows platforms

a. Add the following comments above `LoginWithAgoraToken` in the sample code in the "5. Log in to Chat" section for Unity (in "4. Log in to Agora Chat" section for Windows) under the "Send and receive messages" section.

// Use LoginWithToken to replace LoginWithAgoraToken for the SDK of v1.3.0 or later

b. Add the following callbacks in the sample code of "In the NewBehaviourScript class, add the following callbacks before setupChatSDK:" in "4. Handle and respond to Chat events" section for Unity (in "8. Handle Chat events" section for Windows) under the "Send and receive messages" section.

        public void OnMessageContentChanged(Message msg, string operatorId, long operationTime)
        {
        }
        public void OnMessagePinChanged(string messageId, string conversationId, bool isPinned, string operatorId, long operationTime)
        {
        }









