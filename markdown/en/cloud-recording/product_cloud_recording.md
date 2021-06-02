---
title: Agora Cloud Recording Overview
platform: All Platforms
updatedAt: 2021-03-31 04:16:14
---
Agora Cloud Recording is an add-on service to record and save voice calls, video calls, and interactive broadcasts on your cloud storage. It is compatible with the Agora Native SDK v1.7.0+ and the Agora Web SDK v1.12.0+. 

You can quickly and flexibly record one-to-one or one-to-many audio and video calls or live broadcasts through simple integration. Compared with Agora On-premise Recording, Agora Cloud Recording is more efficient and convenient as it does not require deploying Linux servers.

With Agora Cloud Recording, you can record calls or live broadcasts for your users to watch at their convenience. For example, a user can either attend an online course at the time of the course or watch the recorded course later, made possible by the Agora Cloud Recording service.

## Functions

Agora Cloud Recording provides the following functions:

- High-quality voice and video recordings.
- Individual recording, which generates one audio and/or video file for each user in the channel.
- Composite recording, which combines the audio and video of all users in the channel into one file.
- Record specified users.
- Various composite video layouts.
- Third-party cloud storage.
- Customize the directory of the recorded files in the third-party cloud storage.


## Applications

Agora Cloud Recording can be used in the following scenarios:

| Industry                      | Applications                                                 |
| ----------------------------- | ------------------------------------------------------------ |
| Online Education              | One-to-one and one-to-many online courses. Agora Cloud Recording provides high-quality voice and video recordings. <li>Students can replay recordings for review.</li><li>Students can make up for missed courses at their convenience.</li> |
| Live Broadcasts               | <li>The replay of live-broadcast highlights.</li><li>Captures screenshots.</li><li>Detects sexually explicit content.</li> |
| Financial Industry            | When conducting financial management, account registration, and face-to-face businesses, the financial industry can use audio and video recordings for record keeping and archival purposes. |
| Customer Service/Call Centers | The recordings can be used for customer research and service quality evaluations. |
| Remote Health Care            | <li>Recordings of remote diagnoses and online medical consultations enable patients to acquire medical resources in remote or inaccessible areas. </li><li> Can be used as references for subsequent treatments.</li> |

## Features

Agora Cloud Recording consists of the following features:

| Feature          | Description                                                  |
| ---------------- | ------------------------------------------------------------ |
| High Reliability | <li>Supports globally distributed cluster deployment and highly available services.</li><li>Automatically backs up files on Agora's cloud server when the third-party cloud storage fails and automatically uploads the backup to the third-party cloud storage when it recovers.</li> |
| High Security    | Provides end-to-end security mechanisms for video calls, data transmission, data storage, and so on. For details, see [Information Security Policy](/en/Agora%20Platform/security). |
| Compatibility    | Supports third-party cloud storages, such as [Amazon S3](https://aws.amazon.com/s3/?nc1=h_ls), [Alibaba Cloud](https://www.alibabacloud.com/product/oss), and [Qiniu Cloud](https://www.qiniu.com/en/products/kodo). |
| Ease of Use      | Simple implementation and easy to learn. With four RESTful API calls, you can start, stop, and query the recording. You can get started quickly, flexibly deploy recording services, and easily record on mobile and web pages. |

## Billing

Use Agora Cloud Recording to join a channel, subscribe to the audio and video streams that need to be recorded, and upload the recorded files to the specified cloud storage. Agora Cloud Recording is charged by the minute and [the aggregate resolution](https://docs.agora.io/en/faq/video_billing#calculating-the-recording-aggregate-resolution). The aggregate resolutions of the audio and video streams are divided into three types: Audio, HD, and HD+. Contact [sales-us@agora.io](mailto:sales-us@agora.io) for details.

The billing for each recording task is separate. For example, two recording tasks of the same channel are charged separately.

> The service is free of charge if the monthly voice and video (including recording) usage is less than 10,000 minutes. See [the free-of-charge policy](https://docs.agora.io/en/faq/billing_free) for details.

## References

- [Quickstart for RESTful API](./cloud_recording_rest) describes how to use Agora Cloud Recording with the RESTful APIs.
- [RESTful API Callback Service](./cloud_recording_callback_rest) describes the events of the RESTful API.