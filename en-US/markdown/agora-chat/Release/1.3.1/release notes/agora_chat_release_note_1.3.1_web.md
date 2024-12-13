## v1.3.1

v1.3.1 was released on XXXX, 2024.

#### Improvements

- Added the support for pinning messages in one-to-one conversations. Users can call `pinMessage` or `unpinMessage` to pin or unpin a one-to-one chat message.
- Added the `ConnectionParameters#isFixedDeviceId` parameter (`true` by default) to specify whether to use a fixed device ID. Specifically, the SDK generates a device ID for a browser and saves it to the local storage. Then in the browser, all SDK instances use the same device. The setting of this parameter affects the strategy of forced logout in multi-device login scenarios. For details, see [Log in from multiple devices](https://docs.agora.io/en/agora-chat/develop/multiple-device-login?platform=web).
In previous versions, a random device ID is used for connections of each SDK instance. In this case, each SDK instance uses a different device for connections.
- Added the callback for DNS request failures.
- Added the reason for requesting to join the group to the `requestToJoin` event that is received by the group owner and administrators that approved the join request.





