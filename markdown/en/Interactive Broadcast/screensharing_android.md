---
title: Share the Screen
platform: Android
updatedAt: 2021-01-12 08:47:03
---
## Introduction

Screen sharing enables the host of an interactive live streaming broadcast or video call to display what is on their screen to other users in the channel. This technology has many obvious advantages for communicating information, particularly in the following scenarios:

- During video conferencing, the speaker can share a local image, web page, or full presentation with other participants.
- For online instruction, the teacher can share slides or notes with students.

## Sample project

Agora provides an open-source sample project on GitHub that implements [screen sharing](https://github.com/AgoraIO/API-Examples/blob/master/Android/APIExample/app/src/main/java/io/agora/api/example/examples/advanced/SwitchCameraScreenShare.java) on Android. You can try the sample project and view the source code.

## Implementation

Before proceeding, ensure that you implemented basic real-time communication functions in your project.

The Agora SDK does not provide any method for screen share on Android. You can, however, implement this function using the native screen-capture APIs provided by Android, and the custom video-source APIs provided by Agora.

1. Use `android.media.projection` and `android.hardware.display.VirtualDisplay` to get and pass the screen-capture data.
2. Create an OpenGL ES environment. Create a `SurfaceView` object and pass the object to `VirtualDisplay`, which works as the recipient of the screen-capture data.
3. You can get the screen-capture data from the callbacks of `SurfaceView`. Use either the `Push` mode or `mediaIO` mode to push the screen-capture data to the SDK. For details, see [Custom Video Source and Renderer](custom_video_android).

## Data transfer

The following diagram shows how data is transferred during screen sharing on Android:

![](https://web-cdn.agora.io/docs-files/1607071986468)

## Sample code

<div class="alert note">The code samples provided in this section use <code>MediaProjection</code> and <code>VirtualDisplay</code> APIs provided by Android and have the following Android/API version requirements:
	<ul>
	<li>The Android version must be Lollipop or higher.</li>
		<li>To use <code>MediaProjection</code> APIs, the Android API level must be 21 or higher.</li>
		<li>To use <code>VirtualDisplay</code> APIs, the Android API level must be 19 or higher.</li>
	</ul>
	For detailed usage and considerations, see the Android documentation <a href="https://developer.android.com/reference/android/media/projection/MediaProjection">MediaProjection</a> and <a href="https://developer.android.com/reference/android/hardware/display/VirtualDisplay">VirtualDisplay</a>.
</div>

1. Implement `IVideoSource` and `IVideoFrameConsumer`, and rewrite the callbacks in `IVideoSource`.

```java
// Implements the IVideoSource interface
public class ExternalVideoInputManager implements IVideoSource {
 
...
 
 
    // Gets the IVideoFrameConsumer object when initializing the video source
    @Override
    public boolean onInitialize(IVideoFrameConsumer consumer) {
        mConsumer = consumer;
        return true;
    }
 
    @Override
    public boolean onStart() {
        return true;
    }
 
    @Override
    public void onStop() {
 
    }
    // Sets IVideoFrameConsumer as null when IVideoFrameConsumer is released by the media engine
    @Override
    public void onDispose() {
        Log.e(TAG, "SwitchExternalVideo-onDispose");
        mConsumer = null;
    }
 
    @Override
    public int getBufferType() {
        return TEXTURE.intValue();
    }
 
    @Override
    public int getCaptureType() {
        return CAMERA;
    }
 
    @Override
    public int getContentHint() {
        return MediaIO.ContentHint.NONE.intValue();
    }
 
 ...
 
}
```

```java
// Implements IVideoFrameConsumer
private volatile IVideoFrameConsumer mConsumer;
```

2. Set the custom video source before joining a channel.

```java
// Sets the input thread of the custom video source
// In the sample project, we use the class in the open-source grafika project, which encapsulates the graphics architecture of Android. For details, see https://source.android.com/devices/graphics/architecture
// For detailed implementation of EglCore, GlUtil, EGLContext, and ProgramTextureOES, see https://github.com/google/grafika
// The GLThreadContext class contains EglCore, EGLContext, and ProgramTextureOES
private void prepare() {
            // Creates an OpenEL ES environment based on EglCore
            mEglCore = new EglCore();
            mEglSurface = mEglCore.createOffscreenSurface(1, 1);
            mEglCore.makeCurrent(mEglSurface);
            // Creates an EGL texture object based on GlUtil
            mTextureId = GlUtil.createTextureObject(GLES11Ext.GL_TEXTURE_EXTERNAL_OES);
            // Creates a SurfaceTexture object based on EGL texture
            mSurfaceTexture = new SurfaceTexture(mTextureId);
            // Surface a Surface object based on SurfaceTexture
            mSurface = new Surface(mSurfaceTexture);
            // Pass EGLCore, EGL context, and ProgramTextureOES to GLThreadContext as its members
            mThreadContext = new GLThreadContext();
            mThreadContext.eglCore = mEglCore;
            mThreadContext.context = mEglCore.getEGLContext();
            mThreadContext.program = new ProgramTextureOES();
 
            // Sets the custom video source
            ENGINE.setVideoSource(ExternalVideoInputManager.this);
        }
```

3. Create an `intent` based on `MediaProjection`, and pass the `intent` to the `startActivityForResult()` method to start capturing screen data.

```java
private class VideoInputServiceConnection implements ServiceConnection {
    @Override
    public void onServiceConnected(ComponentName componentName, IBinder iBinder) {
        mService = (IExternalVideoInputService) iBinder;
// Starts capturing screen data. Ensure that your Android version must be Lollipop or higher.
if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.LOLLIPOP) {
                // Instantiates a MediaProjectionManager object
                MediaProjectionManager mpm = (MediaProjectionManager)
                        getContext().getSystemService(Context.MEDIA_PROJECTION_SERVICE);
                // Creates an intent
                Intent intent = mpm.createScreenCaptureIntent();
                // Starts screen capturing
                startActivityForResult(intent, PROJECTION_REQ_CODE);
            }
```

4. Get the screen-capture data information from the activity result.

```java
// Gets the intent of the data information from activity result
 @Override
    public void onActivityResult(int requestCode, int resultCode, @Nullable Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if (requestCode == PROJECTION_REQ_CODE && resultCode == RESULT_OK) {
 
            ...
 
 
                // Sets the custom video source as the screen-capture data
                mService.setExternalVideoInput(ExternalVideoInputManager.TYPE_SCREEN_SHARE, data);
            }
            catch (RemoteException e) {
                e.printStackTrace();
            }
        }
    }
```

The implementation of `setExternalVideoInput(int type, Intent intent)` is as follows:

```java
// Gets the parameters of the screen-capture data from intent
boolean setExternalVideoInput(int type, Intent intent) {
 
        if (mCurInputType == type && mCurVideoInput != null
                && mCurVideoInput.isRunning()) {
            return false;
        }
 
        IExternalVideoInput input;
        switch (type) {
            ...
 
            case TYPE_SCREEN_SHARE:
                // Gets the screen-capture data from the intent of MediaProjection
                int width = intent.getIntExtra(FLAG_SCREEN_WIDTH, DEFAULT_SCREEN_WIDTH);
                int height = intent.getIntExtra(FLAG_SCREEN_HEIGHT, DEFAULT_SCREEN_HEIGHT);
                int dpi = intent.getIntExtra(FLAG_SCREEN_DPI, DEFAULT_SCREEN_DPI);
                int fps = intent.getIntExtra(FLAG_FRAME_RATE, DEFAULT_FRAME_RATE);
                Log.i(TAG, "ScreenShare:" + width + "|" + height + "|" + dpi + "|" + fps);
                // Instantiates a ScreenShareInput class using the screen-capture data
                input = new ScreenShareInput(context, width, height, dpi, fps, intent);
                break;
            default:
                input = null;
        }
        // Sets the captured video data as the ScreenShareInput object, and creates an input thread for external video data
        setExternalVideoInput(input);
        mCurInputType = type;
        return true;
    }
```

5. During the initialization of the input thread of the external video data, create a `VirtualDisplay` object with `MediaProjection`, and render `VirtualDisplay` on `SurfaceView`.

```java
public void onVideoInitialized(Surface target) {
        MediaProjectionManager pm = (MediaProjectionManager)
                mContext.getSystemService(Context.MEDIA_PROJECTION_SERVICE);
        mMediaProjection = pm.getMediaProjection(Activity.RESULT_OK, mIntent);
 
        if (mMediaProjection == null) {
            Log.e(TAG, "media projection start failed");
            return;
        }
        // Creates VirtualDisplay with MediaProjection, and render VirtualDisplay on SurfaceView
        mVirtualDisplay = mMediaProjection.createVirtualDisplay(
                VIRTUAL_DISPLAY_NAME, mSurfaceWidth, mSurfaceHeight, mScreenDpi,
                DisplayManager.VIRTUAL_DISPLAY_FLAG_PUBLIC, target,
                null, null);
    }
```

6. Use `SurfaceView` as the custom video source. After the user joins the channel, the custom video module gets the screen-capture data using `consumeTextureFrame` in `ExternalVideoInputThread` and passes the data to the SDK.

```java
public void run() {
 
                ...
                // Calls updateTexImage() to update the data to the texture object of OpenGL ES
                // Calls getTransformMatrix() to transform the texture matrix
                 try {
                 mSurfaceTexture.updateTexImage();
                 mSurfaceTexture.getTransformMatrix(mTransform);
                      }
                 catch (Exception e) {
                 e.printStackTrace();
                 } 
 
                // Gets the screen-capture data from onFrameAvailable. onFrameAvailable is a rewrite of ScreenShareInput, which gets information such as the texture ID and transform information
                // No need to render the screen-capture data on the local view
                if (mCurVideoInput != null) {
                    mCurVideoInput.onFrameAvailable(mThreadContext, mTextureId, mTransform);
                }
 
                mEglCore.makeCurrent(mEglSurface);
                GLES20.glViewport(0, 0, mVideoWidth, mVideoHeight);
 
                if (mConsumer != null) {
                    Log.e(TAG, "Width and height of the video->width:" + mVideoWidth + ",height:" + mVideoHeight);
                    // Calls consumeTextureFrame to pass the video data to the SDK
                    mConsumer.consumeTextureFrame(mTextureId,
                            TEXTURE_OES.intValue(),
                            mVideoWidth, mVideoHeight, 0,
                            System.currentTimeMillis(), mTransform);
                }
 
                // Waits for the next frame
                waitForNextFrame();
                ...
 
        }
```

## Considerations

The Agora RTC Native SDK supports the app creating only one `RtcEngine` object. To send both screen-capture video and camera-capture video, you need to implement the logic in multiple threads.