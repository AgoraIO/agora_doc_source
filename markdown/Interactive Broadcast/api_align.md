---
title: 核心方法对照表
platform: All Platforms
updatedAt: 2020-12-30 09:01:41
---

Agora SDK 支持多个平台，但是由于平台差异，不同平台在 API 的调用和实现上不完全一致，本文将 Android，iOS/macOS，Windows 和 Web 这几个平台的核心功能 API 对照列出，帮助你快速了解各个平台之间的差异。

## 初始化

初始化时需要传入你的项目的 [App ID](./token?platform=All%20Platforms#app-id)，只有 App ID 相同的应用程序才能进入同一个频道进行互通。

| 平台      | API                                                                                                                                                                                                  |
| --------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Android   | [create](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a35466f690d0a9332f24ea8280021d5ed)                                                                                       |
| iOS/macOS | [sharedEngineWithAppId](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/sharedEngineWithAppId:delegate:)                                                                              |
| Web       | [AgoraRTC.createClient](./API%20Reference/web/globals.html#createclient) <br>[Client.init](./API%20Reference/web/interfaces/agorartc.client.html#init)                                               |
| Windows   | [createAgoraRtcEngine](./API%20Reference/cpp/group__create_agora_rtc_engine.html) <br> [initialize](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#ac71db65e66942e4e0a0550e95c16890f) |

## 设置频道模式

Agora SDK 需要知道应用程序的使用场景（例如通信模式或直播模式）， 从而使用不同的优化手段。

| 平台      | API                                                                                                                       |
| --------- | ------------------------------------------------------------------------------------------------------------------------- |
| Android   | [setChannelProfile](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a1bfb76eb4365b8b97648c3d1b69f2bd6) |
| iOS/macOS | [setChannelProfile](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setChannelProfile:)                    |
| Web       | [createClient](./API%20Reference/web/globals.html#createclient)<sup>[1]</sup>                                             |
| Windows   | [setChannelProfile](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#aab53788c74da25080bad61f0525d12ae)      |

> [1] 通过 `createClient` 中的 `ClientConfig` 的设置实现，详见 [ClientConfig](./API%20Reference/web/interfaces/agorartc.clientconfig.html)。

## 设置用户角色

如果频道模式设置为直播，频道内的用户分为主播和观众两种角色，可以通过调用 API 设置用户的角色。两者的区别在于：

- 主播：可以接收和发布音视频。
- 观众：不能发布音视频，只能接收主播的音视频。

| 平台      | API                                                                                                                   |
| --------- | --------------------------------------------------------------------------------------------------------------------- |
| Android   | [setClientRole](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#aa2affa28a23d44d18b6889fba03f47ec) |
| iOS/macOS | [setClientRole](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setClientRole:)                        |
| Web       | 无<sup>[2]</sup>                                                                                                      |
| Windows   | [setClientRole](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#a89ca6a15d5a388f3c82038e74bad4040)      |

> [2] Web 平台目前没有用于设置用户角色的方法，但是你可以通过调用 `Client.publish`，`Client.unpublish` 和 `Client.subscribe` 来实现主播和观众的角色设置，详见[切换用户角色](./role_web?platform=Web)。

## 加入频道

加入频道时需要传入能标识频道的频道名，输入相同频道名称的用户会进入同一个频道。

如果安全要求较高，可以在该方法中设置 Token，用于[校验用户权限](./token?platform=All%20Platforms)。

| 平台      | API                                                                                                                                     |
| --------- | --------------------------------------------------------------------------------------------------------------------------------------- |
| Android   | [joinChannel](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a8b308c9102c08cb8dafb4672af1a3b4c)                     |
| iOS/macOS | [joinChannelByToken](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/joinChannelByToken:channelId:info:uid:joinSuccess:) |
| Web       | [Client.join](./API%20Reference/web/interfaces/agorartc.client.html#join)                                                               |
| Windows   | [joinChannel](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#adc937172e59bd2695ea171553a88188c)                          |

## 离开频道

通话或直播结束时，调用离开频道的方法退出通话或直播。

不论当前是否还在通话或直播频道中，调用该方法会把通话或直播相关的所有资源释放掉。真正退出频道后，SDK 会触发相应的回调。

| 平台      | API                                                                                                                  |
| --------- | -------------------------------------------------------------------------------------------------------------------- |
| Android   | [leaveChannel](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a2929e4a46d5342b68d0deb552c29d597) |
| iOS/macOS | [leaveChannel](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/leaveChannel:)                         |
| Web       | [Client.leave](./API%20Reference/web/interfaces/agorartc.client.html#leave)                                          |
| Windows   | [leaveChannel](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#a51c12d209373650638bfd82e28777081)      |

## 更新 Token

如果在加入频道时设置了 Token，过一段时间后使用的 Token 会失效，需要调用 API 更换新的 Token。

| 平台      | API                                                                                                                |
| --------- | ------------------------------------------------------------------------------------------------------------------ |
| Android   | [renewToken](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#af1428905e5778a9ca209f64592b5bf80) |
| iOS/macOS | [renewToken](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/renewToken:)                           |
| Web       | [Client.renewToken](./API%20Reference/web/interfaces/agorartc.client.html#renewtoken)                              |
| Windows   | [renewToken](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#a8f25b5ff97e2a070a69102e379295739)      |

## 打开互通

如果频道模式设置为通信，各平台默认与 Web SDK 互通，无需额外设置。

如果频道模式设置为直播，通话中要保证各平台与 Web 平台的互通，必须调用 API 手动设置。

| 平台              | API                                                                                                                                      |
| ----------------- | ---------------------------------------------------------------------------------------------------------------------------------------- |
| Android           | [enableWebSdkInteroperability](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a49636ee063476d7c3da533668771fa03)     |
| iOS/macOS         | [enableWebSdkInteroperability](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/enableWebSdkInteroperability:)             |
| Web<sup>[3]</sup> | N/A                                                                                                                                      |
| Windows           | [enableWebSdkInteroperability](./API%20Reference/cpp/classagora_1_1rtc_1_1_rtc_engine_parameters.html#a5b82667e75a8f299a60b9b7968da48de) |

> [3] Web 平台如需与其他各平台互通，需要将 [ClientConfig](./API%20Reference/web/interfaces/agorartc.clientconfig.html) 中的 `mode` 设置为 `live`。

## 销毁实例

销毁实例可以释放 Agora SDK 使用的所有资源。销毁实例后，如果需要再次使用通话功能，必须重新进行初始化。

| 平台      | API                                                                                                             |
| --------- | --------------------------------------------------------------------------------------------------------------- |
| Android   | [destroy](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#afb808cdc9025a77af7dd2bce98311bfe) |
| iOS/macOS | [destroy](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/destroy)                               |
| Web       | N/A                                                                                                             |
| Windows   | [release](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#afe4804c1f53bfee301c0960fda006c47)      |
