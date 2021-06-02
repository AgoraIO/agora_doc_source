---
title: Adjust the Volume
platform: iOS
updatedAt: 2019-08-13 15:12:31
---
## Introduction

The Agora RTC SDK enables you to manage the volume of the recorded audio or of the audio playback according to your actual scenario. For example, to mute a remote user in a one-to-one call, you can set the audio playback volume as 0.

This article describes the scenarios when you need to adjust the volume, the corresponding APIs and considerations in the process from audio recording to playing. 

![](https://web-cdn.agora.io/docs-files/1548729570704)

## Implementation
Ensure that you prepare the development environment. See [Integrate the SDK](./ios_audio).

### Set the Recording Volume

**Recording** is the process in which audio signals are captured by recorders and transported to signal senders. During this process, you can adjust the volume by changing the volume of recording signals with the Agora SDK.

The value of the volume ranges between 0 and 400. 100 (default) represents the original volume, and 400 is four times the original volume (amplifying the audio signals by four times).

```swift
// swift
// Sets the volume of the recording signal.
agoraKit.adjustRecordingSignalVolume(50)
```

```objective-c
// objective-c
// Sets the volume of the recording signal.
[agoraKit adjustRecordingSignalVolume: 50];
```

#### API Reference

- [`adjustRecordingSignalVolume`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/adjustRecordingSignalVolume:)

### Set the Playback Volume

**Playback** is the process in which audio signal are transported from signal senders to receivers and then to the players. During this process, you can adjust the volume by changing the volume of playback signals with the Agora SDK. 

The value of the volume ranges between 0 and 400. 100 (default) represents the original volume, and 400 is four times the original volume (amplifying the audio signals by four times).

```swift
// swift
// Sets the volume of the playback signal.
agoraKit.adjustRecordingSignalVolume(50)
```

```objective-c
// objective-c
// Sets the volume of the playback signal.
[agoraKit adjustRecordingSignalVolume: 50];
```

#### API Reference

- [`adjustPlaybackSignalVolume`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/adjustPlaybackSignalVolume:)

### Set the Audio Mixing Volume

**Audio mixing** is playing local or online music while speaking, so that other users in the channel can hear the speaker and the music simultaneously. See [Audio Mixing](./effect_mixing_ios_audio?platform=iOS#audio-mixing) for enabling this function.

The value of the audio mixing volume ranges between 0 and 100. 100 (default) represents the original volume, and 0 means the audio mixing is muted.

```swift
// swift
// Sets the audio mixing volume for remote users.
agoraKit.adjustAudioMixingPublishVolume(50)
// Sets the audio mixing volume for local users.
agoraKit.adjustAudioMixingPlayoutVolume(50)
```

```objective-c
// objective-c
// Sets the audio mixing volume for remote users.
[agoraKit adjustAudioMixingPublishVolume: 50];
// Sets the audio mixing volume for local users.
[agoraKit adjustAudioMixingPlayoutVolume: 50];
```

You can also call the API `adjustAudioMixingVolume` to set the volume of audio playing for both remote users and local users.

```swift
// swift
// Sets the audio mixing volume for both local and remote users.
agoraKit.adjustAudioMixingVolume(50)
```

```objective-c
// objective-c
// Sets the audio mixing volume for both local and remote users.
[agoraKit adjustAudioMixingVolume: 50];
```

#### API Reference

- [`adjustAudioMixingPublishVolume`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/adjustAudioMixingPublishVolume:)
- [`adjustAudioMixingPlayoutVolume`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/adjustAudioMixingPlayoutVolume:)
- [`adjustAudioMixingVolume`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/adjustAudioMixingVolume:)

### Set the Audio Effects Volume

**Audio effects** are certain short-time sounds such as clapping and gunshots. See [Audio Effects](./effect_mixing_ios_audio?platform=iOS#play-audio-effect-files) for enabling this function.

The value of the audio effects volume ranges between 0.0 and 100.0. 100 .0 (default) represents the original volume, and 0.0 means the audio effect is muted.

```swift
// swift
// Sets the volume of all audio effect files.
agoraKit.setEffectsVolume(50.0)
// Sets the volume of a single audio effect file.
// soundId is ID of the audio effect when you call playEffect.
agoraKit.setVolumeOfEffect(soundId:"1", 50.0)
```

```objective-c
// objective-c
// Sets the volume of all audio effect files.
[agoraKit setEffectsVolume: 50.0];
// Sets the volume of a single audio effect file.
// soundId is ID of the audio effect when you call playEffect.
[agoraKit setVolumeOfEffect: soundId:@"1" volume:50.0];
```

#### API Reference

- [`setEffectsVolume`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setEffectsVolume:)
- [`setVolumeOfEffect`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setVolumeOfEffect:withVolume:)

### Set the In-ear Monitoring Volume

In audio recording, mixing and playing, you can use `setInEarMonitoringVolume` to adjust the volume of in-ear monitoring.

The value of the in-ear monitoring volume ranges between 0 and 100. 100 (default) represents the original volume, and 0 means the in-ear monitoring is muted.

```swift
// swift
// Enables in-ear monitoring.
agoraKit.enableInearMonitoring(true)
// Sets the in-ear monitoring volume.
agoraKit.setInEarMonitoringVolume(50)
```

```objective-c
// objective-c
// Enables in-ear monitoring.
[agoraKit enableInEarMonitoring(true)];
// Sets the in-ear monitoring volume,
[agoraKit setInEarMonitoringVolume: 50];
```

#### API Reference

- [`enableInEarMonitoring`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/enableInEarMonitoring:)
- [`setInEarMonitoringVolume`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setInEarMonitoringVolume:)

### Get the Data of the Loudest Speaker (Callback Method)

In audio recording, mixing and playing, you can use the following APIs to get the data of the loudest speaker in the channel.

- The speaker with the highest instant volume

```swift
// swift
func rtcEngine(_ engine: AgoraRtcEngineKit, reportAudioVolumeIndicationOfSpeakers speakers:
[AgoraRtcAudioVolumeInfo], totalVolume: Int) {
// Gets the ID of the speakers with the highest instant volume. A user ID of 0 indicates it is the local user.
// speakers is an array that contains uid and volumne of the speaker, volume ranging between 0 and 255.
// totalVolume is the toal volume after audio mixing, ranging between 0 to 255.
}
```

```objective-c
// objective-c
- (void)rtcEngine:(AgoraRtcEngineKit *_Nonnull)engine reportAudioVolumeIndicationOfSpeakers:(NSArray<AgoraRtcAudioVolumeInfo*> *_Nonnull)speakers totalVolume:(NSInteger)totalVolume {
// Gets the ID of the speakers with the highest instant volume.  A user ID of 0 indicates it is the local user.
// speakers is an array that contains uid and volumne of the speaker, volume ranging between 0 and 255.
// totalVolume is the toal volume after audio mixing, ranging between 0 to 255.
}
```

- The speaker with the highest accumulative volume during a certain period

```swift
// swift
func rtcEngine(_ engine: AgoraRtcEngineKit, activeSpeaker speakerUid: UInt) {
// Gets the ID of the speaker with the highest accumulative volume during a certain period. A user ID of 0 indicates it is the local user.
}
```

```objective-c
// objective-c
- (void)rtcEngine:(AgoraRtcEngineKit *_Nonnull)engine activeSpeaker:(NSUInteger)speakerUid {
// Gets the ID of the speaker with the highest accumulative volume during a certain period. A user ID of 0 indicates it is a local user.
}
```

#### API Reference

- [`reportAudioVolumeIndicationOfSpeakers`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:reportAudioVolumeIndicationOfSpeakers:totalVolume:4)
- [`activeSpeaker`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:activeSpeaker:)

## Considerations

- If the volume of the audio signal is set too high, noise may occur on some devices.
- The API methods have return values. If the method call fails, the return value is < 0.