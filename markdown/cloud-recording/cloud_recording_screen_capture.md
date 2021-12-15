---
title: 视频截图
platform: All Platforms
updatedAt: 2020-12-10 07:34:14
---

## 功能描述

本文介绍如何通过设置 RESTful API 参数对视频进行截图，并将图片上传至你的第三方云存储。

> - 云端录制只支持在单流录制模式（`individual`）下进行截图。
> - 录制和截图无法同时进行。如果你需要对频道内的媒体流同时进行录制和截图，需要调用两次 [`acquire`](https://docs.agora.io/cn/cloud-recording/restfulapi/#/云端录制/acquire) 方法，获取两个 resource ID, 分别进行录制和截图。

阅读本文前，请确保你已了解如何使用 RESTful API 进行云端录制，详见[云端录制 RESTful API 快速开始](https://docs.agora.io/cn/cloud-recording/cloud_recording_rest)。

## 实现方法

在调用 [`start`](https://docs.agora.io/cn/cloud-recording/restfulapi/#/云端录制/start) 方法时，设置 `snapshotConfig`，即可根据你设置的截图周期定期截图，并生成指定格式的图片文件。同时，云端录制会根据 `storageConfig` 将图片上传至你指定的第三方云存储。

### start 请求示例

```json
{
  "uid": "527841",
  "cname": "httpClient463224",
  "clientRequest": {
    "token": "<token if any>",
    "recordingConfig": {
      "channelType": 0
    },
    "snapshotConfig": {
      "captureInterval": 5,
      "fileType": ["jpg"]
    },
    "storageConfig": {
      "accessKey": "xxxxxxf",
      "region": 3,
      "bucket": "xxxxx",
      "secretKey": "xxxxx",
      "vendor": 2,
      "fileNamePrefix": ["directory1", "directory2"]
    }
  }
}
```

# 截图文件命名规则

云端录制生成的截图文件的命名规则为 `<sid>_<cname>__uid_s_<uid>__uid_e_video_<utc>.jpg`。文件类型取决于你在 `start` 方法中设置的 `fileType`，目前只支持 JPG。

上述文件名中各字段含义如下：

- `<sid>`：录制 ID
- `<cname>`：频道名
- `<uid>`：用户 ID
- `<utc>`：该截图文件生成时的 UTC 时间，时区为 UTC+0，由年、月、日、小时、分钟、秒和毫秒组成。例如，`utc` 等于 `20190611073246073`，表示该截图文件生成时间为 UTC 2019 年 6 月 11 日 7 点 32 分 46 秒 73 毫秒。

当出现[服务器断网、进程被杀](https://docs.agora.io/cn/faq/high-availability)时，云端录制会自动启用高可用机制，在 90 秒内切换到新的服务器，自动恢复截图服务。启用高可用机制后，截图文件的文件名会增加 `bak<n>` 前缀，`n` 为高可用机制在该次截图进程中被启用的 index, `0` 表示第一次启用。以文件名 `bak0_sid_channel1__uid_s_123__uid_e_video_20190611073246073.jpg` 为例，`bak0` 表示该文件为本次截图中第一次启用高可用机制后生成的截图文件。

# 开发注意事项

在进行视频截图时，需要注意以下参数的设置。如设置错误，会收到报错或无法生成截图。

- 请求 URL 中的 `mode` 参数必须设为 `individual。`
- `不可设置 recordingFileConfig。`
- `streamType` 必须设置为 1 或 2
- 如果设置了 `subscribeAudioUid`，则必须同时设置 `subscribeVideoUids`。

另外，在截图过程中，如果某用户中途停止发布视频流，云端录制会停止对其截图，并发送 [Agora 消息通知服务](https://docs.agora.io/cn/cloud-recording/cloud_recording_callback_rest)的回调。其他用户的截图不受影响。当该用户再次发布视频流时，云端录制会恢复对其截图。
