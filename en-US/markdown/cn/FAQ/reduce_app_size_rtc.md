---
title: 如何设置录制的输出视频属性？
platform: ["Linux"]
updatedAt: 2021-01-22 10:14:41
Products: ["Recording"]
---

RTC Native SDK supports more and more functions, and the package size also increases. This article describes how to reduce the app size after integrating the RTC Native SDK.

## Solution 1: Use the Audio SDK

The Video SDK supports both audio and video functions, so the package size is larger. If you only need to use the audio functions, Agora recommends integrating the Audio SDK.

## Solution 2: Remove unnecessary extension libraries

The SDK provides extension libraries that can be optionally integrated into the project. The name of extension libraries is suffixed with `Extension`. For details, see [Extension libraries](#extension_libraries).

If you do not need the extension functions, you can directly remove the corresponding extension libraries to reduce the app size.

### <a name="extension_libraries"></a>Extension libraries

#### **Deep-learning noise reduction library**

The SDK enables traditional noise reduction by default to reduce most of the stationary background noise. Deep-learning noise reduction adds non-stationary background noise reduction based on the traditional noise reduction. After integrating the deep-learning noise reduction library, you can call `enableDeepLearningDenoise` to enable the deep-learning noise reduction.

See the extension library name of each platform and the increased app size after integration in the following table:

| Platform | Architecture | Library name | Increased app size after integration (KB) |
| :------ | :---------- | :---------------------------------- | :-------------------------- |
| Android | arm64-v8a | libagora_ai_denoise_extension.so | 1120 |
| Android | armeabi-v7a | libagora_ai_denoise_extension.so | 792 |
| iOS | arm64 | AgoraAIDenoiseExtension.xcframework | 502 |
| iOS | armv7 | AgoraAIDenoiseExtension.xcframework | 448 |
| macOS | arm64 | AgoraAIDenoiseExtension.framework | 496 |
| macOS | x86_64 | AgoraAIDenoiseExtension.framework | 588 |
| Windows | x86 | libagora_ai_denoise_extension.dll | 5312 |
| Windows | x86_64 | libagora_ai_denoise_extension.dll | 5424 |

#### AV1 library

The AV1 function improves the clarity of texts when users shares the screen. To use this function, contact [support@agora.io](https://agora-ticket.agora.io/).

See the extension library name of each platform and the increased app size after integration in the following table:

| Platform | Architecture | Library name | Increased app size after integration (KB) |
| :------ | :---------- | :----------------------------------------------------------- | :-------------------------- |
| Android | arm64-v8a | libagora_dav1d_extension.so | 696 |
| Android | armeabi-v7a | libagora_dav1d_extension.so | 608 |
| iOS | arm64 | AgoraDav1dExtension.xcframework | 959 |
| iOS | armv7 | AgoraDav1dExtension.xcframework | 746 |
| macOS | x86_64 | AgoraDav1dExtension.framework | 1316 |
| Windows | x86 | libagora_dav1d_extension.dll | 1252 |
| Windows | x86_64 | libagora_dav1d_extension.dll | 1756 |

#### JND library

The JND (Just-noticeable difference) function is used for video perceptual coding, which reduces bandwidth consumption while keeping the same image quality. For example, this function can improve video smoothness in bandwidth-constrained scenarios, and reduce network traffic consumption in mobile network scenarios. To use this function, contact [support@agora.io](https://agora-ticket.agora.io/).

See the extension library name of each platform and the increased app size after integration in the following table:

| Platform | Architecture | Library name | Increased app size after integration (KB) |
| :------ | :---------- | :----------------------------------------------------------- | :-------------------------- |
| Android | arm64-v8a | libagora_jnd_extension.so | 1172 |
| Android | armeabi-v7a | libagora_jnd_extension.so | 816 |
| iOS | arm64 | AgoraJNDExtension.xcframework | 78 |
| iOS | armv7 | AgoraJNDExtension.xcframework | 69 |
| macOS | arm64 | AgoraJNDExtension.framework | 720 |
| macOS | x86_64 | AgoraJNDExtension.framework | 616 |
| Windows | x86 | libagora_jnd_extension.dll | 1528 |
| Windows | x86_64 | libagora_jnd_extension.dll | 1948 |