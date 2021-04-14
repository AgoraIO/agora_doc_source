---
title: Adjust the Volume
platform: Android
updatedAt: 2020-12-03 12:01:44
---
## Introduction

The Agora RTC SDK enables you to manage the volume of the recorded audio or of the audio playback according to your actual scenario. For example, to mute a remote user in a one-to-one call, you can set the audio playback volume as 0.

## Implementation
Ensure that you prepare the development environment. See [Integrate the SDK](./android_audio).

The Agora SDK provides methods to adjust the volume of the audio signals, which enables adjusting the recording and playback volumes.
The value of the volume ranges between 0 and 400. 100 (default) represents the original volume, and 400 is four times the original volume (amplifying the audio signals by four times).

```java
int volume = 200;
// Sets the volume of the recording signal.
rtcEngine.adjustRecordingSignalVolume(volume);
// Sets the volume of the playback signal.
rtcEngine.adjustPlaybackSignalVolume(volume);
```

### API Methods

- [`adjustRecordingSignalVolume`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#af3747f72256eb683feadbca2b742bd05)
- [`adjustPlaybackSignalVolume`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#af7d7f10fc96db2febb9c2590891d071b)

## Considerations

- If the volume of the audio signal is set too high, noise may occur on some devices.
- The API methods have return values. If the method call fails, the return value is < 0.
