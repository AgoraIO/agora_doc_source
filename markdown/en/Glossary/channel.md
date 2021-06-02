---
title: channel
platform: All Platforms
updatedAt: 2020-07-03 20:47:06
---
A channel is created by a developer calling the methods provided by Agora for transmitting real-time data.

Agora uses different channels to transmit different types of data. The RTC channel transmits audio or video data, while the RTM channel transmits messaging or signaling data. RTC channels and RTM channels are independent of each other.

Additional components provided by Agora, such as On-premise Recording and Cloud Recording, can join the RTC channel and provide real-time recording, transmission acceleration, media playback, and content moderation.  

Agora identifies channels by channel name. Users with the same channel name join the same channel and interact with each other. A channel no longer exists when the last user leaves the channel.

To ensure communication security, users should provide a token for authentication when joining a channel. When the token expires, the user can no longer access Agora services. 

<div class="alert info">Reference:
<li><a href="https://docs.agora.io/en/Agora%20Platform/token">Set up authentication</a></li>
<li><a href="#agora-rtc-sdk">Agora RTC SDK</a></li>
<li><a href="#agora-rtm-sdk">Agora RTM SDK</a></li>	
</div>

<a href="./terms"><button>Back to glossary</button></a>