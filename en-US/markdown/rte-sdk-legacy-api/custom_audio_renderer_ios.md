This article introduces how to use the methods provided by the Agora SDK to implement custom audio rendering to meet your needs.

## Understand the tech

The Agora SDK uses default audio modules for rendering in real-time communications.
However, these modules might not meet your development requirements, such as in the following scenarios:

- Your app has its own audio module.
- You want to use a pre-processing library for the audio data.
- You need flexible device resource allocation to avoid conflicts with other services.

## Prerequisites

Before adjusting the audio volume, ensure that you have implemented the basic real-time communication functions in your project. For details, see [Start a Call](start_call_ios) or [Start Interactive Live Streaming](start_live_ios).

## Implementation

### Use custom audio renderer APIs

1. Before calling `joinChannel`, call `enableExternalAudioSink` to enable and configure the external audio renderer.

    ```swift
    agoraKit.enableExternalAudioSink(8000, channels:2)
    ```

2. After joining the channel, call `pullPlaybackAudioFrame` to retrieve the audio data sent by a remote user.

    ```swift
    agoraKit.pullPlaybackAudioFrameRawData(data, lengthInByte:lengthInByte)
    ```

3. Use your own audio renderer to process the audio data, then play the rendered data.

### Use raw audio data APIs

#### Prerequisites

Before implementing custom audio rendering, ensure that you have implemented the raw audio data function in your project. For details, see [Raw Audio Data](raw_audio_data_ios).

1. Get the audio data to play from `onRecordAudioFrame`, `onPlaybackAudioFrame`, `onMixedAudioFrame`, or `onPlaybackAudioFrameBeforeMixing`.
2. Render and play the remote audio data on your own.

## Reference

### Sample project

Agora provides an open-sourced API-Example iOS sample project on GitHub that includes the following files that implement custom audio renderer functions:

| File                                                         | Description                                                  |
| :----------------------------------------------------------- | :----------------------------------------------------------- |
| [CustomAudioRender](https://github.com/AgoraIO/API-Examples/tree/dev/3.6.200/iOS/APIExample/Examples/Advanced/CustomAudioRender) | Implements the custom audio render function.  |


### Considerations

Customizing the audio source and sink requires you to manage audio data recording and playback on your own.

- When customizing the audio sink, you need to process and play back the audio data on your own.