## Understand the tech

During the video transmission process, you can pre- and post-process the captured video data to achieve the desired playback effect.

Agora provides the raw data function for you to process the video data per your application scenario. This function enables you to pre-process the captured video frames before sending it to the encoder, or to post-process the decoded video frames.

## Prerequisites

Before using the raw data function, ensure that you have implemented the basic real-time communication functions in your project. See [Start a Video Call](https://docs.agora.io/en/Interactive%20Broadcast/start_call_android) or [Start Interactive Live Video Streaming](https://docs.agora.io/en/Interactive%20Broadcast/start_live_android) for details.
## Implementation

### Process raw video data using Java APIs

1. Before joining a channel, create an `IVideoFrameObserver` object and then call `registerVideoFrameObserver` to register video frame observer.
2. Implement the `onCaptureVideoFrame`, `onRenderVideoFrame`, and `onScreenCaptureVideoFrame` callbacks. Get the video frames captured the callbacks and process the data according to your needs.

```java
private final IVideoFrameObserver iVideoFrameObserver = new IVideoFrameObserver() {
        @Override
        public boolean onCaptureVideoFrame(VideoFrame videoFrame) {
            Log.i(TAG, "OnEncodedVideoImageReceived"+Thread.currentThread().getName());
            if(isSnapshot){
                isSnapshot = false;

                // get image bitmap
                VideoFrame.I420Buffer buffer = videoFrame.getBuffer().toI420();
                ByteBuffer ib = ByteBuffer.allocate(videoFrame.getBuffer().getHeight() * videoFrame.getBuffer().getWidth() * 2);
                ib.put(buffer.getDataY());
                ib.put(buffer.getDataU());
                ib.put(buffer.getDataV());
                YuvImage yuvImage = new YuvImage(ib.array(),
                        ImageFormat.NV21, videoFrame.getBuffer().getWidth(), videoFrame.getBuffer().getHeight(), null);
                ByteArrayOutputStream out = new ByteArrayOutputStream();
                yuvImage.compressToJpeg(new Rect(0, 0,
                        videoFrame.getBuffer().getWidth(), videoFrame.getBuffer().getHeight()), 50, out);
                byte[] imageBytes = out.toByteArray();
                Bitmap bm = BitmapFactory.decodeByteArray(imageBytes, 0, imageBytes.length);

                // save to file
                saveBitmap2Gallery(bm);
            }
            return false;
        }

        @Override
        public boolean onScreenCaptureVideoFrame(VideoFrame videoFrame) {
            return false;
        }

        @Override
        public boolean onMediaPlayerVideoFrame(VideoFrame videoFrame, int i) {
            return false;
        }

        @Override
        public boolean onRenderVideoFrame(int i, RtcConnection rtcConnection, VideoFrame videoFrame) {
            return false;
        }

        @Override
        public int getVideoFrameProcessMode() {
            return 0;
        }

        @Override
        public int getVideoFormatPreference() {
            return 1;
        }

        @Override
        public int getRotationApplied() {
            return 0;
        }

        @Override
        public boolean getMirrorApplied() {
            return false;
        }
    };
```

```java
int ret = engine.registerVideoFrameObserver(iVideoFrameObserver);
```


### Process raw audio data using JNI and C++ APIs

1. Use the JNI and C++ interface files to generate a shared library in the project, and use Java to call the raw video data interface of the Agora C++ SDK.
2. Before joining a channel, call the `registerVideoFrameObserver` method to register a video observer, and implement an `IVideoFrameObserver` class in this method.
3. After you successfully register the observer, the SDK captures every video frame and sends the captured raw video data via the `onCaptureVideoFrame`, `onPreEncodeVideoFrame`, or `onRenderVideoFrame` callbacks.
4. Process the captured raw video data according to your needs. Then, you can send it to the SDK via the callbacks mentioned in step 3.

#### Call the Agora C++ API in a Java project

The following diagram shows the basic flow of calling the Agora C++ API in a Java project:

![](https://web-cdn.agora.io/docs-files/1607912602385)

- The Java project loads the `.so` library built from the C++ interface file (`.cpp` file) via the Java interface file.
- The Java interface file generates a `.h` file with the `javac -h -jni` command. The C++ interface file should include this file.
- The C++ interface file calls C++ methods of the `.so` library in the Agora Android SDK by including the Agora Android SDK header file.

#### API call sequence

The following diagram shows how to implement the raw video data function in your project:

![](https://web-cdn.agora.io/docs-files/1607915730887)

<div class="alert note">The <code>registerVideoFrameObserver</code>, <code>onCaptureVideoFrame</code>, <code>onPreEncodeVideoFrame</code>, and <code>onRenderVideoFrame</code> are all C++ methods and callbacks.</div>


#### Sample code

##### Create a JNI interface

Create a Java interface file and a C++ interface file separately via the JNI interface. Make sure to build the C++ interface file as a `.so` library.

1. Create a Java interface file to call the C++ API. The interface file should declare the corresponding Java methods for calling C++. Refer to the `MediaPreProcessing.java` file in the sample project for the implementation.

```java
// The Java interface file declares the corresponding Java methods for calling C++.
package io.agora.advancedvideo.rawdata;

import java.nio.ByteBuffer;

public class MediaPreProcessing {
    static {
        // Loads the C++ .so library. Build the C++ interface file to generate the .so library.
        // The name of the .so library depends on the library name generated by building the C++ interface file.
        System.loadLibrary("apm-plugin-raw-data");
    }
    // Define the Java method that corresponds to the C++ API
    public interface ProgressCallback {
        // Get the captured video frame
        void onCaptureVideoFrame(int videoFrameType, int width, int height, int bufferLength, int yStride, int uStride, int vStride, int rotation, long renderTimeMs);
        // Get the pre-encoded video frame
        void onPreEncodeVideoFrame(int videoFrameType, int width, int height, int bufferLength, int yStride, int uStride, int vStride, int rotation, long renderTimeMs);
        // Get the video frame rendered by the SDK
        void onRenderVideoFrame(int uid, int videoFrameType, int width, int height, int bufferLength, int yStride, int uStride, int vStride, int rotation, long renderTimeMs);
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

    public static native void setVideoCaptureByteBuffer(ByteBuffer byteBuffer);

    public static native void setAudioRecordByteBuffer(ByteBuffer byteBuffer);

    public static native void setAudioPlayByteBuffer(ByteBuffer byteBuffer);

    public static native void setBeforeAudioMixByteBuffer(ByteBuffer byteBuffer);

    public static native void setAudioMixByteBuffer(ByteBuffer byteBuffer);

    public static native void setVideoDecodeByteBuffer(int uid, ByteBuffer byteBuffer);

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

3. Create a C++ interface file to include the methods to be called from Java. The C++ interface file exports the corresponding methods from the C++ SDK based on the generated `.h` file. Refer to the `io_agora_advancedvideo_rawdata_MediaPreProcessing.cpp` file in the sample project for the implementation.

<div class="alert note">The JNI defines the data structure in C++ that maps to Java. You can refer <a href="https://docs.oracle.com/javase/7/docs/technotes/guides/jni/spec/jniTOC.html">here</a> for more information.</div>

```cpp
// Global variables

jobject gCallBack = nullptr;
jclass gCallbackClass = nullptr;
// Method ID at the Java level
jmethodID captureVideoMethodId = nullptr;
jmethodID renderVideoMethodId = nullptr;
void *_javaDirectPlayBufferCapture = nullptr;
map<int, void *> decodeBufferMap;

static JavaVM *gJVM = nullptr;

// Implement the IVideoFrameObserver class and related callbacks
class AgoraVideoFrameObserver : public agora::media::IVideoFrameObserver
{


public:
    AgoraVideoFrameObserver()
    {

    }

    ~AgoraVideoFrameObserver()
    {

    }
    // Get video frame data from the VideoFrame object, copy to the ByteBuffer, and call Java method via the method ID
    void getVideoFrame(VideoFrame &videoFrame, _jmethodID *jmethodID, void *_byteBufferObject,
                  unsigned int uid)
    {
        if (_byteBufferObject == nullptr)
        {
            return;
        }

        int width = videoFrame.width;
        int height = videoFrame.height;
        size_t widthAndHeight = (size_t) videoFrame.yStride * height;
        size_t length = widthAndHeight * 3 / 2;

        AttachThreadScoped ats(gJVM);
        JNIEnv *env = ats.env();

        memcpy(_byteBufferObject, videoFrame.yBuffer, widthAndHeight);
        memcpy((uint8_t *) _byteBufferObject + widthAndHeight, videoFrame.uBuffer,
               widthAndHeight / 4);
        memcpy((uint8_t *) _byteBufferObject + widthAndHeight * 5 / 4, videoFrame.vBuffer,
               widthAndHeight / 4);

        if (uid == 0)
        {
            env->CallVoidMethod(gCallBack, jmethodID, videoFrame.type, width, height, length,
                                videoFrame.yStride, videoFrame.uStride,
                                videoFrame.vStride, videoFrame.rotation,
                                videoFrame.renderTimeMs);
        } else
        {
            env->CallVoidMethod(gCallBack, jmethodID, uid, videoFrame.type, width, height,
                                length,
                                videoFrame.yStride, videoFrame.uStride,
                                videoFrame.vStride, videoFrame.rotation,
                                videoFrame.renderTimeMs);
        }
    }
    // Copy video frame data from ByteBuffer to the VideoFrame object
    void writebackVideoFrame(VideoFrame &videoFrame, void *byteBuffer)
    {
        if (byteBuffer == nullptr)
        {
            return;
        }

        int width = videoFrame.width;
        int height = videoFrame.height;
        size_t widthAndHeight = (size_t) videoFrame.yStride * height;

        memcpy(videoFrame.yBuffer, byteBuffer, widthAndHeight);
        memcpy(videoFrame.uBuffer, (uint8_t *) byteBuffer + widthAndHeight, widthAndHeight / 4);
        memcpy(videoFrame.vBuffer, (uint8_t *) byteBuffer + widthAndHeight * 5 / 4,
               widthAndHeight / 4);
    }

public:
    // Implement the onCaptureVideoFrame callback
    virtual bool onCaptureVideoFrame(VideoFrame &videoFrame) override
    {
        // Get captured video frames
        getVideoFrame(videoFrame, captureVideoMethodId, _javaDirectPlayBufferCapture, 0);
        __android_log_print(ANDROID_LOG_DEBUG, "AgoraVideoFrameObserver", "onCaptureVideoFrame");
        // Send the video frames back to the SDK
        writebackVideoFrame(videoFrame, _javaDirectPlayBufferCapture);
        return true;
    }

   // Implement the onRenderVideoFrame callback
    virtual bool onRenderVideoFrame(unsigned int uid, VideoFrame &videoFrame) override
    {
        __android_log_print(ANDROID_LOG_DEBUG, "AgoraVideoFrameObserver", "onRenderVideoFrame");
        map<int, void *>::iterator it_find;
        it_find = decodeBufferMap.find(uid);

        if (it_find != decodeBufferMap.end())
        {
            if (it_find->second != nullptr)
            {
                // Get the video frame rendered by the SDK
                getVideoFrame(videoFrame, renderVideoMethodId, it_find->second, uid);
                // Send the video frames back to the SDK
                writebackVideoFrame(videoFrame, it_find->second);
            }
        }
        return true;
    }

    // Implement the onPreEncodeVideoFrame callback
    virtual bool onPreEncodeVideoFrame(VideoFrame& videoFrame) override {
        // Get the pre-encoded video frame
        getVideoFrame(videoFrame, preEncodeVideoMethodId, _javaDirectPlayBufferCapture, 0);
        __android_log_print(ANDROID_LOG_DEBUG, "AgoraVideoFrameObserver", "onPreEncodeVideoFrame");
        // Send the video frames back to the SDK
        writebackVideoFrame(videoFrame, _javaDirectPlayBufferCapture);
        return true;
    }

};


...

// AgoraVideoFrameObserver object
static AgoraVideoFrameObserver s_videoFrameObserver;
// rtcEngine object
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

// For the Java interface file, use the JNI to export corresponding C++.
// The Java_io_agora_advancedvideo_rawdata_MediaPreProcessing_setCallback method corresponds to the setCallback method in the Java interface file.
JNIEXPORT void JNICALL Java_io_agora_advancedvideo_rawdata_MediaPreProcessing_setCallback
        (JNIEnv *env, jclass, jobject callback)
{
    if (!rtcEngine) return;

    env->GetJavaVM(&gJVM);
    // Create an AutoPtr instance that uses the IMediaEngine class as the template
    agora::util::AutoPtr<agora::media::IMediaEngine> mediaEngine;
    // The AutoPtr instance calls the queryInterface method to get a pointer to the IMediaEngine instance from the IID.
    // The AutoPtr instance accesses the pointer to the IMediaEngine instance via the arrow operator and calls the registerVideoFrameObserver via the IMediaEngine instance.
    mediaEngine.queryInterface(rtcEngine, agora::INTERFACE_ID_TYPE::AGORA_IID_MEDIA_ENGINE);
    if (mediaEngine)
    {
        // Register the video frame observer
        int code = mediaEngine->registerVideoFrameObserver(&s_videoFrameObserver);

        ...

    }

     if (gCallBack == nullptr)
    {
        gCallBack = env->NewGlobalRef(callback);
        gCallbackClass = env->GetObjectClass(gCallBack);
        // Get the method ID of callback functions
        captureVideoMethodId = env->GetMethodID(gCallbackClass, "onCaptureVideoFrame",
                                                "(IIIIIIIIJ)V");
        renderVideoMethodId = env->GetMethodID(gCallbackClass, "onRenderVideoFrame",
                                               "(IIIIIIIIIJ)V");

        __android_log_print(ANDROID_LOG_DEBUG, "setCallback", "setCallback done successfully");
    }

   ...

// C++ implementation of the setVideoCaptureByteBuffer method in the Java interface file
JNIEXPORT void JNICALL
Java_io_agora_advancedvideo_rawdata_MediaPreProcessing_setVideoCaptureByteBuffer
        (JNIEnv *env, jclass, jobject bytebuffer)
{
    _javaDirectPlayBufferCapture = env->GetDirectBufferAddress(bytebuffer);
}

// C++ implementation of the setVideoDecodeByteBuffer method in the Java interface file
JNIEXPORT void JNICALL
Java_io_agora_advancedvideo_rawdata_MediaPreProcessing_setVideoDecodeByteBuffer
        (JNIEnv *env, jclass, jint uid, jobject byteBuffer)
{
    if (byteBuffer == nullptr)
    {
        decodeBufferMap.erase(uid);
    } else
    {
        void *_javaDirectDecodeBuffer = env->GetDirectBufferAddress(byteBuffer);
        decodeBufferMap.insert(make_pair(uid, _javaDirectDecodeBuffer));
        __android_log_print(ANDROID_LOG_DEBUG, "agora-raw-data-plugin",
                            "setVideoDecodeByteBuffer uid: %u, _javaDirectDecodeBuffer: %p",
                            uid, _javaDirectDecodeBuffer);
    }
}
    }
}


...


#ifdef __cplusplus
}
#endif
```

4. Build the C++ interface file via the NDK to generate a `.so` library. Use the `System.loadLibrary()` method to load the generated `.so` library in the Java interface file. See the following CMake example:

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

##### Implement the raw video data function in a Java project

1. Implement an interface that maps to the C++ methods in a Java interface file.

```java
// Implement the ProgressCallback interface in Java
public class MediaDataObserverPlugin implements MediaPreProcessing.ProgressCallback {

    ...

    // Get the captured video frame
    @Override
    public void onCaptureVideoFrame(int videoFrameType, int width, int height, int bufferLength, int yStride, int uStride, int vStride, int rotation, long renderTimeMs) {
        byte[] buf = new byte[bufferLength];
        byteBufferCapture.limit(bufferLength);
        byteBufferCapture.get(buf);
        byteBufferCapture.flip();

        for (MediaDataVideoObserver observer : videoObserverList) {
            observer.onCaptureVideoFrame(buf, videoFrameType, width, height, bufferLength, yStride, uStride, vStride, rotation, renderTimeMs);
        }

        byteBufferCapture.put(buf);
        byteBufferCapture.flip();

        if (beCaptureVideoShot) {
            beCaptureVideoShot = false;

            getVideoSnapshot(width, height, rotation, bufferLength, buf, captureFilePath, yStride, uStride, vStride);
        }
    }
    // Get the pre-encoded video frame
    @Override
    public void onPreEncodeVideoFrame(int videoFrameType, int width, int height, int bufferLength, int yStride, int uStride, int vStride, int rotation, long renderTimeMs) {
        byte[] buf = new byte[bufferLength];
        byteBufferCapture.limit(bufferLength);
        byteBufferCapture.get(buf);
        byteBufferCapture.flip();

        for (MediaDataVideoObserver observer : videoObserverList) {
            observer.onPreEncodeVideoFrame(buf, videoFrameType, width, height, bufferLength, yStride, uStride, vStride, rotation, renderTimeMs);
        }

        byteBufferCapture.put(buf);
        byteBufferCapture.flip();

        if (beCaptureVideoShot) {
            beCaptureVideoShot = false;

            getVideoSnapshot(width, height, rotation, bufferLength, buf, captureFilePath, yStride, uStride, vStride);
        }
    }
    // Get the video frame rendered by the SDK
    @Override
    public void onRenderVideoFrame(int uid, int videoFrameType, int width, int height, int bufferLength, int yStride, int uStride, int vStride, int rotation, long renderTimeMs) {
        for (MediaDataVideoObserver observer : videoObserverList) {
            ByteBuffer tmp = decodeBufferList.get(uid);
            if (tmp != null) {
                byte[] buf = new byte[bufferLength];
                tmp.limit(bufferLength);
                tmp.get(buf);
                tmp.flip();

                observer.onRenderVideoFrame(uid, buf, videoFrameType, width, height, bufferLength, yStride, uStride, vStride, rotation, renderTimeMs);

                tmp.put(buf);
                tmp.flip();

                if (beRenderVideoShot) {
                    if (uid == renderVideoShotUid) {
                        beRenderVideoShot = false;

                        getVideoSnapshot(width, height, rotation, bufferLength, buf, renderFilePath, yStride, uStride, vStride);
                    }
                }
            }
        }
    }
```

2. Call the `setCallback` method. The `setCallback` method calls the `registerVideoFrameObserver` C++ method via JNI to register a video frame observer.

```java
@Override
   public void onActivityCreated(@Nullable Bundle savedInstanceState) {
       super.onActivityCreated(savedInstanceState);
       // Implement the MediaDataObserverPlugin instance
       mediaDataObserverPlugin = MediaDataObserverPlugin.the();
       // Register the video frame observer
       MediaPreProcessing.setCallback(mediaDataObserverPlugin);
       MediaPreProcessing.setVideoCaptureByteBuffer(mediaDataObserverPlugin.byteBufferCapture);
       mediaDataObserverPlugin.addVideoObserver(this);
   }
```

3. Implement the `onCaptureVideoFrame`, `onRenderVideoFrame`, and `onPreEncodeVideoFrame` callbacks. Get the video frame from the callbacks, and process the video frame.

```java
// Get the captured video frame
@Override
public void onCaptureVideoFrame(byte[] data, int frameType, int width, int height, int bufferLength, int yStride, int uStride, int vStride, int rotation, long renderTimeMs) {

    Log.e(TAG, "onCaptureVideoFrame0");
    if (blur) {
        return;
    }
    Bitmap bitmap = YUVUtils.i420ToBitmap(width, height, rotation, bufferLength, data, yStride, uStride, vStride);
    Bitmap bmp = YUVUtils.blur(getContext(), bitmap, 4);
    System.arraycopy(YUVUtils.bitmapToI420(width, height, bmp), 0, data, 0, bufferLength);
}
// Get the pre-rendered video frame
@Override
public void onRenderVideoFrame(int uid, byte[] data, int frameType, int width, int height, int bufferLength, int yStride, int uStride, int vStride, int rotation, long renderTimeMs) {
    if (blur) {
        return;
    }
    Bitmap bmp = YUVUtils.blur(getContext(), YUVUtils.i420ToBitmap(width, height, rotation, bufferLength, data, yStride, uStride, vStride), 4);
    System.arraycopy(YUVUtils.bitmapToI420(width, height, bmp), 0, data, 0, bufferLength);
}
// Get the pre-encoded video frame
@Override
public void onPreEncodeVideoFrame(byte[] data, int frameType, int width, int height, int bufferLength, int yStride, int uStride, int vStride, int rotation, long renderTimeMs) {
    Log.e(TAG, "onPreEncodeVideoFrame0");
}
```

## Reference

### Sample project

Agora provides an open-source sample project [Raw Video Data](https://github.com/AgoraIO/API-Examples/blob/dev/3.6.200/Android/APIExample/app/src/main/java/io/agora/api/example/examples/advanced/ProcessRawData.java) on GitHub.

### API reference

- registerVideoFrameObserver
- registerVideoEncodedImageReceiver

- onCaptureVideoFrame
- onRenderVideoFrame
- onScreenCaptureVideoFrame
- getVideoFrameProcessMode
- OnEncodedVideoImageReceived

- [`registerVideoFrameObserver`](https://docs.agora.io/en/Interactive%20Broadcast/API%20Reference/cpp/classagora_1_1media_1_1_i_media_engine.html#a5eee4dfd1fd46e4a865feba163f3c5de)
- [`onCaptureVideoFrame`](https://docs.agora.io/en/Interactive%20Broadcast/API%20Reference/cpp/classagora_1_1media_1_1_i_video_frame_observer.html#a915c673aec879dcc2b08246bb2fcf49a)
- [`onRenderVideoFrame`](https://docs.agora.io/en/Interactive%20Broadcast/API%20Reference/cpp/classagora_1_1media_1_1_i_video_frame_observer.html#a966ed2459b6887c52112af638bc27c14)
- [`onPreEncodeVideoFrame`](https://docs.agora.io/en/Interactive%20Broadcast/API%20Reference/cpp/classagora_1_1media_1_1_i_video_frame_observer.html#a2be41cdde19fcc0f365d4eb14a963e1c)