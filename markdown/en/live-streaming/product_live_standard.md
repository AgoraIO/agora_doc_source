---
title:  Interactive Live Streaming Standard Overview
platform: All Platforms
updatedAt: 2021-04-01 02:26:15
---
Agora Interactive Live Streaming Standard is a product designed for live streaming scenarios featuring “light interaction” between the host and audience. Light interaction in this case refers to situations that require a timely exchange of text messages, comments, or virtual gifts, with less reliance on audio or video communication. Typical scenarios include live online classes, live-stream shopping (e-commerce), trivia gaming, or live sports streaming.

The product adopts a UDP-based AUT protocol developed by Agora and relies on SD-RTN™, a software-defined real-time network built by Agora, to provide high-quality, low-latency live streaming experiences with good synchronization.

![](https://web-cdn.agora.io/docs-files/1606386150787)

## Live streaming solution comparison

The following table shows the differences between Agora live streaming products and traditional CDN live streaming:
<style>
table th:first-of-type {
    width: 100px;
}
table th:nth-of-type(2) {
    width: 200px;
}
table th:nth-of-type(3) {
    width: 200px;
}
	table th:nth-of-type(4) {
    width: 200px;
}
</style>

|                        | Agora Interactive Live Streaming Premium                     | Agora Interactive Live Streaming Standard                    | Traditional CDN live streaming                               |
| :--------------------- | :----------------------------------------------------------- | :----------------------------------------------------------- | ------------------------------------------------------------ |
| Typical scenarios      | Live streaming events where the host(s) and audience have frequent audio and video interactions that require ultra-low latency on the audiences' clients. | Live streaming events where the host(s) must be able to respond quickly to the audience's text messages, comments, and virtual rewards or that require less frequent audio and video interactions. | Live streaming events that do not require audio or video interactions. |
| Latency                |<ul><li>Latency on the host's client: < 400 ms</li> <li>Latency on the audience's client: 400 ms - 800 ms</li><ul> | Latency on the audience's client: 1500 ms - 2000 ms          | Latency on the audience's client: > 3000 ms                  |
| Synchronization        |<ul><li>Excellent synchronization between the host(s) and the audience</li><li>Excellent synchronization among the audience</li><ul> | <ul><li>Good synchronization between the host(s) and the audience</li><li>Good synchronization among the audience</li><ul> | <ul><li>Poor synchronization between the host(s) and the audience</li><li>Poor synchronization among the audience</li><ul> |
| Interactive experience | Excellent                                                    | Good                                                         | Poor                                                         |
| Pricing                | High                                                         | Moderate                                                     | Low                                                          |



<div class="alert note"> You can switch seamlessly from Interactive Live Streaming Standard to Interactive Live Streaming Premium with one API. After the switch, the latency on the audience's client can be reduced from 1500 ms - 2000 ms to 400 ms - 800 ms, and the audience and host can interact with each other via audio and video.</div>

## Scenarios

Together with the Agora RTM SDK, Interactive Live Streaming Standard enables you to implement the following live streaming scenarios:

| Scenario             | Description                                                  |
| :------------------- | :----------------------------------------------------------- |
| Lecture Hall         | In a large online class, the low latency of Interactive Live Streaming Standard allows the teacher's audio and video to be quickly synchronized to the clients of thousands of students. The low latency between the audio and video of the teacher and the courseware makes real-time teaching more effective. Students can interact with the teacher through text messages, online quizzes, and similar means to enhance the learning experience. |
| Showroom             | In a showroom live streaming, the audience can send virtual gifts to the host. Thanks to the low latency of Interactive Live Streaming Standard, the host can promptly thank the audience for their gifts, and the audience can receive the host's thanks in a timely fashion, which helps to strengthen the emotional connection on both sides. |
| Live-stream Shopping | In a live-stream shopping scenario, customers can ask sellers for product and activity information via real-time messages. The low latency of Interactive Live Streaming Standard allows sellers to quickly respond to customers' questions, and customers can promptly see sellers' answers, thus encouraging transactions. In addition, the high synchronization of Interactive Live Streaming Standard ensures a consistent experience on the audiences' clients for activities such as responding to flash sales, and grabbing time-sensitive offers (seckilling) and coupons. |
| Live match streaming | Live streaming sporting events or games in real time, synchronized so that there are no problematic delays. |
| Trivia Game          | Apart from providing a smooth live streaming experience, the high synchronization of Interactive Live Streaming Standard also ensures that players receive the questions at the same time. This gives the audience members the same amount of time to answer—and an equal chance to win. |

## Functions

Interactive Live Streaming Standard boasts a flexible combination of functions for different scenarios.

| Function                                | Description                                                  |
| :-------------------------------------- | :----------------------------------------------------------- |
| Single Host                             | Low-latency live streaming by one host. The audience can join the channel and watch the live streaming. |
| Becoming a host                         | An audience member can switch their user role and become a host. Then they can interact with other hosts via audio and video. |
| Co-hosting across channels              | Hosts interact with each other across channels.              |
| Audio mixing                            | Hosts combine the audio of a local or online file with their own voice, and then send it out in the channel. |
| Basic image enhancement                 | Sets basic beauty effects in a video call, including skin smoothening, whitening, and cheek blushing. |
| Screen sharing                          | Hosts share their screens with the audience in the channel. Supports sharing the whole or part of a window or screen. |
| Modify the raw data                     | Developers obtain and modify the raw voice or video data of the SDK engine to create special effects, such as voice-changing effects. |
| Inject an online media stream           | Injects an external audio or video stream into an ongoing interactive live streaming channel. The host and audience in the channel can listen to or watch the stream while interacting with each other. You can set the attributes of the video source. |
| Customize the video source and renderer | Users process videos (from self-built cameras, screen sharing, or files) for image enhancement and filtering. |
| Push streams to the CDN                 | The host publishes the audio and video in the channel to the CDN (Content Delivery Network):<ul><li>Starts or stops publishing at any time.<li>Adds or removes an address while continuously publishing the stream.<li>Adjusts the picture-in-picture layout.</li><ul> |

## Properties

| Property                    | Agora specifications                                         |
| :-------------------------- | :----------------------------------------------------------- |
| SDK package size            | 4.61 MB to 10.41 MB                                          |
| Host capacity               | Up to 17 users                                               |
| Audience capacity           | Up to 1 million users                                        |
| Audio profile               | <li>Sample rate: 16 kHz to 48 kHz.<li>Support for mono and stereo sound.</li> |
| Video profile               | <li>SDK video source: Up to 1080p @ 60 fps.<li>Custom video source: Up to 4K resolution.</li> |
| Audio anti-packet-loss rate | 70% (uplink and downlink)                                    |

## Compatibility

The platform compatibility of Interactive Live Streaming Standard is as follows:

- For the host‘s client, Interactive Live Streaming Standard supports platforms including Android, iOS, macOS, Windows, Web, and cross-platform frameworks (Unity, Electron, React Native, and Flutter).
- For the audience's client, Interactive Live Streaming Standard supports platforms including Android, iOS, macOS, and Windows. 

The following table lists the version requirements of different platforms:

| Platform | Supported Version                                            |
| :------- | :----------------------------------------------------------- |
| Android  | 4.1+<br>The Android SDK supports the following ABIs:<li>armeabi-v7a<li>arm64-v8a<li>x86<li>x86-64 </li>|
| iOS      | 8.0+                                                         |
	| Windows  | Windows 7+<br>The Windows SDK supports the following architectures:<li>x86<li>x86-64</li> |
| macOS    | 10.0+                                                        |
| Unity    | 2017+ <br>The Unity SDK supports the following platforms:<li>Android (armeabi-v7a, arm64-v8a, x86)<li>iOS<li>Windows (x86, x86-64)<li>macOS</li> |
| Web      | <li>Google <li>Chrome 58+<li>Chrome 49 (Windows XP only)<li>Firefox 56+<li>Safari 11+<li>Opera 45+<li>QQ Browser 10.5+<li>360 Secure Browser 9.1+<li>Edge Browser 80+ </li>The browser support on the Web platform varies with the device and system. See [Which browsers does the Agora Web SDK support?](https://docs.agora.io/en/All/faq/browser_support) |

## Billing

Contact [sales@agora.io](mailto:sales@agora.io) for detailed billing rates for Interactive Live Streaming Standard.