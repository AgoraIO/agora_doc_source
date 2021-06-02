---
title: 视频截图
platform: All Platforms
updatedAt: 2021-01-13 07:57:38
---
## 功能描述

本文介绍如何通过命令行的方式获取视频截图，以便分析视频内容，例如对直播内容进行鉴黄以确保合法合规。

阅读本文前，请确保你已经完成本地服务端录制 SDK 的环境准备和集成工作并且了解如何使用命令行开始录制，详见[集成客户端](./recording_integrate_cpp)和[命令行录制](./recording_cmd_cpp)。

## 实现方法

你可通过 `getVideoFrame` 参数设置录制文件格式来获得截图。此外，你还可以通过 `captureInterval` 参数设置截图时间间隔。

### 设置录制文件格式

通过 `getVideoFrame` 参数设置录制文件的格式。录制模式不同，`getVideoFrame` 的设置要求不同，如下所示。

- **单流录制模式**

单流录制模式（`isMixingEnabled` 为 0）下，`getVideoFrame` 参数可设为 3，4，5。

<table>
  <tr>
    <th>参数设置</th>
    <th>录制方式</th>
    <th>录制文件格式</th>
  </tr>
  <tr>
    <td>--getVideoFrame 3</td>
    <td rowspan="2">只截图</td>
    <td>原始视频数据 JPG 帧格式。</td>
  </tr>
  <tr>
    <td>--getVideoFrame 4</td>
    <td>JPG 文件格式。</td>
  </tr>
  <tr>
    <td>--getVideoFrame 5</td>
    <td>边录制边截图</td>
    <td><li>Native 端每个 UID 生成一个 MP4 视频文件和多个 JPG 文件。<br><li>Web 端每个 UID 生成一个 WebM/MP4 视频文件和多个 JPG 文件。</td>
  </tr>
</table>

- **合流录制模式**

合流录制模式（`isMixingEnabled` 为 1）下，如想进行截图，`getVideoFrame` 只能设为 5，会得到一个 MP4 视频文件，并对各单流截图，获得多个 JPG 文件。

### 设置截图时间间隔

通过 `captureInterval` 参数设置截图时间间隔。默认值为 5 秒，最小值为 1 秒。

## 命令行示例

以下命令为单流模式下只录制视频时获取 JPG 截图。

```
./recorder_local --appId <你的 App ID> --channel <待录制的频道名> --uid 0 --appliteDir ~/Agora_Recording_SDK_for_Linux_FULL/bin --isVideoOnly 1 --getVideoFrame 4
```