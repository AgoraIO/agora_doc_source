## Introduction

To meet the laws and regulations of different countries or regions, the Agora RTC SDK supports geofencing. After enabling geofencing, the Agora SDK only connects to Agora servers within the specified region.

For example, if you specify North America as the region for connection, the SDK only connects to Agora servers in North America. When there is no available server in North American, the SDK throws an error instead of connecting to servers in another region.

<div class="alert note">Do not enable geofencing if your scenarios do not have regional restrictions.</div>

## Implementation

When initializing an `IAgoraService` instance by calling `initialize`, call `AgoraServiceConfig.setAreaCode()` to specify the region for connection.

- `0xFFFFFFFF`: (Default) Global
- `0x00000001`: Mainland China
- `0x00000002`: North America
- `0x00000004`: Europe
- `0x00000008`: Asia, excluding Mainland China
- `0x00000010`: Japan
- `0x00000020`: India

<div class="alert note">The area codes support bitwise operation.</div>

## Sample code

The following sample code shows how to specify North America as the region for connection.

```java
SDK.load(); // ensure JNI library load
// Creates an AgoraService object
AgoraService service = new AgoraService();
if (null == service) {
    System.out.printf("createAndInitAgoraService fail\n");
    return;
}
AgoraServiceConfig config = new AgoraServiceConfig();
// Disables the audio device module (Normally we do not directly connect audio capture or playback devices to a server)
config.setEnableAudioDevice(0);
// Enables the audio processing module
config.setEnableAudioProcessor(1);
// Whether to enable video
config.setEnableVideo(0);
// Specify North America as the region for connection
config.setAreaCode(0x00000002);
int ret = service.initialize(config);
```