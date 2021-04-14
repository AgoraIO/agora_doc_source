---
title: Adjust the Volume
platform: Web
updatedAt: 2020-12-30 09:08:45
---
<div class="alert note">This article only applies to the Agora Web SDK 4.x. If you use the Web SDK 3.x or earlier versions, see <a href="./volume_web?platform=Web">Adjust the Volume</a>.</li></div>

## Introduction

The Agora Web SDK allows you to manage the sampling volume of the local audio or the playback volume of the subscribed audio as required by the actual scenario.

## Implementation

Before proceeding, ensure that you have read the quickstart guides and implemented basic real-time audio and video functions in your project.

The SDK provides the `setVolume` method for the local audio track and the remote audio track objects, to adjust the sampling volume of the local audio track and the playback volume of the remote audio tracks respectively.

### Sample code

**Adjust the playback volume**

In the following example, the `remoteUser` object represents a subscribed remote user.

```javascript
// Set the volume to half of the original volume
remoteUser.audioTrack.setVolume(50);
// Set the volume to twice of the original volume
remoteUser.audioTrack.setVolume(200);
// Set the volume to 0
remoteUser.audioTrack.setVolume(0);
```

**Adjust the sampling volume**

In the following example, the `localAudioTrack` object represents the local audio track.

```javascript
AgoraRTC.createMicrophoneAudioTrack().then(localAudioTrack => {
  // Set the volume to half of the original volume
  localAudioTrack.setVolume(50);
  // Set the volume to twice of the original volume
  localAudioTrack.setVolume(200);
  // Set the volume to 0
  localAudioTrack.setVolume(0);
});
```

### API reference
- [`LocalAudioTrack.setVolume`](./API%20Reference/web/v4.2.1/interfaces/ilocalaudiotrack.html#setvolume)
- [`RemoteAudioTrack.setVolume`](./API%20Reference/web/v4.2.1/interfaces/iremoteaudiotrack.html#setvolume)

## Considerations

On some devices, setting the audio level too high may cause audio distortion.