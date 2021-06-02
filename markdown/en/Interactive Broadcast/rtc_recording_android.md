---
title: Record the Audio on the Client
platform: Android
updatedAt: 2019-09-29 16:24:47
---
## Introduction

You can record the audio of all the users in a call and save it on the client for future replays. 

The Agora Native SDK supports recording the audio of all the users in a channel and saves the recording into one file in the following formats: 

- WAV: Large file (lossless compression)
- AAC: Small file (lossy compression)

## Implementation

Before proceeding, ensure that you have implemented basic real-time functions in your project. See [Start a  Call](start_call_android) or [Start Live Interactive Streaming](start_live_android) for details.

To start audio recording, call the `startAudioRecording` method after joining a channel.

```java
// Start audio recording.
rtcEngine.startAudioRecording(
  // Local path of the recording file specified by the user, including the filename and format.
	"path/to/file",
	// Audio quality of the recording: LOW, MEDIUM, and HIGH.
	AUDIO_RECORDING_QUALITY_HIGH 
);

// Stop audio recording.
rtcEngine.stopAudioRecording();
```

### API reference

- [`startAudioRecording`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a44744695d723b7d18c704a57f828cddb)
- [`stopAudioRecording`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a2d751055a21611b3cf99fe39d24bb1a0)

## Considerations

- Start the recording after joining a channel.
- The recording automatically stops if the local user leaves the channel. 