## v1.3.0 

v1.3.0 was released on XXXX, 2024.

#### New features

- Added the `ChatManager#deleteAllMessageAndConversation` method to uni-directionally clear all conversations and messages in them. Meanwhile, you can choose whether to clear the chat history on the server.
- Added the function of searching for messages by search scope in `MessageSearchScope` during keyword-based search.
  - `MessageSearchScope`: Includes three message search scopes: the message content, message extension information, and both. 
  - `ChatManager#loadMessagesWithKeyword`: Searches for messages in all conversations by search scope.
  - `conversation#loadMessagesWithKeyword`: Searches for messages in a conversation by search scope.
- Added the function of marking a conversation: 
  - `ConversationFetchOptions`: Includes options for filtering conversations retrieved from the server. You can only retrieve pinned conversations or marked conversations by setting the options.
  - `ChatManager#addRemoteAndLocalConversationsMark`: Marks a conversation.
  - `ChatManager#deleteRemoteAndLocalConversationsMark`: Unmarks a conversation.
  - `ChatManager#fetchConversationsByOptions`: Gets conversations from the server by setting `ConversationFetchOptions`.
  - `Conversation#marks`: Gets all marks of a local conversation.
  - `ChatMultiDevicesEvent#CONVERSATION_UPDATE_MARK`: Conversation mark update event in a multi-device login scenario. If a user adds or removes a conversation mark on one device,  this event is received on other devices of the user.
- Added the `ChatMessage#isBroadcast` property to indicate whether the message is a broadcast message sent via a RESTful API to all chat rooms under an app.
- Added the `ChatMessage#deliverOnlineOnly` property to set whether the message is delivered only when the recipient(s) is/are online. If this property is set to `true`, the message is discarded when the recipient is offline.
- Added the `GroupManager#fetchJoinedGroupCount` method to allow the current user to retrieve the total number of joined groups.
- Added the error code 706 `CHATROOM_OWNER_NOT_ALLOW_LEAVE` that occurs when the chat room owner leaves the chat room. If `ChatOptions#isChatRoomOwnerLeaveAllowed` is set to `false` during SDK initialization, the chat room is not allowed to leave the chat room. In this case, error 706 is reported if the chat room owner calls the `leaveChatRoom` method to leave the chat room.
- Added the support for retrieval of historical messages of chat rooms from the server.
- Added the `ChatOptions#useReplacedMessageContents` property to determine whether the server returns the adjusted text message to the sender if the message content is replaced during text moderation.
- Added the function of pinning a message:
  - `ChatManager#pinMessage`: Pins a message.   
  - `ChatManager#unpinMessage`: Unpins a message.  
  - `ChatManager#fetchPinnedMessages`: Gets the list of pinned messages in a conversation from the server. 
  - `Conversation#loadPinnedMessages`: Gets the list of pinned messages in a local conversation.
  - `MessagePinInfo`: Includes the operator that pins or unpins the message and the operation time.
  - `ChatMessage#pinInfo`: Includes the message pinning information.
  - `ChatEventHandler#onMessagePinChanged`: Occurs when the message pinning status changed. When a message is pinned or unpinned in a group or chat room, all members in the group or chat room receive this event. 
- Added the `ChatOptions#enableEmptyConversation` property to set whether to include empty conversations in the retrieved list of local conversations. This property is set during SDK initialization.
- Added the `applicant` and `decliner` parameters to the `ChatGroupEventHandler#onRequestToJoinDeclinedFromGroup` event to respectively indicate the user that applies to join the group and the user that declines the join request. 
- Added the `ChatOptions#messagesReceiveCallbackIncludeSend` property to set whether to return the successfully sent message in the `ChatEventHandler#onMessagesReceived` event.
- Added the support for returning the modified custom message via the `ChatEventHandler#onMessageContentChanged` event if the message is modified via the RESTful API. 

#### Improvements

- Marked `ChatManager#fetchConversation` and `ChatManager#fetchPinnedConversations` deprecated. Use `ChatManager#fetchConversationsByOptions` instead.
- Supported the forwarding of single attachment messages by passing in the message body and extension fields, without reuploading the attachment.  
- Reduced the number of times group specifications are retrieved when a large number of group member events are received during certain scenarios. 
- Delivered a more accurate chat room member count by optimizing the way to update the member count when members join or leave the chat room.
- Shortened the time used to call the `ChatManager#markAllConversationsAsRead` method by marking all conversations read more efficiently.
- Optimized the way the SDK randomly gets server addresses to increase the success rate of requests.
- Adjusted the timeout period for joining or leaving chat rooms.
- Optimized the way the connection is re-established upon a connection failure in certain scenarios.
- Supported for uploading the attachment by fragment when sending an attachment message.
- Marked the `ChatClient#loginWithAgoraToken` method deprecated. Use the `ChatClient#loginWithToken` method instead.
- Fine tuned the error message for token-based login for the sake of accuracy.
- Optimized the way messages are resent.
- Removed the internal `NetworkOnMainThreadException` exception catching during a network request.
- Optimized the database upgrade logic.
- Increased the maximum allowed size of a log file from 2 MB to 5 MB.
- Added the iOS privacy protocol `PrivacyInfo.xcprivacy`.

#### Issues fixed

- For a modified message, the `from` property is missing from the body of the message pulled from the server by an offline user that gets online. 
- In special scenarios, chat room events are missing when users exit the SDK before login to it.
- The SDK reconnects to the server twice after the network is back to normal.
- An incorrect error message is returned for an unlogged-in user that calls the `leaveChatRoom` method.
- The members in a group are double counted in certain scenarios.
- The data reporting module crashes occasionally.
- The SDK is instantiated repeatedly when the `ChatManager#updateMessage` method is called frequently for SDK initialization in multi-thread scenarios.
