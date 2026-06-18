## v1.4.0

v1.4.0 was released on XXXX, 2026.

## New Features

- Supported sending and receiving GIF image messages. The GIF image message is a subtype of the image message and will not be compressed.
- Supported setting, updating, and retrieving group avatars.
- Enabled users to receive the following information upon joining a chat room: Added the `info` field to the `joinChatRoom` response:
  - Chat room creation time: `createtimestamp`.
  - Whether all-member mute is enabled: `isallmembersmuted`.
  - Whether the user is in the allowlist: `isinallowlist`.
  - Current chat room member count: `membercount`.
  - User mute expiration time: `muteexpiretimestamp`.
- Included the mute expiration time in the chat room mute event: Added the `muteTimestamp` parameter to the `muteMember` event.
- Supported retrieving roaming messages sent by a specific group member.
- Supported batch notifications via group member join/leave events. Previously, the SDK triggered a separate event for each individual member: Added new events `memberspresence` and `membersabsence` (the original `memberpresence` and `memberabsence` remain valid).
- Allowed members in the chat room to receive the new announcement after it is modified: Added the `announcement` field to the chat room announcement update event `updateannouncement`.
- Included the user ID of the muted member in the group/chat room mute event: Added the `userId` parameter to the `muteMember` event.
- Allowed setting extension information when creating a group: Deprecated `createGroup` and use `createGroupVNext` instead.

## Improvements

- Supported modifying various message types via the message modification API `modifyMessage`:
  - Text and custom messages: Modifying both the message body and extensions (`ext`).
  - File, video, voice, image, location, and combined messages: Modifying extensions (`ext`) only.
  - Command messages: Not supported.
- Allowed group owners, chat room owners, and administrators to recall messages sent by other users.
- Adjusted the trigger threshold for the `onTokenWillExpire` event; the notification is now triggered when 80% of the token's validity period has elapsed (previously 50%).
- Supported retrieving a group/chat room member list that includes each member's user ID, role, and join time.
  - Deprecated `listGroupMembers`; use `getGroupMembers` instead.
  - Deprecated `listChatRoomMembers`; use `getChatRoomMembers` instead.
- Optimized the reconnection logic to automatically switch reconnection addresses by default.
- Adjusted the execution order of the login method's callback `open().then` and the connection success event `onConnected`: Calling `open()` will now trigger the `onConnected` or `onDisconnected` event before resolving `open().then` or rejecting `open().catch`. This ensures that subsequent actions only occur after the connection is fully established, resolving the previous issue where messages could only be sent after `onConnected` was triggered following the login callback. Additionally, login errors such as authentication failures will now be thrown directly in `open().catch`.
- Added `parseDownloadResponse` and `download` methods to the SDK's `message` object: These methods are now available in both the `utils` object and the `message` object.

## Issues Fixed

- The `conversationId` parameter value was incorrect in the message pinning event `onMessagePinEvent`.
- The message retrieval occasionally failed.
