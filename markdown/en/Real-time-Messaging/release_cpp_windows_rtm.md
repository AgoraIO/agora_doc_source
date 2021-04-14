---
title: Release Notes
platform: Android
updatedAt: 2021-02-10 04:11:31
---
  ## Overview

The Agora Real-time Messaging (RTM) SDK provides a streamlined and stable messaging mechanism for you to quickly implement real-time messaging for various scenarios. See [product overview](/en/Real-time-Messaging/product_rtm?platform=All%20Platforms) for more information.

## v1.2.1

v1.2.1 was released on November 20, 2019. 



### Issues Fixed

- The SDK fails to reconnect to the Agora RTM system if the user disables VPN. 
- If a channel member reconnects to the Agora RTM server after being interrupted, chances are the rest members of the channel can receive `onMemberJoined` twice. 

## v1.2.0 

v1.2.0 was released on November 6, 2019. 

### Compatibility Changes

Deprecated the `isOnline` property of the `PeerOnlineStatus`. Use `onlineState` instead. 


### New Features

#### Subscribe to the online status of the specified user(s)

When the method call succeeds, the SDK returns the onPeersOnlineStatusChanged callback to report the online status of peers, to whom you subscribe.
When the online status of the peers, to whom you subscribe, changes, the SDK returns the onPeersOnlineStatusChanged callback to report whose online status has changed.
If the online status of the peers, to whom you subscribe, changes when the SDK is reconnecting to the server, the SDK returns the onPeersOnlineStatusChanged callback to report whose online status has changed when successfully reconnecting to the server.

#### Unsubscribe from the online status of the specified user(s)

Allows you to unsubscribe from the online status of the specified user(s).

#### Get a list of the peers, to whose specific status you have subscribed

Allows you to get a list of the peers, to whose specific status you have subscribed.

#### Create a raw message

Creates and initializes a raw message to be sent.

 If you set a text description, ensure that the size of the raw message and the description combined does not exceed 32 KB.




## v1.1.0

v1.1.0 was released on September 30, 2019. It added the following features: 

### Send an (offline) peer-to-peer message to a specified user

This version allows you to send a message to a specified user when that user is offline. If you set a message as an offline message and the specified user is offline when you send it, the RTM server caches it. Please note that we only cache 200 offline messages for up to seven days for each receiver. If the number of the cached messages reaches this limit, the newest message overrides the oldest one.



<a name="getcount"></a>

### Get the member count of specified channel(s)

Use the [getChannelMemberCount](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#a41dee47c6201acb2f29371b6e30249a5) method get the member count of specified channel(s) without the need to join them. One method call can get the member counts of a maximum of 32 channels. 

### Query the online status of the specified users

### User attribute operations

This version enables you to set or update a user's attributes. Please note: 

- Only after you successfully logging in the Agora RTM system can you execute user attribute-related operations. Otherwise, the SDK triggers the `ATTRIBUTE_OPERATION_ERR_NOT_LOGGED_IN` error code.
- The attributes you set will be cleared when you log out of the RTM system.
- You can only set a maximum of 16 KB attributes in a single method call. Otherwise, the SDK triggers the `ATTRIBUTE_OPERATION_ERR_SIZE_OVERFLOW` error code. 

You can do the following:

- Substitute the local user's attributes with new ones.
- Add or update the local user's attribute(s).
- Use attribute keys to delete the local user's attributes.
- Clear all attributes of the local user.
- Get all attributes of a specified user.
- Use attribute keys to get the attributes of a specified user.

### Channel attribute operations

This version enables you to set or get the attribute(s) of a specified channel. You can use this feature to create group announcements.

Each channel attribute exists as a key-value pair. See [IRtmChannelAttribute](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_channel_attribute.html) for more information. Please note: 

- The key for each channel attribute must be printable characters and not exceed 8 KB.
- Each channel attribute must not exceed 8 KB in length. 
- The overall size of the attributes of a channel must not exceed 32 KB. 
- The number of attributes of a channel must not exceed 32. 

You can do the following: 

- Substitute the attributes of a specified channel with new ones.
- Adds or update the attribute(s) of a specified channel.
- Use attribute keys to deletes the attributes of a specified channel.
- Clear all attributes of a specified channel.
- Get all attributes of a specified channel.
- Use attribute keys to get the attributes of a specified channel.

>  The  [enableNotificationToChannelMembers](/en/Real-time-Messaging/API%20Reference/RTM_cpp/structagora_1_1rtm_1_1_channel_attribute_options.html#a9a29721df90beca76974a5e348902530) flag decides whether to notify all members of a channel about this attribute change. 

### Call invitation

This version enables you to create, send, cancel, accept, and decline a call invitation in a one-to-one or one-to-many voice/video call. 

### Join or leave a channel

### Send or receive channel messages

<a name="oncount"></a>

### Automatically return the latest number of members in the current channel 

Once you are in a channel, you no longer must call the `getChannelMemberCount` method to get the member count of the current channel. We also do not recommend using `onMemberJoined` and `onMemberLeft` to keep track of the member counts. As of this release, the SDK returns to the channel members [onMemberCountUpdated](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_channel_event_handler.html#aff85052bb2a46c3220789c1ef90aa01e) the latest channel member count when the number of channel members changes. Note that:

- When the number of channel members ≤ 512, the SDK returns this callback when the number changes and at a MAXIMUM speed of once per second.
- When the number of channel members exceeds 512, the SDK returns this callback when the number changes and at a MAXIMUM speed of once every three seconds.



> Please treat this callback and the [onGetMembers](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_channel_event_handler.html#a5e3f5a5ae0b3861de2f0310841ad0b37) callback separately: 
>
> - The former is an automatic callback. It returns the current numer of channel members;
> - The latter is triggered by the [getMembers](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_channel.html#a3f9c943059ac48a568c81798da38c3cb) method. It returns a member list of the current channel. If the number of channel members exceeds 512, the SDK only returns a list of 512 randomly selected channel members. 

### Renew the Token

### Specify the default path to the SDK log file

Use the `setLogFile` method to change the default path to the SDK log file. To ensure that errors are completely written to the log file, we recommend calling this method immediately after you have created and initialized an `IRtmService` instance.



### Set the output log level of the SDK

Use the `setLogFilter` method to set the output log level of the SDK.  The log level follows the sequence of OFF, CRITICAL, ERROR, WARNING, and INFO. Choose a level to see the logs preceding that level. If, for example, you set the log level to WARNING, you see the logs within levels CRITICAL, ERROR, and WARNING (the OFF level does not return any log results). See also [LOG_FILTER_TYPE](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/namespaceagora_1_1rtm.html#af515252477afb2a71feef88113dfa481). 

> You can call this method once you have created and initialized an `IRtmService` instance. You do not have to call this method until after calling the `login` method. 

### Set the log file size in KB

Use the `setLogFileSize` method to set the log file size. The log file has a default size of 512 KB. File size settings of less than 512 KB or greater than 10 MB will not take effect.

> You can call this method once you have created and initialized an `IRtmService` instance. You do not have to call this method until after calling the `login` method. 