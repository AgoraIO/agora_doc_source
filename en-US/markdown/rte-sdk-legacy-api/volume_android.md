# Adjust the Volume

This page shows you how to set audio recording, audio mixing, audio playback and in-ear monitoring volume.

## Understand the tech

The Agora RTC SDK enables you to manage the volume of the recorded audio or of the audio playback according to your actual scenario. For example, you can set the audio playback volume as 0 to mute a remote user in a one-to-one call.

<div class="alert note">Setting the audio level too high may cause audio distortion on some devices.</div>

The following figure shows the workflow for audio volume settings.

![](https://web-cdn.agora.io/docs-files/1578559042677)

### Playback

**Playback** is the process of playing the received audio signal on the local playback device.

![](https://web-cdn.agora.io/docs-files/1578559415146)

### In-ear monitoring

**In-ear monitoring** is the process of playing the audio from the recording device.

![](https://web-cdn.agora.io/docs-files/1578560373700)


### Recording

**Recording** is the process of sampling audio by a recording device and transmitting the recorded signal to the sender.

![](https://web-cdn.agora.io/docs-files/1578559122611)

## Prerequisites

Before adjusting the audio volume, ensure that you have implemented the basic real-time communication functions in your project. For details, see [Start a Call](start_call_android) or [Start Interactive Live Streaming](start_live_android).

## Implementation

### Adjust the playback volume

To set the volume of the audio signal, call `adjustPlaybackSignalVolume` or `adjustUserPlaybackSignalVolume`.


```java
int volume = 50;
int uid = 123456;
// Sets the playback audio level of all remote users.
mRtcEngine.adjustPlaybackSignalVolume(volume);
// Sets the playback audio level of a specified remote user, such as 123456.
mRtcEngine.adjustUserPlaybackSignalVolume(uid, volume);
```

### Adjust the in-ear monitoring volume

In audio recording, mixing and playback, to adjust the volume of the in-ear monitor, call `setInEarMonitoringVolume`.

```java
// Enables in-ear monitoring.
rtcEngine.enableInEarMonitoring(true);
int volume = 50;
// Sets the in-ear monitoring volume.
rtcEngine.setInEarMonitoringVolume(volume);
```



### Balance the volume by getting the data of the loudest speaker (callback)

When recording, mixing, or playing audio, you can use the following methods to get the data of the loudest speaker in the channel.

- Reports users with the highest peak volumes. The `onAudioVolumeIndication` callback reports the user IDs the corresponding volumes of the currently loudest speakers (at most 3) in the channel.

	 <div class="alert note">You must call <code>enableAudioVolumeIndication</code> to be able to receive this callback.</div>


  ```java
  private final IRtcEngineEventHandler mRtcEventHandler = new IRtcEngineEventHandler() {

        ...

        @override
        public void onAudioVolumeIndication(AudioVolumeInfo[] speakers, int totalVolume) {
        // Gets a list of the currently loudest speakers and the total volume
        }

  };

  ...

  // Enables the onAudioVolumeIndication callback
  mRtcEngine.enableAudioVolumeIndication(true);
  ```

- Reports the user with the highest average volume. The `onActiveSpeaker` callback reports the user ID with the highest average volume during a certain period of time.

	 <div class="alert note">You must call <code>enableAudioVolumeIndication</code> to be able to receive this callback.</div>

  ```java

  private final IRtcEngineEventHandler mRtcEventHandler = new IRtcEngineEventHandler() {

        @override
        public void onActiveSpeaker(int uid) {
          // Gets the uid of the highest average volume during a certain period of time
        }

        ...

  };

  ...

  // Enables the onAudioVolumeIndication callback
  mRtcEngine.enableAudioVolumeIndication(true);
  ```

### Adjust the recording volume

To set the volume of the recorded signal, call `adjustRecordingSignalVolume`.

```java
ChannelMediaOptions options = new ChannelMediaOptions();
options.clientRoleType = Constants.CLIENT_ROLE_BROADCASTER;
mRtcEngine.joinChannel(token, channelName, 1234, options);
int volume = 50;
// Sets the volume of the recorded signal.
rtcEngine.adjustRecordingSignalVolume(volume);
```

## Reference

This section includes reference information about the function.


### Sample project

We provide an open-source [AdjustVolume](https://github.com/AgoraIO/API-Examples/blob/dev/3.6.200/Android/APIExample/app/src/main/java/io/agora/api/example/examples/advanced/AdjustVolume.java) sample project that implements adjusting the sampling, playback, and ear-monitoring volume on GitHub. You can download the sample project and view the source code.

### API reference

- [`adjustRecordingSignalVolume`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#af3747f72256eb683feadbca2b742bd05)
- [`adjustPlaybackSignalVolume`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#af7d7f10fc96db2febb9c2590891d071b)
- [`adjustUserPlaybackSignalVolume`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#aac9c5135996428d9a238fe8e66858268)
- [`adjustAudioMixingPlayoutVolume`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a0308c6bc82af433ae8340e0b3cd228c9)
- [`setInEarMonitoringVolume`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#af71afdf140660b10c4fb0c40029c432d)
- [`onAudioVolumeIndication`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a4d37f2b4d569fa787bb8c0e3ae8cd424)
- [`onActiveSpeaker`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a895e965178d808f9d33b387ab3e50300)


