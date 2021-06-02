---
title: Build a Client for the Student
platform: Web
updatedAt: 2021-02-03 09:45:29
---
This section describes how to implement a Web client for the student.

## Integrate the SDK

Refer to the following table to download the SDKs, and integrate the SDKs into your project.


| Product | SDK download | Integration guide |
| ---------------- | ---------------- | ---------------- | 
| [RTC (Real-time Communication) SDK](https://docs.agora.io/en/Interactive%20Broadcast/product_live?platform=All%20Platforms)      | [Agora SDK for Web](https://docs.agora.io/en/Interactive%20Broadcast/downloads)      | [Start Interactive Live Streaming](https://docs.agora.io/en/Interactive%20Broadcast/start_live_web?platform=Web) |
| [RTM (Real-time Messaging) SDK](https://docs.agora.io/en/Real-time-Messaging/product_rtm?platform=All%20Platforms) | [Real-time Messaging SDK](https://docs.agora.io/en/Real-time-Messaging/downloads) | [Peer-to-peer or Channel Messaging](https://docs.agora.io/en/Real-time-Messaging/messaging_web?platform=Web) |
| Agora Room Management Service | N/A | [Agora Room Management Service](https://agoradoc.github.io/en/edu-cloud-service/restfulapi) |
| [Whiteboard](https://developer.herewhite.com/javascript-en/home) | [White SDK](https://developer.herewhite.com/javascript-en/home/install) | N/A |


## Core API call sequence

Refer to the following diagrams to implement the basic real-time communication and messaging functions in your project with the Agora RTC SDK, Agora RTM SDK, and Agora Room Management Service.

<div class="alert info">The Agora Edu SDK is a wrapper around the Agora RTC SDK, Agora RTM SDK and Agora Room Management Service with more scenario-oriented and easy-to-use APIs. The Agora Edu SDK is in the alpha stage. You can submit an <a href="https://github.com/AgoraIO-Usecase/eEducation">issue</a> if you have any problem.</div>

### Basic process

![](https://web-cdn.agora.io/docs-files/1605265124854)

### Sends a request to speak up

![](https://web-cdn.agora.io/docs-files/1605265137200)

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
