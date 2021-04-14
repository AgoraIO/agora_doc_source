---
title: Raw Audio Data
platform: Unity
updatedAt: 2020-07-10 16:50:36
---
## Introduction

During real-time communications, you can capture the raw audio data and process the captured raw audio data according to your needs.

Agora Unity SDK provides the `AudioRawDataManager` class for capturing the raw audio data.

## Implementation

Before using the raw audio data function, ensure that you have implemented the basic real-time communication functions in your project. See [Start a Voice Call](start_call_audio_unity) and [Start a Voice Broadcast](start_live_audio_unity) for details.

Follow these steps to implement the raw audio data functions in your project:

1. Before joining a channel, call `RegisterAudioRawDataObserver` to register an audio observer.
2. After you successfully register the observer, implement the following methods and callbacks as needed:
   - Call `SetOnRecordAudioFrameCallback` to listen for the `OnRecordAudioFrameHandler` callback, which returns an audio frame captured by the recording device.
   - Call `SetOnPlaybackAudioFrameCallback` to listen for the `OnPlaybackAudioFrameHandler` callback, which returns a mixed audio frame of all remote users.
   - Call `SetOnMixedAudioFrameCallback` to listen for the `OnMixedAudioFrameHandler` callback, which returns a mixed audio frame of local user, remote users and their music files.
   - Call `SetOnPlaybackAudioFrameBeforeMixingCallback` to listen for the `OnPlaybackAudioFrameBeforeMixingHandler` callback, which returns an audio frame of a specified remote user.
3. Process the captured raw audio data according to your needs. For example, you can play back the raw audio data through the `AudioSource` object of Unity, see the workflow as follows: 
   - Create a limited queue.
   - Each callback you call in the step 2 can return `buffer` data. Insert the `buffer` data to the rear of the queue.
   - Use the `setData` method of the `AudioClip` object to take the `buffer` data out and store in the `AudioClip` object.
   - Use the `AudioSource` object to play back the raw audio data in the `AudioClip` object.
4. After leaving the channel, call `UnRegisterAudioRawDataObserver` to remove the audio observer.

### API call sequence

The following diagram shows how to implement the raw audio data functions in your project:

![](https://web-cdn.agora.io/docs-files/1582034852535)

### Sample code

See the following sample code to implement the raw audio data functions in your project:

```
void Start()
{
   // Initializes IRtcEngine.
   mRtcEngine = IRtcEngine.GetEngine(mVendorKey);
   // Gets the AudioRawDataManager object.
   AudioRawDataManager = AudioRawDataManager.GetInstance(mRtcEngine);
   // Registers the audio observer.
   mRtcEngine.RegisterAudioRawDataObserver();
   // Listens for the OnRecordAudioFrameHandler delegate.
   AudioRawDataManager.SetOnRecordAudioFrameCallback(OnRecordAudioFrameHandler);
   // Listens for the OnPlaybackAudioFrameHandler delegate.
   AudioRawDataManager.SetOnPlaybackAudioFrameCallback(OnPlaybackAudioFrameHandler);
   // Listens for the OnMixedAudioFrameHandler delegate.
   AudioRawDataManager.SetOnMixedAudioFrameCallback(OnMixedAudioFrameHandler);
   // Listens for the OnPlaybackAudioFrameBeforeMixingHandler delegate.
   AudioRawDataManager.SetOnPlaybackAudioFrameBeforeMixingCallback(OnPlaybackAudioFrameBeforeMixingHandler);
}

// Gets an audio frame captured by the recording device.
void OnRecordAudioFrameHandler(AudioFrame audioFrame);
{
   Debug.Log("OnRecordAudioFrameHandler");
}

// Gets a mixed audio frame of all remote users.
void OnPlaybackAudioFrameHandler(AudioFrame audioFrame);
{
   Debug.Log("OnPlaybackAudioFrameHandler");
}

// Gets a mixed audio frame of local user, remote users and their music files.
void OnMixedAudioFrameHandler(AudioFrame audioFrame);
{
   Debug.Log("OnMixedAudioFrameHandler");
}

// Gets an audio frame of a specified remote user.
void OnPlaybackAudioFrameBeforeMixingHandler(AudioFrame audioFrame);
{
   Debug.Log("OnPlaybackAudioFrameBeforeMixingHandler");
}

public enum AUDIO_FRAME_TYPE 
{
   // 0: PCM16
   FRAME_TYPE_PCM16 = 0, 
};

public struct AudioFrame 
{
   // The type of the audio frame. See #AUDIO_FRAME_TYPE.
   public AUDIO_FRAME_TYPE type;
   // The number of samples per channel in the audio frame.
   public int samples;  
   // The number of bytes per audio sample, which is usually 16-bit (2-byte).
   public int bytesPerSample;  
   // The number of audio channels.
   // - 1: Mono
   // - 2: Stereo (the data is interleaved)
   public int channels;  
   // The sample rate.
   public int samplesPerSec;  
   // The data buffer of the audio frame. When the audio frame uses a stereo channel, the data buffer is interleaved. 
   // The size of the data buffer is as follows: buffer = samples × channels × bytesPerSample.
   public byte[] buffer;  
   // The timestamp of the external audio frame. You can use this parameter for the following purposes:
   // - Restore the order of the captured audio frame.
   // - Synchronize audio and video frames in video-related scenarios, including where external video sources are used.
   public long renderTimeMs;
   // Reserved for future use.
   public int avsync_type;
};
```

### API reference

- [RegisterAudioRawDataObserver](./API%20Reference/unity/classagora__gaming__rtc_1_1_audio_raw_data_manager.html#a383ab15736c601371ef2c2a4adc222b6)
- [UnRegisterAudioRawDataObserver](./API%20Reference/unity/classagora__gaming__rtc_1_1_audio_raw_data_manager.html#ab5a84bd4a281ba355723c94a53d5f440)
- [SetOnRecordAudioFrameCallback](./API%20Reference/unity/classagora__gaming__rtc_1_1_audio_raw_data_manager.html#aa9cfcbcf865a20a31985d804f01da015)
- [SetOnPlaybackAudioFrameCallback](./API%20Reference/unity/classagora__gaming__rtc_1_1_audio_raw_data_manager.html#af98e7659c8950e85cd49dfe0e3fcf8fc)
- [SetOnMixedAudioFrameCallback](./API%20Reference/unity/classagora__gaming__rtc_1_1_audio_raw_data_manager.html#a14176fcaa8f7574c797c44e8510dd216)
- [SetOnPlaybackAudioFrameBeforeMixingCallback](./API%20Reference/unity/classagora__gaming__rtc_1_1_audio_raw_data_manager.html#a6c1cbace7f81de8004b4a7945c999bbb)
- [OnRecordAudioFrameHandler](./API%20Reference/unity/classagora__gaming__rtc_1_1_audio_raw_data_manager.html#a11cc2a11aae003aad55972f1fa45902d)
- [OnPlaybackAudioFrameHandler](./API%20Reference/unity/classagora__gaming__rtc_1_1_audio_raw_data_manager.html#a314bf23c8d6da5a534e7e3129c2db99f)
- [OnMixedAudioFrameHandler](./API%20Reference/unity/classagora__gaming__rtc_1_1_audio_raw_data_manager.html#ab48b7b118a31e6433d83d3fbe750d150)
- [OnPlaybackAudioFrameBeforeMixingHandler](./API%20Reference/unity/classagora__gaming__rtc_1_1_audio_raw_data_manager.html#a8396bcc09ad94c0ac25d0f0ce073fc9a)

Use the following methods to modify the audio sample rate in the above callbacks:

- [SetRecordingAudioFrameParameters](./API%20Reference/unity/classagora__gaming__rtc_1_1_i_rtc_engine.html#a869d8e781cddb4db957338900b0154ad)
- [SetPlaybackAudioFrameParameters](./API%20Reference/unity/classagora__gaming__rtc_1_1_i_rtc_engine.html#a6ab86b7a541f1dc244e1cab3135935b4)
- [SetMixedAudioFrameParameters](./API%20Reference/unity/classagora__gaming__rtc_1_1_i_rtc_engine.html#ae9dc5fb3c4fde9da875ed8cfa783c5ea)

## Considerations

- Agora recommends to call `RegisterAudioRawDataObserver` before joining a channel, and call `UnRegisterAudioRawDataObserver` after leaving the channel.
- Agora Unity SDK provides four methods to listen for the above callbacks, and each callback is optional. To avoid wasting device resources, call each method according to your needs.