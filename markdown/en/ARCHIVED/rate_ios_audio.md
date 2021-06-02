---
title: Rate the Call
platform: iOS
updatedAt: 2018-12-27 15:34:42
---
## Introduction

When a call or live broadcast ends, you can get feedback on the quality of experience to improve your product by asking your users to rate the call or live broadcast.

The Agora SDK provides methods for you to collect your users' ratings and comments on the calls.

After the rating function is implemented, you can see your users' ratings in [Agora Analytics](./aa_guide), as shown in the figure below:

![](https://web-cdn.agora.io/docs-files/1545801217929)

## Implementation
Ensure that you prepared the development environment. See [Integrate the SDK](./ios_audio).

```swift
// swift
agoraKit.rate(agoraKit.getCallId(), 5, "This is an awesome call!");
```

```objective-c
// objective-c
NSString* callId = [agoraKit getCallId];
[agoraKit rate:callId rating:5 description:@"This is an awesome call!"]; 
```


### API Reference

- [`rate`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/rate:rating:description:)
- [`getCallId`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/getCallId)

## Considerations

The API methods have return values. If the method fails, the return value is < 0.