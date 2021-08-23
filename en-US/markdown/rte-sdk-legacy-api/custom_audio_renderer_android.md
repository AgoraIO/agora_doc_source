This article describes how to enable a custom audio renderer in the above scenarios.

## Understand the tech

Generally, Agora SDKs use default audio modules for rendering in real-time communications.

However, these default modules might not meet your development requirements, such as in the following scenarios:

- Your app has its own audio module.
- You need to process the captured audio with a pre-processing library.
- You need flexible device resource allocation to avoid conflicts with other services.


### API call sequence

Refer to the following diagram to implement the custom audio renderer in your project:

![](https://web-cdn.agora.io/docs-files/1569378513078)

### Audio data transfer

The following diagram shows how the audio data is transferred when you customize the audio renderer:

![](https://web-cdn.agora.io/docs-files/1607672594828)

- You need to implement the rendering module yourself using methods from outside the SDK.
- Call `pullPlaybackAudioFrame` to retrieve the audio data sent by a remote user.

## Prerequisites

Before proceeding, ensure that you have implemented the basic real-time communication functions in your project. For details, see [Start a Voice Call](https://docs.agora.io/en/Voice/start_call_audio_android?platform=Android) or [Start Interactive Live Audio Streaming](https://docs.agora.io/en/Interactive%20Broadcast/start_live_audio_android?platform=Android).

## Implementation


Refer to the following steps to implement a custom audio renderer in your project:

1. Before calling `joinChannel`, call `setExternalAudioSink` to enable and configure the external audio renderer.

    ```java
    // Enables the custom audio renderer
    rtcEngine.setExternalAudioSink(
        true,      // Enables external audio rendering
        44100,     // Sampling rate (Hz). You can set this value as 8000, 16000, 32000, 441000, or 48000
        1          // The number of channels of the external audio source. This value must not exceed 2
    );

2. After joining the channel, call `pullPlaybackAudioFrame` to retrieve the audio data sent by a remote user.

    ```java
    // Retrieves remote audio frames for playback
    rtcEngine.pullPlaybackAudioFrame(
        data,             // The data type is byte[]
        lengthInByte      // The size of the audio data (byte)
    );
    ```

3. Use your own audio renderer to process the audio data, then play the rendered data.


## Reference

### Sample project

Agora provides an open-source [demo project](https://github.com/AgoraIO/API-Examples/blob/dev/3.6.200/Android/APIExample/app/src/main/java/io/agora/api/example/examples/advanced/customaudio) on GitHub. You can view the source code on Github or download the project to try it out.

###  API reference

- [`setExternalAudioSink`](https://docs.agora.io/en/Interactive%20Broadcast/API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a270c0607d443790e92cdbd0d45ba1732)
- [`pullPlaybackAudioFrame`](https://docs.agora.io/en/Interactive%20Broadcast/API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#ae15064944870692e9a0a59fdc87654c4)


### Considerations

Performing the following operations requires you to use methods from outside the Agora SDK:

- Manage the processing and playback of audio frames when using a custom audio renderer.