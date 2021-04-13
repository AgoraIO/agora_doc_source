---
title: How can I rate a call?
platform: ["Android","iOS","macOS","Windows","Unity"]
updatedAt: 2020-10-15 15:53:56
Products: ["Voice","Video","Interactive Broadcast"]
---
When a call ends, you can collect users' subjective evaluation of the call quality experience to improve your product. The Agora RTC SDK provides methods for you to collect your users' ratings and feedbacks.

After implementing the rating function, you can see users' ratings in [Agora Analytics](https://docs.agora.io/en/Agora%20Platform/aa_guide?platform=All%20Platforms), as shown in the following figure:

![](https://web-cdn.agora.io/docs-files/1545801217929)

## Implementation

> Before proceeding, ensure that you implement a basic video call or live interactive video streaming in your project.

Refer to the following steps to implement the rating function:

1. When the user is in a channel, call `getCallId` to get current call ID.
2. After the user leaves the channel, call `rate` to rate the call.

### Sample code

```java
// Java
// Get current call ID. Rate 5 and give description.
String callId = rtcEngine.getCallId();
rtcEngine.rate(callId, 5, "This is an awesome call!");
```

```swift
// Swift
// Get current call ID. Rate 5 and give description.
agoraKit.rate(agoraKit.getCallId(), 5, "This is an awesome call!");
```

```objective-c
// Objective-C
// Get current call ID. Rate 5 and give description.
NSString* callId = [agoraKit getCallId];
[agoraKit rate:callId rating:5 description:@"This is an awesome call!"];
```

```C++
// C++
// Get current call ID. Rate 5 and give description.
lpAgoraEngine->getCallId(callId);
lpAgoraEngine->rate(wdCallId, 5, "This is an awesome call!");
```

```C#
// C#
// Get current call ID. Rate 5 and give description.
String callId = mRtcEngine.GetCallId();
mRtcEngine.Rate(callId, 5, "This is an awesome call!");
```


### API reference

- Java for Android

    - [`getCallId`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#aa4d80e8de0e8ae4d2fd3f153945d289f)
    - [`rate`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#ab7083355af531cc43d455024bd1f7662)

- Objective-C for iOS/macOS
    - [`getCallId`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/getCallId)
    - [`rate`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/rate:rating:description:)

- C++ for All platforms
    - [`getCallId`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#af67688d89526926718edb26938d65541)
    - [`rate`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#a748c30a6339ec9798daa0d1b21585411)

- C# for Unity
    - [`GetCallId`](./API%20Reference/unity/classagora__gaming__rtc_1_1_i_rtc_engine.html#ab6b0ec1b64c5c9ec417819af0c70385a)
    - [`Rate`](./API%20Reference/unity/classagora__gaming__rtc_1_1_i_rtc_engine.html#a2de30387e035e21f20f5bf5aebc001f5)