---
title: 业务系统对接
platform: Android
updatedAt: 2021-03-12 06:33:18
---
声网灵动课堂主要提供的是课堂内的实时互动体验，本身不提供用户系统和排课系统。

如果你已有用户系统和排课系统，可以参考下图将你的用户系统和排课系统与声网灵动课堂进行对接。

![](https://web-cdn.agora.io/docs-files/1611128449673)

你需要实现以下业务逻辑：

- 在你的服务端部署 RTM Token 生成器，通过 Agora App ID、App 证书和用户 ID 参数生成 RTM Token。详情请参考[生成 RTM Token](https://docs.agora.io/cn/Real-time-Messaging/token_server_rtm) 文档。
- 设计一个 RESTful API，用于实现以下三个目的：
  - 验证登录 App 的用户是否在用户系统中存在。
  - 获取该用户的个人信息与排课信息。
  - 获取 RTM Token 生成器为该用户签发的 RTM Token。

客户端获取到用户 ID、课堂 ID 和 RTM Token 后，根据《快速接入》文档调用 Agora Edu SDK 的 `launch` 方法，传入用户 ID、课堂 ID 和 RTM Token 以及其他参数，即可启动声网灵动课堂。

<div class="alert note"><li>请确保用户 ID 和课堂 ID 的全局唯一性。<li>课堂会在第一个用户进入后自动创建，并在最后一个用户离开后 1 小时彻底销毁。声网不会保存你的用户和课堂信息。</div>