---
title: Channel Connection
platform: Web
updatedAt: 2021-02-23 07:35:55
---
In real-time communications, a user can be in various channel connection states. This page shows how the SDK determines the connection state of a user and transitions between the states.

## Connection states

To help you get the connection state of each user in the channel, the Agora Web SDK added the `Client.on("connection-state-change")` callback in v2.5.1. This callback occurs when the connection state of the local user changes. 

With this callback, the SDK provides the following connection states of the users:

- DISCONNECTED(1): The user is disconnected from the Agora's server.
- CONNECTING(2): The SDK is establishing connections between the user and the server.
- CONNECTED(3): The user is connected to the server.
- DISCONNECTING(4): The SDK is trying to disconnect from the the server. This state occurs calling `Client.leave`

The following diagram shows how each connection state is defined:

![](https://web-cdn.agora.io/docs-files/1569309023941)

During communications, you can also call the `getConnectionState` method to get the current connection state.

## SDK reconnection

When network interruption occurs, the SDK automatically tries reconnecting to the server.

The following diagram shows the callbacks received by UID 1 and UID 2, where UID 1 joins the channel, gets a network exception, loses connection, and rejoins the channel.

![](https://web-cdn.agora.io/docs-files/1604479403744)

Where:

- T0: The SDK receives the `Client.join` request from UID 1.
- T1: UID 1 joins the channel. During the process, UID 1 also receives the `Client.on("connection-state-change", CONNECTING)` callback. When successfully joining the channel, UID 1 receives the `Client.on("connection-state-change", CONNECTED)` and `Client.on("connected")` callbacks.
- T2 : Due to network latency, UID 2 detects UID 1 100 ms after UID 1 joins the channel. UID 2 receives the `Client.on("peer-online")` callback.
- T3: UID 1 calls the `Stream.publish` method to publish the local stream.
- T4: UID 2 receives the `Client.on("stream-added")`, indicating the UID 1 has published a stream. UID 2 can call the `Stream.subscribe` method to subscribe to UID 1's stream.
- T5: The uplink network condition of UID 1 deteriorates. The SDK automatically tries rejoining the channel.
- T6: If UID 2 fails to receive any data from UID 1 in 10 seconds, the SDK decides that UID 1 is not publishing any stream, and UID 2 receives `Client.on("stream-removed")`. Meanwhile the SDK continues to try rejoining the channel.
- T7: During the reconnection, the connection state changes to `Client.on("connection-state-change", CONNECTING)`.
- T8: If the server fails to receive any data from UID 1 in 10 seconds, the SDK decides that UID 1 is offline, and UID 2 receives the `Client.on("peer-leave")` callback. Meanwhile the SDK continues to try rejoining the channel.
- T9: When UID 1 successfully rejoins the channel, the connection state changes to `Client.on("connection-state-change", CONNECTED)`.
- T10: UID2 receives the `Client.on("peer-online")` callback of UID 1, indicating that UID 1 is back in the channel.


## API reference

- [Client.getConnectionState](./API%20Reference/web/interfaces/agorartc.client.html#getconnectionstate)
- [Client.on](./API%20Reference/web/interfaces/agorartc.client.html#on)("connection-state-change")

## Reference

For how connection states change when the process gets killed, see [FAQ: Does Agora have reconnection mechanisms?](https://docs.agora.io/en/faq/sdk_behavior).