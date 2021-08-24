# Adjust the Volume

This article shows you how to set audio recording, audio mixing, audio playback and in-ear monitoring volume.

## Understand the tech

The Agora RTC SDK enables you to manage the volume of the recorded audio or of the audio playback according to your actual scenario. For example, you can set the audio playback volume as 0 to mute a remote user in a one-to-one call.

The following diagram shows the workflow for audio volume settings.

![](https://web-cdn.agora.io/docs-files/1578885967798)

### Playback

**Playback** is the process of playing the received audio signal on the local playback device.

![](https://web-cdn.agora.io/docs-files/1578887639765)

### In-ear monitoring

**In-ear monitoring** is the process of playing the audio from the recording device.

![](https://web-cdn.agora.io/docs-files/1578887697061)

### Recording


**Recording** is the process of sampling audio by a recording device and transmitting the recorded signal to the sender.

![](https://web-cdn.agora.io/docs-files/1578559122611)

## Prerequisites

Before adjusting the audio volume, ensure that you have implemented the basic real-time communication functions in your project. For details, see [Start a Call](start_call_ios) or [Start Interactive Live Streaming](start_live_ios).

## Implementation
### Adjust the playback volume

To set the volume of the audio signal, call `adjustPlaybackSignalVolume` or `adjustUserPlaybackSignalVolume`.


```swift
// Swift
// Sets the volume of the local playback of all remote users as 50.
agoraKit.adjustPlaybackSignalVolume(50)
// Sets the volume of the local playback of a specified remote user as 50.
agoraKit.adjustUserPlaybackSignalVolume(uid, volume: 50)
```

```objective-c
// Objective-C
// Sets the volume of the local playback of all remote users as 50.
[agoraKit adjustPlaybackSignalVolume: 50];
// Sets the volume of the local playback of a specified remote user as 50.
[agoraKit adjustUserPlaybackSignalVolume: uid, volume: 50];
```

### Adjust the in-ear monitor volume

In audio recording, mixing, and playback, to adjust the volume of the in-ear monitor, call `setInEarMonitoringVolume` .

<div class="alert note">Call enableInEarMonitoring(true) before calling this method.</div>


```swift
// Swift
// Enables in-ear monitoring.
agoraKit.enableInearMonitoring(true)
// Sets the in-ear monitor volume as 50.
agoraKit.setInEarMonitoringVolume(50)
```

```objective-c
// Objective-C
// Enables in-ear monitoring.
[agoraKit enableInEarMonitoring(true)];
// Sets the in-ear monitor volume as 50.
[agoraKit setInEarMonitoringVolume: 50];
```

### Balance the volume by getting the information of the loudest speaker (callback)

When recording, mixing, or playing audio, you can use the following methods to get the data of the loudest speaker in the channel.

-  Reports users with the highest peak volumes. The `reportAudioVolumeIndicationOfSpeakers` callback reports the user IDs the corresponding volumes of the currently loudest speakers in the channel.

  <div class="alert note">You must call enableAudioVolumeIndication to be able to receive this callback.</div>


```swift
// Swift
// Gets the the user IDs of the users with the highest peak volume, the corresponding volumes, as well as whether the local user is speaking.
func rtcEngine(_ engine: AgoraRtcEngineKit, reportAudioVolumeIndicationOfSpeakers speakers:
[AgoraRtcAudioVolumeInfo], totalVolume: Int) {
}
```

```objective-c
// Objective-C
// Gets the the user IDs of the users with the highest peak volume, the corresponding volumes, as well as whether the local user is speaking.
- (void)rtcEngine:(AgoraRtcEngineKit *_Nonnull)engine reportAudioVolumeIndicationOfSpeakers:(NSArray<AgoraRtcAudioVolumeInfo*> *_Nonnull)speakers totalVolume:(NSInteger)totalVolume {
}
```

- Reports the user with the highest average volume. The `activeSpeaker` callback reports the user ID with the highest average volume during a certain period of time.

  <div class="alert note">You must call enableAudioVolumeIndication to be able to receive this callback.</div>

```swift
// Swift
// Gets the user ID of the user with the highest average volume during a certain period of time. A uid of 0 indicates the local user.
func rtcEngine(_ engine: AgoraRtcEngineKit, activeSpeaker speakerUid: UInt) {
}
```

```objective-c
// Objective-C
// Gets the user ID of the user with the highest average volume during a certain period of time. A uid of 0 indicates the local user.
- (void)rtcEngine:(AgoraRtcEngineKit *_Nonnull)engine activeSpeaker:(NSUInteger)speakerUid {
}
```

### Adjust the recording volume

Call `adjustRecordingSignalVolume` to set the volume of the recorded signal.


```swift
// Swift
// Sets the volume of the recorded signal as 50.
agoraKit.adjustRecordingSignalVolume(50)
```

```objective-c
// Objective-C
// Sets the volume of the recording signal as 50.
[agoraKit adjustRecordingSignalVolume: 50];
```

## Reference



### Sample project

We provide an open-source [JoinChannelAudio](https://github.com/AgoraIO/API-Examples/blob/dev/3.6.200/iOS/APIExample/Examples/Basic/JoinChannelAudio/JoinChannelAudio.swift) sample project that implements adjusting the recording, playback, and ear-monitoring volume on GitHub. You can download the sample project and view the source code.

When adjusting the audio volume, you can also refer to the following articles:

- If you need to adjust the volume of audio effect or audio mixing files, refer to [Play Audio Files](./audio_effect_mixing_apple?platform=iOS).
- [How to solve the problem of low volume?](https://docs.agora.io/en/faq/audio_low)

### API reference

- [`adjustRecordingSignalVolume`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/adjustRecordingSignalVolume:)
- [`adjustPlaybackSignalVolume`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/adjustPlaybackSignalVolume:)
- [`adjustUserPlaybackSignalVolume`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/adjustUserPlaybackSignalVolume:volume:)
- [`adjustAudioMixingPlayoutVolume`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/adjustAudioMixingPlayoutVolume:)
- [`enableInEarMonitoring`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/enableInEarMonitoring:)
- [`setInEarMonitoringVolume`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setInEarMonitoringVolume:)
- [`reportAudioVolumeIndicationOfSpeakers`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:reportAudioVolumeIndicationOfSpeakers:totalVolume:4)
- [`activeSpeaker`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:activeSpeaker:)

### Considerations

Setting the audio level too high may cause audio distortion on some devices.

