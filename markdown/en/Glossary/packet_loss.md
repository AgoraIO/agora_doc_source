---
title: packet loss
platform: All Platforms
updatedAt: 2020-07-03 20:47:18
---
Packet loss refers to the data packets transmitted on the network failing to arrive at their intended destination. 

Packet loss may be caused by network congestion, device overload, hardware failures, and software errors. 

In real-time audio and video communication, slight packet loss does not necessarily impact the end user experience. However, a high packet loss rate can reduce the audio and video quality: in audio, it may cause distorted and stuttering voice or occasional noise; and in video, it may cause frozen and blurry frames.

Agora is committed to improving the end user experience by leveraging anti-packet loss technologies such as FEC (Forward Error Correction) and retransmission. The [Agora RTC SDK](https://docs.agora.io/en/Agora%20Platform/terms?platform=All%20Platforms#agora-rtc-sdk) triggers callbacks to report the packet loss rates during the audio and video data transmission through callbacks, so that developers can understand the current network quality and locate issues. Developers can also learn about packet loss rates by using [Agora Analytics](https://docs.agora.io/en/Agora%20Platform/terms?platform=All%20Platforms#agora-analytics).

<div class="alert info">Reference:<li><a href="https://docs.agora.io/en/Agora%20Platform/terms?platform=All%20Platforms#delay">delay</a></li><li><a href="https://docs.agora.io/en/Agora%20Platform/terms?platform=All%20Platforms#jitter">jitter</a></li>
</div>

<a href="./terms"><button>Back to glossary</button></a>