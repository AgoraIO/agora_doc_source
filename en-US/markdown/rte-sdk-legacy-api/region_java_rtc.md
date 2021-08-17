## Understand the tech

To meet the laws and regulations of different countries or regions, the Agora RTC SDK supports geofencing. After enabling geofencing, the Agora SDK only connects to Agora servers within the specified region.

For example, if you specify North America as the region for connection, the SDK only connects to Agora servers in North America. When there is no available server in North American, the SDK throws an error instead of connecting to servers in another region.

<div class="alert note">Do not enable geofencing if your scenarios do not have regional restrictions.</div>

## Implementation

When creating an RtcEngine instance by calling [`create`](https://docs-preview.agoralab.co/en/trinity/API%20Reference/java_high_level/classio_1_1agora_1_1rtc2_1_1_rtc_engine.html#afffd4c0d9b799631ed407c5167b6e09a), set the `mAreaCode` parameter in `RtcEngineConfig` to specify the region for connection.

- `AREA_CODE_GLOB`: (Default) Global
- `AREA_CODE_CN`: Mainland China
- `AREA_CODE_NA`: North America
- `AREA_CODE_EU`: Europe
- `AREA_CODE_AS`: Asia, excluding Mainland China
- `AREA_CODE_JP`: Japan
- `AREA_CODE_IN`: India

<div class="alert note">The area codes support bitwise operation.</div>

### Specify a region

```java
// Specify the region for connection as North America.
private void initializeEngine() {
    try {
        RtcEngineConfig config = new RtcEngineConfig();
        config.mAppId = appId;
        config.mContext = mContext;
        config.mEventHandler = mEngineEventHandler.mRtcEventHandler;
        config.mAreaCode = AREA_CODE_NA;
        mRtcEngine = RtcEngine.create(config);
    } catch (Exception e) {
        Log.e(TAG, Log.getStackTraceString(e));
        throw new RuntimeException("NEED TO check rtc sdk init fatal error\n" + Log.getStackTraceString(e));
    }
...
}
```

### Exclude a region

```java
// Exclude Mainland China from the regions for connection.
private void initializeEngine() {
    try {
        RtcEngineConfig config = new RtcEngineConfig();
        config.mAppId = appId;
        config.mContext = mContext;
        config.mEventHandler = mEngineEventHandler.mRtcEventHandler;
        config.mAreaCode = AREA_CODE_GLOB ^ AREA_CODE_CN;
        mRtcEngine = RtcEngine.create(config);
    } catch (Exception e) {
        Log.e(TAG, Log.getStackTraceString(e));
        throw new RuntimeException("NEED TO check rtc sdk init fatal error\n" + Log.getStackTraceString(e));
    }
...
}
```
