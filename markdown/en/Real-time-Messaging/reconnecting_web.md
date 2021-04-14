---
title: Manage Connection States
platform: Web
updatedAt: 2021-03-12 04:55:14
---
## Overview

When users log in and out of the Agora RTM system, or when the network connection state changes, the connection between the Agora RTM SDK and the Agora RTM system switches between different states. The possible connection states are as follows:

- DISCONNECTED (The user is not connected.)
- CONNECTING (The user is connecting.)
- CONNECTED (The user is connected.)
- RECONNECTING (The user is reconnecting.)
- ABORTED (The user is kicked out.)

In the following figure, the solid lines show conditions where the SDK automatically switches states, and the dotted lines show conditions where the user needs to actively call APIs to switch states.


<div class="alert note">Whenever the connection state changes, the RTM SDK returns the latest state (the <code>ConnectionState</code> enumeration) and the cause for the state change (the <code>ConnectionChangeReason</code> enumeration) through the <code>ConnectionStateChanged</code> callback. You can manage connection states through this callback.</div>

![](https://web-cdn.agora.io/docs-files/1602312695250)

## Call APIs to change connection states

You can use the state and cause for the state change returned by the `ConnectionStateChanged` callback to actively call the API to change the connection state in the following situations.

### Log in to the RTM system

When you call `login` to log in to the RTM system, the connection state changes from DISCONNECTED to CONNECTING, and the cause for the state change is LOGIN. When the state is CONNECTING, you do not need to perform any operations and the connection state automatically changes to one of the following states:

- DISCONNECTED: The login fails or times out (the user fails to log in within 12 seconds).
- CONNECTED: The login succeeds. 

When the connection state turns to DISCONNECTED, you need to call `login` again to log in.

### Disconnected from the RTM system due to network problems

When the connection state is CONNECTED, if the connection with the Agora RTM system is interrupted and cannot recover in four seconds due to network reasons, the connection state changes to RECONNECTING, and the cause for the state change is INTERRUPTED. When in the RECONNECTING state, the RTM SDK continues to automatically reconnect to the RTM system until the login is successful, so you do not need to perform any login operations. After successful reconnection, the connection state changes to CONNECTED.


After the automatic reconnection is successful, the RTM system resends messages that occurred during the disconnection, as follows:

- All peer-to-peer messages during the disconnection.
- A maximum of 32 channel messages that were sent within the 30-second period before successful reconnection. 


If the reconnection keeps failing, the connection state remains at RECONNECTING. You can call `logout` to log out of the system first, and then call the `login` method to reconnect at an appropriate time.


The RTM system responds differently per the length of time between the interruption of the connection and the successful reconnection:

- If the user successfully logs in again within 30 seconds of the interruption, the connection state changes to the CONNECTED. The user's online state remains unchanged.
- If the user is still offline 30 seconds after the interruption, the RTM system removes the user from the online user list and channel, and users in the same channel receive the `MemberLeft` callback. If the user successfully logs in later, the connection state changes to the CONNECTED. The SDK automatically adds the user to the previous channel, and users in the same channel receive the `MemberJoined` callback. Because the RTM system has removed the user from the online list, the SDK will also automatically synchronize user attributes to the RTM system.


In the RECONNECTING state, the SDK keeps reconnecting to the Agora RTM system. If the token expires, the SDK returns the `TokenExpired` callback, which does not affect the connection state.


### Kicked out of the RTM system

If the same user ID logs in to the RTM system from another client instance, the user who is currently connected in the client instance gets kicked out by the RTM system, and the connection state changes to ABORTED. You can call `logout` to log out of the system first, and then call the `login` method to reconnect in an appropriate time. 

<div class="alert note">In the <code>ABORTED</code> state, any call to APIs that require user login fails. In app development, users in this state can be automatically logged out but need to manually log in again. If the user is automatically logged out and logged in, an infinite loop may be formed in which users from two clients are always kicking out each other. The infinite loop ends only when the user from one client logs out or the process is killed.</div>

### Log out of the RTM system

If you call `logout` to log out of the RTM system, the connection state changes to DISCONNECTED.

## Sample code

Refer to the following sample code to monitor the connection state:

```
// Monitors the connection state
rtm.on('ConnectionStateChanged', (newState, reason) => {
    console.log('reason', reason)
```


## API reference

- [`ConnectionStateChanged`](/en/Real-time-Messaging/API%20Reference/RTM_web/interfaces/rtmevents.rtmclientevents.html#connectionstatechanged)
- [`ConnectionState`](/en/Real-time-Messaging/API%20Reference/RTM_web/enums/rtmstatuscode.connectionstate.html)
- [`ConnectionStateReason`](/en/Real-time-Messaging/API%20Reference/RTM_web/enums/rtmstatuscode.connectionchangereason.html)