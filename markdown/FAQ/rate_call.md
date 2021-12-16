---
title: 如何给通话评分？
platform: ["Android","iOS","macOS","Windows","Unity"]
updatedAt: 2020-11-10 06:01:33
Products: ["Interactive Broadcast","Video","Voice"]
---
通话结束后，你可以收集用户对通话质量体验的主观评价，以改进产品。Agora RTC SDK 提供相关方法支持用户为通话评分并提供反馈意见。

实现评分功能后，你可以在[水晶球](https://docs.agora.io/cn/Agora%20Platform/aa_guide?platform=All%20Platforms)的**通话调查**里看到用户对通话的评分，如下图所示：

![](https://web-cdn.agora.io/docs-files/1545801192291)

## 实现方法

> 在实现通话评分功能前，请确保你已在项目中完成基本的实时音视频功能。

参考如下步骤，在你的项目中实现通话评分功能：

1. 加入频道后，调用 `getCallId` 方法获取当前通话 ID。
2. 离开频道后，调用 `rate` 方法给该通话评分。

### 示例代码

```java
// Java
// 获取通话 ID，给通话质量评 5 分，并进行描述。
String callId = rtcEngine.getCallId();
rtcEngine.rate(callId, 5, "This is an awesome call!");
```

```swift
// Swift
// 获取通话 ID，给通话质量评 5 分，并进行描述。
agoraKit.rate(agoraKit.getCallId(), 5, "This is an awesome call!");
```

```objective-c
// Objective-C
// 获取通话 ID，给通话质量评 5 分，并进行描述。
NSString* callId = [agoraKit getCallId];
[agoraKit rate:callId rating:5 description:@"This is an awesome call!"];
```

```C++
// C++
// 获取当前通话 ID。
lpAgoraEngine->getCallId(callId);
// 给通话质量评 5 分，并进行描述。
lpAgoraEngine->rate(wdCallId, 5, "This is an awesome call!");
```

```C#
// C#
// 获取通话 ID，给通话质量评 5 分，并进行描述。
String callId = mRtcEngine.GetCallId();
mRtcEngine.Rate(callId, 5, "This is an awesome call!");
```

### API 参考

- Java

    - [`getCallId`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#aa4d80e8de0e8ae4d2fd3f153945d289f)
    - [`rate`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#ab7083355af531cc43d455024bd1f7662)

- Objective-C
    - [`getCallId`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/getCallId)
    - [`rate`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/rate:rating:description:)

- C++
    - [`getCallId`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#af67688d89526926718edb26938d65541)
    - [`rate`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#a748c30a6339ec9798daa0d1b21585411)

- C#
    - [`GetCallId`](./API%20Reference/unity/classagora__gaming__rtc_1_1_i_rtc_engine.html#ab6b0ec1b64c5c9ec417819af0c70385a)
    - [`Rate`](./API%20Reference/unity/classagora__gaming__rtc_1_1_i_rtc_engine.html#a2de30387e035e21f20f5bf5aebc001f5)