---
title: Enable Interoperability 
platform: macOS
updatedAt: 2020-07-13 18:06:11
---
## Introduction

To **enable interoperability** means enabling real-time audio and video call services by integrating SDKs of different platforms in the app. Users of the app can then join the same channel and interoperate with others using a mobile device (iOS or Android), a desktop device (Windows or macOS), or a web browser or web app.

## Implementation

Ensure that you prepared the development environment. See [Integrate the SDK](./mac_video).

To enable interoperability between a mobile device and a web browser or app, you need to adjust the settings on both platforms. 

>Use this function only when the channel is in the live broadcast profile. Interoperability is enabled by default in the communication profile.

* On the mobile device, call the `enableWebSdkInteroperability` method.

```swift
// swift
// Ensure that this method is called from the native side to interoperate with the Web SDK.
agoraKit.enableWebSdkInteroperability(true)
```

```objective-c
// objective-c
// Ensure that this method is called from the native side to interoperate with the Web SDK.
[agoraKit enableWebSdkInteroperability: YES];
```

*  For the Web, in the `createClient` method, set the `mode` argument as `'live'`.

```javascript
// javascript
// Choose the current mode and codec.
var client = AgoraRTC.createClient({ mode: 'live', codec: 'h264' });
```

## Considerations

* The settings must be adjusted on both the mobile device and the web browser/app to enable interoperability.