---
title: Build a Client
platform: Android
updatedAt: 2020-07-20 14:23:36
---
This article describes how to implement the basic features of co-hosted interactive streaming.

## Flowchart

Refer to the flowcharts for the following functions:

- Joins and leaves the room.

![](https://web-cdn.agora.io/docs-files/1594371478629)

- Controls host seats.

![](https://web-cdn.agora.io/docs-files/1594364973276)

## Integrate the SDK

Refer to the following table to integrate the SDKs into your project:


| Product | SDK downloads | Integration guide |
| ---------------- | ---------------- | ---------------- |
| [Agora RTC (Real-time Communication) SDK](https://docs.agora.io/en/Interactive%20Broadcast/product_live?platform=All%20Platforms)      | [Agora SDK for Android](https://docs.agora.io/en/Agora%20Platform/downloads)      | [Start a Video Broadcast](https://docs.agora.io/en/Interactive%20Broadcast/start_live_android?platform=Android) |
| [Agora RTM (Real-time Messaging) SDK](https://docs.agora.io/en/Real-time-Messaging/product_rtm?platform=All%20Platforms) | [Real-time messaging SDK](https://docs.agora.io/en/Real-time-Messaging/downloads) | [Peer-to-peer or Channel Messaging](https://docs.agora.io/en/Real-time-Messaging/messaging_android?platform=Android) |
| [Third-party Image Enhancement SDK](https://www.faceunity.com/#/developindex)	 | N/A | [Android SDK Integration Guide](https://www.faceunity.com/docs_develop_en/#/nama_api_docs/Android/docs/Android_Nama_SDK_Integration_Guide) |


## Core API call sequence

The following diagrams show the core APIs that the Agora Live Demo app uses to implement a co-hosted interactive streaming scenario. Refer to them to implement the various functions in your project.

<div class="alert note">The Cloud Service in the demo app is implemented by Agora, and you need to deploy your own cloud service for the same purposes.</div>

- The host joins the room and starts the interactive streaming.

   ![](https://web-cdn.agora.io/docs-files/1594365053924)
	 
- The host invites the audience for co-hosting, stops co-hosting, mutes and unmutes a co-host, and closes and reopens a host seat.

   ![](https://web-cdn.agora.io/docs-files/1594365078444)
	
- The audience applies for co-hosting, switches back to an audience member, and stops and resumes co-hosting per the host's request.

   ![](https://web-cdn.agora.io/docs-files/1594365093451)


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
| [onMessageReceived](https://docs.agora.io/en/Real-time-Messaging/API%20Reference/RTM_java/interfaceio_1_1agora_1_1rtm_1_1_rtm_client_listener.html#af760814981718fb31d88acb8251d19b6) | Occurs when the local user receives a peer-to-peer message. |
| [leave](https://docs.agora.io/en/Real-time-Messaging/API%20Reference/RTM_java/classio_1_1agora_1_1rtm_1_1_rtm_channel.html#a9e0b6aad17bfceb3c9c939351a467d14) | Leaves the RTM channel. |
| [logout](https://docs.agora.io/en/Real-time-Messaging/API%20Reference/RTM_java/classio_1_1agora_1_1rtm_1_1_rtm_client.html#a6f5695854e251ddd4ba05547ab47b317) | Logs out of the Agora RTM system. |

- Agora RTC SDK

| API | Function |
| ---------------- | ---------------- |
| [create](https://docs.agora.io/en/Interactive%20Broadcast/API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a35466f690d0a9332f24ea8280021d5ed)      | Creates an RtcEngine object. |
| [setChannelProfile](https://docs.agora.io/en/Interactive%20Broadcast/API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a1bfb76eb4365b8b97648c3d1b69f2bd6) | Sets the channel profile. In a PK host, we set the channel profile as live broadcast.|
| [setClientRole](https://docs.agora.io/en/Interactive%20Broadcast/API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#aa2affa28a23d44d18b6889fba03f47ec) | Sets the user role in a live broadcast. In a PK host, we set the role of the host as broadcaster, and other users as audience. |
| [enableVideo](https://docs.agora.io/en/Interactive%20Broadcast/API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a99ae52334d3fa255dfcb384b78b91c52) | Enables video.|
| [setupLocalVideo](https://docs.agora.io/en/Interactive%20Broadcast/API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a1fa43a5ce24196e840bcb1062cadbf23) | Sets the local video view. Call this method on the clients of the host and co-hosts to enable the host and co-hosts to see their own video view. |
| [joinChannel](https://docs.agora.io/en/Interactive%20Broadcast/API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a8b308c9102c08cb8dafb4672af1a3b4c) | Joins the RTC channel. |
| [setupRemoteVideo](https://docs.agora.io/en/Interactive%20Broadcast/API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a0e9f693c9bc2ccb91554c2c7dc6b7140) | Sets the remote video view. Call this method on the clients of the host and co-hosts to enable the audience to see the video view of the host and co-hosts. |
| [muteLocalAudioStream](https://docs.agora.io/en/Interactive%20Broadcast/API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html?&_ga=2.144305526.2109159719.1594021857-1969480941.1589793536#a838a04b744e6fb53bd1548d30bff1302) | Stops or resumes sending the local audio stream. Use this method with sendMessageToPeer to revoke or restore a co-host's privilege of sending audio. |
| [muteLocalVideoStream](https://docs.agora.io/en/Interactive%20Broadcast/API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html?&_ga=2.144305526.2109159719.1594021857-1969480941.1589793536#a949cd7044eec55ffd0b63ad3004db756) | Stops or resumes sending the local video stream. Use this method with sendMessageToPeer to revoke or restore a co-host's privilege of sending video. |
| [leaveChannel](https://docs.agora.io/en/Interactive%20Broadcast/API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a2929e4a46d5342b68d0deb552c29d597) | Leaves the channel. Use this method to quick switch to another live-broadcast channel. |

## Additional functions

**Image enhancement**

The Agora Live Demo app uses a third-party SDK for image enhancement. You can refer to the source code in the faceunity file to implement the function.

**Network quality detection**

Use the `onRtcStats` callback to detect and report the network quality in real-time. Triggered once every two seconds during a live broadcast, this callback reports statistics, including the sending and receiving bitrate and packet loss rate.

**Mute the local audio and video**

Call `muteLocalAudioStream` or `muteLocalVideoStream` to stop sending local audio or video streams.

**In-ear monitoring**

Call `enableInEarMonitoring` to enable the in-ear monitor function on the host's client.

**Audio mixing**

After joining the channel, call `startAudioMixing` on the host's client to play background music.

## Open-source sample project

Agora provides an open-source sample project for [Co-hosted Interactive Streaming](https://github.com/AgoraIO-Usecase/AgoraLive) on GitHub for you to download as a source code reference.