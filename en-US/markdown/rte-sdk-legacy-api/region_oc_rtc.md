# Geofencing

To meet the laws and regulations of different countries or regions, the Agora RTC SDK supports geofencing. After enabling geofencing, the Agora SDK only connects to Agora servers within the specified region.

## Understand the tech

For example, if you specify North America as the region for connection, the SDK only connects to Agora servers in North America. When there is no available server in North American, the SDK throws an error instead of connecting to servers in another region.

<div class="alert note">Do not enable geofencing if your scenarios do not have regional restrictions.</div>

## Prerequisites

Before adjusting the audio volume, ensure that you have implemented the basic real-time communication functions in your project. For details, see [Start a Call](start_call_ios) or [Start Interactive Live Streaming](start_live_ios).

## Implementation

When creating an `AgoraRtcEngineKit` instance by calling [`sharedEngineWithConfig`](https://docs-preview.agoralab.co/en/trinity/API%20Reference/oc_high_level/interface_agora_rtc_engine_kit.html#a7b846b533c9144396668b7ce9d90cb8b), set the `areaCode` parameter in `AgoraRtcEngineConfig` to specify the region for connection.

- `AgoraAreaCodeGLOB`: (Default) Global
- `AgoraAreaCodeCN`: Mainland China
- `AgoraAreaCodeNA`: North America
- `AgoraAreaCodeEU`: Europe
- `AgoraAreaCodeAS`: Asia, excluding Mainland China
- `AgoraAreaCodeJP`: Japan
- `AgoraAreaCodeIN`: India

<div class="alert note">The area codes support bitwise operation. </div>


### Specify a region

To specify the region for connection as North America, add `config.areaCode = AgoraAreaCode.NA.rawValue` before creating an instance of `AgoraRtcEngineKit`.

```swift
// Swift
// Initializes AgoraEngine
func initializeAgoraEngine(){
     let config = AgoraRtcEngineConfig()
     // Pass in your App ID here.
     config.appId = "YourAppId"
     //Sets the channel profile as live broadcast.
     config.channelProfile = .liveBroadcasting
     // Specifies North America as the region for connection
     config.areaCode = AgoraAreaCode.NA.rawValue
     agoraKit = AgoraRtcEngineKit.sharedEngine(with: config, delegate: self)
  }
```

### Exclude a region

To exclude Mainland China from the region for connection, add `config.areaCode = AgoraAreaCode.GLOB.rawValue ^ AgoraAreaCode.CN.rawValue` before creating an instance of `AgoraRtcEngineKit`.

```swift
// Swift
// Initializes AgoraEngine
func initializeAgoraEngine(){
     let config = AgoraRtcEngineConfig()
     // Pass in your App ID here.
     config.appId = "YourAppId"
     // Sets the channel profile as live broadcast.
     config.channelProfile = .liveBroadcasting
     // Excludes Mainland China from the regions for connection.
     config.areaCode = AgoraAreaCode.GLOB.rawValue ^ AgoraAreaCode.CN.rawValue
     agoraKit = AgoraRtcEngineKit.sharedEngine(with: config, delegate: self)
  }
```
