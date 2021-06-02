---
title: Manage Connection States
platform: Android
updatedAt: 2021-03-12 04:55:12
---
## Overview

When users log in and out of the Agora RTM system, or when the network connection state changes, the connection between the Agora RTM SDK and the Agora RTM system switches between different states. The possible connection states are as follows:

- CONNECTION_STATE_DISCONNECTED (The user is not connected.)
- CONNECTION_STATE_CONNECTING (The user is connecting.)
- CONNECTION_STATE_CONNECTED (The user is connected.)
- CONNECTION_STATE_RECONNECTING (The user is reconnecting.)
- CONNECTION_STATE_ABORTED (The user is kicked out.)

In the following figure, the solid lines show conditions where the SDK automatically switches states, and the dotted lines show conditions where the user needs to actively call APIs to switch states.


<div class="alert note">Whenever the connection state changes, the RTM SDK returns the latest state (the <code>CONNECTION_STATE</code> enumeration) and the cause for the state change (the <code>CONNECTION_CHANGE_REASON</code> enumeration) through the <code>onConnectionStateChanged</code> callback. You can manage connection states through this callback.</div>

![](https://web-cdn.agora.io/docs-files/1611310606967)

## Call APIs to change connection states

You can use the state and cause for the state change returned by the `onConnectionStateChanged` callback to actively call the API to change the connection state in the following situations.

### Log in to the RTM system

When you call `login` to log in to the RTM system, the connection state changes from CONNECTION_STATE_DISCONNECTED to CONNECTION_STATE_CONNECTING, and the cause for the state change is CONNECTION_CHANGE_REASON_LOGIN. When the state is CONNECTION_STATE_CONNECTING, you do not need to perform any operations and the connection state automatically changes to one of the following states:

- CONNECTION_STATE_DISCONNECTED: The login fails or times out (the user fails to log in within 12 seconds).
- CONNECTION_STATE_CONNECTED: The login succeeds. 

When the connection state turns to CONNECTION_STATE_DISCONNECTED, you need to call `login` again to log in.

### Disconnected from the RTM system due to network problems

When the connection state is CONNECTION_STATE_CONNECTED, if the connection with the Agora RTM system is interrupted and cannot recover in four seconds due to network reasons, the connection state changes to CONNECTION_STATE_RECONNECTING, and the cause for the state change is CONNECTION_CHANGE_REASON_INTERRUPTED. When in the CONNECTION_STATE_RECONNECTING state, the RTM SDK continues to automatically reconnect to the RTM system until the login is successful, so you do not need to perform any login operations. After successful reconnection, the connection state changes to CONNECTION_STATE_CONNECTED, but the SDK does not return the `onLoginSuccess` callback.


After the automatic reconnection is successful, the RTM system resends messages that occurred during the disconnection, as follows:

- All peer-to-peer messages during the disconnection.
- A maximum of 32 channel messages that were sent within the 30-second period before successful reconnection. 


If the reconnection keeps failing, the connection state remains at CONNECTION_STATE_RECONNECTING. You can call `logout` to log out of the system first, and then call the `login` method to reconnect at an appropriate time.


The RTM system responds differently per the length of time between the interruption of the connection and the successful reconnection:

- If the user successfully logs in again within 30 seconds of the interruption, the connection state changes to the CONNECTION_STATE_CONNECTED. The user's online state remains unchanged.
- If the user is still offline 30 seconds after the interruption, the RTM system removes the user from the online user list and channel, and users in the same channel receive the `onMemberLeft` callback. If the user successfully logs in later, the connection state changes to the CONNECTION_STATE_CONNECTED. The SDK automatically adds the user to the previous channel, and users in the same channel receive the `onMemberJoined` callback. Because the RTM system has removed the user from the online list, the SDK will also automatically synchronize user attributes to the RTM system.


In the CONNECTION_STATE_RECONNECTING state, the SDK keeps reconnecting to the Agora RTM system. If the token expires, the SDK returns the `onTokenExpired` callback, which does not affect the connection state.


### Kicked out of the RTM system

If the same user ID logs in to the RTM system from another client instance, the user who is currently connected in the client instance gets kicked out by the RTM system, and the connection state changes to CONNECTION_STATE_ABORTED. You can call `logout` to log out of the system first, and then call the `login` method to reconnect in an appropriate time. 

<div class="alert note">In the <code>CONNECTION_STATE_ABORTED</code> state, any call to APIs that require user login fails. In app development, users in this state can be automatically logged out but need to manually log in again. If the user is automatically logged out and logged in, an infinite loop may be formed in which users from two clients are always kicking out each other. The infinite loop ends only when the user from one client logs out or the process is killed.</div>

### Log out of the RTM system

If you call `logout` to log out of the RTM system, the connection state changes to CONNECTION_STATE_DISCONNECTED.

## Sample code

Refer to the following sample code to monitor the connection state:

```
// Monitors the connection state
  virtual void onConnectionStateChanged(CONNECTION_STATE state, CONNECTION_CHANGE_REASON reason)
 {
    Print("onConnectionStateChanged: %d", state);
  }
```


## API reference

- [`onConnectionStateChanged`](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service_event_handler.html#aa2e25e87c6f06cfd71b3538786d23743) 
- [`CONNECTION_STATE`](/en/Real-time-Messaging/API%20Reference/RTM_cpp/namespaceagora_1_1rtm.html#aa6af3dc5c5eeb4df7a3ff1eea25b1cee) 
- [`CONNECTION_CHANGE_REASON`](/en/Real-time-Messaging/API%20Reference/RTM_cpp/namespaceagora_1_1rtm.html#a81380191ea654d791fb7e6db14faca90) 