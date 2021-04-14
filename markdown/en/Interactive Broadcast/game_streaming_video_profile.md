---
title: Set Video Profiles for Screen-Sharing a Game
platform: iOS
updatedAt: 2020-12-24 10:00:29
---
## Overview

Players often need to share their screens during game streaming. This article introduces how to adjust the frame rate, resolution, and bitrate when screen-sharing a game to improve the audience's viewing experience.

## Implementation

If you use the Agora Android/iOS SDK to design an app for Android/iOS, Agora recommends that you use two processes: one for the video stream captured by the user’s camera, and one for the screen-sharing video stream. Call `setVideoEncoderConfiguration` to set the video encoding profile of the screen-sharing stream. See [Share the Screen (Android)](./screensharing_android?platform=Android) and [Share the Screen (iOS)](./screensharing_ios?platform=iOS).

## Recommended video profiles

The optimal video profile varies according to the gaming scenario. The overarching principle is as follows:

- Adjust the frame rate based on how frequently the images refresh on the screen.
- Adjust the resolution based on the richness of detail in the images.
- Adjust the bitrate to accommodate the increase/decrease in the number of pixels caused by the increase/decrease of the frame rate and resolution.

Use the following diagram to determine your gaming scenario, then refer to the scenarios table for suggested video profile settings.

![](https://web-cdn.agora.io/docs-files/1608803515066)

<style type="text/css">
.tg  {border-collapse:collapse;border-spacing:0;}
.tg td{border-color:black;border-style:solid;border-width:1px;font-family:Arial, sans-serif;font-size:14px;
  overflow:hidden;padding:10px 5px;word-break:normal;}
.tg th{border-color:black;border-style:solid;border-width:1px;font-family:Arial, sans-serif;font-size:14px;
  font-weight:normal;overflow:hidden;padding:10px 5px;word-break:normal;}
.tg .tg-dby6{font-weight:bold;text-align:center;vertical-align:center}
.tg .tg-ns82{text-align:center;vertical-align:center}
</style>
<table class="tg">
<thead>
  <tr>
    <th class="tg-dby6"><span style="font-weight:bold;color:#333;background-color:#F4F5F7">Category</span></th>
    <th class="tg-dby6"><span style="font-weight:bold;color:#333;background-color:#F4F5F7">Quality level</span></th>
    <th class="tg-dby6"><span style="font-weight:bold;color:#333;background-color:#F4F5F7">Frame rate (fps)</span></th>
    <th class="tg-dby6"><span style="font-weight:bold;color:#333;background-color:#F4F5F7">Resolution</span></th>
    <th class="tg-dby6"><span style="font-weight:bold;color:#333;background-color:#F4F5F7">Bitrate (Kbps)</span></th>
  </tr>
</thead>
<tbody>
  <tr>
    <td class="tg-ns82" rowspan="2">Scenario 1: Ultra-high image-refresh frequency</td>
    <td class="tg-ns82">Smooth</td>
    <td class="tg-ns82">24</td>
    <td class="tg-ns82">640 × 360</td>
    <td class="tg-ns82">1800 ~ 2200</td>
  </tr>
  <tr>
    <td class="tg-ns82">High-definition</td>
    <td class="tg-ns82">24</td>
    <td class="tg-ns82">840 × 480</td>
    <td class="tg-ns82">2600 ~ 2800</td>
  </tr>
  <tr>
    <td class="tg-ns82" rowspan="2">Scenario 2: Low image-refresh frequency</td>
    <td class="tg-ns82">Smooth</td>
    <td class="tg-ns82">10</td>
    <td class="tg-ns82">840 × 480</td>
    <td class="tg-ns82">800</td>
  </tr>
  <tr>
    <td class="tg-ns82">High-definition</td>
    <td class="tg-ns82">10</td>
    <td class="tg-ns82">1280 × 720</td>
    <td class="tg-ns82">1400</td>
  </tr>
  <tr>
    <td class="tg-ns82" rowspan="2">Scenario 3: High image-refresh frequency, high frame rate</td>
    <td class="tg-ns82">Smooth</td>
    <td class="tg-ns82">24</td>
    <td class="tg-ns82">840 × 480</td>
    <td class="tg-ns82">1400 ~ 1600</td>
  </tr>
  <tr>
    <td class="tg-ns82">High-definition</td>
    <td class="tg-ns82">24</td>
    <td class="tg-ns82">1280 × 720</td>
    <td class="tg-ns82">2000 ~ 2200</td>
  </tr>
  <tr>
    <td class="tg-ns82" rowspan="2">Scenario 4: High image-refresh frequency, low frame rate, and rich image detail</td>
    <td class="tg-ns82">Smooth</td>
    <td class="tg-ns82">15</td>
    <td class="tg-ns82">840 × 480</td>
    <td class="tg-ns82">1000 ~ 1200</td>
  </tr>
  <tr>
    <td class="tg-ns82">High-definition</td>
    <td class="tg-ns82">15</td>
    <td class="tg-ns82">1280 × 720</td>
    <td class="tg-ns82">1600 ~ 1800</td>
  </tr>
  <tr>
    <td class="tg-ns82" rowspan="2">Scenario 5: High image-refresh frequency, low frame rate, and low image detail</td>
    <td class="tg-ns82">Smooth</td>
    <td class="tg-ns82">15</td>
    <td class="tg-ns82">640 × 360</td>
    <td class="tg-ns82">800 ~ 1000</td>
  </tr>
  <tr>
    <td class="tg-ns82">High-definition</td>
    <td class="tg-ns82">15</td>
    <td class="tg-ns82">840 × 480</td>
    <td class="tg-ns82">1400 ~ 1600</td>
  </tr>
</tbody>
</table>


**Scenario 1: Ultra-high image-refresh frequency**

Typical examples include running games, such as Temple Run and Subway Surfers, and racing games. These games require the highest frame rates, such as 24 fps. 

**Scenario 2: Low image-refresh frequency**

Typical examples include Angry Birds and Snake. These games do not require high frame rates, so you can use a lower setting, such as 10 fps. If video profiles at the smooth quality level fail to display the full gaming screen, switch to the high-definition quality level.

**Scenario 3: High image-refresh frequency, high frame rate**

Typical examples include gun games, such as Game for Peace. These games require a higher frame rate and resolution, such as 24 fps and 1280 × 720, because their images tend to be rich in detail.

**Scenario 4: High image-refresh frequency, low frame rate, and rich image detail**

Typical examples include MOBA games, such as Honor of Kings. These games do not require the highest frame rates but do require higher resolutions. A typical setting might be 15 fps and 1280 × 720.

**Scenario 5: High image-refresh frequency, low frame rate, and low image detail**

Typical examples include tower defense games, such as Plants vs. Zombies, and fishing games. These games do not require the highest frame rates or higher resolutions. A typical setting might be 15 fps and 840 × 480.

## Considerations

- You can make minor adjustments to the recommended video profiles according to the actual performance you experience. Agora recommends that you determine the optimal frame rate first, then work out the optimal resolution and bitrate.
- In scenario 1, a frame rate of 24 fps is enough to screen-share with decent quality. Agora does not recommend setting the value higher than 24 fps, because when the bitrate is fixed, the encoder reduces image quality to reach a higher frame rate. If the 24 fps setting causes overheating or is too resource-intensive, you can adjust the value downward.
- To ensure that the rich detail of images is displayed in scenarios 3 and 4, Agora recommends setting the resolution as 1280 × 720. You can adjust the resolution and bitrate downward according to the actual performance.