This page shows you how to get raw audio data for pre- and post-processing.

## Understand the tech

During the audio transmission process, you can pre- and post-process the captured audio data to achieve the desired playback effect.

Agora provides the raw data function for you to process the audio data according to your scenarios. This function enables you to pre-process the captured audio signal before sending it to the encoder, or to post-process the decoded audio signal.

### API call sequence

The following figure shows how to implement the raw audio data function in your project:

![](https://web-cdn.agora.io/docs-files/1615535771289)

## Prerequisites

Before proceeding, ensure that you have implemented basic real-time functions in your project. See [Start a Call](./start_call_android?platform=Android) or [Start Interactive Live Streaming](./start_live_android?platform=Android).

## Implementation

To implement the raw audio data function in your project, refer to the following steps.

1. Before joining a channel, create an `IAudioFrameObserver` object and then call `registerAudioFrameObserver` to register an audio frame observer.
2. Call the `set` methods to configure the format of the audio frame.
3. Implement the `onRecordFrame`, `onPlaybackFrame`, `onPlaybackFrameBeforeMixing` and `onMixedFrame` callbacks. Get the audio frames captured the callbacks and process the data according to your needs.

```java
// Call registerAudioFrameObserver to register the audio frame observer and pass in an IAudioFrameObserver object.
engine.registerAudioFrameObserver(new IAudioFrameObserver() {

    // Implement the onRecordFrame callback by playing the captured audio frame.
    @Override
    public boolean onRecordFrame(byte[] samples, int numOfSamples, int bytesPerSample, int channels, int samplesPerSec) {
        if(isEnableLoopBack){
            mAudioPlayer.play(samples, 0, numOfSamples * bytesPerSample);
        }

        return false;
    }
    // Implement the onPlaybackFrame callback
    @Override
    public boolean onPlaybackFrame(byte[] samples, int numOfSamples, int bytesPerSample, int channels, int samplesPerSec) {
        return false;
    }
    // Implement the onPlaybackFrameBeforeMixing callback
    @Override
    public boolean onPlaybackFrameBeforeMixing(byte[] samples, int numOfSamples, int bytesPerSample, int channels, int samplesPerSec, int uid) {
        return false;
    }


    // Implement the onMixedFrame callback
    @Override
    public boolean onMixedFrame(byte[] samples, int numOfSamples, int bytesPerSample, int channels, int samplesPerSec) {
        return false;
    }

    // Call the set methods to configure the format of the audio frame captured by each callback.
    engine.setRecordingAudioFrameParameters(SAMPLE_RATE, SAMPLE_NUM_OF_CHANNEL, Constants.RAW_AUDIO_FRAME_OP_MODE_READ_WRITE,SAMPLES_PER_CALL);
    engine.setMixedAudioFrameParameters(SAMPLE_RATE, SAMPLES_PER_CALL);
    engine.setPlaybackAudioFrameParameters(SAMPLE_RATE, SAMPLE_NUM_OF_CHANNEL, Constants.RAW_AUDIO_FRAME_OP_MODE_READ_WRITE,SAMPLES_PER_CALL);
});
```

## Reference

This section includes in depth information about the methods you used in this page, and links to related pages.

### Sample project

Agora provides the following open-source sample projects on GitHub:

- [Process raw audio data](https://github.com/AgoraIO/API-Examples/blob/dev/3.6.200/Android/APIExample/app/src/main/java/io/agora/api/example/examples/advanced/ProcessAudioRawData.java)

### API reference

- [registerAudioFrameObserver](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a57eaa3859be21cd327763fc316197fff)
- [setRecordingAudioFrameParameters](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a682a8c493660bb565a38869dcc84c73e)
- [setPlaybackAudioFrameParameters](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a07e30f884f4dae8c7ddba740aeb008f1)
- [setMixedAudioFrameParameters](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a24da4130cac855befeac9b2f2e6e751f)
- [onRecordFrame](./API%20Reference/java/interfaceio_1_1agora_1_1rtc_1_1_i_audio_frame_observer.html#a386c3a451ce95f796d64e83006d7779c)
- [onPlaybackFrame](./API%20Reference/java/interfaceio_1_1agora_1_1rtc_1_1_i_audio_frame_observer.html#a3781dd30d34a0634140872a9dd131488)
- [onPlaybackFrameBeforeMixing](./API%20Reference/java/interfaceio_1_1agora_1_1rtc_1_1_i_audio_frame_observer.html#ab43c709bdbce83f907b00710b48d8d56)
- [onMixedFrame](./API%20Reference/java/interfaceio_1_1agora_1_1rtc_1_1_i_audio_frame_observer.html#a81794255075807161fa1a3c13e23db2c)