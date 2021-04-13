---
title: Billing for Cloud Recording
platform: All Platforms
updatedAt: 2021-04-01 00:31:00
---
This article introduces the billing policy for the cloud recording service provided by Agora.

Starting in February 2021, Agora further divided HD+ video into Full HD, 2K, and 2K+ video and set a more fine-grained pricing.

<div class="alert note"><ul><li>Your billing details may differ if you have signed a contract with Agora.</li><li>If the previous pricing set for HD and HD+ video still applies to you, see <a href="#question">What is the previous pricing for audio and video?</a> for detailed video categorization and unit price.</li></ul></div>

## Overview

Agora calculates the billing of all projects under your [Agora account](https://console.agora.io/) monthly.

Billing for the cloud recording service begins once you use Agora Cloud Recording to record and save audio calls, group video calls, or interactive video streaming made via the Agora RTC SDK on your cloud storage. 

On the first day of each month, Agora sends you the bill via email, and five days later deducts the payment from your account. For details, see [Billing, fee deduction, and account suspension](https://docs.agora.io/en/faq/billing_account).

<div class="alert note">Agora gives each Agora account 10,000 charge-free minutes each month. For more information on the deduction sequence and applicable products, see<a href="https://docs.agora.io/en/faq/billing_free"> Agora's free-of-charge policy for the first 10,000 minutes</a>.</div>


## Composition

Agora calculates the recording service minutes of audio and video used by your projects on a monthly basis.

At the end of each month, Agora adds up the usage duration (in seconds) of audio and video in each category, and divides them by 60 to get the respective service minutes (rounded up to the nearest integer). Then, Agora multiplies the service minutes by the corresponding pricing to get the cost of that month.

**Cost = audio charges + video charges = audio pricing × audio service minutes + video pricing × video service minutes**

<div class="alert note"><ul><li>If the recording server successfully records both audio and video at the same time, then Agora only charges for the video minutes.</li><li>During a recording, the idle minutes are charged based on the audio pricing. The cost is the audio pricing × idle minutes.</li></ul></div>

### Service minutes

Service minutes (accurate to seconds) are calculated from the time when the recording starts to the time when the recording stops in a channel.

Service minutes comprise the following:

- **Video minutes**: The duration that the recording server records video in a channel.
- **Audio minutes**: The remaining duration after deducting the video minutes from the total duration when the recording server is in the channel, regardless of whether the recording server records any audio.

<div class="alert note">If you create a recording instance and record multiple audio and video streams at the same time in a channel, the total service minutes per streams are not additive. For example: <ul><li>If a recording instance records the video streams of both user A and user B for the same 10 minutes, the billing for the recording service is for 10 minutes of video.</li><li>If a recording instance records the audio stream of user A and the video stream of user B for the same 10 minutes, the billing for the recording device is also for 10 minutes of video.</li></ul>If you use multiple recording sessions at the same time in a channel, then the service minutes per recording session are additive.</div>

### Pricing

The pricing for audio and video is as follows:

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
                        <td>1.49</td>
                    </tr>
                    <tr>
                        <td rowspan="4">Recording video</td>
                        <td>High-Definition (HD)</td>
                        <td>5.99</td>
                    </tr>
                    <tr>
                        <td>Full High-Definition (Full HD)</td>
                        <td>13.49</td>
                    </tr>
                    <tr>
                        <td>2K</td>
                        <td>23.99</td>
                    </tr>
                    <tr>
                        <td>2K+</td>
                        <td>53.99 </td>
                    </tr>
                </tbody>
            </table>                  


#### Video aggregate resolution

Agora adds up the resolution of all the video streams recorded at the same time to get the **aggregate resolution**, which categorizes video as follows:

| Video category                 | Video aggregate resolution                      |
| :----------------------------- | :----------------------------------------------------------- |
| High-Definition (HD)           | Up to 921,600 (1280 × 720）           |
| Full High-Definition (Full HD) | From greater than 921,600 (1280 × 720) to 2,073,600 (1920 × 1080) |
| 2K                             | From greater than 2,073,600 (1920 × 1080) to 3,686,400 (2560 × 1440)  |
| 2K+                            | From greater than 3,686,400 (2560 × 1440) to 8,847,360 (4096 × 2160)  |

For example, if the recording server records two 960 × 720 video streams at the same time, the aggregate resolution is 960 × 720 + 960 × 720 = 1,382,400. The recording service is charged based on the Full HD video pricing.

## Examples

This section shows how to calculate the monthly audio and video service minutes of each category, as well as the total cost based on the corresponding unit price.

### Scenario description

Suppose you have an enabled project named Test under your Agora account, and the project uses the Agora Cloud Recording to implement the recording function.

The recording usage duration of the project between February 1 and February 28, 2021 is as follows:

#### Recording one

On February 4, 2021: Four users join the channel at the same time and have a video call for 6,000 seconds. You start one cloud recording session to record only the audio streams of the four users in the channel.

During this recording, the recording service generates only charges for the audio minutes.

| Session                     | Audio | HD video | Full HD video | 2K video | 2K+ video |
| :-------------------------- | :---- | :------- | :------------ | :------- | :-------- |
| Usage duration (in seconds) | 6,000 | 0        | 0             | 0        | 0         |

#### Recording two

On February 9, 2021: Four users join the channel at the same time and have a video call for 6,000 seconds. You start two cloud recording sessions to record only the audio streams of the four users in the channel.

During this recording, the recording service generates only charges for the audio minutes.

| Session                     | Audio                  | HD video | Full HD video | 2K video | 2K+ video |
| :-------------------------- | :--------------------- | :------- | :------------ | :------- | :-------- |
| Usage duration (in seconds) | 6,000 + 6,000 = 12,000 | 0        | 0             | 0        | 0         |

#### Recording three

On February 13, 2021: Four users join the channel at the same time and have a video call for 3,500 seconds. You start one cloud recording session to record the audio and video streams of the four users in the channel. The video resolution of each user is 640 × 360.

During this recording, the recording service generates charges for the video minutes. The aggregate video resolution is 4 × (640 × 360) = 921,600, falling into the category of HD.

| Session                     | Audio | HD video | Full HD video | 2K video | 2K+ video |
| :-------------------------- | :---- | :------- | :------------ | :------- | :-------- |
| Usage duration (in seconds) | 0     | 3,500    | 0             | 0        | 0         |

#### Recording four

On February 15, 2021: Users A, B, and C join the channel at the same time and have interactive live video streaming. The video resolution of A, B, and C is 640 x 360, 1280 x 720, and 960 x 720. 1,680 seconds later, user D joins the channel, and has interactive live streaming with A, B, and C for 520 seconds. The video resolution of D is 1920 x 1080. During live streaming, you start one cloud recording session to record the audio and video streams of all the users in the channel.

During this recording, the recording service generates charges for the video minutes.

In the initial 1,680 seconds, the aggregate resolution is 640 x 360 + 1280 x 720 + 960 x 720 = 1,843,200, falling into the category of Full HD video.

In the subsequent 520 seconds, the aggregate resolution is 640 x 360 + 1280 x 720 + 960 x 720 + 1920 x 1080 = 3,916,800, falling into the category of 2K+ video.

| Session                     | Audio | HD video | Full HD video | 2K video | 2K+ video |
| :-------------------------- | :---- | :------- | :------------ | :------- | :-------- |
| Usage duration (in seconds) | 0     | 0        | 1,680         | 0        | 520       |

### Cost calculation

<table class="relative-table confluenceTable" resolved=""
                style="border-collapse: collapse; margin: 0px; overflow-x: auto; width: auto;">
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
                            rowspan="1">Actual usage duration (seconds)</th>
                        <th class="confluenceTh" colspan="5"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px; background-color: rgb(244, 245, 247); font-weight: bold; color: rgb(51, 51, 51);"
                            rowspan="1">Usage duration displayed on Agora Console (minutes)</th>
                    </tr>
                    <tr>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">
                            <p>Audio</p>
                        </td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">
                            <p>HD video</p>
                        </td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">
                            <p>Full HD video</p>
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
                            <p>Audio</p>
                        </td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">
                            <p>HD video</p>
                        </td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">
                            <p style="margin: 0px; padding: 0px;">Full HD video</p>
                        </td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">
                            <p style="margin: 0px; padding: 0px;">2K video</p>
                        </td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">
                            <p style="margin: 0px; padding: 0px;">2K+ video</p>
                        </td>
                    </tr>
                    <tr>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">2020-02-04</td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">6,000</td>
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
                            rowspan="1">100</td>
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
                            rowspan="1" colspan="1">2020-02-09</td>
                        <td class="confluenceTd"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1" colspan="1">12,000</td>
                        <td class="confluenceTd"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1" colspan="1">0</td>
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
                            rowspan="1">200</td>
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
                            rowspan="1" colspan="1">2020-02-13</td>
                        <td class="confluenceTd"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1" colspan="1">0</td>
                        <td class="confluenceTd"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1" colspan="1">3,500</td>
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
                            rowspan="1">0</td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">59</td>
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
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">2020-02-15</td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">0</td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">0</td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">1,680</td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">0</td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">520</td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">0</td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">0</td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">28</td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">0</td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">9</td>
                    </tr>
                    <tr>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">Monthly usage</td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">18,000</td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">3,500</td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">1,680</td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">0</td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">520</td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">300</td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">59</td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">28</td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">0</td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">9</td>
                    </tr>
                    <tr>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1"><strong>Billable service minutes</strong></td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">300<br /> minutes</td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">59<br /> minutes</td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">28<br /> minutes</td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">0</td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">9<br /> minutes</td>
                        <td class="confluenceTd" colspan="5"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1"><strong>The usage displayed on Agora Console is for
                                reference only and not used as the actual billing
                            basis.</strong></td>
                    </tr>
                    <tr>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">
                            <p style="margin: 0px; padding: 0px;">Cost of each service</p>
                            <p style="margin: 10px 0px 0px; padding: 0px;">($US)</p>
                        </td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">(300/1000 )<br /> × 1.49<br /> = 0.447</td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">(59/1000)<br /> × 5.99<br /> = 3.5341</td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">(28/1000) <br />× 13.49<br /> = 3.7772</td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">0</td>
                        <td class="confluenceTd" colspan="1"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1">(9/1000)<br /> × 53.99<br /> = 0.48591</td>
                        <td class="confluenceTd" colspan="5"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1"></td>
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
                            <p align="left"><strong><strong style="text-align: right;"
                                            ><strong>8.24</strong></strong></strong></p>
                            <p align="left"><strong><strong>(0.447 + 3.5341 + 3.7772 + 0.48591 =
                                        8.24421 ≈ 8.24）</strong></strong></p>
                        </td>
                        <td class="confluenceTd" colspan="5"
                            style="border: 1px solid rgb(193, 199, 208); padding: 7px 10px; vertical-align: top; text-align: left; min-width: 8px;"
                            rowspan="1"></td>
                    </tr>
                </tbody>
            </table>


<div class="alert note"><ul><li>Agora rounds up the monthly total fees to two decimal places.</li><li>Agora gives each Agora account 10,000 minutes of free time per month. Because the monthly total service minutes in the above example do not exceed 10,000 minutes, the service is free of charge and the bill would show $US 0.</li></ul></div>


## Considerations

### Accuracy of service minutes

At the end of each month, Agora adds up the usage duration (in seconds) of audio, HD video, and HD+ video, and divides them by 60 to get the respective service minutes (rounded up to the next integer). For example, if the duration of audio service of the month is 59 seconds, then the audio service minutes is calculated as 1 minute; if the duration of video service is 61 seconds, then the video service minutes is calculated as 2 minutes. The error of service minutes for each month is within 1 minute. 





### Video resolution in the dual-stream scenario

When the user being recorded enables [dual-stream mode](https://docs.agora.io/en/Agora%20Platform/terms?platform=All%20Platforms#a-name-dualadual-stream-mode), the recording service can receive only one stream at a time:

- If the recording server records the high-quality video stream, the aggregate video resolution is calculated based on the resolution of the high-quality video.
- If the recording server records the low-quality video stream, the aggregate video resolution is calculated based on the resolution of the video received by the server.

### Resolution calibration

When calculating the aggregate resolution, Agora counts the resolution of 225,280 (640 × 352) as 640 × 360.






<a name="question"></a>
## Q&A







<details>
	<summary><font color="#3ab7f8">Question: How does Agora charge if I use different recording modes?</font></summary>

Your recording fee has nothing to do with the recording mode you choose. Regardless of whether you use the individual mode or composite mode, your recording fee relates only to the number of the streams recorded, the recording time, and the aggregate recording resolutions. The number of the streams recorded does not affect the recording duration, but affects the aggregate recording resolution.

</details>








<details>
	<summary><font color="#3ab7f8">Question: How does Agora charge for HD and HD+ video?</font></summary>

Starting in January 2021, Agora further divided HD+ video into Full HD, 2K, and 2K+ video and set a more fine-grained pricing.

If you still use the previous pricing set for HD and HD+ video, see the following video categorization and unit price:

#### Pricing

The pricing for audio and video is as follows:

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
                    <td>1.49</td>
                </tr>
                <tr>
                    <td rowspan="2">Recording video</td>
                    <td>High-Definition (HD)</td>
                    <td>5.99</td>
                </tr>
                <tr>
                    <td>High-Definition Plus (HD+)</td>
                    <td>22.49</td>
                </tr>
            </tbody>
        </table>                     

### Video aggregate resolution

Agora adds up the resolution of all the video streams recorded at the same time to get the **aggregate resolution**, which categorizes video as follows:

| Video category             | Video aggregate resolution                      |
| :------------------------- | :-------------------------------------------------- |
| High-Definition (HD)       | Video aggregate resolution ≤ 921,600 (1280 × 720)   |
| High-Definition Plus (HD+) | Video aggregate resolution ＞ 921,600 (1280 × 720)  |

</details>


## Relevant links

- [Agora's free-of-charge policy for the first 10,000 minutes](https://docs.agora.io/en/faq/billing_free)
- [Billing, free deduction, and account suspension](https://docs.agora.io/en/faq/billing_account)