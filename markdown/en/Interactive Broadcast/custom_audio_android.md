---
title: Custom Audio Source and Renderer
platform: Android
updatedAt: 2021-01-13 03:49:51
---
## Introduction

Generally, Agora SDKs use default audio modules for capturing and rendering in real-time communications.

However, these default modules might not meet your development requirements, such as in the following scenarios:

- Your app has its own audio module.
- You need to process the captured audio with a pre-processing library.
- You need flexible device resource allocation to avoid conflicts with other services.

Agora provides a solution to enable a custom audio source and/or renderer in the above scenarios. This article describes how to do so using the Agora Native SDK.

## Sample project

Agora provides an open-source [demo project](https://github.com/AgoraIO/API-Examples/tree/master/Android/APIExample) on GitHub. You can view the source code on Github or download the project to try it out.

## Implementation

Before proceeding, ensure that you have implemented the basic real-time communication functions in your project. For details, see [Start a Voice Call](https://docs.agora.io/en/Voice/start_call_audio_android?platform=Android) or [Start Interactive Live Audio Streaming](https://docs.agora.io/en/Interactive%20Broadcast/start_live_audio_android?platform=Android).

### Custom audio source

Refer to the following steps to implement a custom audio source in your project:

1. Before calling `joinChannel`, call `setExternalAudioSource` to specify the custom audio source.
2. Implement audio capture and processing yourself using methods from outside the SDK.
3. Call `pushExternalAudioFrame` to send the audio frames to the SDK for later use.

#### API call sequence

Refer to the following diagram to implement the custom audio source:

![](https://web-cdn.agora.io/docs-files/1568968141511)

#### Audio data transfer

The following diagram shows how the audio data is transferred when you customize the audio source:

![](https://web-cdn.agora.io/docs-files/1607671910645)

- You need to implement the capture module yourself using methods from outside the SDK.
- Call `pushExternalAudioFrame` to send the captured audio frames to the SDK.

#### Code samples

Refer to the following code samples to implement the custom audio source in your project.

1. Before the local user joins the channel, specify the custom audio source.

```java
// Specifies the custom audio source
engine.setExternalAudioSource(true, DEFAULT_SAMPLE_RATE, DEFAULT_CHANNEL_COUNT);
// The local user joins the channel
int res = engine.joinChannel(accessToken, channelId, "Extra Optional Data", 0);
```

2. Implement your own audio capture module. After the local user joins the channel, enable the capture module to start capturing audio frames from the custom audio source.

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


#### API reference

- [`setExternalAudioSource`](https://docs.agora.io/en/Interactive%20Broadcast/API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a5e5630afd7104ee7be8b246ae004efb3)
- [`pushExternalAudioFrame`](https://docs.agora.io/en/Interactive%20Broadcast/API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a9e219a679d066cfc2544b5e8f9d4d69f)

### Custom audio renderer

Refer to the following steps to implement a custom audio renderer in your project:

1. Before calling `joinChannel`, call `setExternalAudioSink` to enable and configure the external audio renderer.
2. After joining the channel, call `pullPlaybackAudioFrame` to retrieve the audio data sent by a remote user.
3. Use your own audio renderer to process the audio data, then play the rendered data.

#### API call sequence

Refer to the following diagram to implement the custom audio renderer in your project:

![](https://web-cdn.agora.io/docs-files/1569378513078)

#### Audio data transfer

The following diagram shows how the audio data is transferred when you customize the audio renderer:

![](https://web-cdn.agora.io/docs-files/1607672594828)

- You need to implement the rendering module yourself using methods from outside the SDK.
- Call `pullPlaybackAudioFrame` to retrieve the audio data sent by a remote user.

#### Code samples

Refer to the following code samples to implement the custom audio renderer in your project:

```java
// Enables the custom audio renderer
rtcEngine.setExternalAudioSink(
    true,      // Enables external audio rendering
    44100,     // Sampling rate (Hz). You can set this value as 8000, 16000, 32000, 441000, or 48000
    1          // The number of channels of the external audio source. This value must not exceed 2
);

// Retrieves remote audio frames for playback
rtcEngine.pullPlaybackAudioFrame(
    data,             // The data type is byte[]
    lengthInByte      // The size of the audio data (byte)
);
```

####  API reference

- [`setExternalAudioSink`](https://docs.agora.io/en/Interactive%20Broadcast/API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a270c0607d443790e92cdbd0d45ba1732)
- [`pullPlaybackAudioFrame`](https://docs.agora.io/en/Interactive%20Broadcast/API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#ae15064944870692e9a0a59fdc87654c4)

## Considerations

Performing the following operations requires you to use methods from outside the Agora SDK:

- Manage the capture and processing of audio frames when using a custom audio source.
- Manage the processing and playback of audio frames when using a custom audio renderer.