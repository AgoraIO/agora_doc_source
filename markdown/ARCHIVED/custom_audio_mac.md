---
title: 自定义音频采集和渲染
platform: macOS
updatedAt: 2019-09-20 17:31:50
---
## 功能介绍

实时通信过程中，Agora SDK 通常会启动默认的音频模块进行采集和渲染。如果想要在客户端实现自定义音频采集和渲染，则可以使用自定义的音频源或渲染器，来进行实现。

**自定义采集**主要适用于以下场景：

- 当 SDK 内置的音频源不能满足开发者需求时，比如需要使用自定义的前处理库。
- 开发者的 App 中已有自己的音频模块，为了复用代码，也可以自定义音频源。

## 实现方法

在开始自定义采集前，请确保你已完成环境准备、安装包获取等步骤，详见[集成客户端](./mac_video)。

### 自定义音频源

你可以使用 Push 方法自定义音频源。该方法下，SDK 默认不会对采集传入的音频数据做消噪等处理。如有音频消噪需求，需要开发者自行实现。

```swift
// swift
// 推入数据类型为 rawData
agoraKit.pushExternalAudioFrameRawData("your rawData", samples: "per push samples", timestamp: 0)

// 推入数据类型为 CMSampleBuffer
agoraKit.pushExternalAudioFrameSampleBuffer("your CMSampleBuffer")
```

```objective-c
// objective-c
// 推入数据类型为 rawData
[agoraKit pushExternalAudioFrameRawData: "your rawData" samples: "per push samples", timestamp: 0];

// 推入数据类型为 CMSampleBuffer
[agoraKit pushExternalAudioFrameSampleBuffer: "your CMSampleBuffer"];
```

####  API 参考
* [`pushExternalAudioFrameRawData:samples:timestamp:`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/pushExternalAudioFrameRawData:samples:timestamp:)
* [`pushExternalAudioFrameSampleBuffer:`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/pushExternalAudioFrameSampleBuffer:)



## 开发注意事项
客户端自定义采集和渲染属于较复杂的功能，开发者自身需要具备音频相关知识，能够自己独立开发完成采集与渲染。