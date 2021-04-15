---
title: 如何设置录制的输出视频属性？
platform: ["Linux"]
updatedAt: 2021-01-22 10:14:41
Products: ["Recording"]
---

RTC Native SDK supports more and more functions, and the package size also increases. This article describes how to reduce the size of the app after integrating the SDK.

## Solution 1: Use audio SDK

The video SDK has full functions and a large package. If you only need to use the pure audio function, Agora recommends that you integrate the audio SDK.

## Solution two, delete unnecessary plug-ins

The SDK provides a list of plug-ins, that is, a dynamic library that can be optionally integrated into the project file. The name of the plug-in is suffixed with `Extension`, please refer to [the plug-in list for details](#extension_libraries).

If you don't need to use related plug-in functions, you can directly delete the corresponding plug-in to reduce the size of the app.

### <a name="extension_libraries"></a>List of plugins

#### **AI noise reduction plug-in**

The SDK enables traditional noise reduction mode by default to reduce most of the stationary background noise. AI noise reduction refers to the elimination of non-stationary noise on the basis of traditional noise reduction. After integrating the AI noise reduction plug-in, you can call `enableDeepLearningDenoise` to enable AI noise reduction.

The plug-in name of each platform and the added volume of the integrated app are shown in the following table:

| Platform | Architecture | Library name | Increased volume of the app after integration (KB) |
| :------ | :---------- | :---------------------------------- | :-------------------------- |
| Android: | arm64-v8a | libagora_ai_denoise_extension.so | 1120 |
| Android: | armeabi-v7a folder | libagora_ai_denoise_extension.so | 792 |
| iOS | arm64 | AgoraAIDenoiseExtension.xcframework | 502 |
| iOS | armv7 | AgoraAIDenoiseExtension.xcframework | 448 |
| macOS | arm64 | AgoraAIDenoiseExtension.framework | 496 |
| macOS | x86_64 | AgoraAIDenoiseExtension.framework | 588 |
| Windows | x86 | libagora_ai_denoise_extension.dll | 5312 |
| Windows | x86_64 | libagora_ai_denoise_extension.dll | 5424 |

#### AV1 plug-in

The AV1 function can improve the clarity of text sharing in screen sharing. Contact support@agora.io if you [want ](https://agora-ticket.agora.io/)to raise the limit.

The plug-in name of each platform and the added volume of the integrated app are shown in the following table:

| Platform | Architecture | Library name | Increased volume of the app after integration (KB) |
| :------ | :---------- | :----------------------------------------------------------- | :-------------------------- |
| Android: | arm64-v8a | libagora_dav1d_extension.so | 696 |
| Android: | armeabi-v7a folder | libagora_dav1d_extension.so | 608 |
| iOS | arm64 | AgoraDav1dExtension.xcframework | 959 |
| iOS | armv7 | AgoraDav1dExtension.xcframework | 746 |
| macOS | x86_64 | AgoraDav1dExtension.framework | 1316 |
| Windows | x86 | libagora_dav1d_extension.dll | 1252 |
| Windows | x86_64 | libagora_dav1d_extension.dll | 1756 |

#### JND plugin

The JND function is used for video perceptual coding to reduce bandwidth consumption while ensuring the same image quality. For example, improve video fluency in bandwidth-constrained scenarios, and reduce traffic consumption in mobile network scenarios. Contact support@agora.io if you [want ](https://agora-ticket.agora.io/)to raise the limit.

The plug-in name of each platform and the added volume of the integrated app are shown in the following table:

| Platform | Architecture | Library name | Increased volume of the app after integration (KB) |
| :------ | :---------- | :----------------------------------------------------------- | :-------------------------- |
| Android: | arm64-v8a | libagora_jnd_extension.so | 1172 |
| Android: | armeabi-v7a folder | libagora_jnd_extension.so | 816 |
| iOS | arm64 | AgoraJNDExtension.xcframework | 78 |
| iOS | armv7 | AgoraJNDExtension.xcframework | 69 |
| macOS | arm64 | AgoraJNDExtension.framework | 720 |
| macOS | x86_64 | AgoraJNDExtension.framework | 616 |
| Windows | x86 | libagora_jnd_extension.dll | 1528 |
| Windows | x86_64 | libagora_jnd_extension.dll | 1948 |