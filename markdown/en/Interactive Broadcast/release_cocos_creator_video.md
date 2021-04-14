---
title: Release Notes
platform: Cocos Creator
updatedAt: 2020-12-15 10:15:05
---
This page provides the release notes for the Agora Cocos Creator SDK.

## Introduction

The Agora Cocos Creator SDK, developed upon the Agora Android SDK and the Agora iOS SDK, supports all functions for the corresponding versions of these SDKs. The Agora Cocos Creator SDK typically supports the following scenarios:

- Voice Call
- Live Interactive Audio Streaming

For the key features included in each scenario, see [Agora Voice Call Overview](./product_voice) and [Agora Live Interactive Audio Streaming Overview](./product_live_audio).

## v3.1.2

v3.1.2 was released on October 30, 2020.

**Main features**

#### 1. Mobile platform support

This release supports iOS and Android platforms.

#### 2. Interoperability with the Agora Web SDK

This release enables interoperability with the Agora Web SDK by default.

#### 3. Encryption

This release supports encrypting audio streams. The following table shows the encryption libraries for the Android and iOS platforms. If you do not intend to use this function, you can remove the encryption libraries to decrease the SDK size.

| Platform | Encryption libraries             |
| :------- | :------------------------------- |
| Android  | `libagora-crypto.so`             |
| iOS      | `AgoraRtcCryptoLoader.framework` |

#### 4. Cloud proxy

This release supports the cloud proxy service. See [Use Cloud Proxy](./cloudproxy_native) for details.

**Reference**

See the following documentation to quickly integrate the SDK and implement real-time voice communication in your project.

- [Start a Voice Call](./start_call_audio_cocos_creator) or [Start Live Interactive Audio Streaming](./start_live_audio_cocos_creator)
- [API Reference](./API%20Reference/cocos_creator_voice/index.html)

Agora also provides an open-source [Voice-Call-for-Mobile-Gaming](https://github.com/AgoraIO/Voice-Call-for-Mobile-Gaming/tree/master/Basic-Voice-Call-for-Gaming/Hello-CocosCreator-Voice-Agora) on GitHub.