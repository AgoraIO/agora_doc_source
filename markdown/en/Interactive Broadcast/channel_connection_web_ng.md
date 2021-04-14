---
title: Channel Connection
platform: Web
updatedAt: 2021-02-23 07:34:40
---
<div class="alert note">This article only applies to the Agora Web SDK 4.x. If you use the Web SDK 3.x or earlier versions, see <a href="./channel_connection_web?platform=Web">Channel Connection</a>.</div>

This page shows how the Agora Web SDK determines the connection state of a user and transitions between the states.

## Connection states

To help you get the connection state of each user in the channel, the Web SDK provides the `AgoraRTCClient.connectionState` property and the `Client.on("connection-state-change")` callback. This callback occurs when the connection state of the local user changes.

The connection between the SDK and the Agora server has the following states:

- `"DISCONNECTED"`: The SDK is disconnected from the server. This is the initial state before you call `join`.
  - The SDK also enters this state after you call `leave`.
  - The user is banned by the Agora server or the connection fails.
  
- `"CONNECTING"`: The SDK is connecting to the server. The SDK enters this state when you call `join`.

- `"CONNECTED"`: The SDK is connected to the server and joins a channel. The user can now publish streams or subscribe to streams in the channel.

- `"RECONNECTING"`: The SDK is reconnecting to the server. If the connection is lost because the network is down or switched, the SDK enters this state.

- `"DISCONNECTING"`: The SDK is disconnecting from the server. The SDK enters this state when you call `leave`.

The following diagram shows how each connection state is defined:

![](https://web-cdn.agora.io/docs-files/1614065529668)

## SDK reconnection

When network interruption occurs, the SDK automatically tries reconnecting to the server.

The following diagram shows the callbacks received by UID 1 and UID 2, where UID 1 joins the channel, gets a network exception, loses connection, and rejoins the channel.

![](https://web-cdn.agora.io/docs-files/1614065548863)

Where:

- T0: The SDK receives the `Client.join` request from UID 1.
- T1: UID 1 starts to join the channel. During the process, UID 1 receives the `Client.on("connection-state-change", CONNECTING)` callback. When successfully joining the channel, UID 1 receives the `Client.on("connection-state-change", CONNECTED)` callback.
- T2: Due to network latency, UID 2 detects UID 1 100 ms after UID 1 joins the channel. UID 2 receives the `AgoraRTCClient.on("user-joined")` callback.
- T3: UID 1 calls `Stream.publish` to publish the local stream.
- T4: UID 2 receives the `AgoraRTCClient.on("user-published")` callback, indicating UID 1 has published a stream. UID 2 can call `Stream.subscribe` to subscribe to UID 1's stream.
- T5: The uplink network condition of UID 1 deteriorates. The SDK automatically tries rejoining the channel.
- T6: During the reconnection, the SDK triggers the `Client.on("connection-state-change", RECONNECTING)` callback.
- T7: If the Agora server fails to receive any data from UID 1 in 10 seconds, the SDK decides that UID 1 is not publishing any stream, and UID 2 receives `AgoraRTCClient.on("user-unpublished")`.
- T8: If the Agora server fails to receive any heartbeat packet from UID 1 in 20 seconds, the SDK decides that UID 1 is offline, and UID 2 receives the `AgoraRTCClient.on("user-left")` callback.
- T9: When UID 1 successfully rejoins the channel, the connection state changes to `Client.on("connection-state-change", CONNECTED)`.
- T10: UID2 receives the `AgoraRTCClient.on("user-joined")` callback, indicating that UID 1 is back in the channel.

## API reference

- [AgoraRTCClient.on("connection-state-change")](./API%20Reference/web_ng/interfaces/iagorartcclient.html#event_connection_state_change)
- [AgoraRTCClient.on("user-joined")](./API%20Reference/web_ng/interfaces/iagorartcclient.html#event_user_joined)
- [AgoraRTCClient.on("user-left")](./API%20Reference/web_ng/interfaces/iagorartcclient.html#event_user_left)
- [AgoraRTCClient.on("user-published")](./API%20Reference/web_ng/interfaces/iagorartcclient.html#event_user_published)
- [AgoraRTCClient.on("user-unpublished")](./API%20Reference/web_ng/interfaces/iagorartcclient.html#event_user_unpublished)

## Reference

For how connection states change when the process gets killed, see [FAQ: Does Agora have reconnection mechanisms?](https://docs.agora.io/en/faq/sdk_behavior)