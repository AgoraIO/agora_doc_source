---
title: Set the Audio Profile
platform: Web
updatedAt: 2020-12-30 09:08:46
---
<div class="alert note">This article only applies to the Agora Web SDK 4.x. If you use the Web SDK 3.x or earlier versions, see <a href="./audio_profile_web?platform=Web">Set the Audio Profile</a>.</li></div>

## Introduction

High-fidelity audio is essential for professional audio scenarios such as podcasts and singing competitions. Podcasts, for example, require stereo and high-fidelity audio. High-fidelity audio refers to an audio profile with a sample rate of 48 kHz and a bitrate of 192 Kbps.

## Implementation

Before proceeding, ensure that you have read the quickstart guides and implemented basic real-time audio and video functions in your project.

The Agora Web SDK provides the following methods to create audio tracks:
- `createMicrophoneAudioTrack`
- `createBufferSourceAudioTrack`
- `createCustomAudioTrack`

To adjust the audio profile, set the `encoderConfig` property in these methods.

You can set `encoderConfig` in either of the following ways:

- Pass the preset audio encoder configurations.
- Pass your customized audio encoder configurations.

### Sample code

**Use preset audio encoder configurations**

```javascript
AgoraRTC.createMicrophoneAudioTrack({
  encoderConfig: "high_quality_stereo",
}).then(/**...**/);
```

**Customize audio encoder configurations**

```javascript
AgoraRTC.createMicrophoneAudioTrack({
  encoderConfig: {
    sampleRate: 48000,
    stereo: true,
    bitrate: 128,
  },
}).then(/**...**/);
```

### API reference

- [`createMicrophoneAudioTrack`](./API%20Reference/web/v4.2.0/interfaces/iagorartc.html#createmicrophoneaudiotrack)
- [`createBufferSourceAudioTrack`](./API%20Reference/web/v4.2.0/interfaces/iagorartc.html#createbuffersourceaudiotrack)
- [`createCustomAudioTrack`](./API%20Reference/web/v4.2.0/interfaces/iagorartc.html#createcustomaudiotrack)

## Considerations

Set the audio profile before calling `AgoraRTCClient.publish`. After publishing an audio track, you can no longer modify its audio profile.