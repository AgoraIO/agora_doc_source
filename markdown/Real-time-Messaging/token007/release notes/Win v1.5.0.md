## v1.5.0

v1.5.0 was released on July 20, 2022.

#### Upgrade features

**AccessToken2**

As of this release, the authentication mechanism of RTM is upgraded from AccessToken to AccessToken2. Both types of tokens are supported at the same time and can work in tandem with each other.

<div class="alert note"><li>If you are new to RTM, Agora recommends that you use the latest release and deploy the App server and client for AccessToken2 step by step according to <a href="https://docs.agora.io/en/Real-time-Messaging/token_server_rtm">RTM Token</a>.<li>If you have already deployed AccessToken in a previous release, you can quickly upgrade to AccessToken2 by referring <a href="https://docs.agora.io/en/Real-time-Messaging/token_server_rtm#upgrade">Upgrade to AccessToken2</a>.</div>

AccessToken2 allows users to specify the validity period of an RTM token. The validity period can be a maximum of 24 hours. This release also adds the `onTokenPrivilegeWillExpire` callback, which is triggered when a token is due to expire in 30 seconds. Upon receiving this callback, you can generate a new RTM token on your server and pass the new RTM token to the SDK; otherwise, the connection state of the SDK switches from connected to aborted due to `CONNECTION_CHANGE_REASON_TOKEN_EXPIRED (9)`. For details, see [RTM Token expiration](./token_server_rtm#rtm-token-expiration).

#### Sunset features

[Image or file messages](./upload_download_media_cpp), [historical messages](./rtm_get_event), and [offline messages](./messaging_restful#history) are deprecated as of this release. If you have integrated these features in a previous release, you can continue to use them.

#### API changes

**Added**  
- `onTokenPrivilegeWillExpire`
- `CONNECTION_CHANGE_REASON_TOKEN_EXPIRED (9)` in the `CONNECTION_CHANGE_REASON` enumberator

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

**Improvements**

- Improved performance of login and messaging operations.
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
- Optimized the reconnection mechanism.

**API changes**

#### New methods

[`setRtmServiceContext`](/en/Video/API%20Reference/RTM_cpp/v1.4.0/group__get_rtm_sdk_version.html#ga55ed2d637b72bf2940872b8736a00bd3)

## v1.3.0

v1.3.0 was released on May 8, 2020.

**Compatibility changes**

- You need to add a new TCP port, 9140, to the firewall whitelist. The port is for sending and receiving image or file messages. See [Firewall Requirements](https://docs.agora.io/en/Agora%20Platform/firewall?platform=All%20Platforms).
- The Agora server blocks any file message or image message that you send to RTM SDK 1.2.2 or earlier, or to the Signaling SDK.

**New features**

#### 1. Send and receive file messages

v1.3.0 supports downloading non-empty files that are smaller than 30 MB. You can cancel an ongoing upload or download process at any time. Each file you upload to the Agora server corresponds to a media ID. The file stays on the Agora server for seven days. You can use the media ID to download the file as long as the it is still on the Agora server.

<div class="alert note">You can only download files using the methods provided by the SDK.</div>

v1.3.0 adds the `IFileMessage` message class for saving and transferring a media ID. The `IFileMessage` class inherits from the `IMessage` class, so you can use the existing peer-to-peer or channel messaging methods to transfer the `IFileMessage` instance. You can use the `IFileMessage` object to complete the following tasks:

- Set the filename and thumbnail of the uploaded file.
- Get the size of the uploaded file.

<div class="alert note">The total size of the message content, the filename, and the thumbnail must not exceed 32 KB.</div>

#### 2. Send and receive image messages

v1.3.0 supports downloading non-empty image files that are smaller than 30 MB. You can cancel an ongoing upload or download process at any time. Each image you upload to the Agora server corresponds to a media ID. The image file stays on the Agora server for seven days. You can use the media ID to download the image file as long as it is still on the Agora server.

<div class="alert note">You can only download image files using the download methods provided by the SDK.</div>

v1.3.0 adds the `IImageMessage` message class for saving and transferring a media ID. The `IImageMessage` class inherits from the `IMessage` class, so you can use the existing peer-to-peer or channel messaging methods to transfer the `IImageMessage` instance. You can use the `IImageMessage` object to complete the following tasks:

- Set the filename and thumbnail of the uploaded image file.
- Get the size of the uploaded image file.
- Get the SDK-calculated width and height of image files in JPEG, JPG, BMP, or PNG format.
- Set the width or height of image files. The width or height you set overwrites the width or height that the SDK calculates.

<div class="alert note">The total size of the message content, the filename, and the thumbnail must not exceed 32 KB.</div>

#### 3. Report the progress of upload or download

The SDK returns the progress of an upload or download by callback every second during a task in progress. If the upload or download task pauses, the SDK ceases to return any further callback until the task continues.

**Bug fixes**

- Login failure caused by the SDK's incorrect identification of user's network type.
- Other problems that may cause the system to crash.

**API changes**

#### New methods

- [`createFileMessageByUploading`](/en/Real-time-Messaging/API%20Reference/RTM_cpp/v1.3.0/classagora_1_1rtm_1_1_i_rtm_service.html?transId=e3e2dae0-8fb1-11ea-ba71-75bee5b5d68c#a99f2137ec43be135b369b7d6927b6138)
- [`createImageMessageByUploading`](/en/Real-time-Messaging/API%20Reference/RTM_cpp/v1.3.0/classagora_1_1rtm_1_1_i_rtm_service.html?transId=e3e2dae0-8fb1-11ea-ba71-75bee5b5d68c#a7192d93f365c28e2d0b91547716fb5a9)
- [`cancelMediaUpload`](/en/Real-time-Messaging/API%20Reference/RTM_cpp/v1.3.0/classagora_1_1rtm_1_1_i_rtm_service.html?transId=e3e2dae0-8fb1-11ea-ba71-75bee5b5d68c#a0090bbb72e250ffbaedc84d9041b64b1)
- [`cancelMediaDownload`](/en/Real-time-Messaging/API%20Reference/RTM_cpp/v1.3.0/classagora_1_1rtm_1_1_i_rtm_service.html?transId=e3e2dae0-8fb1-11ea-ba71-75bee5b5d68c#adc34b7acad8b845fe1242efd127d82b9)
- [`createFileMessageByMediaId`](/en/Real-time-Messaging/API%20Reference/RTM_cpp/v1.3.0/classagora_1_1rtm_1_1_i_rtm_service.html?transId=e3e2dae0-8fb1-11ea-ba71-75bee5b5d68c#a6e4b13011388ec45e8a02377b240506f)
- [`createImageMessageByMediaId`](/en/Real-time-Messaging/API%20Reference/RTM_cpp/v1.3.0/classagora_1_1rtm_1_1_i_rtm_service.html?transId=e3e2dae0-8fb1-11ea-ba71-75bee5b5d68c#a97bfb847ff876ab216cf219f4b4f856d)
- [`downloadMediaToMemory`](/en/Real-time-Messaging/API%20Reference/RTM_cpp/v1.3.0/classagora_1_1rtm_1_1_i_rtm_service.html?transId=e3e2dae0-8fb1-11ea-ba71-75bee5b5d68c#ade134da2be907a8078ce693849e0cc37)
- [`downloadMediaToFile`](/en/Real-time-Messaging/API%20Reference/RTM_cpp/v1.3.0/classagora_1_1rtm_1_1_i_rtm_service.html?transId=e3e2dae0-8fb1-11ea-ba71-75bee5b5d68c#a70584eb57e97476b1da072f737d88c95)

#### New callbacks

- [`onMediaUploadingProgress`](/en/Real-time-Messaging/API%20Reference/RTM_cpp/v1.3.0/classagora_1_1rtm_1_1_i_rtm_service_event_handler.html?transId=e3e2dae0-8fb1-11ea-ba71-75bee5b5d68c#a56d5464c3b5e53c44039190a3ac4dfe9)
- [`onMediaDownloadingProgress`](/en/Real-time-Messaging/API%20Reference/RTM_cpp/v1.3.0/classagora_1_1rtm_1_1_i_rtm_service_event_handler.html?transId=e3e2dae0-8fb1-11ea-ba71-75bee5b5d68c#a9c4dfbb224f69b73f64dc1bf34f28567)
- [`onMediaCancelResult`](/en/Real-time-Messaging/API%20Reference/RTM_cpp/v1.3.0/classagora_1_1rtm_1_1_i_rtm_service_event_handler.html?transId=e3e2dae0-8fb1-11ea-ba71-75bee5b5d68c#a64cac4d387e2bf6a419bb478358570f6)
- [`onFileMediaUploadResult`](/en/Real-time-Messaging/API%20Reference/RTM_cpp/v1.3.0/classagora_1_1rtm_1_1_i_rtm_service_event_handler.html?transId=e3e2dae0-8fb1-11ea-ba71-75bee5b5d68c#aadaa8cd5309e4e70ab2cbdfc1ef21241)
- [`onImageMediaUploadResult`](/en/Real-time-Messaging/API%20Reference/RTM_cpp/v1.3.0/classagora_1_1rtm_1_1_i_rtm_service_event_handler.html?transId=e3e2dae0-8fb1-11ea-ba71-75bee5b5d68c#abaeeaeb6d69b98510d6c3b012849251e)
- [`onFileMessageReceivedFromPeer`](/en/Real-time-Messaging/API%20Reference/RTM_cpp/v1.3.0/classagora_1_1rtm_1_1_i_rtm_service_event_handler.html?transId=e3e2dae0-8fb1-11ea-ba71-75bee5b5d68c#a4642bb3a8ddf026617fff47d1c9f3e3a)
- [`onImageMessageReceivedFromPeer`](/en/Real-time-Messaging/API%20Reference/RTM_cpp/v1.3.0/classagora_1_1rtm_1_1_i_rtm_service_event_handler.html?transId=e3e2dae0-8fb1-11ea-ba71-75bee5b5d68c#a2682e64be745cf7af816a12f9895ce07)
- [`onFileMessageReceived`](/en/Real-time-Messaging/API%20Reference/RTM_cpp/v1.3.0/classagora_1_1rtm_1_1_i_channel_event_handler.html?transId=e3e2dae0-8fb1-11ea-ba71-75bee5b5d68c#a416dd103c84387a5147e962398eff8d1)
- [`onImageMessageReceived`](/en/Real-time-Messaging/API%20Reference/RTM_cpp/v1.3.0/classagora_1_1rtm_1_1_i_channel_event_handler.html?transId=e3e2dae0-8fb1-11ea-ba71-75bee5b5d68c#a6d710170df9b3c1f0ef092012af2e317)
- [`onMediaDownloadToMemoryResult`](/en/Real-time-Messaging/API%20Reference/RTM_cpp/v1.3.0/classagora_1_1rtm_1_1_i_rtm_service_event_handler.html?transId=e3e2dae0-8fb1-11ea-ba71-75bee5b5d68c#ad0de249a8f0b79973f34f295cabe4904)
- [`onMediaDownloadToFileResult`](/en/Real-time-Messaging/API%20Reference/RTM_cpp/v1.3.0/classagora_1_1rtm_1_1_i_rtm_service_event_handler.html?transId=e3e2dae0-8fb1-11ea-ba71-75bee5b5d68c#a0b6edc7b944eab02d545bb2d2d1bfe2f)

#### Deprecated methods

[`sendMessage`](/en/Real-time-Messaging/API%20Reference/RTM_cpp/v1.3.0/classagora_1_1rtm_1_1_i_channel.html?transId=e3e2dae0-8fb1-11ea-ba71-75bee5b5d68c#a4ae01f44d49f334f7c2950d95f327d30) is deprecated. Use [`sendMessage (const IMessage *message, const SendMessageOptions &options)`](/en/Real-time-Messaging/API%20Reference/RTM_cpp/v1.3.0/classagora_1_1rtm_1_1_i_channel.html?transId=e3e2dae0-8fb1-11ea-ba71-75bee5b5d68c#a056dfe9e83c168c3c94e47a017a6ec3f) instead.

## v1.2.2

$$ 284398f0-1b4a-11ea-8fc3-cf882a952d6b
{
  "platform": "Windows C++"
}
$$

## v1.2.1

$$ b3810d10-20b5-11ea-b338-f1556ea7fcbf
{
  "platform": "Windows C++"
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

v1.1.0 was released on September 30, 2019. It added the following features: 

**Send an (offline) peer-to-peer message to a specified user**

This version allows you to send a message to a specified user when that user is offline. If you set a message as an offline message and the specified user is offline when you send it, the RTM server caches it. Please note that we only cache 200 offline messages for up to seven days for each receiver. If the number of the cached messages reaches this limit, the newest message overrides the oldest one.



<a name="getcount"></a>

**Get the member count of specified channel(s)**

Use the [getChannelMemberCount](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#a41dee47c6201acb2f29371b6e30249a5) method get the member count of specified channel(s) without the need to join them. One method call can get the member counts of a maximum of 32 channels. 

**Query the online status of the specified users**

**User attribute operations**

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

**Channel attribute operations**

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

**Call invitation**

This version enables you to create, send, cancel, accept, and decline a call invitation in a one-to-one or one-to-many voice/video call. 

**Join or leave a channel**

**Send or receive channel messages**

<a name="oncount"></a>

**Automatically return the latest number of members in the current channel**

Once you are in a channel, you no longer must call the `getChannelMemberCount` method to get the member count of the current channel. We also do not recommend using `onMemberJoined` and `onMemberLeft` to keep track of the member counts. As of this release, the SDK returns to the channel members [onMemberCountUpdated](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_channel_event_handler.html#aff85052bb2a46c3220789c1ef90aa01e) the latest channel member count when the number of channel members changes. Note that:

- When the number of channel members ≤ 512, the SDK returns this callback when the number changes and at a MAXIMUM speed of once per second.
- When the number of channel members exceeds 512, the SDK returns this callback when the number changes and at a MAXIMUM speed of once every three seconds.



> Please treat this callback and the [onGetMembers](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_channel_event_handler.html#a5e3f5a5ae0b3861de2f0310841ad0b37) callback separately: 
>
> - The former is an automatic callback. It returns the current number of channel members;
> - The latter is triggered by the [getMembers](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_channel.html#a3f9c943059ac48a568c81798da38c3cb) method. It returns a member list of the current channel. If the number of channel members exceeds 512, the SDK only returns a list of 512 randomly selected channel members. 

**Renew the Token**

**Specify the default path to the SDK log file**

Use the `setLogFile` method to change the default path to the SDK log file. To ensure that errors are completely written to the log file, we recommend calling this method immediately after you have created and initialized an `IRtmService` instance.



**Set the output log level of the SDK**

Use the `setLogFilter` method to set the output log level of the SDK.  The log level follows the sequence of OFF, CRITICAL, ERROR, WARNING, and INFO. Choose a level to see the logs preceding that level. If, for example, you set the log level to WARNING, you see the logs within levels CRITICAL, ERROR, and WARNING (the OFF level does not return any log results). See also [LOG_FILTER_TYPE](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/namespaceagora_1_1rtm.html#af515252477afb2a71feef88113dfa481). 

> You can call this method once you have created and initialized an `IRtmService` instance. You do not have to call this method until after calling the `login` method. 

**Set the log file size in KB**

Use the `setLogFileSize` method to set the log file size. The log file has a default size of 512 KB. File size settings of less than 512 KB or greater than 10 MB will not take effect.

> You can call this method once you have created and initialized an `IRtmService` instance. You do not have to call this method until after calling the `login` method. 