---
title: Image Enhancement
platform: Windows
updatedAt: 2020-11-16 04:08:48
---
## Introduction

Agora provides an image enhancement API for users in social and entertainment scenarios to improve their appearance in a video call or interactive live video streaming. With this API, users can adjust settings such as the image contrast, brightness, sharpness, and red saturation, as shown in the following figure:

![](https://web-cdn.agora.io/docs-files/1553753660177)

## Implementation

Before proceeding, ensure that you have implemented basic real-time functions in your project. See [Start a  Call](start_call_windows) or [Start Live Interactive Streaming](start_live_windows) for details.

Call the [`setBeautyEffectOptions`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#a5899cc462e5250028c9afada4df98d48) method to flexibly add image enhancement features.

This method has two parameters: 

- `enabled`: Sets whether or not to enable image enhancement.
- `options`: Sets the image enhancement options, including `lighteningContrastLevel` for adjusting the contrast level, `lighteningLevel` for adjusting the brightness level, `smoothnessLevel` for adjusting the sharpness level, and `rednessLevel` for adjusting the red saturation level.

### Sample code

```c++
bool enabled = true;
agora::rtc::BeautyOptions options;
options.lighteningContrastLevel = BeautyOptions::LIGHTENING_CONTRAST_NORMAL;
options.lighteningLevel = 0.7;
options.smoothnessLevel = 0.5;
options.rednessLevel = 0.1;
  
m_lpAgoraEngine->setBeautyEffectOptions(enabled, options);
```

We also provide an open-source demo project [OpenLive-Windows](https://github.com/AgoraIO/Basic-Video-Broadcasting/tree/master/OpenLive-Windows)  on GitHub that implements the image enhancement function.