---
title: Build a Client for the Teaching Assistant
platform: Web
updatedAt: 2020-11-23 08:30:46
---
This section describes how to implement a Web client for the teaching assistant.

## Integrate the SDK

Refer to the following table to download the SDKs, and integrate the SDKs into your project.


| Product | SDK download | Integration guide |
| ---------------- | ---------------- | ---------------- | 
| [RTC (Real-time Communication) SDK](https://docs.agora.io/en/Interactive%20Broadcast/product_live?platform=All%20Platforms)      | [Agora SDK for Web](https://docs.agora.io/en/Interactive%20Broadcast/downloads)      | [Start Interactive Live Streaming](https://docs.agora.io/en/Interactive%20Broadcast/start_live_web?platform=Web) |
| [RTM (Real-time Messaging) SDK](https://docs.agora.io/en/Real-time-Messaging/product_rtm?platform=All%20Platforms) | [Real-time Messaging SDK](https://docs.agora.io/en/Real-time-Messaging/downloads) | [Peer-to-peer or Channel Messaging](https://docs.agora.io/en/Real-time-Messaging/messaging_web?platform=Web) |
| Agora Room Management Service | N/A | [Agora Room Management Service](https://agoradoc.github.io/en/edu-cloud-service/restfulapi) |
| [Whiteboard](https://developer.herewhite.com/javascript-en/home) | [White SDK](https://developer.herewhite.com/javascript-en/home/install) | N/A |


## Core API call sequence

Refer to the following diagrams to implement the basic real-time communication and messaging functions in your project with the Agora RTC SDK, Agora RTM SDK, and Agora Edu Cloud Service.

<div class="alert info">The Agora Edu SDK is a wrapper around the Agora RTC SDK, Agora RTM SDK and Agora Room Management Service with more scenario-oriented and easy-to-use APIs. The Agora Edu SDK is in the alpha stage. You can submit an <a href="https://github.com/AgoraIO-Usecase/eEducation">issue</a> if you have any problem.</div>

![](https://web-cdn.agora.io/docs-files/1605269114101)