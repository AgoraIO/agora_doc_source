---
title: 如何处理 Token 相关错误码？
platform: ["All Platforms"]
updatedAt: 2020-09-22 16:53:56
Products: ["Voice","Video","Interactive Broadcast"]
---
当你的 Agora 项目启用了 App Certificate，则表示你选择使用动态密钥 Token 对用户进行鉴权。

由于 Token 具有一定的时效性，因此 app 在运行过程中，你有可能会收到如下与 Token 相关的错误码或事件回调。本文对这些事件进行了梳理，提供触发的原因以及解决方法，帮助你在 App 出现异常时进行问题排查。

<div class="alert note">本文适用于 RTC 产品。</div>

## 101：App ID 无效

**问题描述：**

- Native 端：SDK 在初始化 Agora 服务时返回错误码 `ERR_INVALID_APP_ID(101)`；或调用 `joinChannel` 方法加入频道时，SDK 回调 `onError` 事件，并报告错误码 `ERR_INVALID_APP_ID(101)`。
- Web 端：在初始化  Agora 服务或调用 `Client.join` 方法加入频道时，Console 控制台打印错误码 `ERR_INVALID_VENDOR_KEY(101)`。

**问题原因：** 不是有效的 App ID，一般是由于 App ID 的数据类型不对引起的。

**解决方法：** 建议检查 App ID 数据格式是否有效。Agora 的 App ID 为 String 型，请使用正确数据类型的  App ID，重新初始化 Agora 服务。

## 109/118/2：Token 已过期

**问题描述：**

- Native 端：调用 `joinChannel` 方法加入频道时，SDK 回调 `onError` 事件，并报告错误码 `ERR_TOKEN_EXPIRED(109)`。
- Web 端：调用 `Client.join` 方法加入频道时，Console 控制台打印错误码 `ERR_DYNAMIC_KEY_TIMEOUT(109)` 或 `ERR_DYNAMIC_KEY_EXPIRED(118)`。

**问题原因：** Token 过期。

**解决方法：** Token 一旦过期，你就需要在服务端重新生成一个 Token，然后调用  `renewToken` 方法尝试重新加入频道。
		
## 110：Token 无效

**问题描述：**

- Native 端：调用 `joinChannel` 方法加入频道时，SDK 回调 `onError` 事件，并报告错误码 `ERR_INVALID_TOKEN(110)`。
- Web 端：调用 `Client.join` 方法加入频道时，Console 控制台打印错误码 `ERR_NO_AUTHORIZED(110)`。

**问题原因：** 生成的 Token 无效。一般有以下原因：

- 你的 Agora 项目开启了 App Certificate，但是加入频道时却未传入 Token；或者项目未开启 App Certificate，就试图使用 Token 加入频道。
- 你在服务端生成 Token 时填入的 App ID、用户 ID 和频道名，与你初始化和加入频道时填入的 App ID、用户 ID 和频道名不匹配。

**解决方法：**

- 在加入频道前，请确认你在初始化时填入的 App ID 对应的项目是否已开启 App Certificate。如果未开启 App Certificate，则不能使用 Token 加入频道；如果已开启，则必须使用 Token 加入频道。
- 当确认使用 Token 加入频道时，还需要确认： 
	- 用于生成 Token 的 App ID 和初始化服务时填入的 App ID 一致。
	- 用于生成 Token 的用户 ID 和加入频道时填入的用户 ID 一致，且数据类型也一致。
	- 用于生成 Token 的频道名和加入频道时填入的频道名一致。

## 119：静态厂商使用动态密钥

<div class="alert note">该错误码仅适用于 RTC Web SDK。</div>

**问题描述：** Web 端调用 `Client.join` 方法加入频道时，Console 控制台打印错误码 `ERR_STATIC_USE_DYNAMIC_KEY(119)`。

**问题原因：** 表示静态厂商使用了动态密钥。一般是由于使用的 App ID 对应的 Agora 项目未启用  App Certificate，却试图使用 Token 加入频道引起。

**解决方法：** 对于未开启 App Certificate 的项目，你可以不使用 token 加入频道。你也可以先启用 App Certificate，然后在服务端生成 Token 后重新加入频道。

## 120：动态厂商使用静态密钥

<div class="alert note">该错误码仅适用于 RTC Web SDK。</div>

**问题描述：** Web 端调用 `Client.join` 方法加入频道时，Console 控制台打印错误码 `ERR_DYNAMIC_USE_STATIC_KEY(120)`。

**问题原因：** 表示动态厂商使用了静态密钥。一般是由于使用的 App ID 对应的 Agora 项目已经启用 App Certificate，加入频道时却没有传入 Token 引起。

**解决方法：** App ID 对应的项目一旦启用  App Certificate，就必须使用 Token 进行鉴权。你也可以换一个没有启用 App Certificate 的项目的 App ID，然后尝试重新加入频道。

## Token 过期相关事件回调

为保证通信体验，Agora 提供如下两个回调，提醒用户 Token 即将过期或已经过期：

- `onTokenPrivilegeWillExpire`：该回调表示 Token 即将在 30 秒内失效。收到这个回调时，你需要在服务端重新生成 Token，然后调用 `renewToken` 方法，将新生成的 Token 传给 SDK。
- `onRequestToken`（Web 平台为 `onTokenPrivilegeDidExpire`）：该回调表示 Token 已经失效。收到这个回调时，你需要在服务端重新生成 Token，然后调用 `joinChannel` 方法重新尝试加入频道。

## 各语言 Token 错误码对照表

| 错误码 | Java/C++/C# | Objective-C | Javascript |
| ---------------- | ---------------- | ---------------- | ---------------- |
| 101      | `ERR_INVALID_APP_ID`      | `AgoraErrorCodeInvalidAppId`      | `ERR_INVALID_VENDOR_KEY` |
| 109      | `ERR_TOKEN_EXPIRED`      | `AgoraErrorCodeTokenExpired`      | `ERR_DYNAMIC_KEY_TIMEOUT` |
| 110      | `ERR_INVALID_TOKEN`      | `AgoraErrorCodeInvalidToken`      | `ERR_NO_AUTHORIZED` |
| 2      | /      | /      | `K_TIMESTAMP_EXPIRED` |
| 118      | /      | /      | `ERR_DYNAMIC_KEY_EXPIRED` |
| 119      | /      | /      | `ERR_STATIC_USE_DYNAMIC_KEY` |
| 120      | /      | /      | `ERR_DYNAMIC_USE_STATIC_KEY` |
