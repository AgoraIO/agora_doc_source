---
title: Create and Initialize an AgoraRtcEngine Instance
platform: macOS
updatedAt: 2018-12-14 00:21:40
---
Before creating an AgoraRtcEngine instance, ensure that you have finished preparing the development environment. See [Integrate the SDK](/en/Interactive%20Broadcast/mac_video) for more information.

## Implementation
Create an AgoraRtcEngine instance by invoking `sharedEngineWithAppId` before joining a live broadcast channel.

In this method:

- Pass the Agora App ID. Only apps with the same App ID can join the same channel.
- Specify a delegate object. The Agora SDK uses the delegate object to inform the app of Agora engine runtime events, such as joining or leaving a channel and adding new users into the channel.

```objective-c
//Objective-C
#import <AgoraRtcEngineKit/AgoraRtcEngineKit.h>

...

- (void)initializeAgoraEngine {
  self.agoraKit = [AgoraRtcEngineKit sharedEngineWithAppId:@"Your App ID" delegate:self];
}
```

```swift
//Swift
import AgoraRtcEngineKit

...

func initializeAgoraEngine() {
   agoraKit = AgoraRtcEngineKit.sharedEngine(withAppId: "Your App ID", delegate: self)
}
```

> Ensure that you call the `sharedEngineWithAppId` method to intiialize the AgoraRtcEngine before calling any other API. 

## Next Steps
You have now finished creating the AgoraRtcEngine instance and can start a video call with the following steps:
* [Join a Channel](/cn/Interactive%20Broadcast/join_live_mac)
* [Switch the Client Role](/en/Interactive%20Broadcast/role_mac)
* [Publish and Subscribe to Streams](/cn/Interactive%20Broadcast/publish_mac_live)

For added requirements on network connection or audio quality, you can also take the following steps before joining a channel:

* [Conduct a Last mile Test](/en/Interactive%20Broadcast/lastmile_ios?platform=macOS)
* [Set the Stereo/High-fidelity Audio Profile](/en/Interactive%20Broadcast/audio_profile_mac)