## Understand the tech

During the audio transmission process, you can pre- and post-process the captured audio data to achieve the desired playback effect.

Agora provides the raw data function for you to process the audio data according to your scenarios. This function enables you to pre-process the captured audio signal before sending it to the encoder, or to post-process the decoded audio signal.

## Implementation

### Process raw audio data using Java APIs

#### API call sequence

The following diagram shows how to implement the raw audio data function in your project:

![](https://web-cdn.agora.io/docs-files/1615535771289)

<div class="alert note">The Agora C++ SDK provides the <code>IAudioFrameObserver</code> class to capture and modify raw audio data. Therefore, you can use Java to call the C++ API via the JNI (Java Native Interface). Since the RTC Java SDK encapsulates the RTC C++ SDK, you can include the <code>.h</code> file in the SDK to directly call the C++ methods.</div>

#### API call sequence

The following diagram shows how to implement the raw audio data function in your project:

<div class="alert note">The <code>registerAudioFrameObserver</code>, <code>onRecordAudioFrame</code>, <code>onPlaybackAudioFrame</code>, <code>onMixedAudioFrame</code>, and <code>onPlaybackAudioFrameBeforeMixing</code> are all C++ methods and callbacks.</div>

![](https://web-cdn.agora.io/docs-files/1607913459953)


## Implementation

### Prerequisites

Before proceeding, ensure that you have implemented basic real-time functions in your project. See [Start a Call](./start_call_android?platform=Android) or [Start Interactive Live Streaming](./start_live_android?platform=Android).

### Process raw audio data using Java APIs

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


### Process raw audio data using JNI and C++ APIs

Before using the raw data function, ensure that you have implemented the basic real-time audio function in your project.


Follow these steps to implement the raw audio data function in your project:

1. Use the JNI and C++ interface files to generate a shared library in the project, and use Java to call the raw audio data interface of the Agora C++ SDK.
2. Before joining a channel, call the `registerAudioFrameObserver` method to register an audio observer, and implement an `IAudioFrameObserver` class in this method.
3. After you successfully register the observer, the SDK sends the captured raw audio data via the `onRecordAudioFrame`, `onPlaybackAudioFrame`, `onPlaybackAudioFrameBeforeMixing`, or `onMixedAudioFrame` callbacks.
4. Process the captured raw audio data according to your needs. Then, you can either play it yourself directly or send it to the SDK via the callbacks mentioned in step 3 per your requirements.

#### Call the Agora C++ API in a Java project

The following diagram shows the basic flow of calling the Agora C++ API in a Java project:

![](https://web-cdn.agora.io/docs-files/1607913364400)

- The Java project loads the `.so` library built from the C++ interface file (`.cpp` file) via the Java interface file.
- The Java interface file generates a `.h` file with the `javac -h -jni` command. The C++ interface file should include this file.
- The C++ interface file calls the C++ method of the `.so` library in the Agora Android SDK by including the header files from the Agora Android SDK.


##### Create a JNI interface

Create a Java interface file and a C++ interface file separately via the JNI interface. Make sure to build the C++ interface file as a `.so` library.

1. Create a Java interface file to call the C++ API. The interface file should declare the relevant Java methods for calling C++. Refer to the `MediaPreProcessing.java` file in the sample project for the implementation.

    ```java
    // The Java interface file declares the relevant Java methods for calling C++.
    package io.agora.advancedvideo.rawdata;

    import java.nio.ByteBuffer;

    public class MediaPreProcessing {
        static {
            // Loads the C++ .so library. Build the C++ interface file to generate the .so library.
            // The name of the .so library depends on the library name generated by building the C++ interface file.
            System.loadLibrary("apm-plugin-raw-data");
        }
        // Define the local method
        public interface ProgressCallback {

        ...

            // Get the recorded audio frame
            void onRecordAudioFrame(int audioFrameType, int samples, int bytesPerSample, int channels, int samplesPerSec, long renderTimeMs, int bufferLength);
            // Get the playback audio frame
            void onPlaybackAudioFrame(int audioFrameType, int samples, int bytesPerSample, int channels, int samplesPerSec, long renderTimeMs, int bufferLength);
            // Get the playback audio frame before mixing
            void onPlaybackAudioFrameBeforeMixing(int uid, int audioFrameType, int samples, int bytesPerSample, int channels, int samplesPerSec, long renderTimeMs, int bufferLength);
            // Get the mixed audio frame
            void onMixedAudioFrame(int audioFrameType, int samples, int bytesPerSample, int channels, int samplesPerSec, long renderTimeMs, int bufferLength);
        }

        public static native void setCallback(ProgressCallback callback);

        public static native void setAudioRecordByteBuffer(ByteBuffer byteBuffer);

        public static native void setAudioPlayByteBuffer(ByteBuffer byteBuffer);

        public static native void setBeforeAudioMixByteBuffer(ByteBuffer byteBuffer);

        public static native void setAudioMixByteBuffer(ByteBuffer byteBuffer);


        public static native void releasePoint();

    }
    ```

2. Run the following command to generate a `.h` file from the Java interface file:

    ```shell
    # JDK 10 or later
    javac -h -jni MediaPreProcessing.java

    # JDK 9 or earlier
    javac MediaPreProcessing.java
    javah -jni MediaPreProcessing.class
    ```

3. Create a C++ interface file. The C++ interface file exports the corresponding methods from the C++ SDK based on the generated `.h` file. Refer to the `io_agora_advancedvideo_rawdata_MediaPreProcessing.cpp` file in the sample project for the implementation.

    <div class="alert note">The JNI defines the data structure in C++ that maps to Java. You can refer to <a href="https://docs.oracle.com/javase/7/docs/technotes/guides/jni/spec/jniTOC.html">this document</a> for more information.</div>

    ```cpp
    // Global variables

    jobject gCallBack = nullptr;
    jclass gCallbackClass = nullptr;
    // Method IDs at the Java level
    jmethodID recordAudioMethodId = nullptr;
    jmethodID playbackAudioMethodId = nullptr;
    jmethodID playBeforeMixAudioMethodId = nullptr;
    jmethodID mixAudioMethodId = nullptr;
    // ByteBuffer for audio frames from onRecordAudioFrame
    void *_javaDirectPlayBufferRecordAudio = nullptr;
    // ByteBuffer for audio frames from onPlaybackAudioFrame
    void *_javaDirectPlayBufferPlayAudio = nullptr;
    // ByteBuffer for audio frames from onPlaybackAudioFrameBeforeMixing
    void *_javaDirectPlayBufferBeforeMixAudio = nullptr;
    // ByteBuffer for audio frames from onMixedAudioFrame
    void *_javaDirectPlayBufferMixAudio = nullptr;
    map<int, void *> decodeBufferMap;

    static JavaVM *gJVM = nullptr;

    // Implement the IAudioFrameObserver class and related callbacks
    class AgoraAudioFrameObserver : public agora::media::IAudioFrameObserver
    {

    public:
        AgoraAudioFrameObserver()
        {
            gCallBack = nullptr;
        }

        ~AgoraAudioFrameObserver()
        {
        }
        // Get audio frames from the AudioFrame object, copy to the ByteBuffer, and call the Java method by method ID
        void getAudioFrame(AudioFrame &audioFrame, _jmethodID *jmethodID, void *_byteBufferObject,
                        unsigned int uid)
        {
            if (_byteBufferObject == nullptr)
            {
                return;
            }

            AttachThreadScoped ats(gJVM);
            JNIEnv *env = ats.env();
            if (env == nullptr)
            {
                return;
            }
            int len = audioFrame.samples * audioFrame.bytesPerSample;
            memcpy(_byteBufferObject, audioFrame.buffer, (size_t) len); // * sizeof(int16_t)

            if (uid == 0)
            {
                env->CallVoidMethod(gCallBack, jmethodID, audioFrame.type, audioFrame.samples,
                                    audioFrame.bytesPerSample,
                                    audioFrame.channels, audioFrame.samplesPerSec,
                                    audioFrame.renderTimeMs, len);
            } else
            {
                env->CallVoidMethod(gCallBack, jmethodID, uid, audioFrame.type, audioFrame.samples,
                                    audioFrame.bytesPerSample,
                                    audioFrame.channels, audioFrame.samplesPerSec,
                                    audioFrame.renderTimeMs, len);
            }
        }
        // Copies the audio frames from the ByteBuffer to the AudioFrame object
        void writebackAudioFrame(AudioFrame &audioFrame, void *byteBuffer)
        {
            if (byteBuffer == nullptr)
            {
                return;
            }

            int len = audioFrame.samples * audioFrame.bytesPerSample;
            memcpy(audioFrame.buffer, byteBuffer, (size_t) len);
        }

    public:
        // Implement the onRecordAudioFrame callback
        virtual bool onRecordAudioFrame(AudioFrame &audioFrame) override
        {
            // Gets the recorded audio frames
            getAudioFrame(audioFrame, recordAudioMethodId, _javaDirectPlayBufferRecordAudio, 0);
            // Sends the audio frames to the SDK
            writebackAudioFrame(audioFrame, _javaDirectPlayBufferRecordAudio);
            return true;
        }

        // Implement the onPlaybackAudioFrame callback
        virtual bool onPlaybackAudioFrame(AudioFrame &audioFrame) override
        {
            // Gets the playback audio frames
            getAudioFrame(audioFrame, playbackAudioMethodId, _javaDirectPlayBufferPlayAudio, 0);
            // Sends the audio frames to the SDK
            writebackAudioFrame(audioFrame, _javaDirectPlayBufferPlayAudio);
            return true;
        }

    // Implement the onPlaybackAudioFrameBeforeMixing callback
        virtual bool onPlaybackAudioFrameBeforeMixing(unsigned int uid, AudioFrame &audioFrame) override
        {
            // Gets the playback audio frames before mixing
            getAudioFrame(audioFrame, playBeforeMixAudioMethodId, _javaDirectPlayBufferBeforeMixAudio,
                        uid);
            // Sends the audio frames to the SDK
            writebackAudioFrame(audioFrame, _javaDirectPlayBufferBeforeMixAudio);
            return true;
        }

        // Implement the onMixedAudioFrame callback
        virtual bool onMixedAudioFrame(AudioFrame &audioFrame) override
        {
            // Gets the mixed audio frames
            getAudioFrame(audioFrame, mixAudioMethodId, _javaDirectPlayBufferMixAudio, 0);
            // Sends the audio frames to the SDK
            writebackAudioFrame(audioFrame, _javaDirectPlayBufferMixAudio);
            return true;
        }
    };


    ...

    // AgoraAudioFrameObserver object
    static AgoraAudioFrameObserver s_audioFrameObserver;
    // IRtcEngine object
    static agora::rtc::IRtcEngine *rtcEngine = nullptr;

    // Set up the C++ interface
    #ifdef __cplusplus
    extern "C" {
    #endif


    int __attribute__((visibility("default")))
    loadAgoraRtcEnginePlugin(agora::rtc::IRtcEngine *engine)
    {
        __android_log_print(ANDROID_LOG_DEBUG, "agora-raw-data-plugin", "loadAgoraRtcEnginePlugin");
        rtcEngine = engine;
        return 0;
    }

    void __attribute__((visibility("default")))
    unloadAgoraRtcEnginePlugin(agora::rtc::IRtcEngine *engine)
    {
        __android_log_print(ANDROID_LOG_DEBUG, "agora-raw-data-plugin", "unloadAgoraRtcEnginePlugin");

        rtcEngine = nullptr;
    }


    ...


    // For the Java interface file, use the JNI to export corresponding C++ methods. The Java_io_agora_advancedvideo_rawdata_MediaPreProcessing_setCallback method corresponds to the setCallback method in the Java interface file.
    JNIEXPORT void JNICALL Java_io_agora_advancedvideo_rawdata_MediaPreProcessing_setCallback
            (JNIEnv *env, jclass, jobject callback)
    {
        if (!rtcEngine) return;

        env->GetJavaVM(&gJVM);
        // Create an AutoPtr instance that uses the IMediaEngine class as the template
        agora::util::AutoPtr<agora::media::IMediaEngine> mediaEngine;
        // The AutoPtr instance calls the queryInterface method to get a pointer to the IMediaEngine instance from the IID.
        // The AutoPtr instance accesses the pointer to the IMediaEngine instance via the arrow operator and calls the registerVideoFrameObserver method via the IMediaEngine instance.
        mediaEngine.queryInterface(rtcEngine, agora::INTERFACE_ID_TYPE::AGORA_IID_MEDIA_ENGINE);
        if (mediaEngine)
        {

            ...


            // Register the audio frame observer
            int ret = mediaEngine->registerAudioFrameObserver(&s_audioFrameObserver);

        }

    if (gCallBack == nullptr)
        {
            gCallBack = env->NewGlobalRef(callback);
            gCallbackClass = env->GetObjectClass(gCallBack);

            // Get the MethodId of each callback function through the callback object
            recordAudioMethodId = env->GetMethodID(gCallbackClass, "onRecordAudioFrame", "(IIIIIJI)V");
            playbackAudioMethodId = env->GetMethodID(gCallbackClass, "onPlaybackAudioFrame",
                                                    "(IIIIIJI)V");
            playBeforeMixAudioMethodId = env->GetMethodID(gCallbackClass,
                                                        "onPlaybackAudioFrameBeforeMixing",
                                                        "(IIIIIIJI)V");
            mixAudioMethodId = env->GetMethodID(gCallbackClass, "onMixedAudioFrame", "(IIIIIJI)V");

            ...

            __android_log_print(ANDROID_LOG_DEBUG, "setCallback", "setCallback done successfully");
        }

    }

    ...

    // C++ implementation of setAudioRecordByteBuffer in the Java interface file
    JNIEXPORT void JNICALL
    Java_io_agora_advancedvideo_rawdata_MediaPreProcessing_setAudioRecordByteBuffer
            (JNIEnv *env, jclass, jobject bytebuffer)
    {
        _javaDirectPlayBufferRecordAudio = env->GetDirectBufferAddress(bytebuffer);
    }
    // C++ implementation of setAudioPlayByteBuffer in the Java interface file
    JNIEXPORT void JNICALL Java_io_agora_advancedvideo_rawdata_MediaPreProcessing_setAudioPlayByteBuffer
            (JNIEnv *env, jclass, jobject bytebuffer)
    {
        _javaDirectPlayBufferPlayAudio = env->GetDirectBufferAddress(bytebuffer);
    }
    //  C++ implementation of setBeforeAudioMixByteBuffer in the Java interface file
    JNIEXPORT void JNICALL
    Java_io_agora_advancedvideo_rawdata_MediaPreProcessing_setBeforeAudioMixByteBuffer
            (JNIEnv *env, jclass, jobject bytebuffer)
    {
        _javaDirectPlayBufferBeforeMixAudio = env->GetDirectBufferAddress(bytebuffer);
    }
    //  C++ implementation of setAudioMixByteBuffer in the Java interface file
    JNIEXPORT void JNICALL Java_io_agora_advancedvideo_rawdata_MediaPreProcessing_setAudioMixByteBuffer
            (JNIEnv *env, jclass, jobject bytebuffer)
    {
        _javaDirectPlayBufferMixAudio = env->GetDirectBufferAddress(bytebuffer);
    }

    }


    ...


    #ifdef __cplusplus
    }
    #endif
    ```

4. Build the C++ interface file via the NDK to generate a `.so` library. Use the `System.loadLibrary()` method to load the generated `.so` library in the Java interface file. See the following CMake file.

    ```c
    cmake_minimum_required(VERSION 3.4.1)

    add_library( # Sets the name of the library.
            apm-plugin-raw-data

            # Sets the library as a shared library.
            SHARED

            # Provides a relative path to your source file(s).
            src/main/cpp/io_agora_advancedvideo_rawdata_MediaPreProcessing.cpp)


    find_library( # Sets the name of the path variable.
            log-lib

            # Specifies the name of the NDK library that
            # you want CMake to locate.
            log)

    target_link_libraries( # Specifies the target library.
            apm-plugin-raw-data

            # Links the target library to the log library
            # included in the NDK.
            ${log-lib})
    ```

#### Implement the raw audio data function in a Java project

1. Implement an interface that maps to the C++ methods in a Java interface file.

    ```java
    // Implement the ProgressCallback interface in Java
    public class MediaDataObserverPlugin implements MediaPreProcessing.ProgressCallback {


        ...

    // Get the recorded audio frame
    @Override
        public void onRecordAudioFrame(int audioFrameType, int samples, int bytesPerSample, int channels, int samplesPerSec, long renderTimeMs, int bufferLength) {
            byte[] buf = new byte[bufferLength];
            byteBufferAudioRecord.limit(bufferLength);
            byteBufferAudioRecord.get(buf);
            byteBufferAudioRecord.flip();

            for (MediaDataAudioObserver observer : audioObserverList) {
                observer.onRecordAudioFrame(buf, audioFrameType, samples, bytesPerSample, channels, samplesPerSec, renderTimeMs, bufferLength);
            }

            byteBufferAudioRecord.put(buf);
            byteBufferAudioRecord.flip();
        }

        // Get the playback audio frame
        @Override
        public void onPlaybackAudioFrame(int audioFrameType, int samples, int bytesPerSample, int channels, int samplesPerSec, long renderTimeMs, int bufferLength) {
            byte[] buf = new byte[bufferLength];
            byteBufferAudioPlay.limit(bufferLength);
            byteBufferAudioPlay.get(buf);
            byteBufferAudioPlay.flip();

            for (MediaDataAudioObserver observer : audioObserverList) {
                observer.onPlaybackAudioFrame(buf, audioFrameType, samples, bytesPerSample, channels, samplesPerSec, renderTimeMs, bufferLength);
            }

            byteBufferAudioPlay.put(buf);
            byteBufferAudioPlay.flip();
        }
        // Get the playback audio frame before mixing
        @Override
        public void onPlaybackAudioFrameBeforeMixing(int uid, int audioFrameType, int samples, int bytesPerSample, int channels, int samplesPerSec, long renderTimeMs, int bufferLength) {
            byte[] buf = new byte[bufferLength];
            byteBufferBeforeAudioMix.limit(bufferLength);
            byteBufferBeforeAudioMix.get(buf);
            byteBufferBeforeAudioMix.flip();

            for (MediaDataAudioObserver observer : audioObserverList) {
                observer.onPlaybackAudioFrameBeforeMixing(uid, buf, audioFrameType, samples, bytesPerSample, channels, samplesPerSec, renderTimeMs, bufferLength);
            }

            byteBufferBeforeAudioMix.put(buf);
            byteBufferBeforeAudioMix.flip();
        }
        // Get the mixed audio frame
        @Override
        public void onMixedAudioFrame(int audioFrameType, int samples, int bytesPerSample, int channels, int samplesPerSec, long renderTimeMs, int bufferLength) {
            byte[] buf = new byte[bufferLength];
            byteBufferAudioMix.limit(bufferLength);
            byteBufferAudioMix.get(buf);
            byteBufferAudioMix.flip();

            for (MediaDataAudioObserver observer : audioObserverList) {
                observer.onMixedAudioFrame(buf, audioFrameType, samples, bytesPerSample, channels, samplesPerSec, renderTimeMs, bufferLength);
            }

            byteBufferAudioMix.put(buf);
            byteBufferAudioMix.flip();
        }
    }
    ```

2. Call the `setCallback` method. The `setCallback` method calls the `registerAudioFrameObserver` C++ method via JNI to register an audio frame observer.

    ```java
    @Override
    public void onActivityCreated(@Nullable Bundle savedInstanceState) {
        super.onActivityCreated(savedInstanceState);
        mediaDataObserverPlugin = MediaDataObserverPlugin.the();
        // Registers the audio frame observer
        MediaPreProcessing.setCallback(mediaDataObserverPlugin);


        ...

    }
    ```

3. Implement the `onRecordAudioFrame`, `onPlaybackAudioFrame`, `onPlaybackAudioFrameBeforeMixing`, and `onMixedAudioFrame` callbacks. Get the audio frames from the callbacks, and process the audio frames.

    ```java
    // Get the recorded audio frame
    @Override
    public void onRecordAudioFrame(byte[] data, int audioFrameType, int samples, int bytesPerSample, int channels, int samplesPerSec, long renderTimeMs, int bufferLength) {

    }

    // Get the playback audio frame
    @Override
    public void onPlaybackAudioFrame(byte[] data, int audioFrameType, int samples, int bytesPerSample, int channels, int samplesPerSec, long renderTimeMs, int bufferLength) {

    }


    // Get the playback audio frame before mixing
    @Override
    public void onPlaybackAudioFrameBeforeMixing(int uid, byte[] data, int audioFrameType, int samples, int bytesPerSample, int channels, int samplesPerSec, long renderTimeMs, int bufferLength) {

    }

    // Get the mixed audio frame
    @Override
    public void onMixedAudioFrame(byte[] data, int audioFrameType, int samples, int bytesPerSample, int channels, int samplesPerSec, long renderTimeMs, int bufferLength) {

    }
    ```

## Reference

### Sample project

Agora provides the following open-source sample projects on GitHub:

- [Process raw audio data using Java APIs](https://github.com/AgoraIO/API-Examples/blob/dev/3.6.200/Android/APIExample/app/src/main/java/io/agora/api/example/examples/advanced/ProcessAudioRawData.java)
- [Process raw audio data using JNI and C++ APIs](https://github.com/AgoraIO/API-Examples/blob/dev/3.6.200/Android/APIExample/app/src/main/java/io/agora/api/example/examples/advanced/ProcessRawData.java)

### API reference

- [registerAudioFrameObserver](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a57eaa3859be21cd327763fc316197fff)
- [setRecordingAudioFrameParameters](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a682a8c493660bb565a38869dcc84c73e)
- [setPlaybackAudioFrameParameters](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a07e30f884f4dae8c7ddba740aeb008f1)
- [setMixedAudioFrameParameters](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a24da4130cac855befeac9b2f2e6e751f)
- [onRecordFrame](./API%20Reference/java/interfaceio_1_1agora_1_1rtc_1_1_i_audio_frame_observer.html#a386c3a451ce95f796d64e83006d7779c)
- [onPlaybackFrame](./API%20Reference/java/interfaceio_1_1agora_1_1rtc_1_1_i_audio_frame_observer.html#a3781dd30d34a0634140872a9dd131488)
- [onPlaybackFrameBeforeMixing](./API%20Reference/java/interfaceio_1_1agora_1_1rtc_1_1_i_audio_frame_observer.html#ab43c709bdbce83f907b00710b48d8d56)
- [onMixedFrame](./API%20Reference/java/interfaceio_1_1agora_1_1rtc_1_1_i_audio_frame_observer.html#a81794255075807161fa1a3c13e23db2c)

- [`registerAudioFrameObserver`](https://docs.agora.io/en/Interactive%20Broadcast/API%20Reference/cpp/classagora_1_1media_1_1_i_media_engine.html#ae46ca0d20789787aaab2fb268a524100)
- [`setRecordingAudioFrameParameters`](https://docs.agora.io/en/Interactive%20Broadcast/API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#a2c4717760b5fbf1bb8c1a3c16ca67fe5)
- [`setPlaybackAudioFrameParameters`](https://docs.agora.io/en/Interactive%20Broadcast/API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#aa5f2f6eb3db5acaaf8c40818d90694f1)
- [`setMixedAudioFrameParameters`](https://docs.agora.io/en/Interactive%20Broadcast/API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#a520ebcda51b5eb488339f3a12dfb8013)
- [`onRecordAudioFrame`](https://docs.agora.io/en/Interactive%20Broadcast/API%20Reference/cpp/classagora_1_1media_1_1_i_audio_frame_observer.html#ac6ab0c792420daf929fed78f9d39f728)
- [`onPlaybackAudioFrame`](https://docs.agora.io/en/Interactive%20Broadcast/API%20Reference/cpp/classagora_1_1media_1_1_i_audio_frame_observer.html#aefc7f9cb0d1fcbc787775588bc849bac)
- [`onPlaybackAudioFrameBeforeMixing`](https://docs.agora.io/en/Interactive%20Broadcast/API%20Reference/cpp/classagora_1_1media_1_1_i_audio_frame_observer.html#ae04d85a65eefec5e7c1e0477bcaa067c)
- [`onMixedAudioFrame`](https://docs.agora.io/en/Interactive%20Broadcast/API%20Reference/cpp/classagora_1_1media_1_1_i_audio_frame_observer.html#a78d095cbd0b8ee04f657430bb6de8100)