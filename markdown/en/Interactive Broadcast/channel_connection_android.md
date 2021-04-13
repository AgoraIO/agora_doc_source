---
title: Channel Connection
platform: Android
updatedAt: 2020-09-22 11:38:21
---
In real-time communications, a user can be in various channel connection states. This page shows how the SDK determines the connection state of a user and transitions between the states.

## Connection states

To help you get the connection state of each user in the channel, the Agora Native SDK added the `onConnectionStateChanged` callback in v2.3.0. This callback occurs when the connection state of the local user changes. You can get the connection state and reason for the state change in this callback.

With this callback, the SDK provides the following connection states of the users:

- DISCONNECTED(1): The user is disconnected from the Agora's server.
- CONNECTING(2): The SDK is establishing connections between the user and the server.
- CONNECTED(3): The user is connected to the server.
- RECONNECTING(4): The SDK is trying to reconnect to the the server. This state occurs when the network connection is interrupted, and the SDK automatically tries reconnecting to the server.
- FAILED(5): The connection fails. The SDK stops trying to connect to the server in this state.

The following diagram shows how each connection state is defined:

![](https://web-cdn.agora.io/docs-files/1569298444019)

During communications, you can also call the `getConnectionState` method to get the current connection state, and the reason for the state change in the `onConnectionStateChanged` callback.

## SDK reconnection

When network interruption occurs, the SDK automatically tries reconnecting to the server.

The following diagram shows the callbacks received by UID 1 and UID 2, where UID 1 joins the channel, gets a network exception, loses connection, and rejoins the channel.

![](https://web-cdn.agora.io/docs-files/1569298652204)

Where:

- T0: The SDK receives the `joinChannel` request from UID 1.
- T1: 200 ms after calling the `joinChannel` method, UID 1 joins the channel. During the process, UID 1 also receives the `onConnectionStateChanged(CONNECTION_STATE_CONNECTING, CONNECTION_CHANGED_CONNECTING)` callback. When successfully joining the channel, UID 1 receives the `onConnectionStateChanged(CONNECTION_STATE_CONNECTED, CONNECTION_CHANGED_JOIN_SUCCESS)` and `onJoinChannelSuccess` callbacks.
- T2 : Due to network latency, UID 2 detects UID 1 100 ms after UID 1 joins the channel. UID 2 receives the `onUserJoined` callback.
- T3: The uplink network condition of UID 1 deteriorates. The SDK automatically tries rejoining the channel.
- T4: If UID 1 fails to receive any data from the server in four seconds, it receives the `onConnectionStateChanged(CONNECTION_STATE_RECONNECTING, CONNECTION_CHANGED_INTERRUPTED)` callback; meanwhile the SDK continues to try rejoining the channel.
- T5: If UID 1 fails to receive any data from the server in 15 seconds, UID 1 receives the `onConnectionLost` callback; meanwhile the SDK continue to try rejoining the channel.
- T6: If UID 2 fails to receive any data from UID 1 in 20 seconds, the SDK decides that UID 1 is offline. UID 2 receives the `onUserOffline`.
- T7: If UID 1 fails to rejoin the channel in 20 minutes, the SDK stops trying. UID 1 receives the `onConnectionStateChanged(CONNECTION_STATE_FAILED, CONNECTION_CHANGED_JOIN_FAILED)` callback. UID 1 needs to leave the channel and call the `joinChannel` method to join the channel.


## API reference

- [getConnectionState](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a8635e3c9e26ffe95e7ab9a518af533b9)
- [onConnectionStateChanged](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a31b2974a574ec45e62bb768e17d1f49e)
- [onConnectionLost](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a1abc011459e044a491274415a1230168)

## Reference

For the reconnection mechanism in Agora Native SDKs earlier than v2.3.2, and how connection states change when the process gets killed, see [FAQ: Does Agora have reconnection mechanisms?]((https://docs.agora.io/en/faq/sdk_behavior))