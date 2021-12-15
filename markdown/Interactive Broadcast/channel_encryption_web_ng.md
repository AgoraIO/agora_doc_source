---
title: 媒体流加密
platform: Web
updatedAt: 2021-02-08 03:00:07
---

<div class="alert note">本文仅适用于 Agora Web SDK 4.x 版本。如果你使用的是 Web SDK 3.x 或更早版本，请查看<a href="./channel_encryption_web?platform=Web">媒体流加密</a>。</li></div>

## 功能描述

在实时音视频互动过程中，开发者需要对媒体流加密，从而保障用户的数据安全。Agora 提供内置加密方案，你可以设置加密模式和密钥。

<div class="alert note"><li>通信和直播场景均支持媒体流加密功能。但是在直播场景下，Agora 不支持将加密后的媒体流推到 CDN 上。</li><li>如需使用媒体流加密功能，请确保接收端和发送端都使用相同的加密方案，否则会出现未定义行为（例如音频无声或视频黑屏）。</li></div>

下图描述了启用加密功能后的数据传输流程：
![](https://web-cdn.agora.io/docs-files/1590556854574)

## 实现方法

开始前，请确保你已参考快速开始在你的项目中实现基本的实时音视频功能。

在加入频道前，调用 `setEncryptionConfig` 设置加密模式和密钥。

<div class="alert note">同一频道内所有用户必须使用相同的加密模式和密钥。</div>

Agora 支持 4 种加密模式：

- `"aes-128-xts"`: 128 位 AES 加密，XTS 模式。
- `"aes-256-xts"`: 256 位 AES 加密，XTS 模式。
- `"aes-128-ecb"`: 128 位 AES 加密，ECB 模式。
- `"sm4-128-ecb"`: 128 位 SM4 加密，ECB 模式。

以下示例代码中的 `client` 是指通过 `AgoraRTC.createClient` 创建的本地客户端对象。

```js
// 设置 `encryptionMode ` 选择加密方案。
// `password` 为加密密码。
client.setEncryptionConfig(encryptionMode, password);
```

### API 参考

- [AgoraRTCClient.setEncryptionConfig](./API%20Reference/web/v4.2.1/interfaces/iagorartcclient.html#setencryptionconfig)

## 开发注意事项

请确保在调用 `AgoraRTCClient.join` 加入频道之前设置加密。
