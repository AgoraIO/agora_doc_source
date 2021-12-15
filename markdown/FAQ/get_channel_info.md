---
title: 如何获取频道相关信息，例如频道名称，以及频道内的用户列表？
platform:
  [
    "Android",
    "iOS",
    "macOS",
    "Web",
    "Windows",
    "Unity",
    "Cocos Creator",
    "微信小程序",
    "Electron",
    "RESTful",
    "React Native",
    "Flutter",
  ]
updatedAt: 2019-10-24 14:46:46
Products: ["Voice", "Video", "Interactive Broadcast", "live-streaming"]
---

Agora 目前只支持在服务端通过 RESTful API 获取频道相关信息。

你可通过我们提供[查询频道列表接口](https://docs.agora.io/cn/Agora%20Platform/dashboard_restful_communication?platform=All%20Platforms#分页查询厂商频道列表-get)，传入 App ID，获取频道列表，包括频道个数、频道名和频道内用户数量等信息。

此外，你还可以通过[获取频道内用户列表接口](https://docs.agora.io/cn/Agora%20Platform/dashboard_restful_communication?platform=All%20Platforms#获取频道内用户列表-get)，指定频道名，查询该频道是否存在。如存在，则获取频道模式、频道内用户人数和频道内所有用户的 UID 等信息。
