The default Agora audio module interacts seamlessly with the devices your app runs on. The SDK enables you to add specialized audio features to your app using a custom audio source.

## Understand the tech

By default, SDK integrates the default audio modules on the device your app runs on for real-time communication. However, there are scenarios where you may want to integrate a custom audio capturer. For example:

- Your app has its own audio module.
- You need to process the captured audio with a pre-processing library.
- You need flexible device resource allocation to avoid conflicts with other services.

To manage the capture and processing of audio frames when using a custom audio source, use methods from outside the Agora SDK.

#### API call sequence

The following figure shows the call sequence you need to implement in your app for custom audio source:

![](https://web-cdn.agora.io/docs-files/1568968141511)

#### Audio data transfer

The following figure shows how the audio data is transferred when you customize the audio source:

![](https://web-cdn.agora.io/docs-files/1607671910645)

- You need to implement the capture module yourself using methods from outside the SDK.
- Call `pushExternalAudioFrame` to send the captured audio frames to the SDK.

## Prerequisites

Before proceeding, ensure that you have implemented the basic real-time communication functions in your project. For details, see [Start a Voice Call](https://docs.agora.io/en/Voice/start_call_audio_android?platform=Android) or [Start Interactive Live Audio Streaming](https://docs.agora.io/en/Interactive%20Broadcast/start_live_audio_android?platform=Android).

## Implementation

To implement a custom audio source in your project, refer to the following steps.

1. Before calling `joinChannel`, call `setExternalAudioSource` to specify the custom audio source.

    ```java
    // Specifies the custom audio source
    engine.setExternalAudioSource(true, DEFAULT_SAMPLE_RATE, DEFAULT_CHANNEL_COUNT, 1, true, true);
    // The local user joins the channel
    ChannelMediaOptions option = new ChannelMediaOptions();
    option.autoSubscribeAudio = true;
    option.autoSubscribeVideo = true;
    int res = engine.joinChannel(accessToken, channelId, 0, option);
    ```

2. Implement audio capture and processing yourself using methods from outside the SDK.

3. Call `pushExternalAudioFrame` to send the audio frames to the SDK for later use.

    ```java
    engine.pushExternalAudioFrame(ByteBuffer.wrap(buffer), 0, 0);
    ```


## Reference

This section includes in depth information about the methods you used in this page, and links to related pages.

### Sample project

Agora provides an open-source [demo project](https://github.com/AgoraIO/API-Examples/blob/dev/3.6.200/Android/APIExample/app/src/main/java/io/agora/api/example/examples/advanced/customaudio) on GitHub. You can view the source code on Github or download the project to try it out.

###  API reference

- [`setExternalAudioSource1`]()
- [`setExternalAudioSource2`]()
- [`pushExternalAudioFrame1`]()
- [`pushExternalAudioFrame2`]()
