---
title: Test a Media Device
platform: Unity
updatedAt: 2020-11-16 04:31:09
---
## Introduction

To ensure smooth communications, we recommend conducting a media device test before joining a channel to check whether the microphone or camera works properly. This function applies to scenarios that have high-quality requirements, such as online education.

## Implementation

Ensure that you understand how to start a call or start an interactive broadcast. See details in the following quickstarts:

- [Start a Voice Call](start_call_audio_unity) or [Start a Audio Broadcasting](start_live_audio_unity)
- [Start a Video Call](start_call_unity) or [Start a Video Broadcasting](start_live_unity)

Choose either of the following ways to test the audio or video devices:

- Call `StartAudioRecordingDeviceTest` or `StartEchoTest` to test the audio recording devices. When you want to stop the test, call `StopAudioRecordingDeviceTest` or `StopEchoTest`.
- Call `StartAudioPlaybackDeviceTest` or `StartEchoTest` to test the audio playback devices. When you want to stop the test, call `StopAudioPlaybackDeviceTest` or `StopEchoTest`.
- Call `StartPreview` to test the video devices. When you want to stop the test, call `StopPreview`.

<div class="alert note">Test the devices before joining a channel.</div>

### Recording device test

Call `StartAudioRecordingDeviceTest` or `StartEchoTest` to test whether the local audio recording device, such as the microphone, is working properly.

To conduct the test, the user speaks. If the SDK reports the audio volume information in the `OnVolumeIndicationHandler` callback, the audio recording device works properly. A UID of 0 indicates the local user. 

When you want to stop the test, call `StopAudioRecordingDeviceTest` or `StopEchoTest`.

#### Sample code

```c#
// For Windows or macOS devices.
public void loadEngine(string appId)
{
    // Initializes the IRtcEngine.
    mRtcEngine = IRtcEngine.GetEngine (appId);
    mRtcEngine.OnVolumeIndication = OnVolumeIndicationHandler;
    // Retrieves the AudioRecordingDeviceManager object.
    AudioRecordingDeviceManager audioRecordingDeviceManager = (AudioRecordingDeviceManager)mRtcEngine.GetAudioRecordingDeviceManager();
    // Creates an AudioRecordingDeviceManager instance.
    audioRecordingDeviceManager.CreateAAudioRecordingDeviceManager();
    // Retrieves the total number of the indexed audio recording devices in the system.
    int count = audioRecordingDeviceManager.GetAudioRecordingDeviceCount();
    // Retrieves the device ID of the target audio recording device. The value of index should not more than the number retrieved from GetAudioRecordingDeviceCount.
    audioRecordingDeviceManager.GetAudioRecordingDevice(0, ref deviceNameA, ref deviceIdA);
    // Sets the audio recording device using the device ID.
    audioRecordingDeviceManager.SetAudioRecordingDevice(deviceIdA);
    // Enables the audio volume callback.
    mRtcEngine.EnableAudioVolumeIndication(300, 3, true);
    // Starts the audio recording device test.
    audioRecordingDeviceManager.StartAudioRecordingDeviceTest(300);
    // Stops the audio recording device test.
    audioRecordingDeviceManager.StopAudioRecordingDeviceTest();
    // Releases AudioRecordingDeviceManager instance.
    audioRecordingDeviceManager.ReleaseAAudioRecordingDeviceManager();
}
     
// Implements the audio volume callback. 
void OnVolumeIndicationHandler(AudioVolumeInfo[] speakers, int speakerNumber, int totalVolume)
{
 
}
```

```c#
// For Android or iOS devices.
public void loadEngine(string appId)
{
    // Initializes the IRtcEngine.
    mRtcEngine = IRtcEngine.GetEngine (appId);   
    // Starts an audio device test.
    mRtcEngine.StartEchoTest(10);
    // Stops the audio device test.
    mRtcEngine.StopEchoTest();
}
```



#### API reference

- [`CreateAAudioRecordingDeviceManager`](./API%20Reference/unity/classagora__gaming__rtc_1_1_audio_recording_device_manager.html#ad9fb9e47b11e58219a531b092ed2f542)
- [`GetAudioRecordingDeviceManager`](./API%20Reference/unity/classagora__gaming__rtc_1_1_i_rtc_engine.html#a5e91acecd848f60d3f7b6e1feedd8ec2)
- [`GetAudioRecordingDeviceCount`](./API%20Reference/unity/classagora__gaming__rtc_1_1_audio_recording_device_manager.html#a506b83d43a439a5c70522250efcd18fa)
- [`GetAudioRecordingDevice`](./API%20Reference/unity/classagora__gaming__rtc_1_1_audio_recording_device_manager.html#a915dc0e346e47a20b12c9b4153f2f8ff)
- [`SetAudioRecordingDevice`](./API%20Reference/unity/classagora__gaming__rtc_1_1_audio_recording_device_manager.html#aba3adae3ee4b65ca9d4ad96ec90ea85e)
- [`OnVolumeIndicationHandler`](./API%20Reference/unity/namespaceagora__gaming__rtc.html#ac1916abed6e6e714c05997f415ec8686)
- [`EnableAudioVolumeIndication`](./API%20Reference/unity/classagora__gaming__rtc_1_1_i_rtc_engine.html#a9fcbc19f8c908171dd06be102b3cc84c)
- [`StartAudioRecordingDeviceTest`](./API%20Reference/unity/classagora__gaming__rtc_1_1_audio_recording_device_manager.html#af9b3a6b30159c8f408150195553db973)
- [`StopAudioRecordingDeviceTest`](./API%20Reference/unity/classagora__gaming__rtc_1_1_audio_recording_device_manager.html#a0763233b634c0f52521d20aae6e31d58)
- [`ReleaseAAudioRecordingDeviceManager`](./API%20Reference/unity/classagora__gaming__rtc_1_1_audio_recording_device_manager.html#a5c9812b4b2ae51ba8ca69f717e6d0fd9)
- [`StartEchoTest`](./API%20Reference/unity/classagora__gaming__rtc_1_1_i_rtc_engine.html#a98242534c8fbbe6451aef90f115bf253)
- [`StopEchoTest`](./API%20Reference/unity/classagora__gaming__rtc_1_1_i_rtc_engine.html#afa82ea6348ed0952ad4941aec6020553)

### Playback device test

Call `StartAudioPlaybackDeviceTest` or `StartEchoTest` to test whether the local audio playback device, such as the speaker, is working properly.

To conduct the test, specify an audio file for playback. If you can hear the audio file, the audio playback device works properly.

When you want to stop the test, call `StopAudioPlaybackDeviceTest` or `StopEchoTest`.

#### Sample code

```c#
// For Windows or macOS devices.
public void loadEngine(string appId)
{
    // Initializes the IRtcEngine.
    mRtcEngine = IRtcEngine.GetEngine (appId);
    mRtcEngine.OnVolumeIndication = OnVolumeIndicationHandler;
    // Retrieves the AudioPlaybackDeviceManager object.
    AudioPlaybackDeviceManager audioPlaybackDeviceManager = (AudioPlaybackDeviceManager)mRtcEngine.GetAudioPlaybackDeviceManager();
    // Creates an AudioPlaybackDeviceManager instance.
    audioPlaybackDeviceManager.CreateAAudioPlaybackDeviceManager();
    // Retrieves the total number of the indexed audio playback devices in the system.
    int count = audioPlaybackDeviceManager.GetAudioPlaybackDeviceCount();
    // Retrieves the device ID of the target audio playback device. The value of index should not more than the number retrieved from GetAudioPlaybackDeviceCount.
    audioPlaybackDeviceManager.GetAudioPlaybackDevice(0, ref deviceNameA, ref deviceIdA);
    // Sets the audio playback device using the device ID.
    audioPlaybackDeviceManager.SetAudioPlaybackDevice(deviceIdA);
    // Enables the audio volume callback.
    mRtcEngine.EnableAudioVolumeIndication(300, 3, true);
    // Starts the audio playback device test.
    audioPlaybackDeviceManager.StartAudioPlaybackDeviceTest(300);
    // Stops the audio playback device test.
    audioPlaybackDeviceManager.StopAudioPlaybackDeviceTest();
    // Releases AudioPlaybackDeviceManager instance.
    audioPlaybackDeviceManager.ReleaseAAudioPlaybackDeviceManager();
}
     
// Implements the audio volume callback. 
void OnVolumeIndicationHandler(AudioVolumeInfo[] speakers, int speakerNumber, int totalVolume)
{
 
}
```

```c#
// For Android or iOS devices.
public void loadEngine(string appId)
{
    // Initializes the IRtcEngine.
    mRtcEngine = IRtcEngine.GetEngine (appId);   
    // Starts an audio device test.
    mRtcEngine.StartEchoTest(10);
    // Stops the audio device test.
    mRtcEngine.StopEchoTest();
}
```

#### API reference

- [`CreateAAudioPlaybackDeviceManager`](./API%20Reference/unity/classagora__gaming__rtc_1_1_audio_playback_device_manager.html#a450d22b7a62e19ef904b25497ca37a9f)
- [`GetAudioPlaybackDeviceManager`](./API%20Reference/unity/classagora__gaming__rtc_1_1_i_rtc_engine.html#a80ef3b11d711fd8b7151184b53f3e9ad)
- [`GetAudioPlaybackDeviceCount`](./API%20Reference/unity/classagora__gaming__rtc_1_1_audio_playback_device_manager.html#a1146b8b47de6f2bb484036fe148940bf)
- [`GetAudioPlaybackDevice`](./API%20Reference/unity/classagora__gaming__rtc_1_1_audio_playback_device_manager.html#ac2a33d9a4a6cc5e595c8ed97d5abd9f6)
- [`SetAudioPlaybackDevice`](./API%20Reference/unity/classagora__gaming__rtc_1_1_audio_playback_device_manager.html#a5e3887205c686a3ee1ba5b019ce890d0)
- [`OnVolumeIndicationHandler`](./API%20Reference/unity/namespaceagora__gaming__rtc.html#ac1916abed6e6e714c05997f415ec8686)
- [`EnableAudioVolumeIndication`](./API%20Reference/unity/classagora__gaming__rtc_1_1_i_rtc_engine.html#a9fcbc19f8c908171dd06be102b3cc84c)
- [`StartAudioPlaybackDeviceTest`](./API%20Reference/unity/classagora__gaming__rtc_1_1_audio_playback_device_manager.html#af22121da6b72efd95de5567dcef250b8)
- [`StopAudioPlaybackDeviceTest`](./API%20Reference/unity/classagora__gaming__rtc_1_1_audio_playback_device_manager.html#a258fd90156636b7b4a0ccd3cef048563)
- [`ReleaseAAudioPlaybackDeviceManager`](./API%20Reference/unity/classagora__gaming__rtc_1_1_audio_playback_device_manager.html#a1cabc394e77fe075416b999610301c04)
- [`StartEchoTest`](./API%20Reference/unity/classagora__gaming__rtc_1_1_i_rtc_engine.html#a98242534c8fbbe6451aef90f115bf253)
- [`StopEchoTest`](./API%20Reference/unity/classagora__gaming__rtc_1_1_i_rtc_engine.html#afa82ea6348ed0952ad4941aec6020553)

### Video device test

The video device tests check the video capture device and the video rendering device.

After calling `EnableVideo` and `EnableVideoObserver`, call `StartPreview` to test whether the local video devices, such as the camera and renderer, are working properly. If you can see the local video view, the video devices work properly.

When you want to stop the test, call `StopPreview`.

<div class="alert note"><li>To get video raw data, ensure that you call both <tt>EnableVideo</tt> and <tt>EnableVideoObserver</tt> methods.<br><li>You cannot get a window handler in Unity, so Agora doesn't recommend to use the <tt>StartVideoDeviceTest</tt> or <tt>StartVideoDeviceTest</tt> method to test a video device.</br></li></div>


#### Sample code

```
// For Windows or macOS devices.
public void loadEngine(string appId)
{
    // Initializes IRtcEngine.
    mRtcEngine = IRtcEngine.GetEngine (appId);
    // Retrieves the VideoDeviceManager object.
    VideoDeviceManager videoDeviceManager = (VideoDeviceManager)mRtcEngine.GetVideoDeviceManager();
    // Creates a VideoDeviceManager instance.
    videoDeviceManager.CreateAVideoDeviceManager();
    // Retrieves the total number of the indexed video devices in the system.
    videoDeviceManager.GetVideoDeviceCount();
    // Retrieves the device ID of the target video device. The value of index should not more than the number retrieved from GetVideoDeviceCount.
    videoDeviceManager.GetVideoDevice(0, deviceNameA, deviceIdA);
    // Sets the video device using the device ID.
    videoDeviceManager.SetVideoDevice(deviceIdA);
    // Enables the video module.
    int mRtcEngine.EnableVideo();
    // Enables the video observer.
    int mRtcEngine.EnableVideoObserver();
    // Starts the video preview.
    int mRtcEngine.StartPreview();
    // Stops the video preview.
    int mRtcEngine.StopPreview();
    // Releases the VideoDeviceManager instance.
    videoDeviceManager.ReleaseAVideoDeviceManager();
}
```

####  API Reference

- [`CreateAVideoDeviceManager`](./API%20Reference/unity/classagora__gaming__rtc_1_1_video_device_manager.html#aa1b7dac0847168bf1785c809ea365448)
- [`GetVideoDeviceManager`](./API%20Reference/unity/classagora__gaming__rtc_1_1_i_rtc_engine.html#a043b46e8ec12ca5dab99d10e75c7e385)
- [`GetVideoDeviceCount`](./API%20Reference/unity/classagora__gaming__rtc_1_1_video_device_manager.html#a6b1bfd5cb7e1749861b8dc1167a98725)
- [`GetVideoDevice`](./API%20Reference/unity/classagora__gaming__rtc_1_1_video_device_manager.html#a2564c374c51d6a352394fe3c87abc8fa)
- [`SetVideoDevice`](./API%20Reference/unity/classagora__gaming__rtc_1_1_video_device_manager.html#aa85b06e3ecff61b799fce74f31af88e4)
- [`EnableVideo`](./API%20Reference/unity/classagora__gaming__rtc_1_1_i_rtc_engine.html#a1372df5a9a62a56996dbdb839b375116)
- [`EnableVideoObserver`](./API%20Reference/unity/classagora__gaming__rtc_1_1_i_rtc_engine.html#ace979cd59611a0cc39e13f8ea33c0f7c)
- [`StartPreview`](./API%20Reference/unity/classagora__gaming__rtc_1_1_i_rtc_engine.html#a50cd2959d23dc061a08cab28f40ee212)
- [`StopPreview`](./API%20Reference/unity/classagora__gaming__rtc_1_1_i_rtc_engine.html#a46072182b9da72eced255d7d5b9d989f)
- [`ReleaseAVideoDeviceManager`](./API%20Reference/unity/classagora__gaming__rtc_1_1_video_device_manager.html#a2e24fdc1ecd02fbd9add649f2e070278)

## Considerations

- Ensure that your audio or video device is not being used by any third-party app when you conduct the test.
- When you want to stop the test, ensure that you call the corresponding `Stop` method before calling `JoinChannelByKey`.