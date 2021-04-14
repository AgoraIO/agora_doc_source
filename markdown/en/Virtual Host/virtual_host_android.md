---
title: Build a Client
platform: Android
updatedAt: 2020-07-21 17:15:42
---
This section describes how to implement the basic features of a virtual host scenario.

## Flowchart

Refer to the flowcharts for the following functions:

- Joins and leaves the room.

![](https://web-cdn.agora.io/docs-files/1594377181071)

- Controls host seats.

![](https://web-cdn.agora.io/docs-files/1595233671494)

## Integrate the SDK

| Product | SDK downloads | Integration guide |
| ---------------- | ---------------- | ---------------- |
| [Agora RTC (Real-time Communication) SDK](https://docs.agora.io/en/Interactive%20Broadcast/product_live?platform=All%20Platforms)      | [Agora SDK for Android](https://docs.agora.io/en/Agora%20Platform/downloads)      | [Start a Video Broadcast](https://docs.agora.io/en/Interactive%20Broadcast/start_live_android?platform=Android) |
| [Agora RTM (Real-time Messaging) SDK](https://docs.agora.io/en/Real-time-Messaging/product_rtm?platform=All%20Platforms) | [Real-time messaging SDK](https://docs.agora.io/en/Real-time-Messaging/downloads) | [Peer-to-peer or Channel Messaging](https://docs.agora.io/en/Real-time-Messaging/messaging_android?platform=Android) |
| Third-party Animoji Enhancement SDK	 | N/A | Refer to the integration guide of the third-party Animoji SDK. |

## Core API call sequence

The following diagrams show the core APIs that the Agora Live Demo app uses to implement a multi-hosted interactive streaming scenario. Refer to them to implement the various functions in your project.

<div class="alert note">The Cloud Service in the demo app is implemented by Agora, and you need to deploy your own cloud service for the same purposes.</div>

- Generates avatar using third-party Animoji SDK.

![](https://web-cdn.agora.io/docs-files/1595233374203)
	 
- The host joins the room and starts the interactive streaming.

![](https://web-cdn.agora.io/docs-files/1595233383169)
	
- The host invites the audience member for co-hosting, then stops co-hosting. The audience member stops co-hosting.

![](https://web-cdn.agora.io/docs-files/1595233390117)


## Core API reference

- Agora RTM SDK

| API | Function |
| ---------------- | ---------------- |
| [createInstance](https://docs.agora.io/en/Real-time-Messaging/API%20Reference/RTM_java/classio_1_1agora_1_1rtm_1_1_rtm_client.html#a6411640143c4d0d0cd9481937b754dbf)      | Creates an RTM Client object.      |
| [login](https://docs.agora.io/en/Real-time-Messaging/API%20Reference/RTM_java/classio_1_1agora_1_1rtm_1_1_rtm_client.html#a995bb1b1bbfc169ee4248bd37e67b24a) | Logs into the Agora RTM system.|
| [createChannel](https://docs.agora.io/en/Real-time-Messaging/API%20Reference/RTM_java/classio_1_1agora_1_1rtm_1_1_rtm_client.html#a95ebbd1a1d902572b444fef7853f335a) | Creates an Agora RTM channel. |
| [join](https://docs.agora.io/en/Real-time-Messaging/API%20Reference/RTM_java/classio_1_1agora_1_1rtm_1_1_rtm_channel.html#ad7b321869aac2822b3f88f8c01ce0d40) | Joins the RTM channel.|
| [sendMessage](https://docs.agora.io/en/Real-time-Messaging/API%20Reference/RTM_java/classio_1_1agora_1_1rtm_1_1_rtm_channel.html#a6e16eb0e062953980a92e10b0baec235) | Sends a channel message, which can be received by all users in the channel. |
| [sendMessageToPeer](https://docs.agora.io/en/Real-time-Messaging/API%20Reference/RTM_java/classio_1_1agora_1_1rtm_1_1_rtm_client.html#a729079805644b3307297fb2e902ab4c9) | Sends a peer message. The host uses this method to send a co-hosting invitation to an audience member; an audience member uses this method to send a co-hosting application to the host. |
| [onMessageReceived](https://docs.agora.io/en/Real-time-Messaging/API%20Reference/RTM_java/interfaceio_1_1agora_1_1rtm_1_1_rtm_client_listener.html#af760814981718fb31d88acb8251d19b6) | Occurs when receiving a peer-to-peer message. |
| [leave](https://docs.agora.io/en/Real-time-Messaging/API%20Reference/RTM_java/classio_1_1agora_1_1rtm_1_1_rtm_channel.html#a9e0b6aad17bfceb3c9c939351a467d14) | Leaves the RTM channel. |
| [logout](https://docs.agora.io/en/Real-time-Messaging/API%20Reference/RTM_java/classio_1_1agora_1_1rtm_1_1_rtm_client.html#a6f5695854e251ddd4ba05547ab47b317) | Logs out of the Agora RTM system. |

- Agora RTC SDK

| API | Function |
| ---------------- | ---------------- |
| [create](https://docs.agora.io/en/Interactive%20Broadcast/API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a35466f690d0a9332f24ea8280021d5ed)      | Creates an RtcEngine object. |
| [setChannelProfile](https://docs.agora.io/en/Interactive%20Broadcast/API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a1bfb76eb4365b8b97648c3d1b69f2bd6) | Sets the channel profile. In multi-hosted interactive streaming, the channel profile is set as `BROADCASTING`.|
| [setClientRole](https://docs.agora.io/en/Interactive%20Broadcast/API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#aa2affa28a23d44d18b6889fba03f47ec) | Sets the user role in interactive streaming. In multi-hosted interactive streaming, use this method to switch a user between a co-host and an audience member. |
| [enableVideo](https://docs.agora.io/en/Interactive%20Broadcast/API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a99ae52334d3fa255dfcb384b78b91c52) | Enables video.|
| [setupLocalVideo](https://docs.agora.io/en/Interactive%20Broadcast/API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a1fa43a5ce24196e840bcb1062cadbf23) | Sets the local video view. Call this method on the clients of the host and co-hosts to enable the host and co-hosts to see their own video view. |
| [joinChannel](https://docs.agora.io/en/Interactive%20Broadcast/API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a8b308c9102c08cb8dafb4672af1a3b4c) | Joins the RTC channel. |
| [setupRemoteVideo](https://docs.agora.io/en/Interactive%20Broadcast/API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a0e9f693c9bc2ccb91554c2c7dc6b7140) | Sets the remote video view. Call this method on the clients of the host and co-hosts to enable the audience to see the video view of the host and co-hosts. |
| [leaveChannel](https://docs.agora.io/en/Interactive%20Broadcast/API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a2929e4a46d5342b68d0deb552c29d597) | Leaves the channel. |
| [setVideoSource](https://docs.agora.io/en/Interactive%20Broadcast/API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a2929e4a46d5342b68d0deb552c29d597) | Customizes the video source. |
| [consumeTextureFrame](https://docs.agora.io/en/Voice/API%20Reference/java/interfaceio_1_1agora_1_1rtc_1_1mediaio_1_1_i_video_frame_consumer.html#ae0a7c8f508b4aa814852e4e2af53082c) | Receives the video frame in texture. |
| [startPreview](https://docs.agora.io/en/Voice/API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a9143c9bb03165fe8b07c0c1e5a455ffb) | Starts the local video preview before joining a channel. |

## Additional functions

**Network quality detection**

Use the `onRtcStats` callback to detect and report the network quality in real-time. Triggered once every two seconds during a live broadcast, this callback reports statistics, including the sending and receiving bitrate and packet loss rate.

**In-ear monitoring**

Call `enableInEarMonitoring` to enable the in-ear monitor function on the host's client.

**Audio mixing**

After joining the channel, call `startAudioMixing` on the host's client to play background music.

## Open-source sample project

Agora provides an open-source sample project for [Virtual Host](https://github.com/AgoraIO-Usecase/AgoraLive) on GitHub for you to download as a source code reference.