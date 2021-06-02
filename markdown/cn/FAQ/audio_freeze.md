---
title: 如何处理音频卡顿问题？
platform: ["Android","iOS","macOS","Web","Windows","Linux","Cocos Creator","微信小程序","Electron","React Native","Flutter"]
updatedAt: 2020-11-12 07:17:21
Products: ["Voice","Video","Interactive Broadcast","Recording"]
---
卡顿的问题可能涉及到网络，设备，物理环境等原因。比较常见的是客户端的网络较差导致。

## 步骤 1：自检操作

检查网络状况是否良好。可以换到 4G 或更稳定的 Wi-Fi 环境下再尝试。
也可通过声网提供的水晶球服务，确认用户的网络、设备 CPU 使用是否正常。

## 步骤 2：联系技术支持

如果问题仍旧存在，请联系技术支持，并提供以下信息，方便快速定位问题：

<table>
  <tr>
    <th>信息</th>
    <th>详情</th>
  </tr>
  <tr>
    <td rowspan="4">必要信息</td>
    <td>用户听到语音卡顿的频道名</td>
  </tr>
  <tr>
    <td>哪些用户听到了语音卡顿，提供他们的 UID</td>
  </tr>
  <tr>
    <td>哪些用户造成了语音卡顿，提供他们的 UID</td>
  </tr>
  <tr>
    <td>录音文件（如果有的话）</td>
  </tr>
  <tr>
    <td rowspan="2">可选信息</td>
    <td>如果是直播场景，卡顿是否来自于主播</td>
  </tr>
  <tr>
    <td>如果频道内显示了视频，检查视频播放是否流畅、清晰</td>
  </tr>
</table>


## 步骤 3：水晶球监控通话质量

你可以使用 Agora 控制台中的[水晶球](http://dashboard.agora.io/analytics/call/search)功能对通话质量进行跟踪和反馈，详见[水晶球教程](https://dashboard.agora.io/analytics/call/tutorial?_ga=2.197716463.1125435494.1542623251-764614247.1539586349)。