---
title: Adjust the Volume
platform: Unity
updatedAt: 2020-12-03 12:01:48
---
## Introduction

The Agora RTC SDK enables you to manage the volume of the recorded audio or of the audio playback according to your actual scenario. For example, to mute a remote user in a one-to-one call, you can set the audio playback volume as 0.

This article provides the APIs and additional information relating to audio recording, audio mixing, and audio playback volume settings.

![](https://web-cdn.agora.io/docs-files/1586770252932)

## Implementation
Before adjusting the audio volume, ensure that you have implemented the basic real-time communication functions in your project. For details, see [Start a Voice Call](start_call_audio_unity) or [Start Live Interactive Audio Streaming](start_live_audio_unity).

### Adjust the recording volume

**Recording** is the process of sampling audio by a recording device and transmitting the recorded signal to the sender. To adjust the recording volume, you can **set the volume of the recording device** or **set the volume of the recorded signal**. Agora recommends using audio device-related APIs to adjust the recording volume on Windows and macOS devices.
![](https://web-cdn.agora.io/docs-files/1586770294896)

#### Set the volume of the recording device (macOS and Windows only)

Call `SetAudioRecordingDeviceVolume` to set the volume of your recording device. 

<div class="alert note">This method sets the global volume of your recording device.</div>

The `volume` parameter represents the audio level of the recording device, ranging between 0 and 255:
- 0: Mute.
- 255: The maximum volume of the device.

As the following screenshot shows, the volume value corresponds to the audio level of your audio recording device.
![](https://web-cdn.agora.io/docs-files/1577201229190)

Sample code

```c#
// Retrieves the AudioRecordingDeviceManager object.
AudioRecordingDeviceManager audioRecordingDeviceManager = (AudioRecordingDeviceManager)mRtcEngine.GetAudioRecordingDeviceManager();
// Sets the volume of your recording device as 50.
int ret = audioRecordingDeviceManager.SetAudioRecordingDeviceVolume(50);
```

#### Set the volume of the recorded signal 

If `SetAudioRecordingDeviceVolume` does not suffice, you can call `AdjustRecordingSignalVolume` to set the volume of the recorded signal.

The `volume` parameter represents the audio level of the recorded signal, ranging between 0 and 400:
- 0: Mute.
- 100: (Default) The original volume.
- 400: Four times the original volume (amplifying the audio signals by four times).

Sample code

```c#
// Sets the volume of the recorded signal to 50% of the original volume.
int ret = mRtcEngine.AdjustRecordingSignalVolume(50);
```

#### API reference
- [`SetAudioRecordingDeviceVolume`](./API%20Reference/unity/classagora__gaming__rtc_1_1_audio_recording_device_manager.html#ac278e396de3080f50ba59dc71e256a78)
- [`AdjustRecordingSignalVolume`](./API%20Reference/unity/classagora__gaming__rtc_1_1_i_rtc_engine.html#a367f7bc63304e1b4c215780af1df005b)

### Adjust the playback volume

**Playback** is the process of playing the received audio signal on the local playback device. To adjust the playback volume, you can **set the volume of the playback device**, or **set the volume of the audio signal**. Agora recommends using audio device-related APIs to adjust the playback volume on Windows and macOS devices.
![](https://web-cdn.agora.io/docs-files/1586770338360)

#### Set the volume of the playback device (macOS and Windows only)

To set the volume on the playback device directly, call `SetAudioPlaybackDeviceVolume`. 

<div class="alert note">This method sets the global volume of your playback device.</div>

The `volume` parameter represents the audio level of the playback device, ranging between 0 and 255:
- 0: Mute.
- 255: The maximum volume of the device.

As the following screenshot shows, the volume value corresponds to the audio level of your audio playback device.
![](https://web-cdn.agora.io/docs-files/1577201545034)

Sample code

```c#
// Retrieves the AudioPlaybackDeviceManager object.
AudioPlaybackDeviceManager audioPlaybackDeviceManager = (AudioPlaybackDeviceManager)mRtcEngine.GetAudioPlaybackDeviceManager();
// Sets the volume of the playback device as 50.
int ret = audioPlaybackDeviceManager.SetAudioPlaybackDeviceVolume(50);
```

#### Set the volume of the playback signal

If `SetAudioPlaybackDeviceVolume` does not suffice, you can use `AdjustPlaybackSignalVolume`  to set the volume of the audio signal.
  - Universally sets the playback audio level of all remote users after audio mixing.
  - The `volume` parameter represents the playback audio level, ranging between 0 and 400. 

<div class="alert note">As of v2.3.2, to mute the local audio playback, you must call both <tt>AdjustPlaybackSignalVolume<tt> and </tt>AdjustAudioMixingVolume</tt>, and set the volume parameter as 0.</div>

Sample code

```c#
// Sets the volume of the local playback of all remote users as 50% of the original volume.
int ret = mRtcEngine.AdjustPlaybackSignalVolume(50);
```

#### API reference

- [`SetAudioPlaybackDeviceVolume`](./API%20Reference/unity/classagora__gaming__rtc_1_1_audio_playback_device_manager.html#aca6f0daed9ea0fd012b17a213fe83d24)
- [`AdjustPlaybackSignalVolume`](./API%20Reference/unity/classagora__gaming__rtc_1_1_i_rtc_engine.html#a25c394db63570a6f45f9b40e8d7eb8e1)
- [`AdjustAudioMixingVolume`](./API%20Reference/unity/classagora__gaming__rtc_1_1_i_rtc_engine.html#ae6a3b1041004fdd5a031975a2f9cdb7e)

### Adjust the audio mixing volume

**Audio mixing** is the process of combining local or online music files with the local stream so that all the remote users in the channel can hear the host and the music at the same time. See [Audio Effects/Mixing](audio_effect_mixing_unity) for more information about enabling this function.
![](https://web-cdn.agora.io/docs-files/1586770368334)

The `AdjustAudioMixingVolume` method adjusts the volume of the music file for both the local user and the remote users.

The `volume` parameter represents the audio level of the music file, ranging between 0 and 100.
- 0: Mute.
- 100: (Default) The original volume.

Sample code

```c#
// Sets the audio mixing volume for the local user and remote users as 50% of the original volume.
int ret = mRtcEngine.AdjustAudioMixingVolume(50);
```

You can also call `AdjustAudioMixingPlayoutVolume` and `AdjustAudioMixingPublishVolume` respectively to adjust the audio mixing volume.

- `AdjustAudioMixingPlayoutVolume`:
  - Adjusts the audio mixing volume for the local user.
  - The `volume` parameter represents the audio mixing volume for the local user, ranging between 0 and 100.
- `AdjustAudioMixingPublishVolume`：
  - Adjusts the audio mixing volume for the remote users.
  - The `volume` parameter represents the audio mixing volume for the remote users, ranging between 0 and 100.

<div class="alert note">Call <tt>AdjustAudioMixingPlayoutVolume</tt> and <tt>AdjustAudioMixingPublishVolume</tt> after joining a channel.</div>

Sample code

```c#
// Sets the audio mixing volume of the music for the remote users as 50% of the original volume.
int ret = mRtcEngine.AdjustAudioMixingPublishVolume(50);
// Sets the audio mixing volume of the music for the local user as 50% of the original volume.
int ret = mRtcEngine.AdjustAudioMixingPlayoutVolume(50);
```

#### API reference

- [`AdjustAudioMixingPublishVolume`](./API%20Reference/unity/classagora__gaming__rtc_1_1_i_rtc_engine.html#a0900c11feef9cbee498f17f95cd0aed2)
- [`AdjustAudioMixingPlayoutVolume`](./API%20Reference/unity/classagora__gaming__rtc_1_1_i_rtc_engine.html#ac7d6df07616489729d521ce47934bb29)
- [`AdjustAudioMixingVolume`](./API%20Reference/unity/classagora__gaming__rtc_1_1_i_rtc_engine.html#ae6a3b1041004fdd5a031975a2f9cdb7e)

### Adjust the audio effects volume

 An **audio effects** here refers to a sound clip which plays a brief sound effect such as clapping or gunshots. See [Audio Effects/Mixing](audio_effect_mixing_unity) for more information on how to enable this function.

![](https://web-cdn.agora.io/docs-files/1586770384829)

You can call `SetEffectsVolume` or `SetVolumeOfEffect` to set the audio effects volume.
- `SetEffectsVolume`：
  - Sets the volume of all audio effects.
  - The `volume` parameter represents the volume of the audio effects, ranging between 0 and 100.
- `SetVolumeOfEffect`：
  - Sets the volume of a specified audio effect.
  - The `volume` parameter represents the volume of a specified audio effect, ranging between 0 and 100.

#### Sample code

```c#
// Retrieves the AudioEffectManagerImpl object.
AudioEffectManagerImpl audioEffectManagerImpl = (AudioEffectManagerImpl)mRtcEngine.GetAudioEffectManager();
// Sets the volume of all audio effects as 50% of the original volume.
int ret = audioEffectManagerImpl.SetEffectsVolume(50);
// Sets the volume of a specified audio effect as 50% of the original volume.
int ret = mRtcEngine.SetVolumeOfEffect(soundId, 50);
```

#### API reference

- [`SetEffectsVolume`](./API%20Reference/unity/classagora__gaming__rtc_1_1_audio_effect_manager_impl.html#a94b890267c9ce921fd07153515ce510b)
- [`SetVolumeOfEffect`](./API%20Reference/unity/classagora__gaming__rtc_1_1_i_rtc_engine.html#a8238ea891e6c030263179735c647b1f1)

### Adjust the in-ear monitoring volume (Android and iOS only)

In audio recording, mixing and playing, you can call `SetInEarMonitoringVolume` to adjust the volume of the in-ear monitoring.

![](https://web-cdn.agora.io/docs-files/1586770402384)

The `volume` parameter represents the volume of the in-ear monitoring, ranging between 0 and 100.
- 0: Mute.
- 100: (Default) The original volume.

#### Sample code

```c#
// Enables in-ear monitoring.
int ret = mRtcEngine.EnableInEarMonitoring(true);
// Sets the in-ear monitoring volume as 50% of the original volume.
int ret = mRtcEngine.SetInEarMonitoringVolume(50);
```

#### API reference

- [`EnableInEarMonitoring`](./API%20Reference/unity/classagora__gaming__rtc_1_1_i_rtc_engine.html#ab5e3a1ccf03508f96af241cc25aefecd)
- [`SetInEarMonitoringVolume`](./API%20Reference/unity/classagora__gaming__rtc_1_1_i_rtc_engine.html#a0236c42fc3b664eb9e66f99e6209afc8)

### Get the data of the loudest speaker (callback)

When recording, mixing, or playing audio, you can use the following methods to get the data of the loudest speaker in the channel.

- Reports users with the highest peak volumes. The `OnVolumeIndicationHandler` callback reports the user IDs the corresponding volumes of the currently loudest speakers in the channel.
 
 <div class="alert note">You must call <tt>EnableAudioVolumeIndication</tt> to be able to receive this callback.</div>
 
 Sample code

 ```c#
// Gets the user IDs of the users with the highest peak volume, the corresponding volumes, as well as whether the local user is speaking.
// @param speakers is an array containing the user IDs and volumes of the local and the remote users. The volume parameter ranges between 0 and 255.
// @param speakerNumber refers to the number of the speakers, ranging between 0 and 3.
// @param totalVolume refers to the total volume after audio mixing, ranging between 0 and 255.
void OnVolumeIndicationHandler(const AudioVolumeInfo* speakers, unsigned int speakerNumber, int totalVolume)  {
}
 ```

- Reports the user with the highest average volume. The `OnActiveSpeakerHandler` callback reports the user ID with the highest average volume during a certain period of time.

 <div class="alert note">You must call <tt>EnableAudioVolumeIndication</tt> to be able to receive this callback.</div>

 Sample code

 ```c#
 // Gets the user ID of the user with the highest average volume during a certain period of time. A uid of 0 indicates the local user.
void OnActiveSpeakerHandler(uint uid) {
}
 ```

#### API reference

- [`OnVolumeIndicationHandler`](./API%20Reference/unity/namespaceagora__gaming__rtc.html#ac1916abed6e6e714c05997f415ec8686)
- [`OnActiveSpeakerHandler`](./API%20Reference/unity/namespaceagora__gaming__rtc.html#ade84b7a1e925d77c049bbf955fb6104c)

## Considerations

Setting the audio level too high may cause audio distortion on some devices.

## Reference

When adjusting the audio volume, you can also refer to the following articles:

- [How to solve the problem of low volume?](https://docs.agora.io/en/faq/audio_low)