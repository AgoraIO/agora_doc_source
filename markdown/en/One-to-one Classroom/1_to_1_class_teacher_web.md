---
title: Build a Client for the Teacher
platform: Web
updatedAt: 2020-05-13 19:10:25
---
This section describes how to implement a web client for the teacher.

## Flowchart

This flowchart shows the major logic of the following functions:

- The teacher joins and leaves the classroom:

![](https://web-cdn.agora.io/docs-files/1585127810582)

- Recording:

![](https://web-cdn.agora.io/docs-files/1582536970924)

## Integrate the SDK

Refer to the following table to download the SDKs, and integrate the SDKs into your project.


| Product | SDK download | Integration guide |
| ---------------- | ---------------- | ---------------- | 
| [RTC (Real-time Communication) SDK](https://docs.agora.io/en/Video/product_video?platform=All%20Platforms)      | [ Agora SDK for Web](https://docs.agora.io/en/Video/downloads)      | [Start a Video Call](https://docs.agora.io/en/Video/start_call_web?platform=Web) |
| [RTM (Real-time Messaging) SDK](https://docs.agora.io/en/Real-time-Messaging/product_rtm?platform=All%20Platforms) | [Real-time Messaging SDK](https://docs.agora.io/en/Real-time-Messaging/downloads) | [Peer-to-peer or Channel Messaging](https://docs.agora.io/en/Real-time-Messaging/messaging_web?platform=Web) |
| [Cloud Recording](https://docs.agora.io/en/cloud-recording/product_cloud_recording?platform=All%20Platforms) | / | [Record by RESTful API](https://docs.agora.io/en/cloud-recording/cloud_recording_rest?platform=All%20Platforms) |
| Agora Room Management Service | / | [Agora Room Management Service quickstart](https://github.com/AgoraIO-Usecase/eEducation/wiki/Agora-Edu-Cloud-Service) |
| [Whiteboard](https://developer-en.netless.link/docs/javascript/overview/js-outline/) | [White SDK](https://developer-en.netless.link/docs/javascript/guide/js-sdk/) | [Whiteboard quickstart](https://developer.netless.link/javascript-en/home/install) |


## Core API call sequence

Refer to the following diagram to implement the various functions in your project with the Agora RTC SDK, Agora RTM SDK, and Agora Room Management Service.

![](https://web-cdn.agora.io/docs-files/1589367492967)

## Core API reference

- Agora Room Management Service

| API | Function |
| ---------------- | ---------------- |
| [entry](https://github.com/AgoraIO-Usecase/eEducation/wiki/Agora-Edu-Cloud-Service#enter-a-classroom) | Enter a room. |
| [get room info](https://github.com/AgoraIO-Usecase/eEducation/wiki/Agora-Edu-Cloud-Service#initialize-a-classroom) | Get the room info. |
| [change room info](https://github.com/AgoraIO-Usecase/eEducation/wiki/Agora-Edu-Cloud-Service#change-room-info) | Change the room info. |
| [change user info](https://github.com/AgoraIO-Usecase/eEducation/wiki/Agora-Edu-Cloud-Service#change-user-info) | Change the user info. |
 
- Agora RTM SDK

| API | Function | 
| ---------------- | ---------------- | 
| [createInstance](https://docs.agora.io/en/Real-time-Messaging/API%20Reference/RTM_web/modules/agorartm.html#createinstance)      | Creates an RTM Client object.      |
| [login](https://docs.agora.io/en/Real-time-Messaging/API%20Reference/RTM_web/classes/rtmclient.html#login) | Logs into the Agora RTM system. |
| [createChannel](https://docs.agora.io/en/Real-time-Messaging/API%20Reference/RTM_web/classes/rtmclient.html#createchannel) | Creates an Agora RTM channel. You can create multiple channels with an RtmClient object. |
| [join](https://docs.agora.io/en/Real-time-Messaging/API%20Reference/RTM_web/classes/rtmchannel.html#join) | Joins an Agora RTM channel. |
| [sendMessage](https://docs.agora.io/en/Real-time-Messaging/API%20Reference/RTM_web/classes/rtmchannel.html#sendmessage) | Sends a channel message, which can be received by all the users in the channel. |
| [leave](https://docs.agora.io/en/Real-time-Messaging/API%20Reference/RTM_web/classes/rtmchannel.html#leave) | Leaves the RTM channel.|

- Agora RTC SDK

| API | Function |
| ---------------- | ---------------- |
| [createClient](./API%20Reference/web/v3.3.1/globals.html#createclient)      | Creates an RTC Client object.      |
| [Client.init](./API%20Reference/web/interfaces/agorartc.client.html#init) | Initializes the RTC Client object. | 
| [createStream](./API%20Reference/web/v3.3.1/globals.html#createstream) | Creates a Stream object for sending and receiving audio and video. |
| [Stream.init](./API%20Reference/web/interfaces/agorartc.stream.html#init) | Initializes the Stream object. |
| [Client.join](./API%20Reference/web/interfaces/agorartc.client.html#join) | Joins an Agora RTC channel. |
| [Client.publish](./API%20Reference/web/interfaces/agorartc.client.html#publish) | Publishes the local audio and video stream to SD-RTN. |
| [Client.on](./API%20Reference/web/interfaces/agorartc.client.html#on)("stream-added") | Occurs when a remote audio or video stream is added to the channel. |
| [Client.subscribe](./API%20Reference/web/interfaces/agorartc.client.html#subscribe) | Subscribes to the remote audio or video stream.|
| [Stream.play](./API%20Reference/web/interfaces/agorartc.stream.html#play) | Plays the audio or video stream.|
| [Client.leave](./API%20Reference/web/interfaces/agorartc.client.html#leave) | Leaves the RTC channel. |

<div class="alert note">The default channel profile of the Agora RTC SDK is Communication profile. Agora recommends using the Communication profile, no matter whether the teacher enables both the camera and the screen sharing.</div>


## Additional functions

For more features and functions available for an  online class, you can refer to the following:


<details>
<summary>Monitor the network quality</summary>
Use the <code>on("network-quality")</code> callback of the Agora RTC SDK  to monitor the last-mile uplink and downlink network quality of every user in the channel. 
For more methods for reporting the real-time network quality, see the following guides:
<li><a href="https://docs.agora.io/en/Interactive%20Broadcast/lastmile_quality_web?platform=Web">Lastmile Tests</a></li>
<li><a href="https://docs.agora.io/en/Interactive%20Broadcast/in-call_quality_web?platform=Web">In-call Stats</a></li>
</details>
<details>
<summary>Mute the local audio or video</summary>
Call the following methods provided by the Agora RTC SDK:
	<li><code>muteAudio</code> or <code>unmuteAudio</code>, to stop or resume sending the local video stream.</li>
	<li><code>muteVideo</code> or <code>unmuteVideo</code>, to stop or resume sending the local video stream.</li>
</details>
 
<details>
<summary>Mute the remote audio or video</summary>
Use both the Agora RTC SDK and Agora RTM SDK to implement this function:
<ol>
	<li>Call <code>sendMessageToPeer</code> on the teacher's client to send a peer-to-peer message to the student, asking them to mute their audio or video.</li>
	<li>Call the corresponding <code>mute</code> methods on the student's client to mute their local audio or video.</li>
</ol>
</details>
<details>
<summary>Screen share</summary>
Refer to the following documents on screen sharing:
<li><a href="https://docs.agora.io/en/Video/screensharing_web?platform=Web#a-namechromeascreen-sharing-on-google-chrome">Screen Sharing on Goole Chrome</a></li>
<li><a href="https://docs.agora.io/en/Video/screensharing_web?platform=Web#a-name--ffascreen-sharing-on-firefox">Screen Sharing on Firefox</a></li>
</details>

<details>
<summary>Whiteboard</summary>
Implement the following whiteboard functions in your project:
	<li><a href="https://developer.netless.link/javascript-en/home/document-converter">Document conversion</a></li>
	<li><a href="https://developer.netless.link/javascript-en/home/business-state-management">Status Listen</a></li>
	<li><a href="https://developer.netless.link/javascript-en/home/tools">Tools</a></li>
	<li><a href="https://developer.netless.link/javascript-en/home/view">Perspective Operation</a></li>
	<li><a href="https://developer.netless.link/javascript-en/home/room-methods">Whiteboard Operation</a></li>
	<li><a href="https://developer.netless.link/document-en/home/scene-manangement">Page (Scene) Management</a></li>
</details>


## Open-source demo project

Agora provides an open-source demo for [One-to-one Class](https://github.com/AgoraIO-Usecase/eEducation/tree/master/education_web) on GitHub to download as a source code reference.