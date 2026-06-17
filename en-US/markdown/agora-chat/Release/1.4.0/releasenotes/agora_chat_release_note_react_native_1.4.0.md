## v1.4.0

v1.4.0 was released on XXXX, 2026.

## New Features

- Supported sending and receiving GIF image messages. The GIF image message is a subtype of the image message and will not be compressed.
- Supported setting, updating, and retrieving group avatars.
- Supported custom group avatars during group creation: Added the `createGroupEx` method and deprecated the original `createGroup` method.
- Enabled users to receive the following information upon joining a chat room:
  - Current chat room member count: Retrieved via the `ChatRoom#getMemberCount` method. This count updates when users join or leave the chat room.
  - Chat room-wide mute status: Retrieved via the `ChatRoom#isAllMemberMuted` method. This status updates upon receiving mute/unmute status change events.
  - Chat room creation timestamp: Retrieved via the newly added `ChatRoom#getCreateTimestamp` method.
  - Whether the current user is on the chat room allowlist: Retrieved via the newly added `ChatRoom#isInWhitelist` method to check if the user is on the chat room allowlist.
  - Mute expiration timestamp of the current user: Retrieved via the `ChatRoom#getMuteExpireTimestamp` method.
- Added the new chat room mute event `ChatRoomEventListener#onMuteListAddedV2` to provide muted user IDs and their mute expiration timestamps via the `muteInfo` parameter, deprecating the old event `ChatRoomEventListener#onMuteListAdded`.
- Supported retrieving roaming messages sent by specific group members.
- Supported retrieving messages sent by specific members within a local group conversation: Added the `senders` parameter to replace the deprecated the `sender` parameter in `getConvMsgsWithKeyword`.
- Supported searching for messages across all local conversations by keyword, returning the list of conversation IDs and their matching message IDs.
- Supported retrieving one or more local messages by message ID.
- Supported batch notifications via group member join/leave events. Previously, the SDK triggered a separate event for each individual member. The new events `ChatGroupEventListener#onMembersJoined` and `ChatGroupEventListener#onMembersExited` are introduced to replace the deprecated `ChatGroupEventListener#onMemberJoined` and `ChatGroupEventListener#onMemberExited` events.
- Supported monitoring the start and end of offline message synchronization from the server: Added the `onOfflineMessageSyncStart` and `onOfflineMessageSyncFinish` events to the server connection status listener `listenerChatConnectEventListener`.
- Added the `ChatManager#getMessageCount` method to retrieve the total number of messages in the local database.

## Improvements

- Changed the unique app identifier from the app key to app ID.
- Supported modifying various message types by adding `ChatManager#modifyMsgBody` to replace the deprecated `ChatManager#modifyMessageBody`:
  - Text and custom messages: Modifying both the message body and extensions (`ext`).
  - File, video, voice, image, location, and combined messages: Modifying extensions (`ext`) only.
  - Command messages: Not supported.
- Allowed group owners, chat room owners, and administrators to recall messages sent by other users.
- Enhanced security by adding access checks for message attachments. For example, if you receive an image message in a group and forward it to others outside the group, they cannot download the image. 
- Adjusted the trigger threshold for the `ChatConnectEventListener#onTokenWillExpire` event; the notification is now triggered when 80% of the token's validity period has elapsed (previously 50%).
- Supported retrieving a group member list that includes each member's role and join time.
- Changed the cursor value in `ChatManager#fetchHistoryMessagesByOptions` from `undefined` to an empty string ("") when the final page of roaming messages is returned.
- Removed APIs that were deprecated prior to native SDK version 1.1.0.
- Optimized specific database operations.
- Added exception clearing mechanisms and null pointer protection to the JNI layer on Android.
- Optimized the reconnection logic to automatically switch reconnection addresses by default.
- Improved the `applicationWillEnterForeground` handling logic by sending a ping message to trigger reconnection on iOS.
- Disabled default constructors for message, conversation, and message body objects to prevent null pointer crashes on iOS.
- Added the device timezone offset to log files to facilitate troubleshooting.
- Removed the reflection-based approach for obtaining absolute file paths from `FileProvider` on Android.
- Upgraded BoringSSL and SQLCipher dependencies to their latest versions to mitigate potential security risks.
- Improved the loading performance of the local conversation list when the latest message is an attachment by eliminating redundant file length checks.
- Added static constructors `ChatOptions#withAppId` and `ChatOptions#withAppKey` to initialize the SDK with an app ID or app key, replacing the deprecated `ChatOptions` constructor.
- Added `ChatGroupManager#fetchGroupInfoWithoutMembersFromServer` to retrieve group information without member information, replacing the deprecated `ChatGroupManager#fetchGroupInfoFromServer`. To retrieve member information, call `ChatGroupManager#fetchMemberInfoListFromServer`.
- Removed the deprecated `ChatMessageEventListener#onMessagesRecalled` event. Use `ChatMessageEventListener#onMessagesRecalledInfo` instead.
- Added `modifyMsgBody` to replace the deprecated `modifyMessageBody`. 
- Updated `getConvMsgsWithKeyword` by adding the `senders` parameter to replace the deprecated the `sender` parameter.
- Added 16KB page alignment support for Android 15+ compatibility.

## Issues Fixed

- Messages in memory were not deleted when their corresponding local conversation was removed.
- The `TYPE` field was empty in the `ChatMessageEventListener#onChatMessageThreadUserRemoved` event.
- A crash occurred on certain device models when retrieving the start and end times of conversation Do-Not-Disturb (DND) settings.
- `ChatMessageEventListener#onMessageContentChanged` failed to return modification details when editing messages other than text and custom messages.
- Group or chat room members incorrectly requested details from the server after a disbandment event was triggered.
- The database was mistakenly rebuilt upon encountering a `SQLITE_BUSY` error.
- The latest message in a conversation retrieved from the server via `ChatManager#fetchConversationsFromServerWithCursor` did not contain translations or message Reactions.
- An exception during logout caused by nesting SDK API calls within SDK events on Android.
- On iOS, completion callbacks for some APIs were not invoked on the main thread, including APIs in `ChatUserInfoManager` and `ChatPresenceManager`, as well as `ChatManager#fetchHistoryMessagesByOptions`, `ChatManager#fetchSupportedLanguages`, `ChatManager#translateMessage`, and `ChatManager#getMessageCount`.
- A crash caused by extreme network conditions.
- Applications using React Native 0.77, 0.78, 0.79, or 0.80 failed to compile when integrating the chat SDK.
- Session types were converted incorrectly on iOS.
- `EMFetchMessageOption` was converted incorrectly on Android.
- No API was available to check whether the current user was in a chat room's mute list.
- Circular dependencies between files.
