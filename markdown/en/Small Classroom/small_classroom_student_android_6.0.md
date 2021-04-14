---
title: Build a Client for the Student
platform: Android
updatedAt: 2021-02-03 09:45:24
---
This section describes how to implement an Android client for the student.

## Integrate the SDK

Refer to the following table to download the SDKs, and integrate the SDKs into your project.


| Product | SDK download | Integration guide |
| ---------------- | ---------------- | ---------------- |
| [RTC (Real-time Communication) SDK](https://docs.agora.io/en/Interactive%20Broadcast/product_live?platform=All%20Platforms)      | [Agora SDK for Android](https://download.agora.io/sdk/release/Agora_Native_SDK_for_Android_v2_9_0_102_FULL_20200216_1288.zip)      | [Start Interactive Live Streaming](https://docs.agora.io/en/Interactive%20Broadcast/start_live_android?platform=Android) |
| [RTM (Real-time Messaging) SDK](https://docs.agora.io/en/Real-time-Messaging/product_rtm?platform=All%20Platforms) | [Real-time Messaging SDK](https://docs.agora.io/en/Real-time-Messaging/downloads) | [Peer-to-peer or Channel Messaging](https://docs.agora.io/en/Real-time-Messaging/messaging_android?platform=Android) |
| Agora Room Management Service | N/A | [Agora Room Management Service](https://agoradoc.github.io/en/edu-cloud-service/restfulapi) |
| [Whiteboard](https://developer.herewhite.com/android-en/home) | [White SDK](https://developer.herewhite.com/android-en/home/android-prepare) | N/A |


## Core API call sequence

Refer to the following diagrams to implement the basic real-time communication and messaging functions in your project with the Agora RTC SDK, Agora RTM SDK, and Agora Edu Cloud Service.

<div class="alert info">The Agora Edu SDK is a wrapper around the Agora RTC SDK, Agora RTM SDK and Agora Room Management Service with more scenario-oriented and easy-to-use APIs. The Agora Edu SDK is in the alpha stage. You can submit an <a href="https://github.com/AgoraIO-Usecase/eEducation">issue</a> if you have any problem.</div>

### Basic process

![](https://web-cdn.agora.io/docs-files/1605260564594)

### Update the classroom information

![](https://web-cdn.agora.io/docs-files/1605261018444)

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
