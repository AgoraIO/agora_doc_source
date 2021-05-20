---
title: Agora Live Interactive Audio Streaming Overview
platform: All_Platforms
updatedAt: 2020-12-01 03:06:07
---
The Agora Native SDK for Audio Broadcasting enables one-to-many and many-to-many audio live streaming. Different from the traditional CDN live broadcast, which only allows one-way communication from the hosts to the audience, the Agora SDK for Interactive Broadcast empowers the audience to interact with the hosts through [hosting-in](https://docs.agora.io/en/Agora%20Platform/terms?platform=All%20Platforms#hosting-in), like a viewer jumping onto the stage in the middle of a play to perform. The Agora Native SDK for Interactive Broadcast is applicable to scenarios that encourage active engagement, such as game-playing, online classes for students in small groups, and Q&A sessions during E-commerce live streaming.

## Functions and Scenarios

The Agora Native SDK for Audio Broadcasting boasts a flexible combination of functions for different scenarios.

| Function                              | Description                                                  | Scenario                                                     |
| ------------------------------------- | ------------------------------------------------------------ | ------------------------------------------------------------ |
| Host-in at the Client Side         | An audience switches to a co-host and interacts with the existing host. | <li>Large-scale live streams where hosts can invite the audience to interact with them. <li>Online games such as Murder Mystery and Werewolf Killing. |
| Host-in across Channels            | Hosts interact with each other across channels.    | PK Hosting.                                                  |
| Audio Mixing                          | Sends the local and online audio with the user's voice to other audience members in the channel. | <li>Online KTV. <li>Interactive music classes for children.    |
| Screen Sharing                        | Hosts share their screens with the audience in the channel. | <li>Interactive online classes.<li>Live streaming of gaming hosts. |
| Modify the Raw Data                    | Developers obtain and modify the raw voice data of the SDK engine to create special effects, such as a voice change. | <li>To change the voice in an online voice chatroom.<li>Image enhancement in a live stream. |
| Inject an Online Media Stream         | Injects an external audio stream to an ongoing live broadcast channel. The host and audience in the channel can listen to or watch the stream while interacting with each other. You can set the attributes of the audio source. | <li>The host and audience listening to a concert together.    |
| Push Streams to the CDN                | Sends the audio of your channel to other RTMP servers through the CDN:<li>Starts or stops publishing at any time.<li>Adds or removes an address while continuously publishing the stream. <li>Adjusts the picture-in-picture layout. | <li>To send a live stream to WeChat or Weibo.<li>To allow more people to watch the live stream when the number of audience members in the channel reached the limit. |

See the following sample code for application scenarios:

- [PK Hosting](https://github.com/AgoraIO/ARD-Agora-Online-PK/blob/master/README.zh.md)
- [Trivia Game](https://github.com/AgoraIO/HQ)
- [Online KTV](https://github.com/AgoraIO/Agora-Online-KTV/blob/master/README.zh.md)
- [Online Voice Chatroom](https://github.com/AgoraIO-Usecase/Chatroom)
- [Clip Doll Machine](https://github.com/AgoraIO/Wawaji)
- [Murder Mystery Game](https://github.com/AgoraIO-Usecase/Murder-Mystery-Game)

## Key Properties

| Property                                          | Agora Live Broadcast Specifications                          |
| ------------------------------------------------- | ------------------------------------------------------------ |
| SDK Package Size                                  | 3.69 MB to 7.75 MB                                              |
| Host Capacity                                     | 17 users                                                  |
| Audience Capacity                                 | One million users                                       |
| Audio Profile                                     | <li>Sample rate: 16 KHz to 48 KHz.<li>Support for mono and stereo sound  |
| Audio Anti-packet-loss Rate                       | 70% (uplink and downlink)                               |
| Latency between the Host and the Host-in Audience/Host | 200 ms to 600 ms                                                  |

## Compatibility

The Agora Native SDK for Interactive Broadcast is supported on platforms such as iOS, Android, Windows, macOS, Linux, Web, and WeChat Mini-programs, and allows for cross-platform connections. The following is a list of supported platforms and their versions.

<table>
  <tr>
    <th>Platform</th>
    <th>Supported Version</th>
  </tr>
  <tr>
    <td>Android</td>
		<td><p>4.1+</p>
			<p>The Android SDK supports the following architecture:</p>
			<ul><li>ARMv7</li>
				<li>ARM64</li>
				<li>X86</li></ul></td>
  </tr>
  <tr>
    <td>iOS</td>
    <td>8.0+</td>
  </tr>
	  <tr>
    <td>Windows</td>
    <td>XP SP3+</td>
  </tr>
  <tr>
    <td>macOS</td>
    <td>10.0+</td>
  </tr>
  <tr>
    <td>WeChat Mini-Programs</td>
    <td>Support</td>
  </tr>
  <tr>
    <td>Web</td>
		<td><ul><li>Chrome 58+</li>
			<li>Firefox 56+</li>
			<li>Safari 11+</li>
			<li>Opera 45+</li>
			<li>QQ 10+</li>
            <li>360 Security Browser 9.1+</li></ul></td>
  </tr>
</table>