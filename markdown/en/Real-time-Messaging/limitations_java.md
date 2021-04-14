---
title: RTM Limitations
platform: Android
updatedAt: 2020-09-30 23:53:56
---

This page provides a brief overview of the limitations of the Agora RTM Java SDK for Linux, including API call limit, string size, encoding, and more.


## API call limit

The call limit is for one <code>RtmClient</code> instance. If an operation corresponds to multiple methods, the number of the method calls of an operation equals the sum of the method calls of all corresponding methods in a specific time frame.

<div class="alert note">You can increase the call limit of an API by creating multiple <code>RtmClient</code> instances.</div>

| Function                                           | Method                                                       | Call limit                  |
| -------------------------------------------------- | ------------------------------------------------------------ | ------------------------------- |
| Log in to the RTM system                             | [login](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/classio_1_1agora_1_1rtm_1_1_rtm_client.html#a995bb1b1bbfc169ee4248bd37e67b24a) | Two calls per second          |
| Retrieve member count of specified channels | [getChannelMemberCount](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/classio_1_1agora_1_1rtm_1_1_rtm_client.html#aff0384f2a004ed75498e20e1917352e4) | One call per second |
| Join a different channel each time | [join](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/classio_1_1agora_1_1rtm_1_1_rtm_channel.html#ad7b321869aac2822b3f88f8c01ce0d40) | 50 calls every three seconds |
| Join the same channel each time | [join](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/classio_1_1agora_1_1rtm_1_1_rtm_channel.html#ad7b321869aac2822b3f88f8c01ce0d40) | Two calls every five seconds |
| Send messages                                     | <li>[sendMessageToPeer](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/classio_1_1agora_1_1rtm_1_1_rtm_client.html#a25ab5c0126e1dc51c78b2b705de68b7a)<li> [sendMessageToPeer](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/classio_1_1agora_1_1rtm_1_1_rtm_client.html#a729079805644b3307297fb2e902ab4c9) <li>  [sendMessage](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/classio_1_1agora_1_1rtm_1_1_rtm_channel.html#a57087adf4227a17c774ea292840148a0)  | 1,500 calls every three seconds           |
| Retrieve a member list of the channel             | [getMembers](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/classio_1_1agora_1_1rtm_1_1_rtm_channel.html#a567aca5f866cf71c3b679ae09b4bf626) | Five calls every two seconds  |
| Renew the token                                   | [renewToken](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/classio_1_1agora_1_1rtm_1_1_rtm_client.html#a9a6d33282509384165709107d7a89353) | Two calls per second          |
| Query the online status of the specified users | [queryPeersOnlineStatus](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/classio_1_1agora_1_1rtm_1_1_rtm_client.html#ac711f981405648ed5ef1cb07436125f3) | 100 calls every five seconds. |
| Set user attributes                               | <li>[setLocalUserAttributes](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/classio_1_1agora_1_1rtm_1_1_rtm_client.html#a339b7b2371ff2b86137b6db6c1c66294)<li>[addOrUpdateLocalUserAttributes](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/classio_1_1agora_1_1rtm_1_1_rtm_client.html#a765b186d62ed3ef6d67a5e875b040875)<li>[deleteLocalUserAttributesByKeys](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/classio_1_1agora_1_1rtm_1_1_rtm_client.html#a2477533989c1bb9ced831af210f1dba4)<li> [clearLocalUserAttributes](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/classio_1_1agora_1_1rtm_1_1_rtm_client.html#ae0c6c5c5bae6020e69009441d8a41785) | 100 calls every five seconds   |
| Get user attributes                               | <li>[getUserAttributes](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/classio_1_1agora_1_1rtm_1_1_rtm_client.html#aee9a6c027f35b652781f654a89433755)<li>[getUserAttributesByKeys](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/classio_1_1agora_1_1rtm_1_1_rtm_client.html#a3b927c35cca5ebd31afb976d60e99193) | 400 calls every 5 seconds   |
| Set channel attributes | <li>[setChannelAttributes](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/classio_1_1agora_1_1rtm_1_1_rtm_client.html#ad25f51a3671db50e348ec6c170044ec6)<li>[addOrUpdateChannelAttributes](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/classio_1_1agora_1_1rtm_1_1_rtm_client.html#a997a31e6bfe1edc9b6ef58a931ef3f23)<li>[deleteChannelAttributesByKeys](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/classio_1_1agora_1_1rtm_1_1_rtm_client.html#a4cbf3329abda4940b73a75455cd1dc06)<li> [clearChannelAttributes](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/classio_1_1agora_1_1rtm_1_1_rtm_client.html#a6ed0ef4baacda8fa00eda5373d17f59f)  | 100 calls every five seconds         |
| Get channel attributes | <li>[getChannelAttributes](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/classio_1_1agora_1_1rtm_1_1_rtm_client.html#a81f14a747a4012815ab4ba8d9e480fb6)<li>[getChannelAttributesByKeys](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/classio_1_1agora_1_1rtm_1_1_rtm_client.html#a358b47f4b42d678fafa76f3f30290e5e)  | 400 calls every five seconds   |
| Subscribe to the online status of the specified users | [subscribePeersOnlineStatus](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/classio_1_1agora_1_1rtm_1_1_rtm_client.html#a7a9ec7398c013ed35e17bc5d93e71420) | 10 calls every five seconds. |
| Unsubscribe from the online status of the specified users | [unsubscribePeersOnlineStatus](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/classio_1_1agora_1_1rtm_1_1_rtm_client.html#acf3ab093be17a0752d8aff094e3aabc4) | 10 calls every five seconds. |
| Get a list of the peers, to whose specific status you have subscribed | [queryPeersBySubscriptionOption](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/classio_1_1agora_1_1rtm_1_1_rtm_client.html#a971c357f7d0c27d122ff877389314ccc) | 10 calls every five seconds. |
	

## String size

- The maximum size of a peer-to-peer or channel message is 32 KB. See [RtmMessage.setText](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/classio_1_1agora_1_1rtm_1_1_rtm_message.html#a114bf5f4d728e1a5e31792491bf4a1d2).
- The maximum size of the content in a call invitation is 8 KB. See [LocalInvitation.setContent](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/interfaceio_1_1agora_1_1rtm_1_1_local_invitation.html#a4cec28ff6d356242329b1034c7531445).
- The maximum size of the response in a call invitation is 8 KB. See [RemoteInvitation.setResponse](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/interfaceio_1_1agora_1_1rtm_1_1_remote_invitation.html#a229b8cf773eaa0e79b0d67815fd6b6f1).

## Unicode support 

- Channel and peer-to-peer messages, invitation content, and invitation response must be in UTF-8 format.
- The `filePath` parameter of the following methods must be in UTF-8 format:
  - [`createFileMessageByUploading`](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/classio_1_1agora_1_1rtm_1_1_rtm_client.html#a1b08207278d611e5e4b87e6d9712e0c7)
  - [`createImageMessageByUploading`](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/classio_1_1agora_1_1rtm_1_1_rtm_client.html#afc93fad7700593a803ddbc87482c0ac0)
  - [`downloadMediaToFile`](/en/Real-time-Messaging/API%20Reference/RTM_java_linux/classio_1_1agora_1_1rtm_1_1_rtm_client.html#a34e0bd19fb0bbd1d91dec0a1af100038)

## Miscellaneous 

- Notifications of a member joining or leaving the channel are automatically disabled when the number of channel members exceeds 512. Agora recommends that you call the [Gets channel events RESTful API](/en/Real-time-Messaging/rtm_get_event?platform=All%20Platforms)) from your server to get the notifications of channel events. 
- The current version supports querying the online status of a maximum of 256 users.
- You can subscribe to the online status of a maximxim of 512 users in one method call, and you can subscribe to the online status of at most 512 users. 
- Attribute settings in one user attribute operation should not exceed 16 KB in size; attribute settings in one channel attribute operation should not exceed 32 KB in size; each attribute (key/value pair) should not excced 8 KB in size; the number of key/value pairs you set in one attribute operation should not exceed 32. 