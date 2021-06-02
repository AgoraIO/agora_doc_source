---
title: Agora Platform Overview
platform: All_Platforms
updatedAt: 2020-11-16 09:42:20
---
Agora.io provides the building blocks developers need to add real-time voice and video communications through a simple, powerful SDK. Integrate Agora SDK and enable real-time communications within 30 minutes.

![](https://web-cdn.agora.io/docs-files/1542873804344)

## Agora SDK

After integrating Agora SDK, you can call different sets of APIs to implement voice/video communications in different scenarios. 

| Agora SDK  | Supported Scenarios                   | Description                                                  |
| ---------- | ------------------------------------ | ------------------------------------------------------------ |
| Voice SDK  | [Voice Call](/en/Voice/product_voice) <br>[Interactive Broadcast](/en/Interactive%20Broadcast/product_live) | SDK package size is smaller and applies to audio-only calls and <br>live broadcasts. <sup>[1]</sup> |
| Video SDK  | [Video Call](/en/Video/product_video) <br>[Interactive Broadcast](/en/Interactive%20Broadcast/product_live) | Provides both audio and video functions. |
| Gaming SDK | [Interactive Gaming](/cn/Interactive%20Gaming/product_gaming)                   | Optimized for gaming applications. The package size is about 1 M. |
| Recording Add-on  | [Recording](/en/Recording/product_recording)                     | Records and saves voice/video calls and broadcasts on your server. |
| Signalling Add-on | [Signalling](/en/Signaling/product_signaling)                    | Based on the TCP protocol and provides a stable messaging channel for real-time communication scenarios. |

> [1] Only supports Android and iOS for now.

## Self-built Infrastructure: SD-RTN（Software Defined Real-time Network）

SD-RTN (Software Defined Real-time Network) is the real-time transmission network built by Agora itself. Actually, all the audio and video services provided by Agora SDK are dispatched and transmitted through SD-RTN, which is the only network infrastructure specifically designed for real-time communication in the world.
Currently, Agora has deployed nearly 200 data centers worldwide that use intelligent dynamic routing algorithm to achieve millisecond latency and ensure high availability of our service.

| Feature                                         | Description                                                  |
| ----------------------------------------------- | ------------------------------------------------------------ |
| Global network coverage                         | <li>Covers 200+ countries<li>Covers 100+ telecommunication providers in China |
| Mass access capability                          | <li>Supports multiple intelligent terminal access<li>A single channel can support a million people online at the same time |
| QoS (Quality of Service) capability enhancement | <li>Prevents network congestion in advance<li>Weak network anti-loss guarantee |
| QoS-based dynamic routing                       | <li>Comprehensive assessment of network resources<li>QoS optimal path guarantee |
| SLA (Service Level Agreement) guarantee         | <li>7 &times; 24 support, including ticket system/IM/community<li>One-to-one VIP service |
| Global network reliability                      | <li>Global network availability: 99.999%<li>Invisible core business, such as anti-DDoS<li>More than 99.9% global 5-second landing success rate |
| Compatibility and Interoperability              | <li>Support for 6000+ devices <li>Support for iOS, Android, Windows, MacOS, Linux, CoCos, Unity, and so on |
| UDP (User Datagram Protocol) optimization       | Optimizes multiple private protocols based on the UDP        |
| Self-developed audio and video codecs           | <li>Efficient use of network resources<li>Self-developed SOLO, NOVA codecs |
| Anti-packet-loss optimization                   | Algorithm for optimizing anti-packet-loss mechanism under weak network conditions; audio anti-packet-loss rate 70% |

## Self-developed Audio and Video Codecs

Agora is the only RTC service provider who uses self-developed audio and video codecs in the world. Therefore, we have unique advantages on audio and video qualities.

## Audio

- High fidelity, 3D surround sound experience:

- 48 KHz full-band acquisition: Highly restored acoustic sound
- 3A algorithm based on machine learning: Echo cancellation, automatic gain, noise suppression
- Hearing enhancement: Stereo, 3D surround sound, sound localization, audio mixing, reverberation effects, in-ear monitoring, voice change

## Video

- Immersive visual experience

- Continuous network detection: Network detection before and after encoding, network friendly
- Dynamic network flow control: Maintains a dynamic balance of network bandwidth resources
- Highly efficient anti-loss coding products: Optimized coding algorithm, smooth video transmission, prevents network impact
- Packet loss compensation: Automatically repairs the content to ensure the experience
- Visual enhancement: Image enhancement based on machine learning

## Developer Tools and Support

- The [Developer Center](https://docs.agora.io/en) provides documentation for developers to integrate and use Agora SDKs, and SDK and sample code downloads.
- [Agora Dashboard](https://dashboard.agora.io/) is a self-service system that enables the developers to monitor the usage statistics, track the QoE, manage the projects, manage the account privileges, and submit the tickets.
- [Sample apps and use cases on Github](https://github.com/AgoraIO)
- 5 &times; 8 technical support. Developers can ask questions about integration on [Stack Overflow](https://stackoverflow.com/questions/tagged/agora.io), and [submit tickets](https://dashboard.agora.io/show-ticket-submission) for quality issues.
- [Agora Dashboard](<https://dashboard.agora.io/>) provides a tool (Agora Analytics) to track the QoE (Quality of Experience), which presents rich data in the whole process of a call in diagrams,for example:

  - Device status, including the system CPU usage and the App CPU usage
  - User events, for example stopping sending audio or starting receiving video
  - The bitrates of the sent/received audio and video
  - The freeze time in rendering the audio and video
  - The packet loss rates of the audio and video

  You can quickly tell how the QoE is and identify the issues from the diagrams. [Check out](https://dashboard.agora.io/analytics/call/tutorial) how you can analyze your calls with Agora Analytics.