This article introduces how to use the methods provided by the Agora SDK to implement custom audio capture to meet your needs.

## Understand the tech

The Agora SDK uses default audio modules for capturing in real-time communications.
However, these modules might not meet your development requirements, such as in the following scenarios:

- Your app has its own audio module.
- You want to use a pre-processing library for the audio data.
- You need flexible device resource allocation to avoid conflicts with other services.

The API call sequence is as follows:

![custom audio source api sequence](https://web-cdn.agora.io/docs-files/1605766083489)

## Implementation

### Prerequisites

Before adjusting the audio volume, ensure that you have implemented the basic real-time communication functions in your project. For details, see [Start a Call](start_call_ios) or [Start Interactive Live Streaming](start_live_ios).

### Implement the workflow

Use the following steps to implement the custom audio source:

1. Before joining a channel, call `setExternalAudioSource` to notify the SDK to use the external audio source.

    ```swift
    agoraKit.setExternalAudioSource(true, sampleRate: Int(sampleRate), channels: Int(channel))
    ```

2. Record and process the audio data on your own.
3. Send the audio data back to the SDK using `pushExternalAudioFrame`.

    ```swift
    agoraKit.pushExternalAudioFrameNSData(data, sourceId: 1, timestamp: 0)
    ```

## Reference

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