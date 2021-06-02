---
title: Network Geofencing
platform: iOS
updatedAt: 2021-03-24 02:32:00
---
## Introduction

To meet the laws and regulations of different countries or regions, the Agora RTC SDK supports geofencing. After enabling geofencing, the Agora SDK only connects to Agora servers within the specified region.

For example, if you specify North America as the region for connection, the SDK only connects to Agora servers in North America. When there is no available server in North American, the SDK throws an error instead of connecting to servers in another region.

<div class="alert note">Do not enable geofencing if your scenarios do not have regional restrictions.</div>

## Implementation

As of v3.0.0.2, the Agora RTC Native SDK supports network geofencing. 

When initializing the SDK by calling [`initialize`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#ac71db65e66942e4e0a0550e95c16890f), set the `areaCode` parameter in `RtcEngineContext` to specify the region for connection.

For v3.0.0.2, v3.0.1, and v3.0.1.1, the area codes are as follows:

- `AREA_CODE_GLOBAL`: (Default) Global
- `AREA_CODE_CN`: Mainland China
- `AREA_CODE_NA`: North America
- `AREA_CODE_EUR`: Europe
- `AREA_CODE_AS`: Asia, excluding Mainland China

v3.1.0 added the following area codes:

- `AREA_CODE_JAPAN`: Japan
- `AREA_CODE_INDIA`: India

For v3.1.1 and later, the area codes are as follows:

- `AREA_CODE_GLOB`: (Default) Global
- `AREA_CODE_CN`: Mainland China
- `AREA_CODE_NA`: North America
- `AREA_CODE_EU`: Europe
- `AREA_CODE_AS`: Asia, excluding Mainland China
- `AREA_CODE_JP`: Japan
- `AREA_CODE_IN`: India

<div clas="alert note">Agora supports specifying only one area for connection.</div>

## Sample code

```swift
IRtcEngine  *m_lpAgoraEngine = NULL;
RtcEngineContext ctx;
 
if(m_lpAgoraEngine == NULL)
    m_lpAgoraEngine = createAgoraRtcEngine();
ctx.eventHandler = &m_EngineEventHandler;
ctx.appId = appId;
if (hWnd != NULL)
    ctx.context = hWnd;
// Specify the region as North America.
ctx.areaCode = rtc::AREA_CODE_NA;
m_lpAgoraEngine->initialize(ctx);
```

## Considerations

If a firewall is deployed in your network environment, ensure that you whitelist all domains and ports listed in [Use Cloud Proxy](cloudproxy_native).