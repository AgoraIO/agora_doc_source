The default Agora audio module interacts seamlessly with the devices your app runs on. The SDK enables you to add specialized audio features to your app using custom audio renderers.

This page shows you how to integrate your custom audio renderer in your app.

## Understand the tech

By default, SDK integrates the default audio modules on the device your app runs on for real-time communication. However, there are scenarios where you may want to integrate a custom audio renderer. For example:

- Your app has its own audio module.
- You need to process the captured audio with a pre-processing library.
- You need flexible device resource allocation to avoid conflicts with other services.

To manage the processing and playback of audio frames when using a custom audio renderer, use methods from outside the Agora SDK.

## Prerequisites

Before implementing custom audio rendering, ensure that you have implemented the raw audio data function in your project. For details, see [Raw Audio Data](raw_audio_data_ios).

## Implementation

To implement a custom audio renderer in your project, refer to the following steps.

1. Get the audio data to play from `onRecordAudioFrame`, `onPlaybackAudioFrame`, `onMixedAudioFrame`, or `onPlaybackAudioFrameBeforeMixing`.
2. Render and play the remote audio data on your own.

## Reference

This section includes reference information about the function.

### Sample project

Agora provides an open-sourced API-Example iOS sample project on GitHub that includes the following files that implement custom audio renderer functions:

| File                                                         | Description                                                  |
| :----------------------------------------------------------- | :----------------------------------------------------------- |
| [CustomAudioRender](https://github.com/AgoraIO/API-Examples/tree/dev/3.6.200/iOS/APIExample/Examples/Advanced/CustomAudioRender) | Implements the custom audio render function.  |