## v1.4.0

v1.4.0 was released on XXXX, 2026.

## New Features

- Supported sending and receiving GIF image messages. The GIF image message is a subtype of the image message and will not be compressed.
- Supported setting, updating, and retrieving group avatars.
- Enabled users to receive the following information upon joining a chat room:
  - Current chat room member count: Retrieved via the `ChatRoom#memberCount` attribute. This count updates when users join or leave the chat room.
  - Chat room-wide mute status: Retrieved via the `ChatRoom#isAllMemberMuted` attribute. This status updates upon receiving mute/unmute status change events.
  - Chat room creation timestamp: Retrieved via the newly added `ChatRoom#createTimestamp` attribute.
  - Whether the current user is on the chat room allowlist: Retrieved via the newly added `ChatRoom#isInWhitelist` attribute to check if the user is on the chat room allowlist.
  - Mute expiration timestamp of the current user: Retrieved via the `ChatRoom#muteExpireTimestamp` attribute.
- Added the new chat room mute event `ChatRoomEventHandler#onMuteListAddedFromChatRoom(roomId, mutes, expireTime)` to provide muted user IDs and their mute expiration timestamps via the `Map<String, int>` parameter, deprecating the old event `ChatRoomEventHandler#onMuteListAddedFromChatRoom(roomId, mutes)`.
- Supported retrieving roaming messages sent by specific group members.
- Supported retrieving messages sent by specific members within a local group conversation.
- Supported searching for messages across all local conversations by keyword, returning the list of conversation IDs and their matching message IDs.
- Supported retrieving one or more local messages by message ID.
- Supported batch notifications via group member join/leave events. Previously, the SDK triggered a separate event for each individual member. The new events `ChatGroupEventHandler#onMembersJoinedFromGroup` and `ChatGroupEventHandler#onMembersExitedFromGroup` are introduced to replace the deprecated `ChatGroupEventHandler#onMemberJoinedFromGroup` and `ChatGroupEventHandler#onMemberExitedFromGroup` events.

## Improvements

- Changed the unique app identifier from the app key to app ID.
- Supported modifying various message types via the message modification API `ChatManager#modifyMessage`:
  - Text and custom messages: Modifying both the message body and extensions (`attributes`).
  - File, video, voice, image, location, and combined messages: Modifying extensions (`attributes`) only.
  - Command messages: Not supported.
- Allowed group owners, chat room owners, and administrators to recall messages sent by other users.
- Adjusted the trigger threshold for the `ConnectionEventHandler#onTokenWillExpire` event; the notification is now triggered when 80% of the token's validity period has elapsed (previously 50%).
- Supported retrieving a group member list that includes each member's role and join time.
- Optimized specific database operations.
- Optimized the reconnection logic to automatically switch reconnection addresses by default.
- Added the device timezone offset to log files to facilitate troubleshooting.
- Improved the loading performance of the local conversation list when the latest message is an attachment by eliminating redundant file length checks.

## Issues Fixed

- Messages in memory were not deleted when their corresponding local conversation was removed.
- The `TYPE` field was empty in the `ChatThreadEventHandler#onUserKickOutOfChatThread` event.
- `ChatEventHandler#onMessageContentChanged` failed to return modification details when editing messages other than text and custom messages.
- After a group or chat room was disbanded, the SDK would still fetch group or chat room details from the server after members received the disbandment event.
- The database was mistakenly rebuilt upon encountering a `SQLITE_BUSY` error.
- The latest message in a conversation retrieved from the server via `ChatManager#fetchConversationsByOptions` did not contain translations or message Reactions.
- A crash caused by extreme network conditions.
