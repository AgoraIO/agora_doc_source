# Channel Connection

During a real-time engagement session, the connection state between an app client and Agora SD-RTN<sup>TM</sup> changes as the client joins and leaves an Agora channel, or go offline due to network or authentication reasons. 

This page includes introductions to the various connection states and how they change, as well as the reasons behind these changes.

## Understand the tech

Agora provides an `onConnectionStateChanged` callback that occurs when the connection state changes. The following diagram illustrates the various states and how the states change:

![](images/connection_tech.png)

As shown in the diagram, a client app can have five connection states before and after it joins an Agora channel. You can use these connection states to better manage the user and troubleshoot when network interruption occurs.

## Implement channel connection monitoring

This section includes how to implemnent channel connection monitoring in a real-time engagement app.

```java
public void onConnectionStateChanged(int state, int reason) {
    super.onConnectionStateChanged(state, reason);
    Log.i(TAG, "onConnectoionStateChanged->" + ", state->" + state + ", reason->" + reason);
}
```

 The `onConnectionStateChanged` callback that includes all these state and a `reason` parameter that explains the reasons for connection state changes:

 | Connection state | Reasons for the state change | Trouble shooting |
 | --- | --- | --- |
 | Disconnected | <ul><li>`LEAVE_CHANNEL`</li> | N/A |
 | Connecting | <ul><li>`CONNECTING`</li><li>`RENEW_TOKEN`</li> | N/A |
 | Connected | <ul><li>`JOIN_SUCCESS`</ul> | N/A |
 | Reconnecting | <ul><li>`INTERUPTED`</li><li>`INVALID_APP_ID`</li><li>`INVALID_CHANNEL_NAME`</li><li>`INVALID_TOKEN`</li><li>`TOKEN_EXPIRED`</li><li>`SETTING_PROXY_SERVER`</li><li>`CLIENT_IP_ADDRESS_CHANGED`</li><li>`KEEP_ALIVE_TIMEOUT`</li><li>`PROXY_SERVER_INTERRUPTED`</li>| |
 | Failed | <ul><li>`BANNED_BY_SERVER`</li><li>`JOIN_FAILED`</li><li>`REJECTED_BY_SERVER`</li> |



When the network connection is interrupted, the SDK automatically tries to reconnect to the server. 
- If it successfully rejoins the channel, the SDK triggers `onRejoinChannelSuccess`.
- If not in 10 seconds, the SDK triggers `onConnectionLost` while still trying rejoining the channel.
- If not in 20 minutes, the SDK stops


## Reference


 

