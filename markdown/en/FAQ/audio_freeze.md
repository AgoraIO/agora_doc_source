---
title: Why does audio freeze occur in a call?
platform: ["Android","iOS","macOS","Web","Windows","Unity","Cocos Creator","微信小程序","Electron","React Native","Flutter"]
updatedAt: 2020-07-09 21:58:31
Products: ["Voice","Interactive Broadcast"]
---
Jitter may be caused by slow Internet connections, bad device performances, or the physical environment.

## Step 1: Self-check

Check if the network is stable and in good condition. If not, switch to 4G or another Wi-Fi network.

## Step 2: Contact Agora Customer Support

If the issue persists, contact Agora customer support and submit the issue with the following information:

<table>
  <tr>
    <th>Information</th>
    <th>Details</th>
  </tr>
  <tr>
    <td>Mandatory</td>
    <td><li>The name of the channel where the users hear the jitter.</li><li>The uids of the users who hear the jitters.</li><li>The uid of the user who causes the jitters.</li><li>The recording files, if available.</li></td>
  </tr>
  <tr>
    <td>Additional</td>
    <td><li>Live interactive streaming: If the jitter comes from the host.</li><li>Video mode: If the video is smooth and clear.</li></td>
  </tr>
</table>

## Step 3: Monitor the Quality of Experience in Agora Analytics in Console

You can check the statistics of every call in [Agora Analytics](https://dashboard.agora.io/analytics/call/search) in Console. For more information, see [Agora Analytics Tutorial](https://dashboard.agora.io/analytics/call/tutorial?_ga=2.197716463.1125435494.1542623251-764614247.1539586349).