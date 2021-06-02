---
title: Billing for Interactive Live Streaming Standard
platform: Android
updatedAt: 2021-04-01 00:30:48
---
This article introduces the billing policy for the Interactive Live Streaming Standard product provided by Agora.

<div class="alert note">Your billing details may differ if you have signed a contract with Agora.</div>

## Overview

Agora calculates the billing of all projects under your Agora account monthly.

Billing begins once you implement interactive live streaming using the Agora Voice or Video SDK.

On the first day of each month, Agora sends you your bill for the previous month's usage via mail, and five days later deducts the payment from your account. For details, see [Billing, fee deduction, and account suspension](https://docs.agora.io/en/faq/billing_account).

<div class="alert note"><ul><li>Agora gives each Agora account 10,000 charge-free minutes each month. For more information on the deduction sequence and applicable products, see <a href="https://docs.agora.io/en/One-to-one%20Classroom/faq/billing_free"> Agora's free-of-charge policy for the first 10,000 minutes</a >.</li><li>Once a user joins a live-streaming channel from apps integrated with the Agora Voice or Video SDK, the user subscribes to the audio and video streams sent by all other users in the channel by default, giving rise to usage and cost.</li></ul></div>

## Composition

Agora calculates billing based on the usage of all sessions under each project. The billing for each session equals the total sum of charges for all users in the session. 

At the end of each month, Agora adds up the usage duration (in seconds) of audio and video in each category, and divides them by 60 to get the respective service minutes (rounded up to the nearest integer). Then, the service minutes are multiplied by the corresponding pricing to get the cost of that month.

**Cost = audio charges + video charges = audio pricing × audio service minutes + video pricing × video service minutes** 

<div class="alert note"><ul><li>If a user successfully subscribes to both audio and video at the same time, then Agora only charges for the video service.</li><li>For sessions with only one user, the cost of the session equals the audio pricing × service minutes of the session.</li></ul></div>

### Service minutes

The usage duration of each session equals the total sum of service minutes of all users in the session.

For each user, Agora calculates the service minutes (accurate to seconds) from the user joining a channel to the user leaving the channel.

Depending on the subscribing behavior of the user, service minutes comprises the following:

- **Video minutes**: The total duration of the user receiving video.
- **Audio minutes**: If you deduct the video minutes from the total duration when the user is in the channel, you get the audio minutes of that user, regardless of whether that user subscribes to any audio.

<div class="alert note">If the user subscribes to multiple audio and video streams at the same time, the total service minutes per stream are not additive. For example:<ul><li>If User A subscribes to the video streams of both B and C for the same 10 minutes, A uses 10 minutes of video service.</li><li>If User A subscribes to the audio stream of B, and video stream of C, both for the same 10 minutes, A also uses 10 minutes of video service.</li></ul>For more information, see  <a href="https://docs.agora.io/en/Interactive%20Broadcast/faq/billing_basis">How does Agora calculate service minutes?</a >
</div>

### Unit Price

In a live-streaming channel, Agora charges for audio and video service usage based on the role and level of the user.

- **Host**: A user with the host user role is a host. The audio and video minutes of a host are billed based on [Interactive Live Streaming Premium pricing](/en/Interactive%20Broadcast/billing_rtc). 

- **Audience**:

  - **Interactive Live Streaming Standard audience**: A user with the audience user role and the low latency user level is an audience member in Interactive Live Streaming Standard. The audio and video minutes of an audience member in Interactive Live Streaming Standard are billed based on [Interactive Live Streaming Standard pricing](/en/Interactive%20Broadcast/billing_rtc).

  - **Interactive Live Streaming Premium audience**: A user with the audience user role and the ultra-low latency user level is an audience member in Interactive Live Streaming Premium. The audio and video minutes of an audience member in Interactive Live Streaming Premium are billed based on [Interactive Live Streaming Premium pricing](https://confluence.agoralab.co/display/TEKP/Billing+for+Interactive+Live+Streaming+Standard#BillingforInteractiveLiveStreamingStandard-premium).

When an audience member in Interactive Live Streaming Standard subscribes to audio and video, the pricing is as follows:

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
                        <td>Audio</td>
                        <td>N/A</td>
                        <td>0.59</td>
                    </tr>
                    <tr>
                        <td rowspan="4">Video</td>
                        <td>High-Definition (HD)</td>
                        <td>1.99</td>
                    </tr>
                    <tr>
                        <td>Full High-Definition (Full HD)</td>
                        <td>4.59 </td>
                    </tr>
                    <tr>
                        <td>2K</td>
                        <td>7.99</td>
                    </tr>
                    <tr>
                        <td>2K+</td>
                        <td>17.99 </td>
                    </tr>
                </tbody>
            </table>       

<div class="alert note">Agora determines video category based on <a href="#aggregate">Aggregate video resolution</a>.</div>

<a name="aggregate "></a>
#### Aggregate video resolution

Agora adds up the resolution of all the video streams a user subscribes to at the same time to determine the user's **aggregate video resolution**, which categorizes video as follows:

| Video category                 | Aggregate video resolution                                   |
| :----------------------------- | :----------------------------------------------------------- |
| High-Definition (HD)           | Up to 921,600 (1280 × 720）                                  |
| Full High-Definition (Full HD) | From greater than 921,600 (1280 × 720) to 2,073,600 (1920 × 1080) |
| 2K                             | From greater than 2,073,600 (1920 × 1080) to 3,686,400 (2560 × 1440) |
| 2K+                            | From greater than 3,686,400 (2560 × 1440) to 8,847,360 (4096 × 2160) |

For example, if a user subscribes to two 960 × 720 video streams at the same time, the aggregate resolution is 960 × 720 + 960 × 720 = 1,382,400. The user is charged for Full HD video service.

### Usage-based volume discounts

After deducting the charge-free minutes, Agora calculates your monthly total usage of [Interactive live Streaming Standard](/en/live-streaming/product_live_standard) and automatically applies the following discounts:

| Minutes used</br>(after deducting the free-charge minutes)          | Discount level |
| :--------------------- | :------------- |
| 0 to 99,999     | 0            |
| 100,000 to 499,999     | 5%             |
| 500,000 to 999,999     | 7%             |
| 1,000,000 to 3,000,000 | 10%            |

<div class="alert note"><ul><li>Agora adopts tiered discounts model, in which a specific discount is applied to the usage within that tier. The discount increases as usage reaches a new tier.</li><li>Contact sales-us@agora.io for more preferential pricing plan If you expect your monthly total usage to be more than 3,000,000 minutes.</li><li>For more information on the deduction sequence and applicable products of the charge-free minutes, see see<a href="https://docs.agora.io/en/faq/billing_free"> Agora's free-of-charge policy for the first 10,000 minutes</a>.</li></div>

## Examples

This section shows how to calculate the monthly audio and video service minutes of each category, as well as the total cost based on the corresponding unit price.

### Scenario description

Suppose you have an enabled project named Test under your Agora account, and the project uses the Agora RTC SDK to implement interactive live streaming.

The project has the following sessions between February 1 and February 28, 2021:

#### Session one: Single-hosted video streaming

On February 8, 2021: User A joins a video streaming channel and hosts for 1,808 seconds. Interactive Live Streaming Standard audience members B, C, and D subscribe to the video of A. The video resolution of A is 1280 × 720.

Since user A does not subscribe to any stream in the channel, A is charged for the audio service only. Audience members B, C, and D each subscribe to the video with a resolution of 1280 × 720, which belongs to Full HD video, so they are each charged for Full HD video service.

| Product                             | Usage duration (in seconds) |                   |          |           |      |
| :---------------------------------- | :-------------------------- | ----------------- | -------- | --------- | ---- |
| Audio                               | HD video                    | Full HD video     | 2K video | 2K+ video |      |
| Interactive Live Streaming Standard | 1,808                       | 1,808 × 3 = 5,424 | 0        | 0         | 0    |



#### Session two: Co-hosted video streaming

On February 11, 2021: User A hosts in an interactive streaming channel. Interactive Live Streaming Standard audience members B and C subscribe to the video of A. The video resolution of A is 1920 × 1080. 568 seconds later, audience member C changes their user role and co-hosts with A for 600 seconds. A and C subscribe to each other's video, and B subscribes to the video of both A and C. The video resolution of A remains unchanged at 1920 × 1080, and the video resolution of C is 1280 × 720.

- **Usage of A**:

  - The first 568 seconds: 568 seconds of audio service, since A does not subscribe to any stream in the channel.
  - The subsequent 600 seconds: 600 seconds of HD video service, for subscribing to the 1280 × 720 video of C.

  Since A is a host, the audio and video minutes used by A are billed based on Interactive Live Streaming Premium pricing.

- **Usage of B**:

  - The first 568 seconds: 568 seconds of Full HD video service, for subscribing to the 1920 × 1080 video of A.
  - The subsequent 600 seconds: 600 seconds of 2K video service, for subscribing to both the 1920 × 1080 video of A and the 1280 × 720 video of C (an aggregate video resolution of 2,073,600 + 921,600 = 2,995,200).

  Since B is an audience member in Interactive Live Streaming Standard, the audio and video minutes used by B are billed based on Interactive Live Streaming Standard pricing.

- **Usage of C**:

  - The first 568 seconds: 568 seconds of Full HD video service, for subscribing to the 1920 × 1080 video of A.
  - The subsequent 600 seconds: 600 seconds of Full HD video service, for subscribing to the 1920 × 1080 video of A.

  For the first 568 seconds, as C is an Interactive Live Streaming Standard audience member, the audio and video minutes are billed based on Interactive Live Streaming Standard pricing; for the subsequent 600 seconds, as C becomes a host, the audio and video minutes are billed based on Interactive Live Streaming Standard pricing.

| Product                             | Usage duration (in seconds) |               |                   |           |      |
| :---------------------------------- | :-------------------------- | ------------- | ----------------- | --------- | ---- |
| Audio                               | HD video                    | Full HD video | 2K video          | 2K+ video |      |
| Interactive Live Streaming Standard | 0                           | 0             | 568 + 568 = 1,136 | 600       | 0    |
| Interactive Live Streaming Premium  | 568                         | 600           | 600               | 0         | 0    |

### Cost calculation

#### Interactive Live Streaming Standard cost

| Date                                | Actual usage duration (seconds)                              |                            |                            |                           |           |
| :---------------------------------- | :----------------------------------------------------------- | -------------------------- | -------------------------- | ------------------------- | --------- |
| Audio                               | HD video                                                     | Full HDvideo               | 2K video                   | 2K+ video                 |           |
| 2020-02-08                          | 1,808                                                        | 5,424                      | 0                          | 0                         | 0         |
| 2020-02-11                          | 0                                                            | 0                          | 1,136                      | 600                       | 0         |
| Monthly cumulative usage            | 1,808                                                        | 5,424                      | 1,136                      | 600                       | 0         |
| ***\*Billable service minutes\** ** | 31 minutes                                                   | 91 minutes                 | 19 minutes                 | 10 minutes                | 0 minutes |
| Cost of each service($US)           | (31/1000) × 0.59= 0.01829                                    | (91/1000) × 1.99 = 0.18109 | (19/1000) × 4.59 = 0.08721 | (10/1000) × 7.99 = 0.0799 | 0         |
| Total cost($US)                     | ***\*0.37\** ****（0.01829 + 0.18109 + 0.08721 + 0.0799 = 0.36649 ≈ 0.37） ** |                            |                            |                           |           |

#### Interactive Live Streaming Premium cost

| Date                                       | Actual usage duration (seconds)                              |                           |                           |           |           |
| :----------------------------------------- | :----------------------------------------------------------- | ------------------------- | ------------------------- | --------- | --------- |
| Audio                                      | HD video                                                     | Full HD video             | 2K video                  | 2K+ video |           |
| 2020-02-08                                 | 0                                                            | 0                         | 0                         | 0         | 0         |
| 2020-02-11                                 | 568                                                          | 600                       | 600                       | 0         | 0         |
| Monthly cumulative usage                   | 568                                                          | 600                       | 600                       | 0         | 0         |
| ***\**\*Billable service minutes\*\**\* ** | 10 minutes                                                   | 10 minutes                | 10 minutes                | 0 minutes | 0 minutes |
| Cost of each service($US)                  | (10/1000) × 0.99= 0.0099                                     | (10/1000) × 3.99 = 0.0399 | (10/1000) × 8.99 = 0.0899 | 0         | 0         |
| Total cost($US)                            | **0.14****（0.0099 + 0.0399 + 0.0899 = 0.1397 \**≈ 0.14\**）** |                           |                           |           |           |



- Agora rounds up the monthly total fees to two decimal places.
- Agora gives each Agora account 10,000 minutes of free time per month. Because the monthly total service minutes in the above example do not exceed 10,000 minutes, the service is free of charge and the bill would show $US 0.

## Considerations

### Accuracy of service minutes

At the end of each month, Agora adds up the usage duration (in seconds) of audio and video in each category, and divides them by 60 to get the respective service minutes (rounded up to the nearest integer). For example, if the duration of audio service of the month is 59 seconds, then the audio service minutes is calculated as 1 minute; if the duration of video service is 61 seconds, then the video service minutes is calculated as 2 minutes. The margin of error for service minutes for each month is within 1 minute. 

### Video resolution in the dual-stream scenario

In dual-stream mode, the aggregate video resolution is calculated as follows:

- If the user subscribes to the high-quality video stream, the aggregate resolution is calculated based on the resolution of the high-quality video.
- If the user subscribes to the low-quality video stream, the aggregate resolution is calculated based on the resolution of the video received by the user.

### Video resolution in the screen sharing scenario

In scenarios involving screen sharing, the unit price of the screen-sharing stream is calculated on the basis of the video dimension that you set in <code>ScreenCaptureParameters</code>. For details, see descriptions in the following classes:

- Windows: [`ScreenCaptureParameters`](https://docs.agora.io/en/Interactive%20Broadcast/API%20Reference/cpp/structagora_1_1rtc_1_1_screen_capture_parameters.html)
- macOS: [`AgoraScreenCaptureParameters`](https://docs.agora.io/en/Interactive%20Broadcast/API%20Reference/oc/Classes/AgoraScreenCaptureParameters.html)

<div class="alert note">On Web, due to limitations of some devices and browsers, the resolution you set may fail to take effect and get adjusted by the browser. In this case, billings will be calculated based on the actual resolution. See <a href="https://docs.agora.io/en/Video/API%20Reference/web/v3.3.0/interfaces/agorartc.stream.html#setscreenprofile">setScreenProfile</a >.</div>

### Resolution calibration

When calculating the aggregate resolution, Agora counts the resolution of 225280 (640 × 352) as 640 × 360.

## FAQ

<details><summary><font color="#3ab7f8">Why do I see audio minutes in my bill even though all users subscribe only to video streams?</font></summary>
Chances are:
	<ul>
	<li>The user being subscribed to has not subscribed to any video stream.</li>
	<li>After subscribing to a video stream, a user has not received any video stream due to poor network conditions.</li>
</ul>
If either of these conditions occurs, the corresponding user's aggregate resolution is 0 and the user's service time counts as audio minutes.
</details>
<details><summary><font color="#3ab7f8">Why am I charged for Full HD video, even though all users subscribe only to video streams with the resolution of 360 × 640?</font></summary>
Video streams are categorized as HD, Full HD, 2K, and 2K+ by <b>aggregate resolution</b>, which is the sum of all the resolutions of the video streams a user subscribes to. In other words, the more video streams a user subscribes to, the more likely that user's aggregate resolution falls into Full HD, or even 2K or 2K+.
</details>
<details><summary><font color="#3ab7f8">Are the audio minutes on my bill for a specific user?</font></summary>
No. The audio minutes that you see on your bill are the sum of the audio minutes used by all users under your Agora account.
</details>

## Relevant links

- [Agora's free-of-charge policy for the first 10,000 minutes](https://docs.agora.io/en/faq/billing_free)
- [Billing, free deduction, and account suspension](https://docs.agora.io/en/faq/billing_account)
- [How do I get the user's call duration?](https://docs.agora.io/en/faq/business_billing)