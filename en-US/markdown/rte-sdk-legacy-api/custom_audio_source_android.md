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
    engine.setExternalAudioSource(true, DEFAULT_SAMPLE_RATE, DEFAULT_CHANNEL_COUNT);
    // The local user joins the channel
    int res = engine.joinChannel(accessToken, channelId, "Extra Optional Data", 0);
    ```

2. Implement audio capture and processing yourself using methods from outside the SDK.

3. Call `pushExternalAudioFrame` to send the audio frames to the SDK for later use.

    ```java
    public class RecordThread extends Thread
        {
            private AudioRecord audioRecord;
            public static final int DEFAULT_SAMPLE_RATE = 16000;
            public static final int DEFAULT_CHANNEL_COUNT = 1, DEFAULT_CHANNEL_CONFIG = AudioFormat.CHANNEL_IN_MONO;
            private byte[] buffer;

            RecordThread()
            {
                int bufferSize = AudioRecord.getMinBufferSize(DEFAULT_SAMPLE_RATE, DEFAULT_CHANNEL_CONFIG,
                        AudioFormat.ENCODING_PCM_16BIT);
                audioRecord = new AudioRecord(MediaRecorder.AudioSource.MIC, DEFAULT_SAMPLE_RATE, DEFAULT_CHANNEL_COUNT,
                        AudioFormat.ENCODING_PCM_16BIT, bufferSize);
                buffer = new byte[bufferSize];
            }
            // Starts audio capture. Reads and sends the captured frames until audio capture stops.
            @Override
            public void run()
            {
                try
                {
                    // Start audio recording
                    audioRecord.startRecording();
                    while (!stopped)
                    {
                        // Reads the captured audio frames
                        int result = audioRecord.read(buffer, 0, buffer.length);
                        if (result >= 0)
                        {
                            // Sends the captured audio frames to the SDK
                            CustomAudioSource.engine.pushExternalAudioFrame(
                                    buffer, System.currentTimeMillis());
                        }
                        else
                        {
                            logRecordError(result);
                        }
                        Log.e(TAG, "Data size:" + result);
                    }
                    release();
                }
                catch (Exception e)
                {e.printStackTrace();}
            }

            ...
        }
    ```


## Reference

This section includes in depth information about the methods you used in this page, and links to related pages.

### Sample project

Agora provides an open-source [demo project](https://github.com/AgoraIO/API-Examples/blob/dev/3.6.200/Android/APIExample/app/src/main/java/io/agora/api/example/examples/advanced/customaudio) on GitHub. You can view the source code on Github or download the project to try it out.

###  API reference

- [`setExternalAudioSource`](https://docs.agora.io/en/Interactive%20Broadcast/API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a5e5630afd7104ee7be8b246ae004efb3)
- [`pushExternalAudioFrame`](https://docs.agora.io/en/Interactive%20Broadcast/API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a9e219a679d066cfc2544b5e8f9d4d69f)

