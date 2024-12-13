## v1.3.1

v1.3.1 was released on XXXX, 2024.

#### Improvements

- Added the support for pinning messages in one-to-one conversations. Users can call `ChatManager#asyncPinMessage` or `ChatManager#asyncUnPinMessage` to pin or unpin a one-to-one chat message.

- Adapted to the 16 KB page size of Android 15. 

#### Issues fixed

- A crash occurs when `to` is empty during message sending.
- An incorrect nextkey is returned when pulling roaming messages. 
- A crash occurs when `CustomMessageBody#setParams` is called repeatedly in multi-thread scenarios.
- The number of unread messages is inconsistent among multiple devices in certain scenarios. 
- The specified image thumbnail size does not take effect during message sending.


