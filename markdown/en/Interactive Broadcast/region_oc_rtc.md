---
title: Network Geofencing
platform: iOS
updatedAt: 2021-03-24 02:30:47
---
## Introduction

To meet the laws and regulations of different countries or regions, the Agora RTC SDK supports geofencing. After enabling geofencing, the Agora SDK only connects to Agora servers within the specified region.

For example, if you specify North America as the region for connection, the SDK only connects to Agora servers in North America. When there is no available server in North American, the SDK throws an error instead of connecting to servers in another region.

<div class="alert note">Do not enable geofencing if your scenarios do not have regional restrictions.</div>

## Implementation

As of v3.0.0.2, the Agora RTC Native SDK supports network geofencing. 

When creating an `AgoraRtcEngineKit` instance by calling [`sharedEngineWithConfig`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/sharedEngineWithConfig:delegate:), set the `areaCode` parameter in `AgoraRtcEngineConfig` to specify the region for connection.

- `AgoraAreaCodeGLOB`: (Default) Global
- `AgoraAreaCodeCN`: Mainland China
- `AgoraAreaCodeNA`: North America
- `AgoraAreaCodeEU`: Europe
- `AgoraAreaCodeAS`: Asia, excluding Mainland China
- `AgoraAreaCodeJP`: Japan
- `AgoraAreaCodeIN`: India

<div class="alert note"><ul><li>The area codes listed above apply to the RTC Native SDK v3.1.1 and later. For area codes earlier than v3.1.1, you can refer to the API reference of a specified version.</li><li>The area codes support bitwise operation.</li></ul></div>

## Sample code

```swift
// Swift
// Specify the region for connection as North America.
let agoraRtcEngineConfig = AgoraRtcEngineConfig();
agoraRtcEngineConfig.appId = type.appId(isClassical: settings.shouldUseClassicalAppIds)
agoraRtcEngineConfig.areaCode = AgoraAreaCode.NA.rawValue
agoraKit = AgoraRtcEngineKit.sharedEngine(with: agoraRtcEngineConfig, delegate: self)
```

```swift
// Swift
// Exclude Mainland China from the regions for connection.
let agoraRtcEngineConfig = AgoraRtcEngineConfig();
agoraRtcEngineConfig.appId = type.appId(isClassical: settings.shouldUseClassicalAppIds)
agoraRtcEngineConfig.areaCode = AgoraAreaCode.GLOB.rawValue ^ AgoraAreaCode.CN.rawValue
agoraKit = AgoraRtcEngineKit.sharedEngine(with: agoraRtcEngineConfig, delegate: self)
```

## Considerations

If a firewall is deployed in your network environment, ensure that you whitelist all domains and ports listed in [Use Cloud Proxy](cloudproxy_native).