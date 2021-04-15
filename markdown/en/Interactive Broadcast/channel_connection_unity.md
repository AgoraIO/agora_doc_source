---
title: Channel Connection
platform: Unity
updatedAt: 2020-09-22 11:39:35
---
In real-time communications, a user can be in various channel connection states. This page shows how the SDK determines the connection state of a user and transitions between the states.

## Connection states

To help you get the connection state of each user in the channel, the Agora Unity SDK added the `OnConnectionStateChangedHandler` callback in v2.3.2. This callback occurs when the connection state of the local user changes. You can get the connection state and reason for the state change in this callback.

With this callback, the SDK provides the following connection states of the users:

- `DISCONNECTED(1)`: The user is disconnected from the Agora's server.
- `CONNECTING(2)`: The SDK is establishing connections between the user and the server.
- `CONNECTED(3)`: The user is connected to the server.
- `RECONNECTING(4)`: The SDK is trying to reconnect to the the server. This state occurs when the network connection is interrupted, and the SDK automatically tries reconnecting to the server.
- `FAILED(5)`: The connection fails. The SDK stops trying to connect to the server in this state.

The following diagram shows how each connection state is defined:

![](https://web-cdn.agora.io/docs-files/1584432603538)

During communications, you can also call the `GetConnectionState` method to get the current connection state, and the reason for the state change in the `OnJoinChannelSuccessHandler` callback.

## SDK reconnection

When network interruption occurs, the SDK automatically tries reconnecting to the server.

The following diagram shows the callbacks received by UID 1 and UID 2, where UID 1 joins the channel, gets a network exception, loses connection, and rejoins the channel.

![](https://web-cdn.agora.io/docs-files/1584432660084)

Where:

- T0: The SDK receives the `JoinChannelByKey` request from UID 1.
- T1: 200 ms after calling the `JoinChannelByKey` method, UID 1 joins the channel. During the process, UID 1 also receives the `OnConnectionStateChangedHandler(CONNECTION_STATE_CONNECTING, CONNECTION_CHANGED_CONNECTING)` callback. When successfully joining the channel, UID 1 receives the `OnConnectionStateChangedHandler(CONNECTION_STATE_CONNECTED, CONNECTION_CHANGED_JOIN_SUCCESS)` and `OnJoinChannelSuccessHandler` callbacks.
- T2 : Due to network latency, UID 2 detects UID 1 100 ms after UID 1 joins the channel. UID 2 receives the `OnUserJoinedHandler` callback.
- T3: The uplink network condition of UID 1 deteriorates. The SDK automatically tries rejoining the channel.
- T4: If UID 1 fails to receive any data from the server in four seconds, it receives the `OnConnectionStateChangedHandler(CONNECTION_STATE_RECONNECTING, CONNECTION_CHANGED_INTERRUPTED)` callback; meanwhile the SDK continues to try rejoining the channel.
- T5: If UID 1 fails to receive any data from the server in 15 seconds, UID 1 receives the `OnConnectionLostHandler` callback; meanwhile the SDK continue to try rejoining the channel.
- T6: If UID 2 fails to receive any data from UID 1 in 20 seconds, the SDK decides that UID 1 is offline. UID 2 receives the `OnUserOfflineHandler`.
- T7: If UID 1 fails to rejoin the channel in 20 minutes, the SDK stops trying. UID 1 receives the `OnConnectionStateChangedHandler(CONNECTION_STATE_FAILED, CONNECTION_CHANGED_JOIN_FAILED)` callback. UID 1 needs to leave the channel and call the `JoinChannelByKey` method to join the channel.


## API reference

- [GetConnectionState](./API%20Reference/unity/classagora__gaming__rtc_1_1_i_rtc_engine.html#ab2fbccbec5f20a1e42db7b16ef904c21)
- [OnConnectionStateChangedHandler](./API%20Reference/unity/namespaceagora__gaming__rtc.html#adae7694cb602375ccbc14be3062a230c)
- [OnConnectionLostHandler](./API%20Reference/unity/namespaceagora__gaming__rtc.html#a1f17f5429ec17c1c7d6bcaa298076ad7)