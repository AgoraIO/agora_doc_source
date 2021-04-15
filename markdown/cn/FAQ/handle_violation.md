---
title: 如何处理违规视频？
platform: ["All Platforms"]
updatedAt: 2020-07-09 21:28:34
Products: ["content-moderation"]
---
当检测到违规情况时，你可以采取以下几种处理方式，或结合自己的业务需要采取其他措施。

### 停止发送本地视频流

在客户端调用 Agora RTC SDK 中的 `muteLocalVideoStream`，停止发送问题 UID 的本地视频。

### 封禁违规 UID 或关掉频道

从服务端发送 RESTful API 请求，将违规 UID 踢出频道，或禁用整个违规频道。详见[服务端踢人 RESTful API](https://docs.agora.io/cn/Agora%20Platform/dashboard_restful_communication#服务端踢人-api)。

### 画面模糊化

你可以通过处理原始视频数据，对违规画面进行模糊化处理。你可以参考[原始视频数据](https://docs.agora.io/cn/Interactive%20Broadcast/raw_data_video_android?platform=Android)了解如何获取原始视频数据。

<div class="alert note">声网不提供模糊化处理的 API。你需要自己实现模糊化处理的功能。</div>

