## v1.3.0

v1.3.0 was released on XXXX, 2024.

#### New features

- Added the `ChatManager#DeleteAllMessagesAndConversations` method to uni-directionally clear all conversations and messages in them.
- Added the function of searching for messages by search scope in `MessageSearchScope` during keyword-based search. 
  - `MessageSearchScope`: Includes three message search scopes: the message content, message extension information, and both. 
  - `ChatManager#SearchMsgFromDB(string, long, in, string, MessageSearchDirection, MessageSearchScope, ValueCallBack<List<Message>>)`: Searches for messages in all conversations by search scope.
  - `Conversation#LoadMessagesWithScope(string, MessageSearchScope, long, int, string, MessageSearchDirection, ValueCallBack<List<Message>>)`: Searches for messages in a conversation by search scope. 
- Added the function of marking a conversation: 
  - `ChatManager#MarkConversations`: Marks or unmarks a conversation.
  - `ChatManager#GetConversationsFromServerWithCursor`: Gets the conversations from the server by conversation mark.
  - `Conversation#Marks`: Gets all marks of a local conversation.
  - `MultiDevicesOperation#CONVERSATION_MARK`: Occurs on other devices when a conversation is marked or unmarked on one device.
- Added the `Message#Broadcast` property to indicate whether the message is a broadcast message sent via a RESTful API to all chat rooms under an app.
- Added the `Message#DeliverOnlineOnly` field to set whether the message is delivered only when the recipient(s) is/are online. If this field is set to `true`,  the message is discarded when the recipient is offline.
- Added the `GroupManager#FetchMyGroupsCount` method to allow the current user to retrieve the total number of joined groups.
- Added the error code 706 `CHATROOM_OWNER_NOT_ALLOW_LEAVE` that occurs when chat room owner leaves the chat room. If `Options#IsRoomOwnerLeaveAllowed` is set to `false` during SDK initialization, the chat room is not allowed to leave the chat room. In this case, error 706 is reported if the chat room owner calls the `LeaveRoom` method to leave the chat room.
- Added the support for retrieval of historical messages of chat rooms from the server.
-  Added the `Options#UseReplacedMessageContents` property to determine whether the server returns the adjusted text message to the sender if the message content is replaced during text moderation.
- Added the `Message#IsContentReplaced` property to indicate whether the content of the text message is replaced during text moderation.
- Added the function of pinning a message:
  - `ChatManager#PinMessage`: Pins or unpins a message.   
  - `ChatManager#GetPinnedMessagesFromServer`: Gets the list of pinned messages in a conversation from the server. 
  - `Conversation#PinnedMessages`: Gets the list of pinned messages in a local conversation.
  - `Message#PinnedInfo`: Gets the pinning information of the message.
  - `PinnedInfo`: Includes the operator that pins or unpins the message and the operation time.
  - `IChatManagerDelegate#OnMessagePinChanged`: Occurs when the message pinning status changed. When a message is pinned or unpinned in a group or chat room, all members in the group or chat room receive this event.
- Added the `Options#EnableEmptyConversation` property to set whether to include empty conversations in the retrieved list of local conversations. This property is set during SDK initialization.
- Added the `applicant` and `decliner` parameters to the `IGroupManagerDelegate#OnRequestToJoinDeclinedFromGroup` event to respectively indicate the user that applies to join the group and the user that declines the join request. 
- Added the `Options#IncludeSendMessageInMessageListener` property to set whether to return the successfully sent message in the `MessageListener#onMessageReceived` event.
- Added the `SDKClient#LoginWithToken` method for login with the user ID and user token.
- Added the `SDKClient#RenewToken` method for users to renew a token.
- Added the support for returning the modified custom message via the `IChatManagerDelegate#OnMessageContentChanged` event if the message is modified via the RESTful API. 

#### Improvements

- Marked the `SDKClient#LoginWithAgoraToken` and `SDKClient#Login` methods deprecated. Use the `LoginWithToken` method instead.
- Marked the `SDKClient#RenewAgoraToken` method deprecated. Use the `RenewToken` method instead.
- Added the `Facility` library to improve the DNS acquisition logic and support data reporting.
- Switched `ChatManager#SearchMsgFromDB(string, long, int, string, MessageSearchDirection, ValueCallBack<List<Message>>)` from a synchronous method to an asynchronous one.
- Switched the TCP sockets from the blocking mode to the non-blocking mode. This issue is specific to the Unity SDK on Windows.
- Supported the forwarding of single attachment messages by passing in the message body and extension fields, without reuploading the attachment.  
- Reduced the number of times group specifications are retrieved when a large number of group member events are received during certain scenarios. 
- Delivered a more accurate chat room member count by optimizing the way to update the member count when members join or leave the chat room.
- Shortened the time used to call the `ChatManager#MarkAllConversationsAsRead` method by marking all conversations read more efficiently.
- Fine tuned the error message for token-based login for the sake of accuracy.
- Optimized the way the SDK randomly gets server addresses to increase the success rate of requests.
- Adjusted the timeout period for joining or leaving chat rooms.
- Optimized the way the connection is re-established upon a connection failure in certain scenarios.
- Supported for uploading the attachment by fragment when sending an attachment message.
- Optimized the way messages are resent.
- Removed the internal `NetworkOnMainThreadException` exception catching during a network request.
- Optimized the database upgrade logic.
- Increased the maximum allowed size of a log file from 2 MB to 5 MB.
- Added the privacy protocol `PrivacyInfo.xcprivacy`. 

#### Issues fixed

- The database name is encrypted, but contents in the database are still in plain text. This issue is specific to the Unity SDK on Windows. 
- For a modified message, the `from` property is missing from the body of the message pulled from the server by an offline user that gets online. 
- In special scenarios, chat room events are missing when users exit the SDK before login to it.
- The SDK reconnects to the server twice after the network is back to normal.
- An incorrect error message is returned for an unlogged-in user that calls the `LeaveRoom` method.
- The members in a group are double counted in certain scenarios.
- The data reporting module crashes occasionally.
- The SDK is instantiated repeatedly when the `ChatManager#UpdateMessage` method is called frequently for SDK initialization in multi-thread scenarios.
