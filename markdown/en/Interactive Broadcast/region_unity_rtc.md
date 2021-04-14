---
title: Network Geofencing
platform: Unity
updatedAt: 2021-03-24 02:33:40
---
## Introduction

To meet the laws and regulations of different countries or regions, the Agora RTC SDK supports geofencing. After enabling geofencing, the Agora SDK only connects to Agora servers within the specified region.

For example, if you specify North America as the region for connection, the SDK only connects to Agora servers in North America. When there is no available server in North American, the SDK throws an error instead of connecting to servers in another region.

<div class="alert note">Do not enable geofencing if your scenarios do not have regional restrictions.</div>

## Implementation

As of v3.0.1, the Agora RTC Unity SDK supports network geofencing.

When initializing the SDK by calling [`GetEngine`](./API%20Reference/unity/classagora__gaming__rtc_1_1_i_rtc_engine.html#ac1a02000088c915aa36065325f42d166) , set the `areaCode` parameter in `RtcEngineConfig` to specify the region for connection.

- `AREA_CODE_GLOB`: (Default) Global
- `AREA_CODE_CN`: Mainland China
- `AREA_CODE_NA`: North America
- `AREA_CODE_EU`: Europe
- `AREA_CODE_AS`: Asia, excluding Mainland China
- `AREA_CODE_JP`: Japan
- `AREA_CODE_IN`: India

<div class="alert note"><ul><li>The area codes listed above apply to the RTC Unity SDK v3.2.1 and later. For area codes earlier than v3.2.1, you can refer to the API reference of a specified version.</li><li>The area codes support bitwise operation.</li></ul></div>

## Sample code

```C#
// Initialize IRtcEngine and specify the region as North America.
RtcEngineConfig mRtcEngineConfig = new RtcEngineConfig(appId, AREA_CODE.AREA_CODE_NA);
mRtcEngine = IRtcEngine.GetEngine(mRtcEngineConfig);
}
```

## Considerations

If a firewall is deployed in your network environment, ensure that you whitelist all domains and ports listed in [Use Cloud Proxy](cloudproxy_native).