## v1.3.1

v1.3.1 was released on XXXX, 2024.

#### Improvements

- Added the support for pinning messages in one-to-one conversations. Users can call `AgoraChatManager#pinMessage` or `AgoraChatManager#unpinMessage` to pin or unpin a one-to-one chat message.

#### Issues fixed

- A crash occurs when `conversationId` is empty during message sending.
- An incorrect nextkey is returned when pulling roaming messages. 
- The number of unread messages is inconsistent among multiple devices in certain scenarios. 
- The specified image thumbnail size does not take effect during message sending.


