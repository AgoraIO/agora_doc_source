## v1.3.0

v1.3.0 was released on XXXX, 2024.

#### New features

- Added the privacy protocol `PrivacyInfo.xcprivacy`.
- Added the `AgoraChatManager#deleteAllMessagesAndConversations:completion:` method to uni-directionally clear all conversations and messages in them. Meanwhile, you can choose whether to clear the chat history on the server.
- Added the function of searching for messages by search scope in `AgoraChatMessageSearchScope` during keyword-based search:
  - `AgoraChatMessageSearchScope`: Includes three message search scopes: the message content, message extension information, and both. 
  - `AgoraChatManager#loadMessagesWithKeyword:timestamp:count:fromUser:searchDirection:scope:completion:`: Searches for messages in all conversations by search scope.
  - `AgoraChatConversation#loadMessagesWithKeyword:timestamp:count:fromUser:searchDirection:scope:completion:`: Searches for messages in a conversation by search scope.
- Added the function of marking a conversation: 
  - `AgoraChatManager#addConversationMark:completion`: Marks a conversation.
  - `AgoraChatManager#removeConversationMark:completion`: Unmarks a conversation.
  - `AgoraChatManager#getConversationsFromServerWithCursor:filter:completion`: Gets the list of conversations from the server by conversation mark.
  - `AgoraChatConversation#marks`: Gets all marks of a local conversation.
  - `multiDevicesConversationEvent#AgoraChatMultiDevicesEventConversationUpdateMark`: Conversation mark update event in a multi-device login scenario. If a user adds or removes a conversation mark on one device, this event is received on other devices of the user.
- Added the `AgoraChatMessage#broadcast` property to indicate whether the message is a broadcast message sent via a RESTful API to all chat rooms under an app.
- Added the `AgoraChatMessage#deliverOnlineOnly` property to determine whether the message is delivered only when the recipient(s) is/are online. If this property is set to `YES`, the message is discarded when the recipient is offline.
- Added the `AgoraChatGroupManager#getJoinedGroupsCountFromServerWithCompletion` method to allow the current user to retrieve the total number of joined groups.
- Added the error code 706 `AgoraChatErrorChatroomOwnerNotAllowLeave` that occurs when chat room owner leaves the chat room. If `AgoraChatOptions#canChatroomOwnerLeave` is set to `NO` during SDK initialization, the chat room is not allowed to leave the chat room. In this case, error 706 is reported if the chat room owner calls the `leaveChatroom` method to leave the chat room.
- Added the support for retrieval of historical messages of chat rooms from the server.
- Added the `AgoraChatOptions#useReplacedMessageContents` method to determine whether the server returns the adjusted text message to the sender if the message content is replaced during text moderation.
- Added the function of pinning a message:
  - `AgoraChatManager#pinMessage:completion:`: Pins a message.
  - `AgoraChatManager#unpinMessage:completion:`: Unpins a message. 
  - `AgoraChatManager#getPinnedMessagesFromServer:completion:`: Gets the list of pinned messages in a conversation from the server. 
  - `AgoraChatConversation#pinnedMessages`: Gets the list of pinned messages in a local conversation.
  - `AgoraChatMessagePinInfo`: Includes the operator that pins or unpins the message and the operation time.
  - `AgoraChatMessage#pinnedInfo`: Includes the message pinning information.
  - `AgoraChatMessageListener#onMessagePinChanged`: Occurs when the message pinning status changed. When a message is pinned or unpinned in a group or chat room, all members in the group or chat room receive this event. 
- Added the `AgoraChatManager#markAllConversationsAsRead` method to mark all conversations as read. Upon a call of this method, the number of unread messages of all conversations is reset to zero.  
- Added the `AgoraChatOptions#includeSendMessageInMessageListener` property to set whether to return the successfully sent message in the `messagesDidReceive` event.
- Added the `AgoraChatOptions#loadEmptyConversations` property to set whether to include empty conversations in the retrieved list of local conversations. 
- Added the `applicant` and `decliner` parameters to the  `AgoraChatGroupManagerDelegate#joinGroupRequestDidDecline:reason:decliner:applicant:` event to respectively indicate the user that applies to join the group and the user that declines the join request. 
- Added the support for returning the modified custom message via the  `AgoraChatChatManagerDelegate#onMessageContentChanged:operatorId:operationTime` event if the message is modified via a RESTful API. 

#### Improvements

- Supported the forwarding of single attachment messages by passing in the message body, without reuploading the attachment.
- Reduced the number of times group specifications are retrieved when a large number of group member events are received during certain scenarios. 
- Delivered a more accurate chat room member count by optimizing the way to update the member count when members join or leave the chat room.
- Fine tuned the error message for token-based login for the sake of accuracy.
- Optimized the way the SDK randomly gets server addresses to increase the success rate of requests.
- Adjusted the timeout period for joining or leaving chat rooms.
- Allowed users to get the general mute status of groups (the value of `AgoraChatGroup#isMuteAllMembers`) locally upon login by storing the status in the local database. 
- Increased the maximum allowed size of a log file from 2 MB to 5 MB.
- Supported for uploading the attachment by fragment when sending an attachment message.
- Marked the `AgoraChatClient#loginWithUsername:agoraToken:` and `AgoraChatClient#loginWithUsername:password:` methods deprecated. Use the `AgoraChatClient#loginWithUsername:token` method instead.
- Optimized the way messages are resent.
- Optimized the database upgrade logic.

#### Issues fixed

- The members in a group are double counted in certain scenarios.
- A SQL statement error is reported when a single quotation mark `'` is included in a message search keyword.
- The SDK reconnects to the server twice after the network is back to normal.
- For a modified message, the `from` property is missing from the body of the message pulled from the server by an offline user that gets online. 


