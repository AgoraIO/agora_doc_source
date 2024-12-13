## v1.3.1

#### Improvements

- Added the support for pinning messages in one-to-one conversations. Users can call `ChatManager#pinMessage` or `ChatManager#unpinMessage` to pin or unpin a one-to-one chat message.
- Optimized the connections to the server under weak network conditions for native platforms.

#### Issues fixed

The following issues are fixed on native platforms:
- An attachment message can still be sent successfully despite of failure of sending the attachment under special circumstances.
- An incorrect nextkey is returned when pulling roaming messages. 
- The cache is not updated upon the addition of contacts to block list.
- The official push feature may not work after users log out and log in again.