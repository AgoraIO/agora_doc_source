---
title: Switch the Client Role
platform: Android
updatedAt: 2018-12-14 05:53:21
---
A live broadcast channel consists of two user roles: 

-   Host (Broadcaster): A host receives and publishes the voice streams, and interacts with other hosts using voice.
-   Audience: An audience can only hear the hosts.

You can call the `setClientRole` method to set the user role. 

```
mRtcEngine.setClientRole(Constants.CLIENT_ROLE_BROADCASTER)
```

> You can call the `setClientRole` method before joining a live broadcast channel or during a live broadcast:
> 
>  - Before joining the channel: Set the client role as the host or audience.
>  -  During a live broadcast: Switch the user role from an audience to the host or vice versa.

If two users join a live broadcast channel as hosts:

1. User A calls the `setClientRole` method to set the user role as the host, and calls the `joinChannel` method to join the channel.

   ```Java
   //Set the user role as the host.
   mRtcEngine.setClientRole(Constants.CLIENT_ROLE_BROADCASTER)
   
   //Create and join a channel.
   mRtcEngine.joinChannel(null, "channelName", null, myUid)
   ```
	 
2. User B calls the `setClientRole` method to set the user role as the host, and calls the `joinChannel` method to join a channel.

   ```Java
   //Set the user role as the host.
   mRtcEngine.setClientRole(Constants.CLIENT_ROLE_BROADCASTER)
   
   //Create and join a channel.
   mRtcEngine.joinChannel(null, "channelName", null, myUid)
   ```
	 
User A joins the channel as a host and user B joins as an audience. If user B wants to switch to a host:

1. User A calls the `setClientRole` method to set the user role as the host, and calls the `joinChannel` method to join a channel.

   ```Java
   //Set the user role as the host.
   mRtcEngine.setClientRole(Constants.CLIENT_ROLE_BROADCASTER)
   
   //Create and join a channel.
   mRtcEngine.joinChannel(null, "channelName", null, myUid)
   ```
	 
2. User B calls the `joinChannel` method to join the channel as an audience, and calls the `setClientRole` method to switch the user role to the host.

   ```Java
   //Create and join a channel.
   mRtcEngine.joinChannel(null, "channelName", null, myUid)
   
   //Set the user role as the host.
   mRtcEngine.setClientRole(Constants.CLIENT_ROLE_BROADCASTER)
   ```