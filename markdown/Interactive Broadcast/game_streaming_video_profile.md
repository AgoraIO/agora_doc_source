---
title: 设置游戏直播视频属性
platform: Android
updatedAt: 2020-12-17 07:01:11
---

## 概述

游戏直播中，玩家经常需要观看其他玩家屏幕共享的游戏画面。本文介绍在这种场景下如何调节屏幕共享视频流的帧率、分辨率、码率值，以提升玩家观看游戏直播的体验。

## 实现方法

在 Android 和 iOS 平台上，Agora 推荐你使用两个进程分别分享用户摄像头视频流和用户屏幕共享视频流，并通过 `setVideoEncoderConfiguration` 方法设置屏幕共享视频流的视频编码属性。详见[屏幕共享（Android）](./screensharing_android?platform=Android)和[屏幕共享（iOS）](./screensharing_ios?platform=iOS)。

## 调参策略

你需要依据不同游戏场景类型设置不同的视频属性。总体的调参思路：根据游戏画面变化的快慢调节帧率，根据游戏画面的精细程度调节分辨率。同时考虑到帧率和分辨率的提升/降低会带来像素数的增加/减少，你需要相应地调节码率。

请参考如下图表判断你的游戏场景类型，并使用对应的视频属性推荐值。

![](https://web-cdn.agora.io/docs-files/1608185965210)

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
    <th class="tg-dby6"><span style="color:#333">游戏场景</span></th>
    <th class="tg-dby6"><span style="color:#333">画质档位</span></th>
    <th class="tg-dby6"><span style="color:#333">视频帧率 (fps)</span></th>
    <th class="tg-dby6"><span style="color:#333">视频分辨率</span></th>
    <th class="tg-dby6"><span style="color:#333">视频码率 (Kbps)</span></th>
  </tr>
</thead>
<tbody>
  <tr>
    <td class="tg-ns82" rowspan="2">场景 1: 复杂游戏</td>
    <td class="tg-ns82">流畅</td>
    <td class="tg-ns82">24</td>
    <td class="tg-ns82">640 × 360</td>
    <td class="tg-ns82">1800 ~ 2200</td>
  </tr>
  <tr>
    <td class="tg-ns82">高清</td>
    <td class="tg-ns82">24</td>
    <td class="tg-ns82">840 × 480</td>
    <td class="tg-ns82">2600 ~ 2800</td>
  </tr>
  <tr>
    <td class="tg-ns82" rowspan="2">场景 2: 单一游戏</td>
    <td class="tg-ns82">流畅</td>
    <td class="tg-ns82">10</td>
    <td class="tg-ns82">840 × 480</td>
    <td class="tg-ns82">800</td>
  </tr>
  <tr>
    <td class="tg-ns82">高清</td>
    <td class="tg-ns82">10</td>
    <td class="tg-ns82">1280 × 720</td>
    <td class="tg-ns82">1400</td>
  </tr>
  <tr>
    <td class="tg-ns82" rowspan="2">场景 3: 较复杂的高帧游戏</td>
    <td class="tg-ns82">流畅</td>
    <td class="tg-ns82">24</td>
    <td class="tg-ns82">840 × 480</td>
    <td class="tg-ns82">1400 ~ 1600</td>
  </tr>
  <tr>
    <td class="tg-ns82">高清</td>
    <td class="tg-ns82">24</td>
    <td class="tg-ns82">1280 × 720</td>
    <td class="tg-ns82">2000 ~ 2200</td>
  </tr>
  <tr>
    <td class="tg-ns82" rowspan="2">场景 4: 较复杂的低帧且细节丰富游戏</td>
    <td class="tg-ns82">流畅</td>
    <td class="tg-ns82">15</td>
    <td class="tg-ns82">840 × 480</td>
    <td class="tg-ns82">1000 ~ 1200</td>
  </tr>
  <tr>
    <td class="tg-ns82">高清</td>
    <td class="tg-ns82">15</td>
    <td class="tg-ns82">1280 × 720</td>
    <td class="tg-ns82">1600 ~ 1800</td>
  </tr>
  <tr>
    <td class="tg-ns82" rowspan="2">场景 5: 较复杂的低帧且细节单一游戏</td>
    <td class="tg-ns82">流畅</td>
    <td class="tg-ns82">15</td>
    <td class="tg-ns82">640 × 360</td>
    <td class="tg-ns82">800 ~ 1000</td>
  </tr>
  <tr>
    <td class="tg-ns82">高清</td>
    <td class="tg-ns82">15</td>
    <td class="tg-ns82">840 × 480</td>
    <td class="tg-ns82">1400 ~ 1600</td>
  </tr>
</tbody>
</table>

场景 1 的主要特点为游戏画面变化程度非常大。典型代表为神庙逃亡、地铁跑酷等跑酷类游戏和赛车类游戏。这类游戏所需帧率较高，如 24 fps。

场景 2 的主要特点为游戏画面变化程度非常小。典型代表为愤怒的小鸟、贪吃蛇大作战等游戏。这类游戏所需帧率最低，如 10 fps。如果设为流畅档时，丢失了一些游戏边框细节，你可以设为高清档。

场景 3 的主要特点为游戏画面变化程度中等，且为高帧游戏。典型代表为和平精英等枪战类游戏。这类高帧游戏往往画面细节丰富，因此所需帧率和分辨率都较高，如 24 fps 和 1280 × 720。

场景 4 的主要特点为游戏画面变化程度中等、且为画面细节丰富的低帧游戏。典型代表为王者荣耀等 MOBA 类游戏。这类游戏所需帧率较低、所需分辨率较高，如 15 fps 和 1280 × 720。

场景 5 的主要特点为游戏画面变化程度中等、且为画面细节不丰富的低帧游戏。典型代表为植物大战僵尸等塔防类游戏、捕鱼类游戏。这类游戏所需帧率较低、所需分辨率较低，如 15 fps 和 840 × 480。

## 注意事项

- 你可以根据实际情况对本文的视频属性推荐值进行微调。Agora 推荐你先找到最合适的帧率，再找出最合适的分辨率和码率。
- 即使是画面变化程度非常大的游戏， 24 fps 的帧率即可达到很好的用户体验。Agora 不推荐你设置高于 24 fps 的帧率。因为当码率一定时，编码器为了承载更高的帧数，会降低画质。如果 24 fps 的编码设置带来较大的系统开销，如手机过热、CPU 占用率过高，你可以适当调低帧率。
- 为较好展示场景 3 和 4 丰富的画面细节，Agora 推荐分辨率设为 1280 × 720。但你可以根据实际情况适当减少分辨率和码率。
