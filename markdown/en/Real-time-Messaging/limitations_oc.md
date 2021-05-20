---
title: RTM Limitations
platform: Android
updatedAt: 2021-01-19 10:42:57
---

This page provides a brief overview of the limitations of the Agora RTM Objective-C SDK for iOS or Agora RTM Objective-C SDK for macOS, including API call limit, string size, encoding, and more.



## API call limit

The call limit is for one <code>AgoraRtmKit</code> instance. If an operation corresponds to multiple methods, the number of the method calls of an operation equals the sum of the method calls of all corresponding methods in a specific time frame.

<div class="alert note">You can increase the call limit of an API by creating multiple <code>AgoraRtmKit</code> instances.</div>

| Function                                                    | Method                                                       | API call limit                 |
| ----------------------------------------------------------- | ------------------------------------------------------------ | ------------------------------ |
| Log in the Agora RTM system                                | [`loginByToken`](/en/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmKit.html#//api/name/createChannelWithId:delegate:) | 2 calls per second         |
| Retrieve member count of specified channel(s) | [`getChannelMemberCount`](/en/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmKit.html#//api/name/getChannelMemberCount:completion:) | 1 call per second |
| Join a channel<sup>1</sup> | [`joinWithCompletion`](/en/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmChannel.html#//api/name/joinWithCompletion:) | 50 calls every 3 seconds |
| Send messages| <li>[`sendMessage:toPeer:completion:`](/en/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmKit.html#//api/name/sendMessage:toPeer:completion:) <li>[`sendMessage:toPeer:sendMessageOptions:completion:`](/en/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmKit.html#//api/name/sendMessage:toPeer:sendMessageOptions:completion:) <li>And [`sendMessage:completion:`](/en/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmChannel.html#//api/name/sendMessage:completion:) taken together | 60 calls per second          |
| Retrieve a member list of the channel                      | [`getMembersWithCompletion:`](/en/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmChannel.html#//api/name/getMembersWithCompletion:) | 5 calls every 2 seconds |
| Renew the token | [`renewToken`](/en/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmKit.html#//api/name/renewToken:completion:) | 2 calls per second |
| Query the online status of the specified users. | [`queryPeersOnlineStatus`](/en/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmKit.html#//api/name/queryPeersOnlineStatus:completion:) | 10 calls every 5 seconds |
| Set user attributes | <li>[`setLocalUserAttributes`](/en/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmKit.html#//api/name/setLocalUserAttributes:completion:)<li>[`addOrUpdateLocalUserAttributes`](/en/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmKit.html#//api/name/addOrUpdateLocalUserAttributes:completion:)<li>[`deleteLocalUserAttributesByKeys`](/en/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmKit.html#//api/name/deleteLocalUserAttributesByKeys:completion:)<li>And [`clearLocalUserAttributes`](/en/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmKit.html#//api/name/clearLocalUserAttributesWithCompletion:) taken together | 10 calls every 5 seconds          |
| Get user attributes | <li>[`getUserAttributes`](/en/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmKit.html#//api/name/getUserAllAttributes:completion:)<li>And [`getUserAttributesByKeys`](/en/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmKit.html#//api/name/getUserAttributes:ByKeys:completion:) taken together | 40 calls every 5 seconds         |
| Set channel attributes | <li>[`setChannelAttributes`](/en/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmKit.html#//api/name/setChannel:Attributes:Options:completion:)<li>[`addOrUpdateChannelAttributes`](/en/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmKit.html#//api/name/addOrUpdateChannel:Attributes:Options:completion:)<li>[`deleteChannelAttributesByKeys`](/en/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmKit.html#//api/name/deleteChannel:AttributesByKeys:Options:completion:)<li>And [`clearChannelAttributes`](/en/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmKit.html#//api/name/clearChannel:Options:AttributesWithCompletion:) taken together | 10 calls every 5 seconds          |
| Get channel attributes | <li>[`getChannelAttributes`](/en/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmKit.html#//api/name/getChannelAllAttributes:completion:)<li>And [`getChannelAttributesByKeys`](/en/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmKit.html#//api/name/getChannelAttributes:ByKeys:completion:) taken together | 10 calls every 5 seconds         |
| Subscribe to the online status of the specified user(s) | [`subscribePeersOnlineStatus`](/en/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmKit.html#//api/name/subscribePeersOnlineStatus:completion:) | 10 calls every 5 seconds. |
| Unsubscribe from the online status of the specified user(s) | [`unsubscribePeersOnlineStatus`](/en/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmKit.html#//api/name/unsubscribePeersOnlineStatus:completion:) | 10 calls every 5 seconds. |
| Get a list of the peers, to whose specific status you have subscribed. | [`queryPeersBySubscriptionOption`](/en/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmKit.html#//api/name/queryPeersBySubscriptionOption:completion:) | 10 calls every 5 seconds. |

<div class="alert note"><sup>1</sup> The API call limit for joining the same channel is 2 calls every 5 seconds. </div>

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

- The maximum length of a peer-to-peer or channel message is 32 KB. See [`AgoraRtmMessage`](/en/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmMessage.html).
- The maximum length of the content in a call invitation is 8 KB. See [`AgoraRtmLocalInvitation`](/en/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmLocalInvitation.html).
- The maximum length of the response in a call invitation is 8 KB. See [`AgoraRtmRemoteInvitation`](/en/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmRemoteInvitation.html).

## Encoding 

- Channel and peer-to-peer messages, invitation content, and invitation response must be in UTF-8 format. 
- The `filePath` parameter of the following methods must be in UTF-8 format:
    - [`createFileMessageByUploading:withRequest:completion:`](/cn/Real-time-Messaging/API%20Reference/RTM_oc/v1.3.0/Classes/AgoraRtmKit.html#//api/name/createFileMessageByUploading:withRequest:completion:)
    - [`createImageMessageByUploading:withRequest:completion:`](/cn/Real-time-Messaging/API%20Reference/RTM_oc/v1.3.0/Classes/AgoraRtmKit.html#//api/name/createImageMessageByUploading:withRequest:completion:)
    - [`downloadMedia:toFile:withRequest:completion:`](/cn/Real-time-Messaging/API%20Reference/RTM_oc/v1.3.0/Classes/AgoraRtmKit.html#//api/name/downloadMedia:toFile:withRequest:completion:) 


## Miscellaneous 

- Notifications of a member joining or leaving the channel are automatically disabled when the number of channel members exceeds 512.
- The current version supports querying the online status of up to 256 users.
- You can subscribe to the online status of up to 512 users in one method call. Overall, you can subscribe to the online status of up to 512 users. 
- Attribute settings in one user attribute operation should not exceed 16 KB in size. Attribute settings in one channel attribute operation should not exceed 32 KB in size; each attribute (key/value pair) should not excced 8 KB in size; the number of key/value pairs you set in one attribute operation should not exceed 32. 
- Each file or image you upload to the Agora server stays for 7 days. The corresponding media ID also stays valid for 7 days.
- Each file or image to upload must not exceed 30 MB.