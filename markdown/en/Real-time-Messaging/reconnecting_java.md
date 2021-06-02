---
title: Manage Connection States
platform: Android
updatedAt: 2021-03-12 04:55:11
---
## Overview

When users log in and out of the Agora RTM system, or when the network connection state changes, the connection between the Agora RTM SDK and the Agora RTM system switches between different states. The possible connection states are as follows:

- CONNECTION_STATE_DISCONNECTED (The user is not connected.)
- CONNECTION_STATE_CONNECTING (The user is connecting.)
- CONNECTION_STATE_CONNECTED (The user is connected.)
- CONNECTION_STATE_RECONNECTING (The user is reconnecting.)
- CONNECTION_STATE_ABORTED (The user is kicked out.)

In the following figure, the solid lines show conditions where the SDK automatically switches states, and the dotted lines show conditions where the user needs to actively call APIs to switch states.


<div class="alert note">Whenever the connection state changes, the RTM SDK returns the latest state (the <code>ConnectionState</code> enumeration) and the cause for the state change (the <code>ConnectionStateReason</code> enumeration) through the <code>onConnectionStateChanged</code> callback. You can manage connection states through this callback.</div>

![](https://web-cdn.agora.io/docs-files/1602305100142)


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

### Log out of the RTM system

If you call `logout` to log out of the RTM system, the connection state changes to CONNECTION_STATE_DISCONNECTED.

## Sample code

Refer to the following sample code to monitor the connection state:


```
// Monitors the connection state
public void onConnectionStateChanged(int state, int reason)
{
   System.out.println("on connection state changed to "+ state + " reason: " + reason);
 }
```


## API reference

- [`onConnectionStateChanged`](/en/Real-time-Messaging/API%20Reference/RTM_java_Linux/interfaceio_1_1agora_1_1rtm_1_1_rtm_client_listener.html#a9b6f86cb2d7d5ec4adf0b6d645c16bf9)
- [`ConnectionState`](/en/Real-time-Messaging/API%20Reference/RTM_java_Linux/interfaceio_1_1agora_1_1rtm_1_1_rtm_status_code_1_1_connection_state.html) 
- [`ConnectionChangeReason`](/en/Real-time-Messaging/API%20Reference/RTM_java_Linux/interfaceio_1_1agora_1_1rtm_1_1_rtm_status_code_1_1_connection_change_reason.html) 