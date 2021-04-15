---
title: What is the difference between Agora Live Interactive Streaming and common CDN + RTMP technologies?
platform: ["Android","iOS","macOS","Web","Windows","Unity","Cocos Creator","微信小程序","Electron","React Native","Flutter"]
updatedAt: 2020-07-06 16:12:32
Products: ["Interactive Broadcast"]
---
Most CDN + RTMP technologies for live streaming allow users to watch the live steaming in a web browser, which lowers the audience's threshold. 
Agora provides a solution for SD-RTN™, host, and audience to have the same real-time communication quality as an individual line with:

- Private voice and video coding
- Private transport protocol
- Private node deployment
- Private transmission algorithms

See the following table for details:

| Feature                | CDN + RTMP        | Agora Live Interactive Streaming                                  |
| --------------------------- | ----------------- | ------------------------------------------------------------ |
| Video Encoding and Decoding | H.264             | Private                                                      |
| Audio Encoding and Decoding | AAC               | Private                                                      |
| Transport Protocol          | TCP based on RTMP | Private protocol based on UDP                                |
| Transmission Algorithm      | TCP               | Private algorithm for fixing packet loss and adjusting the bitrate automatically according to the current bandwidth |
| Picture-in-picture layout   | Fixed             | Can be adjusted dynamically                                  |

Agora also enables the function of [publishing streams into the CDN](https://docs.agora.io/en/Interactive%20Broadcast/cdn_streaming_android?platform=Android) for social media sharing.