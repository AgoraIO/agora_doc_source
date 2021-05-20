---
title: Build a Client for the Student
platform: Web
updatedAt: 2020-05-13 19:09:23
---
This section describes how to implement a Web client for the student.

## Flowchart

This flowchart shows the major logic of the students joining and leaving the classroom:

![](https://web-cdn.agora.io/docs-files/1582875834807)

## Integrate the SDK

Refer to the following table to download the SDKs, and integrate the SDKs into your project.


| Product | SDK download | Integration guide |
| ---------------- | ---------------- | ---------------- | 
| [RTC (Real-time Communication) SDK](https://docs.agora.io/en/Video/product_video?platform=All%20Platforms)      | [ Agora SDK for Web](https://docs.agora.io/en/Video/downloads)      | [Start a Video Call](https://docs.agora.io/en/Video/start_call_web?platform=Web) |
| [RTM (Real-time Messaging) SDK](https://docs.agora.io/en/Real-time-Messaging/product_rtm?platform=All%20Platforms) | [Real-time Messaging SDK](https://docs.agora.io/en/Real-time-Messaging/downloads) | [Peer-to-peer or Channel Messaging](https://docs.agora.io/en/Real-time-Messaging/messaging_web?platform=Web) |
| Agora Room Management Service | / | [Agora Room Management Service quickstart](https://github.com/AgoraIO-Usecase/eEducation/wiki/Agora-Edu-Cloud-Service) |
| [Whiteboard](https://developer-en.netless.link/docs/javascript/overview/js-outline/) | [White SDK](https://developer-en.netless.link/docs/javascript/guide/js-sdk/) | [Whiteboard quickstart](https://developer.netless.link/javascript-en/home/install) |


## Core API call sequence

Refer to the following diagram to implement the basic real-time communication and messaging functions in your project with the Agora RTC SDK, Agora RTM SDK, and Agora Room Management Service.

![](https://web-cdn.agora.io/docs-files/1589367413753)

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
| [createInstance](https://docs.agora.io/en/Real-time-Messaging/API%20Reference/RTM_web/modules/agorartm.html#createinstance)     | Creates an RTM Client object.      |
| [login](https://docs.agora.io/en/Real-time-Messaging/API%20Reference/RTM_web/classes/rtmclient.html#login) | Logs into the Agora RTM system. |
| [createChannel](https://docs.agora.io/en/Real-time-Messaging/API%20Reference/RTM_web/classes/rtmclient.html#createchannel) | Creates an Agora RTM channel. You can create multiple channels with an RtmClient object. |
| [join](https://docs.agora.io/en/Real-time-Messaging/API%20Reference/RTM_web/classes/rtmchannel.html#join) | Joins an Agora RTM channel. |
| [sendMessage](https://docs.agora.io/en/Real-time-Messaging/API%20Reference/RTM_web/classes/rtmchannel.html#sendmessage)  | Sends a channel message, which can be received by all the users in the channel. |
| [leave](https://docs.agora.io/en/Real-time-Messaging/API%20Reference/RTM_web/classes/rtmchannel.html#leave) | Leaves the RTM channel. |

- Agora RTC SDK


| API | Function |
| ---------------- | ---------------- |
| [createClient](./API%20Reference/web/v3.3.1/globals.html#createclient)        | Creates an RTC Client object.      |
| [Client.init](./API%20Reference/web/interfaces/agorartc.client.html#init) | Initializes the RTC Client object. |
| [Client.join](./API%20Reference/web/interfaces/agorartc.client.html#join) | Joins an Agora RTC channel. |
| [Client.on](./API%20Reference/web/interfaces/agorartc.client.html#on)("stream-added") | Occurs when a remote audio or video stream is added to the channel.  |
| [createStream](./API%20Reference/web/v3.3.1/globals.html#createstream) | Creates a Stream object for sending and receiving audio and video. |
| [Stream.init](./API%20Reference/web/interfaces/agorartc.stream.html#init) | Initializes the Stream object.  |
| [Client.publish](./API%20Reference/web/interfaces/agorartc.client.html#publish) | Publishes the local audio and video stream to SD-RTN. |
| [Client.subscribe](./API%20Reference/web/interfaces/agorartc.client.html#subscribe) | Subscribes to the remote audio or video stream.|
| [Stream.play](./API%20Reference/web/interfaces/agorartc.stream.html#play) | Plays the audio or video stream.|
| [Client.leave](./API%20Reference/web/interfaces/agorartc.client.html#leave) | Leaves the RTC channel. |

<div class="alert note">The default channel profile of the Agora RTC SDK is Communication profile. </div>


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

Agora provides an open-source demo for [One-to-one Clasroom](https://github.com/AgoraIO-Usecase/eEducation) on GitHub to download as a source code reference.