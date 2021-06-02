---
title: Rate Call
platform: Android
updatedAt: 2020-11-16 04:26:08
---
## Introduction

When a call or interactive live streaming ends, you can gather feedback on the quality of experience to improve your product by asking your users to rate the call or interactive live streaming.

The Agora SDK provides methods for you to collect your users' ratings and comments on the calls.

After the rating function is implemented, you can see your users' ratings in [Agora Analytics](./aa_guide), as shown in the figure below:

![](https://web-cdn.agora.io/docs-files/1545801217929)

## Implementation 

Before proceeding, ensure that you implement a basic video call or live broadcast in your project. See [Start a Call](start_call_android)/[Start a Live Broadcast](start_live_android) for details.

Refer to the following steps to rate the call:

1. The user that has joined the channel calls the `getCallId` method to get current call ID.
2. The user that has left the channel calls the `rate` method to rate the call.

### Sample code

```java
// Java
// Get current call ID. Rate 5 and give description.
String callId = rtcEngine.getCallId();
rtcEngine.rate(callId, 5, "This is an awesome call!");
```

### API Reference

- [`getCallId`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#aa4d80e8de0e8ae4d2fd3f153945d289f)
- [`rate`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#ab7083355af531cc43d455024bd1f7662)