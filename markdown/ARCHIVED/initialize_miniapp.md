---
title: 初始化客户端对象
platform: 微信小程序
updatedAt: 2019-10-29 11:00:13
---
# 初始化

将项目的 App ID 填入 初始化客户端对象 `init` 方法，即可初始化客户端对象。

```
client.init(appId, onSuccess, onFailure);
```

> - 由于小程序 SDK 支持与 Native SDK 和 Web SDK 互通，请确保各 SDK 使用相同的 App ID。
> - 如果你的 App ID 启用了 App 证书，则在 [加入频道](./join_live_mini) 时必须使用 Channel Key 或 Token。
> - 请确保在调用其他 API 前先调用 `client.init` 方法初始化客户端对象。

