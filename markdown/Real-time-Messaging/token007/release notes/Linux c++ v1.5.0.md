## v1.5.0

v1.5.0 was released on July 20, 2022.

#### Upgrade features

**AccessToken2**

As of this release, the authentication mechanism of RTM is upgraded from AccessToken to AccessToken2. Both types of tokens are supported at the same time and can work in tandem with each other.

<div class="alert note"><li>If you are new to RTM, Agora recommends that you use the latest release and deploy the App server and client for AccessToken2 step by step according to <a href="https://docs.agora.io/en/Real-time-Messaging/token_server_rtm">RTM Token</a>.<li>If you have already deployed AccessToken in previous release, you can have a quick upgrade referring to <a href="https://docs.agora.io/en/Real-time-Messaging/token_server_rtm#upgrade">Upgrade to AccessToken2</a>.</div>

AccessToken2 allows users to specify the validity period of an RTM token. The validity period can be a maximum of 24 hours. Besides, this release adds the `onTokenPrivilegeWillExpire` callback triggered when a token is about to expire in 30 seconds. Upon receiving this callback, you can generate a new RTM token on your app server, and pass the new RTM token to the SDK; otherwise, the connection state of the SDK switches from connected to aborted due to `CONNECTION_CHANGE_REASON_TOKEN_EXPIRED (9)`. For details, see [RTM Token expiration](./token_server_rtm#rtm-token-expiration).

#### Sunset features

[Image or file messages](./upload_download_media_cpp), [historical messages](./rtm_get_event), and [offline messages](./messaging_restful#history) are deprecated as of this release. In previous versions, users who integrate these features can still use them.


#### API changes

**Added**  
- `onTokenPrivilegeWillExpire`
- `CONNECTION_CHANGE_REASON_TOKEN_EXPIRED (9)` in the `CONNECTION_CHANGE_REASON` enumerator

**Deprecated**  
- `createFileMessageByMediaId`
- `createFileMessageByUploading`
- `createImageMessageByMediaId`
- `createImageMessageByUploading`
- `cancelMediaUpload`
- `cancelMediaDownload`
- `downloadMediaToMemory`
- `downloadMediaToFile`
- `enableOfflineMessaging`
- `enableHistoricalMessaging`
- `onFileMessageReceived`
- `onFileMessageReceivedFromPeer`
- `onImageMessageReceived`
- `onImageMessageReceivedFromPeer`
- `onMediaUploadingProgress`
- `onMediaDownloadingProgress`

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

- Improved the performance of login and messaging operations.
- Added the `AGORA_SDK_BOTH_RTM_AND_RTC` macro for the `RTM_AREA_CODE` enum type. You can use the macro to resolve naming conflicts when using RTC and RTM together.

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

[`setRtmServiceContext`](/en/Real-time-Messaging/API%20Reference/RTM_cpp/v1.4.0/group__get_rtm_sdk_version.html#ga55ed2d637b72bf2940872b8736a00bd3)

## v1.3.0

v1.3.0 was released on June 12.

**Compatibility changes**

- You need to add a new TCP port, 9140, to the firewall whitelist. The port is for sending and receiving image or file messages. See [Firewall Requirements](https://docs.agora.io/en/Agora%20Platform/firewall?platform=All%20Platforms).
- The Agora server blocks any file message or image message that you send to RTM SDK 1.2.2 or earlier, or to the Signaling SDK.

**New features**

#### 1. Send and receive file messages or image messages

You can call `createFileMessageByUploading` or `createImageMessageByUploading` to upload non-empty files or image files no greater than 30 MB. Each uploaded file or image stays in the Agora server for seven days. The SDK returns a media ID as the unique indentifier of the file or image file. You can use the `IFileMessage` class or the `IImageMessage` class to save the media ID. The `IFileMessage` class and the `IImageMessage` class inherit from the `IMessage` class, so you can send and receive file or image messages via peer-to-peer or channel message methods. You can call `downloadMediaToMemory` or `downloadMediaToFile` to download the received file or image file.

#### 2. Manage upload or download tasks

You can call `cancelMediaUpload` or `cancelMediaDownload` to cancel an upload or download task. You also can use the `onMediaUploadingProgress` callback or the `onMediaDownloadingProgress` callback to return upload or download progress.

**Improvements**

The call limits of the following operations have increased. See [RTM limitations](/en/Real-time-Messaging/limitations_cpp_linux?platform=Linux%20CPP&versionId=ff8c9040-ac73-11ea-aa07-c5bcc14a9a95). 

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

- [`createFileMessageByUploading`](/en/Real-time-Messaging/API%20Reference/RTM_cpp/v1.3.0/classagora_1_1rtm_1_1_i_rtm_service.html?transId=82687bd0-ac53-11ea-aa07-c5bcc14a9a95#a99f2137ec43be135b369b7d6927b6138)
- [`createImageMessageByUploading`](/en/Real-time-Messaging/API%20Reference/RTM_cpp/v1.3.0/classagora_1_1rtm_1_1_i_rtm_service.html?transId=82687bd0-ac53-11ea-aa07-c5bcc14a9a95#a7192d93f365c28e2d0b91547716fb5a9)
- [`cancelMediaUpload`](/en/Real-time-Messaging/API%20Reference/RTM_cpp/v1.3.0/classagora_1_1rtm_1_1_i_rtm_service.html?transId=82687bd0-ac53-11ea-aa07-c5bcc14a9a95#a0090bbb72e250ffbaedc84d9041b64b1)
- [`cancelMediaDownload`](/en/Real-time-Messaging/API%20Reference/RTM_cpp/v1.3.0/classagora_1_1rtm_1_1_i_rtm_service.html?transId=82687bd0-ac53-11ea-aa07-c5bcc14a9a95#adc34b7acad8b845fe1242efd127d82b9)
- [`createFileMessageByMediaId`](/en/Real-time-Messaging/API%20Reference/RTM_cpp/v1.3.0/classagora_1_1rtm_1_1_i_rtm_service.html?transId=82687bd0-ac53-11ea-aa07-c5bcc14a9a95#a6e4b13011388ec45e8a02377b240506f)
- [`createImageMessageByMediaId`](/en/Real-time-Messaging/API%20Reference/RTM_cpp/v1.3.0/classagora_1_1rtm_1_1_i_rtm_service.html?transId=82687bd0-ac53-11ea-aa07-c5bcc14a9a95#a97bfb847ff876ab216cf219f4b4f856d)
- [`downloadMediaToMemory`](/en/Real-time-Messaging/API%20Reference/RTM_cpp/v1.3.0/classagora_1_1rtm_1_1_i_rtm_service.html?transId=82687bd0-ac53-11ea-aa07-c5bcc14a9a95#ade134da2be907a8078ce693849e0cc37)
- [`downloadMediaToFile`](/en/Real-time-Messaging/API%20Reference/RTM_cpp/v1.3.0/classagora_1_1rtm_1_1_i_rtm_service.html?transId=82687bd0-ac53-11ea-aa07-c5bcc14a9a95#a70584eb57e97476b1da072f737d88c95)

#### New callbacks

- [`onMediaUploadingProgress`](/en/Real-time-Messaging/API%20Reference/RTM_cpp/v1.3.0/classagora_1_1rtm_1_1_i_rtm_service_event_handler.html?transId=82687bd0-ac53-11ea-aa07-c5bcc14a9a95#a56d5464c3b5e53c44039190a3ac4dfe9)
- [`onMediaDownloadingProgress`](/en/Real-time-Messaging/API%20Reference/RTM_cpp/v1.3.0/classagora_1_1rtm_1_1_i_rtm_service_event_handler.html?transId=82687bd0-ac53-11ea-aa07-c5bcc14a9a95#a9c4dfbb224f69b73f64dc1bf34f28567)
- [`onMediaCancelResult`](/en/Real-time-Messaging/API%20Reference/RTM_cpp/v1.3.0/classagora_1_1rtm_1_1_i_rtm_service_event_handler.html?transId=82687bd0-ac53-11ea-aa07-c5bcc14a9a95#a64cac4d387e2bf6a419bb478358570f6)
- [`onFileMediaUploadResult`](/en/Real-time-Messaging/API%20Reference/RTM_cpp/v1.3.0/classagora_1_1rtm_1_1_i_rtm_service_event_handler.html?transId=82687bd0-ac53-11ea-aa07-c5bcc14a9a95#aadaa8cd5309e4e70ab2cbdfc1ef21241)
- [`onImageMediaUploadResult`](/en/Real-time-Messaging/API%20Reference/RTM_cpp/v1.3.0/classagora_1_1rtm_1_1_i_rtm_service_event_handler.html?transId=82687bd0-ac53-11ea-aa07-c5bcc14a9a95#abaeeaeb6d69b98510d6c3b012849251e)
- [`onFileMessageReceivedFromPeer`](/en/Real-time-Messaging/API%20Reference/RTM_cpp/v1.3.0/classagora_1_1rtm_1_1_i_rtm_service_event_handler.html?transId=82687bd0-ac53-11ea-aa07-c5bcc14a9a95#a4642bb3a8ddf026617fff47d1c9f3e3a)
- [`onImageMessageReceivedFromPeer`](/en/Real-time-Messaging/API%20Reference/RTM_cpp/v1.3.0/classagora_1_1rtm_1_1_i_rtm_service_event_handler.html?transId=82687bd0-ac53-11ea-aa07-c5bcc14a9a95#a2682e64be745cf7af816a12f9895ce07)
- [`onFileMessageReceived`](/en/Real-time-Messaging/API%20Reference/RTM_cpp/v1.3.0/classagora_1_1rtm_1_1_i_channel_event_handler.html?transId=82687bd0-ac53-11ea-aa07-c5bcc14a9a95#a416dd103c84387a5147e962398eff8d1)
- [`onImageMessageReceived`](/en/Real-time-Messaging/API%20Reference/RTM_cpp/v1.3.0/classagora_1_1rtm_1_1_i_channel_event_handler.html?transId=82687bd0-ac53-11ea-aa07-c5bcc14a9a95#a6d710170df9b3c1f0ef092012af2e317)
- [`onMediaDownloadToMemoryResult`](/en/Real-time-Messaging/API%20Reference/RTM_cpp/v1.3.0/classagora_1_1rtm_1_1_i_rtm_service_event_handler.html?transId=82687bd0-ac53-11ea-aa07-c5bcc14a9a95#ad0de249a8f0b79973f34f295cabe4904)
- [`onMediaDownloadToFileResult`](/en/Real-time-Messaging/API%20Reference/RTM_cpp/v1.3.0/classagora_1_1rtm_1_1_i_rtm_service_event_handler.html?transId=82687bd0-ac53-11ea-aa07-c5bcc14a9a95#a0b6edc7b944eab02d545bb2d2d1bfe2f)

#### Deprecated methods

[`sendMessage`](/en/Real-time-Messaging/API%20Reference/RTM_cpp/v1.3.0/classagora_1_1rtm_1_1_i_channel.html?transId=82687bd0-ac53-11ea-aa07-c5bcc14a9a95#a4ae01f44d49f334f7c2950d95f327d30) is deprecated. Use [`sendMessage (const IMessage *message, const SendMessageOptions &options)`](/en/Real-time-Messaging/API%20Reference/RTM_cpp/v1.3.0/classagora_1_1rtm_1_1_i_channel.html?transId=82687bd0-ac53-11ea-aa07-c5bcc14a9a95#a056dfe9e83c168c3c94e47a017a6ec3f) instead.

## v1.2.2

$$ 284398f0-1b4a-11ea-8fc3-cf882a952d6b
{
  "platform": "Linux C++"
}
$$

## v1.2.1

$$ b3810d10-20b5-11ea-b338-f1556ea7fcbf
{
  "platform": "Linux C++"
}
$$

## v1.2.0 

v1.2.0 was released on November 6, 2019. 

**Compatibility Changes**

Deprecated the `isOnline` property of the `PeerOnlineStatus`. Use `onlineState` instead. 


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

## v1.1.0

v1.1.0 was released on October 14, 2019. It adds the following features: 

- [Gets the member count of specified channel(s).](#getcount)
- [Automatically returns the latest numer of members in the current channel](#oncount)
- [Channel attribute operations](#channelattributes)



**Compatibility Changes**

1. Deprecates the [sendMessageToPeer](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#afec5391fa9c4ec2bfe9ac4e684705600) method, and uses [sendMessageToPeer(const char \*, const IMessage \*, const SendMessageOptions \&)](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#a08c1b3d444af5a2778ede48e4c677a52) instead. 
2. The [getServerReceivedTs](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_message.html#ac7427e3a49bd44e53b2809e0b39511b6)  method of the [IMessage](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_message.html) object supports both peer-to-peer and channel messages. 
3. Timeout for sending a peer-to-peer message is 10 seconds from this release, compared to 5 seconds in previous versions. See [PEER_MESSAGE_ERR_SENT_TIMEOUT ](/en/Real-time-Messaging/API%20Reference/RTM_cpp/namespaceagora_1_1rtm.html#ac7c591aac4ca6867e239c8bcccc1fc5ca231d49ed8da45aa4be794cfe927703dc).
4. Puts a limit on the frequency of  [join](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_channel.html#a6a54cdd8e5db526514e0ca84aa9cba4c) the same channel: [Two times every five seconds](/en/Real-time-Messaging/API%20Reference/RTM_cpp/namespaceagora_1_1rtm.html#adeb91ade364eddd742d8f3ad59c6638ea02250c14972ba934c148fc3d558baa6f).

**New Features**

<a name="getcount"></a>
#### 1. Gets the member count of specified channel(s).

You can now get the member count of specified channel(s) without the need to join, by calling the [getChannelMemberCount](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#a41dee47c6201acb2f29371b6e30249a5) method. You can get the member counts of a maximum of 32 channels in one method call. 

<a name="oncount"></a>
#### 2. Automatically returns the latest numer of members in the current channel 

If you are already in a channel, you do not have to call the `getChannelMemberCount` method to get the member count of the current channel. We also do not recommend using `onMemberJoined` and `onMemberLeft` to keep track of the member counts. As of this release, the SDK returns to the channel members [onMemberCountUpdated](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_channel_event_handler.html#aff85052bb2a46c3220789c1ef90aa01e) the latest channel member count when the number of channel members changes. Note that:

- When the number of channel members ≤ 512, the SDK returns this callback when the number changes and at a MAXIMUM speed of once per second.
- When the number of channel members exceeds 512, the SDK returns this callback when the number changes and at a MAXIMUM speed of once every three seconds.



> Please treat this callback and the [onGetMembers](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_channel_event_handler.html#a5e3f5a5ae0b3861de2f0310841ad0b37) callback separately: 
> - The former is an automatic callback. It returns the current numer of channel members;
> - The latter is triggered by the [getMembers](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_channel.html#a3f9c943059ac48a568c81798da38c3cb) method. It returns a member list of the current channel. If the number of channel members exceeds 512, the SDK only returns a list of 512 randomly-selected channel members. 

<a name="channelattributes"></a>
#### 3. Channel attribute operations

Supports setting or getting the attribute(s) of a specified channel. You can use this feature to create group anouncement.

Each channel attribute comes as a key-value pair. See [IRtmChannelAttribute](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_channel_attribute.html) for more information. Where: 

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

When updating attributes of a channel, you can use the  [enableNotificationToChannelMembers](/en/Real-time-Messaging/API%20Reference/RTM_cpp/structagora_1_1rtm_1_1_channel_attribute_options.html#a9a29721df90beca76974a5e348902530) flag to decide whether or not to notify all members of the channel about this attribute change. 

> The SDK caches the channel attributes. If multiple users have the privilege to update the channel attributes, then we recommend calling the [getChannelAttributes](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#a3dc8409ed82d8f95a0839d5e9e7da564) to update the cache before updating the channel attributes. 

**Improvements**

#### Resends peer-to-peer messages

This release improves the resending mechanism of peer-to-peer messages, and extends the timeout for sending a peer-to-peer message from five to 10 seconds, greatly improving the success rate of peer-to-peer message sending under weak network conditions. 

#### Caches channel messages

The Agora RTM system will resend a maximum of 32 channel messages of up to 30 seconds to channel members, when they manage to reconnect to the system from poor network conditions. This greatly improves the overall arrival rate of channel messages under weak network conditions. 


**API Changes**

#### Added Methods

- [createChannelAttribute](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#af153fe0c639a009bf35bad1da471d2be): Creates and returns an [IRtmChannelAttribute](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_channel_attribute.html) instance. 
- [setChannelAttributes](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#aa229a7207062b510799166c1239412fa): Substitutes the attributes of a specified channel with new ones.
- [addOrUpdaeChannelAttributes](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#ae4068ff21c8e20e8eeb45ba21959c368): Adds or updates the attribute(s) of a specified channel.
- [deleteChannelAttributesByKeys](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#a1a448f33be57b31f9952822426e5c4bd): Deletes the attributes of a specified channel by attribute keys.
- [clearChannelAttributes](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#aff6cff676e3fc3150ef5f27845c9a3d3): Clears all attributes of a specified channel.
- [getChannelAttributes](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#a3dc8409ed82d8f95a0839d5e9e7da564): Gets all attributes of a specified channel.
- [getChannelAttributesByKeys](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#ac97f24f9d78e885e494a22be95db8d33): Gets the attributes of a specified channel by attribute keys.
- [getChannelMemberCount](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#a41dee47c6201acb2f29371b6e30249a5): Gets the member count of specified channel(s).

#### Added Callbacks

- [onSetChannelAttributesResult](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service_event_handler.html#a7e9581ecf7998686b96aa25005381492): Returns the result of the [setChannelAttributes](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#aa229a7207062b510799166c1239412fa) method call. 
- [onAddOrUpdateChannelAttributesResult](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service_event_handler.html#a24acf67b176597cd13e0d5dc5c3885e7): Returns the result of the [addOrUpdaeChannelAttributes](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#ae4068ff21c8e20e8eeb45ba21959c368) method call. 
- [onDeleteChannelAttributesResult](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service_event_handler.html#a087caa19e3d4115f040d943e738cc2df): Returns the result of the [deleteChannelAttributesByKeys](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#a1a448f33be57b31f9952822426e5c4bd) method call. 
- [onClearChannelAttributesResult](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service_event_handler.html#a10c56b8ac93aedb31348da8f2811228c): Returns the result of the [clearChannelAttributes](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#aff6cff676e3fc3150ef5f27845c9a3d3) method call. 
- [onGetChannelAttributesResult](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service_event_handler.html#ab3f049ec99393efb883e0e589704e613): Returns the result of the [getChannelAttributes](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#a3dc8409ed82d8f95a0839d5e9e7da564) or [getChannelAttributesByKeys](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#ac97f24f9d78e885e494a22be95db8d33) method call. 
- [onAttributesUpdated](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_channel_event_handler.html#a7a9ae1b89fdf3f69242393955d0fd5c5): Returns all attributes of the channel when the channel attributes are updated. 
- [onGetChannelMemberCountResult](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service_event_handler.html#a881a9953322b09dc17cd0dc98c11eb18): Returns the result of the [getChannelMemberCount](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#a41dee47c6201acb2f29371b6e30249a5) method call. 
- [onMemberCountUpdated](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_channel_event_handler.html#aff85052bb2a46c3220789c1ef90aa01e): Occurs when the number of the channel members changes, and returns the new number.

#### Added Error Codes 

- [GET_CHANNEL_MEMBER_COUNT_ERR_CODE](/en/Real-time-Messaging/API%20Reference/RTM_cpp/namespaceagora_1_1rtm.html#ad2e93c1596f5f929e7d7601a85024dcc): Error codes related to retrieving the channel member count of specified channel(s).
- [JOIN_CHANNEL_ERR_JOIN_SAME_CHANNEL_TOO_OFTEN](/en/Real-time-Messaging/API%20Reference/RTM_cpp/namespaceagora_1_1rtm.html#adeb91ade364eddd742d8f3ad59c6638ea02250c14972ba934c148fc3d558baa6f): The frequency of joining the same channel exceeds two times every five seconds.

#### Deprecated Methods

- [sendMessageToPeer](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#afec5391fa9c4ec2bfe9ac4e684705600): Replaced by the [sendMessageToPeer](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#a08c1b3d444af5a2778ede48e4c677a52) method. 

#### Deprecated Error Codes

- [ATTRIBUTE_OPERATION_ERR_NOT_READY](/en/Real-time-Messaging/API%20Reference/RTM_cpp/namespaceagora_1_1rtm.html#a9413a8cce9bbd88d8d4baade13c2ccceacfd54d25148ff796305ab58ef7317613): Replaced by [ATTRIBUTE_OPERATION_ERR_USER_NOT_LOGGED_IN](/en/Real-time-Messaging/API%20Reference/RTM_cpp/namespaceagora_1_1rtm.html#a9413a8cce9bbd88d8d4baade13c2cccea9469baeab2e6c16b0351c16885f9fd33). 




## v1.0.1

v1.0.1 was released on August 1st, 2019. 

**Issues Fixed**

- When the connection to the Agora RTM system is interrupted, the SDK does not return the `onConnectionStateChanged` callback. 

## v1.0.0

v1.0.0 was released on July 24th, 2019.

**New Features**

#### Interconnects with the legacy Agora Signaling SDK

v1.0.0 implements the `ILocalCallinvitation::setChannelId` and `ILocalCallinvitation::getChannelId` methods. 

> - To intercommunicate with the legacy Agora Signaling SDK, you MUST set the channel ID. However, even if the callee successfully accepts the call invitation, the Agora RTM SDK does not join the channel of the specified channel ID.
> - If your App does not involve the legacy Agora Signaling SDK, we recommend using the `ILocalCallInvitation::setContent` method or the `IRemoteCallInvitation::setResponse` method to set customized contents. 

#### Specifies the default path to the SDK log file

Supports changing the default path to the SDK log file using the `setLogFile` method. To avoid creating an incomplete log file, we recommend calling this method once you have created and initialized an `IRtmService` instance. 



#### Sets the output log level of the SDK

Supports setting the output log level of the SDK using the `setLogFilter` method.  The log level follows the sequence of OFF, CRITICAL, ERROR, WARNING, and INFO. Choose a level to see the logs preceding that level. If, for example, you set the log level to WARNING, you see the logs within levels CRITICAL, ERROR, and WARNING. See also [LOG_FILTER_TYPE](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/namespaceagora_1_1rtm.html#af515252477afb2a71feef88113dfa481). 

> You can call this method once you have created and initializd an `IRtmService` instance. You do not have to call this method after calling the `login` method. 

#### Sets the log file size in KB

Supports setting the log file size using the `setLogFileSize` method. The log file has a default size of 512 KB. File size settings of less than 512 KB or greater than 10 MB will not take effect.


> You can call this method once you have created and initializd an `IRtmService` instance. You do not have to call this method after calling the `login` method. 

**Improvements**

Adds error codes based on the following scenarios: 

- The Agora RTM service is not initialized.
- The method call frequency exceeds the limit. 
- The user does not call the `login` method or the method call of `login` does not succeed before calling any of the RTM core APIs. 

**Issues Fixed**

- One can log in the Agora RTM system with a static App ID and an RTM token, which is generated from a dynamic App ID. 


**API Changes**

- [setLogFile](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#a08063b2692a6091ad5e8b30146498089): Specifies the default path to the SDK log file.
- [setLogFilter](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#a41da0404ac726b7326ef1ca6213b2d61): Sets the output log level of the SDK.
- [setLogFileSize](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#ae7f4dcaf1173365ae5836bb23d5188f9): Sets the log file size in KB.



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

v0.9.2 was released on May 8th, 2019.

**New Features**

- Queries the Online Status of the Specified Users.
-  Renews the Token.

**Improvements**

-  Supports a `userId` that starts with a space.




## v0.9.1

v0.9.1 is released on April 4th, 2019.

**New Features**

This release adds the call invitation feature, allowing you to create, send, cancel, accept, and decline a call invitation in a one-to-one or one-to-many voice/video call. 


## v0.9.0

v0.9.0 is released on February 4th, 2019.

Initial version. 

**Key features**

- Sends or receives peer-to-peer messages.
- Joins or leaves a channel.
- Sends or receives channel messages.