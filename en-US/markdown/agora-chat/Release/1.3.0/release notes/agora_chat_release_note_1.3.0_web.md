## v1.3.0

v1.3.0 was released on XXXX, 2024.

### New features

- Added the `deleteAllMessagesAndConversations` method to uni-directionally clear all conversations and messages in them on the server. 
- Added the function of marking a conversation: 
  - `addConversationMark`: Marks a conversation.
  - `removeConversationMark`: Unmarks a conversation.
  - `getServerConversationsByFilter`: Gets the conversations from the server by conversation mark.
  - `onMultiDeviceEvent#markConversation/unMarkConversation`: Conversation mark update event in a multi-device login scenario. If a user adds or removes a conversation mark on one device,  this event is received on other devices of the user.
- Added the `broadcast` field to the message object to indicate whether the message is a broadcast message sent via a RESTful API to all chat rooms under an app.
- Added the `deliverOnlineOnly` field during message creation to set whether the message is delivered only when the recipient(s) is/are online. If this field is set to `true`, the message is discarded when the recipient is offline.
- Added the support for retrieval of historical messages of chat rooms from the server.
- Added the `useReplacedMessageContents` parameter to determine whether the server returns the adjusted text message to the sender if the message content is replaced during text moderation.
- Added the function of pinning a message:
  - `pinMessage`: Pins a message. 
  - `unpinMessage`: Unpins a message. 
  - `getServerPinnedMessages`: Gets the list of pinned messages in a conversation from the server. 
  - `onMessagePinEvent`: Occurs when the message pinning status changed. When a message is pinned or unpinned in a group or chat room, all members in the group or chat room receive this event. 
- Added the `LocalCache` module for local conversation data management:
  - `getLocalConversations`: Gets the local conversation list.
  - `getLocalConversation`: Gets a local conversation.
  - `setLocalConversationCustomField`: Sets a custom field for a local conversation.
  - `clearConversationUnreadCount`：Resets the number of unread messages of a conversation to zero.  
  - `removeLocalConversation`: Deletes a local conversation.
  - `getServerConversations`: Synchronizes the conversation list from the server to the local database.
- Added the `applicant` parameter to the `joinPublicGroupDeclined` event to indicate the user that applies to join the group. 
- Added the `message` field to the parameter type `SendMsgResult` in the message sending success callback to return the message object that is successfully sent.
- Added the `onMessage` event which returns the following types of received messages to the recipient in bulk: text, image, video, voice, location, and file messages and combined messages.
- Added the thumbnail for a video message by using the first video frame as the video thumbnail whose URL can be accessed via the `videoMessage.thumb` field. 
- Added the `memberCount` field to the events that occur when a member joins or exits a group or chat room. 
- Added the `getSelfIdsOnOtherPlatform` method to get the list of login IDs of other login devices of the current user so that the user can send messages to a specific device.
- Added the support for returning the modified custom message via the `onModifiedMessage` event if the message is modified via a RESTful API. 
- Added two login token expiration events:
  - `onTokenExpired`: Occurs when the token expires.
  - `onTokenWillExpire`: Occurs half of the token validity period is passed.

### Improvements

- Fine tuned the error message for token-based login for the sake of accuracy.
- Formatted the `customExts` field in the latest custom message of conversations in the conversation list.
- Supported for uploading the attachment by fragment when sending an attachment message.
- Marked the `agoraToken` parameter in the login method `open` deprecated. Use the `accessToken` parameter instead.

### Issues fixed

- Some types in the SDK are incorrect. 