# Share the Screen

Screen sharing enables a host of an interactive live streaming broadcast or a user in a video call to display what is on their screen to other users in the channel. This technology has many advantages for communicating information. For example:

- During video conferencing, the speaker can share a local image, web page, or full presentation with other participants.
- For online instruction, the teacher can share slides or notes with students.

## Understand the tech

To share the screen on Android, you need to use Android native APIs and Agora APIs together. The following diagram shows how data is transferred during screen sharing:

![](https://web-cdn.agora.io/docs-files/1629947832958)

## Prerequisites

Before proceeding, ensure that you have the following:
- A project that has implemented the [basic real-time engagement functionality](https://docs-preprod.agora.io/en/live-streaming-4.x-preview/start_live_android_ng?platform=Android).
- To use `MediaProjection` (Android native class), you need to use Android API level 21 or higher.

## Implementation

This section shows you how to implement screen sharing. Add code in the following steps in `/app/java/com.example.<projectname>/MainActivity`.


### 1. Send the screen-sharing notification

If the user shares the screen on Android 10 or later, to avoid the Android system from triggering `SecurityException` (Android native callback), you need to call `startForeground` (Android native method) before calling `MediaProjection` to notify the user that the current device starts screen sharing.

```java
// Start capturing screen data. Ensure that your Android version must be Lollipop or higher.
if (Build.VERSION.SDK_INT > Build.VERSION_CODES.LOLLIPOP) {
    if(b){
        if(Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
            getActivity().startForegroundService(fgServiceIntent);
        }
    }
    }
```

### 2. Start capturing screen data

Create an intent based on `MediaProjection`, and pass the intent to the `startActivityForResult` (Android native method) to start capturing screen data.

```java
if (Build.VERSION.SDK_INT > Build.VERSION_CODES.LOLLIPOP) {
    if(b){

        ...

        // Instantiate a MediaProjectionManager object
        MediaProjectionManager mpm = (MediaProjectionManager)
                getContext().getSystemService(Context.MEDIA_PROJECTION_SERVICE);
        // Create an intent
        Intent intent = mpm.createScreenCaptureIntent();
        // Start screen capturing
        startActivityForResult(intent, PROJECTION_REQ_CODE);
    }
    }
```

### 3. Start the screen sharing

Get the screen data from the activity result, and pass the screen data in the `mediaProjectionPermissionResultData` parameter of `startScreenCapture` to start the screen sharing.

```java
@Override
// Listen for onActivityResult.
public void onActivityResult(int requestCode, int resultCode, @Nullable Intent data) {
    super.onActivityResult(requestCode, resultCode, data);
    if (requestCode == PROJECTION_REQ_CODE && resultCode == RESULT_OK) {
        DisplayMetrics metrics = new DisplayMetrics();
        getActivity().getWindowManager().getDefaultDisplay().getMetrics(metrics);
        ScreenCaptureParameters parameters = new ScreenCaptureParameters();
        parameters.setFrameRate(DEFAULT_SHARE_FRAME_RATE);
        // Start the screen sharing.
        engine.startScreenCapture(data, parameters);
    }
}
```

### 4. Join a channel and publish video streams

- To send video streams showing the user's entire screen, add the following code to your project:

```java
// Join a channel and publish the video stream from the screen sharing.
options.publishCameraTrack = false;
options.publishScreenTrack = true;
engine.joinChannel(accessToken, channelId, 0, options);
```

- To send video streams from both the user's entire screen and local camera, add the following code to your project:

```java
// Join a channel and publish the video stream from the screen sharing.
options.publishCameraTrack = true;
options.publishScreenTrack = false;
engine.joinChannel(accessToken, channelId, 0, options);

// Join the same channel and publish the video stream from the local camera.
ChannelMediaOptions mediaOptions = new ChannelMediaOptions();
mediaOptions.publishCameraTrack = false;
mediaOptions.publishScreenTrack = true;
String channelId = et_channel.getText().toString();
engine.joinChannelEx(null, channelId, 0, mediaOptions, iRtcEngineEventHandler, rtcConnection2);
```

### 5. Stop the screen sharing

When the user finishes the screen sharing, call `stopScreenCapture` to stop the screen sharing.

```java
// Stop the screen sharing.
engine.stopScreenCapture();
```

## Reference

This section provides reference information you may need when sharing the screen.

### Sample project

Agora provides an open-source sample project that implements [sharing the screen](https://github.com/AgoraIO/API-Examples/blob/dev/3.6.200/Android/APIExample/app/src/main/java/io/agora/api/example/examples/advanced/SwitchCameraScreenShare.java) on GitHub. You can try the sample project and view the source code.

### API reference

- Android native APIs
  - [MediaProjection](https://developer.android.google.cn/reference/android/media/projection/MediaProjection)
  - [SecurityException](https://developer.android.google.cn/reference/java/lang/SecurityException?hl=en)
  - [startForeground](https://developer.android.google.cn/guide/components/foreground-services?hl=en#start)

- Agora APIs
  - [startScreenCapture](https://docs-preview.agoralab.co/cn/trinity/API%20Reference/java_high_level/classio_1_1agora_1_1rtc2_1_1_rtc_engine.html#a16a83b985493c445408da46ab7f01258)
  - [stopScreenCapture](https://docs-preview.agoralab.co/cn/trinity/API%20Reference/java_high_level/classio_1_1agora_1_1rtc2_1_1_rtc_engine.html#aaa8a6ef8909cebd023c5c229d35fb472)