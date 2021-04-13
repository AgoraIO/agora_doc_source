---
title: Agora On-premise Recording Overview
platform: All_Platforms
updatedAt: 2021-02-18 07:08:33
---
<div class="alert note">Note: <br>If you do not want to prepare server resources, Agora recommends using <a href="https://docs.agora.io/en/cloud-recording/product_cloud_recording?platform=Linux">Agora Cloud Recording</a>, which enables you to record voice/video calls and interactive broadcastsis on your cloud storage through RESTful APIs.  </div>

The Agora On-premise Recording SDK is an add-on to record and save voice calls, video calls, and interactive broadcasts on your server. The Agora On-premise Recording SDK is compatible with the Agora Native SDK v1.7.0+ and the Agora Web SDK v1.12.0+.

For example, a user can either attend an online course at the time of the course or watch the recorded course later; made possible by the Agora On-premise Recording SDK being deployed at the server by the online course provider.

## Functions

The Agora On-premise Recording SDK enables you to record high-quality voice or video calls made via the [Agora RTC SDK](https://docs.agora.io/en/Agora%20Platform/terms?platform=All%20Platforms#rtc-sdk). See the following table for details.

| Function                                                     | Description                                                  |
| :----------------------------------------------------------- | :----------------------------------------------------------- |
| Choose audio and/or video                                    | You can choose to record the following content:<li>Record only audio.Record only video.<li>Record both audio and video. |
| Choose recording mode                                        | You can choose one of the following recording modes:<li>[Individual Recording](./individual_recording): The SDK generates audio and/or video files for each UID.<li>[Composite Recording](./composite_recording): The SDK packs the audio of all UIDs in the channel into one audio file, and the video of all UIDs into one video file. You can also set the audio and video profile of the recording file. |
| [Set the video layout](./recording_layout_guide) | You need to do the following things in composite recording mode:<li>Set the size and position of the region for each user in the layout.<li>Set the background images associated with each user.<li>Set the background image of the canvas. |
| [Get the raw data](./recording_raw_data) | You can get the following raw data: <li>Raw audio data in AAC or PCM formats.<li>Raw video data in H.264 or YUV formats. |
| [Capture Screenshots](./recording_screen_capture) | In individual recording mode, you can get one recording file and multiple screenshots in JPEG format for each UID, or only get screenshots in JPEG format.In composite recording mode, you can get a video file in MP4 format and multiple screenshots in JPEG format. |
| Use the proxy                                                | You can configure the proxy server or [Use Cloud Proxy](./cloudproxy_recording) to connect to Agora's services through a firewall. |
| Record dual streams                                          | If you enable the [dual-stream mode](https://docs.agora.io/en/Agora%20Platform/terms?platform=All%20Platforms#a-name-dualadual-stream-mode) in the Agora RTC SDK, the Agora On-premise Recording SDK allows you to record the following streams:Only record the high-video stream.Only record the low-video stream. |

## Applications

The Agora On-premise Recording SDK can be used in the following scenarios:

| Industry                      | Applications                                                 |
| ----------------------------- | ------------------------------------------------------------ |
| Online Education              | One-to-one and one-to-many online courses. The Agora On-premise Recording SDK provides high-quality voice and video recordings. <li>Students can replay recordings for review.<li>Students can make up for missed courses at their convenience. |
| Live Broadcasts               | <li>The replay of live-broadcast highlights.<li>Captures screenshots.<li>Detects sexually explicit content. |
| Financial Industry            | When conducting financial management, account registration, and face-to-face businesses, the financial industry can use audio and video recordings for record keeping and archival purposes. |
| Customer Service/Call Centers | The recordings can be used for customer research and service quality evaluations. |
| Remote Health Care            | <li>Recordings of remote diagnoses and online medical consultations enable patients to acquire medical resources in remote or inaccessible areas. <li> Can be used as references for subsequent treatments. |

## Features

The Agora On-premise Recording SDK consists of the following features:

| Feature          | Description                                                  |
| ---------------- | ------------------------------------------------------------ |
| High Reliability | The Agora On-premise Recording SDK supports cluster deployment, dynamic capacity expansion, and high availability services. |
| High Security    | Provides end-to-end security mechanisms for video calls, data transmission, data storage, and so on. For details, see [Information Security Policy](/en/Agora%20Platform/security). |
| Compatibility    | Supports CentOS 6.5+ x64 and Ubuntu 14.04+ x64 operating systems. |
| Ease of Use      | Simple implementation and easy to learn. You can get started quickly, flexibly deploy recording services, and easily record on mobile and web pages. |
| Flexibility      | By flexibly combining various functions of the Agora On-premise Recording SDK, you can seamlessly apply the SDK to multiple scenarios to achieve better service. |

## Compatibility with the Agora SDKs

The recording SDK supports:

- Recording communication that uses the Native SDK.
- Recording communication that uses the Web SDK.
- Recording communication that uses both the Native SDK and the Web SDK.

The On-premise Recording SDK is compatible with the following Agora SDK versions:

<table>
<thead>
<tr><th>Agora SDK</th>
<th>Compatible versions</th>
</tr>
</thead>
<tbody>
<tr><td>Agora Native SDK</td>
<td>v1.7.0 or later</td>
</tr>
<tr><td>Agora Web SDK</td>
<td>v1.12.0 or later</td>
</tr>
</tbody>
</table>

> If any user in the channel uses an Agora SDK which is not compatible with the Agora On-premise Recording SDK, recording fails for the whole channel.

## References

- [Integrate the SDK](/en/Quickstart%20Guide/recording_integrate_cpp) and [Record a Call](/en/Quickstart%20Guide/recording_cmd_cpp) on how to deploy and use the Agora On-premise Recording SDK, manage, play, and protect recorded files.
- [API Reference](./API%20Reference/recording_cpp/index.html) lists the API methods of the Agora On-premise Recording SDK.
- The [Agora Linux Server Recording](https://github.com/AgoraIO/Basic-Recording/tree/master/Agora-LinuxServer-Recording) sample app enables recording on your Linux server.