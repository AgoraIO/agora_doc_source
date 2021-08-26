This page shows you how to get raw video data for pre- and post-processing.

## Understand the tech

During the video transmission process, you can pre- and post-process the captured video data to achieve the desired playback effect.

Agora provides the raw data function for you to process the video data per your application scenario. This function enables you to pre-process the captured video frames before sending it to the encoder, or to post-process the decoded video frames.

## Prerequisites

Before using the raw data function, ensure that you have implemented the basic real-time communication functions in your project. See [Start a Video Call](https://docs.agora.io/en/Interactive%20Broadcast/start_call_android) or [Start Interactive Live Video Streaming](https://docs.agora.io/en/Interactive%20Broadcast/start_live_android) for details.

## Implementation

To implement the raw video data function in your project, refer to the following steps.

1. Before joining a channel, create an `IVideoFrameObserver` object and then call `registerVideoFrameObserver` to register video frame observer.

    ```java
    int ret = engine.registerVideoFrameObserver(iVideoFrameObserver);
    ```

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

            // TODO Params still subject to changes
            @Override
            public boolean onRenderVideoFrame(String channelId, int i, VideoFrame videoFrame) {
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

## Reference

This section includes in depth information about the methods you used in this page, and links to related pages.

### Sample project

Agora provides an open-source sample project [Raw Video Data](https://github.com/AgoraIO/API-Examples/blob/dev/3.6.200/Android/APIExample/app/src/main/java/io/agora/api/example/examples/advanced/ProcessRawData.java) on GitHub.

### API reference

- [registerVideoFrameObserver]()
- [registerVideoEncodedImageReceiver]()
- [onCaptureVideoFrame]()
- [onRenderVideoFrame]()
- [onScreenCaptureVideoFrame]()
- [getVideoFrameProcessMode]()
- [OnEncodedVideoImageReceived]()
