The default Agora audio module interacts seamlessly with the devices your app runs on. The SDK enables you to add specialized audio features to your app using custom audio renderers.

This page shows you how to integrate your custom audio renderer in your app.

## Understand the tech

By default, SDK integrates the default audio modules on the device your app runs on for real-time communication. However, there are scenarios where you may want to integrate a custom audio renderer. For example:

- Your app has its own audio module.
- You need to process the captured audio with a pre-processing library.
- You need flexible device resource allocation to avoid conflicts with other services.

To manage the processing and playback of audio frames when using a custom audio renderer, use methods from outside the Agora SDK.

### API call sequence

The following figure shows the call flow you need to implement when you integrate a custom audio rendered:

![](https://web-cdn.agora.io/docs-files/1569378513078)

### Audio data transfer

The following figure shows how the audio data is transferred when you customize the audio renderer:

![](https://web-cdn.agora.io/docs-files/1607672594828)

- You need to implement the rendering module yourself using methods from outside the SDK.
- Call `pullPlaybackAudioFrame` to retrieve the audio data sent by a remote user.

## Prerequisites

Before proceeding, ensure that you have implemented the basic real-time communication functions in your project. For details, see [Start a Voice Call](https://docs.agora.io/en/Voice/start_call_audio_android?platform=Android) or [Start Interactive Live Audio Streaming](https://docs.agora.io/en/Interactive%20Broadcast/start_live_audio_android?platform=Android).

## Implementation

This section shows you how to use custom audio renderers.

### Use custom audio renderer APIs

Take the following steps to use custom audio renderer APIs for custom audio rendering.

1. Enable audio sink during SDK initialization.

    ```java
    // Enable audio sink
    config.mEnableAudioDevice = false;
    engine = RtcEngine.create(config);
    ```

2. Before calling `joinChannel`, call `setExternalAudioSink` to enable and configure the external audio renderer.

    ```java
    // Enables the custom audio renderer
    rtcEngine.setExternalAudioSink(
        true,      // Enables external audio rendering
        44100,     // Sampling rate (Hz). You can set this value as 8000, 16000, 32000, 441000, or 48000
        1          // The number of channels of the external audio source. This value must not exceed 2
    );
    ```

3. After joining the channel, call `pullPlaybackAudioFrame` to retrieve the audio data sent by a remote user. Use your own audio renderer to process the audio data, then play the rendered data.

    ```java
    private class FileThread implements Runnable {

        @Override
        public void run() {
            while (mPull) {
                int lengthInByte = 48000 / 1000 * 2 * 1 * 10;
                ByteBuffer frame = ByteBuffer.allocateDirect(lengthInByte);
                int ret = engine.pullPlaybackAudioFrame(frame, lengthInByte);
                byte[] data = new byte[frame.remaining()];
                frame.get(data, 0, data.length);
                // Write to local file or render by player
                FileIOUtils.writeFileFromBytesByChannel("/sdcard/agora/pull_48k.pcm", data, true, true);
                try {
                    Thread.sleep(10);
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }

            }
        }
    }
    ```

### Use raw audio data APIs

Take the following steps to use raw audio data APIs for custom audio rendering.

##### Implementation

Ensure that you have implemented the raw audio data function in your project. For details, see [Raw Audio Data](raw_audio_data_android).

To implement a custom audio renderer in your project, refer to the following steps.

1. Get the audio data to play from `onRecordAudioFrame`, `onPlaybackAudioFrame`, `onMixedAudioFrame`, or `onPlaybackAudioFrameBeforeMixing`.
2. Render and play the remote audio data on your own.

## Reference

This section includes in depth information about the methods you used in this page, and links to related pages.

### Sample project

Agora provides an open-source [demo project](https://github.com/AgoraIO/API-Examples/blob/dev/3.6.200/Android/APIExample/app/src/main/java/io/agora/api/example/examples/advanced/customaudio) on GitHub. You can view the source code on Github or download the project to try it out.

###  API reference

- [`setExternalAudioSink`](https://docs.agora.io/en/Interactive%20Broadcast/API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a270c0607d443790e92cdbd0d45ba1732)
- [`pullPlaybackAudioFrame`](https://docs.agora.io/en/Interactive%20Broadcast/API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#ae15064944870692e9a0a59fdc87654c4)

