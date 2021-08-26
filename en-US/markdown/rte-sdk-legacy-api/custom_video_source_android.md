The default Agora video module interacts seamlessly with the devices your app runs on. SDK enable you to add specialized video features to your app using a custom video source.

## Understand the tech

By default, SDK integrates the default video modules on the device your app runs on for real-time communication. However, there are scenarios where you may want to integrate a custom video capturer. For example:

- Your app has its own video module.
- You want to use a non-camera source, such as recorded screen data.
- You need to process the captured video with a pre-processing library for functions such as image enhancement.
- You need flexible device resource allocation to avoid conflicts with other services.

To manage the capture and processing of video frames when using a custom video source, use methods outside the SDK.

If the format of the custom captured video is Texture and the remote user sees anomalies (such as flickering and distortion) in the local custom captured video, Agora recommends that you make a copy of the video data before sending the custom video data back to the SDK, and then send both the original video data and the copied video data back to the SDK. This eliminates the anomalies during the internal data encoding.

### API call sequence

Refer to The following figure to implement the custom video source.

![img](https://web-cdn.agora.io/docs-files/1569392881143)

If you are not sure whether your custom video source supports Texture encoding, call `isTextureEncodeSupported` to find out. Then use the returned result to set the `useTexture` parameter in the `setExternalVideoSource` method.

### Video data transfer

The following figure shows how the video data is transferred when you customize the video source in Push mode:

![](https://web-cdn.agora.io/docs-files/1607670382235)

- You need to implement the capture module yourself using methods from outside the SDK.
- Captured video frames are sent to the SDK via the `pushExternalVideoFrame` method.

## Prerequisites

Before proceeding, ensure that you have implemented the basic real-time communication functions in your project. For details, see [Start a Video Call](https://docs.agora.io/en/Interactive%20Broadcast/start_call_android) or [Start Live Interactive Video Streaming](https://docs.agora.io/en/Interactive%20Broadcast/start_live_android).
## Implementation

Refer to the following steps to customize the video source in your project:

1. Before calling `joinChannel`, call `setExternalVideoSource` to specify the custom video source.

    ```java
    // Creates TextureView
    TextureView textureView = new TextureView(getContext());
    // Adds SurfaceTextureListener, which triggers the onSurfaceTextureAvailable callback if SurfaceTexture in TextureView is available
    textureView.setSurfaceTextureListener(this);
    // Adds TextureView to local video layout
    fl_local.addView(textureView, new FrameLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT,
    ViewGroup.LayoutParams.MATCH_PARENT));

    // Specifies the custom video source
    ChannelMediaOptions option = new ChannelMediaOptions();
    option.autoSubscribeAudio = true;
    option.autoSubscribeVideo = true;
    engine.setExternalVideoSource(true, true, false);
    // Joins the channel
    int res = engine.joinChannel(accessToken, channelId, 0, option);
    ```

2. Implement video capture and processing. Agora SDKs do not supply the APIs for custom video processing. Use system SDKs for the devices your app supports to create custom video modules. To integrate your video module, call `AgoraVideoFrame` before sending the captured video frames to the SDK. For example, you can set `rotation` as `180` to rotate the video frames by 180 degrees clockwise.

    ```java
    // Triggers this callback if SurfaceTexture in TextureView is available
    public void onSurfaceTextureAvailable(SurfaceTexture surface, int width, int height) {
            Log.i(TAG, "onSurfaceTextureAvailable");
            mTextureDestroyed = false;
            mSurfaceWidth = width;
            mSurfaceHeight = height;
            /** handler associate to the GL thread which creates the texture.
            * in some condition SDK need to convert from texture format to YUV format, in this case,
            * SDK will use this handler to switch into the GL thread to complete the conversion.
            * */
            mHandler = new Handler(Looper.myLooper());
            mEglCore = new EglCore();
            mDummySurface = mEglCore.createOffscreenSurface(1, 1);
            mEglCore.makeCurrent(mDummySurface);
            mPreviewTexture = GlUtil.createTextureObject(GLES11Ext.GL_TEXTURE_EXTERNAL_OES);
            // Creates a SurfaceTexture object for camera preview
            mPreviewSurfaceTexture = new SurfaceTexture(mPreviewTexture);
            // Creates OnFrameAvailableListener using the Android API setOnFrameAvailableListener, which triggers the onFrameAvailable callback if there are new video frames for SurfaceTexture
            mPreviewSurfaceTexture.setOnFrameAvailableListener(this);
            mDrawSurface = mEglCore.createWindowSurface(surface);
            mProgram = new ProgramTextureOES();
            if (mCamera != null || mPreviewing) {
                Log.e(TAG, "Camera preview has been started");
                return;
            }
            try {
                // Enables the camera (the code sample uses Android's Camera class)
                mCamera = Camera.open(mFacing);
                // Sets the most suitable resolution for your app scenario
                Camera.Parameters parameters = mCamera.getParameters();
                parameters.setPreviewSize(DEFAULT_CAPTURE_WIDTH, DEFAULT_CAPTURE_HEIGHT);
                mCamera.setParameters(parameters);
                // Sets mPreviewSurfaceTexture as the SurfaceTexture object for camera preview
                mCamera.setPreviewTexture(mPreviewSurfaceTexture);
                // Enables the portrait mode for camera preview. To ensure that camera preview stays in the portrait mode, rotate the preview image by 90 degrees clockwise
                mCamera.setDisplayOrientation(90);
                // The camera starts capturing video frames and rendering them to the specified SurfaceView
                mCamera.startPreview();
                mPreviewing = true;
            }
            catch (IOException e) {
                e.printStackTrace();
            }
        }
    ```

3. Call `pushExternalVideoFrame` to send the video frames to the SDK for later use.

    ```java
    // The onFrameAvailable callback gets new video frames captured by SurfaceTexture
    // Renders the video frames using EGL for later use in local view
    // Calls pushExternalVideoFrame to send the video frames to the SDK
    public void onFrameAvailable(SurfaceTexture surfaceTexture) {
            if (mTextureDestroyed) {
                return;
            }

            if (!mEglCore.isCurrent(mDrawSurface)) {
                mEglCore.makeCurrent(mDrawSurface);
            }
            /** Use surfaceTexture's timestamp, in nanosecond */
            long timestampNs = -1;
            try {
                surfaceTexture.updateTexImage();
                surfaceTexture.getTransformMatrix(mTransform);
                timestampNs = surfaceTexture.getTimestamp();
            }
            catch (Exception e) {
                e.printStackTrace();
            }
            // Configures MVP matrix
            if (!mMVPMatrixInit) {
                // This code sample defines activity as the portrait mode. Since the captured video frames are rotated by 90 degrees, you need to switch the width and height data when calculating the frame ratio.
                float frameRatio = DEFAULT_CAPTURE_HEIGHT / (float) DEFAULT_CAPTURE_WIDTH;
                float surfaceRatio = mSurfaceWidth / (float) mSurfaceHeight;
                Matrix.setIdentityM(mMVPMatrix, 0);

                if (frameRatio >= surfaceRatio) {
                    float w = DEFAULT_CAPTURE_WIDTH * surfaceRatio;
                    float scaleW = DEFAULT_CAPTURE_HEIGHT / w;
                    Matrix.scaleM(mMVPMatrix, 0, scaleW, 1, 1);
                } else {
                    float h = DEFAULT_CAPTURE_HEIGHT / surfaceRatio;
                    float scaleH = DEFAULT_CAPTURE_WIDTH / h;
                    Matrix.scaleM(mMVPMatrix, 0, 1, scaleH, 1);
                }
                mMVPMatrixInit = true;
            }
            // Sets the size of the video view
            GLES20.glViewport(0, 0, mSurfaceWidth, mSurfaceHeight);
            // Draws video frames
            mProgram.drawFrame(mPreviewTexture, mTransform, mMVPMatrix);
            // Sends the buffer of EGL image to EGL Surface for local playback and preview. mDrawSurface is an object of the EGLSurface class.
            mEglCore.swapBuffers(mDrawSurface);

            // If the user has joined the channel, configures the external video frames and sends them to the SDK.
            if (joined) {
                // Configures external video frames
                VideoFrame.TextureBuffer buffer = new TextureBuffer(
                        mEglCore.getEGLContext(),
                        DEFAULT_CAPTURE_HEIGHT /* For simplicity, swap frame width and height */,
                        DEFAULT_CAPTURE_WIDTH  /* For simplicity, swap frame width and height */,
                        VideoFrame.TextureBuffer.Type.OES,
                        mPreviewTexture,
                        RendererCommon.convertMatrixToAndroidGraphicsMatrix(mTransform),
                        mHandler,
                        mYuvConverter,
                        null /* for simplicity just pass null, if you want to avoid texture in use case, you can use this callback*/);
                VideoFrame frame = new VideoFrame(buffer, 0, timestampNs);
                // Sends external video frames to the SDK
                boolean a = engine.pushExternalVideoFrame(frame);
                Log.e(TAG, "pushExternalVideoFrame:" + a);
            }
        }
    ```

## Reference

This section includes reference information about the function.

### Sample project

Agora provides the following open-source sample projects on GitHub:
- [Custom video capture (Push)](https://github.com/AgoraIO/API-Examples/blob/dev/3.6.200/Android/APIExample/app/src/main/java/io/agora/api/example/examples/advanced/PushExternalVideo.java)

### API reference

- [`isTextureEncodeSupported`](https://docs.agora.io/en/Interactive%20Broadcast/API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a60c16364ab588a38f5155d9c94eaf800)
- [`setExternalVideoSource`](https://docs.agora.io/en/Interactive%20Broadcast/API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a2d9966c52798ab62ed941fa865e926cd)
- [`pushExternalVideoFrame`](https://docs.agora.io/en/Interactive%20Broadcast/API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a6e7327f4449800a2c2ddc200eb2c0386)