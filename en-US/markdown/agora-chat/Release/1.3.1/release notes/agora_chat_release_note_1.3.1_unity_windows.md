## v1.3.1

v1.3.1 was released on XXXX, 2024.

#### Improvements

- Added the support for pinning or unpinning messages in one-to-one conversations. You can call `ChatManager#PinMessage` to pin or unpin a one-to-one chat message. Also, you can call `ChatManager#GetPinnedMessagesFromServer` to get the pinned messages from a one-to-one conversation from the server.

- Provided new users of a chat room with more chat room information. When users join the chat room, they can obtain the following information about the chat room via the `Room` Object:
  - `RoomId`
  - `MemberCount`
  - `CreateTimeStamp`
  - `IsAllMemberMuted`
  - `IsInAllowList`
  - `MuteUntilTimeStamp`

  This feature is available only for Windows, Unity Mac and Unity Windows platforms.

- Delivered a more accurate chat room member count by optimizing the way to update the member count when members join or leave the chat room.

- Added the "info" parameter to OnLoggedOtherDevice to indicate device extension information. In this case, if the latest login device forces an existing login device to get offline due to too many login devices, the offline device will learn which device makes it go offline, from the logout callback that contains the device extension information. 