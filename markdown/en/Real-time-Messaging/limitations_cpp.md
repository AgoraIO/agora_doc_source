---
title: RTM Limitations
platform: CPP
updatedAt: 2021-01-19 10:33:21
---

This page provides a brief overview of the limitations of the Agora RTM SDK for Windows C++, including API call limit, string size, encoding, and more.


## Call limit

The call limit is for one <code>IRtmService</code> instance. If an operation corresponds to multiple methods, the number of the method calls of an operation equals the sum of the method calls of all corresponding methods in a specific time frame.

<div class="alert note">You can increase the call limit of an API by creating multiple <code>IRtmService</code> instances.</div>

| Operation                                                    | Method                                                       | Call limit                 |
| ----------------------------------------------------------- | ------------------------------------------------------------ | ------------------------------ |
| Log in the RTM system                                | [`login`](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#a2433a0babbed76ab87084d131227346b) | 2 calls per second         |
| Retrieve member count of specified channel(s) | [`getChannelMemberCount`](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#a41dee47c6201acb2f29371b6e30249a5) | 1 call per second |
| Join a different channel each time | [`join`](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_channel.html#a6a54cdd8e5db526514e0ca84aa9cba4c) | 50 calls every 3 seconds |
| Join the same channel each time | [`join`](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_channel.html#a6a54cdd8e5db526514e0ca84aa9cba4c) | 2 calls every 5 seconds |
| Send messages | <li>[`sendMessageToPeer`](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#afec5391fa9c4ec2bfe9ac4e684705600)</li> <li>[`sendMessageToPeer`](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#a08c1b3d444af5a2778ede48e4c677a52)</li> <li>[`sendMessage`](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_channel.html#a4ae01f44d49f334f7c2950d95f327d30)</li> | 60 calls per second          |
| Retrieve a member list of the channel          | [`getMembers`](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_channel.html#a3f9c943059ac48a568c81798da38c3cb) | 5 calls every 2 seconds |
| Renew the token| [`renewToken`](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#a2c33be67bfec02d69041f1e8978f4559) | 2 calls per second |
| Query the online status of the specified user(s) | [`queryPeersOnlineStatus`](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#a3add0055c4455dc8d04bfc37edfd8e94) | 10 calls every 5 seconds. |
| Set user attributes                               | <li>[`setLocalUserAttributes`](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#a86dcbfc38c665be8565f06c534338d33)</li><li>[`addOrUpdateLocalUserAttributes`](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#a0a63923bd1e81e60d6ca54213a329747)</li><li>[`deleteLocalUserAttributesByKeys`](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#acb669f6c4c28e08cdf889df11e1ddeb3)</li><li>[`clearLocalUserAttributes`](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#acc5eee875f4166fe455cde7aff1ad738)</li> | 10 calls every 5 seconds   |
| Get user attributes                               | <li>[`getUserAttributes`](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#a14cac887f9adb390621dd0427092a65b)</li><li>[`getUserAttributesByKeys`](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#af011235917c291df5581f92afa35532f)</li> | 40 calls every 5 seconds   |
| Set channel attributes | <li>[`setChannelAttributes`](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#aa229a7207062b510799166c1239412fa)</li><li>[`addOrUpdateChannelAttributes`](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#ae4068ff21c8e20e8eeb45ba21959c368)</li><li>[`deleteChannelAttributesByKeys`](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#a1a448f33be57b31f9952822426e5c4bd)</li><li>[`clearChannelAttributes`](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#aff6cff676e3fc3150ef5f27845c9a3d3)</li> | 10 calls every 5 seconds         |
| Get channel attributes | <li>[`getChannelAttributes`](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#a3dc8409ed82d8f95a0839d5e9e7da564)</li><li> [`getChannelAttributesByKeys`](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#ac97f24f9d78e885e494a22be95db8d33)</li> | 10 calls every 5 seconds          |
| Subscribe to the online status of the specified user(s) | [`subscribePeersOnlineStatus`](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#a3a0e2d4d79ac85e23eae0dcb114ba9f0) | 10 calls every 5 seconds. |
| Unsubscribe from the online status of the specified user(s) | [`unsubscribePeersOnlineStatus`](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#a027574f04151a9fded678fadba47441e) | 10 calls every 5 seconds. |
| Gets a list of the peers, to whose specific status you have subscribed. | [`queryPeersBySubscriptionOption`](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#a063bd3db39660a7a3513378ce03f4456) | 10 calls every 5 seconds. |

	
## Operation timeout

<style> table th:first-of-type {     width: 300px; } th:third-of-type {     width: 100px; }</style>

| Operation | Timeout (s) | 
| ---------------- | ---------------- | 
| Log in the RTM system   | 6   | 
| Send peer messages  | 10     | 
| Query the online status of specified users  | 10     | 
| Subscribe to the online status of specified users  | 10     | 
| Unsubscribe from the online status of specified users  | 10     | 
| Query peers by subscription option  | 5     | 
| User attribute or channel attribute operations  | 5     | 
| Retrieve member count of specified channels  | 5    | 
| Join a channel  | 5    | 
| Send a channel message| 10    | 
| Get a member list of the channel  | 5   | 




## String size

- The maximum size of a peer-to-peer or channel message is 32 KB. See [`IMessage.setText`](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_message.html#a2e93098d5a3819e9d4cf8d42641474ae).
- The maximum size of the content in a call invitation is 8 KB. See [`ILocalCallInvitation.setContent`](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_local_call_invitation.html#aaf4b356b7602cad2bdb998250617c920).
- The maximum size of the response in a call invitation is 8 KB. See [`IRemoteCallInvitation.setResponse`](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_remote_call_invitation.html#a77c8a0902f9dce36525a66575a6ae8a5).

## Encoding

- Channel and peer-to-peer messages, invitation content, and invitation response must be in UTF-8 format.
- The `filePath` parameter of the following methods must be in UTF-8 format:
  - [`createFileMessageByUploading`](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#a99f2137ec43be135b369b7d6927b6138)
  - [`createImageMessageByUploading`](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#a7192d93f365c28e2d0b91547716fb5a9)
  - [`downloadMediaToFile`](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#a70584eb57e97476b1da072f737d88c95)


## Miscellaneous

- Notifications of a member joining or leaving the channel are automatically disabled when the number of channel members exceeds 512.
- The current version supports querying the online status of up to 256 users.
- You can subscribe to the online status of up to 512 users in one method call, and you can subscribe to the online status of up to 512 users. 
- Attribute settings in one user attribute operation must not exceed 16 KB in size. Attribute settings in one channel attribute operation must not exceed 32 KB in size. Each attribute (key/value pair) must not exceed 8 KB in size. The number of key/value pairs you set in one attribute operation must not exceed 32. 
- Each file or image you upload to the Agora server stays for 7 days. The corresponding media ID also stays valid for 7 days.
- Each file or image to upload must not exceed 30 MB.
- Each client instance can only support up to 9 upload and download processes at the same time.