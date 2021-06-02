---
title: Manage Connection States
platform: Android
updatedAt: 2021-03-12 04:55:13
---
## Overview

When users log in and out of the Agora RTM system, or when the network connection state changes, the connection between the Agora RTM SDK and the Agora RTM system switches between different states. The possible connection states are as follows:

- AgoraRtmConnectionStateDisconnected (The user is not connected.)
- AgoraRtmConnectionStateConnecting (The user is connecting.)
- AgoraRtmConnectionStateConnected (The user is connected.)
- AgoraRtmConnectionStateReconnecting (The user is reconnecting.)
- AgoraRtmConnectionStateAborted (The user is kicked out.)

In the following figure, the solid lines show conditions where the SDK automatically switches states, and the dotted lines show conditions where the user needs to actively call APIs to switch states.


<div class="alert note">Whenever the connection state changes, the RTM SDK returns the latest state (the <code>connectionStateChanged</code> enumeration) and the cause for the state change (the <code>AgoraRtmConnectionChangeReason</code> enumeration) through the <code>connectionStateChanged</code> callback. You can manage connection states through this callback.</div>

![](https://web-cdn.agora.io/docs-files/1602310309202)

## Call APIs to change connection states

You can use the state and cause for the state change returned by the `connectionStateChanged` callback to actively call the API to change the connection state in the following situations.

### Log in to the RTM system

When you call `loginByToken` to log in to the RTM system, the connection state changes from AgoraRtmConnectionStateDisconnected to AgoraRtmConnectionStateConnecting, and the cause for the state change is AgoraRtmConnectionChangeReasonLogin. When the state is AgoraRtmConnectionStateConnecting, you do not need to perform any operations and the connection state automatically changes to one of the following states:

- AgoraRtmConnectionStateDisconnected: The login fails or times out (the user fails to log in within 12 seconds).
- AgoraRtmConnectionStateConnected: The login succeeds. 

When the connection state turns to AgoraRtmConnectionStateDisconnected, you need to call `loginByToken` again to log in.

### Disconnected from the RTM system due to network problems

When the connection state is AgoraRtmConnectionStateConnected, if the connection with the Agora RTM system is interrupted and cannot recover in four seconds due to network reasons, the connection state changes to AgoraRtmConnectionStateReconnecting, and the cause for the state change is AgoraRtmConnectionChangeReasonInterrupted. When in the AgoraRtmConnectionStateReconnecting state, the RTM SDK continues to automatically reconnect to the RTM system until the login is successful, so you do not need to perform any login operations. After successful reconnection, the connection state changes to AgoraRtmConnectionStateConnected, but the SDK does not return the `AgoraRtmLoginBlock` callback.


After the automatic reconnection is successful, the RTM system resends messages that occurred during the disconnection, as follows:

- All peer-to-peer messages during the disconnection.
- A maximum of 32 channel messages that were sent within the 30-second period before successful reconnection. 


If the reconnection keeps failing, the connection state remains at AgoraRtmConnectionStateReconnecting. You can call `logoutWithCompletion` to log out of the system first, and then call the `loginByToken` method to reconnect at an appropriate time.


The RTM system responds differently per the length of time between the interruption of the connection and the successful reconnection:

- If the user successfully logs in again within 30 seconds of the interruption, the connection state changes to the AgoraRtmConnectionStateConnected. The user's online state remains unchanged.
- If the user is still offline 30 seconds after the interruption, the RTM system removes the user from the online user list and channel, and users in the same channel receive the `memberLeft` callback. If the user successfully logs in later, the connection state changes to the AgoraRtmConnectionStateConnected. The SDK automatically adds the user to the previous channel, and users in the same channel receive the `memberJoined` callback. Because the RTM system has removed the user from the online list, the SDK will also automatically synchronize user attributes to the RTM system.


In the AgoraRtmConnectionStateReconnecting state, the SDK keeps reconnecting to the Agora RTM system. If the token expires, the SDK returns the `rtmKitTokenDidExpire` callback, which does not affect the connection state.


### Kicked out of the RTM system

If the same user ID logs in to the RTM system from another client instance, the user who is currently connected in the client instance gets kicked out by the RTM system, and the connection state changes to AgoraRtmConnectionStateAborted. You can call `logoutWithCompletion` to log out of the system first, and then call the `loginByToken` method to reconnect in an appropriate time. 

<div class="alert note">In the <code>AgoraRtmConnectionStateAborted</code> state, any call to APIs that require user login fails. In app development, users in this state can be automatically logged out but need to manually log in again. If the user is automatically logged out and logged in, an infinite loop may be formed in which users from two clients are always kicking out each other. The infinite loop ends only when the user from one client logs out or the process is killed.</div>

### Log out of the RTM system

If you call `logoutWithCompletion` to log out of the RTM system, the connection state changes to AgoraRtmConnectionStateDisconnected.

## Sample code

Refer to the following sample code to monitor the connection state:

```
// Monitors the connection state
- (void)rtmKit:(AgoraRtmKit *)kit connectionStateChanged:(AgoraRtmConnectionState)state reason:(AgoraRtmConnectionChangeReason)reason {
    NSString *message = [NSString stringWithFormat:@"connection state changed: %ld", state];
}
```


## API reference
- [`connectionStateChanged`](/en/Real-time-Messaging/API%20Reference/RTM_oc/Protocols/AgoraRtmDelegate.html#//api/name/rtmKit:connectionStateChanged:reason:)
- [`AgoraRtmConnectionState`](/en/Real-time-Messaging/API%20Reference/RTM_oc/Constants/AgoraRtmConnectionState.html)
- [`AgoraRtmConnectionChangeReason`](/en/Real-time-Messaging/API%20Reference/RTM_oc/Constants/AgoraRtmConnectionChangeReason.html)