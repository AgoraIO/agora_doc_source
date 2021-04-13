---
title: Why do I see a prompt to find local network devices when launching an iOS app integrated with the Agora RTC SDK?
platform: ["iOS"]
updatedAt: 2020-12-18 03:21:53
Products: ["Voice","Video","Interactive Broadcast","Audio Broadcast"]
---
## Problem

After users upgrade their iOS devices to iOS 14.0, and use an app that integrates the Agora RTC SDK for iOS for the first time, users see a prompt for finding local network devices. The following picture shows the pop-up prompt:

![](https://web-cdn.agora.io/docs-files/1599797972248)

## Reason

iOS 14.0 adds a privacy setting relating to local network usage, and your app needs to obtain the **Privacy - Local Network Usage Description** permission from the user to access the user's local network device.

Agora RTC SDK for iOS with the version earlier than v3.1.2 detects the connection quality between the client and the user's local router, and reports the round-trip delay between the client and the user's local router by using the [`gatewayRtt`](./API%20Reference/oc/Classes/AgoraChannelStats.html#//api/name/gatewayRtt) parameter of the [`reportRtcStats`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:reportRtcStats:) callback. The iOS system determines the connectivity detection as a search for local network devices. Thus, although the app does not connect to any devices on the user's local network, the user sees a prompt to find local network devices when launching an iOS app for the first time.

## Solution

### Solution one: Use the SDK version v3.1.2 and above

As of v3.1.2, Agora RTC SDK for iOS disables the local network connection quality report. If your business does not rely on this function, Agora recommends this solution.

Integrate the SDK v3.1.2 and above, and users will not see the prompt to find local network devices. As of v3.1.2, the `gatewayRtt` parameter in the `reportRtcStats` callback is invalid (always reports `-1`). Do not use `gatewayRtt` to obtain the round-trip delay between the client and the user's local router. 

### Solution two: Modify the privacy description in your project

If you need to obtain the round-trip delay between the client and the user's local router, Agora recommends using the SDK with the version earlier than v3.1.2 and modifying the privacy description in your project.

The default prompt shows as follows: **This app will be able to discover and connect to devices on the networks you use**. Agora recommends modifying the privacy description according to your business requirements. The steps to modify the privacy description are as follows:

1. Open your Xcode project, find the `info.plist` file, and click **+** to add **Privacy - Local Network Usage Description**.

 <div class="alert info">In Xcode 11, you need to add <b>NSLocalNetworkUsageDescription</b>.</div>
 
2. According to your business requirements, add the purpose of obtaining local network device permissions in the **Value** column of **Privacy - Local Network Usage Description**. For example, add **This app will not connect to devices on your network, it only detects the connectivity with your local gateway**.
   ![](https://web-cdn.agora.io/docs-files/1599798113793)

After modification, users will see the following prompt when launching an iOS app for the first time:

![](https://web-cdn.agora.io/docs-files/1599798127052)

- If users tap **OK**, the app can obtain the round-trip delay between the client and the user's local router by using the `gatewayRtt` parameter of the `reportRtcStats` callback.
- If users tap **Don't Allow**, the `gatewayRtt` parameter in the `reportRtcStats` callback is invalid (always reports `-1`). The app cannot use `gatewayRtt` to obtain the round-trip delay between the client and the user's local router.

Users can also set the app permission in the **Settings -> Privacy -> Local network** interface on iOS devices.

## References

- [Privacy - Local Network Usage Description](https://developer.apple.com/documentation/bundleresources/information_property_list/nslocalnetworkusagedescription)
- [Support local network privacy in your app](https://developer.apple.com/videos/play/wwdc2020/10110/)