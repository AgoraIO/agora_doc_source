---
title: What is the pricing for Cloud Player?
platform: ["RESTful"]
updatedAt: 2021-03-03 02:13:02
Products: ["Interactive Broadcast"]
---
This article introduces the billing policy for the Cloud Player service provided by Agora.

<div class="alert note">Your billing details may differ if you have signed a contract with Agora.</div>

## Composotion

The billing for the Agora Cloud Player service comprises transcoding charges and subscription charges:

- Transcoding charges: The charges for Cloud Player injecting an online media stream into the RTC channel. Note that this charge is not included in Agora's policy of granting 10,000 minutes of usage per month free of charge.
- Subscription charges: The charges for Cloud Player subscribing to streams in the RTC channel as a virtual host. Subscription charges go directly into real-time communication charges.

## Transcoding charges

Transcoding charges occur when Cloud Player injects an online stream into an RTC channel.

Based on the injected stream, transcoding charges can be categorized as one of the following:

- Audio transcoding charges: If Cloud Player injects an audio stream into an RTC channel, audio transcoding charges occur. Audio transcoding charges = Audio transcoding unit price × Audio transcoding service minutes.
- Video transcoding charges: If Cloud Player injects a video stream or an audio and video stream into an RTC channel, video transcoding charges occur. Video transcoding charges = Video transcoding unit price × Video transcoding service minutes.

### Transcoding pricing
The following table lists the transcoding pricing of Cloud Player:

| Service | Category | Pricing ($US/1,000 minutes) |
| ---------------- | ---------------- | ---------------- |
| Audio      | N/A      | $1.15      |
| HD video | Output video resolution up to 921,600 (1280 × 720)| $6.86 |
| FHD video | Output resolution greater than 921,600 (1280 × 720), up to 2,073,600 (1920 × 1080)| $15.49 |

### Transcoding duration
Agora monitors the time interval between when Cloud Player is enabled and when it is destroyed, and then calculates this interval as the transcoding duration.

- Audio transcoding duration: The duration that Cloud Player transcodes an audio stream.
- Video transcoding duration: The duration that Cloud Player transcodes a video stream or an audio and video stream.

<div class="alert note">When using the Agora Cloud service, if you set the value of <code>playTs</code> greater than <code>createTs</code>, the duration between these two timestamps is billed as audio transcoding charges.</div>

## Subscription charges
When you successfully inject an online stream into an RTC channel, Cloud Player joins the RTC channel as a virtual host, which generates subscription charges. Subscription charges are included in the charges for real-time communications.

### Subscription pricing

Given that Cloud Player publishes streams in the RTC channel, but never receives them, subscription pricing is the same as for audio service charges, which is $0.99 ($US/1,000 minutes).

### Subscription duration

The time interval between when Cloud Player starts publishing streams into the RTC channel and Cloud Player is destroyed is calculated as the subscription duration.
