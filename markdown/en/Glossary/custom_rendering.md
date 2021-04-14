---
title: custom rendering
platform: All Platforms
updatedAt: 2020-07-03 20:47:08
---
Custom rendering is the process where developers collect raw data from the SDK and process it according to specific needs.

When the default audio or video renderer cannot meet requirements, developers can use an external audio or video renderer to render raw data. Common custom rendering scenarios are as follows:

- When storing the raw data in other engine for rendering, developers need to use the custom rendering function.
- When rendering animation, developers can use the custom rendering function.
- To avoid any conflict between real-time communication and other processes that may be working in parallel, developers can use an external audio or video renderer to render raw data.

<div class="alert info">Reference:<li><a href="https://docs.agora.io/en/Interactive%20Broadcast/custom_audio_android?platform=Android">Custom Audio Source and Renderer</a></li><li><a href="https://docs.agora.io/en/Interactive%20Broadcast/custom_video_android?platform=Android">Custom Video Source and Renderer</a></li></div>

<a href="./terms"><button>Back to glossary</button></a>