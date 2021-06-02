---
title: 为什么第三方云存储中没有录制文件？
platform: ["RESTful"]
updatedAt: 2020-03-12 11:45:16
Products: ["cloud-recording"]
---
录制结束后，在第三方云存储中没有找到录制文件，可能有以下几种原因：
  - 没有发流端加入频道，录制超时。
  - Token 过期或 Token 认证失败。
  - 在调用[获取云端录制资源的 API](https://docs.agora.io/cn/cloud-recording/cloud_recording_api_rest?platform=All%20Platforms#a-nameacquirea%E8%8E%B7%E5%8F%96%E4%BA%91%E7%AB%AF%E5%BD%95%E5%88%B6%E8%B5%84%E6%BA%90%E7%9A%84-api) 时，传入的 `uid` 参数与频道内现有的用户 ID 重复。举例来说，频道内有三个用户，UID 分别为 `123`，`234`，和 `345`，如果你传入的 `uid` 为 `123`， 则会导致录制失败。
  - 在调用[开始云端录制的 API](https://docs.agora.io/cn/cloud-recording/cloud_recording_api_rest?platform=All%20Platforms#a-namestarta开始云端录制的-api) 时，传入的 `transcodingConfig` 参数值不合理，导致录制失败。请参考[如何设置录制视频的分辨率](https://docs.agora.io/cn/faq/recording_video_profile)设置该参数。
  - 你的云存储配置出错。请确保你的云存储配置填写正确：
    - bucket：云存储空间名称， 由你自己在云账户下创建。
    - accessKey：在云存储个人账户下面密钥管理里。
    - secretKey ：在云存储个人账户下面密钥管理里。

  如果你开通了 Agora 消息通知服务，当你的云存储配置出错时，你会收到 [`cloud_recording_error`](https://docs.agora.io/cn/cloud-recording/cloud_recording_callback_rest?platform=All%20Platforms#a-name1a1-cloud_recording_error) 事件的通知。