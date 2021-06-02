---
title: Switch the Client Role
platform: Windows
updatedAt: 2018-12-14 00:30:11
---
An interactive broadcast channel consists of two user roles: 
-   Host (Broadcaster): A host receives and publishes the audio streams, and interacts with other hosts using voice.
-   Audience: An audience receives the audio streams of the hosts.

You can call the <code>setClientRole</code> method to set the user role as the host (broadcaster) or audience according to your needs.


```
int nRet = m_lpAgoraEngine->setClientRole(role);
```

> You can call the <code>setClientRole</code> method before joining a live broadcast channel or during a live broadcast:
> 
>  - Before joining the channel: Set the client role as the host (broadcaster) or audience.
>  -  During a live broadcast: Switch the user role from an audience to the host (broadcaster) or vice versa.

If two users join a live broadcast channel as hosts:

1. User A calls the `setClientRole` method to set the user role as the host, and calls `joinChannel` to join the channel.

   ```cpp
   //Set the user role as the host.
   int nRet = m_lpAgoraEngine->setClientRole(role);
   
   //Create and join a channel.
   LPCSTR lpStreamInfo = "{\"owner\":true,\"width\":640,\"height\":480,\"bitrate\":500}";
   nRet = m_lpAgoraEngine->joinChannel(lpDynamicKey, lpChannelName, lpStreamInfo, nUID);
   ```
	 
2. User B calls the `setClientRole` method to set the user role as the host, and calls `joinChannel` to join the channel.

   ```cpp
   //Set the user role as the host.
   int nRet = m_lpAgoraEngine->setClientRole(role);
   
   //Create and join a channel.
   LPCSTR lpStreamInfo = "{\"owner\":true,\"width\":640,\"height\":480,\"bitrate\":500}";
   nRet = m_lpAgoraEngine->joinChannel(lpDynamicKey, lpChannelName, lpStreamInfo, nUID);
   ```

User A joins the channel as a host and user B joins as an audience. If user B wants to switch to the host:

1. User A calls the `setClientRole` method and sets the user role as the host, and calls the `joinChannel` method to join a channel.

   ```cpp
   //Set the user role as the host.
   int nRet = m_lpAgoraEngine->setClientRole(role);
   
   //Create and join a channel.
   LPCSTR lpStreamInfo = "{\"owner\":true,\"width\":640,\"height\":480,\"bitrate\":500}";
   nRet = m_lpAgoraEngine->joinChannel(lpDynamicKey, lpChannelName, lpStreamInfo, nUID);
   ```

2. User B calls the `joinChannel` method, joins the channel as an audience, and then calls the `setClientRole` method to switch the user role to the host.

   ```cpp
//Create and join a channel.
   LPCSTR lpStreamInfo = "{\"owner\":true,\"width\":640,\"height\":480,\"bitrate\":500}";
   nRet = m_lpAgoraEngine->joinChannel(lpDynamicKey, lpChannelName, lpStreamInfo, nUID);
	 
   //Set the user role as the host.
   int nRet = m_lpAgoraEngine->setClientRole(role);
   ```