---
title: Rate the Call
platform: Android
updatedAt: 2018-12-27 15:34:37
---
## Introduction

When a call or interactive live streaming ends, you can gather feedback on the quality of experience to improve your product by asking your users to rate the call or interactive live streaming.

The Agora SDK provides methods for you to collect your users' ratings and comments on the calls.

After the rating function is implemented, you can see your users' ratings in [Agora Analytics](./aa_guide), as shown in the figure below:

![](https://web-cdn.agora.io/docs-files/1545801217929)

## Implementation
Ensure that you prepare the development environment. See [Integrate the SDK](./android_audio).

```java
String callId = rtcEngine.getCallId();
rtcEngine.rate(callId, 5, "This is an awesome call!");
```

### API Reference

- [rate](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#ab7083355af531cc43d455024bd1f7662)
- [getCallId](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#aa4d80e8de0e8ae4d2fd3f153945d289f)

## Considerations

The API methods have return values. If the method call fails, the return value is < 0.