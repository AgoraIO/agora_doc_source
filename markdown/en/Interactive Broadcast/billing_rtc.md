---
title: Billing for Real-time Communication
platform: All Platforms
updatedAt: 2021-04-01 00:30:34
---
This article introduces the billing policy for the real-time communication (RTC) service provided by Agora.

Starting in January 2021, Agora adopted <a href="#tiered">tiered pricing</a> as the default billing method. Tiered pricing has several advantages over the previous default method, <a href="#fixed">fixed unit pricing</a>, including:

- A more fine-grained division of video categories and their associated pricing.
- Tiered discounts based on monthly cumulative usage, where more usage equals larger discounts.

<div class="alert note">Your billing details may differ if you have signed a contract with Agora.</div>

## Overview

Agora calculates the billing of all projects under your Agora account monthly.

Billing for RTC begins once you implement an RTC function, such as audio call, group video call, or interactive live video streaming, using the Agora RTC SDK.

On the first day of each month, Agora sends you your bill for the previous month's usage via mail, and five days later deducts the payment from your account. For details, see [Billing, fee deduction, and account suspension](https://docs.agora.io/en/faq/billing_account).

<div class="alert note">
	<ul>
		<li>Agora gives each Agora account 10,000 charge-free minutes each month. For more information on the deduction sequence and applicable products, see<a href="https://docs.agora.io/en/faq/billing_free"> Agora's free-of-charge policy for the first 10,000 minutes</a>.</li>
		<li>Once a user joins an RTC channel from apps integrated with the Agora RTC SDK, the user subscribes to the audio and video streams sent by all other users in the channel by default, giving rise to usage and cost. The Agora RTC SDK includes the Agora Voice or Video SDK for native platforms and third-party frameworks.</li>
		<li>If your scenario involves other Agora products or services, such as the RTMP converter, RTM SDK, or Cloud Recording, expect additional charges for these products or services. For details, see the billing policy for each Agora product or service.</li>
	</ul>
</div>

## Composition

Agora calculates your billing based on the usage of all sessions under each project. The billing for each session equals the total sum of charges for all users in the session. 

At the end of each month, Agora adds up the usage duration (in seconds) of audio and video in each category, and divides them by 60 to get the respective service minutes (rounded up to the nearest integer). Then, Agora multiplies the service minutes by the corresponding pricing to get the cost of that month.

**Cost = audio charges + video charges = audio pricing × audio service minutes + video pricing × video service minutes**

<div class="alert note"><ul><li>If a user successfully subscribes to both audio and video at the same time, then Agora only charges for the video service.</li><li>For sessions with only one user, the cost of the session equals the audio pricing × service minutes of the session.</li></ul></div>

### Service minutes

The usage duration of each session equals the total sum of service minutes of all users in the session.

For each user, Agora calculates the service minutes (accurate to seconds) from the user joining a channel to the user leaving the channel.

Depending on the subscribing behavior of the user, service minutes comprises the following:

- **Video minutes**: The total duration of the user receiving video.
- **Audio minutes**: If you deduct the video minutes from the total duration when the user is in the channel, you get the audio minutes of that user, regardless of whether that user subscribes to any audio.

<div class="alert note">If the user subscribes to multiple audio and video streams at the same time, the total service minutes per stream are not additive. For example: <ul><li>If User A subscribes to the video streams of both B and C for the same 10 minutes, A uses 10 minutes of video service.</li><li>If User A subscribes to the audio stream of B, and video stream of C, both for the same 10 minutes, A also uses 10 minutes of video service.</li></ul>For more information, see <a href="https://docs.agora.io/en/Interactive%20Broadcast/faq/billing_basis">How does Agora calculate service minutes?</a ></div>


<a name="tiered"></a>
### Tiered pricing

Agora uses a tiered pricing method for usage based on cumulative monthly service minutes. There are four tiers. As usage reaches a new tier, an increasing discount is applied and the unit price for both audio and video in that tier decreases. 

The tiered discounts and pricing are as follows:

<table class="confluenceTable" resolved=""
            style="border-collapse: collapse; margin: 0px; overflow-x: auto;" width="865">
            <colgroup span="1">
                <col span="1" width="29%" />
                <col span="1" width="13%" />
                <col span="1" width="16%" />
                <col span="1" width="12%" />
                <col span="1" width="14%" />
                <col span="1" width="9%" />
                <col span="1" width="9%" />
            </colgroup>
            <tbody>
                <tr>
                    <th class="confluenceTh" rowspan="2"
                        style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px; background-color: rgb(244, 245, 247); font-weight: bold; color: rgb(51, 51, 51);"
                        colspan="1">
                        <p
                            style="margin: 0px; padding: 0px; background-color: rgb(244, 245, 247); font-weight: bold; color: rgb(51, 51, 51);"
                            >Monthly cumulative service minutes</p>
                    </th>
                    <th class="confluenceTh" rowspan="2"
                        style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px; background-color: rgb(244, 245, 247); font-weight: bold; color: rgb(51, 51, 51);"
                        colspan="1">Discount</th>
                    <th class="confluenceTh" rowspan="2"
                        style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px; background-color: rgb(244, 245, 247); font-weight: bold; color: rgb(51, 51, 51);"
                        colspan="1">
                        <p
                            style="margin: 0px; padding: 0px; background-color: rgb(244, 245, 247); font-weight: bold; color: rgb(51, 51, 51);"
                            >Unit price for audio</p>
                        <p
                            style="margin: 10px 0px 0px; padding: 0px; background-color: rgb(244, 245, 247); font-weight: bold; color: rgb(51, 51, 51);"
                            > ($US/1,000 minutes)</p>
                    </th>
                    <th class="confluenceTh" colspan="4"
                        style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: center; min-width: 8px; background-color: rgb(244, 245, 247); font-weight: bold; color: rgb(51, 51, 51);"
                        rowspan="1">Unit price for video ($US/1,000 minutes)</th>
                </tr>
                <tr>
                    <td class="confluenceTd" colspan="1"
                        style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                        rowspan="1">High-Definition (HD)</td>
                    <td class="confluenceTd" colspan="1"
                        style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                        rowspan="1">Full High-Definition (Full HD)</td>
                    <td class="confluenceTd" colspan="1"
                        style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                        rowspan="1">2K</td>
                    <td class="confluenceTd" colspan="1"
                        style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                        rowspan="1">2K+</td>
                </tr>
                <tr>
                    <td class="confluenceTd" colspan="1"
                        style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                        rowspan="1">0 to 99,999<br clear="none" /></td>
                    <td class="confluenceTd" colspan="1"
                        style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                        rowspan="1">0</td>
                    <td class="confluenceTd" colspan="1"
                        style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                        rowspan="1">0.99</td>
                    <td class="confluenceTd" colspan="1"
                        style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                        rowspan="1">3.99</td>
                    <td class="confluenceTd" colspan="1"
                        style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                        rowspan="1">8.99 </td>
                    <td class="confluenceTd" colspan="1"
                        style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                        rowspan="1">15.99 </td>
                    <td class="confluenceTd" colspan="1"
                        style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                        rowspan="1">35.99 </td>
                </tr>
                <tr>
                    <td class="confluenceTd"
                        style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                        rowspan="1" colspan="1">100,000 to 499,999<br clear="none" /></td>
                    <td class="confluenceTd"
                        style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                        rowspan="1" colspan="1">5%</td>
                    <td class="confluenceTd"
                        style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                        rowspan="1" colspan="1">0.94</td>
                    <td class="confluenceTd"
                        style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                        rowspan="1" colspan="1">3.79</td>
                    <td class="confluenceTd" colspan="1"
                        style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                        rowspan="1">8.54</td>
                    <td class="confluenceTd" colspan="1"
                        style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                        rowspan="1">15.19</td>
                    <td class="confluenceTd" colspan="1"
                        style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                        rowspan="1">34.19</td>
                </tr>
                <tr>
                    <td class="confluenceTd" colspan="1"
                        style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                        rowspan="1">500,000 to 999,999<br clear="none" /></td>
                    <td class="confluenceTd" colspan="1"
                        style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                        rowspan="1">7%</td>
                    <td class="confluenceTd" colspan="1"
                        style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                        rowspan="1">0.92</td>
                    <td class="confluenceTd" colspan="1"
                        style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                        rowspan="1">3.71</td>
                    <td class="confluenceTd" colspan="1"
                        style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                        rowspan="1">8.36</td>
                    <td class="confluenceTd" colspan="1"
                        style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                        rowspan="1">14.87</td>
                    <td class="confluenceTd" colspan="1"
                        style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                        rowspan="1">33.47</td>
                </tr>
                <tr>
                    <td class="confluenceTd" colspan="1"
                        style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                        rowspan="1">1,000,000+<br clear="none" /></td>
                    <td class="confluenceTd" colspan="1"
                        style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                        rowspan="1">10%</td>
                    <td class="confluenceTd" colspan="1"
                        style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                        rowspan="1">0.89</td>
                    <td class="confluenceTd" colspan="1"
                        style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                        rowspan="1">3.59</td>
                    <td class="confluenceTd" colspan="1"
                        style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                        rowspan="1">8.09</td>
                    <td class="confluenceTd" colspan="1"
                        style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                        rowspan="1">14.39</td>
                    <td class="confluenceTd" colspan="1"
                        style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                        rowspan="1">32.39</td>
                </tr>
            </tbody>
        </table>


#### Video aggregate resolution

Agora adds up the resolution of all the video streams a user subscribes to at the same time to determine the user's **video aggregate resolution**, which categorizes video as follows:

| Video category                 | **Video aggregate resolution**                           |
| :----------------------------- | :----------------------------------------------------------- |
| High-Definition (HD)           | Video aggregate resolution ≤ 921,600（1280 × 720）           |
| Full High-Definition (Full HD) | 921,600（1280 × 720）＜ Video aggregate resolution ≤ 2,073,600（1920 × 1080） |
| 2K                             | 2,073,600 (1920 × 1080) ＜ Video aggregate resolution ≤ 3,686,400 （2560 × 1440） |
| 2K+                            | 3,686,400 （2560 × 1440）＜ Video aggregate resolution ≤ 8,847,360 （4096 × 2160） |

For example, if a user subscribes to two 960 × 720 video streams at the same time, the aggregate resolution is 960 × 720 + 960 × 720 = 1,382,400. The user is charged for Full HD video service.


<a name="fixed"></a>
### Fixed pricing

Besides the default tiered pricing method, Agora also keeps the previous video categorization and pricing as an option.

The pricing for audio and video is as follows:

<table>
                <colgroup>
                    <col width="19%" />
                    <col width="39%" />
                    <col width="42%" />
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
                        <td>0.99</td>
                    </tr>
                    <tr>
                        <td rowspan="2">Video</td>
                        <td>High-Definition (HD)</td>
                        <td>3.99</td>
                    </tr>
                    <tr>
                        <td>High-Definition Plus (HD+)</td>
                        <td>14.99</td>
                    </tr>
                </tbody>
            </table>
				
<div class="alert note">The live video streaming pricing stated on <a href="https://www.agora.io/en/pricing/">the official website</a> does not apply by default. Please <a href="mailto:support.agora.io">contact our sales</a> to get this rate.</div>

#### Video aggregate resolution

Agora adds up the resolution of all the video streams a user subscribes to at the same time to determine the user's **video aggregate resolution**, which categorizes video as follows:

| Video category             | Video aggregate resolution                          |
| :------------------------- | :-------------------------------------------------- |
| High-Definition (HD)       | Video aggregate resolution ≤ 921,600（1280 × 720）  |
| High-Definition Plus (HD+) | Video aggregate resolution ＞ 921,600（1280 × 720） |

For example, if a user subscribes to two 960 × 720 video streams at the same time, the aggregate resolution is 960 × 720 + 960 × 720 = 1,382,400. The user is charged for HD+ video service.

## Examples

This section shows how to calculate the monthly audio and video service minutes of each category, as well as the total cost based on the corresponding unit price.

### Scenario description

Suppose you have an enabled project named Test under your Agora account, and the project uses the Agora RTC SDK to implement real-time communication functions.

The project has the following sessions between February 1 and February 28, 2021:

#### Session one: Voice call

On February 3, 2021: Users A and B join the channel at the same time and have a voice call for 1,250 seconds.

In this session, both A and B use the audio service for 1,250 seconds.

| Session                     | Audio             | HD video | Full HD video | 2K video | 2K+ video |
| :-------------------------- | :---------------- | :------- | :------------ | :------- | :-------- |
| Usage duration (in seconds) | 1,250 × 2 = 2,500 | 0        | 0             | 0        | 0         |

#### Session two: Single-hosted video streaming

On February 8, 2021: User A joins a video streaming channel and hosts for 1,808 seconds. Users B, C, and D watch the live streaming. The video resolution of A is 1920 × 1080. 

Since user A does not subscribe to any stream in the channel, A is charged for the audio service only. Users B, C, and D subscribe to the video with a resolution of 1920 × 1080, which belongs to Full HD video, so they are each charged for Full HD video service. 

| Session                     | Audio | HD video | Full HD video     | 2K video | 2K+ video |
| :-------------------------- | :---- | :------- | :---------------- | :------- | :-------- |
| Usage duration (in seconds) | 1,808 | 0        | 1,808 × 3 = 5,424 | 0        | 0         |

#### Session three: Co-hosted video streaming

On February 11, 2021: User A hosts in an interactive streaming channel, with two audience members, B and C. The video resolution of A is 1920 × 1080. 568 seconds later, audience member C changes their user role and co-hosts with A for 600 seconds. The video resolution of C is 1280 × 720. 

- **Usage of A**:
  - The first 568 seconds: 568 seconds of audio service, since A does not subscribe to any stream in the channel.
  - The subsequent 600 seconds: 600 seconds of HD video service, for subscribing to the 1280 × 720 video of C.
- **Usage of B**:
  - The first 568 seconds: 568 seconds of Full HD video service, for subscribing to the 1920 × 1080 video of A.
  - The subsequent 600 seconds: 600 seconds of 2K video service, for subscribing to the 1920 × 1080 video of A and the 1280 × 720 video of C (an aggregate video resolution of 2,073,600 + 921,600 = 2,995,200).
- **Usage of C**:
  - The first 568 seconds: 568 seconds of Full HD video service, for subscribing to the 1920 × 1080 video of A.
  - The subsequent 600 seconds: 600 seconds of Full HD video service, for subscribing to the 1920 × 1080 video of A.

| Session                     | Audio | HD video | Full HD video           | 2K video | 2K+ video |
| :-------------------------- | :---- | :------- | :---------------------- | :------- | :-------- |
| Usage duration (in seconds) | 568   | 600      | 568 + 568 + 600 = 1,736 | 600      | 0         |

### Cost calculation

<table class="relative-table confluenceTable" resolved=""
                style="border-collapse: collapse; margin: 0px; overflow-x: auto; width: 800;">
                <colgroup span="1">
                    <col style="width: 0px;" span="1" />
                    <col style="width: 0px;" span="1" />
                    <col style="width: 0px;" span="1" />
                    <col style="width: 0px;" span="1" />
                    <col style="width: 0px;" span="1" />
                    <col style="width: 0px;" span="1" />
                    <col style="width: 0px;" span="1" />
                    <col style="width: 0px;" span="1" />
                    <col style="width: 0px;" span="1" />
                    <col style="width: 0px;" span="1" />
                    <col style="width: 0px;" span="1" />
                </colgroup>
                <tbody>
                    <tr>
                        <th class="confluenceTh" rowspan="2"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px; background-color: rgb(244, 245, 247); font-weight: bold; color: rgb(51, 51, 51);"
                            colspan="1">Date</th>
                        <th class="confluenceTh" colspan="5"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px; background-color: rgb(244, 245, 247); font-weight: bold; color: rgb(51, 51, 51);"
                            rowspan="1">Actual usage duration (seconds)<br clear="none" /></th>
                        <th class="confluenceTh" colspan="5"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px; background-color: rgb(244, 245, 247); font-weight: bold; color: rgb(51, 51, 51);"
                            rowspan="1">Usage duration displayed on Agora Console (minutes)</th>
                    </tr>
                    <tr>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">
                            <p style="margin: 0px; padding: 0px;">Audio</p>
                        </td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">
                            <p style="margin: 0px; padding: 0px;">HD video</p>
                        </td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">
                            <p style="margin: 0px; padding: 0px;">Full HD video</p>
                        </td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">
                            <p style="margin: 0px; padding: 0px;">2K video</p>
                        </td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">
                            <p style="margin: 0px; padding: 0px;">2K+ video</p>
                        </td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">
                            <p style="margin: 0px; padding: 0px;">Audio</p>
                        </td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">
                            <p style="margin: 0px; padding: 0px;">HD video</p>
                        </td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">
                            <p style="margin: 0px; padding: 0px;">Full HD video</p>
                        </td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">
                            <p style="margin: 0px; padding: 0px;">2K video</p>
                        </td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">
                            <p style="margin: 0px; padding: 0px;">2K+ video</p>
                        </td>
                    </tr>
                    <tr>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">2020-02-03</td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">2,500</td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">0</td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">0</td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">0</td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">0</td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">42</td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">0</td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">0</td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">0</td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">0</td>
                    </tr>
                    <tr>
                        <td class="confluenceTd"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1" colspan="1">2020-02-08</td>
                        <td class="confluenceTd"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1" colspan="1">1,808</td>
                        <td class="confluenceTd"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1" colspan="1">5,424</td>
                        <td class="confluenceTd"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1" colspan="1">0</td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">0</td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">0</td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">31</td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">91</td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">0</td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">0</td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">0</td>
                    </tr>
                    <tr>
                        <td class="confluenceTd"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1" colspan="1">2020-02-11</td>
                        <td class="confluenceTd"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1" colspan="1">568</td>
                        <td class="confluenceTd"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1" colspan="1">600</td>
                        <td class="confluenceTd"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1" colspan="1">1,736<br clear="none" /></td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">600</td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">0</td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">10</td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">10</td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">29</td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">10</td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">0</td>
                    </tr>
                    <tr>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">Monthly usage</td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">4,876</td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">6,024</td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">1,736</td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">600</td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">0</td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">83</td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">101</td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">29</td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">10</td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">0</td>
                    </tr>
                    <tr>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1"><strong>Billable service minutes</strong></td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">
                            <p style="margin: 0px; padding: 0px;">82 minutes</p>
                        </td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">101 minutes</td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">29 minutes</td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">10 minutes</td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">
                            <p style="margin: 0px; padding: 0px;">0 minutes</p>
                        </td>
                        <td class="confluenceTd" colspan="5"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1"><strong>The usage displayed on Agora Console is for
                                reference only and not used as the actual billing basis.<br
                                    clear="none" /></strong></td>
                    </tr>
                    <tr>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">
                            <p style="margin: 0px; padding: 0px;">Cost of each service</p>
                            <p>($US)</p>
                        </td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">(82/1000 ) × 0.99 = 0.08118</td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">(101/1000) × 3.99 = 0.40299</td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">(29/1000) × 8.99 = 0.26071</td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">(10/1000) × 15.99 = 0.1599</td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">0</td>
                        <td class="confluenceTd" colspan="5"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1"><br clear="none" /></td>
                    </tr>
                    <tr>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">
                            <p style="margin: 0px; padding: 0px;">Total cost</p>
                            <p style="margin: 10px 0px 0px; padding: 0px;">($US)</p>
                        </td>
                        <td class="confluenceTd" colspan="5"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: right; min-width: 8px;"
                            rowspan="1">
                            <p style="margin: 0px; padding: 0px;"><strong>0.90</strong></p>
                            <p><strong>(0.08118 + 0.40299 + 0.26071 + 0.1599 = 0.90478 ≈ 0.90)<br
                                        clear="none" /></strong></p>
                        </td>
                        <td class="confluenceTd" colspan="5"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1"><br clear="none" /></td>
                    </tr>
                </tbody>
            </table>


 <table class="relative-table confluenceTable" resolved=""
                    style="border-collapse: collapse; margin: 0px; overflow-x: auto; width: 748px;">
                    <colgroup span="1">
                        <col style="width: 0px;" span="1" />
                        <col style="width: 0px;" span="1" />
                        <col style="width: 0px;" span="1" />
                        <col style="width: 0px;" span="1" />
                        <col style="width: 0px;" span="1" />
                        <col style="width: 0px;" span="1" />
                        <col style="width: 0px;" span="1" />
                        <col style="width: 0px;" span="1" />
                        <col style="width: 0px;" span="1" />
                        <col style="width: 0px;" span="1" />
                        <col style="width: 0px;" span="1" />
                    </colgroup>
                    <tbody>
                        <tr>
                            <th class="confluenceTh" rowspan="2"
                                style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px; background-color: rgb(244, 245, 247); font-weight: bold; color: rgb(51, 51, 51);"
                                colspan="1">Date</th>
                            <th class="confluenceTh" colspan="5"
                                style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px; background-color: rgb(244, 245, 247); font-weight: bold; color: rgb(51, 51, 51);"
                                rowspan="1">Actual usage duration (seconds)<br clear="none" /></th>
                            <th class="confluenceTh" colspan="5"
                                style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px; background-color: rgb(244, 245, 247); font-weight: bold; color: rgb(51, 51, 51);"
                                rowspan="1">Usage duration displayed on Agora Console (minutes)</th>
                        </tr>
                        <tr>
                            <td class="confluenceTd" colspan="1"
                                style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                                rowspan="1">
                                <p style="margin: 0px; padding: 0px;">Audio</p>
                            </td>
                            <td class="confluenceTd" colspan="1"
                                style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                                rowspan="1">
                                <p style="margin: 0px; padding: 0px;">HD video</p>
                            </td>
                            <td class="confluenceTd" colspan="1"
                                style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                                rowspan="1">
                                <p style="margin: 0px; padding: 0px;">Full HD video</p>
                            </td>
                            <td class="confluenceTd" colspan="1"
                                style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                                rowspan="1">
                                <p style="margin: 0px; padding: 0px;">2K video</p>
                            </td>
                            <td class="confluenceTd" colspan="1"
                                style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                                rowspan="1">
                                <p style="margin: 0px; padding: 0px;">2K+ video</p>
                            </td>
                            <td class="confluenceTd" colspan="1"
                                style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                                rowspan="1">
                                <p style="margin: 0px; padding: 0px;">Audio</p>
                            </td>
                            <td class="confluenceTd" colspan="1"
                                style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                                rowspan="1">
                                <p style="margin: 0px; padding: 0px;">HD video</p>
                            </td>
                            <td class="confluenceTd" colspan="1"
                                style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                                rowspan="1">
                                <p style="margin: 0px; padding: 0px;">Full HD video</p>
                            </td>
                            <td class="confluenceTd" colspan="1"
                                style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                                rowspan="1">
                                <p style="margin: 0px; padding: 0px;">2K video</p>
                            </td>
                            <td class="confluenceTd" colspan="1"
                                style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                                rowspan="1">
                                <p style="margin: 0px; padding: 0px;">2K+ video</p>
                            </td>
                        </tr>
                        <tr>
                            <td class="confluenceTd" colspan="1"
                                style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                                rowspan="1">2020-02-03</td>
                            <td class="confluenceTd" colspan="1"
                                style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                                rowspan="1">2,500</td>
                            <td class="confluenceTd" colspan="1"
                                style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                                rowspan="1">0</td>
                            <td class="confluenceTd" colspan="1"
                                style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                                rowspan="1">0</td>
                            <td class="confluenceTd" colspan="1"
                                style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                                rowspan="1">0</td>
                            <td class="confluenceTd" colspan="1"
                                style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                                rowspan="1">0</td>
                            <td class="confluenceTd" colspan="1"
                                style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                                rowspan="1">42</td>
                            <td class="confluenceTd" colspan="1"
                                style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                                rowspan="1">0</td>
                            <td class="confluenceTd" colspan="1"
                                style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                                rowspan="1">0</td>
                            <td class="confluenceTd" colspan="1"
                                style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                                rowspan="1">0</td>
                            <td class="confluenceTd" colspan="1"
                                style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                                rowspan="1">0</td>
                        </tr>
                        <tr>
                            <td class="confluenceTd"
                                style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                                rowspan="1" colspan="1">2020-02-08</td>
                            <td class="confluenceTd"
                                style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                                rowspan="1" colspan="1">1,808</td>
                            <td class="confluenceTd"
                                style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                                rowspan="1" colspan="1">5,424</td>
                            <td class="confluenceTd"
                                style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                                rowspan="1" colspan="1">0</td>
                            <td class="confluenceTd" colspan="1"
                                style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                                rowspan="1">0</td>
                            <td class="confluenceTd" colspan="1"
                                style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                                rowspan="1">0</td>
                            <td class="confluenceTd" colspan="1"
                                style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                                rowspan="1">31</td>
                            <td class="confluenceTd" colspan="1"
                                style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                                rowspan="1">91</td>
                            <td class="confluenceTd" colspan="1"
                                style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                                rowspan="1">0</td>
                            <td class="confluenceTd" colspan="1"
                                style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                                rowspan="1">0</td>
                            <td class="confluenceTd" colspan="1"
                                style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                                rowspan="1">0</td>
                        </tr>
                        <tr>
                            <td class="confluenceTd"
                                style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                                rowspan="1" colspan="1">2020-02-11</td>
                            <td class="confluenceTd"
                                style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                                rowspan="1" colspan="1">568</td>
                            <td class="confluenceTd"
                                style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                                rowspan="1" colspan="1">600</td>
                            <td class="confluenceTd"
                                style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                                rowspan="1" colspan="1">1,736<br clear="none" /></td>
                            <td class="confluenceTd" colspan="1"
                                style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                                rowspan="1">600</td>
                            <td class="confluenceTd" colspan="1"
                                style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                                rowspan="1">0</td>
                            <td class="confluenceTd" colspan="1"
                                style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                                rowspan="1">10</td>
                            <td class="confluenceTd" colspan="1"
                                style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                                rowspan="1">10</td>
                            <td class="confluenceTd" colspan="1"
                                style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                                rowspan="1">29</td>
                            <td class="confluenceTd" colspan="1"
                                style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                                rowspan="1">10</td>
                            <td class="confluenceTd" colspan="1"
                                style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                                rowspan="1">0</td>
                        </tr>
                        <tr>
                            <td class="confluenceTd" colspan="1"
                                style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                                rowspan="1">Monthly usage</td>
                            <td class="confluenceTd" colspan="1"
                                style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                                rowspan="1">4,876</td>
                            <td class="confluenceTd" colspan="1"
                                style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                                rowspan="1">6,024</td>
                            <td class="confluenceTd" colspan="1"
                                style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                                rowspan="1">1,736</td>
                            <td class="confluenceTd" colspan="1"
                                style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                                rowspan="1">600</td>
                            <td class="confluenceTd" colspan="1"
                                style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                                rowspan="1">0</td>
                            <td class="confluenceTd" colspan="1"
                                style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                                rowspan="1">83</td>
                            <td class="confluenceTd" colspan="1"
                                style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                                rowspan="1">101</td>
                            <td class="confluenceTd" colspan="1"
                                style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                                rowspan="1">29</td>
                            <td class="confluenceTd" colspan="1"
                                style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                                rowspan="1">10</td>
                            <td class="confluenceTd" colspan="1"
                                style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                                rowspan="1">0</td>
                        </tr>
                        <tr>
                            <td class="confluenceTd" colspan="1"
                                style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                                rowspan="1"><strong>Billable service minutes</strong></td>
                            <td class="confluenceTd" colspan="1"
                                style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                                rowspan="1">
                                <p style="margin: 0px; padding: 0px;">82 minutes</p>
                            </td>
                            <td class="confluenceTd" colspan="1"
                                style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                                rowspan="1">101 minutes</td>
                            <td class="confluenceTd" colspan="1"
                                style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                                rowspan="1">29 minutes</td>
                            <td class="confluenceTd" colspan="1"
                                style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                                rowspan="1">10 minutes</td>
                            <td class="confluenceTd" colspan="1"
                                style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                                rowspan="1">
                                <p style="margin: 0px; padding: 0px;">0 minutes</p>
                            </td>
                            <td class="confluenceTd" colspan="5"
                                style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                                rowspan="1"><strong>The usage displayed on Agora Console is for
                                    reference only and not used as the actual billing basis.<br
                                        clear="none" /></strong></td>
                        </tr>
                        <tr>
                            <td class="confluenceTd" colspan="1"
                                style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                                rowspan="1">
                                <p style="margin: 0px; padding: 0px;">Cost of each service</p>
                                <p>($US)</p>
                            </td>
                            <td class="confluenceTd" colspan="1"
                                style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                                rowspan="1">(82/1000 ) × 0.99 = 0.08118</td>
                            <td class="confluenceTd" colspan="1"
                                style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                                rowspan="1">(101/1000) × 3.99 = 0.40299</td>
                            <td class="confluenceTd" colspan="1"
                                style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                                rowspan="1">(29/1000) × 8.99 = 0.26071</td>
                            <td class="confluenceTd" colspan="1"
                                style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                                rowspan="1">(10/1000) × 15.99 = 0.1599</td>
                            <td class="confluenceTd" colspan="1"
                                style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                                rowspan="1">0</td>
                            <td class="confluenceTd" colspan="5"
                                style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                                rowspan="1"><br clear="none" /></td>
                        </tr>
                        <tr>
                            <td class="confluenceTd" colspan="1"
                                style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                                rowspan="1">
                                <p style="margin: 0px; padding: 0px;">Total cost</p>
                                <p style="margin: 10px 0px 0px; padding: 0px;">($US)</p>
                            </td>
                            <td class="confluenceTd" colspan="5"
                                style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: right; min-width: 8px;"
                                rowspan="1">
                                <p style="margin: 0px; padding: 0px;"><strong>0.90</strong></p>
                                <p><strong>(0.08118 + 0.40299 + 0.26071 + 0.1599 = 0.90478 ≈
                                            0.90)<br clear="none" /></strong></p>
                            </td>
                            <td class="confluenceTd" colspan="5"
                                style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                                rowspan="1"><br clear="none" /></td>
                        </tr>
                    </tbody>
                </table>

<div class="alert note"><ul><li>Agora rounds up the monthly total fees to two decimal places.
</li><li>Agora gives each Agora account 10,000 minutes of free time per month. Because the monthly total service minutes in the above example do not exceed 10,000 minutes, the service is free of charge and the bill would show $US 0.</li></ul></div>

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
<details><summary><font color="#3ab7f8">Why am I charged for HD+ video, even though all users subscribe only to video streams with the resolution of 360 × 640?</font></summary>
Video streams are categorized as HD or HD+ by <b>aggregate resolution</b>, which is the sum of all the resolutions of the video streams a user subscribes to. In other words, the more video streams a user subscribes to, the more likely that user's aggregate resolution falls into HD+ (1,280 × 720).
</details>
<details><summary><font color="#3ab7f8">Are the audio minutes on my bill for a specific user?</font></summary>
No. The audio minutes that you see on your bill are the sum of the audio minutes used by all users under your Agora account.
</details>

## Reference

- [Agora's free-of-charge policy for the first 10,000 minutes](https://docs.agora.io/en/faq/billing_free)
- [Billing, free deduction, and account suspension](https://docs.agora.io/en/faq/billing_account)
- [How do I get the user's call duration?](https://docs.agora.io/en/faq/business_billing)