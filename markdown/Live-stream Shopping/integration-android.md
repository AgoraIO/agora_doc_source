## 方案概览

你可以在教师端和学生端集成[声网 SDK](https://docs.agora.io/cn/Agora%20Platform/terms?platform=All%20Platforms#agora-rtc-sdk)、[声网 RTM SDK](https://docs.agora.io/cn/Agora%20Platform/terms?platform=All%20Platform#agora-rtm-sdk)、[声网互动白板 SDK](https://docs.agora.io/cn/whiteboard/landing-page?platform=Android)，并使用[声网云端录制服务](https://docs.agora.io/cn/Agora%20Platform/terms?platform=All%20Platform#cloud-recording)来搭建一对 N 在线小班课场景。

![](https://web-cdn.agora.io/docs-files/1677221469890)

各 SDK 或服务实现的功能如下：

|声网产品         | 实现功能                                             |
| :----------------- | :--------------------------------------------------- |
|[声网 SDK](https://docs.agora.io/cn/Video/product_video)      | 加入 RTC 频道，进行实时音视频互动。                  |
|[声网 RTM SDK](https://docs.agora.io/cn/Real-time-Messaging/product_rtm)      | 登录 RTM 系统并加入 RTM 频道，实现收发实时文字消息。 |
|[声网互动白板服务](https://docs.agora.io/cn/whiteboard/product_whiteboard) | 实现互动白板相关功能。                               |
|[声网云端录制服务](https://docs.agora.io/cn/cloud-recording/product_cloud_recording) | 录制实时音视频、录制完成后即时回放。                 |