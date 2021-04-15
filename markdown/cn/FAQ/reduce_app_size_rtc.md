---
title: 如何设置录制的输出视频属性？
platform: ["Linux"]
updatedAt: 2021-01-22 10:14:41
Products: ["Recording"]
---

RTC Native SDK 支持的功能日益增多，包体积也随之增加。本文介绍如何减少集成 SDK 后的 app 体积。

## 方案一、使用音频 SDK

视频 SDK 的功能全，包体积大。如果你只需使用纯音频功能，Agora 推荐你集成音频 SDK。

## 方案二、删除不需要的插件

SDK 提供插件列表，即可选集成到项目文件的动态库。插件的命名以 `Extension` 为后缀，详见[插件列表](#extension_libraries)。

如果你不需要使用相关插件功能，你可以直接删除对应的插件，以减少 app 体积。

### <a name="extension_libraries"></a>插件列表

#### **AI 降噪插件**

SDK 默认开启传统降噪，以消除大部分平稳噪声。AI 降噪是指在传统降噪的基础上消除非平稳噪声。集成 AI 降噪插件后，你可以调用 `enableDeepLearningDenoise` 开启 AI 降噪。

各平台插件名及集成后 app 增加的体积见下表：

| 平台    | 架构        | 库名                                | 集成后 app 增加的体积（KB） |
| :------ | :---------- | :---------------------------------- | :-------------------------- |
| Android | arm64-v8a   | libagora_ai_denoise_extension.so    | 1120                        |
| Android | armeabi-v7a | libagora_ai_denoise_extension.so    | 792                         |
| iOS     | arm64       | AgoraAIDenoiseExtension.xcframework | 502                         |
| iOS     | armv7       | AgoraAIDenoiseExtension.xcframework | 448                         |
| macOS   | arm64       | AgoraAIDenoiseExtension.framework   | 496                         |
| macOS   | x86_64      | AgoraAIDenoiseExtension.framework   | 588                         |
| Windows | x86         | libagora_ai_denoise_extension.dll   | 5312                        |
| Windows | x86_64      | libagora_ai_denoise_extension.dll   | 5424                        |

#### AV1 插件

AV1 功能可以提升屏幕共享中文本共享的清晰度。如需使用该功能，请[提交工单](https://agora-ticket.agora.io/)联系技术支持。

各平台插件名及集成后 app 增加的体积见下表：

| 平台    | 架构        | 库名                                                         | 集成后 app 增加的体积（KB） |
| :------ | :---------- | :----------------------------------------------------------- | :-------------------------- |
| Android | arm64-v8a   | libagora_dav1d_extension.so | 696                         |
| Android | armeabi-v7a | libagora_dav1d_extension.so | 608                         |
| iOS     | arm64       | AgoraDav1dExtension.xcframework                              | 959                         |
| iOS     | armv7       | AgoraDav1dExtension.xcframework                              | 746                         |
| macOS   | x86_64      | AgoraDav1dExtension.framework                                | 1316                        |
| Windows | x86         | libagora_dav1d_extension.dll                                 | 1252                        |
| Windows | x86_64      | libagora_dav1d_extension.dll                                 | 1756                        |

#### JND 插件

JND 功能用于视频感知编码，在保障同等画质的前提下降低带宽消耗。例如，在带宽受限场景下提升视频流畅性，在移动网络场景下降低流量消耗。如需使用该功能，请[提交工单](https://agora-ticket.agora.io/)联系技术支持。

各平台插件名及集成后 app 增加的体积见下表：

| 平台    | 架构        | 库名                                                         | 集成后 app 增加的体积（KB） |
| :------ | :---------- | :----------------------------------------------------------- | :-------------------------- |
| Android | arm64-v8a   | libagora_jnd_extension.so | 1172                        |
| Android | armeabi-v7a | libagora_jnd_extension.so | 816                         |
| iOS     | arm64       | AgoraJNDExtension.xcframework                                | 78                          |
| iOS     | armv7       | AgoraJNDExtension.xcframework                                | 69                          |
| macOS   | arm64       | AgoraJNDExtension.framework                                  | 720                         |
| macOS   | x86_64      | AgoraJNDExtension.framework                                  | 616                         |
| Windows | x86         | libagora_jnd_extension.dll                                   | 1528                        |
| Windows | x86_64      | libagora_jnd_extension.dll                                   | 1948                        |