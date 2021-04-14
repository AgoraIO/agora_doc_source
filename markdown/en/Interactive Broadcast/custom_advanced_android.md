---
title: Agora Component for Customization
platform: Android
updatedAt: 2018-11-20 14:48:36
---
<a name = "custom_video_source"></a>
## Customize the Video Source with the Agora Component

### 1. AgoraBufferedCamera2 Class

The `AgoraBufferedCamera2.java` class shows how to customize the video source in `ByteBuffer` and `ByteArray`.

The construct of `AgoraBufferedCamera2` needs a `Context` and an optional `CaptureParameter` that defines the parameters of the camera and buffer type. By default, the resolution is 640 x 480, video format is YUV420P; and data type is `ByteBuffer`.

```
AgoraBufferedCamera2 source = new AgoraBufferedCamera2(this);
source.useFrontCamera(true);
rtcEngine.setVideoSource(source);
```

When using the `ByteArray` or `ByteBuffer` video source, the SDK receives the pixel format in YUV420p, NV21, or RGBA.

### 2. AgoraTextureCamera Class

The `AgoraTextureCamera.java `class shows how to customize a textured video source. `AgoraTextureCamera` can be used directly as the video source.

```
IVideoSource source = new AgoraTextureCamera(this, 640, 480);
rtcEngine.setVideoSource(source);
```

### 3. Helper Class and Component

Compared with YUV or RGB, the textured video source is more complex considering the GL environment and thread requirements when being transmitted.

#### SurfaceTextureHelper Interface

The `SurfaceTextureHelper` class is an assisting class provided by the Agora SDK to help users use `SurfaceTexture` without the need to build a GL environment, textures, and interact between threads.

Major functions of `SurfaceTextureHelper`:

1.  Create a textured object, and build a `SurfaceTexture` with the textured object
2.  Notify developers on texture updates when `SurfaceTexture` has captured the video frame


**Create a SurfaceTextureHelper**

```
public static SurfaceTextureHelper create(final String threadName, final EglBase.Context sharedContext);
```

Call the `create` method to create `SurfaceTextureHelper`. In this method, a GL thread is built together with textures and `SurfaceTexture`.

**Get the SurfaceTexture**

```
public EglBase.Context getEglContext();
public Handler getHandler();
public SurfaceTexture getSurfaceTexture();
```

This method gets the created texture. If in the GL environment or a thread is required, call the `getEglContext` and `getHandler` methods.

**Monitor the SurfaceTexture**

```
public interface OnTextureFrameAvailableListener {
    abstract void onTextureFrameAvailable(int oesTextureId, float[] transformMatrix, long timestampNs);
}
public void startListening(final OnTextureFrameAvailableListener listener);
public void stopListening();
```

This method creates a listener to monitor the new video frame of `SurfaceTexture`, and start or end monitoring by calling the `startListening` and `stopListening` methods.

**Release SurfaceTexture**

```
void dispose();
```

Call this method to release relevant resources when `SurfaceTexture` is no longer needed.

#### TextureSource Interface

The `TextureSource` interface includes `SurfaceTextureHelper` and `IVideoFrameConsumer` methods to implement customized textured video source operations. `SurfaceTexture` can be created by `SurfaceTextureHelper`, and used to capture a video frame and convert it into a texture to be sent to `RtcEngine`. With the `TextureSource` interface, developers only need to care about the following:

-   Video source functionality and compatibility.
-   Capturing the `SurfaceTexture` video frame.
-   Sending the updated texture to `RtcEngine`.


1.  Implement four `TextureSource` callbacks for the video source functionality and compatibility.

    ```
    abstract protected boolean onCapturerOpened();
    abstract protected boolean onCapturerStarted();
    abstract protected void onCapturerStopped();
    abstract protected void onCapturerClosed();
    ```

2.  Use `SurfaceTexture` to capture the video frame.

    ```
    public SurfaceTexture getSurfaceTexture();
    ```

    See `SurfaceTexture` for methods to capture video frame.

3.  Once the video frame is captured and updated as a texture, call `onTextureFrameAvailable` to send the video frame to `RtcEngine`.

    ```
    public void onTextureFrameAvailable(int oesTextureId, float[] transformMatrix, long timestampNs);
    ```

4.  Release the resources when the video frame is no longer needed.

    ```
    public void release();
    ```


### 4. Example of Using External Screen Recording as the Video Source with TextureSource

The following sequence shows an example of how to use external screen recording as the video source.

Step 1. Implement the following callbacks:

```
public class ScreenRecordSource extends TextureSource {
    private Context mContext;
    private boolean mIsStart;
    private VirtualDisplay mVirtualDisplay;
    private MediaProjection mMediaProjection;

    public ScreenRecordSource(Context context, int width, int height, int dpi, MediaProjection mediaProjection) {
        super(null, width, height);
        mContext = context;
        mMediaProjection = mediaProjection;
    }

    @Override
    protected boolean onCapturerOpened() {
        createVirtualDisplay();
        return true;
    }
    @Override
    protected boolean onCapturerStarted() {
        return mIsStart = true;
    }
    @Override
    protected void onCapturerStopped() {
        mIsStart = false;
    }
    @Override
    protected void onCapturerClosed() {
        releaseVirtualDisplay();
    }
 }
```

Step 2. Use `SurfaceTexture` to create a virtual display for capturing the screen data.

```
private void createVirtualDisplay() {
    Surface inputSurface = new Surface(getSurfaceTexture);
    if (mVirtualDisplay == null) {
        mVirtualDisplay = mediaProjection.createVirtualDisplay("MainScreen", mWidth, mHeight, mDpi,
                    DisplayManager.VIRTUAL_DISPLAY_FLAG_AUTO_MIRROR, inputSurface, null, null);
    }
}

private void virtualDisplay() {
    if (virtualDisplay != null) {
        virtualDisplay.release();
    }
    virtualDisplay = null;
}
```

Step 3. Reimplement the callbacks for getting the video data.

```
@Override
public void onTextureFrameAvailable(int oesTextureId, float[] transformMatrix, long timeStampNs) {
    super.onTextureFrameAvailable(oesTextureId, transformMatrix, timeStampNs);
    if (mIsStart && mConsumer != null && mConsumer.get() != null) {
        mConsumer.get().consumeTextureFrame(oesTextureId, TEXTURE_OES.intValue(), mWidth, mHeight,
                                            0, System.currentTimeMillis(), transformMatrix);
    }
}
```

> Make sure to call the `super.onTextureFrameAvailable(oesTextureId, transformMatrix, timeStampNs)` parent class method.

Step 4. Release the resources when the external video source is no longer needed.

```
public void sourceRelease() {
   releaseProjection();
   release();
}
```

<a name = "custome_video_renderer"></a>
## Customize the Video Sink with the Agora Component

The Agora SDK uses its default renderer to render the local and remote video. The `IVideoSink` interface can be used for more advanced functions, such as:

-   To render the local or remote video frame instead of directly on the view component.
-   To use the general `SurfaceView` object or customized view component.
-   To render images in specific areas, such as in gaming.


### AgoraSurfaceView Class

`AgoraSurfaceView` inherits `SurfaceView` and implements the `IVideoSink` interface to render video frames in YUV420P, RGB, and Texture \(2D/OES\).

```
AgoraSurfaceView render = new AgoraSurfaceView(this);
render.init(MediaIO.BufferType.BYTE_ARRAY, I420, null);
render.setZOrderOnTop(true);
rtcEngine.setLocalVideoRenderer(render);
```

### AgoraTextureView Class

`AgoraTextureView` inherits `TextureView` and implements the `IVideoSink` interface to render video frames in YUV420P, RGB, and Texture \(2D/OES\).

The following code shows the usage of `AgoraTextureView` with external video sources, and creates the GL environment with `TextureSource`:

```
AgoraTextureCamera source = new AgoraTextureCamera(this, 640, 480);
AgoraTextureView render = (AgoraTextureView) findViewById(R.id.agora_texture_view);
render.init(source.getEglContext());
render.setBufferType(MediaIO.BufferType.TEXTURE);
render.setPixelFormat(MediaIO.PixelFormat.TEXTURE_OES);
rtcEngine().setVideoSource(source);
rtcEngine().setLocalVideoRenderer(render);
```

### Helper Class and Component

#### BaseVideoRenderer Class

**Major functions of the BaseVideoRenderer class:**

-   Supports rendering various formats: I420, RGBA, and TEXTURE\_2D/OES.
-   Supports various rendering targets: SurfaceView, TextureView, Surface, and SurfaceTexture.


Follow these steps to use the `BaseVideoRenderer` class:

1.  Create a customized renderer class to implement the `IVideoSink` interface and embed the `BaseVideoRenderer` object.

2.  Specify the type and format of the video frame, or call the `setBufferType` and `setPixelFormat` methods of the embedded `BaseVideoRenderer` object.

3.  Share `EGLContextHandle` with `RtcEngine`, now that `BaseVideoRenderer` uses OpenGL as the renderer and has created the `EGLContext`.

4.  Set the object to render by calling the `setRenderView` and `setRenderSurface` methods of the embedded `BaseVideoRenderer` object.

5.  Implement methods to control the renderer by calling the `onInitialize`, `onStart`, `onStop`, and `onDispose` methods.

6.  Implement `IVideoFrameConsumer`, and call the `BaseVideoRenderer` object in the corresponding format to render the received video frame on the rendered target.


