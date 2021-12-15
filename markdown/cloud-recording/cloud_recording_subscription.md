---
title: 设置订阅名单
platform: All Platforms
updatedAt: 2020-09-27 10:18:41
---

## 功能描述

默认情况下，云端录制会订阅频道内所有发布的音视频流。你可以使用 API 进行灵活的 UID 订阅。你可以设置音频和视频的订阅白名单或黑名单，还可以在录制过程中更新订阅名单。

## 实现方法

在开始录制时，你可以通过 [`start`](https://docs.agora.io/cn/cloud-recording/restfulapi/#/%E4%BA%91%E7%AB%AF%E5%BD%95%E5%88%B6/start) 方法中的相关参数设置订阅的黑白名单。在录制过程中，你可以通过 [`update`](https://docs.agora.io/cn/cloud-recording/restfulapi/#/%E4%BA%91%E7%AB%AF%E5%BD%95%E5%88%B6/update) 方法中的 `streamSubscribe` 参数更新订阅名单。

<div class="alert note">如果你设置了音频的订阅名单，但没有设置视频的订阅名单，云端录制服务不会订阅任何视频流。反之亦然。</div>

### 设置音频订阅名单

选择以下参数之一设置音频订阅名单。两者不可同时设置。

`subscribeAudioUids`：指定要订阅的音频流，即音频订阅白名单。

`unSubscribeAudioUids`：指定不订阅的音频流，即音频订阅黑名单。

### 设置视频订阅名单

选择以下参数之一设置视频订阅名单。两者不可同时设置。

`subscribeVideoUids`：指定要订阅的视频流，即视频订阅白名单。

`unSubscribeVideoUids`：指定不订阅的视频流，即视频订阅黑名单。

### 示例

假设录制开始时，频道内共有 111、222、333、444 四个用户，中途又进入两个 UID 未知的用户。下表列出了几种常见的订阅方式以及推荐的参数设置。

| 订阅方式                                   | 推荐参数设置                                                                                                                                       |
| :----------------------------------------- | :------------------------------------------------------------------------------------------------------------------------------------------------- |
| 订阅全部音频流和视频流                     | 无需设置订阅相关参数。                                                                                                                             |
| 订阅全部音频流，只订阅 111 和 222 的视频流 | `subscribeAudioUids`: `["#allstream#"]` `subscribeVideoUids: ["111","222"]`                                                                        |
| 订阅全部音频流，不订阅 111 和 222 的视频流 | `subscribeAudioUids: ["#allstream#"]` `unSubscribeVideoUids: ["111","222"]`<br>云端录制会订阅全部音频流以及 333、444 和两个 UID 未知用户的视频流。 |
| 订阅全部音频流，不订阅视频流               | `subscribeAudioUids: ["#allstream#"]`<br>将 `streamType` 设置为 `0`，也可达到同样的效果。                                                          |
| 不订阅 222 的音频流，只订阅 111 的视频流   | `unSubscribeAudioUids: ["222"]` `subscribeVideoUids: ["111"]`<br>云端录制会订阅 111、333、444 和两个 UID 未知用户的音频流，以及 222 的视频流。     |

## 开发注意事项

- 你可以使用通配符 `["#allstream#"]` 指定频道内所有 UID。
- 如果 `recordingConfig` 中的 `streamTypes` 为 `0`（只订阅音频），则不可设置视频订阅名单； 如果 `recordingConfig` 中的 `streamTypes` 为 `1`（只订阅视频），则不可设置音频订阅名单。
- 当订阅的 UID 超过 17 人时，云端录制会按 UID 加入频道的时间顺序，订阅前 17 个 UID 的视频。当某个订阅的 UID 离开频道，云端录制会自动订阅第 18 个加入频道的 UID，以此类推。
