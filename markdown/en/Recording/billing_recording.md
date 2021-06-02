---
title: Billing for On-premise Recording
platform: All Platforms
updatedAt: 2021-04-01 02:24:12
---
This article introduces the billing policy for the on-premise recording service provided by Agora.

<div class="alert note">Your billing details may differ if you have signed a contract with Agora.</div>

## Overview

Agora calculates the billing of all projects under your [Agora account](https://console.agora.io/) monthly.

Billing for the on-premise recording service begins once you use the Agora On-premise Recording SDK to record and save audio calls, group video calls, or interactive live video streaming made via the Agora RTC SDK on your server. On the first day of each month, Agora sends you the bill via email, and five days later deducts the payment from your account. For details, see [Billing, fee deduction, and account suspension](https://docs.agora.io/en/faq/billing_account).


<div class="alert note">Agora gives each Agora account 10,000 charge-free minutes each month. For more information on the deduction sequence and applicable products, see<a href="https://docs.agora.io/en/faq/billing_free"> Agora's free-of-charge policy for the first 10,000 minutes</a>.</div>

## Composition

At the end of each month, Agora calculates the service minutes of video and audio used by your projects on a monthly basis and makes the following charges:

- Video charges: Apply when the recording server successfully records video in an RTC channel.
- Audio charges: Apply when the recording server does not record video in an RTC channel, regardless of whether the server records any audio.

**Cost = video charges + audio charges = (video pricing × video service minutes) + (audio pricing × audio service minutes)**.

<div class="alert note">
	<ul>
		<li>If the recording server successfully records both audio and video at the same time, then Agora only charges for the video minutes.</li>
		<li>During a recording, the idle minutes are charged based on the audio pricing. The cost is the audio pricing × idle minutes.</li>
	</ul>
</div>

## Pricing

The pricing for audio and video are as follows:

| Service type    | Pricing ($US/1,000 minutes)                                  |
| :-------------- | :----------------------------------------------------------- |
| Recording audio | $0.99                                                        |
| Recording video | <ul><li>High-Definition (HD): $3.99</li><li>High-Definition Plus (HD+): $14.99</li></ul> |



### Video aggregate resolution

Agora adds up the resolution of all the video streams recorded at the same time to get the **aggregate resolution**, which categorizes video as either HD or HD+:

- HD: The aggregate resolution is smaller than or equal to 921,600 (1280 × 720).
- HD+: The aggregate resolution is greater than 921,600 (1280 × 720).

Suppose that the recording server records the video of users A, B, C, and D in an RTC channel for 45 minutes. During the recording, the video resolution of the users changes, and the aggregate resolution is calculated as follows:

**Phase 1**

For the first 30 minutes, the recording server records the video of users A, B, and C. The video resolution of the users are as follows:

- Video from A: 640 × 360
- Video from B: 640 × 360
- Video from C: 640 × 360

The aggregate resolution: (640 × 360) + (640 × 360) + (640 × 360) = 691,200.

Since 691,200 is smaller than 921,600, the aggregate resolution for the first 30 minutes falls into the category of HD, and is charged $3.99/1,000 minutes.

**Phase 2**

For the last 15 minutes, the recording server records the video of users A, B, and D. The video resolution of the users are as follows:

- Video from A: 640 × 360
- Video from B: 240 × 180
- Video from D: 1280 × 720

The aggregate resolution: (640 × 360) + (240 × 180) + (1280 × 720) = 1,195,200.

Since 1,195,200 is greater than 921,600, the aggregate resolution for the last 15 minutes falls into the category of HD+, and is charged $14.99/1,000 minutes.

## Service minutes

Service minutes (accurate to seconds) are calculated from the time when the recording starts to the time when the recording stops in a channel.

Service minutes comprise the following:

- Video minutes: The duration that the recording server records video in a channel.
- Audio minutes: The remaining duration after deducting the video minutes from the total duration when the recording server is in the channel, regardless of whether the recording server records any audio.

If you create a recording instance and record multiple audio and video streams at the same time in a channel, the total service minutes per streams are not additive. For example:

- If a recording instance records the video streams of both user A and user B for the same 10 minutes, the billing for the recording service is for 10 minutes of video.
- If a recording instance records the audio stream of user A and the video stream of user B for the same 10 minutes, the billing for the recording service is also for 10 minutes of video.

If you create multiple recording instances and record multiple audio and video streams at the same time in a channel, the total service minutes multiply by the number of recording instances. For example:

- If you create two recording instances to record the video streams of both user A and user B for the same 10 minutes, the billing for the recording service is for 10 minutes of video × 2.
- If you create two recording instances to record the audio stream of user A and the video stream of user B for the same 10 minutes, the billing for the recording service is for 10 minutes of video × 2.

## Examples

Use the following examples to better understand the billing policy for the Agora On-premise Recording service:

<div class="alert note">Your recording fee has nothing to do with the recording mode you choose. Regardless of whether you use the individual mode or composite mode, your recording fee relates only to the number of recording instances, the number of the streams recorded, the recording time, and the aggregate recording resolutions.</div>

### Video call with four users

**Example 1**

Scenario: Four users join the channel at the same time and have a video call for 1,000 minutes. One on-premise recording instance joins the channel and records only the audio streams of the four users.

Cost: The recording service generates only charges for the audio minutes. 
Billing = Audio pricing × audio minutes/1,000 × the number of recording instances = $0.99 × 1,000/1,000 × 1 = $0.99 

**Example 2**

Scenario: Four users join the channel at the same time and have a video call for 1,000 minutes. Two on-premise recording instances join the channel and record only the audio streams of the four users. 

Cost: The recording service generates only charges for the audio minutes. 
Billing = Audio pricing × audio minutes/1,000 × the number of recording instances = $0.99 × 1,000/1,000 × 2 = $1.98

**Example 3**

Scenario: Four users join the channel at the same time and have a video call for 1,000 minutes. One on-premise recording instance joins the channel and records the audio and video streams of the four users. The video resolution of each user is 640 × 360.

Cost: The recording service generates charges for the video minutes. The aggregate video resolution is 4 × (640 × 360) = 921,600, falling into the category of HD.
Billing = Video pricing × video minutes/1,000 × the number of recording instances= $3.99 × 1,000/1,000 × 1 = $3.99 

### Voice call with five users

Scenario: Five users join the channel at the same time and have a video call for 1,000 minutes. One on-premise recording instance joins the channel and records the audio and video streams of the five users. The video resolution of each user is 640 × 360.

Cost: The recording service generates charges for the video minutes. The aggregate video resolution is 5 × (640 × 360) = 1,152,000, falling into the category of HD+.
Billing = Video pricing × video minutes/1,000 × the number of recording instances= $14.99 × 1,000/1,000 × 1 = $14.99

## Considerations

### Accuracy of service minutes

At the end of each month, Agora adds up the usage duration (in seconds) of audio, HD video, and HD+ video, and divides them by 60 to get the respective service minutes (rounded up to the next integer). For example, if the duration of audio service of the month is 59 seconds, then the audio service minutes is calculated as 1 minute; if the duration of video service is 61 seconds, then the video service minutes is calculated as 2 minutes. The error of service minutes for each month is within 1 minute. 





### Video resolution in the dual-stream scenario

When the user being recorded enables [dual-stream mode](https://docs.agora.io/en/Agora%20Platform/terms?platform=All%20Platforms#a-name-dualadual-stream-mode), the recording service can receive only one stream at a time:

- If the recording server records the high-quality video stream, the aggregate video resolution is calculated based on the resolution of the high-quality video.
- If the recording server records the low-quality video stream, the aggregate video resolution is calculated based on the resolution of the video received by the server.

### Resolution calibration

When calculating the aggregate resolution, Agora counts the resolution of 225,280 (640 × 352) as 640 × 360.





## Q&A







<details>
	<summary><font color="#3ab7f8">Question: How does Agora charge if I use different recording modes?</font></summary>

Your recording fee has nothing to do with the recording mode you choose. Regardless of whether you use the individual mode or composite mode, your recording fee relates only to the number of the streams recorded, the recording time, and the aggregate recording resolutions. The number of the streams recorded does not affect the recording duration, but affects the aggregate recording resolution.

</details>



<details>
	<summary><font color="#3ab7f8">Question: Does Agora charge the screen capture function separately?</font></summary>

Agora does not charge for the screen capture function separately. Screen capture is a different form of the recording function. The recording service joins the corresponding channel and subscribes to the specified video streams all the time in order to capture screens at the specified interval. Therefore, if you have enabled the screen capture function, Agora charges you for the full-time recording of the corresponding stream, but do not charge you for the screen capture function separately.

</details>




<details>
	<summary><font color="#3ab7f8">Question: What is the previous pricing for audio and video?</font></summary>


#### Pricing

Agora continues to optimize our pricing to better serve our customers. The legacy pricing for audio and video is as follows:

<table>
            <colgroup>
                <col />
                <col />
                <col />
            </colgroup>
            <thead>
                <tr>
                    <th>Service type</th>
                    <th>Category</th>
                    <th>Pricing ($US/1,000 minutes)</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>Recording audio</td>
                    <td>N/A</td>
                    <td>0.99</td>
                </tr>
                <tr>
                    <td rowspan="2">Recording video</td>
                    <td>High-Definition (HD)</td>
                    <td>3.99</td>
                </tr>
                <tr>
                    <td>High-Definition Plus (HD+)</td>
                    <td>14.99</td>
                </tr>
            </tbody>
        </table>                     

### Video aggregate resolution

Agora adds up the resolution of all the video streams recorded at the same time to get the **aggregate resolution**, which categorizes video as follows:

| Video category             | Video aggregate resolution                      |
| :------------------------- | :-------------------------------------------------- |
| High-Definition (HD)       | Video aggregate resolution ≤ 921,600 (1280 × 720)  |
| High-Definition Plus (HD+) | Video aggregate resolution ＞ 921,600 (1280 × 720)  |

</details>





## Relevant links

- [Agora's free-of-charge policy for the first 10,000 minutes](https://docs.agora.io/en/faq/billing_free)
- [Billing, free deduction, and account suspension](https://docs.agora.io/en/faq/billing_account)