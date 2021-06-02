---
title: Channel Encryption
platform: Web
updatedAt: 2021-02-14 04:42:23
---
<div class="alert note">This article only applies to the Agora Web SDK 4.x. If you use the Web SDK 3.x or earlier versions, see <a href="./channel_encryption_web?platform=Web">Channel Encryption</a>.</li></div>

## Introduction

To improve data security, developers can encrypt users' media streams during the real-time engagement. Agora supports built-in encryption, and you can set the encryption mode and encryption secret.

<div class="alert note"><li>Both the communication and interactive live streaming scenarios support encryption, but Agora does not support pushing encrypted streams to the CDN in a live-streaming channel.</li><li>Eure that both the receivers and senders use the same encryption scheme. Otherwise, undefined behaviors such as no voice and black screen may occour.</li></div>

The following diagram describes the encrypted data transmission process:
![](https://web-cdn.agora.io/docs-files/1590556634763)

## Implementation

Before proceeding, ensure that you have read the quickstart guides and implemented basic real-time audio and video functions in your project.

Before joining a channel, call `setEncryptionConfig` to set the encryption mode and encryption secret.

<div class="alert note">All users in the same channel must use the same encryption mode and encryption secret.</div>

The `client` object in the following sample code is created by calling `AgoraRTC.createClient`.

```js
// Sets the encryption mode.
// Sets the encryption password.
client.setEncryptionConfig(encryptionMode, password);
```

### API reference
- [`AgoraRTCClient.setEncryptionConfig`](./API%20Reference/web_ng/interfaces/iagorartcclient.html#setencryptionconfig)

## Considerations
Call `AgoraRTCClient.setEncryptionConfig` before joining a channel.

