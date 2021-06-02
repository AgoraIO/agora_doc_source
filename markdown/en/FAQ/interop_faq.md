---
title: How do I use the Agora Web SDK to interoperate with the Agora Native SDK?
platform: ["Android","iOS","macOS","Web","Windows"]
updatedAt: 2020-07-13 17:57:05
Products: ["Voice","Video","Interactive Broadcast"]
---
As of v3.0.0, the interoperability between the RTC Native SDK and the RTC Web SDK is enabled by default for both the `COMMUNICATION` and the `LIVE_BROADCASTING` profile.

For RTC native SDKs prior to v3.0.0, the interoperability with the Web SDK is enabled by default in the `COMMUNICATION` profile. In the `LIVE_BROADCASTING` profile, however, to enable interoperability between a mobile device and a web browser or app, you need to make the following settings on both platforms. 

* On the mobile/desktop device, call the `enableWebSdkInteroperability` method.

	```java
	// java
	// Ensure that this methid is called from the native side to interoperate with Web SDK.
	rtcEngine.enableWebSdkInteroperability(true);
	```

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

	```cpp
	// cpp
	//  Ensure that this method is called from the native side to interoperate with the Web SDK.
	lpAgoraEngine->enableWebSdkInteroperability
	```

* For the Web, in the `createClient` method, set the `mode` argument as `'live'`.

	```javascript
	// javascript
	// Choose the current mode and codec.
	var client = AgoraRTC.createClient({ mode: 'live', codec: 'h264' });
	```

<div class="alert note">Given known test experience, if your scenario involves Safari, we recommend setting <code>codec</code> at the Web Client as <code>h264</code>; otherwise, set it as <code>vp8</code>.</div>




