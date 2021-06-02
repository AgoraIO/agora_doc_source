---
title: Build a Client for the Student
platform: Android
updatedAt: 2020-05-13 19:08:23
---
This section describes how to implement an Android client for the student.

## Flowchart

This flowchart shows the major logic of the student joining and leaving the classroom:

![](https://web-cdn.agora.io/docs-files/1582873440949)

## Integrate the SDK

Refer to the following table to download the SDKs, and integrate the SDKs into your project.


| Product | SDK download | Integration guide |
| ---------------- | ---------------- | ---------------- |
| [RTC (Real-time Communication) SDK](https://docs.agora.io/en/Interactive%20Broadcast/product_live?platform=All%20Platforms)      | [Agora SDK for Android](https://download.agora.io/sdk/release/Agora_Native_SDK_for_Android_v2_9_0_102_FULL_20200216_1288.zip)      | [Start Interactive Live Streaming](https://docs.agora.io/en/Interactive%20Broadcast/start_live_android?platform=Android) |
| [RTM (Real-time Messaging) SDK](https://docs.agora.io/en/Real-time-Messaging/product_rtm?platform=All%20Platforms) | [Real-time Messaging SDK](https://docs.agora.io/en/Real-time-Messaging/downloads) | [Peer-to-peer or Channel Messaging](https://docs.agora.io/en/Real-time-Messaging/messaging_android?platform=Android) |
| Agora Room Management Service | / | [Agora Room Management Service quickstart](https://github.com/AgoraIO-Usecase/eEducation/wiki/Agora-Edu-Cloud-Service) |
| [Whiteboard](https://developer-en.netless.link/docs/android/overview/android-introduction/) | [White SDK](https://developer-en.netless.link/docs/android/quick-start/android-prepare/) | [Whiteboard quickstart](https://developer.netless.link/android-en/home/android-prepare) |



## Core API call sequence

Refer to the following diagram to implement the basic real-time communication and messaging functions in your project with the Agora RTC SDK, Agora RTM SDK, and Agora Edu Cloud Service.

![](https://web-cdn.agora.io/docs-files/1589367204617)

## Core API reference
- Agora Edu Cloud Service

| API | Function |
| ---------------- | ---------------- |
| [entry](https://github.com/AgoraIO-Usecase/eEducation/wiki/Agora-Edu-Cloud-Service#enter-a-classroom) | Enter a room. |
| [get room info](https://github.com/AgoraIO-Usecase/eEducation/wiki/Agora-Edu-Cloud-Service#initialize-a-classroom) | Get the room info. |
| [change room info](https://github.com/AgoraIO-Usecase/eEducation/wiki/Agora-Edu-Cloud-Service#change-room-info) | Change the room info. |
| [change user info](https://github.com/AgoraIO-Usecase/eEducation/wiki/Agora-Edu-Cloud-Service#change-user-info) | Change the user info. |
 
- Agora RTM SDK

| API | Function |
| ---------------- | ---------------- |
| [createInstance](https://docs.agora.io/en/Real-time-Messaging/API%20Reference/RTM_java/classio_1_1agora_1_1rtm_1_1_rtm_client.html#a6411640143c4d0d0cd9481937b754dbf)    | Creates an RtmClient object.      |
| [login](https://docs.agora.io/en/Real-time-Messaging/API%20Reference/RTM_java/classio_1_1agora_1_1rtm_1_1_rtm_client.html#a995bb1b1bbfc169ee4248bd37e67b24a) | Logs into the Agora RTM system. |
| [createChannel](https://docs.agora.io/en/Real-time-Messaging/API%20Reference/RTM_java/classio_1_1agora_1_1rtm_1_1_rtm_client.html#a95ebbd1a1d902572b444fef7853f335a) | Creates an Agora RTM channel. You can create multiple channels with an RtmClient object. |
| [join](https://docs.agora.io/en/Real-time-Messaging/API%20Reference/RTM_java/classio_1_1agora_1_1rtm_1_1_rtm_channel.html#ad7b321869aac2822b3f88f8c01ce0d40) | Joins an Agora RTM channel. |
| [ceateMessage](https://docs.agora.io/en/Real-time-Messaging/API%20Reference/RTM_java/classio_1_1agora_1_1rtm_1_1_rtm_client.html#a77dbd15cb6c9db3844fb313bd5dceac3) | Creates an RtmMessage object.  |
| [sendMessage](https://docs.agora.io/en/Real-time-Messaging/API%20Reference/RTM_java/classio_1_1agora_1_1rtm_1_1_rtm_channel.html#a6e16eb0e062953980a92e10b0baec235) | Sends a channel message, which can be received by all the users in the channel. |
| [leave](https://docs.agora.io/en/Real-time-Messaging/API%20Reference/RTM_java/classio_1_1agora_1_1rtm_1_1_rtm_channel.html#a9e0b6aad17bfceb3c9c939351a467d14) | Leaves the RTM channel. |
| [logout](https://docs.agora.io/en/Real-time-Messaging/API%20Reference/RTM_java/classio_1_1agora_1_1rtm_1_1_rtm_client.html#a6f5695854e251ddd4ba05547ab47b317) | Logs out of the RTM system. |

- Agora RTC SDK


| API | Function |
| ---------------- | ---------------- |
| [create](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a35466f690d0a9332f24ea8280021d5ed)      | Creates an RtcEngine object.      |
| [enableVIdeo](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a99ae52334d3fa255dfcb384b78b91c52) | Enables the video module. |
| [setVideoEncoderConfiguration](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#af5f4de754e2c1f493096641c5c5c1d8f) | Sets the video encoder configuration. |
| [setupLocalVideo](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a1fa43a5ce24196e840bcb1062cadbf23) | Sets the local video view. |
| [joinChannel](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a8b308c9102c08cb8dafb4672af1a3b4c) | Joins an Agora RTC channel. You can call [startPreview](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a9143c9bb03165fe8b07c0c1e5a455ffb) to start the local video preview before joining a channel. |
| [setupRemoteVideo](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a0e9f693c9bc2ccb91554c2c7dc6b7140) | Sets the remote video view.|
| [leaveChannel](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a2929e4a46d5342b68d0deb552c29d597) | Leaves the RTC channel. |

<div class="alert note">The default channel profile of the Agora RTC SDK is Communication profile.</div>


## Additional functions

For more features and functions available for an  online class, you can refer to the following:


<details>
<summary>Monitor the network quality</summary>
Use the <code>onNetworkQuality</code> callback of the Agora RTC SDK  to monitor the last-mile uplink and downlink network quality of every user in the channel. 
For more methods for reporting the real-time network quality, see the following guides:
<li><a href="https://docs.agora.io/en/Interactive%20Broadcast/lastmile_quality_android?platform=Android">Lastmile Tests</a></li>
<li><a href="https://docs.agora.io/en/Interactive%20Broadcast/in-call_quality_android?platform=Android">In-call Stats</a></li>
</details>
<details>
<summary>Mute the local audio or video</summary>
Call the following methods provided by the Agora RTC SDK:
<li><code>muteLocalAudioStream</code>, to stop or resume sending the local audio stream.</li>
<li><code>muteLocalVideoStream</code>, to stop or resume sending the local video stream.</li>
</details>
<details>
<summary>Voice detection</summary>
For RTC SDKs later than v2.9.2, you can enable voice detection by calling <code>enableAudioVolumeIndication</code>, and setting the <code>report_vad</code> parameter as <code>true</code>.
Once enabled, the <code>onAudioVolumeIndication</code> callback reports whether the local user is speaking in the <code>AudioVolumeInfo</code> struct.
</details>
<details>
<summary>Whiteboard</summary>
Implement the following whiteboard functions in your project:
	<li><a href="https://developer.netless.link/android-en/home/android-create-room">Create room/Get room information</a></li>
	<li><a href="https://developer.netless.link/android-en/home/android-document">Document Conversion</a></li>
		<li><a href="https://developer.netless.link/android-en/home/android-state">State Managment</a></li>
	<li><a href="https://developer.netless.link/android-en/home/android-tools">Tools</a></li>
	<li><a href="https://developer.netless.link/android-en/home/android-view">Perspective Operation</a></li>
	<li><a href="https://developer.netless.link/android-en/home/android-operation">Whiteboard Operation</a></li>
	<li><a href="https://developer.netless.link/android-en/home/android-scenes">Page (Scene) Management</a></li>
</details>


## Open-source demo project

Agora provides an open-source demo for [One-to-one Online Clasroom](https://github.com/AgoraIO-Usecase/eEducation) on GitHub to download as a source code reference.