---
title: Build a Client
platform: iOS
updatedAt: 2020-11-16 04:35:17
---
This article describes how to implement the basic features of live-stream shopping.

## Flowchart

Refer to the flowcharts for the following functions:

- Joins and leaves the room.

![](https://web-cdn.agora.io/docs-files/1594377181071)

- Co-host across channels.

![](https://web-cdn.agora.io/docs-files/1592898366538)

- Co-host in a channel.

![](https://web-cdn.agora.io/docs-files/1602231822290)

- Manages the product list.

<div class="alert note">The figure below is for reference only. If you want to use the product list management function, you need to design and deploy it yourself.</div>

![](https://web-cdn.agora.io/docs-files/1602231580288)

## Integrate the SDK

Refer to the following table to integrate the SDKs into your project:


| Product | SDK downloads | Integration guide |
| ---------------- | ---------------- | ---------------- |
| [Agora RTC (Real-time Communication) SDK](https://docs.agora.io/en/Interactive%20Broadcast/product_live?platform=All%20Platforms)      | [Agora SDK for iOS](https://docs.agora.io/en/Agora%20Platform/downloads)      | [Start Live Interactive Video Streaming](https://docs.agora.io/en/Interactive%20Broadcast/start_live_ios?platform=iOS) |
| [Agora RTM (Real-time Messaging) SDK](https://docs.agora.io/en/Real-time-Messaging/product_rtm?platform=All%20Platforms) | [Real-time messaging SDK](https://docs.agora.io/en/Real-time-Messaging/downloads) | [Peer-to-peer or Channel Messaging](https://docs.agora.io/en/Real-time-Messaging/messaging_ios?platform=iOS) |
| [Third-party Image Enhancement SDK](https://www.faceunity.com/#/developindex) | N/A | [iOS SDK Integration Guide](https://www.faceunity.com/docs_develop_en/#/nama_api_docs/iOS/docs/iOS_Nama_SDK_Integration_Guide) |


## Core API call sequence

The following diagrams show the core APIs that the Agora Live Demo app uses to implement a live-stream shopping scenario. Refer to them to implement the various functions in your project.

<div class="alert note">The Cloud Service in the demo app is implemented by Agora, and you need to deploy your own cloud service for the same purposes.</div>

- The host joins the room and starts the interactive streaming. 

![](https://web-cdn.agora.io/docs-files/1602248708202)

- The host invites an audience member for co-hosting, or an audience member applies for co-hosting. 

![](https://web-cdn.agora.io/docs-files/1602248736528)

- The host sends a PK host invitation. 

![](https://web-cdn.agora.io/docs-files/1602248756984)

- The audience chat through text messages and switch channels.

![](https://web-cdn.agora.io/docs-files/1592900593914)

## Core API reference

- Agora RTM SDK

| API | Function |
| ---------------- | ---------------- |
| [initWithAppId](https://docs.agora.io/en/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmKit.html#//api/name/initWithAppId:delegate:)       | Creates an RTM Client object.      |
| [loginByToken](https://docs.agora.io/en/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmKit.html#//api/name/loginByToken:user:completion:) | Logs into the Agora RTM system.|
| [createChannelWithId](https://docs.agora.io/en/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmKit.html#//api/name/createChannelWithId:delegate:) | Creates an Agora RTM channel. |
| [joinWithCompletion](https://docs.agora.io/en/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmChannel.html#//api/name/joinWithCompletion:) | Joins the RTM channel.|
| [sendMessage](https://docs.agora.io/en/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmChannel.html#//api/name/sendMessage:completion:) | Sends a channel message, which can be received by all users in the channel. |
| [sendMessage](https://docs.agora.io/en/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmKit.html#//api/name/sendMessage:toPeer:sendMessageOptions:completion:) | Sends a peer message. The host can use this method to send a co-hosting invitation to an audience member or send a PK host invitation to the host of another channel; an audience member can use this method to send a co-hosting application to the host. |
| [leaveWithCompletion](https://docs.agora.io/en/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmChannel.html#//api/name/leaveWithCompletion:) | Leaves the RTM channel. |
| [logoutWithCompletion](https://docs.agora.io/en/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmKit.html#//api/name/logoutWithCompletion:) | Logs out of the Agora RTM system. |

- Agora RTC SDK

| API | Function |
| ---------------- | ---------------- |
| [sharedEngineWithAppId](https://docs.agora.io/en/Interactive%20Broadcast/API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/sharedEngineWithAppId:delegate:)      | Creates an RtcEngine object. |
| [setChannelProfile](https://docs.agora.io/en/Interactive%20Broadcast/API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setChannelProfile:) | Sets the channel profile. In live-stream shopping, we set the channel profile as `LiveBroadcasting`. |
| [setClientRole](https://docs.agora.io/en/Interactive%20Broadcast/API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setClientRole:) | Sets the user role in live interactive streaming. In live-stream shopping, we set the role of the host as `Broadcaster`, and other users as `Audience` |
| [enableVideo](https://docs.agora.io/en/Interactive%20Broadcast/API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/enableVideo) | Enables video.|
| [setupLocalVideo](https://docs.agora.io/en/Interactive%20Broadcast/API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setupLocalVideo:) | Sets the local video view. Call this method on the host's client to configure the view of the host on the local device. |
| [joinChannelByToken](https://docs.agora.io/en/Interactive%20Broadcast/API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/joinChannelByToken:channelId:info:uid:joinSuccess:) | Joins the RTC channel. |
| [startChannelMediaRelay](https://docs.agora.io/en/Interactive%20Broadcast/API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/startChannelMediaRelay:) | Starts relaying media streams across channels. This is the core API for co-hosting across channels.|
| [setupRemoteVideo](https://docs.agora.io/en/Interactive%20Broadcast/API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setupRemoteVideo:) | Sets the remote video view. Once the audience member accepts the co-hosting invitation or the host of the destination channel accepts the PK host invitation, call this method on the original host's client to configure the view of the co-host.  |
| [stopChannelMediaRelay](https://docs.agora.io/en/Interactive%20Broadcast/API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/stopChannelMediaRelay) | Stops relaying media streams across channels. |
| [leaveChannel](https://docs.agora.io/en/Interactive%20Broadcast/API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/leaveChannel:) | Leaves the channel. |

## Additional functions

**Image enhancement**

The Agora Live Demo app uses a third-party SDK for image enhancement. You can refer to the source code in the faceunity file to implement the function.

**Network quality detection**

Use the `reportRtcStats` callback to detect and report the network quality in real-time. Triggered once every two seconds during live interactive streaming, this callback reports statistics, including the sending and receiving bitrate and packet loss rate.

**In-ear monitoring**

Call `enableInEarMonitoring` to enable the in-ear monitor function on the host's client.

**Audio mixing**

After joining the channel, call `startAudioMixing` on the host's client to play background music.

## Open-source sample project

Agora provides an open-source sample project for [Live-stream shopping](https://github.com/AgoraIO-Usecase/AgoraLive) on GitHub for you to download as a source code reference.