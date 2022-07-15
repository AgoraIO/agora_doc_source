~7ef2bd50-e4e2-11e9-ace3-6300933cff54~

## v1.4.10
v1.4.10 was released on March 01, 2022.

#### Issues fixed

Fixed some rich media related crashes.

## v1.4.9
v1.4.9 was released on November 26, 2021.

#### Improvements

Improved the login success rate and connection stability under the IPv4/IPv6 dual-stack network.

## v1.4.7
v1.4.7 was released on July 19, 2021.

Improved the success rate of logins and message delivery for the RTM SDK in poor network conditions.

## v1.4.6

v1.4.6 was released on June 21, 2021.

Fixed some issues that may cause crashes to improve stability.

## v1.4.5

v1.4.5 was released on April 30, 2021.

#### Improvements

Fixed some issues that may cause crashes to improve stability.

## v1.4.4

v1.4.4 was released on April 20, 2021.

#### Improvements

Improved the success rate of logins and message delivery for the RTM SDK in poor network conditions.

#### Issues fixed

Fixed some issues that might cause the system to crash.

## v1.4.3

v1.4.3 was released on February 10, 2021.

#### Issues fixed

This release fixed the following issues:

- Crash issues caused by occasional multi-thread access conflict.
- High timeout rate for RTM login operations.

## v1.4.2

v1.4.2 was released on November 23, 2020.

**Compatibility changes**

- For CentOS, v1.4.2 does not support CentOS 7 or earlier. If your CentOS is 7 or earlier, Agora recommends that you use v1.4.1.
- In `setLogFileSize`, the default log file size increases from 10 MB to 100 MB.

**Improvements**

Improved the performance of login and messaging operations.

**Bug fixes**

Fixed the issue that `java.lang.UnsatisfiedLinkError: no agora-rtm-sdk-jni in java.library.path` occurred when integrating the v1.4.0 and the v1.4.1 SDK.

## v1.4.1

v1.4.1 was released on September 30, 2020.

**Improvements**

Improved the log file.


## v1.4.0

v1.4.0 was released on September 1, 2020.

**Compatibility changes**

- You need to add new ports to the firewall whitelist. See [Firewall Requirements](https://docs.agora.io/en/Agora%20Platform/firewall?platform=All%20Platforms).
    - New TCP ports: 8443, 9136, 9137, 9141. New UDP port: 8443. Reason: Support real-time transport encryption.
    - New UDP ports: 8130, 9120, 9121. Reason: Support UDP path to improve the SDK's performance in sub-optimal network conditions.
    - New UDP port: 9700. Reason: Support data reporting.
- In `setLogFileSize`, the default log file size increases from 512 KB to 10 MB. The maximum log file size increases from 10 MB to 1 GB.

**New features**

- Geofencing. You can call `setRtmServiceContext` to set the region of the Agora RTM SDK. The RTM SDK can only connect to Agora RTM servers within the specified region.
- Transport Layer Security (TLS) encryption.

**Improvements**

- Improved the success rate of login and message delivery of the RTM SDK in poor network conditions. 
- The call frequency limit has increased for the following operations. See [Limitations](/en/Real-time-Messaging/limitations_android?platform=Android). 

| Operation                                 | Call frequency limit change                                  |
| :---------------------------------------- | :----------------------------------------------------------- |
| Send peer-to-peer or channel messages     | Increased from 300 calls every three seconds to 1,500 calls every three seconds |
| Query user online status                  | Increased from 20 calls every five seconds to 100 calls every five seconds |
| Add, delete, or update user attributes    | Increased from 20 calls every five seconds to 100 calls every five seconds |
| Query user attributes                     | Increased from 80 calls every five seconds to 400 calls every five seconds |
| Add, delete, or update channel attributes | Increased from 20 calls every five seconds to 100 calls every five seconds |
| Query channel attributes                  | Increased from 80 calls every five seconds to 400 calls every five seconds |

- Optimized the reconnection mechanism.

**API changes**

#### New methods

[`setRtmServiceContext`](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/v1.4.0/classio_1_1agora_1_1rtm_1_1_rtm_client.html?transId=d0cb6360-eb2c-11ea-b8b9-41d66d687758#a60f0dae72834f3d300bd7e5abb3fdcc7)

## v1.3.0

v1.3.0 was released on June 12.

**Compatibility changes**

- You need to add a new TCP port, 9140, to the firewall whitelist. The port is for sending and receiving image or file messages. See [Firewall Requirements](https://docs.agora.io/en/Agora%20Platform/firewall?platform=All%20Platforms).
- The Agora server blocks any file message or image message that you send to RTM SDK 1.2.2 or earlier, or to the Signaling SDK.

**New features**

#### 1. Send and receive file messages or image messages

You can call `createFileMessageByUploading` or `createImageMessageByUploading` to upload non-empty files or image files no greater than 30 MB. Each uploaded file or image stays in the Agora server for seven days. The SDK returns a media ID as the unique indentifier of the file or image file. You can use the `RtmFileMessage` class or the `RtmImageMessage` class to save the media ID. The `RtmFileMessage` class and the `RtmImageMessage` class inherit from the `RtmMessage` class, so you can send and receive file or image messages via peer-to-peer or channel message methods. You can call `downloadMediaToMemory` or `downloadMediaToFile` to download the received file or image file.

#### 2. Manage upload or download tasks

You can call `cancelMediaUpload` or `cancelMediaDownload` to cancel an upload or download task. You also can use the `onMediaUploadingProgress` callback or the `onMediaDownloadingProgress` callback to return upload or download progress.

**Improvements**

The call limits of the following operations have increased. See [RTM limitations](/en/Real-time-Messaging/limitations_java?platform=Android&versionId=18f892c0-ac7b-11ea-aa07-c5bcc14a9a95). 

| Operation                                 | Call limit increase                                          |
| :---------------------------------------- | :----------------------------------------------------------- |
| Send peer-to-peer or channel messages     | From 180 calls every three seconds to 300 calls every three seconds |
| Query user online status                  | From 10 calls every five seconds to 20 calls every five seconds |
| Add, delete, or update user attributes    | From 10 calls every five seconds to 20 calls every five seconds |
| Query user attributes                     | From 40 calls every five seconds to 80 calls every five seconds |
| Add, delete, or update channel attributes | From 10 calls every five seconds to 20 calls every five seconds |
| Query channel attributes                  | From 10 calls every five seconds to 80 calls every five seconds |


**Fixed issues**

- Login failure caused by the SDK's incorrect identification of user's network type.
- Other problems that may cause the system to crash.

**API changes**

#### New methods

- [`createFileMessageByMediaId`](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/v1.3.0/classio_1_1agora_1_1rtm_1_1_rtm_client.html?transId=891f74d0-ac51-11ea-aa07-c5bcc14a9a95#ae4104179072ed6ebcf050d12250c7a1b)
- [`createImageMessageByMediaId`](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/v1.3.0/classio_1_1agora_1_1rtm_1_1_rtm_client.html?transId=891f74d0-ac51-11ea-aa07-c5bcc14a9a95#aaa3e2556fc93af882fd2758419c682af)
- [`createFileMessageByUploading`](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/v1.3.0/classio_1_1agora_1_1rtm_1_1_rtm_client.html?transId=891f74d0-ac51-11ea-aa07-c5bcc14a9a95#a1b08207278d611e5e4b87e6d9712e0c7)
- [`createImageMessageByUploading`](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/v1.3.0/classio_1_1agora_1_1rtm_1_1_rtm_client.html?transId=891f74d0-ac51-11ea-aa07-c5bcc14a9a95#afc93fad7700593a803ddbc87482c0ac0)
- [`downloadMediaToMemory`](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/v1.3.0/classio_1_1agora_1_1rtm_1_1_rtm_client.html?transId=891f74d0-ac51-11ea-aa07-c5bcc14a9a95#a3d2568cc940dfd8c8110e70dcc4fb85d)
- [`downloadMediaToFile`](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/v1.3.0/classio_1_1agora_1_1rtm_1_1_rtm_client.html?transId=891f74d0-ac51-11ea-aa07-c5bcc14a9a95#a34e0bd19fb0bbd1d91dec0a1af100038)
- [`cancelMediaUpload`](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/v1.3.0/classio_1_1agora_1_1rtm_1_1_rtm_client.html?transId=891f74d0-ac51-11ea-aa07-c5bcc14a9a95#a17467b5b336a39bc0d29058244aa7c0c)
- [`cancelMediaDownload`](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/v1.3.0/classio_1_1agora_1_1rtm_1_1_rtm_client.html?transId=891f74d0-ac51-11ea-aa07-c5bcc14a9a95#a21af4c790dcb6547253ffd43114696a5)

#### New callbacks

- [`onImageMessageReceived`](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/v1.3.0/interfaceio_1_1agora_1_1rtm_1_1_rtm_channel_listener.html?transId=891f74d0-ac51-11ea-aa07-c5bcc14a9a95#aa5e74313bc9c7a47e2e877690bbd5b8d)
- [`onFileMessageReceived`](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/v1.3.0/interfaceio_1_1agora_1_1rtm_1_1_rtm_channel_listener.html?transId=891f74d0-ac51-11ea-aa07-c5bcc14a9a95#a0d6889ad993ae6e99edaa1d05e67ba77)
- [`onImageMessageReceivedFromPeer`](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/v1.3.0/interfaceio_1_1agora_1_1rtm_1_1_rtm_client_listener.html?transId=891f74d0-ac51-11ea-aa07-c5bcc14a9a95#a9cdc9016e7b3349d8340318411852ccf)
- [`onFileMessageReceivedFromPeer`](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/v1.3.0/interfaceio_1_1agora_1_1rtm_1_1_rtm_client_listener.html?transId=891f74d0-ac51-11ea-aa07-c5bcc14a9a95#a812843550667e2e13068d4715d2fa98b)
- [`onMediaUploadingProgress`](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/v1.3.0/interfaceio_1_1agora_1_1rtm_1_1_rtm_client_listener.html?transId=891f74d0-ac51-11ea-aa07-c5bcc14a9a95#ad54b344caf11bcbfb086a15e96fbb9f2)
- [`onMediaDownloadingProgress`](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/v1.3.0/interfaceio_1_1agora_1_1rtm_1_1_rtm_client_listener.html?transId=891f74d0-ac51-11ea-aa07-c5bcc14a9a95#a1f774858444cc9b36369cbee4770df9c)


#### Deprecated methods

[`sendMessage (RtmMessage message, ResultCallback<Void> resultCallback)`](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/v1.3.0/classio_1_1agora_1_1rtm_1_1_rtm_channel.html?transId=891f74d0-ac51-11ea-aa07-c5bcc14a9a95#a57087adf4227a17c774ea292840148a0) is deprecated. Use [`sendMessage (RtmMessage message, SendMessageOptions options, ResultCallback<Void> resultCallback)`](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/v1.3.0/classio_1_1agora_1_1rtm_1_1_rtm_channel.html?transId=891f74d0-ac51-11ea-aa07-c5bcc14a9a95#a6e16eb0e062953980a92e10b0baec235) instead.

## v1.2.2

$$ 284398f0-1b4a-11ea-8fc3-cf882a952d6b
{
  "platform": "Linux Java"
}
$$

## v1.2.1

$$ b3810d10-20b5-11ea-b338-f1556ea7fcbf
{
  "platform": "Linux Java"
}
$$

## v1.2.0 

v1.2.0 was released on November 6, 2019. 

**New Features**

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
 
**Issues Fixed**
 
 - The system returns `rtm native not ready`, if one creates multiple channels with the same `channelId` and then calls `join` or `leave`. 

## v1.1.0

v1.1.0 was released on October 14, 2019. It adds the following features: 

- [Gets the member count of specified channel(s).](#getcount)
- [Automatically returns the latest numer of members in the current channel](#oncount)
- [Channel attribute operations](#channelattributes)



**Compatibility Changes**

1. Deprecates the [sendMessageToPeer](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/classio_1_1agora_1_1rtm_1_1_rtm_client.html#a25ab5c0126e1dc51c78b2b705de68b7a) method, and uses [sendMessageToPeer(const char \*, const IMessage \*, const SendMessageOptions \&)](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/classio_1_1agora_1_1rtm_1_1_rtm_client.html#a729079805644b3307297fb2e902ab4c9) instead.
2. The [getServerReceivedTs](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/classio_1_1agora_1_1rtm_1_1_rtm_message.html#a7994de6da26269c3137e93ddf7a2c2be) method of the [RtmMessage](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/classio_1_1agora_1_1rtm_1_1_rtm_message.html) object supports both peer-to-peer and channel messages. 
3. Timeout for sending a peer-to-peer message is 10 seconds from this release, compared to 5 seconds in previous versions. See [PEER_MESSAGE_ERR_TIMEOUT ](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/interfaceio_1_1agora_1_1rtm_1_1_rtm_status_code_1_1_peer_message_error.html#a9aaaa5b9fa46cc15327abd6c2825bc4d).
4. Puts a limit on the frequency of  [join](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/classio_1_1agora_1_1rtm_1_1_rtm_channel.html#ad7b321869aac2822b3f88f8c01ce0d40) the same channel: [Two times every five seconds](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/interfaceio_1_1agora_1_1rtm_1_1_rtm_status_code_1_1_join_channel_error.html#a2040b572e1ef4f593f234a20c84a22c7).

**New Features**

<a name="getcount"></a>
#### 1. Gets the member count of specified channel(s).

You can now get the member count of specified channel(s) without the need to join, by calling the [getChannelMemberCount](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/classio_1_1agora_1_1rtm_1_1_rtm_client.html#aff0384f2a004ed75498e20e1917352e4) method. You can get the member counts of a maximum of 32 channels in one method call. 

<a name="oncount"></a>
#### 2. Automatically returns the latest numer of members in the current channel 

If you are already in a channel, you do not have to call the `getChannelMemberCount` method to get the member count of the current channel. We also do not recommend using `onMemberJoined` and `onMemberLeft` to keep track of the member counts. As of this release, the SDK returns to the channel members [onMemberCountUpdated](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/interfaceio_1_1agora_1_1rtm_1_1_rtm_channel_listener.html#ad778e702e026a79460f45a992bb8576d) the latest channel member count when the number of channel members changes. Note that:

- When the number of channel members ≤ 512, the SDK returns this callback when the number changes and at a MAXIMUM speed of once per second.
- When the number of channel members exceeds 512, the SDK returns this callback when the number changes and at a MAXIMUM speed of once every three seconds.

> Please treat this callback and the [getMembers](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/classio_1_1agora_1_1rtm_1_1_rtm_channel.html#a567aca5f866cf71c3b679ae09b4bf626) method separately: 
> - The former is an active callback. It returns the current numer of channel members;
> - The latter relies on the [onSuccess](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/interfaceio_1_1agora_1_1rtm_1_1_result_callback.html#a7206b30500655c4a73d146acf50cb6f5) callback to return a member list of the current channel. If the number of channel members exceeds 512, the SDK only returns a list of 512 randomly-selected channel members. 

<a name="channelattributes"></a>
#### 3. Channel attribute operations

Supports setting or getting the attribute(s) of a specified channel. You can use this feature to create group anouncement.

Each channel attribute comes as a key-value pair. See [RtmChannelAttribute](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/classio_1_1agora_1_1rtm_1_1_rtm_channel_attribute.html) for more information. Where: 

- The key of each channel attribute must be visible characters and not exceed 8 KB.
- Each channel attribute must not exceed 8 KB in length. 
- The overall size of the attributes of a channel must not exceed 32 KB. 
- The number of attributes of a channel must not exceed 32. 

Specific features: 

- Sets the attributes of a specified channel with new ones.
- Adds or updates the attribute(s) of a specified channel.
- Deletes the attributes of a specified channel by attribute keys.
- Clears all attributes of a specified channel.
- Gets all attributes of a specified channel.
- Gets the attributes of a specified channel by attribute keys.

When updating attributes of a channel, you can use the  [setEnableNotificationToChannelMembers](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/classio_1_1agora_1_1rtm_1_1_channel_attribute_options.html#a2f240727791b3ad1af97f4a399ce1579) flag to decide whether or not to notify all members of the channel about this attribute change. 

> The SDK caches the channel attributes. If multiple users have the privilege to update the channel attributes, then we recommend calling the [getChannelAttributes](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/classio_1_1agora_1_1rtm_1_1_rtm_client.html#a81f14a747a4012815ab4ba8d9e480fb6) to update the cache before updating the channel attributes. 

**Improvements**

#### Resends peer-to-peer messages

This release improves the resending mechanism of peer-to-peer messages, and extends the timeout for sending a peer-to-peer message from five to 10 seconds, greatly improving the success rate of peer-to-peer message sending under weak network conditions. 

#### Caches channel messages

The Agora RTM system will resend a maximum of 32 channel messages of up to 30 seconds to channel members, when they manage to reconnect to the system from poor network conditions. This greatly improves the overall arrival rate of channel messages under weak network conditions. 


**API Changes**

#### Added Methods

- [setChannelAttributes](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/classio_1_1agora_1_1rtm_1_1_rtm_client.html#ad25f51a3671db50e348ec6c170044ec6): Sets the attributes of a specified channel with new ones.
- [addOrUpdaeChannelAttributes](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/classio_1_1agora_1_1rtm_1_1_rtm_client.html#a765b186d62ed3ef6d67a5e875b040875): Adds or updates the attribute(s) of a specified channel.
- [deleteChannelAttributesByKeys](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/classio_1_1agora_1_1rtm_1_1_rtm_client.html#a2477533989c1bb9ced831af210f1dba4): Deletes the attributes of a specified channel by attribute keys.
- [clearChannelAttributes](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/classio_1_1agora_1_1rtm_1_1_rtm_client.html#ae0c6c5c5bae6020e69009441d8a41785): Clears all attributes of a specified channel.
- [getChannelAttributes](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/classio_1_1agora_1_1rtm_1_1_rtm_client.html#a81f14a747a4012815ab4ba8d9e480fb6): Gets all attributes of a specified channel.
- [getChannelAttributesByKeys](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/classio_1_1agora_1_1rtm_1_1_rtm_client.html#a3b927c35cca5ebd31afb976d60e99193): Gets the attributes of a specified channel by attribute keys.
- [getChannelMemberCount](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/classio_1_1agora_1_1rtm_1_1_rtm_client.html#aff0384f2a004ed75498e20e1917352e4): Gets the member count of specified channel(s).

#### Added Callbacks

- [onAttributesUpdated](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/interfaceio_1_1agora_1_1rtm_1_1_rtm_channel_listener.html#a2904a1f1f78c497b9176fffb853be96f): Returns all attributes of the channel when the channel attributes are updated. 
- [onMemberCountUpdated](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/interfaceio_1_1agora_1_1rtm_1_1_rtm_channel_listener.html#ad778e702e026a79460f45a992bb8576d): Occurs when the number of the channel members changes, and returns the new number.

#### Added Error Codes 

- [GetChannelMemberCountErrCode](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/interfaceio_1_1agora_1_1rtm_1_1_rtm_status_code_1_1_get_channel_member_count_err_code.html): Error codes related to retrieving the channel member count of specified channel(s).
- [JOIN_CHANNEL_ERR_JOIN_SAME_CHANNEL_TOO_OFTEN](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/interfaceio_1_1agora_1_1rtm_1_1_rtm_status_code_1_1_join_channel_error.html#a2040b572e1ef4f593f234a20c84a22c7): The frequency of joining the same channel exceeds two times every five seconds.

#### Deprecated Methods

- [sendMessageToPeer](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/classio_1_1agora_1_1rtm_1_1_rtm_client.html#a25ab5c0126e1dc51c78b2b705de68b7a): Replaced by the [sendMessageToPeer(const char \*, const IMessage \*, const SendMessageOptions \&)](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/classio_1_1agora_1_1rtm_1_1_rtm_client.html#a729079805644b3307297fb2e902ab4c9) method. 

#### Deprecated Error Codes

- [ATTRIBUTE_OPERATION_ERR_NOT_READY](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/interfaceio_1_1agora_1_1rtm_1_1_rtm_status_code_1_1_attribute_operation_error.html#ac6a33aef7c62a132ba79630219d548a7): Replaced by [ATTRIBUTE_OPERATION_ERR_USER_NOT_LOGGED_IN](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/interfaceio_1_1agora_1_1rtm_1_1_rtm_status_code_1_1_attribute_operation_error.html#a9f329760056976289e49ad1dc69c598f).

## v1.0.1

v1.0.1 was released on August 1st, 2019. 

**Issues Fixed**

- When the connection to the Agora RTM system is interrupted, the SDK does not return the `onConnectionStateChanged` callback. 

## v1.0.0

v1.0.0 was released on July 24th, 2019.

**New Features**

#### Interconnects with the legacy Agora Signaling SDK

v1.0.0 implements the `LocalInvitation.setChannelId` and `LocalInvitation.getChannelId` methods. 

> - To intercommunicate with the legacy Agora Signaling SDK, you MUST set the channel ID. However, even if the callee successfully accepts the call invitation, the Agora RTM SDK does not join the channel of the specified channel ID.
> - If your App does not involve the legacy Agora Signaling SDK, we recommend using the `LocalInvitation.setContent` method or the `RemoteInvitation.setResponse` method to set customized contents. 

#### Specifies the default path to the SDK log file

Supports changing the default path to the SDK log file using the `setLogFile` method. To avoid creating an incomplete log file, we recommend calling this method once you have created and initialized an `RtmClient` instance. 



#### Sets the output log level of the SDK

Supports setting the output log level of the SDK using the `setLogFilter` method.  The log level follows the sequence of OFF, CRITICAL, ERROR, WARNING, and INFO. Choose a level to see the logs preceding that level. If, for example, you set the log level to WARNING, you see the logs within levels CRITICAL, ERROR, and WARNING. 

> You can call this method once you have created and initializd an `RtmClient` instance. You do not have to call this method after calling the `login` method. 

#### Sets the log file size in KB

Supports setting the log file size using the `setLogFileSize` method. The log file has a default size of 512 KB. File size settings of less than 512 KB or greater than 10 MB will not take effect.


> You can call this method once you have created and initializd an `RtmClient` instance. You do not have to call this method after calling the `login` method. 

**Improvements**

Adds error codes based on the following scenarios: 

- The Agora RTM service is not initialized.
- The method call frequency exceeds the limit. 
- The user does not call the `login` method or the method call of `login` does not succeed before calling any of the RTM core APIs. 

**Issues Fixed**

- One can log in the Agora RTM system with a static App ID and an RTM token, which is generated from a dynamic App ID. 


**API Changes**

- [setLogFile](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/classio_1_1agora_1_1rtm_1_1_rtm_client.html#ad44bd79d005d25c68712cc35d16d934b): Specifies the default path to the SDK log file.
- [setLogFilter](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/classio_1_1agora_1_1rtm_1_1_rtm_client.html#a6726b3a3eafee4528280d3b0d1c6316f): Sets the output log level of the SDK.
- [setLogFileSize](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/classio_1_1agora_1_1rtm_1_1_rtm_client.html#a85a6365227adc43f8c3e07042dec6723): Sets the log file size in KB.
- [getSdkVersion](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/classio_1_1agora_1_1rtm_1_1_rtm_client.html#af3cc54b4d456a67d912786f61619c065): Gets the SDK version.




## v0.9.3

v0.9.3 was released on June 7th, 2019.

**New Features**

#### Sends an (offline) peer-to-peer message to a specified user (receiver)

This version allows you to send a message to a specified user when he/she is offline. If you set a message as an offline message and the specified user is offline when you send it, the RTM server caches it. Please note that for now we only cache 200 offline messages for up to seven days for each receiver. When the number of the cached messages reaches this limit, the newest message overrides the oldest one.


#### User attribute-related operations

This version allows you to set or update a user's attributes. You can:

- Substitutes the local user's attributes with new ones.
- Adds or updates the local user's attribute(s).
- Deletes the local user's attributes using attribute keys.
- Clears all attributes of the local user.
- Gets all attributes of a specified user.
- Gets the attributes of a specified user using attribute keys.

> - Only after you successfully loggin in the Agora RTM system can you execute user attribute-related operations. Otherwise, the SDK triggers the `ATTRIBUTE_OPERATION_ERR_NOT_READY` error code.
> - The attributes you set will be clears when you log out of the RTM system.
> - You can only set a maximum of 16 KB attributes in a single method call. Otherwise, the SDK triggers the `ATTRIBUTE_OPERATION_ERR_SIZE_OVERFLOW` error code. 

**Improvements**

- Supports creating an RTM channel before logging in the Agora RTM system. 
- Supports creating multiple RTM channels. But a user can only join a maximum of 20 RTM channels at the same time. When the number of the joined channels exceeds 20, the SDK triggers the `JOIN_CHANNEL_ERR_FAILURE` error code. 

**Issues Fixed**

- Occasional system crashes.
- A user who has logged out of the Agora RTM system appears online to the other users until 30 seconds later. 

## v0.9.2 

v0.9.2 was released on May 5th, 2019.

**New Features**

#### Queries the Online Status of the Specified Users

This release introduces a new concept: online and offline. 

- Online: The user has logged in the Agora RTM system. 
- Offline: The user has logged out of the Agora RTM system. 

This release adds the function of querying the online status of the specified users. After logging in the Agora RTM system, you can get the online status of a maximum of 256 specified users. See [queryPeersOnlineStatus](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/classio_1_1agora_1_1rtm_1_1_rtm_client.html#ac711f981405648ed5ef1cb07436125f3).

> - The sequence of the returned user IDs is identical to the input sequence. 
> - The call frequency of this method is 10 queries every five seconds. See [Limitations](/en/Real-time-Messaging/RTM_limitations_ios?platform=Android&versionId=27172500-6ef2-11e9-bc89-c55471d1fc24).

#### Renews the Token

In the production environment, you need to use a token to [log in](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/classio_1_1agora_1_1rtm_1_1_rtm_client.html#a995bb1b1bbfc169ee4248bd37e67b24a) the Agora RTM system. Each token expires 24 hours after it is created. This release allows you to [renew a token](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/classio_1_1agora_1_1rtm_1_1_rtm_client.html#a9a6d33282509384165709107d7a89353).

- If you are logging in the Agora RTM system and if your token has expired, the SDK returns the [LOGIN_ERR_TOKEN_EXPIRED](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/interfaceio_1_1agora_1_1rtm_1_1_rtm_status_code_1_1_login_error.html#a4a15940de40fe029ba9821e406f3d875) error code. 
- if you are logged in the Agora RTM system, you will not be kicked out immediately when your token expires. But you need to renew your token the next time you log in the Agora RTM system. Therefore, we still recommend that you renew your token when receiving the [onTokenExpired](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/interfaceio_1_1agora_1_1rtm_1_1_rtm_client_listener.html#aef74f37ed8797d274115d7f13785134e) callback.

> - The [renewToken](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/classio_1_1agora_1_1rtm_1_1_rtm_client.html#a9a6d33282509384165709107d7a89353) method must be called before [creating an RtmClient](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/classio_1_1agora_1_1rtm_1_1_rtm_client.html#a6411640143c4d0d0cd9481937b754dbf).
> - The call freqency of the `RenewToken` method is two queries every second. See [Limitations](/en/Real-time-Messaging/RTM_limitations_ios?platform=Android&versionId=27172500-6ef2-11e9-bc89-c55471d1fc24).

**Improvements**

- Supports a `userId` that starts with a space.

**API Changes**

#### Queries the Online Status of the Specified Users

##### Adds

- Method: [queryPeersOnlineStatus](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/classio_1_1agora_1_1rtm_1_1_rtm_client.html#ac711f981405648ed5ef1cb07436125f3)
- Error Code: [QueryPeersOnlineStatusError](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/interfaceio_1_1agora_1_1rtm_1_1_rtm_status_code_1_1_query_peers_online_status_error.html)

#### Renews the Token

##### Adds

- Method: [renewToken](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/classio_1_1agora_1_1rtm_1_1_rtm_client.html#a9a6d33282509384165709107d7a89353)
- Callback: [onTokenExpired](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/interfaceio_1_1agora_1_1rtm_1_1_rtm_client_listener.html#aef74f37ed8797d274115d7f13785134e)
- Error Codes: 
  - [RenewTokenError](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/interfaceio_1_1agora_1_1rtm_1_1_rtm_status_code_1_1_renew_token_error.html)

#### Call Invitation

Adds the following error code for when a user sends a call invitation without logging in the Agora RTM system. 

- [LOCAL_INVITATION_ERR_NOT_LOGGEDIN](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/interfaceio_1_1agora_1_1rtm_1_1_rtm_status_code_1_1_local_invitation_error.html#aa717afb5d4809544e6d66e1c0538f2eb)

## v0.9.1

v0.9.1 was released on April 4th, 2019.

**New Features**

This release adds the call invitation feature, allowing you to create, send, cancel, accept, and decline a call invitation in a one-to-one or one-to-many voice/video call. 

**Improvements**

- Optimizes the object relations to facilitate understanding.
- Renames some interfaces to conform to Java naming conventions. 
- Removes `ChannelMessageState` and `PeerMessageState` to simplify the process of sending a channel or peer-to-peer message. Uses `ChannelMessageError` and `PeerMessageError` instead. 
- Removes `IStateListener` for listening to message states. Uses the generic `ResultCallback` instead.

**API Changes**

#### Adds

- [LocalInvitation.setContent()](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/interfaceio_1_1agora_1_1rtm_1_1_local_invitation.html#a4cec28ff6d356242329b1034c7531445): allows the caller to set the content of an outgoing call invitation.
- [LocalInvitation.getContent()](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/interfaceio_1_1agora_1_1rtm_1_1_local_invitation.html#a97294ce1b9b591f9d93e497869b1ad90): allows the caller to retrieve the content of an outgoing call invitation. 
- [LocalInvitation.getResponse()](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/interfaceio_1_1agora_1_1rtm_1_1_local_invitation.html#a268c738458538a266d440b0e281328ee): allows the caller to retrieve the response set by the callee.
- [LocalInvitation.getState()](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/interfaceio_1_1agora_1_1rtm_1_1_local_invitation.html#a59608fbac8050f17ec0f855f28598d20): allows the caller to retrieve the state of an outgoing call invitation. 
- [RemoteInvitation.getCallerId()](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/interfaceio_1_1agora_1_1rtm_1_1_remote_invitation.html#ae38c5740aa9edb09749f0febb2663926): allows the callee to retrieve the user ID of the caller.
- [RemoteInvitation.getContent()](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/interfaceio_1_1agora_1_1rtm_1_1_remote_invitation.html#aeca3b3e981c69c44c7a618d4fdfb3b87): allows the callee to retrieve the content set by the caller. 
- [RemoteInvitation.setResponse()](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/interfaceio_1_1agora_1_1rtm_1_1_remote_invitation.html#a229b8cf773eaa0e79b0d67815fd6b6f1): allows the callee to set the response to the caller. 
- [RemoteInvitation.getResponse()](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/interfaceio_1_1agora_1_1rtm_1_1_remote_invitation.html#a12a70e7d8a77eee21d37bbb65b2f9d3e): allows the callee to retrieve the response to the caller.
- [RemoteInvitation.getState()](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/interfaceio_1_1agora_1_1rtm_1_1_remote_invitation.html#af77a4afabb19ff1468edf29720361a0f): allows the callee to retrieve the state of the incoming call invitation
- [RtmCallEventListener.onLocalInvitationReceivedByPeer()](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/interfaceio_1_1agora_1_1rtm_1_1_rtm_call_event_listener.html#a24e1cb71d3e752963da49bdf91847788): occurs when the callee receives the call invitation. 
- [RtmCallEventListener.onLocalInvitationAccepted()](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/interfaceio_1_1agora_1_1rtm_1_1_rtm_call_event_listener.html#a4dece02a62a187a66c2415fecf6b75dc): occurs when the callee accepts the call invitation. 
- [RtmCallEventListener.onLocalInvitationRefused()](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/interfaceio_1_1agora_1_1rtm_1_1_rtm_call_event_listener.html#a6224643c400268d356cb5d489825bdd0): occurs when the callee declines the call invitation. 
- [RtmCallEventListener.onLocalInvitationCanceled()](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/interfaceio_1_1agora_1_1rtm_1_1_rtm_call_event_listener.html#ae3164e81772cd4d6171165b1705adcaa): occurs when the caller cancels the call invitation. 
- [RtmCallEventListener.onLocalInvitationFailure()](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/interfaceio_1_1agora_1_1rtm_1_1_rtm_call_event_listener.html#acfefb97eaca497cbd71a0c1cbf5067b0): occurs when the outgoing call invitation fails. 
- [RtmCallEventListener.onRemoteInvitationReceived()](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/interfaceio_1_1agora_1_1rtm_1_1_rtm_call_event_listener.html#a8d01498a993c4016aa45ccb9bf4e9097): occurs when the callee receives a call invitation. 
- [RtmCallEventListener.onRemoteInvitationAccepted()](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/interfaceio_1_1agora_1_1rtm_1_1_rtm_call_event_listener.html#a81d9d3de89d08c41408d8a94c8309d29): occurs when the callee accepts a call invitation. 
- [RtmCallEventListener.onRemoteInvitationRefused()](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/interfaceio_1_1agora_1_1rtm_1_1_rtm_call_event_listener.html#a7a21eaa9ff49bcf39e3c49b94f6e6ac7): occurs when the callee declines a call invitation. 
- [RtmCallEventListener.onRemoteInvitationCanceled()](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/interfaceio_1_1agora_1_1rtm_1_1_rtm_call_event_listener.html#a9d0409c87455d4d2b1315f67a5f7aa12): occurs when the caller cancels the call invitation. 
- [RtmCallEventListener.onRemoteInvitationFailure()](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/interfaceio_1_1agora_1_1rtm_1_1_rtm_call_event_listener.html#a6f9f2bbbfbcb0a766c6f1b2e4a8314a1): occurs when the incoming call invitation fails. 
- [RtmCallManager.setEventListener()](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/classio_1_1agora_1_1rtm_1_1_rtm_call_manager.html#a934eee4922584707a1a7ef9ac6999cf2): sets the event listener to the `RtmCallManager` instance. 
- [RtmCallManager.createLocalInvitation()](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/classio_1_1agora_1_1rtm_1_1_rtm_call_manager.html#a1756dca077267acaa407c6901daa2248): creates a call invitation. 
- [RtmCallManager.sendLocalInvitation()](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/classio_1_1agora_1_1rtm_1_1_rtm_call_manager.html#af899697061305ca840e829b92c78e353): sends a call invitation to a specified user. 
- [RtmCallManager.acceptRemoteInvitation()](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/classio_1_1agora_1_1rtm_1_1_rtm_call_manager.html#a5f6f97c84e426e2fbd8a5dda71e2fc6c): accepts an incoming call invitation. 
- [RtmCallManager.refuseRemoteInvitation()](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/classio_1_1agora_1_1rtm_1_1_rtm_call_manager.html#a2ce4af944183976d18c055816f756bf6): declines an incoming call invitation. 
- [RtmCallManager.cancelLocalInvitation()](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/classio_1_1agora_1_1rtm_1_1_rtm_call_manager.html#a5f03bfe1cfd6987fbc7b5a4dc484f564): allows the caller to cancel an outgoing call invitation. 
- [RtmStatusCode#LocalInvitationState](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/interfaceio_1_1agora_1_1rtm_1_1_rtm_status_code_1_1_local_invitation_state.html): states of an outgoing call invitation.
- [RtmStatusCode#RemoteInvitationState](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/interfaceio_1_1agora_1_1rtm_1_1_rtm_status_code_1_1_remote_invitation_state.html): states of an incoming call invitation. 
- [RtmStatusCode#LocalInvitationError](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/interfaceio_1_1agora_1_1rtm_1_1_rtm_status_code_1_1_local_invitation_error.html): error codes of an outgoing call invitation. 
- [RtmStatusCode#RemoteInvitationError](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/interfaceio_1_1agora_1_1rtm_1_1_rtm_status_code_1_1_remote_invitation_error.html): error codes of an incoming call invitation. 
- [RtmStatusCode#InvitationApiCallError](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/interfaceio_1_1agora_1_1rtm_1_1_rtm_status_code_1_1_invitation_api_call_error.html): error codes of the invitation-specific API calls. 
- [ConnectionChangeReason#CONNECTION_CHANGE_REASON_REMOTE_LOGIN](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/interfaceio_1_1agora_1_1rtm_1_1_rtm_status_code_1_1_connection_change_reason.html): another instance has logged in the Agora RTM system with the same user ID. 

#### Renames

- The `RtmClient.destroy()` method, which releases all resources used by the `RtmClient` instance, to: [RtmClient.release()](/API%20Reference/RTM_java_linux/classio_1_1agora_1_1rtm_1_1_rtm_client.html#a5147d00d14afeebf0926b0d2f01079f5).
- The `IResultCallback` class to: [ResultCallback](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/interfaceio_1_1agora_1_1rtm_1_1_result_callback.html)

#### Deletes

- Deletes `PEER_MESSAGE_RECEIVED_BY_SERVER` from [PeerMessageError](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/interfaceio_1_1agora_1_1rtm_1_1_rtm_status_code_1_1_peer_message_error.html), uses `PEER_MESSAGE_ERR_OK` instead.
- Deletes `CHANNEL_MESSAGE_RECEIVED_BY_SERVER` from [ChannelMessageError](/API%20Reference/RTM_java_linux/interfaceio_1_1agora_1_1rtm_1_1_rtm_status_code_1_1_channel_message_error.html), uses `CHANNEL_MESSAGE_OK` instead.
- Deletes the `PeerMessageState` interface, uses [PeerMessageError](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/interfaceio_1_1agora_1_1rtm_1_1_rtm_status_code_1_1_peer_message_error.html) instead. 
- Deletes the `ChannelMessageState` interface, uses [ChannelMessageError](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/interfaceio_1_1agora_1_1rtm_1_1_rtm_status_code_1_1_channel_message_error.html) instead.
- Deletes the `IStateListener` class for listening to message states, uses the [ResultCallback](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/interfaceio_1_1agora_1_1rtm_1_1_result_callback.html) class instead for listening to the peer or channel message results.
  - Success: the SDK returns the [ResultCallback.onSuccess()](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/interfaceio_1_1agora_1_1rtm_1_1_result_callback.html#a7206b30500655c4a73d146acf50cb6f5) callback.
  - Failure: the SDK returns the [ResultCallback.onFailure()](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/interfaceio_1_1agora_1_1rtm_1_1_result_callback.html#a1f9145a3eb119e32cfc0afa938062396) callback with the corresponding error codes.

## v0.9.0

v0.9.0 was released on February 4th, 2019.

Initial version. 

Key features:

- Sends or receives peer-to-peer messages.
- Joins or leaves a channel.
- Sends or receives channel messages.