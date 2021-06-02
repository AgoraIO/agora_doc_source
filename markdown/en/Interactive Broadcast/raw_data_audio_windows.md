---
title: Raw Audio Data
platform: Windows
updatedAt: 2021-01-12 08:57:02
---
## Introduction

During real-time communications, you can pre- and post-process the audio data and modify it for desired playback effects

The RTC Native SDK uses the `IAudioFrameObserver` class to provide raw data functions. You can pre-process the data before sending it to the encoder and modify the captured audio frames. You can also post-process the data after sending it to the decoder and modify the received audio frames.

This article describes how to use raw audio data with the `IAudioFrameObserver` class.

## Implementation

Before using the raw data functions, ensure that you have implemented the basic real-time communication functions in your project. For details, see [Start a Call](./start_call_windows) or [Start Live Interactive Streaming](./start_live_windows).

Follow these steps to implement the raw data functions in your project:

1. Before joining the channel, call `registerAudioFrameObserver` to register an audio frame observer.
2. After successful registration, the SDK sends the raw audio data via `onRecordAudioFrame`, `onPlaybackAudioFrame`, `onPlaybackAudioFrameBeforeMixing`, or `onMixedAudioFrame`.
3. After acquiring the raw data, you can process the data based on your scenario and send the processed data to the SDK via the callbacks mentioned in step 2.

## API call sequence

The following diagram shows how to implement the raw data functions in your project:

![img](https://web-cdn.agora.io/docs-files/1604368836368)

## Data transfer

The following diagram shows the data transfer with the `IAudioFrameObserver` class:

![](https://web-cdn.agora.io/docs-files/1606295367157)

With `onRecordAudioFrame`, `onPlaybackAudioFrame`, `onPlaybackAudioFrameBeforeMixing`, or `onMixedAudioFrame` , you can:

- Get raw audio frames from `AudioFrame`.
- Process the raw frames from `AudioFrame` and return to the SDK or the custom renderer.

## Sample code

1. Call `registerAudioFrameObserver` to register an audio frame observer.

```cpp
// Register audio frame observer
BOOL CAgoraOriginalAudioDlg::RegisterAudioFrameObserver(BOOL bEnable, IAudioFrameObserver *audioFrameObserver)
{
   // Create an AutoPtr instance using the IMediaEngine as template
    agora::util::AutoPtr<agora::media::IMediaEngine> mediaEngine;
    // See AgoraBase.h in the SDK for the implementation of the AutoPtr class
    // The AutoPtr instance calls queryInterface and gets a pointer to the IMediaEngine instance via IID. 
    // The AutoPtr instance accesses the pointer to the IMediaEngine instance and calls registerAudioFrameObserver via IMediaEngine.
    mediaEngine.queryInterface(m_rtcEngine, agora::AGORA_IID_MEDIA_ENGINE);
    int nRet = 0;
    if (mediaEngine.get() == NULL)
        return FALSE;
    if (bEnable)
        // Register audio frame observer		
        nRet = mediaEngine->registerAudioFrameObserver(audioFrameObserver);
    else
        // Unregister audio frame observer
        nRet = mediaEngine->registerAudioFrameObserver(NULL);
  
    return nRet == 0 ? TRUE : FALSE;
}
```

2. Once you obtain the raw audio data, you can pre-process or post-process it.

   Pre-process:

```cpp
// Get the recorded raw audio data, amplify the volume, and send the audio data to the SDK
bool COriginalAudioProcFrameObserver::onRecordAudioFrame(AudioFrame& audioFrame)
{
    SIZE_T nSize = audioFrame.channels * audioFrame.samples * 2;
    unsigned int readByte = 0;
    int timestamp = GetTickCount();
    short *pBuffer = (short *)audioFrame.buffer;
    for (SIZE_T i = 0; i < nSize / 2; i++)
    {
        if (pBuffer[i] * 2 > 32767) {
            pBuffer[i] = 32767;
        }
        else if (pBuffer[i] * 2 < -32768) {
            pBuffer[i] = -32768;
        }
        else {
            pBuffer[i] *= 2;
        }
    }
    return true;
}
```
   
   Post-process:

```cpp
// Get the playback raw audio data, amplify the volume, and send the audio data to the SDK
bool COriginalAudioProcFrameObserver::onPlaybackAudioFrame(AudioFrame& audioFrame)
{
    SIZE_T nSize = audioFrame.channels * audioFrame.samples * 2;
    unsigned int readByte = 0;
    int timestamp = GetTickCount();
    short *pBuffer = (short *)audioFrame.buffer;
    for (SIZE_T i = 0; i < nSize / 2; i++)
    {
        if (pBuffer[i] * 2 > 32767) {
            pBuffer[i] = 32767;
        }
        else if (pBuffer[i] * 2 < -32768) {
            pBuffer[i] = -32768;
        }
        else {
            pBuffer[i] *= 2;
        }
    }
    return true;
}
```

```cpp
// Get the mixed recorded and playback audio frame, amplify the volume, and send the data to the SDK
bool COriginalAudioProcFrameObserver::onMixedAudioFrame(AudioFrame& audioFrame)
{
    SIZE_T nSize = audioFrame.channels * audioFrame.samples * 2;
    unsigned int readByte = 0;
    int timestamp = GetTickCount();
    short *pBuffer = (short *)audioFrame.buffer;
    for (SIZE_T i = 0; i < nSize / 2; i++)
    {
        if (pBuffer[i] * 2 > 32767) {
            pBuffer[i] = 32767;
        }
        else if (pBuffer[i] * 2 < -32768) {
            pBuffer[i] = -32768;
        }
        else {
            pBuffer[i] *= 2;
        }
    }
    return true;
}
```

```cpp
// Get the audio frame of a specified user before mixing, amplify the volume, and send the data to the SDK
bool COriginalAudioProcFrameObserver::onPlaybackAudioFrameBeforeMixing(unsigned int uid, AudioFrame& audioFrame)
{
    SIZE_T nSize = audioFrame.channels * audioFrame.samples * 2;
    unsigned int readByte = 0;
    int timestamp = GetTickCount();
    short *pBuffer = (short *)audioFrame.buffer;
    for (SIZE_T i = 0; i < nSize / 2; i++)
    {
        if (pBuffer[i] * 2 > 32767) {
            pBuffer[i] = 32767;
        }
        else if (pBuffer[i] * 2 < -32768) {
            pBuffer[i] = -32768;
        }
        else {
            pBuffer[i] *= 2;
        }
    }
    return true;
}
```

## API reference

- [`onRecordAudioFrame`](https://docs.agora.io/en/Interactive%20Broadcast/API%20Reference/cpp/classagora_1_1media_1_1_i_audio_frame_observer.html#ac6ab0c792420daf929fed78f9d39f728)
- [`onPlaybackAudioFrame`](https://docs.agora.io/en/Interactive%20Broadcast/API%20Reference/cpp/classagora_1_1media_1_1_i_audio_frame_observer.html#aefc7f9cb0d1fcbc787775588bc849bac)
- [`onPlaybackAudioFrameBeforeMixing`](https://docs.agora.io/en/Interactive%20Broadcast/API%20Reference/cpp/classagora_1_1media_1_1_i_audio_frame_observer.html#ae04d85a65eefec5e7c1e0477bcaa067c)
- [`onMixedAudioFrame`](https://docs.agora.io/en/Interactive%20Broadcast/API%20Reference/cpp/classagora_1_1media_1_1_i_audio_frame_observer.html#a78d095cbd0b8ee04f657430bb6de8100)

To update the sampling rate of the audio data in the callbacks, you can call the following methods:

- [`setRecordingAudioFrameParameters`](https://docs.agora.io/en/Interactive%20Broadcast/API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#a2c4717760b5fbf1bb8c1a3c16ca67fe5)
- [`setPlaybackAudioFrameParameters`](https://docs.agora.io/en/Interactive%20Broadcast/API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#aa5f2f6eb3db5acaaf8c40818d90694f1)
- [`setMixedAudioFrameParameters`](https://docs.agora.io/en/Interactive%20Broadcast/API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#a520ebcda51b5eb488339f3a12dfb8013)


## Sample project

Refer to the sample project on [GitHub](https://github.com/AgoraIO/API-Examples/tree/master/windows/APIExample) to learn how to use raw audio data in your project.