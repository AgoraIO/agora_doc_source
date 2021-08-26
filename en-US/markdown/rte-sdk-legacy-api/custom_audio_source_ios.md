The default Agora audio module interacts seamlessly with the devices your app runs on. SDK enable you to add specialized audio features to your app using a custom audio source.


## Understand the tech

By default, SDK integrates the default audio modules on the device your app runs on for real-time communication. However, there are scenarios where you may want to integrate a custom audio capturer. For example:

- Your app has its own audio module.
- You want to use a pre-processing library for the audio data.
- You need flexible device resource allocation to avoid conflicts with other services.

To manage the capture and processing of audio frames when using a custom audio source, use methods from outside the Agora SDK.

The API call sequence is as follows:

![custom audio source api sequence](https://web-cdn.agora.io/docs-files/1605766083489)

## Prerequisites

Before adjusting the audio volume, ensure that you have implemented the basic real-time communication functions in your project. For details, see [Start a Call](start_call_ios) or [Start Interactive Live Streaming](start_live_ios).

## Implementation

To implement a custom audio source in your project, refer to the following steps.

1. Before joining a channel, call `setExternalAudioSource` to notify the SDK to use the external audio source.

    ```swift
    agoraKit.setExternalAudioSource(true, sampleRate: Int(sampleRate), channels: Int(channel))
    ```

2. Record and process the audio data on your own.
3. Send the audio data back to the SDK using `pushExternalAudioFrameRawData` or `pushExternalAudioFrameSampleBuffer`.

    ```swift
    agoraKit.pushExternalAudioFrameRawData(data, sourceId: 1, timestamp: 0)
    ```

## Reference

This section includes reference information about the function.

### Sample project

Agora provides an open-sourced API-Example iOS sample project on GitHub that includes the following files that implement custom audio source functions:

| File                                                         | Description                                                  |
| :----------------------------------------------------------- | :----------------------------------------------------------- |
| [CustomAudioSource](https://github.com/AgoraIO/API-Examples/tree/dev/3.6.200/iOS/APIExample/Examples/Advanced/CustomAudioSource) | Implements the custom audio source function.  |


### API reference

- [setExternalAudioSource1]()
- [setExternalAudioSource2]()
- [pushExternalAudioFrameRawData]()
- [pushExternalAudioFrameSampleBuffer]()

### Considerations

Customizing the audio source and sink requires you to manage audio data recording and playback on your own.

- When customizing the audio source, you need to record and process the audio data on your own.