---
title: freeze
platform: All Platforms
updatedAt: 2020-08-13 14:19:16
---
Freeze refers to choppy audio or video playback caused by a poor network connection or limited device performance during real-time audio and video communication.

To highlight transmission qualities and help developers locate issues, the Agora RTC SDK provides callbacks that report audio and video freeze statistics during a call. Developers can also track freezes with [Agora Analytics](./terms#agora-analytics).

The Agora RTC SDK and Agora Analytics use different algorithms to decide when a freeze occurs:

| Product | Video freeze | Audio freeze |
| ---------------- | ---------------- | ---------------- |
| RTC SDK      | In a video session where the frame rate is set to 5 fps or higher, video freeze occurs when the time interval between two adjacent video frames is more than 500 ms.      | In the reported interval, audio freeze occurs when the audio frame loss rate reaches 4%.      |
| Agora Analytics   | Occurs when the video freezes for 600 ms or more. | Occurs when the audio freezes for 200 ms or more. |

<div class="alert info">See also: <a href="https://docs.agora.io/en/Agora%20Platform/aa_data_insight?platform=All%20Platforms#quality">Data Insight quality overview</a>
</div>

<a href="./terms"><button>Back to glossary</button></a>