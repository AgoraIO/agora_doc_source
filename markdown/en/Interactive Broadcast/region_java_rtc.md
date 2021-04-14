---
title: Network Geofencing
platform: Android
updatedAt: 2021-03-24 02:28:20
---
## Introduction

To meet the laws and regulations of different countries or regions, the Agora RTC SDK supports geofencing. After enabling geofencing, the Agora SDK only connects to Agora servers within the specified region.

For example, if you specify North America as the region for connection, the SDK only connects to Agora servers in North America. When there is no available server in North American, the SDK throws an error instead of connecting to servers in another region.

<div class="alert note">Do not enable geofencing if your scenarios do not have regional restrictions.</div>

## Implementation

As of v3.0.0.2, the Agora RTC Native SDK supports network geofencing. 

When creating an RtcEngine instance by calling [`create`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a45832a91b1051bc7641ccd8958288dba), set the `mAreaCode` parameter in `RtcEngineConfig` to specify the region for connection.

- `AREA_CODE_GLOB`: (Default) Global
- `AREA_CODE_CN`: Mainland China
- `AREA_CODE_NA`: North America
- `AREA_CODE_EU`: Europe
- `AREA_CODE_AS`: Asia, excluding Mainland China
- `AREA_CODE_JP`: Japan
- `AREA_CODE_IN`: India

<div class="alert note"><ul><li>Agora supports specifying only one area for connection.</li><li>The area codes listed above apply to the RTC Native SDK v3.1.1 and later. For area codes earlier than v3.1.1, you can refer to the API reference of a specified version.</li></ul></div>

## Sample code

```java
// Initialize the RtcEngine instance.
private void initializeEngine() {
    try {
        // Specify the region as North America.
        int areaCode = AREA_CODE_NA;
        RtcEngineConfig config = new RtcEngineConfig();
        config.mAppId = appId;
        config.mContext = mContext;
        config.mEventHandler = mEngineEventHandler.mRtcEventHandler;
        config.mAreaCode = areaCode;
        mRtcEngine = RtcEngine.create(config);
    } catch (Exception e) {
        Log.e(TAG, Log.getStackTraceString(e));
        throw new RuntimeException("NEED TO check rtc sdk init fatal error\n" + Log.getStackTraceString(e));
    }
...
}
```

## Considerations

If a firewall is deployed in your network environment, ensure that you whitelist all domains and ports listed in [Use Cloud Proxy](cloudproxy_native).