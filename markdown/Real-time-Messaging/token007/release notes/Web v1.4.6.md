## v1.4.6

v1.4.6 was released on July 20, 2022.

#### Upgrade features

**AccessToken2**

As of this release, the authentication mechanism of RTM is upgraded from AccessToken to AccessToken2. Both types of tokens are supported at the same time and can work in tandem with each other.

<div class="alert note"><li>If you are new to RTM, Agora recommends that you use the latest release and deploy the App server and client for AccessToken2 step by step according to <a href="https://docs.agora.io/en/Real-time-Messaging/token_server_rtm">RTM Token</a>.<li>If you have already deployed AccessToken in a previous release, you can quickly upgrade to AccessToken2 by referring <a href="https://docs.agora.io/en/Real-time-Messaging/token_server_rtm#upgrade">Upgrade to AccessToken2</a>.</div>

AccessToken2 allows users to specify the validity period of an RTM token. The validity period can be a maximum of 24 hours. This release also adds the `TokenPrivilegeWillExpire` callback, which is triggered when a token is due to expire in 30 seconds. Upon receiving this callback, you can generate a new RTM token on your server and pass the new RTM token to the SDK; otherwise, the connection state of the SDK switches from connected to aborted due to `TOKEN_EXPIRED (9)`. For details, see [RTM Token expiration](./token_server_rtm#rtm-token-expiration).

#### Bug fixes

This release fixed the unit of timeout in output logs from milliseconds (ms) to seconds (s).

#### API changes

**Added**  
- `TokenPrivilegeWillExpire`
- `TOKEN_EXPIRED (9)` in the `ConnectionChangeReason` structure

## v1.4.5

v1.4.5 was released on May 31, 2022.

#### Improvements

This release improved the following issues:

- When the call frequency of `subscribePeersOnlineStatus` exceeds the limit of 10 calls every five seconds, the SDK returns the `PEER_SUBSCRIPTION_STATUS_ERR_TOO_OFTEN (5)` error.
- When the number of subscribed peers exceeds the limit of 512, the SDK returns the `PEER_SUBSCRIPTION_STATUS_ERR_OVERFLOW (6)` error.

#### Fixes

This release fixed an issue where the Agora RTM Web SDK could reconnect to the RTM system when the Safari browser or tab was running in the macOS background.


## v1.4.4
v1.4.4 was released on December 24, 2021.

Fixed an issue where the Agora RTM Web SDK could reconnect to the RTM system (with the connection status RECONNECTING) when the browser or tab was running in the background, if the RTM Web SDK was used in Chrome 88 or higher.

## v1.4.3
v1.4.3 was released on May 27, 2021.

#### Compatibility changes

**Firewall domain whitelist**

As of v1.4.3, the list of destination domains required for your firewall whitelist changes to the following:


- `.edge.agora.io`
- `.edge.sd-rtn.com`
- `web-1.ap.sd-rtn.com``
- `web-2.ap.sd-rtn.com`
- `ap-web-1.agora.io`
- `ap-web-2.agora.io`
- `webcollector-rtm.agora.io`
- `logservice-rtm.agora.io`
- `rtm.statscollector.sd-rtn.com`
- `rtm.logservice.sd-rtn.com`

If you upgrade the SDK to v1.4.3, update your firewall domain whitelist to ensure you can use Agora products in environments with restricted network access.

#### New features 

**Regional connection**

This release adds the `AgoraRTM.setArea` method for specifying the region for connection. After specifying the region, the SDK connects to the Agora servers within that region. The following regions are supported:

- Mainland China
- North America
- Europe
- Asia, excluding Mainland China
- Japan
- India
- Global

If you specify the region for connection as GLOBAL, you can use the excludeArea parameter in the AgoraRTM.setArea method to remove individual region from the regions for connection possibilities. 

#### API changes

**Added**

[`createInstance`](https://docs.agora.io/en/Real-time-Messaging/API%20Reference/RTM_web/modules/agorartm.html#createinstance)

**Deprecated**

`createInstance`. Use [`createInstance`](https://docs.agora.io/en/Real-time-Messaging/API%20Reference/RTM_web/modules/agorartm.html#createinstance) instead.

## v1.4.2

v1.4.2 was released on March 2, 2021.

#### Compatibility changes

**Behavioral changes**

- To better describe the behavior of the `setParameters` method in terms of naming, this version adds the `updateConfig` method, which is a duplicate of the `setParameters` method. The `updateConfig` method deprecates the `setParameters` method.
- When the size of `content` is greater than 8 KB, the `INVITATION_API_CALL_ERR_INVALID_ARGUMENT` error code is triggered when calling `send` instead of calling `setContent`.

**Integration changes**

- As of this version, you must include the [js-sha1](https://www.npmjs.com/package/js-sha1) library in order to use the SDK to upload files or images in Microsoft Edge legacy or Internet Explorer 11 by one of the following methods:
	- In the HTML file, expose js-sha1 to the global `sha1` variable:
	```html
	<script src="https://cdn.jsdelivr.net/npm/js-sha1@0.6.0/src/sha1.min.js"></script>
	```
	- Add the following line to the JS file:
	```javascript
	window.sha1 = require('js-sha1')
	```
- The `isHistoricalMessage` member variable is removed from the `ReceivedMessageProperties` object.

#### Improvements

- The size of the decompressed SDK decreases by about 20%.
- (SDK from NPM only) The TS file in the SDK adds the following exports:
	- `LocalInvitation`
	- `RemoteInvitation`
	- `RtmMessage`
	- `RtmRawMessage`
	- `RtmTextMessage`
	- `RtmFileMessage`
	- `RtmImageMessage`
- The SDK automatically adds the corresponding MIME type to the Blob type from `downloadMedia`. The SDK supports automatically detecting and adding the following MIME types:
	- image/png
	- image/gif
	- application/pdf
	- image/jpeg
	- application/zip

#### API changes

**Added**

[`updateConfig`](/en/Real-time-Messaging/API%20Reference/RTM_web/classes/rtmclient.html#updateconfig)

**Deprecated**

`setParameters`

**Removed**

`isHistoricalMessage` member variable in `ReceivedMessageProperties`

## v1.4.1

v1.4.1 was released on November 5, 2020.

**New features**

Fixed the performance issue when communicating with the RTM Native SDK.

## v1.4.0

v1.4.0 was released on September 25, 2020.

**Compatibility changes**

v1.4.0 supports only TypeScript 3.8 or higher.


**New features**

Geofencing. You can use the `areaCodes` parameter in `createInstance` to set the region of the Agora RTM SDK. The RTM SDK can only connect to Agora RTM servers within the specified region.


**API changes**

#### Added

The `areaCodes` parameter is added to  [`createInstance`](/en/Real-time-Messaging/API%20Reference/RTM_web/modules/agorartm.html#createinstance).


## v1.3.1

v1.3.1 was released on August 7, 2020.

**Fixed issues**

- Connection stability issue between the Agora RTM SDK and the Agora RTM system.
- The same offline message might be delivered multiple times.
- Login stability issue of the RTM SDK.
- Stability issue of sending and receiving peer-to-peer messages. 
- The [`TokenExpired`](/cn/Real-time-Messaging/API%20Reference/RTM_web/interfaces/rtmevents.rtmclientevents.html#tokenexpired) callback could not be triggered in time.


## v1.3.0

v1.3.0 was released on June 16, 2020.

**Compatibility changes**

- The Agora server blocks any file message or image message that you send to RTM SDK 1.2.2 or earlier, or to the Signaling SDK.
- The typical timeout for asynchronously calling a method changes from 5 seconds to 10 seconds.
- You need to add port 9601 to the TCP protocol of the firewall whitelist to support sending and receiving file or image messages. See [Firewall Requirements](https://docs.agora.io/en/Agora%20Platform/firewall?platform=All%20Platforms).

**New features**

#### 1. Send and receive file messages or image messages

You can call `createMediaMessageByUploading` to upload non-empty files or image files no greater than 30 MB. Each uploaded file or image stays in the Agora server for seven days. The SDK returns a media ID as the unique identifier of the file or image file. You can use the `RtmFileMessage` interface or the `RtmImageMessage` interface to save the media ID. The `RtmFileMessage` interface and the `RtmImageMessage` interface are type aliases of the `RtmMessage` interface, so you can send and receive file or image messages via peer-to-peer or channel message methods. You can call `downloadMedia` to download the received file or image file.

#### 2. Manage upload or download tasks

You can use the `mediaTransferHandler` interface to cancel or report the progress of an upload or download task.

**Fixed issues**

Fixed the login issues for some users.

**API changes**

#### Added

- [`createMediaMessageByUploading`](/en/Real-time-Messaging/API%20Reference/RTM_web/v1.3.0/classes/rtmclient.html?transId=6c56ba50-ac6c-11ea-aa07-c5bcc14a9a95#createmediamessagebyuploading) 
- [`downloadMedia`](/en/Real-time-Messaging/API%20Reference/RTM_web/v1.3.0/classes/rtmclient.html?transId=6c56ba50-ac6c-11ea-aa07-c5bcc14a9a95#downloadmedia) 
- [`createMessage`](/en/Real-time-Messaging/API%20Reference/RTM_web/v1.3.0/classes/rtmclient.html?transId=6c56ba50-ac6c-11ea-aa07-c5bcc14a9a95#createmessage) 
- [`RtmImageMessage`](/en/Real-time-Messaging/API%20Reference/RTM_web/v1.3.0/interfaces/rtmimagemessage.html?transId=6c56ba50-ac6c-11ea-aa07-c5bcc14a9a95) 
- [`RtmFileMessage`](/en/Real-time-Messaging/API%20Reference/RTM_web/v1.3.0/interfaces/rtmfilemessage.html?transId=6c56ba50-ac6c-11ea-aa07-c5bcc14a9a95) 
- [`mediaTransferHandler`](/en/Real-time-Messaging/API%20Reference/RTM_web/v1.3.0/interfaces/mediatransferhandler.html?transId=6c56ba50-ac6c-11ea-aa07-c5bcc14a9a95) 
- [`mediaOperationProgress`](/en/Real-time-Messaging/API%20Reference/RTM_web/v1.3.0/interfaces/mediaoperationprogress.html?transId=6c56ba50-ac6c-11ea-aa07-c5bcc14a9a95) 


## v1.2.2

v1.2.2 was released on February 21, 2020.

**Compatibility Changes**


| Timeout | Before v1.2.2 | v1.2.2 |
| ---------------- | ---------------- | ---------------- |
| Send a channel message.     | 5 s    | 10 s     |



**Issues fixed**

The SDK occasionally returns `LOGIN_ERR_UNKNOWN` when logging in from a recent version of Chrome on a Windows platform. 

## v1.2.1

$$ b3810d10-20b5-11ea-b338-f1556ea7fcbf
{
  "platform": "Web"
}
$$

## v1.2.0 

v1.2.0 was released on November 15, 2019. 

**New Features**

#### Subscribe to the online status of the specified user(s)

When the method call succeeds, the SDK returns the PeersOnlineStatusChanged callback to report the online status of peers, to whom you subscribe.
When the online status of the peers, to whom you subscribe, changes, the SDK returns the PeersOnlineStatusChanged callback to report whose online status has changed.
If the online status of the peers, to whom you subscribe, changes when the SDK is reconnecting to the server, the SDK returns the PeersOnlineStatusChanged callback to report whose online status has changed when successfully reconnecting to the server.

#### Unsubscribe from the online status of the specified user(s)

Allows you to unsubscribe from the online status of the specified user(s).

#### Get a list of the peers, to whose specific status you have subscribed

Allows you to get a list of the peers, to whose specific status you have subscribed.

#### Create a raw message

Creates and initializes a raw message to be sent.

 If you set a text description, ensure that the size of the raw message and the description combined does not exceed 32 KB.
 
**Issues fixed**
 
The SDK is occasionally kicked by the server: When the issue occurs, the Client instance receives the `ConnectionStateChange` callback, which indicates the connection state is `ABORTED` and the reason for the connection state change `INTERRUPTED`. The log file shows the error code from the server is 10001. 
 

## v1.1.0

v1.1.0 was released on September 18, 2019. It adds the following features: 

- [Gets the member count of specified channel(s).](#getcount)
- [Automatically returns the latest number of members in the current channel](#oncount)
- [Channel attribute operations](#channelattributes)



**Compatibility Changes**

1. The [getServerReceivedTs](/en/Real-time-Messaging/API%20Reference/RTM_java/classio_1_1agora_1_1rtm_1_1_rtm_message.html#a7994de6da26269c3137e93ddf7a2c2be) method of the [RtmMessage](/en/Real-time-Messaging/API%20Reference/RTM_java/classio_1_1agora_1_1rtm_1_1_rtm_message.html) object supports both peer-to-peer and channel messages. 
2. Timeout for sending a peer-to-peer message is 10 seconds from this release, compared to 5 seconds in previous versions. See [PEER_MESSAGE_ERR_TIMEOUT ](/en/Real-time-Messaging/API%20Reference/RTM_java/interfaceio_1_1agora_1_1rtm_1_1_rtm_status_code_1_1_peer_message_error.html#a9aaaa5b9fa46cc15327abd6c2825bc4d).

**New Features**

<a name="getcount"></a>
#### 1. Gets the member count of specified channel(s).

You can now get the member count of specified channel(s) without the need to join, by calling the `getChannelMemberCount` method. You can get the member counts of a maximum of 32 channels in one method call. 

<a name="oncount"></a>
#### 2. Automatically returns the latest number of members in the current channel 

If you are already in a channel, you do not have to call the `getChannelMemberCount` method to get the member count of the current channel. We also do not recommend using `onMemberJoined` and `onMemberLeft` to keep track of the member counts. As of this release, the SDK returns to the channel members `MemberCountUpdated` the latest channel member count when the number of channel members changes. Note that:

- When the number of channel members ≤ 512, the SDK returns this callback when the number changes and at a MAXIMUM speed of once per second.
- When the number of channel members exceeds 512, the SDK returns this callback when the number changes and at a MAXIMUM speed of once every three seconds.

<a name="channelattributes"></a>
#### 3. Channel attribute operations

Supports setting or getting the attribute(s) of a specified channel. You can use this feature to create group anouncement.

Each channel attribute comes as a key-value pair. See [RtmChannelAttribute](/en/Real-time-Messaging/API%20Reference/RTM_java/classio_1_1agora_1_1rtm_1_1_rtm_channel_attribute.html) for more information. Where: 

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

When updating attributes of a channel, you can use the  `enableNotificationToChannelMembers` flag to decide whether or not to notify all members of the channel about this attribute change.  

**Improvements**

#### Resends peer-to-peer messages

This release improves the resending mechanism of peer-to-peer messages, and extends the timeout for sending a peer-to-peer message from five to 10 seconds, greatly improving the success rate of peer-to-peer message sending under weak network conditions. 

#### Caches channel messages

The Agora RTM system will resend a maximum of 32 channel messages of up to 30 seconds to channel members, when they manage to reconnect to the system from poor network conditions. This greatly improves the overall arrival rate of channel messages under weak network conditions. 


**API Changes**

#### Added Methods

- [setChannelAttributes](/en/Real-time-Messaging/API%20Reference/RTM_web/classes/rtmclient.html#setchannelattributes): Sets the attributes of a specified channel with new ones.
- [addOrUpdaeChannelAttributes](/en/Real-time-Messaging/API%20Reference/RTM_web/v1.1.0/classes/rtmclient.html#addorupdatechannelattributes): Adds or updates the attribute(s) of a specified channel.
- [deleteChannelAttributesByKeys](/en/Real-time-Messaging/API%20Reference/RTM_web/v1.1.0/classes/rtmclient.html#deletechannelattributesbykeys): Deletes the attributes of a specified channel by attribute keys.
- [clearChannelAttributes](/en/Real-time-Messaging/API%20Reference/RTM_web/v1.1.0/classes/rtmclient.html#clearchannelattributes): Clears all attributes of a specified channel.
- [getChannelAttributes](/en/Real-time-Messaging/API%20Reference/RTM_web/v1.1.0/classes/rtmclient.html#getchannelattributes): Gets all attributes of a specified channel.
- [getChannelAttributesByKeys](/en/Real-time-Messaging/API%20Reference/RTM_web/v1.1.0/classes/rtmclient.html#getchannelattributesbykeys): Gets the attributes of a specified channel by attribute keys.
- [getChannelMemberCount](/en/Real-time-Messaging/API%20Reference/RTM_web/v1.1.0/classes/rtmclient.html#getchannelmembercount): Gets the member count of specified channel(s).

#### Added Callbacks

- [AttributesUpdated](/en/Real-time-Messaging/API%20Reference/RTM_java/interfaceio_1_1agora_1_1rtm_1_1_rtm_channel_listener.html#a2904a1f1f78c497b9176fffb853be96f): Returns all attributes of the channel when the channel attributes are updated. 
- [MemberCountUpdated](/en/Real-time-Messaging/API%20Reference/RTM_java/interfaceio_1_1agora_1_1rtm_1_1_rtm_channel_listener.html#ad778e702e026a79460f45a992bb8576d): Occurs when the number of the channel members changes, and returns the new number.

#### Added Error Codes 

- [GetChannelMemberCountErrCode](/en/Real-time-Messaging/API%20Reference/RTM_web/v1.1.0/enums/rtmerrorcode.getchannelmembercounterrcode.html): Error codes related to retrieving the channel member count of specified channel(s).
- [JOIN_CHANNEL_ERR_JOIN_SAME_CHANNEL_TOO_OFTEN](/en/Real-time-Messaging/API%20Reference/RTM_web/v1.1.0/enums/rtmerrorcode.joinchannelerror.html#join_channel_err_join_same_channel_too_often): The frequency of joining the same channel exceeds two times every five seconds.
- [JOIN_CHANNEL_ERR_ALREADY_JOINED_CHANNEL_OF_SAME_ID](/en/Real-time-Messaging/API%20Reference/RTM_web/enums/rtmerrorcode.joinchannelerror.html#join_channel_err_already_joined_channel_of_same_id): You have already joined another channel instance of the same channel ID. 







## v1.0.1

v1.0.1 was released on September 5, 2019. 

**Issues Fixed**

- Peer-to-peer messages have a chance to become offline messages even if [enableOfflineMessaging](/en/Real-time-Messaging/API%20Reference/RTM_web/interfaces/sendmessageoptions.html) is not set. 
- The local user has a chance of not being able to retrieve the latest user attributes of a remote user, if the remote user updates his/her attributes immediately after logging in the Agora RTM system. 

**Improvements**

- Caches up to six seconds of peer-to-peer messages sent when the network is interrupted, and resends the cached messages immediately after the SDK reconnects to the Agora RTM system. 
- Timeout for sending a peer-to-peer message is reset to 10 seconds. 

## v1.0.0

v1.0.0 was released on August 5th, 2019.

**New Features**

#### Interconnects with the legacy Agora Signaling SDK

v1.0.0 implements the `LocalInvitation.channelId` and `LocalInvitation.channelId` property. 

> - To intercommunicate with the legacy Agora Signaling SDK, you MUST set the channel ID. However, even if the callee successfully accepts the call invitation, the Agora RTM SDK does not join the channel of the specified channel ID.
> - If your App does not involve the legacy Agora Signaling SDK, we recommend using the `LocalInvitation.content` or the `RemoteInvitation.response` property to set customized contents. 


#### Sets the output log level of the SDK

Supports setting the output log level of the SDK using the `logFilter` parameter.  The log level follows the sequence of OFF, ERROR, WARNING, and INFO. Choose a level to see the logs preceding that level. If, for example, you set the log level to WARNING, you see the logs within levels ERROR and WARNING. 


### API Changes

#### Adds

- [logFilter](/en/Real-time-Messaging/API%20Reference/RTM_web/interfaces/rtmparameters.html#logfilter)
- [setParameters](/en/Real-time-Messaging/API%20Reference/RTM_web/classes/rtmclient.html#setparameters)



## v0.9.3

v0.9.3 was released on July 24th, 2019.

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

> The attributes you set will be cleard when you log out of the RTM system.


#### Queries the Online Status of the Specified Users

This release introduces a new concept: online and offline. 

- Online: The user has logged in the Agora RTM system. 
- Offline: The user has logged out of the Agora RTM system. 

This release adds the function of querying the online status of the specified users. After logging in the Agora RTM system, you can get the online status of a maximum of 256 specified users. 


#### Renews the Token

This release allows you to renew a token.

**API Changes**

#### Adds

- [sendMessageToPeer](/en/Real-time-Messaging/API%20Reference/RTM_web/classes/rtmclient.html#sendmessagetopeer)
- [setLocalUserAttributes](/en/Real-time-Messaging/API%20Reference/RTM_web/classes/rtmclient.html#setlocaluserattributes)
- [addOrUpdateLocalUserAttributes](/en/Real-time-Messaging/API%20Reference/RTM_web/classes/rtmclient.html#addorupdatelocaluserattributes)
- [deleteLocalUserAttributesByKeys](/en/Real-time-Messaging/API%20Reference/RTM_web/classes/rtmclient.html#deletelocaluserattributesbykeys)
- [clearLocalUserAttributes](/en/Real-time-Messaging/API%20Reference/RTM_web/classes/rtmclient.html#clearlocaluserattributes)
- [getUserAttributes](/en/Real-time-Messaging/API%20Reference/RTM_web/classes/rtmclient.html#getuserattributes)
- [getUserAttributesByKeys](/en/Real-time-Messaging/API%20Reference/RTM_web/classes/rtmclient.html#getuserattributesbykeys)
- [queryPeersOnlineStatus](/en/Real-time-Messaging/API%20Reference/RTM_web/classes/rtmclient.html#querypeersonlinestatus)
- [renewToken](/en/Real-time-Messaging/API%20Reference/RTM_web/classes/rtmclient.html#renewtoken)

## v0.9.1

v0.9.1 was released on May 20th, 2019.

**New Features**

This release adds the call invitation feature, allowing you to create, send, cancel, accept, and decline a call invitation in a one-to-one or one-to-many voice/video call. 



**API Changes**

#### Adds

- [createLocalInvitation](/en/Real-time-Messaging/API%20Reference/RTM_web/classes/rtmclient.html#createlocalinvitation): Creates a call invitation. 
- [LocalInvitation.send](/en/Real-time-Messaging/API%20Reference/RTM_web/classes/localinvitation.html#send): Allows the caller to send a call invitation to a specified user (callee). 
- [LocalInvitation.cancel](/en/Real-time-Messaging/API%20Reference/RTM_web/classes/localinvitation.html#send)Allows the caller to cancel a sent call invitation. 
- [LocalInvitationState](/en/Real-time-Messaging/API%20Reference/RTM_web/enums/localinvitationstate.html): **RETURNED TO THE CALLER** Call invitation status codes. 
- [LocalInvitationFailureReason](/en/Real-time-Messaging/API%20Reference/RTM_web/enums/localinvitationfailurereason.html): **RETURNED TO THE CALLER** Reason for failure of the outgoing call invitation. 
- [RemoteInvitationReceived](/en/Real-time-Messaging/API%20Reference/RTM_web/interfaces/rtmclientevents.html#remoteinvitationreceived): Occurs when the callee receives a call invitation. 
- [RemoteInvitation.accept](/en/Real-time-Messaging/API%20Reference/RTM_web/classes/remoteinvitation.html#accept): Allows the callee to accept an incoming call invitation. 
- [RemoteInvitation.refuse](/en/Real-time-Messaging/API%20Reference/RTM_web/classes/remoteinvitation.html#refuse): Allows the callee to declien an incoming call invitation. 
- [RemoteInvitationState](/en/Real-time-Messaging/API%20Reference/RTM_web/enums/remoteinvitationstate.html): **RETURNED TO THE CALLEE**: Call invitation status codes. 
- [RemoteInvitationFailureReason](/en/Real-time-Messaging/API%20Reference/RTM_web/enums/remoteinvitationfailurereason.html): **RETURNED TO THE CALLEE**: Reason for the failure of the incoming call invitation.

#### Renames

- `RtmClient.ConnectionStateChange` to [ConnectionStateChanged](/en/Real-time-Messaging/API%20Reference/RTM_web/interfaces/rtmclientevents.html#connectionstatechanged) .

#### Deletes

- The `RtmChannel.getId()` method. Uses the [channelId](/en/Real-time-Messaging/API%20Reference/RTM_web/classes/rtmchannel.html#channelid) property instead.

## v0.9.0

v0.9.0 was released on February 14th, 2019.

Initial version. 

**Key features**

- Sends or receives peer-to-peer messages.
- Joins or leaves a channel.
- Sends or receives channel messages.
