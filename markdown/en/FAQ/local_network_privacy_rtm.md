---
title: Why do I see a prompt to find local network devices when launching an iOS app integrated with the Agora RTM SDK?
platform: ["iOS"]
updatedAt: 2020-12-18 03:23:25
Products: ["Real-time-Messaging"]
---
## Problem

After users upgrade their iOS devices to iOS 14.0 and use an app that integrates the Agora RTM SDK for iOS, users see a prompt for finding local network devices. The following picture shows the pop-up prompt:

![](https://web-cdn.agora.io/docs-files/1599797972248)

## Reason

iOS 14.0 adds a privacy setting relating to local network usage, and your app needs to obtain the **Privacy - Local Network Usage Description** permission from the user to access the user's local network device. The RTM SDK accesses the Agora server via domain name. If the DNS server is in the same network segment as the device, the pop-up prompt may be triggered.

## Solution


### Solution one: Use the SDK version v1.4.1 and above

Integrate the RTM SDK v1.4.1 and above, and users will not see the prompt to find local network devices. The availability of the RTM service will not be affected.

### Solution two: Modify the privacy description in your project

The default prompt shows as follows: **This app will be able to discover and connect to devices on the networks you use**. Agora recommends modifying the privacy description according to your business requirements. The steps to modify the privacy description are as follows:

1. Open your Xcode project, find the `info.plist` file, and click **+** to add **Privacy - Local Network Usage Description**.

 <div class="alert info">In Xcode 11, you need to add <b>NSLocalNetworkUsageDescription</b>.</div>
 
2. According to your business requirements, add the purpose of obtaining local network device permissions in the **Value** column of **Privacy-Local Network Usage Description**. For example, add **This app will not connect to devices on your network, it only detects the connectivity with your local gateway**.
   ![](https://web-cdn.agora.io/docs-files/1599798113793)

After modification, users will see the following prompt when launching an iOS app:

![](https://web-cdn.agora.io/docs-files/1599798127052)

- If users tap **OK**, the app can connect to more edge servers with the DNS parsing function of the router.
- If users tap **Don't Allow**, the app cannot connect to extra edge servers, which may slightly affect the availability of the RTM service.



## References

- [Privacy - Local Network Usage Description](https://developer.apple.com/documentation/bundleresources/information_property_list/nslocalnetworkusagedescription)
- [Support local network privacy in your app](https://developer.apple.com/videos/play/wwdc2020/10110/)