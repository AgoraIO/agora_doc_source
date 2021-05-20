---
title: Channel Connection
platform: iOS
updatedAt: 2020-09-22 11:38:40
---
In real-time communications, a user can be in various channel connection states. This page shows how the SDK determines the connection state of a user and transitions between the states.

## Connection states

To help you get the connection state of each user in the channel, the Agora Native SDK added the `connectionChangedToState` callback in v2.3.0. This callback occurs when the connection state of the local user changes. You can get the connection state and reason for the state change in this callback.

With this callback, the SDK provides the following connection states of the users:

- DISCONNECTED(1): The user is disconnected from the Agora's server.
- CONNECTING(2): The SDK is establishing connections between the user and the server.
- CONNECTED(3): The user is connected to the server.
- RECONNECTING(4): The SDK is trying to reconnect to the the server. This state occurs when the network connection is interrupted, and the SDK automatically tries reconnecting to the server.
- FAILED(5): The connection fails. The SDK stops trying to connect to the server in this state.

The following diagram shows how each connection state is defined:

![](https://web-cdn.agora.io/docs-files/1569306273340)

During communications, you can also call the `getConnectionState` method to get the current connection state, and the reason for the state change in the `connectionChangedToState` callback.

## SDK reconnection

When network interruption occurs, the SDK automatically tries reconnecting to the server.

The following diagram shows the callbacks received by UID 1 and UID 2, where UID 1 joins the channel, gets a network exception, loses connection, and rejoins the channel.

![](https://web-cdn.agora.io/docs-files/1569306559250)

Where:

- T0: The SDK receives the`joinChannelByToken` request from UID 1.
- T1: 200 ms after calling the `joinChannelByToken` method, UID 1 joins the channel. During the process, UID 1 also receives the `connectionChangedToState(AgoraConnectionStateConnecting, AgoraConnectionChangedConnecting)` callback. When successfully joining the channel, UID 1 receives the `connectionChangedToState(AgoraConnectionStateConnected, AgoraConnectionChangedJoinSuccess)` and `didJoinChannel` callbacks.
- T2: Due to network latency, UID 2 detects UID 1 100 ms after the latter joins the channel. UID 2 receives the `didJoinedOfUid` callback.
- T3: The uplink network condition of UID 1 deteriorates. The SDK automatically tries rejoining the channel.
- T4 : If UID 1 fails to receive any data from the server in four seconds, it receives the `connectionChangedToState(AgoraConnectionStateReconnecting, AgoraConnectionChangedInterrupted)` callback; meanwhile the SDK continues to try rejoining the channel.
- T5 : If UID 1 fails to receive any data from the server in 15 seconds, UID 1 receives the `rtcEngineConnectionDidLost` callback; meanwhile the SDK continue to try rejoining the channel.
- T6: If UID 2 fails to receive any data from UID 1 in 20 seconds, the SDK decides that UID 1 is offline. UID 2 receives the `didOfflineOfUid` callback.
- T7: If UID 1 fails to rejoin the channel in 20 minutes, the SDK stops trying. UID 1 receives the `connectionChangedToState(AgoraConnectionStateFailed, AgoraConnectionChangedJoinFailed)` callback. UID 1 needs to leave the channel and call the`joinChannelByToken` method to join the channel.


## API reference

- [getConnectionState](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/getConnectionState)
- [connectionChangedToState](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:connectionChangedToState:reason:)
- [rtcEngineConnectionDidLost](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngineConnectionDidLost:)

## Reference

For the reconnection mechanism in Agora Native SDKs earlier than v2.3.2, and how connection states change when the process gets killed, see [FAQ: Does Agora have reconnection mechanisms?]((https://docs.agora.io/en/faq/sdk_behavior))