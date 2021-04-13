---
title: Rate Call
platform: Unity
updatedAt: 2020-11-16 04:32:37
---
## Introduction

When a call or interactive live streaming ends, you can gather feedback on the quality of experience to improve your product by asking your users to rate the call or interactive live streaming.

The Agora SDK provides methods for you to collect your users' ratings and comments on the calls.

After the rating function is implemented, you can see your users' ratings in [Agora Analytics](./aa_guide), as shown in the figure below:

![](https://web-cdn.agora.io/docs-files/1545801217929)

## Implementation 

Before proceeding, ensure that you implement a basic video call or live broadcast in your project. See [Start a Call](start_call_unity)/[Start a Live Broadcast](start_live_unity) for details.

To rate a call:

1. When you are in the channel, call the `GetCallId` method to get current call ID. 
2. After leaving the channel, call the `Rate` method to rate the call.

### Sample code

```C#
// Get current call ID. Rate 5 and give description.
String callId = mRtcEngine.GetCallId();
mRtcEngine.Rate(callId, 5, "This is an awesome call!");
```

### API reference

- [`GetCallId`](./API%20Reference/unity/classagora__gaming__rtc_1_1_i_rtc_engine.html#ab6b0ec1b64c5c9ec417819af0c70385a)
- [`Rate`](./API%20Reference/unity/classagora__gaming__rtc_1_1_i_rtc_engine.html#a2de30387e035e21f20f5bf5aebc001f5)