---
title: Record the Audio on the Client
platform: iOS
updatedAt: 2020-11-16 04:27:47
---
## Introduction

You can record the audio of all the users in a call and save it on the client for future replays. 

The Agora Native SDK supports recording the audio of all the users in a channel and saves the recording into one file in the following formats: 

- WAV: Large file (lossless compression)
- AAC: Small file (lossy compression)

## Implementation

Before proceeding, ensure that you implement a basic call or live broadcast in your project. See the Quickstart Guides for details:

- iOS: [Start a Call](start_call_ios)/[Start a Live Broadcast](start_live_ios)
- macOS: [Start a Call](start_call_mac)/[Start a Live Broadcast](start_live_mac)

To start audio recording, call the `startAudioRecording` method after joining a channel.

```swift
// Swift
// Start audio recording.
// Local path of the recording file specified by the user, including the filename and format.
// Audio quality of the recording: LOW, MEDIUM, and HIGH.
agoraKit.startAudioRecording("recording file path", quality: .high)

// Stop audio recording.
agoraKit.stopAudioRecording()
```

```objective-c
// Objective-C
// Start audio recording.
// Local path to the recording file specified by the user, including the filename and format.
// Audio quality of the recording: LOW, MEDIUM, and HIGH.
[agoraKit startAudioRecording:@"recording file path", quality: AgoraAudioRecordingQualityHigh];

// Stop audio recording.
[agoraKit stopAudioRecording];
```

### API reference

- [`startAudioRecording`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/startAudioRecording:quality:)
- [`stopAudioRecording`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/stopAudioRecording)

## Considerations

- Start the recording after joining a channel.
- The recording automatically stops if the local user leaves the channel. 