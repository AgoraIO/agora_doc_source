---
title: custom source
platform: All Platforms
updatedAt: 2020-07-03 20:47:24
---
Custom source is the process where an app captures raw data by itself. With the custom source function enabled, the Agora SDK does not capture any raw data.

By default, the Agora SDK captures raw data from built-in audio and video input devices. When the Agora SDK does not meet requirements, developers can use custom source function to capture raw data. Typical custom source scenarios include the following: 

- In video conferences, hosts need to share a non-camera source, such as recorded screen data.
- When storing the raw data in another engine for processing, developers need to use the custom source function.
- To avoid any conflict between real-time communication and other processes that may be working in parallel, developers can use an external audio or video input device to capture raw data.

<div class="alert info">Reference:<li><a href="https://docs.agora.io/en/Interactive%20Broadcast/custom_audio_android?platform=Android">Custom Audio Source and Renderer</a></li><li><a href="https://docs.agora.io/en/Interactive%20Broadcast/custom_video_android?platform=Android">Custom Video Source and Renderer</a></li></div>

<a href="./terms"><button>Back to glossary</button></a>