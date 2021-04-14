---
title: Image Enhancement
platform: Unity
updatedAt: 2020-11-16 04:36:35
---
## Introduction

Agora provides an image enhancement API for users in social and entertainment scenarios to improve their appearance in a video call or live interactive video streaming. With this API, users can adjust settings such as the image contrast, brightness, sharpness, and red saturation, as shown in the following figure:

![](https://web-cdn.agora.io/docs-files/1553753660177)

## Implementation

Before proceeding, ensure that you have implemented basic real-time functions in your project. See [Start a  Call](start_call_unity) or [Start Live Interactive Streaming](start_live_unity) for details.

Call the [`SetBeautyEffectOptions`](./API%20Reference/unity/classagora__gaming__rtc_1_1_i_rtc_engine.html#ad9c5e1a032d8c81c8e2a416a83ca0904) method to flexibly add image enhancement features.

This method has two parameters: 

- `enabled`: Sets whether or not to enable image enhancement.
- `beautyOptions`: Sets the image enhancement options, including `lighteningContrastLevel` for adjusting the contrast level, `lighteningLevel` for adjusting the brightness level, `smoothnessLevel` for adjusting the sharpness level, and `rednessLevel` for adjusting the red saturation level.

### Sample code

```c#
bool enabled = true;
BeautyOptions beautyOptions = new BeautyOptions();
beautyOptions.lighteningContrastLevel = BeautyOptions.LIGHTENING_CONTRAST_LEVEL.LIGHTENING_CONTRAST_HIGH;
beautyOptions.lighteningLevel = 0.7f;
beautyOptions.smoothnessLevel = 0.5f;
beautyOptions.rednessLevel = 0.1f;
// Enables image enhancement and sets the options.
mRtcEngine.SetBeautyEffectOptions(enabled, beautyOptions);
```