This article introduces how to use the methods provided by the Agora SDK to implement custom audio rendering to meet your needs.

## Understand the tech

The Agora SDK uses default audio modules for rendering in real-time communications.
However, these modules might not meet your development requirements, such as in the following scenarios:

- Your app has its own audio module.
- You want to use a pre-processing library for the audio data.
- You need flexible device resource allocation to avoid conflicts with other services.

## Implementation

### Prerequisites

Before implementing custom audio rendering, ensure that you have implemented the raw audio data function in your project. For details, see [Raw Audio Data](raw_audio_data_ios).

### Implement the workflow

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