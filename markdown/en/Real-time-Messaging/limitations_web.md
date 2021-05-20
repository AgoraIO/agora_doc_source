---
title: RTM Limitations
platform: Android
updatedAt: 2020-10-20 10:58:27
---
This page provides information about the limitations of the Agora RTM Web SDK. 

> The current version does not support interoperability between the Agora RTM SDK and the Agora Signaling SDK. 


## Multiple Instances

Supports joining a maximum of 20 `RtmChannel` instances at the same time. When the number of channels you join reaches 20, we recommend calling the [RtmChannel.leave](/cn/Real-time-Messaging/RTM_web/API%20Reference/RTM_web/classes/rtmchannel.html#leave) method  to leave channel and then calling the `RtmChannel.removeAllListeners()` method to release all the resources used by that channel. 

## Call Frequencies

| Function                                                    | Method                                                       | Call Frequency                 |
| ----------------------------------------------------------- | ------------------------------------------------------------ | ------------------------------ |
| Logs in the Agora RTM system                                | [RtmClient.login](/en/Real-time-Messaging/API%20Reference/RTM_web/classes/rtmclient.html#login) | Two queries per second         |
| Sends messages (peer-to-peer and channel messages combined) | [RtmClient.sendMessageToPeer](/en/Real-time-Messaging/API%20Reference/RTM_web/classes/rtmclient.html#sendmessagetopeer) and [RtmChannel.sendMessage](/en/Real-time-Messaging/API%20Reference/RTM_web/classes/rtmchannel.html#sendmessage) combined | 60 queries per second          |
| Retrieves a member list of the channel                      | [RtmChannel.getMembers](/en/Real-time-Messaging/API%20Reference/RTM_web/classes/rtmchannel.html#getmembers) | Five queries every two seconds |

## String Length

- The maximum length of a peer-to-peer or channel message is 32 KB. See [RtmMessage.text](/en/Real-time-Messaging/API%20Reference/RTM_web/interfaces/rtmmessage.html#text).
- The maximum length of the content in a call invitation is 8 KB. See [LocalInvitation.content](/en/Real-time-Messaging/API%20Reference/RTM_web/classes/localinvitation.html#content)
- The maximum length of the response in a call invitation is 8 KB. See [RemoteInvitation.response](/en/Real-time-Messaging/API%20Reference/RTM_web/classes/remoteinvitation.html#response)

## Encoding 

Supports channel and peer-to-peer messages, invitation content, and invitation response in UTF-8 only. 


## Miscellaneous 

- Notifications of a member joining or leaving the channel are automatically disabled when the number of channel members exceeds 512. If you have special requirements, contact support@agora.io.