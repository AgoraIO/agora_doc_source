---
title: Image Enhancement
platform: Android
updatedAt: 2020-11-16 04:08:37
---
## Introduction
Agora provides an image enhancement API for users in social and entertainment scenarios to improve their appearance in video calls or live broadcasts. With this API, users can adjust settings such as the image contrast, brightness, sharpness, and red saturation, as shown in the following figure:

![](https://web-cdn.agora.io/docs-files/1553753660177)

## Implementation
Ensure that you prepare the development environment. See [Integrate the SDK](start_live_android).

The Agora SDK provides the [setBeautyEffectOptions](./API%20Reference/java/v2.4.0/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#aa9327de4fb0c29f840b1e68ca2e83fc6) method to enable developers to flexibly add image enhancement features.

This method has two parameters: 

- `enabled`: sets whether or not to enable image enhancement.
- `options`: sets the image enhancement options, including `lighteningContrastLevel` for adjusting the contrast level, `lightening` for adjusting the brightness level, `smoothness` for adjusting the sharpness level, and `redness` for adjusting the red saturation level.

```java
mRtcEngine.setBeautyEffectOptions(true, new BeautyOptions(LIGHTENING_CONTRAST_NORMAL, 0.5F, 0.5F, 0.5F));
```

## Considerations
This API method has return values. If the method call fails, the return value is < 0.